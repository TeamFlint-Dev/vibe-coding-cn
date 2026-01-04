# Performance Dashboard

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/performance-dashboard-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:19:40.701812

---

The **Performance** screen contains detailed information about the performance of your islands across [platforms](/documentation/en-us/fortnite/fortnite-creative-glossary#platform), and the types of issues your islands might experience. You can use the data from this screen to plan adjustments to your island [gameplay](/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay). The goal of the Performance chart is identifying issues, determining the cause, and taking corrective action.

[![undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/48fa4be8-7c2f-4c76-b6b1-d392459ff7a2/performance-screen.png)](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/48fa4be8-7c2f-4c76-b6b1-d392459ff7a2/performance-screen.png)

Click image to enlarge.

To see the Performance tab, click **Performance** in the [top navigation bar](/documentation/en-us/fortnite/fortnite-creative-glossary#topnavigationbar). Get started with your performance insights by reading through the Performance section.

## Why You Need It

The Performance Tab gives you insight into how your island experience performs across platforms, which means you can:

- Monitor your island experiences within days of publishing.
- Be your own QA team.
- Find and solve issues across platforms.

## How It Works

Fortnite uses backend tools to monitor your island for performance issues related to:

- **Frames Per Second (FPS)**: Which is represented as a missed frames percentage.
- **Hitches Per Minute**: Which will be displayed as the actual hitch rate or hitches per minute

Every island will vary on the acceptable rates of issues, and some frames missed and hitches can be expected. There are a lot of factors that lead to lower and higher numbers depending on the complexity of density of elements on your island.

### Frames Per Second

**Frames Per Second (FPS)** is the number of frames that appear in any kind of streaming content per second. While streaming videos and broadcast TV usually use a frame rate of 24 fps, streaming games usually use a higher FPS rate.

The more elements on the screen the more work will need to be done to render them, and this will reduce the frame rate. There are currently no publishing requirements to hit a particular frame rate however the suggested FPS is 30, with 60 FPS being ideal depending on platform.

The higher amount of FPS you have, the less impact missed frames will have on your games performance. The lower amount of FPS you have, the more performance will be impacted by missed frames.

### Hitches

**Hitches** (also known as FPS Drops or Dropped Frames) are often caused by loading in assets, and higher rates can also be decreased by a variety of ways including but not limited to reducing particle effects, mesh complexity, texture sizes, number of line of sight objects, number of unique assets and textures, and more.

Hitches can impede the player experience significantly depending on where and when the hitches happen. If your island is enabled for streaming and players are moving around quickly, it may also be a factor in causing more hitches to occur.

It’s good to keep this number generally lower as good performance results are typically below 2.5 - 3.

### Best Practices

Following are recommended guidelines to help you get the most out of the information available on your [dashboard](/documentation/en-us/fortnite/fortnite-creative-glossary#performancedashboard).

- When you visit the dashboard, check the performance of all your islands in every available category to get the most comprehensive view of your islands’ performance.
- Make changes to your islands based on island performance information and player feedback. If you have a bad report for a game but no player feedback, [playtest](/documentation/en-us/fortnite/fortnite-creative-glossary#playtest) the island yourself on different platforms to see what players are experiencing.
- If you use player feedback as part of your decision to make changes, let your supporters and the Fortnite Creative community know through your social channels.
- Always take constructive performance feedback about your islands seriously.
- If you change settings based on island performance [metrics](/documentation/en-us/fortnite/fortnite-creative-glossary#metrics) only, be sure to test your island on a few different platforms before making any announcements about the changes.

## My Performance Data

Use **My Performance Data** to identify issues on your island and across platforms with the detailed performance data. Understanding this information helps you to make informed adjustments to your island and to [gameplay](/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay) settings that can enhance the player’s experience.

Improving the player experience on your islands can increase the island’s [retention rate](/documentation/en-us/fortnite/fortnite-creative-glossary#retentionrate) and have other positive effects you can measure on the Insights screen.

[![undefined](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/50f29839-47f2-4d09-82aa-4991517a0c6a/performance-screen.png)](https://d1iv7db44yhgxn.cloudfront.net/documentation/images/50f29839-47f2-4d09-82aa-4991517a0c6a/performance-screen.png)

Click image to enlarge.

The line graph shows performance data for the game and period of time you select from the **Show Me** menu.

To check how your game is performing:

1. Click the arrow in the **My Performance Data** menu, then select the game (or games) you want the data for.
2. Click the arrow in the [**Client**](/documentation/en-us/fortnite/fortnite-creative-glossary#game-client) menu to select the platform you want performance information for.
3. Click the arrow in the **Issue** menu to change the issue you want to get data for.
4. Select whether you want Hourly or Daily data in the **Show Me** menu. You can also select the month in the Calendar dropdown menu.

### Client Menu

The **Client** menu has different platform options you can choose from — Overall, Desktop, Mobile, [Console](/documentation/en-us/fortnite/fortnite-creative-glossary#console), and Next-Gen Console. The information in the graph will change depending on what you select from the Client menu.

If you select **Overall**, you will see performance data for your island across all platforms.

### Issue Menu

The **Issue** menu features different issues your islands may be experiencing. These are measured by measuring the average island [frame rate](/documentation/en-us/fortnite/fortnite-creative-glossary#frame-rate), hitches and session crashes.

In some cases, different platforms experience particular performance issues in the same way. Fixing the performance issue for one platform can fix the same issue across all platforms at once. However, there are some cases where fixing a frame rate issue for Fortnite mobile could impact island performance on another platform.

### Show Me

View performance data for a selected period of time by setting the graph view to **Hourly** or **Daily**. You can also select the month you want to view island information for from the **Calendar** menu.

The default is always the current date.

### Download Icon

To download the information for this screen only, click the **Download** icon in the top right corner above the graph.

For more detail on memory management and optimization, check out these Unreal Fest Sessions:

- [**Memory Management in UEFN and Fortnite Creative**](https://www.youtube.com/watch?v=gtX0gPOSkbU&index=36)
- [**Project Optimization in Unreal Editor for Fortnite**](https://www.youtube.com/watch?v=k9fAXZ4U4XA&index=22)
