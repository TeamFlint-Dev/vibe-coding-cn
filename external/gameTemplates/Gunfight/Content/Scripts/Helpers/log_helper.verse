using { /UnrealEngine.com/Temporary/Diagnostics }

# Quick enable or disable of logs
EnableLogs:logic = true

(Logger:log).PrintDebug<public>(Message:string):void=
    if (EnableLogs?):
        Logger.Print(Message)

