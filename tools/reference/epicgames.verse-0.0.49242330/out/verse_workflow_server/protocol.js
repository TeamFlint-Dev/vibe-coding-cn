"use strict";
// Copyright Epic Games, Inc. All Rights Reserved.
Object.defineProperty(exports, "__esModule", { value: true });
exports.VerseWorkflowProtocol = void 0;
/*
This is based on the protocol described by:
//Engine//Restricted//NotForLicensees//Source//Programs//Solaris//VSCodeExtension//VerseWorkflowProtocol.md

Make sure any changes to this file are documented in VerseWorkflowProtocol.md and update:
//Engine//Restricted//NotForLicensees//Plugins//Solaris//Source//VerseWorkflowServer//Public//VerseWorkflowProtocol.h to match.

Furthermore, any additional types added to this file should have their respective user defined type guards added to ./protocolClient.ts
*/
var VerseWorkflowProtocol;
(function (VerseWorkflowProtocol) {
    // ---- Base Protocol  ------------------------------------------------------------------------------------------------
    let MessageType;
    (function (MessageType) {
        MessageType[MessageType["Notification"] = 0] = "Notification";
        MessageType[MessageType["Request"] = 1] = "Request";
        MessageType[MessageType["Response"] = 2] = "Response";
    })(MessageType = VerseWorkflowProtocol.MessageType || (VerseWorkflowProtocol.MessageType = {}));
    // For both BuildState and VKPlayButtonState:
    // - These are referenced by integer-value in package.json.
    //   If they are changed please update those references!
    // - Keep these in sync with their respective C++ enums located at:
    //   BuildState -> VerseWorkflowProtocol.cpp
    //   EVKPlayButtonState -> IVerseWorkflowServerModule.cpp
    let BuildState;
    (function (BuildState) {
        BuildState[BuildState["Success"] = 0] = "Success";
        BuildState[BuildState["Warnings"] = 1] = "Warnings";
        BuildState[BuildState["Errors"] = 2] = "Errors";
        BuildState[BuildState["Building"] = 3] = "Building";
        BuildState[BuildState["NoBuild"] = 4] = "NoBuild";
    })(BuildState = VerseWorkflowProtocol.BuildState || (VerseWorkflowProtocol.BuildState = {}));
    // ---- parameters & results ------------------------------------------------------------------------------------------
    class NoParams {
    }
    VerseWorkflowProtocol.NoParams = NoParams;
    //logMessage
    let Severity;
    (function (Severity) {
        /**
         * An error message.
         */
        Severity[Severity["Error"] = 1] = "Error";
        /**
         * A warning message.
         */
        Severity[Severity["Warning"] = 2] = "Warning";
        /**
         * An information message.
         */
        Severity[Severity["Info"] = 3] = "Info";
        /**
         * A log message.
         */
        Severity[Severity["Log"] = 4] = "Log";
    })(Severity = VerseWorkflowProtocol.Severity || (VerseWorkflowProtocol.Severity = {}));
})(VerseWorkflowProtocol = exports.VerseWorkflowProtocol || (exports.VerseWorkflowProtocol = {}));
//# sourceMappingURL=protocol.js.map