# Sequencer Cannonball Animations

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/party-game-3-sequencer-cannonball-animations-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:21:40.935461

---

[Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#sequencer) is used to animate the cannonball fire and a sinking raft. You’ll need to create a folder for all your animations in the main project folder, and name it **Sequences**.

[![Create a folder for your min-game animations and name it Sequences.](https://dev.epicgames.com/community/api/documentation/image/1e384002-8bd0-40cd-8180-8461e42c736c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e384002-8bd0-40cd-8180-8461e42c736c?resizing_type=fit)

You’ll need to create five different cannonball shots that hit and tilt the raft. These sequences play during the game, imitating cannon fire and possibly dunking players in the ocean.

## Create a Level Sequence

Level Sequences are created in the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser). Create your first Level Sequence by following the steps below.

1. Right-click in the **Content Browser**, and select **Cinematics** > **Level Sequence**.

   [![Right-click in the Content Browser and select Cinematic > Level Sequence.](https://dev.epicgames.com/community/api/documentation/image/b1b765bc-1cf4-4ebf-a0c7-d7ef62d84e53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1b765bc-1cf4-4ebf-a0c7-d7ef62d84e53?resizing_type=fit)
2. Name the thumbnail **Cannonball\_1**.

   [![Level Sequence thumbnail](https://dev.epicgames.com/community/api/documentation/image/7d29f39b-b5ab-42b9-bb5c-474872937b20?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d29f39b-b5ab-42b9-bb5c-474872937b20?resizing_type=fit)
3. Double-click the thumbnail to open Sequencer.
4. Select **Add+** > **Add to Sequencer** > **Cannonball** to add the Cannonball mesh to the sequence.

The cannonball is added to the Level Sequence. You’ll animate the cannonball’s trajectory toward the raft in the sequence.

[![The cannonball mesh is added to the level sequence.](https://dev.epicgames.com/community/api/documentation/image/e405a63c-7fe9-4337-81fc-47c9d6087610?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e405a63c-7fe9-4337-81fc-47c9d6087610?resizing_type=fit)

## Animate the Cannonball

To animate the cannonball, you’ll need to move the [Static Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#static-mesh) using the **Transform** tools in Sequencer. You can achieve this by slightly adjusting the cannonball’s [Axis](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#axis) settings and adding keyframes to the timeline.

To begin the animation, move the playhead marker forward in the timeline, and select the [keyframes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe) next to the cannonball’s **Axis**, **Rotation**, and **[Scale](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#scale)** settings. Keyframes created beyond this point will move the cannonball forward toward the raft until it collides with the raft.

[![Move the playhead marker forward in the timeline and clicking the keyframes next to the cannonball’s **Axis**, **Rotation**, and **Scale** settings.](https://dev.epicgames.com/community/api/documentation/image/19dd76a9-5866-43c8-97a8-6a6f964d53d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19dd76a9-5866-43c8-97a8-6a6f964d53d4?resizing_type=fit)

You can also use the [mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#mesh)’s [pivot points](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#pivot-point) to move the actor in the [viewport](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#viewport) to create Transform location keyframes in Sequencer.

You’ll need to create four more animations for each cannonball hitting different parts of the raft.

## Animate the Raft

To animate the raft, the Cannonball must hit the raft, which detonates the explosive device and causes the parent [prop](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prop) to move. Detonating the Explosive device is achieved by adding a [Gameplay Event](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-events-in-sequencer-in-unreal-editor-for-fortnite) to the device in Sequencer.

In Sequencer:

1. Select **Add+** > **Add to Sequencer** > **Cannonball**.
2. Select **Add+** > **Add to Sequencer** > **Explosive Device**.
3. Select **Add+** > **Add to Sequencer** > **VFX Device**.
4. Select **Add+** > **Add to Sequencer** > **Parent Floor Prop**.

All the necessary [Actors](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#actor) are added to the track. Now you’ll need to animate each Actor individually in the track starting with the cannonball.

1. Select the plus (**+**) icon next to Cannonball and select **Transform**.

   [![Select the **+** icon next to Cannonball and select Transform.](https://dev.epicgames.com/community/api/documentation/image/315d2809-e86c-4567-a58c-d2be5100d616?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/315d2809-e86c-4567-a58c-d2be5100d616?resizing_type=fit)
2. Move the playhead marker to **0015**.
3. Select the **keyframe** icon to set the first keyframe for the cannonball. This determines the starting point in the animation for the cannonball.
4. Move the cannonball down towards the raft by the central point on the cannonball's central pivot point.

   [![The central pivot point of the cannonball.](https://dev.epicgames.com/community/api/documentation/image/5d60214f-7dca-4b0d-a824-f2c5f34edcd8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d60214f-7dca-4b0d-a824-f2c5f34edcd8?resizing_type=fit)
5. Move the playhead marker to **0030**.
6. Select the **keyframe** icon to set the second keyframe for the cannonball.

Continue to move the playhead marker forward in the timeline by 15 seconds. Move the cannonball down towards the raft in small increments, and set a keyframe for each cannonball movement until the cannonball makes contact with the raft.

Once the cannonball makes contact with the raft, you’ll create a Gameplay Event for the Explosive device. Gameplay Events act as triggers in Sequencer to cause an event to happen to a specific device Actor in the viewport.

1. On the **Explosive Device** track, select the plus (**+**), and then select **Gameplay Event** from the dropdown menu. A Gameplay Events track is added under the Explosive device.

   [![Add a Gameplay Event through the track menu.](https://dev.epicgames.com/community/api/documentation/image/8083b01b-be3c-472e-93e0-223c3d1076db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8083b01b-be3c-472e-93e0-223c3d1076db?resizing_type=fit)
2. Move the playhead marker to the keyframe where the cannonball makes contact with the raft.
3. Select the **keyframe** icon next to the Gameplay Event. This sets the first keyframe for the Explosive device event.
4. Right-click on the **keyframe** in the timeline, and select **Properties** > **Gameplay Event Function** > **Explode**. When this time is reached in the level sequence, the explosive device explodes.

   [![Select an event to trigger at the selected time.](https://dev.epicgames.com/community/api/documentation/image/4adc4d2e-3d32-4924-a93c-cf47cd0790a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4adc4d2e-3d32-4924-a93c-cf47cd0790a9?resizing_type=fit)

   *Click image to enlarge.*
5. Move the playhead marker forward by **60 seconds**.
6. Set a second keyframe for the Gameplay Event.
7. Right-click on the **keyframe** in the timeline and select **Properties** > **Gameplay Event Function** > **Reset**. At this point in the level sequence, the explosive device resets, , which makes it possible to play this animation again.

Add a **Transform** track to the **Parent Floor Prop**, and roll the raft towards the cannonball’s impact.

1. Select the plus (**+**) icon next to Parent Floor Prop, and select **Transform** from the track dropdown menu.

   [![Select Transform from the track dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/f05dfeeb-5229-4d66-93e4-3838e76812ee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f05dfeeb-5229-4d66-93e4-3838e76812ee?resizing_type=fit)
2. Move the playhead marker to the Explosive devices’s explode marker.
3. Select the **keyframe** icon to set the first keyframe for the raft. This determines the starting point in the animation for the raft.
4. Roll the raft towards the cannonball’s point of impact by dragging the roll setting or setting Roll to **-15.00 degrees**.
5. Move the playhead marker ahead by **60 seconds**.
6. Select the **key frame** icon to set the second key frame for the raft.

Drag the playhead marker along the timeline to play the animation. The raft should tilt after the cannonball strikes the raft, and the Explosive device detonates. Save your changes and add the animation to the first Cinematic Sequence device named **Cannonball 1**.

Repeat this process to animate four more cannonballs hitting the raft in various places.

## Play the Cannonball Animations In-Game

To play the cannonball animations during the game you’ll need to set up a series of triggers and cinematic sequence devices.

**Devices used**:

- **[7 x Trigger Controls](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)**
- [5 x Cinematic Sequence](https://dev.epicgames.com/documentation/en-us/fortnite/using-cinematic-sequence-device-in-unreal-editor-for-fortnite)

### Triggers 1-7

For this animation you need seven triggers - five for explosions and two for resets.

Create the first [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative), and copy it until you have seven.

Rename five of the Triggers **Explode Trigger 1-5**, this lets you know which Trigger is responsible for activating the explosions of the five cannonballs.

Lasty, change the remaining two Trigger names to **Reset 1** and **Reset 2**. The Reset Triggers are going to play the launch cannonball animation from the ships.

| Option | Value | Explanation |
| --- | --- | --- |
| **Visible in Game** | False | Triggers don’t need to be visible. |
| **Triggered by Player** | False | Trigger isn’t activated by players. |
| **Triggered by Vehicle** | False | Trigger isn’t activated by vehicles. |
| **Triggered by Sequencers** | False | Trigger isn’t activated by sequencers. |
| **Triggered by Water** | False | Trigger isn’t activated by water. |
| **Trigger VFX** | False | VFX are not necessary. |
| **Trigger SFX** | False | SFX are not necessary. |

### Cinematic Sequence

Create and copy the first Cinematic Sequence. Rename five of the cinematic sequencers **Cannonball 1-5** to let you know which cinematic sequence is responsible for playing the explosions of the five cannonballs.

## Next Section

[![Reusable Game Manager](https://dev.epicgames.com/community/api/documentation/image/e1910925-deab-48bf-af7e-f1ec24aff97a?resizing_type=fit&width=640&height=640)

Reusable Game Manager

Create a reusable game manager to control vital gameplay elements for your mini-game island.](https://dev.epicgames.com/documentation/en-us/fortnite/party-game-4-reusable-game-manager-in-unreal-editor-for-fortnite)
