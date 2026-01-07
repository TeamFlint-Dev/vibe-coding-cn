"use strict";
// Copyright Epic Games, Inc. All Rights Reserved.
Object.defineProperty(exports, "__esModule", { value: true });
exports.VerseWorkflowClient = void 0;
const net = require("net");
const protocolClient_1 = require("./protocolClient");
const protocol_1 = require("./protocol");
const vscode = require("vscode");
// Client implementation of VerseWorkflowProtocolClient for VSCode
class VerseWorkflowClient extends protocolClient_1.VerseWorkflowProtocolClient {
    constructor(name) {
        super(name);
        this.connected = false;
        this.createHandlers();
    }
    // ---- life cycle --------------------------------------------------------------------------------------------------------
    /**
     * Start's the VerseWorkflowClient on a specified port over a TCP/IP socket using UTF-8 encoding.
     */
    start(port = VerseWorkflowClient.DEFAULT_PORT, address = VerseWorkflowClient.DEFAULT_ADDRESS) {
        return new Promise((resolve, reject) => {
            this.output.appendLine(`Attempting to connect to VerseWorkflowServer on ${address}:${port}.`);
            this.socket = net.createConnection(port, address, () => {
                // this is the same as `on('connect')`
                this.connect(this.socket, this.socket);
                this.output.appendLine("Connected to VerseWorkflowServer!");
                vscode.commands.executeCommand("setContext", "verseWorkflow.connected", true);
                this.connected = true;
                resolve();
            });
            this.socket.on("error", (error) => {
                // this calls `on('close')` after executing
                this.output.appendLine(`Connection error: Server is unreachable: ${address}:${port}. ${error && error.message}`);
                reject();
            });
            this.socket.on("close", (hadError) => {
                this.output.appendLine("VerseWorkflow connection closed.");
                hadError ? this.cleanUp(true) : this.cleanUp();
            });
            this.socket.on("end", () => {
                this.output.appendLine("VerseWorkflow connection ended.");
                this.cleanUp();
            });
        });
    }
    /**
     * Stops the client.
     */
    stop() {
        this.output.appendLine("Closing VerseWorkflow connection.");
        this.cleanUp();
    }
    cleanUp(destroy = false) {
        vscode.commands.executeCommand("setContext", "verseWorkflow.connected", false);
        this.connected = false;
        if (this.socket) {
            destroy ? this.socket.destroy() : this.socket.end();
            this.socket = null;
        }
    }
    /**
     * Bind the handlers for incoming requests & notifications
     */
    createHandlers() {
        this.on("logMessage", (params) => {
            this.output.appendLine(`${protocol_1.VerseWorkflowProtocol.Severity[params.type]}: ${params.message}`);
        });
        this.on("updateBuildState", (buildState) => {
            vscode.commands.executeCommand("setContext", "verseWorkflow.buildState", buildState);
        });
        this.on("canPushVerseChanges", (bCanPushChanges) => {
            vscode.commands.executeCommand("setContext", "verseWorkflow.canPushVerseChanges", bCanPushChanges);
        });
    }
    // ---- notifications -------------------------------------------------------------------------------------------------
    // ---- requests ------------------------------------------------------------------------------------------------------
    /**
     * The `compile project request` is sent from a client to the server to ask the server to compile its current project.
     * @returns CompileProjectResults | string
     */
    reqCompileProject() {
        this.output.appendLine("Requesting Verse Build on Server.");
        return new Promise((resolve, reject) => {
            this.sendRequest("compileProject", {})
                .then((result) => {
                if (result.numErrors) {
                    vscode.window.showErrorMessage(`Built with ${result.numErrors} error(s). See build log for details.`);
                }
                else if (result.numWarnings) {
                    vscode.window.showWarningMessage(`Built with ${result.numWarnings} warnings(s). See build log for details.`);
                }
                else {
                    vscode.window.showInformationMessage("Built successfully.");
                }
                this.buildLog.appendLine(`${result.message}`);
                resolve(result);
            })
                .catch((errorResult) => {
                vscode.window.showErrorMessage(`Verse build: Unexpected Error! ${errorResult}}.`);
                this.output.appendLine(`${errorResult}`);
                reject(errorResult);
            });
        });
    }
    /**
     * The `push changes` is sent from a client to the server:
     * @param VerseOnly boolean: Whether to push only Verse changes.
     * @returns PushChangesAndStartGameResults | string
     */
    reqPushChanges(VerseOnly) {
        this.output.appendLine(`Requesting Push Content on Server (VerseOnly=${VerseOnly ? "true" : "false"}).`);
        return new Promise((resolve, reject) => {
            this.sendRequest("pushChanges", VerseOnly)
                .then((result) => {
                vscode.window.showInformationMessage(`${result}`);
                this.output.appendLine(`${result}`);
                resolve(result);
            })
                .catch((errorResult) => {
                vscode.window.showErrorMessage(`${errorResult}`);
                this.output.appendLine(`${errorResult}`);
                reject(errorResult);
            });
        });
    }
}
exports.VerseWorkflowClient = VerseWorkflowClient;
VerseWorkflowClient.DEFAULT_PORT = 1962;
VerseWorkflowClient.DEFAULT_ADDRESS = "127.0.0.1";
//# sourceMappingURL=client.js.map