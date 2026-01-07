"use strict";
// Copyright Epic Games, Inc. All Rights Reserved.
Object.defineProperty(exports, "__esModule", { value: true });
exports.VerseWorkflowProtocolClient = void 0;
const ee = require("events");
const protocol_1 = require("./protocol");
const vscode_1 = require("vscode");
class VerseWorkflowProtocolClient extends ee.EventEmitter {
    constructor(name) {
        super();
        this.pendingRequests = new Map();
        this.rawData = Buffer.alloc(0);
        // ---- type guards for params, results, and errorResults -------------------------------------------------------------
        this.ParamsChecker = new Map([
            ["logMessage", (value) => {
                    if (typeof value !== "object") {
                        return false;
                    }
                    return (typeof value.type === "number" &&
                        value.type in protocol_1.VerseWorkflowProtocol.Severity &&
                        typeof value.message === "string");
                }],
            ["pushChanges", (value) => {
                    return typeof value === "boolean";
                }],
            ["updateBuildState", (value) => {
                    return (typeof value === "number" &&
                        value in protocol_1.VerseWorkflowProtocol.BuildState);
                }],
            ["canPushVerseChanges", (value) => {
                    return typeof value === "boolean";
                }]
        ]);
        this.ResultsChecker = new Map([
            ["compileProject", (value) => {
                    if (typeof value !== "object") {
                        return false;
                    }
                    return typeof value.message === "string"
                        && typeof value.numWarnings === "number"
                        && typeof value.numErrors === "number";
                }],
            ["pushChanges", (value) => {
                    return typeof value === "string";
                }]
        ]);
        this.ErrorResultsChecker = new Map([
            ["compileProject", (value) => {
                    return typeof value === "string";
                }],
            ["pushChanges", (value) => {
                    return typeof value === "string";
                }]
        ]);
        this.sequence = 1;
        this.contentLength = -1;
        this.output = vscode_1.window.createOutputChannel(name);
        this.buildLog = vscode_1.window.createOutputChannel(name + " - Build Log");
        // We only allow a single listener for each possible event
        // This is to allow returning results via the `response` parameter from `emit(event, args, response)` calls
        this.setMaxListeners(1);
    }
    // sets the output/input streams
    connect(readable, writable) {
        this.outputStream = writable;
        readable.on("data", (data) => {
            this.handleData(data);
        });
    }
    // Notifications
    sendNotification(command, args) {
        this.send(protocol_1.VerseWorkflowProtocol.MessageType.Notification, command, args);
    }
    sendRequest(command, args) {
        return new Promise((completeDispatch, errorDispatch) => {
            this.send(protocol_1.VerseWorkflowProtocol.MessageType.Request, command, args, (response) => {
                if (response.result !== undefined && this.checkResult(command, response.result)) {
                    completeDispatch(response.result);
                    return true;
                }
                else if (response.error !== undefined && this.checkErrorResult(command, response.error)) {
                    errorDispatch(response.error);
                    return true;
                }
                return false;
            });
        });
    }
    // sends out a message and stores a callback for the response handler if it is a request
    send(type, command, params, callback) {
        const message = {
            seq: this.sequence++,
            type: type,
            command: command,
            params: {},
        };
        if (!Object.is(params, protocol_1.VerseWorkflowProtocol.NoParams)) {
            message.params = params;
        }
        // store callback if this is a request
        if (message.type == protocol_1.VerseWorkflowProtocol.MessageType.Request) {
            this.pendingRequests.set(message.seq, callback);
        }
        const json = JSON.stringify(message);
        this.outputStream.write(`Content-Length: ${Buffer.byteLength(json, "utf8")}\r\n\r\n${json}`, "utf8");
    }
    // receives data from the socket and converts it into a utf-8 encoded string
    handleData(data) {
        this.rawData = Buffer.concat([this.rawData, data]);
        while (true) {
            if (this.contentLength >= 0) {
                // We only process a message once we have equal to or more than the content length specified
                if (this.rawData.length >= this.contentLength) {
                    const message = this.rawData.toString("utf8", 0, this.contentLength);
                    this.rawData = this.rawData.slice(this.contentLength);
                    if (message.length > 0) {
                        this.dispatch(message);
                    }
                    this.contentLength = -1;
                    continue; // there may be more complete messages to process
                }
            }
            else {
                const idx = this.rawData.indexOf(VerseWorkflowProtocolClient.TWO_CRLF);
                if (idx !== -1) {
                    const header = this.rawData.toString("utf8", 0, idx);
                    const lines = header.split("\r\n");
                    for (let i = 0; i < lines.length; i++) {
                        const pair = lines[i].split(/: +/);
                        if (pair[0] === "Content-Length") {
                            this.contentLength = +pair[1];
                        }
                    }
                    this.rawData = this.rawData.slice(idx + VerseWorkflowProtocolClient.TWO_CRLF.length);
                    continue;
                }
            }
            break;
        }
    }
    // processes received data and attempts to call the appropriate handler
    dispatch(body) {
        let rawData;
        try {
            rawData = JSON.parse(body);
        }
        catch (error) {
            if (error instanceof SyntaxError) {
                this.output.appendLine(`Error: Failed to parse incoming JSON body: ${body} due to syntax error ${error}`);
                return;
            }
            else {
                this.output.appendLine(`Error: Failed to parse incoming JSON body: ${body} due to unexpected error ${error}`);
            }
        }
        if (typeof rawData.type === "undefined") {
            this.output.appendLine("Error: Received undefined message.");
            return;
        }
        switch (rawData.type) {
            case protocol_1.VerseWorkflowProtocol.MessageType.Notification: {
                const message = rawData;
                if (!this.checkParam(message.command, message.params)) {
                    this.output.appendLine(`Error: Incoming command '${message.command}' ignored due to invalid params. MsgJSON: ${body}.`);
                    break;
                }
                this.emit(message.command, message.params);
                break;
            }
            case protocol_1.VerseWorkflowProtocol.MessageType.Request: {
                const message = rawData;
                if (!this.checkParam(message.command, message.params)) {
                    this.output.appendLine(`Error: Incoming command '${message.command}' ignored due to invalid params. MsgJSON: ${body}.`);
                    break;
                }
                var response = {
                    seq: message.seq,
                    type: protocol_1.VerseWorkflowProtocol.MessageType.Response,
                    command: message.command,
                };
                if (this.emit(message.command, message.params, response.result)) {
                    const json = JSON.stringify(response);
                    this.outputStream.write(`Content-Length: ${Buffer.byteLength(json, "utf8")}\r\n\r\n${json}`, "utf8");
                }
                break;
            }
            case protocol_1.VerseWorkflowProtocol.MessageType.Response: {
                const response = rawData;
                const clb = this.pendingRequests.get(response.seq);
                if (clb) {
                    this.pendingRequests.delete(response.seq);
                    if (!clb(response)) {
                        this.output.appendLine(`Error: Incoming response '${response.command}' has no valid result or error member... response was ignored. MsgJSON: ${body}.`);
                    }
                }
                break;
            }
            default:
                this.output.appendLine("Error: Unrecognized type of message received!");
        }
    }
    checkParam(command, params) {
        return this.ParamsChecker.has(command) && this.ParamsChecker.get(command)(params);
    }
    checkResult(command, results) {
        return this.ResultsChecker.has(command) && this.ResultsChecker.get(command)(results);
    }
    checkErrorResult(command, results) {
        return this.ErrorResultsChecker.has(command) && this.ErrorResultsChecker.get(command)(results);
    }
}
exports.VerseWorkflowProtocolClient = VerseWorkflowProtocolClient;
VerseWorkflowProtocolClient.TWO_CRLF = "\r\n\r\n";
//# sourceMappingURL=protocolClient.js.map