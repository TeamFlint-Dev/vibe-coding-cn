# Technical Performance

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/technical-performance-in-fortnite
> **爬取时间**: 2025-12-27T00:14:18.208706

---

Understanding the technical performance of your islands is key to ensuring a consistent and stable experience for your players. To access the technical reporting tab, log into the Creator Portal and select a project. All technical reporting for that project lives under the **Technical** tab in the left navigation bar.

[![Select Technical from the project navigation menu.](https://dev.epicgames.com/community/api/documentation/image/3a6cbf67-1759-42cb-abdf-bc4575deba49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a6cbf67-1759-42cb-abdf-bc4575deba49?resizing_type=fit)

Project navigation menu

From the Technical screen you can access reports on your [Verse code](https://dev.epicgames.com/documentation/en-us/fortnite/technical-performance-in-fortnite#verse-runtime-error-reporting) and overall [island performance](https://dev.epicgames.com/documentation/en-us/fortnite/technical-performance-in-fortnite#performance-data-dashboard). These reports can inform you about issues with your island that you may not be aware of that cause quality control issues for players.

## Verse Errors Dashboard

The **Verse Errors** dashboard can help you better understand your island’s performance before you publish your island with Verse Runtime Error Reports. Verse runtime error reporting provides a detailed report of [runtime errors](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#runtime-error) in your Verse scripts.

[![Select Verse Errors tab to get reports on Verse errors in your code.](https://dev.epicgames.com/community/api/documentation/image/60836833-558b-4a0a-b43a-2e867e35b416?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60836833-558b-4a0a-b43a-2e867e35b416?resizing_type=fit)

Verse Errors tab

### Runtime Error Reports

Runtime error reports are categorized based on the result of the Verse code executing and entering a state it cannot recover from (for example, an infinite loop or allocating too much memory). When your code becomes unrecoverable, it’s called a runtime error.

At the point of the runtime error, the faulty code execution is captured in the callstack, and is used to group the occurrences of runtime errors of an identical nature.

Runtime errors capture information such as:

- Coding errors not caught by the compiler
- Issues that would cause your island to crash

[![An example of a project with Verse runtime errors.](https://dev.epicgames.com/community/api/documentation/image/4bba1a97-119c-466f-bd09-cb56acb6c7fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bba1a97-119c-466f-bd09-cb56acb6c7fb?resizing_type=fit)

Verse Runtime Errors

The Verse [compiler](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#compiler) currently cannot detect conditions in Verse code that would produce errors at runtime, such as [integer overflows](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer-overflow) or [infinite recursion](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#infinite-recursion). Such problematic code might appear to compile correctly at a glance, but not all problems can be caught by the compiler’s [semantic analysis](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#semantic-analysis) alone.

When your code executes at runtime, it may trigger runtime errors. When a runtime error occurs, all further Verse execution for the current device is halted. (This behavior is subject to change in the future). Other devices may continue to execute, but it is not recommended to leave your code running in this state; instead, it is recommended that you identify the issue triggering the runtime error(s) and fix them.

Refer to the **[Debug Your Game with Debug Draw](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse)** document for more information on how to fix runtime errors.

### Report Diagnostics and Details

Reports provide thorough error details so you can understand what’s going wrong in your gameplay code. For example:

- **Error Diagnostic** - A designated code to identify the type of runtime error.
- **Error Description** - A detailed description of what the diagnostic means.
- **Number of Occurrences** - The total number of times an event is reported.

The report is a tool to help you identify problems with your code and fix them. From here you can search through runtime error reports and filter the Environment View to show:

- **All**
- **Live**
- **[Playtest](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite)**
- **[Private Code](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-from-the-creator-portal-in-fortnite-creative#publish-in-creator-portal)**

Reports include:

- Timestamps to surface the most recent instance and earliest instance of a runtime error.
- **Playtest** and **Private Code** view that includes a dropdown list of link codes.

Catching runtime errors before publishing gives you the chance to fix your code so players have the best experience possible on your island.

## Performance Data Dashboard

The **Performance data** dashboard provides insight into how your island experience performs across platforms, which means you can:

- Monitor your island experiences within days of publishing.
- Be your own QA team and determine the cause of issues.
- Find and solve issues across platforms.

Performance reports contain detailed information about the performance of your island across platforms, and the types of issues your island might experience. To open the Performance data dashboard, select **Performance data** from the Technical screen options. The dashboard has all your performance insights.

[![Select Performance data from the available options to see your island performance data.](https://dev.epicgames.com/community/api/documentation/image/595ef199-6fe8-4d7c-998c-92a718a7c2ba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/595ef199-6fe8-4d7c-998c-92a718a7c2ba?resizing_type=fit)

Performance data tab

### Performance Tools

Fortnite uses backend tools to monitor your island for performance issues related to:

- **Frames Per Second (FPS)** - Which is represented as a missed frames percentage.
- **Hitches Per Minute** - Which will be displayed as the actual hitch rate or hitches per minute

Every island varies on the acceptable rates of issues, and some frames missed and hitches can be expected. There are a lot of factors that lead to lower and higher numbers depending on the complexity of density of elements on your island.

#### Frames Per Second

Frames Per Second (FPS) is the number of frames that appear in any kind of streaming content per second. While streaming videos and broadcast TV usually use a frame rate of 24 FPS, streaming games usually use a higher FPS rate. Video games have more elements on the screen resulting in more work in the background to render those elements and results in reduced frame rates.

There are currently no publishing requirements to hit a particular frame rate, however **30-60 FP**S is ideal depending on platform. The higher amount of FPS you have, the less impact missed frames have on your game’s performance. The lower amount of FPS you have, the more performance is impacted by missed frames.

#### Hitches

Hitches (also known as FPS Drops or Dropped Frames) are often caused by loading in assets, and higher rates can also be decreased by a variety of ways including but not limited to reducing particle effects, mesh complexity, texture sizes, number of line of sight objects, number of unique assets and textures, and more.

Hitches can impede the player experience significantly depending on where and when the hitches happen. If your island is enabled for streaming and players are moving around quickly, it may also be a factor in causing more hitches to occur.

It’s good to keep this number generally lower as good performance results are typically below **2.5 - 3**.

### Performance Best Practices

Following are recommended guidelines to help you get the most out of the information available on the Performance data dashboard.

- Check all performance categories for your island to get the most comprehensive view of your island's performance.
- Make changes to your islands based on island performance information and player feedback. If you have a bad report for the game but no player feedback, playtest the island yourself on different platforms to see what players are experiencing.
- If you use player feedback as part of your decision to make changes, let your supporters and the Fortnite Creative community know through your social channels and [community posts](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-communities-in-fortnite).
- Always take constructive performance feedback about your island seriously.
- If you change settings based on island performance metrics only, be sure to test your island on a few different platforms before making any announcements about the changes.

### Performance Data Charts

The performance chart provides insight into your island by illustrating issues with detailed performance data. The line graph shows performance data for the island during a specified period of time. To view performance data for a selected period of time use the **Show Me** menu, the default is the current date.

[![An example of the Performance data chart.](https://dev.epicgames.com/community/api/documentation/image/63e7cc36-31f4-48d4-81cb-375ecbbd6e8f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63e7cc36-31f4-48d4-81cb-375ecbbd6e8f?resizing_type=fit)

Click image to enlarge.

To check how your game is performing:

- Click the **arrow icon** then select the game (or games) you want data for.
- Click in the **Client** menu to select the platform you want performance information for.
- Click in the **Issue** menu to switch between issue types.
- Select from Hourly or Daily data in the Show Me menu. You can also select the month in the **Calendar** dropdown menu.

#### Client Menu

The Client menu has different platform options you can choose from:

- **Overall**
- **Desktop**
- **Mobile**
- **Console**
- **Next-Gen Console**

The information in the graph changes depending on what you select from the **Client** menu. If you select **Overall**, you will see performance data for your island across all platforms.

#### Issue Menu

The Issue menu features different issues your island may be experiencing. The chart reflects the measurement of the average island frame rate, hitches, and session crashes.

In some cases, different platforms experience particular performance issues in the same way. Fixing the performance issue for one platform can fix the same issue across all platforms at once. However, there are some cases where fixing a frame rate issue for Fortnite mobile could impact island performance on another platform.

## Download Reports

To download a report click the **Download** icon in the top right corner above the graph.

For more detail on memory management and optimization, check out these Unreal Fest Sessions:

- [Memory Management](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite)
- [Project Optimization in Unreal Editor for Fortnite](https://www.youtube.com/watch?v=k9fAXZ4U4XA)
