# Verse Runtime Error Reporting

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-runtime-error-reporting-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:14:01.732427

---

**Verse Runtime Error Reporting** provides a detailed report of [runtime errors](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#runtime-error) in your Verse scripts. The report is a tool to help you identify problems with your code and fix them.

Reports provide thorough error details so you can understand what’s going wrong in your gameplay code. For example:

- **Error Diagnostic** - A designated code to identify the type of runtime error.
- **Error Description** - A detailed description of what the diagnostic means.
- **Number of Occurences** - The total number of times an event is reported.

Runtime error reports are categorized based on the result of the Verse code executing and entering a state it cannot recover from (i.e. an infinite loop or allocating too much memory). When your code becomes unrecoverable, it’s called a runtime error.

At the point of the runtime error, the faulty code execution is captured in the callstack, and is used to group the occurrences of runtime errors of an identical nature.

## Runtime Errors

Runtime errors capture information such as:

- Coding errors not caught by the compiler
- Issues that would cause your island to crash

The Verse [compiler](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compiler) currently cannot detect conditions in Verse code that would produce errors at runtime, such as [integer overflows](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#integer-overflow) or [infinite recursion](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#infinite-recursion). Such problematic code might appear to compile correctly at a glance, but not all problems can be caught by the compiler’s [semantic analysis](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#semantic-analysis) alone.

When your code executes at runtime, it may trigger **runtime errors**. When a runtime error occurs, all further Verse execution for the current device is halted. (This behaviour is subject to change in the future). Other devices may continue to execute, but it is not recommended to leave your code running in this state; instead, it is recommended that you identify the issue triggering the runtime error(s) and fix them.

Refer to the **[Debug Your Game with Debug Draw](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse)** document for more information on how to fix runtime errors.

Refer to the **[Performance Dashboard](https://dev.epicgames.com/documentation/en-us/fortnite/performance-dashboard-in-fortnite-creative)** document to understand how these metrics can be used alongside the runtime error report.

## Reports

Projects in the Creator Portal have a number of tools to help you understand your island’s performance and audience after publishing your island. You can also use the Verse Runtime Error Reporting feature to better understand your island’s performance before you publish your island.

[![You can find this report on the Project Navigation menu under Technical.](https://dev.epicgames.com/community/api/documentation/image/0c190efe-0065-49e8-9835-602a05af9e06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c190efe-0065-49e8-9835-602a05af9e06?resizing_type=fit)

You can find this report on the [Project Navigation](https://dev.epicgames.com/documentation/en-us/fortnite/managing-your-projects-in-fortnite-creative) menu under **Technical**, this opens the **Verse Errors** tab. Errors will also present during a play session. From here you can search through runtime error reports and filter the **Environment View** to show:

- **All**
- **Live**
- [Playtest](https://dev.epicgames.com/documentation/en-us/fortnite/adding-playtesters-in-fortnite-creative)
- [Private Code](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-page-features-in-fortnite-creative)

[![Search through runtime error reports and filter the **Environment View** to review errors.](https://dev.epicgames.com/community/api/documentation/image/fc933f25-100b-4d7f-ae4e-32da1f3cfd8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc933f25-100b-4d7f-ae4e-32da1f3cfd8c?resizing_type=fit)

Reports include:

- Timestamps to surface the most recent instance and earliest instance of a runtime error.
- **Playtest** and **Private Code** view that includes a dropdown list of link codes.

Catching runtime errors before publishing gives you the chance to fix your code so players have the best experience possible on your island.
