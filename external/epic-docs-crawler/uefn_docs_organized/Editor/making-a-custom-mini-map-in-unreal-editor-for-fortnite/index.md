# Making a Mini Map with the Map Controller Device

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-mini-map-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:07:52.674476

---

A map and minimap are important tools that help players navigate a large game world while providing critical information about terrain, objectives, and points of interest. A map can give players a quick overview of the game environment, either for navigating landscapes or engaging in intense strategic battles. Maps contribute a lot to overall gaming experience, whether exploring mazes, uncovering hidden treasures, or simply planning routes.

In Unreal Editor for Fortnite (UEFN), use the **Map Controller** devices to:

- Change the framing of the map and immediately preview the results.
- Control the zoom on the minimap when the device is active.
- Place multiple Map Controller devices on your island and activate them as needed.
- Customize the look and feel of your maps.

## Positioning the Device

In the **Content Browser**, navigate to **Fortnite** > **Devices**, then find and drag a **Map Controller** device into your viewport. Notice the map preview screen appears at the bottom right.

[![map preview](https://dev.epicgames.com/community/api/documentation/image/66babaf1-471c-45c9-b69d-502446c80920?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/66babaf1-471c-45c9-b69d-502446c80920?resizing_type=fit)

Use the edges of the device volume to define the area captured for the map. The Map Controller displays everything beneath the area that it covers (the downward triangles indicate where the top of the device is).

### Changing the Map Size

Change the **Capture Box Size** in the details menu to make the volume larger or smaller. The device scale is locked, so it retains its square shape.

Only modify the **Map Capture Box Height** if you want the device to trigger when a player enters the Map Controller volume.

### Changing the Map Shape

Change the **Minimap Shape** in the details menu from Default to Square or Cirular. This setting works alongside other settings for the minimap as well.

In the image below, the minimap is set to Circular and uses a Map Capture Box size of 5.0 and a Map Capture Box Height of 1.0.

[![The minimap is set to Circle and uses a Map Capture Box size of 7.0 and a Map Capture Box Height of 29.0.](https://dev.epicgames.com/community/api/documentation/image/d0a01a30-62f8-4e7d-8016-d7d8791b4664?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0a01a30-62f8-4e7d-8016-d7d8791b4664?resizing_type=fit)

### Changing the Map Rotation

Switch the minimap view to follow the player's viewpoint by turning **On** the **Minimap Lock Player Rotation** setting.

In the image below the Minimap Lock Player Rotation setting is turned On.

### Setting the Minimap Zoom Factor

Changing the **Minimap Zoom Factor** affects how zoomed in the map appears in game when following the player.

The minimap below has a zoom factor of 2.

[![Zoom Factor: 2](https://dev.epicgames.com/community/api/documentation/image/4b40bbc0-247f-4ec9-adae-70d626f36c4c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b40bbc0-247f-4ec9-adae-70d626f36c4c?resizing_type=fit)

This next minimap has a zoom factor of 5. Notice how it's more zoomed in.

[![Zoom Factor: 5](https://dev.epicgames.com/community/api/documentation/image/532218e9-e2c3-4bae-a838-c7ddfc34c8f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/532218e9-e2c3-4bae-a838-c7ddfc34c8f7?resizing_type=fit)

Checking **Full Frame Minimap** displays the entire map volume and no longer follows the player.

[![full frame minimap](https://dev.epicgames.com/community/api/documentation/image/3b987f12-05b2-40bc-9066-6e2e5afb5ae9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b987f12-05b2-40bc-9066-6e2e5afb5ae9?resizing_type=fit)

### Setting Up a 3D Map

You can rotate the device along the X, Y and Z axes to capture the island from a different angle.

[![tilted map](https://dev.epicgames.com/community/api/documentation/image/a60b920a-ad6d-46ab-975e-a2a525d338b0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a60b920a-ad6d-46ab-975e-a2a525d338b0?resizing_type=fit)

Test the position of the map inside the game client to ensure you’re getting the expected result.

## Priority System

For the Map Controller device, **Priority** determines which device takes priority when multiple devices are active.

When placing the device, the default priority is **0**. Any Map Controller device with a higher Priority number will override devices with a lower priority.

### Visualizing Priorities

The examples below demonstrate how the priority system works. A total of five maps are each represented by a letter and a priority number: **A1**, **B2**, **C2**, **D5** and **E5**. A1 is the default map, and every other map is connected to an ON/OFF switch. All maps display in the minimap when active.

When two Map Controller devices are set to the same priority, the one most recently activated will be prioritized by the game.

The player will always see the highest priority map displayed out of all active maps.

A lower priority map will never override a high priority map.

### How to Use Priorities

Priority stacks can really simplify your workflow when used correctly!

Imagine a ghost hunting game where, on one team, ghosts must hide from the hunters and collect energy items, while on the other team, hunters use trackers to locate the ghosts. Instead of manually triggering each map to turn on and off, you can grant hunters their own, high-priority, specialized map that will override the ghosts’ maps without any additional logic.

In an open-world survival game, set the outdoor map to a low priority, and make maps of indoor spaces high priority. Once again, with no complicated logic, players will switch maps seamlessly as they enter and exit buildings and other areas of interest.

Now, try coming up with your own scenarios!

## Making Custom Maps

UEFN gives you the ability to completely customize your maps in a few simple steps!

Make sure that your island is mostly finalized before capturing a map image! Modifying a custom map requires a lot more effort than simply moving your Map Controller device to a different location.

1. Position the **Map Controller** device over the area you want to display.

   [![map controller position](https://dev.epicgames.com/community/api/documentation/image/ec99f065-d946-4590-ae16-187d244ed7f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ec99f065-d946-4590-ae16-187d244ed7f2?resizing_type=fit)
2. In the Details panel, scroll down to **Capture Map Image** and click to capture the high-resolution snapshot.

   [![capture map image](https://dev.epicgames.com/community/api/documentation/image/be685bcf-7ad6-44df-8f3c-c8cc12ce9489?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be685bcf-7ad6-44df-8f3c-c8cc12ce9489?resizing_type=fit)
3. This saves the image file in your local **AppData** folder. Your path could look something like this: **C:\Users\your\_name\AppData\Local\UnrealEditorFortnite\Saved\Screenshots\Maps**
4. Open the image in the editor software of your choosing, and make the desired changes.
5. Once finished, export the modified map to a folder.

   [![export map](https://dev.epicgames.com/community/api/documentation/image/3e71c30c-e796-4d28-b046-3c4dc8113f02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e71c30c-e796-4d28-b046-3c4dc8113f02?resizing_type=fit)
6. Drag the custom map file into your project, or **import** it from the **Content Browser**.
7. Double-click on the imported file, and change the following settings:

   1. Texture Group: UI
   2. Mip Gen Settings: NoMipmaps

   [![texture settings](https://dev.epicgames.com/community/api/documentation/image/8ad1c30f-494d-4d71-8a60-a184c9d51f52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ad1c30f-494d-4d71-8a60-a184c9d51f52?resizing_type=fit)
8. Back in the **Map Controller Details** panel, check the box next to **Custom Map Texture**, then select the imported image as the custom texture.
9. Save your project! When you launch a session, you should see your custom maps displaying on both the minimap, and the map screen.

   [![custom map](https://dev.epicgames.com/community/api/documentation/image/f93673f9-c7b1-46f0-9b84-853afae56a83?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f93673f9-c7b1-46f0-9b84-853afae56a83?resizing_type=fit)
