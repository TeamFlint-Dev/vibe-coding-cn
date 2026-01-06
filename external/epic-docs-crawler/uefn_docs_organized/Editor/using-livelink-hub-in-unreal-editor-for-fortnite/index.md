# Using LiveLink Hub

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:05:15.323667

---

**LiveLink Hub** is a standalone executable that launches as a separate process on your workstation. Through LiveLink Hub, you can stream the data from your motion capture recording system to UEFN.

Use **LiveLink Hub** to capture data from your motion capture recording system to use as animations for your FN Mannequin characters, then use these animations to create movements that match your NPC's personality and theme.

You can then use the **[Take Recorder](https://dev.epicgames.com/documentation/en-us/unreal-engine/BlueprintAPI/VirtualCamera/TakeRecorder?application_version=5.5)** to record the live animation captured in LiveLink Hub.

[![](https://dev.epicgames.com/community/api/documentation/image/d9df66c8-e5da-4e92-92a0-0220df635381?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9df66c8-e5da-4e92-92a0-0220df635381?resizing_type=fit)

To launch LiveLink Hub, navigate to **Tools** > **LiveLink Hub**.

See the [LiveLink Hub tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite) to go through the steps of using this tool.

## Using LiveLink Hub

Below is an explanation of LiveLink Hub's features and tools. LiveLink Hub has an overall taskbar to record your animation, along with three panels, broken down into corresponding numbers below.

[![](https://dev.epicgames.com/community/api/documentation/image/298332ae-3415-41b5-8258-23d19757cc1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/298332ae-3415-41b5-8258-23d19757cc1f?resizing_type=fit)

1. [Record Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite#record-button)
2. [Timecode Bar](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite#timecode-bar)
3. [Sources Panel](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite#sources-panel)
4. [Subjects Panel](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite#subjects-panel)
5. [Clients Panel](https://dev.epicgames.com/documentation/en-us/fortnite/using-livelink-hub-in-unreal-editor-for-fortnite#clients-panel)

### Record Button

Use this button to record and save your live animations. Click **Record** to record your animation and click again to save it.

### Timecode Bar

This bar shows the timecode for the data captured from your motion capture recording system.

[![](https://dev.epicgames.com/community/api/documentation/image/3afab1c4-6aa7-4022-a9fd-8401d694c8ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3afab1c4-6aa7-4022-a9fd-8401d694c8ed?resizing_type=fit)

Select the dropdown box to change the system time to either 24, 30, or 60 fps.

### Sources Panel

This panel shows the devices on your computer or network that will stream animation into UEFN. You can note your motion capture system source type, source machine, and status.

[![](https://dev.epicgames.com/community/api/documentation/image/1b3a230a-c6c5-4cfd-abf7-01b19b1082d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1b3a230a-c6c5-4cfd-abf7-01b19b1082d9?resizing_type=fit)

In the **Sources** Panel, click **Add Source** to choose between the following LiveLink Sources:

- Apple ARKit Source
- LiveLinkInputDevice Source
- Message Bus Source
- Mocopi LiveLink
- Pose AI App
- Rokoko Studio Source
- 1Vicon Data Stream Source

### Subjects Panel

This holds animation subjects, which are individual characters or objects that are being streamed.

### Clients Panel

This panel displays the UE/UEFN sessions open on your computer or accessible on your network. By default, **LiveLink Hub** will automatically connect to and start streaming animation data to your UEFN session.

This tutorial will walk you through setting up your project to capture and record animations on a FN Mannequin character. These can then be used on a Fortnite character for the [**Character**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-character-devices-in-fortnite-creative) device.

You will first create an [**Inverse Kinematics (IK) Rig**](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-ik-rig?application_version=5.4) from an imported skeletal mesh asset for FN Mannequin. IK Rigs are used for manipulating areas on skeletal meshes to create animations.

Then, stream your motion capture data into the **LiveLink Hub** to then record it to use in your gameplay and cinematics. **LiveLink Hub** is a tool that provides a common interface for streaming animation data into UEFN.

[![Island Templates](https://dev.epicgames.com/community/api/documentation/image/5b7a190a-6c17-4cf9-a5c4-9b3f7c2994d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b7a190a-6c17-4cf9-a5c4-9b3f7c2994d7?resizing_type=fit)

Before starting this tutorial, create a project from the **Animation** template located in the **Feature Examples** section of the **Project Browser**.

[![Gameplay](https://dev.epicgames.com/community/api/documentation/image/8f01fb0a-2276-47a7-8439-fec11e458e9d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f01fb0a-2276-47a7-8439-fec11e458e9d?resizing_type=fit)

## Create an IK Rig

Follow the steps below to create an IK Rig from an imported skeletal mesh asset.

1. In your project's **Content Browser**, navigate to your project's folder.
2. Right-click on your project folder, select **New Folder**, and name the mocopi import as "Mocopi".

   [![New Folder](https://dev.epicgames.com/community/api/documentation/image/c8f416aa-4072-436a-961d-393b98d37da4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8f416aa-4072-436a-961d-393b98d37da4?resizing_type=fit)
3. Visit the [Epic Games Box site](https://epicgames.ent.box.com/s/znq8n2bpfc09zcp96sln9wn1cw8wzrq3) to download the mocopi skeletal mesh asset.
4. Once downloaded, select **Import** from the **Content Browser** toolbar, and select your downloaded mocopi asset.

   [![Import](https://dev.epicgames.com/community/api/documentation/image/ce4e4a2d-0dc7-46dc-9aee-a6a002067550?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce4e4a2d-0dc7-46dc-9aee-a6a002067550?resizing_type=fit)
5. Make sure the **Skeleton** field is empty when importing the .fbx file, then select **Import All**.

   [![FBX Import](https://dev.epicgames.com/community/api/documentation/image/ecbd3710-82c5-440d-a946-a3e0fa473c64?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecbd3710-82c5-440d-a946-a3e0fa473c64?resizing_type=fit)
6. Take note of the assets created.

   [![Mocopi Assets](https://dev.epicgames.com/community/api/documentation/image/7010a00f-d79a-4619-800a-4a6fc36547d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7010a00f-d79a-4619-800a-4a6fc36547d3?resizing_type=fit)
7. In the **Content Browser** locate your Mocopi assets and right-click on the "MocopiMannequin" skeletal mesh. Navigate to **Create** > **IK Rig**.

   [![Create IK Rig](https://dev.epicgames.com/community/api/documentation/image/0cf04040-185d-43e3-957d-09bc0e548b96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0cf04040-185d-43e3-957d-09bc0e548b96?resizing_type=fit)
8. Double-click on the new IK Rig asset "IK\_Mocopi Mannequin" to open the asset window.

   [![New IK Rig](https://dev.epicgames.com/community/api/documentation/image/0d89c085-10ec-4266-8616-0e9c08661e54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d89c085-10ec-4266-8616-0e9c08661e54?resizing_type=fit)
9. In the new window, click **Auto Create Retarget Chains**, then **Auto Create IK**, and save the asset.

   [![Auto IK](https://dev.epicgames.com/community/api/documentation/image/ca4486da-9519-4be4-aa5a-105921034b52?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca4486da-9519-4be4-aa5a-105921034b52?resizing_type=fit)

   The Mocopi skeleton will be the only asset recognized by UEFN.

[![Post Auto IK](https://dev.epicgames.com/community/api/documentation/image/1cdc0bb2-294d-4f2c-9f7f-f095da6a40c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1cdc0bb2-294d-4f2c-9f7f-f095da6a40c6?resizing_type=fit)

These two actions will create the FK Chains and IK Effectors needed for a full body solve.

1. Next, in the **Content Browser**, right-click on the new IK Rig asset, "IK\_Mocopi Mannequin", and select **Create IK Retargeter**.

   [![Creating Retargeter](https://dev.epicgames.com/community/api/documentation/image/2be44a73-479f-4a83-a98f-397372fefb7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2be44a73-479f-4a83-a98f-397372fefb7d?resizing_type=fit)
2. Double-click on the IK Retargeter asset you just created.

   [![New IK Retargeter](https://dev.epicgames.com/community/api/documentation/image/895154c9-c0bb-4502-917a-8dcf3adab11c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/895154c9-c0bb-4502-917a-8dcf3adab11c?resizing_type=fit)
3. In the **Details** panel of the new window, open the **Target IKRig Asset** dropdown then select "IK\_FN\_Mannequin".

   [![IK Mannequin](https://dev.epicgames.com/community/api/documentation/image/4ba6c73f-ee9a-4bf4-812d-2eaf346831d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ba6c73f-ee9a-4bf4-812d-2eaf346831d0?resizing_type=fit)
4. In the **Viewport** toolbar, click **Running Retarget** to turn the retarget asset into **Edit Retarget Pose**.
5. Navigate to the **Auto Align** dropdown and select **Align All Bones**.

   [![Align Bones](https://dev.epicgames.com/community/api/documentation/image/7a6d152c-3349-44bf-ad5d-fcd055772138?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a6d152c-3349-44bf-ad5d-fcd055772138?resizing_type=fit)
6. Save your asset.

   [![Aligned Bones](https://dev.epicgames.com/community/api/documentation/image/dd4afd0f-6ad2-4aa4-9fe4-83254b42445a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd4afd0f-6ad2-4aa4-9fe4-83254b42445a?resizing_type=fit)

You should now see the two sets of bones line up with each other. You can take this a step further by [retargeting](https://dev.epicgames.com/documentation/en-us/unreal-engine/ik-rig-animation-retargeting-in-unreal-engine?application_version=5.3) the source and target skeletons's base rotations.

Next, bring the live animation data into UEFN through LiveLinkHub.

## Streaming into LiveLinkHub

Follow the steps below to import your asset as an animation. This example uses a Sony mocopi motion capture system.

[![LiveLink Hub](https://dev.epicgames.com/community/api/documentation/image/0022448a-cf61-4178-b9bd-051dec49170f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0022448a-cf61-4178-b9bd-051dec49170f?resizing_type=fit)

1. Navigate to **Tools** > **LiveLink Hub** to access the LiveLink Hub.
2. Add the mocopi source into LiveLink Hub by selecting **Add Source** < **Mocopi LiveLink** < **Create Mocopi Source**.
3. After the mocopi source has been added, you will see a new subject added in the **Subjects** panel. A green icon beside the subject indicates a healthy subject. A yellow icon indicates stale data that is not currently active.

   [![Mocopi Connected](https://dev.epicgames.com/community/api/documentation/image/60abb3af-1792-4fa2-a652-5b4869e9f36a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60abb3af-1792-4fa2-a652-5b4869e9f36a?resizing_type=fit)
4. In your UEFN session, drag the MocopiMannequin skeletal mesh into your level.

   1. Take note of the LiveLink Hub connected message in the bottom toolbar of UEFN.
5. Next, add the FN\_Mannequin to the next level.

   [![FN Mannequin](https://dev.epicgames.com/community/api/documentation/image/1c8c6a6f-61f2-40b9-9a8d-39edbdb591bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c8c6a6f-61f2-40b9-9a8d-39edbdb591bd?resizing_type=fit)
6. Select the MocopiMannequin in the **Outliner** or **Viewport**.
7. In the **Details** panel, click **Add**, then type "Performer Component".

   [![FN Mannequin](https://dev.epicgames.com/community/api/documentation/image/93f3611e-866a-4516-b59d-d9880581d67e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93f3611e-866a-4516-b59d-d9880581d67e?resizing_type=fit)
8. Select the new Performer Component. In the **Subject Name** field, select your MocopiSkeleton subject.

In the **Viewport**, you will now see your motion capture applied to the MocopiMannequin.

[![Moving Mocap](https://dev.epicgames.com/community/api/documentation/image/4717adf0-26cb-4d51-a67c-3a03f92559ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4717adf0-26cb-4d51-a67c-3a03f92559ef?resizing_type=fit)

1. Next, select the FN\_Mannequin in the **Viewport** or **Outliner**.
2. In the **Details** panel, click **Add** then type "Retarget Component".

   [![FN Mannequin](https://dev.epicgames.com/community/api/documentation/image/2c90beff-6d64-491e-9df2-19463543a5a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c90beff-6d64-491e-9df2-19463543a5a1?resizing_type=fit)
3. Select the new retarget component then open the Retarget Asset dropdown, and select the RTG\_MocopiMannequin you previously created.

   [![Select Retarget Asset](https://dev.epicgames.com/community/api/documentation/image/01038cdf-c5aa-4fa6-b065-cbb137148a46?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01038cdf-c5aa-4fa6-b065-cbb137148a46?resizing_type=fit)
4. In the **Details** panel, open the Source Skeleton Mesh Component, then choose the SkeletalMesh under MocopiMannequin from the drop-down menu.

   [![Set Source Mesh](https://dev.epicgames.com/community/api/documentation/image/b3e943fe-c89a-43aa-8247-4439534f3bcf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3e943fe-c89a-43aa-8247-4439534f3bcf?resizing_type=fit)
5. In the **Viewport**, you will now see animation from both the MocopiMannequin and FN\_Mannequin mesh.

   [![Moving Mocap](https://dev.epicgames.com/community/api/documentation/image/0a2d5286-26e8-4795-9f29-dfbfc528fc7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a2d5286-26e8-4795-9f29-dfbfc528fc7a?resizing_type=fit)

## Synchronizing Timecodes

In the steps below, you will set the UEFN timecode rate from LiveLinkHub. This will ensure your animations are recorded at the correct frame rate.

1. In the LiveLink Hub, click on the timecode dropdown.
2. Check **Enable Timecode Source** and set the Timecode Provider to SystemTime to 30fps.

   [![Time Code](https://dev.epicgames.com/community/api/documentation/image/2aff254c-11b1-4235-9a64-bf95115db557?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2aff254c-11b1-4235-9a64-bf95115db557?resizing_type=fit)

[![Green Time Code](https://dev.epicgames.com/community/api/documentation/image/1d05a218-1efd-4fda-a165-52cafce9828d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d05a218-1efd-4fda-a165-52cafce9828d?resizing_type=fit)

LiveLink will display the timecode as 30fps, the time, and a green icon to indicate that the timecode is being sent to UEFN.

## Recording Animation

In the steps below, you will capture an animation sequence on a FN Mannequin character to apply to a Fortnite character for the **Character** device.

1. In the UEFN toolbar, navigate to **Window** > **Cinematics** > [**Take Recorder**](https://dev.epicgames.com/documentation/en-us/unreal-engine/recording-animation-using-take-recorder-in-unreal-engine?application_version=5.3).

   [![Open Take Recorder](https://dev.epicgames.com/community/api/documentation/image/60f0adb7-61f4-421b-a994-efb57044d23d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/60f0adb7-61f4-421b-a994-efb57044d23d?resizing_type=fit)
2. From the **Outliner**, drag the FN Mannequin into the **Take Recorder**.

   [![Edit Retargeter Pose](https://dev.epicgames.com/community/api/documentation/image/b3cfe1a4-77f1-4734-9871-172ee05cb33a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3cfe1a4-77f1-4734-9871-172ee05cb33a?resizing_type=fit)
3. Press the record icon to start recording your animation.

   [![Start Recording](https://dev.epicgames.com/community/api/documentation/image/a30477aa-e366-465c-adac-a276e8464d1a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a30477aa-e366-465c-adac-a276e8464d1a?resizing_type=fit)
4. Next, press the film icon to review the last recording.

   [![Review Last Take](https://dev.epicgames.com/community/api/documentation/image/f36103d3-1550-4138-8e6e-2a34ed8c0bd9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f36103d3-1550-4138-8e6e-2a34ed8c0bd9?resizing_type=fit)
5. Press the record icon again to end the recording.

   [![Stop Recording](https://dev.epicgames.com/community/api/documentation/image/1167287d-7e70-485f-affe-ad6993c82e54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1167287d-7e70-485f-affe-ad6993c82e54?resizing_type=fit)
6. Select the icon to review the last recording to see your animation.

   [![Scrub Take Recorder](https://dev.epicgames.com/community/api/documentation/image/38a88629-5288-40d8-8811-dcd68beed97f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38a88629-5288-40d8-8811-dcd68beed97f?resizing_type=fit)

Your recorded level sequence will now load for you to review.

[![Animation Sequence](https://dev.epicgames.com/community/api/documentation/image/542aca41-6905-4184-8ab7-774e0cb78f10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/542aca41-6905-4184-8ab7-774e0cb78f10?resizing_type=fit)

Your character will continue to animate as if it has not been recorded. The end result will be an animation sequence on the Fortnite mannequin character, which you can apply to the Character device.
