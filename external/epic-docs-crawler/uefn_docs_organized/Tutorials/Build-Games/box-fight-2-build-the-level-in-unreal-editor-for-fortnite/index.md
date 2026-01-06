# 2. Build the Level

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-2-build-the-level-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:19:18.990639

---

To make the game setup simpler, divide the box fight arena into two floors: a main floor where players will spawn and a basement for staging devices.

1. In the **Content Browser**, navigate to **Fortnite > Props > Haunted** and pick a floor tile for your basement.
2. Drag the tile onto your level and copy it by holding the **Alt** key and [translating](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#translate) it over to the next two cells. To select multiple tiles, hold **Shift**  or **Ctrl**, then **left-click** all three floor tiles and copy them over to the adjacent cells. The example level is 3 tiles wide and 5 tiles long.

   [![floor tile](https://dev.epicgames.com/community/api/documentation/image/5763f4b1-b5a9-431a-8f48-fc27230f1970?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5763f4b1-b5a9-431a-8f48-fc27230f1970?resizing_type=fit)
3. Pick a wall tile and place the wall around the floor you just set down.

   [![wall tiles](https://dev.epicgames.com/community/api/documentation/image/6446ce74-c69f-41a8-a312-f674ebcfa147?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6446ce74-c69f-41a8-a312-f674ebcfa147?resizing_type=fit)
4. Repeat the process for the main floor. If you like, add some variety by picking different building [Actors](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#actor). Note that the basement needs a height of 1 tile, while the main floor should be at least 2 tiles high. Here is a view of the arena from the outside.

   [![arena](https://dev.epicgames.com/community/api/documentation/image/e7a7347e-f9bf-4c0a-b9da-b54d8d58af16?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7a7347e-f9bf-4c0a-b9da-b54d8d58af16?resizing_type=fit)

   Remember to save your progress!
5. Since the arena is in an enclosed space, add lights to add brightness to your level. Pick some light sources that are appropriate for your arena, drag the lights onto the main floor and place them in the desired locations. For more ways to light up your level, check out the [lighting pages](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-in-unreal-editor-for-fortnite).

   [![lights](https://dev.epicgames.com/community/api/documentation/image/e7ea9dfc-87f1-47f8-aa90-2b407aca0cef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7ea9dfc-87f1-47f8-aa90-2b407aca0cef?resizing_type=fit)
6. You can illuminate your arena by placing **Light Actors**.

   1. Click **Window** and select **Place Actors** to open the panel.

      [![placeactors](https://dev.epicgames.com/community/api/documentation/image/99ad06e5-3c45-4c25-b58e-9ad2158baee8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99ad06e5-3c45-4c25-b58e-9ad2158baee8?resizing_type=fit)
   2. Select the **Point Light** Actor from either the **Basic** or **Lights** tab and drag it into your level.

      [![pointlight](https://dev.epicgames.com/community/api/documentation/image/8a4187ab-2e70-4e77-ae62-bd108fcdb4b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a4187ab-2e70-4e77-ae62-bd108fcdb4b9?resizing_type=fit)
   3. In the **Details** panel, adjust the Actor's settings to fit your aesthetic. You can scale your Actor to increase or decrease the illuminated area.

      [![pointlightoptions](https://dev.epicgames.com/community/api/documentation/image/3a05a380-8ebe-4501-bb58-0d360aed12b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a05a380-8ebe-4501-bb58-0d360aed12b6?resizing_type=fit)
   4. Copy and paste as many light actors as you need to get the optimal look for your level.

[Playtest your island](https://dev.epicgames.com/documentation/en-us/uefn/playtesting-your-island-in-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/5c24292f-d914-47cd-b16c-0aced85d10bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c24292f-d914-47cd-b16c-0aced85d10bc?resizing_type=fit)

## Next Section

[![3. Add Devices](https://dev.epicgames.com/community/api/documentation/image/25334b81-f62c-4349-93f3-4c3428578ed6?resizing_type=fit&width=640&height=640)

3. Add Devices

Add and configure the devices that make up the box fight.](https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-3-add-devices-in-unreal-editor-for-fortnite)
