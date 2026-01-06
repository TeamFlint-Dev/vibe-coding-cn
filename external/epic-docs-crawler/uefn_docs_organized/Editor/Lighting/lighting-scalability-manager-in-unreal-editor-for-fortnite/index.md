# Lighting Scalability Manager

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lighting-scalability-manager-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:20:07.151945

---

The Lighting Scalability Manager in Unreal Editor for Fortnite (UEFN) is used to hide and show lights and post process volumes (PPV) based on specific scalability settings (cinematic, epic, high, medium and low). This allows you to customize and optimize your lighting per platform and situation.

Behind the scenes the Lighting Scalability Manager is listening to changes in **Global Illumination Quality**.

## Using the Lighting Scalability Manager

The Lighting Scalability Manager can be found in the **ContentBrowser** under **All** > **Fortnite** > **Lighting** > **Tools**.

[![Finding the Lighting Scalability Manager](https://dev.epicgames.com/community/api/documentation/image/3c802322-a1af-4c3c-b0f3-2a185c3e8532?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c802322-a1af-4c3c-b0f3-2a185c3e8532?resizing_type=fit)

To use the Lighting Scalability Manager:

1. From the **Content Browser** search for the **Lighting Scalability Manager** in the search bar, drag the Lighting Scalability Manager thumbnail into the viewport. The thumbnail is replaced with an **Editor Icon** in the scene.
2. Open the Actor dropdown menu in the toolbar and select a light actor to add to the scene.

   [![Open the Actor dropdown menu to select a light](https://dev.epicgames.com/community/api/documentation/image/e779e7bb-0c5e-4eff-8a96-54758bfc0fdb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e779e7bb-0c5e-4eff-8a96-54758bfc0fdb?resizing_type=fit)
3. In the Outliner, rename your lighting actor **Low**.
4. In the Outliner duplicate the lighting actor until you have **two** more copies, then rename them:

   1. **Medium**
   2. **High**

   [![Rename the light Actors](https://dev.epicgames.com/community/api/documentation/image/9e96d417-181a-4af0-be95-6f6b6161ed49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e96d417-181a-4af0-be95-6f6b6161ed49?resizing_type=fit)
5. In the Outliner select the **Lighting Scalability Manager**, this opens the scalability manager options in the **Details** panel. Click the **Actor Array Element** icon (plus sign) to add elements into the Actor array.

   [![Click the Actor Array](https://dev.epicgames.com/community/api/documentation/image/4f9bda57-4b86-4b2b-9a8c-a675f0c4ecff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f9bda57-4b86-4b2b-9a8c-a675f0c4ecff?resizing_type=fit)
6. In the Details panel, click the **arrow** next to the **Array Index** property. This opens the **Actor Options** panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/4bb00e44-774a-44ea-9ee5-6d629863d1f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4bb00e44-774a-44ea-9ee5-6d629863d1f7?resizing_type=fit)
7. Select the **Actor** dropdown menu and select one of your **light actors** from the list.

   Alternatively, you can also hit the dropper next to the arrow and select the object you want loaded in the viewport.
8. Check the proper scalability setting for the actor according to whether the lighting is meant for low scalability, medium scalability, high scalability, or epic/cinematic scalability. Uncheck the other scalability settings that don’t belong with the light actor.

In the image below, the PointLight\_Low is paired with Low settings for lower performing platforms.

[![Low Scalability Setting](https://dev.epicgames.com/community/api/documentation/image/a5f033fd-ab53-4a6d-aaf0-a3bdeeeedf25?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5f033fd-ab53-4a6d-aaf0-a3bdeeeedf25?resizing_type=fit)

The actors work as expected in-game for the platforms that make use of the associated scalability settings.

Repeat steps 5-7 to set the scalability for the other two lighting actors. Playtest on multiple platforms to see the scalability manager at work.

## Lighting Scalability Manager Options

These are the Lighting Scalability Manager’s options:

[![The scalability settings that most used in the Lighting Scalabaility Manager.](https://dev.epicgames.com/community/api/documentation/image/bbcebc6a-dbf9-4a97-b333-3a26f0ac49f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbcebc6a-dbf9-4a97-b333-3a26f0ac49f5?resizing_type=fit)

| Number | Option | Description |
| --- | --- | --- |
| 1. | **Refresh Scalability** | Refreshes the scalability settings in the editor. |
| 2. | **Actor Array Element Icon** | Adds an array field to the Actor option. |
| 3. | **Delete Icon** | Deletes the actor array from the Actor options. |
| 4. | **Actor Dropdown Menu** | Loads the selected actor into the slot. |
| 5. | **Scalability Checkboxes** | Selects or deselects the scalability for the actor. |
| 6. | **Use Selected Actor Icon** | Uses the selected actor from the level editor. |
| 7. | **Select and Frame Actor Icon** | Selects and frames the actor in the viewport. |
| 8. | **Pick Actor Icon** | Picks an actor from the viewport. |

You should rename actors according to the scalability setting you intend to use with that actor. For example, **PointLight\_00\_CineEpicHigh** and **PointLight\_00\_Medium\_Low**. These both share the prefix PointLight\_00\_ but have a different suffix to designate the scalability setting they are used with.

## Custom Indoor Lighting Example

You can hide and show specific lights according to scalability settings. This allows you to have custom indoor lighting tailored to each scalability setting for a consistent user experience regardless of platform.

The light pool and color are matched by using duplicate light actors and the Scalability Manager in the scalability examples below.

### No Scalability in Use

The custom indoor lighting example uses the **Tilted Towers map** inside a prefab building that has no windows and a few lights to demonstrate the power of the Scalability Manager at work.

[![Lights are set up on a Scalability Manager, but not using scalability.](https://dev.epicgames.com/community/api/documentation/image/8757623a-27a4-4783-8bb8-aeeeaaca6978?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8757623a-27a4-4783-8bb8-aeeeaaca6978?resizing_type=fit)

In the image above is an example of the Lighting Scalability Manager used with the Cine\_Spotlight without adding any scalability settings in the manager.

### Scalability in Use

Nothing can be done about matching the scene lighting in low scalability. However, something can be done about matching the scene better on **Medium** and **High** settings using the Lighting Scalability Manager.

Create **3 Spotlights** for the **TV**, one for **Medium scalability**, one for **High scalability**, and one for **Epic/Cine scalability**.

Create **2 Point Lights** for the **desk lamp**, one for **Medium scalability**, and one for **High scalability**.

Set up the Lighting Scalability Manager for the spotlights as follows:

| Actor Settings | Scalability Settings | Explanation | Image |
| --- | --- | --- | --- |
| SpotLight\_Medium Intensity: **80.0 cd** | Medium | The setting works well for providing some shallow lighting highlights on the ground. | [CAPTION] Medium SpotLight [/CAPTION] |
| SpotLight\_High Intensity: **12.0 cd** | High | The setting works well for providing some lighting highlights on the ground. | [CAPTION] High SpotLight [/CAPTION] |
| SpotLight\_Epic Intensity: **8.0 cd** | Epic, Cinematic | The setting works well for providing some realistic lighting highlights on the ground. | [/CAPTION] Epic/Cine SpotLight [/CAPTION] |

*Click on images to enlarge.*

This allows you to match the light intensity and color across each scalability setting to make the scene match as closely as possible for all players across platforms.

Set up the Lighting Scalability Manager for the point lights as follows:

| Actor Settings | Scalability Settings | Explanation | Image |
| --- | --- | --- | --- |
| PointLight\_Medium Intensity: **10.0 cd** | Medium | The setting works well to provide fill lighting on the wall and deeper shadows. | [CAPTION] Medium PointLight [/CAPTION] |
| PointLight\_High Intensity: **0.05 cd** | High | The setting works well for providing fill lighting with fog highlights on the wall and deeper shadows. | [CAPTION] High PointLight [/CAPTION] |

You can see the results of the Light Scalability Manager with the different scalability light actors below. The results show the Lighting Scalabaility Manager without using any scalability settings and with tuning the proper scalability for each light actor:

**Epic Scalability**

![Epic No Scalability](https://dev.epicgames.com/community/api/documentation/image/b404b1aa-a1e1-40fd-a163-4b73b6c1e5c6?resizing_type=fit&width=1920&height=1080)

![Epic In Game After Scalability](https://dev.epicgames.com/community/api/documentation/image/5fab9ca9-347f-48c1-9358-ab07d76552c5?resizing_type=fit&width=1920&height=1080)

Epic No Scalability

Epic In Game After Scalability

**High Scalability**

![High No Scalability](https://dev.epicgames.com/community/api/documentation/image/f7dfdee2-3494-486b-811f-840155231c9d?resizing_type=fit&width=1920&height=1080)

![High In Game After Scalability](https://dev.epicgames.com/community/api/documentation/image/a1be1127-721b-4ce0-9148-92884bb4ad9d?resizing_type=fit&width=1920&height=1080)

High No Scalability

High In Game After Scalability

**Medium Scalability**

![Medium No Scalability](https://dev.epicgames.com/community/api/documentation/image/5ac4c146-2ce1-47dd-9c40-1c16d0d897ce?resizing_type=fit&width=1920&height=1080)

![Medium In Game After Scalability](https://dev.epicgames.com/community/api/documentation/image/6628a488-c862-43e4-9842-85d649b72109?resizing_type=fit&width=1920&height=1080)

Medium No Scalability

Medium In Game After Scalability

**Low Scalability**

![Low No Scalability](https://dev.epicgames.com/community/api/documentation/image/3e2e145a-ecd0-4e45-8420-e6ce777886e6?resizing_type=fit&width=1920&height=1080)

![Low In Game After Scalability](https://dev.epicgames.com/community/api/documentation/image/91a263e6-1ee5-498e-906e-cbef36c28fa5?resizing_type=fit&width=1920&height=1080)

Low No Scalability

Low In Game After Scalability

Low scalability looks like this no matter what settings are used in the Lighting Scalability Manager.

With the Lighting Scalability Manager you can use custom lighting to match your scene at different scalability to Lumen.

### Multiple Usage Example

You can use multiple Lighting Scalability Managers to further organize, categorize, and name your custom lighting as you see fit.

For Instance, in the same example below, two Lighting Scalability Managers are used. One named **\_SpotLight** and second named **\_PointLight**. The lights are loaded the same way as above and the scalability is assigned for each light.

![Spotlights setup on the first Scalability Manager.](https://dev.epicgames.com/community/api/documentation/image/6421a090-adfb-43e5-88b6-dbb3fa90cef8?resizing_type=fit&width=1920&height=1080)

![Point lights setup on the second Scalability Manager](https://dev.epicgames.com/community/api/documentation/image/f41e7976-f2ab-472f-af5d-44c337ab706b?resizing_type=fit&width=1920&height=1080)

Spotlights setup on the first Scalability Manager.

Point lights setup on the second Scalability Manager
