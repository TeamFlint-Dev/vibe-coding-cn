# Copyright Epic Games, Inc. All Rights Reserved.

# Quick enable or disable of logs
EnableLogs:logic = true

PrintLogMessage<public>(Message:string):void=
    if (EnableLogs?):
        Print(Message)