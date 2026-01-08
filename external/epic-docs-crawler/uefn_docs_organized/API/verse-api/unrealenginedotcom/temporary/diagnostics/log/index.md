# log class

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log>
> **爬取时间**: 2025-12-27T02:14:09.822264

---

log class to send messages to the default log

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/Temporary/Diagnostics }` |

## Members

This class has both data members and functions.

### Data

| Data Member Name | Type | Description |
| --- | --- | --- |
| `Channel` | `log_channel` | Channel class name will be added as a prefix used when printing the message e.g. '[log\_channel]: #Message |
| `DefaultLevel` | `log_level` | Sets the default log level of the displayed message. See log\_level enum for more info on log levels. Defaults to log\_level.Normal. |

### Functions

| Function Name | Description |
| --- | --- |
| [`Print`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log/print) | Print message using the given log level |
| [`Print`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log/print-1) | Print diagnostic using the given log level |
| [`PrintCallStack`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log/printcallstack) | Prints the current script call stack using the given log level |
