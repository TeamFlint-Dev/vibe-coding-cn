# Using Patchwork in UEFN

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-fortnite-patchwork-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:15:55.562493

---

Just like in Fortnite Creative, you can use Fortnite Patchwork devices on your UEFN island. All Patchwork devices function the same way they do in Creative, with the same device options. The core differences between using Patchwork in UEFN and using it in Creative are how you connect cables, and how you can use Verse to enable and disable devices.

If you are not yet familiar with Patchwork, check out [Composing with Patchwork in Fortnite Creative](https://dev.epicgames.com/documentation/en-us/fortnite-creative/composing-with-patchwork-in-fortnite-creative). Here, there are several resources to help you get jamming and check out some cool examples for how to use Patchwork on your island.

## Finding Patchwork Devices in the Content Browser

You can search directly for the Patchwork devices in the Content Browser by the product name, **Patchwork**, or find all the Patchwork devices listed in the **Devices** folder.

[![Patchwork devices in the content browser](https://dev.epicgames.com/community/api/documentation/image/8afe10f5-145a-4913-adde-d399fee50c20?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8afe10f5-145a-4913-adde-d399fee50c20?resizing_type=fit)

## Setting Device Options through the Details Panel

All of the Patchwork devices have some level of options available in the Details panel; however, depending on the device, you may only be able to access the full options and play with the knobs in live edit mode.

In UEFN, there are a few things you can set up before launching Live Edit:

- Place the devices you want to use in the viewport.
- Set up and connect all devices with the **Audio/Note/Modulator Out** section in the Details panel.
- Place and connect any Speakers so you can hear the audio once the session starts.
- Place and configure the Music Manager to set shared settings, like tempo and key.

Once these are set, launch a Live Edit session to jam away! After you start a session, the audio can be heard in both Create and Play mode. If you want players to be able to manipulate Patchwork devices, make sure to add the Patchwork Tool through an Item Spawner or other means.

### Accessing the Patchwork Tool

The **Patchwork tool** is not available in UEFN. This is partially because of the way the UEFN interface is set up.

When you enter Create mode, the Patchwork tool is automatically equipped to your Quick Bar. If you are starting in Edit Mode, simply place a Patchwork device on your island and the Patchwork Tool will appear in your bar.

[![example showing edit mode in UEFN with patchwork tool](https://dev.epicgames.com/community/api/documentation/image/5bfa4a0f-3bb0-4c74-b9d8-c7279db97243?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5bfa4a0f-3bb0-4c74-b9d8-c7279db97243?resizing_type=fit)

You can uncheck **Auto Start Game** in the Launch Session dropdown to automatically start your session in Create mode.

[![uncheck auto start game](https://dev.epicgames.com/community/api/documentation/image/e4b96501-0f1a-43c3-a2c1-30f8f827546d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e4b96501-0f1a-43c3-a2c1-30f8f827546d?resizing_type=fit)

## Patching Devices

While editing in UEFN, you can patch devices together in the Details panel through the **User Options - Port Connections** section. You will need to select the cable and port connections. Additionally, when patching devices, the list of devices you can choose from is automatically curated for the devices that are compatible with each other.

As of now, when you patch devices together, the cables will not visually connect in the UEFN editor, and you will not hear any audio. You need to start a Live Edit session in Fortnite to see and hear that everything is working.

The example below uses a Drum Sequencer, a Drum Player, and a Speaker to make a basic beat.

[![beat example setup](https://dev.epicgames.com/community/api/documentation/image/323ab33e-c79a-44bb-86a7-57785f0ebb1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/323ab33e-c79a-44bb-86a7-57785f0ebb1b?resizing_type=fit)

To patch these devices together, start with the Drum Sequencer.

1. Select the Drum Sequencer. In the Details panel, go to the User Options - Port Connections section.

   [![drum sequencer details panel](https://dev.epicgames.com/community/api/documentation/image/10daceb7-1d5c-48da-bd02-c3c8fad79af0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10daceb7-1d5c-48da-bd02-c3c8fad79af0?resizing_type=fit)
2. Set the **Note Out** option by expanding the top dropdown. In this case, you are patching the Drum Sequencer cable to the Drum Player.

   [![patching the drum sequencer to the drum player](https://dev.epicgames.com/community/api/documentation/image/14cf9061-ccb4-4f6d-84c8-b6578a6885b3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14cf9061-ccb4-4f6d-84c8-b6578a6885b3?resizing_type=fit)
3. On the Drum Player, set the **Note Out** to Speaker, and the Port to **Audio Input Port 1**.

   [![patching the drum player to the speaker](https://dev.epicgames.com/community/api/documentation/image/6d508b74-04d9-4eb7-ae8d-18ed6b6b7491?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6d508b74-04d9-4eb7-ae8d-18ed6b6b7491?resizing_type=fit)
4. With the Speaker already connected to the Drum Player, it's ready to go!

## Syncing Music and Gameplay with Patchwork

Here is a really fun project made with Patchwork in UEFN:
