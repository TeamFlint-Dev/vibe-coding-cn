"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.activate = void 0;
// Copyright Epic Games, Inc. All Rights Reserved.
const vscode = require("vscode");
const vscodelc = require("vscode-languageclient");
const os = require("os");
const fs = require("fs");
const path = require("path");
const process = require("process");
const versewc = require("./verse_workflow_server/api");
// Method to get workspace configuration option
function getConfig(configName, option, defaultValue) {
    const config = vscode.workspace.getConfiguration(configName);
    return config.get(option, defaultValue);
}
// This method is called when the extension is activated
function activate(context) {
    let output = vscode.window.createOutputChannel("VerseExt");
    const configName = context.extension.id.split(".").pop();
    const useRelease = getConfig(configName, "useRelease");
    const devExt = vscode.extensions.getExtension("epicgames.verse-dev");
    // Hide VerseWorkflow functionality until connected
    vscode.commands.executeCommand("setContext", "verseWorkflow.connected", false);
    vscode.commands.executeCommand("setContext", "verseWorkflow.canPushVerseChanges", false);
    vscode.commands.executeCommand("setContext", "verseWorkflow.pushRequestInProgress", false);
    vscode.commands.executeCommand("setContext", "verseWorkflow.buildState", versewc.VerseWorkflowProtocol.BuildState.NoBuild);
    if (!useRelease && configName == "verse" && devExt !== undefined) {
        output.appendLine("The development version of the extension was detected; the release version will not be activated.");
        return;
    }
    if (useRelease && configName == "verse-dev") {
        output.appendLine("The release version is being explicitly preferred since `useRelease` is set.");
        return;
    }
    // We make sure that if the extension is installed while a VS Code session is active, that we prompt the user
    // to reload VS Code to ensure that the extension runs properly.
    vscode.extensions.onDidChange(() => {
        let verseExt = vscode.extensions.getExtension(context.extension.id);
        if (verseExt === undefined) {
            return;
        }
        vscode.window
            .showInformationMessage("An extension was recently enabled/disabled. You might want to reload VS Code now for changes to take effect.", "Reload")
            .then((selection) => {
            if (selection === "Reload") {
                vscode.commands.executeCommand("workbench.action.reloadWindow");
            }
        });
    });
    // 1) Connect to language server
    // Determine which language server executable to use
    let serverExecutable = getConfig(configName, "serverPath");
    var useDefaultExecutable = serverExecutable.length == 0;
    if (!useDefaultExecutable) {
        useDefaultExecutable = !fs.existsSync(serverExecutable);
        if (useDefaultExecutable) {
            output.appendLine(`Server executable ${serverExecutable} not found, using default.`);
        }
    }
    if (useDefaultExecutable) {
        const exePath = os.type() == "Windows_NT"
            ? "bin/Win64/verse-lsp.exe"
            : os.type() == "Darwin"
                ? "bin/Mac/verse-lsp"
                : "bin/Linux/verse-lsp";
        let defaultServerExecutable = path.join(context.extensionPath, exePath);
        // Make copy of executable that we can use without locking the original executable
        let serverExecutableExt = path.extname(defaultServerExecutable);
        serverExecutable = path.join(os.tmpdir(), `${path.basename(defaultServerExecutable, serverExecutableExt)}-${process.pid}${serverExecutableExt}`);
        fs.copyFileSync(defaultServerExecutable, serverExecutable);
    }
    // Set language server options
    const serverCommand = {
        command: serverExecutable,
        args: getConfig(configName, "serverArguments"),
    };
    const traceFile = getConfig(configName, "trace");
    if (!!traceFile) {
        const trace = { VERSE_TRACE: traceFile };
        serverCommand.options = { env: Object.assign(Object.assign({}, process.env), trace) };
    }
    const syncFileEvents = getConfig(configName, "syncFileEvents", true);
    const serverOptions = serverCommand;
    const clientOptions = {
        // Register the server for Verse files
        documentSelector: [{ scheme: "file", language: "verse" }],
        synchronize: !syncFileEvents
            ? undefined
            : {
                fileEvents: vscode.workspace.createFileSystemWatcher("**/*.verse"),
            },
        // Resolve symlinks for all files provided by the Verse language server.
        // This is a workaround for a bazel issue - bazel produces a symlink tree to build in,
        // and when navigating to the included file, the Verse language server passes its path inside the symlink tree
        // rather than its filesystem path.
        // FIXME: remove this once the Verse language server knows enough about bazel to resolve the
        // symlinks where needed (or if this causes problems for other workflows).
        uriConverters: {
            code2Protocol: (value) => value.toString(),
            protocol2Code: (value) => vscode.Uri.file(fs.realpathSync(vscode.Uri.parse(value).fsPath)),
        },
    };
    const verseLanguageClient = new vscodelc.LanguageClient("Verse Language Server", serverOptions, clientOptions);
    context.subscriptions.push(verseLanguageClient.start());
    verseLanguageClient.onReady().then(() => {
        output.appendLine(`Verse Language Server executable ${serverCommand.command} is now active!`);
    });
    // 2) Connect to verse workflow server (if availible)
    const verseWorkflowClient = new versewc.VerseWorkflowClient("Verse Workflow");
    // Bind VerseWorkflowClient requests to commands
    context.subscriptions.push(vscode.commands.registerCommand("verseWorkflow.connect", () => {
        verseWorkflowClientConnect(verseWorkflowClient);
    }), vscode.commands.registerCommand("verseWorkflow.disconnect", () => {
        verseWorkflowClientDisconnect(verseWorkflowClient);
    }), vscode.commands.registerCommand("verseWorkflow.compile", () => {
        verseWorkflowClientCompile(verseWorkflowClient);
    }), vscode.commands.registerCommand("verseWorkflow.compileError", () => {
        verseWorkflowClientCompile(verseWorkflowClient);
    }), vscode.commands.registerCommand("verseWorkflow.compileWarning", () => {
        verseWorkflowClientCompile(verseWorkflowClient);
    }), vscode.commands.registerCommand("verseWorkflow.compileSuccess", () => {
        verseWorkflowClientCompile(verseWorkflowClient);
    }), vscode.commands.registerCommand("verseWorkflow.pushVerseChanges", () => {
        verseWorkflowClientPushChanges(verseWorkflowClient, true);
    }));
    // try to connect to server on startup for convenience
    verseWorkflowClientConnect(verseWorkflowClient);
}
exports.activate = activate;
// 3) VerseWorkflowClient commands
function verseWorkflowClientConnect(verseWorkflowClient) {
    verseWorkflowClient.start();
}
function verseWorkflowClientDisconnect(verseWorkflowClient) {
    verseWorkflowClient.stop();
}
function verseWorkflowClientCompile(verseWorkflowClient) {
    const saveBeforeStart = getConfig("debug", "saveBeforeStart");
    if (saveBeforeStart == "allEditorsInActiveGroup") {
        vscode.workspace.saveAll(true);
    }
    else if (saveBeforeStart == "nonUntitledEditorsInActiveGroup") {
        vscode.workspace.saveAll(false);
    }
    verseWorkflowClient.reqCompileProject();
}
function verseWorkflowClientPushChanges(verseWorkflowClient, verseOnly) {
    vscode.commands.executeCommand("setContext", "verseWorkflow.pushRequestInProgress", true);
    verseWorkflowClient.reqPushChanges(verseOnly).finally(() => {
        vscode.commands.executeCommand("setContext", "verseWorkflow.pushRequestInProgress", false);
    });
}
//# sourceMappingURL=extension.js.map