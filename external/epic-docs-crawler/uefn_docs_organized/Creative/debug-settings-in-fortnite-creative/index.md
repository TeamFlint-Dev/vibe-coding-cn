# Debug Settings

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/debug-settings-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:22:16.709301

---

Like other Island Settings, any settings you change here apply only to your current island. To access the debug features, go to **Island Settings** and select the **Debug** category.

[![Debug options in Creative](https://dev.epicgames.com/community/api/documentation/image/974792bb-cf33-4d48-bbbe-9f28f9f6c9c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/974792bb-cf33-4d48-bbbe-9f28f9f6c9c5?resizing_type=fit)

The debug settings can be changed at [**runtime**](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#runtime) in UEFN when you're playtesting. These settings do not affect published islands.

## Debug Options

The **Debug** category provides a way to debug the movement of [AI](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ai) entities on your island (such as guards or wildlife). While some of the options available on this tab are only useful if you're working in [Unreal Editor for Fortnite (UEFN)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#unreal-editor-for-fortnite), others — particularly the navigation option — are also useful in Fortnite Creative.

Debug settings can be managed from **Fortnite Creative** or from **UEFN**. Any toggle settings you change here are reflected in the [Island Settings](https://dev.epicgames.com/documentation/en-us/uefn/island-settings-in-unreal-editor-for-fortnite#useroptions-debug) in UEFN, and vice versa.

These options are on/off toggles, and they all default to Off.

| Option | Values | Description |
| --- | --- | --- |
| Debug | On, Off | This setting defaults to Off. Set it to On to access the settings below it. |
| Navigation | On, Off | A navigation mesh, or NavMesh, is a way to provide a path for an AI to move through complicated spaces. This setting determines whether a visualization of the NavMesh will display in Creative in both [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode) and [Play mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-mode).  The mesh shows up in Fortnite Creative whether you're in [Create mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#create-mode) or [Play mode](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#play-mode).  A NavMesh can only be generated if your island has at least one AI spawner device placed, such as a [Guard Spawner](https://dev.epicgames.com/documentation/assets/using-guard-spawner-devices-in-fortnite-creative), a [Wildlife Spawner](https://dev.epicgames.com/documentation/assets/using-wildlife-spawner-devices-in-fortnite-creative), or [Creature Spawner](https://dev.epicgames.com/documentation/assets/using-creature-spawner-devices-in-fortnite-creative).  For a full description of the colors used in the NavMesh and what they represent, see [Navigation Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/navigation-mesh-in-fortnite-creative). |
| Invincibility | On, Off | Determines whether players take damage during playtesting. It does not affect standard gameplay. |
| Verse Debug Draw | On, Off | When you use [Verse](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#verse) to tweak aspects of your island in UEFN, you can use a Verse feature called Debug Draw for debugging your code. This feature can be enabled from UEFN, as described in [Debug Your Game with Debug Draw](https://dev.epicgames.com/documentation/en-us/uefn/debug-draw-in-verse), or here in Island Settings.  This is the only debug setting that does not work in Creative directly. You can set it here, but you won't see the effects if you are in Edit/Create mode on your island — **the feature can only be used in UEFN.** |
| Fast Iteration Mode | On, Off | Sets whether fast iteration between Edit mode in UEFN and Creative Play mode is enabled. When set to On, your transitions from one mode to the other are faster — game countdowns are shortened, and scoreboards are skipped. This setting is intended to shorten time between edits in UEFN and playtesting, but does not affect anything in Creative if you're not using UEFN. |
| Test Players Added at Game Start | On, Off | Determines how many test players spawn at start of game. Test players behave as though they are idle players. |
| Test Players on Start | None, Fill, Custom | **None**spawns no test players.  **Fill**spawns the maximum number of players allowed per the island settings (go to **Mode > Structure > Max Players** to change this value.)  With **Custom**, you can select the number of test players up to the maximum number of players allowed. |
| Number of Test Players | Select a number | This option is only available if Test Players Added at Game Start is set to Custom. |
| Test Player Behavior | None, Random Movement, Follow Player | Determines the behavior assigned to Test Players:  **None:** Test Players have no behavior.  **Random Movement:** Test Players move within a random area.  Follow Player: Test Players start and stop following players who crouch in front of them. |
| Custom Test Player | Select a character | **UEFN only**. Paste a character definition, or browse. |
