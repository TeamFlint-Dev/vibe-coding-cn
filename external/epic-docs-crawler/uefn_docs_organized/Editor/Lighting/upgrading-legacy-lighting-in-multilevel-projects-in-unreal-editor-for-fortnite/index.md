# Upgrading Legacy Lighting in Multi-Level Projects

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/upgrading-legacy-lighting-in-multilevel-projects-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:17:00.651937

---

With the deprecation of the old time of day manager’s (TODM) day and night cycle and the Skydome device, it is recommended to convert all islands you wish to preserve to the new TODM. 
All islands using the Skydome device will retain their gameplay, volume data, and positional data, but the island lighting will default to Chapter 5 lighting and ignore any settings used with the Skydome device.

The upgrade guarantees:

- More realistic lighting with Lumen and Nanite.
- Parity with the UEFN TODM and future TODM updates.

This also affects UEFN projects that use multi-level instances, or multiple maps. To ensure that you can publish your island and reduce the possibility of running into problems, you need to convert all lighting in your additional levels.

## Default Level

You will always have a default level, which is what is loaded when you launch a session. You can change which level is the default level at any time through the **GameFeatureData** asset by doing the following:

1. From the **Content Browser**, double-click the **Game Feature Data** thumbnail. The Game Feature Data opens in a new window.

   [![Double clicking on the Game Feature Data thumbnail opens the Game Feature Data options.](https://dev.epicgames.com/community/api/documentation/image/8449d0af-bfbc-4c06-98cd-9c48c03757f6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8449d0af-bfbc-4c06-98cd-9c48c03757f6?resizing_type=fit)

   Game Feature Data thumbnail
2. In the **Details** panel, expand the **Experience Data**.

   [![Expanding the option provides a way to change which level becomes the default.](https://dev.epicgames.com/community/api/documentation/image/3ab191e3-35d0-4c26-81ba-37c410bd428e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ab191e3-35d0-4c26-81ba-37c410bd428e?resizing_type=fit)

   Experience Data
3. In the **Default Map** option, click the dropdown menu and select a level to promote to Default Map status.

   [![Select a different map from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/b35afb44-85ff-4c7d-806b-93fe57bbd9c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b35afb44-85ff-4c7d-806b-93fe57bbd9c6?resizing_type=fit)

   Default Map

By default, when you open a UEFN project the “default map” loads, but you can load any additional levels by:

1. Opening the **File** menu and selecting **Open Level…**

   [![Open different levels using this File menu option.](https://dev.epicgames.com/community/api/documentation/image/b072f30d-e511-4d6e-a761-e15a21239c1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b072f30d-e511-4d6e-a761-e15a21239c1c?resizing_type=fit)

   Open Level...

## Manual Lighting Upgrade

In order to upgrade the lighting on a particular level, it is recommended to open up all secondary levels that have legacy lighting and upgrade the TODM and Skydome devices individually. Once a map is loaded, you can convert the map and adjust the visuals to ensure the conversion is working properly for you.

### Time of Day Manager (TODM)

The easiest way to tell if a map is using legacy lighting is to look at the World Settings. To check your what TODM a map is using:

1. Open the **Window** menu and select **World Settings**. The World Settings panel opens next to the Details panel.

   [![Select World Settings from the Window menu.](https://dev.epicgames.com/community/api/documentation/image/c08a2090-161c-4178-ac07-2fa996865e57?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c08a2090-161c-4178-ac07-2fa996865e57?resizing_type=fit)

   Window menu
2. Scroll down to **Time of Day** > **World Time of Day Manager** and open the dropdown menu.

   [![](https://dev.epicgames.com/community/api/documentation/image/fc8c9f66-5cba-473d-b20e-b3f2bc79f3cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc8c9f66-5cba-473d-b20e-b3f2bc79f3cb?resizing_type=fit)

   World Time of Day Manager

   If the map is set to Day Night Cycle (Legacy), the map is using the Chapter 14 legacy world lighting. This TODM is being retired and must be replaced.

   [![If a map is set to Day Night Cycle (Legacy), the lighting is out of date.](https://dev.epicgames.com/community/api/documentation/image/8d785e26-b2c9-4d3a-a400-3f2c330830c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d785e26-b2c9-4d3a-a400-3f2c330830c3?resizing_type=fit)

   Legacy TODM
3. From the **World Time of Day Manager** dropdown menu, select **Day Night Cycle - Chapter 5**.

   [![Set the map to Chapter 5 TODM to upgrade your map's world lighting.](https://dev.epicgames.com/community/api/documentation/image/b11401f5-ed5f-497a-9e1b-717e8aa7c8fc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b11401f5-ed5f-497a-9e1b-717e8aa7c8fc?resizing_type=fit)

   Chapter 5 TODM
4. Click **Save**. Now the map is upgraded to the new TODM.

## Skydome and Day Sequence Devcie

If the legacy TODM was used in your map, you may also have old Skydome devices.  In which case it’s important to also upgrade your Skydome devices to the new [Day Sequence device](https://dev.epicgames.com/documentation/en-us/uefn/using-day-sequence-devices-in-unreal-editor-for-fortnite), since the Skydome device is not compatible with the latest Ch5 TODM.

To check if a map is using the Skydome device, do the following:

1. In the **Outliner**, type **Skydome** in the search bar to surface the device.

   [![Search for the Skydome device in the Outliner.](https://dev.epicgames.com/community/api/documentation/image/12bc4451-3bde-4de8-96f8-873711668293?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12bc4451-3bde-4de8-96f8-873711668293?resizing_type=fit)

   Search for the Skydome device in the Outliner.

For any Skydome devices being used, replace them with the Day Sequence devices.  You can find the Day Sequence device in the **Fortnite** > **Devices** > **Environment** folders in the content hierarchy of the Content Browser.

[![Replace all Skydome devices with the Day Sequence device.](https://dev.epicgames.com/community/api/documentation/image/9b0b7a95-6a96-4d0b-bd03-fd3e2b9e8156?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b0b7a95-6a96-4d0b-bd03-fd3e2b9e8156?resizing_type=fit)

Day Sequence device

Add any number of Day Sequence devices, and tweak the visuals to taste.

The parameters are different between the Skydome and Day Sequence devices, so it’s important to become familiar with the new features.  Please see the [Day Sequence device](https://dev.epicgames.com/documentation/en-us/uefn/using-day-sequence-devices-in-unreal-editor-for-fortnite) document for more details on creating world lighting.
