# Scary Space

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lego-scary-space-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:37:33.778496

---

Welcome to the **LEGO® Scary Space** project template! Experience a scary spaceship full of jump scares, then learn how to use devices and Verse code to create your own cosmic horror-themed game based on this unique project template.

## Playing Scary Space

When you play the Scary Space template, you play as a crewmember of a spaceship. This section will give you a basic walkthrough of the game, explaining the design intent and mechanics demonstrated for each sequence.

To create a project from the template, look for **Brand Templates** in the Project Browser, and select the **ScarySpace** template under **LEGO®**.

[![Select the Scary Space project template](https://dev.epicgames.com/community/api/documentation/image/33bf736b-ae55-4d2c-b812-8c9d9a543049?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/33bf736b-ae55-4d2c-b812-8c9d9a543049?resizing_type=fit)

When you open the project template in UEFN, click **Launch Session** to open the Fortnite client.

[![Click Launch Session to start playing the game.](https://dev.epicgames.com/community/api/documentation/image/5760e63e-f6ca-4b32-8949-ceb15a165885?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5760e63e-f6ca-4b32-8949-ceb15a165885?resizing_type=fit)

Depending on your editor preferences, the project will either launch the client in Play mode, or launch into the island in Create mode. If you are in Create mode, open the **Game Menu** and click the yellow **Start Game** button to start the game.

[![Click the Start Game button to start the game.](https://dev.epicgames.com/community/api/documentation/image/a3499f0c-3436-4e5b-99dd-f00cb8b236aa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3499f0c-3436-4e5b-99dd-f00cb8b236aa?resizing_type=fit)

### Control Room

A friendly robot will talk to you in the ship's Control Room, and set the scene as to why you are drifting in space on a spaceship. The robot tells you a meteor crashed into the ship, and recommends you go find the impact site to assess the damage.

[![Spaceship control room](https://dev.epicgames.com/community/api/documentation/image/aec5da4c-0f2c-4c79-9711-8e9ad72887fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aec5da4c-0f2c-4c79-9711-8e9ad72887fd?resizing_type=fit)

This intro sequence includes a cinematic and an NPC, and introduces the player to the world of the game. The scene was built using the Sequencer. You can find the **IntroSequence** asset in the **Sequences** folder of your project. There is also a Verse device, **intro\_manager\_device**, that controls player movement during the cutscene.

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# The purpose for this class is to lock the player movement during the intro cutscene and unlock it again after it ends.
intro_manager_device := class(creative_device):

    # The device delivering the gameplay event from the sequence.
    @editable
    TriggerDevice : trigger_device = trigger_device{}

    OnBegin<override>()<suspends>:void=
        Sleep(0.0)
        # Here the player is put into stasis (movement locked) until the gameplay event is activating the trigger device, where the player is then released from stasis.
        if(Character := GetPlayspace().GetPlayers()[0].GetFortCharacter[]):
            Character.PutInStasis(stasis_args{AllowFalling := true})
            TriggerDevice.TriggeredEvent.Await()
            Character.ReleaseFromStasis()
```

### Going Through the Hallways

You then move down a couple of hallways that take you toward the hangar, looking for the impact site. There are some surprises waiting for you in these hallways!

[![Hallway jump scare](https://dev.epicgames.com/community/api/documentation/image/10eb7653-9128-4f0a-a91d-c72bc4ddac36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10eb7653-9128-4f0a-a91d-c72bc4ddac36?resizing_type=fit)

In the first two hallways, you can see how to play with camera settings to set up the jump scares.

- **Sequence A:** In the first part, the camera is set closer to you to create a more intimate and intense play experience. This sequence uses the Mutator Zone and Orbit Camera devices to change the player's viewpoint.
- **Sequence B:** At the end of the first hallway, you will be surprised by one of the aliens who is looking in the window! This jump scare uses the Lock, Trigger, and Audio Player devices, and is controlled by the **hallway\_jump\_scare\_device** Verse device.

  ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { Utility }

        hallway_jump_scare_device := class(creative_device):

            # The editable attribute creates a reference which is assignable in the editor.
            @editable
            PlayerTrigger : trigger_device = trigger_device{}

            @editable
            LockDevice : lock_device = lock_device{}

            @editable
            ScaryProps : []creative_prop = array{}

            @editable
            StingerAudioPlayer : audio_player_device = audio_player_device{}

            @editable
            HallwayLight : customizable_light_device = customizable_light_device{}

            OnBegin<override>()<suspends>:void=
                ScaryProps.SetVisibility(false)

                # First step is waiting for the player to collide with the trigger and save agent to use for the lock device.
                MaybeAgent := PlayerTrigger.TriggeredEvent.Await()
                if (Agent := MaybeAgent?):
                    # First part: Initialize the jump scare by opening the door and start the playback of the audio stinger.
                    LockDevice.Open(Agent)
                    StingerAudioPlayer.Play()

                    # The wait here is for timing purposes.
                    Sleep(0.5)

                    # Second part: Show the prop and start closing the door.
                    ScaryProps.SetVisibility(true)
                    LockDevice.Close(Agent)

                    # Again we wait for timing purposes.
                    Sleep(1.8)

                    # Third part: Here we hide the prop, this way when the player reaches the door the hallway will look "normal" instead of containing a scary monster.
                    ScaryProps.SetVisibility(false)
                    Sleep(0.5)
                    HallwayLight.TurnOn()
  ```

### Into the Hangar

Finally, at the end of the second hallway you arrive at the hangar. Go through the sliding doors. Once you enter the hangar, the lights will go on one by one. Watch out – the aliens are keeping an eye on you! The alien eyes follow the player, again raising tension.

[![Alien eye in the hangar](https://dev.epicgames.com/community/api/documentation/image/2b302316-6690-4329-b42f-9f408fb1b3c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2b302316-6690-4329-b42f-9f408fb1b3c4?resizing_type=fit)

When you are close to the end of the hangar maze, a hand will reach out to get you!

[![Hangar jump scare](https://dev.epicgames.com/community/api/documentation/image/ae7e4d34-2a98-4fd1-a0ed-6e4668fefc6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae7e4d34-2a98-4fd1-a0ed-6e4668fefc6e?resizing_type=fit)

- **Sequence C:** The slow progression of lights turning on raises tension (from the slow pacing) but also provides relief (the previous darkness is replaced by light). This sequence uses Trigger devices to create events that enable the lights on a series of delays.
- The hangar has a maze-like layout, forcing you to navigate and explore the different space assets used in this template. These assets are available in the Content Browser, and also as Prefabs and Galleries in the Creative inventory.
- **Sequence D:** This sequence controls the alien eyes that follow the player. It uses a Trigger device to begin the sequence, but all other behavior is controlled by the **prop\_look\_at\_device** Verse device.

  ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Characters }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { Utility }

        prop_look_at_device := class(creative_device):

            # The editable attribute creates a reference which is assignable in the editor
            # The eye-flower prop that we are rotating
            @editable
            Prop : creative_prop = creative_prop{}

            @editable
            PlayerTrigger : trigger_device = trigger_device{}

            @editable
            CreakAudioPlayer : audio_player_device = audio_player_device{}

            DetectionThreshold : float = 800.0

            RotationInterval : float = 0.5

            OnBegin<override>()<suspends> : void =

                # Wait for the player to enter the room and trigger the PlayerTrigger
                PlayerTrigger.TriggeredEvent.Await()

                # The PlayerTrigger also engages the lights which are turned on with a delay. See "StorageRoom Light Sequence Billboard" in the editor for more information.
                # Therefore we wait 3 seconds until the lights are on before the plant rotates. This is for dramatic effect.
                Sleep(3.0)

                # Here we start the update coroutine checking the player position and rotating the prop towards them.
                UpdateProp()

            UpdateProp()<suspends>:void=

                    # To begin with the eye-flower prop does a dramatic 180 degree turn and plays an audio cue,
                    PropTransform := Prop.GetTransform()
                    PIRotation := PropTransform.Rotation.ApplyLocalRotationZ(PiFloat)
                    CreakAudioPlayer.Play()
                    Prop.MoveTo(PropTransform.Translation, PIRotation, 4.0)

                # Code in the loop below keeps looking for the player and rotates the prop towards them.
                loop:
                    # Get the transform for the player and check if the distance between them and the prop are below the "DetectionThreshold".
                    if(PlayerTransform := GetPlayspace().GetPlayers()[0].GetFortCharacter[].GetTransform(),
                        Distance(PlayerTransform.Translation, PropTransform.Translation) <= DetectionThreshold):
                            # Create the vector pointing from the prop to the player.
                            ToVector := PlayerTransform.Translation - PropTransform.Translation

                            # Create a rotation around the up or Z-axis aligning with the ToVector using the custom LookInDirection function.
                            ToRotation := LookInDirection(ToVector)

                            # Only move the prop and play the audio if the player's position has changed.
                            if (Distance(Prop.GetTransform().Rotation,ToRotation) <= 0.01):
                                CreakAudioPlayer.Stop()
                                Sleep(RotationInterval)
                            else:
                                #Play creaking audio
                                CreakAudioPlayer.Play()

                                # Create interpolated animation with the MoveTo function.
                                Prop.MoveTo(PropTransform.Translation, ToRotation, RotationInterval)

                    # If the player is too far away or leaves the game the code waits out the RotationInterval instead.
                    else:
                        Sleep(RotationInterval)
  ```
- **Sequence E**: At the end of the area is a jump scare. This scene was built using the Sequencer. You can find the **SkeletonArmTrapSequence** asset in the Sequences folder of your project.

### Cross-Section and Box Alien Chase

As you exit the hangar into an X-shaped intersection, a Box Alien will arrive in a short cinematic. Run fast! The alien will chase you as you navigate toward the meteor crash site.

[![Box  Alien chase](https://dev.epicgames.com/community/api/documentation/image/112f3fcc-f961-414d-9b0e-3a5ce79af639?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/112f3fcc-f961-414d-9b0e-3a5ce79af639?resizing_type=fit)

- **Sequence F**: This scene uses a cinematic, a Verse device, and a Sequence to create the action in the scene.
- The Box Alien is introduced with a short cinematic. This atmospheric appearance is another way to raise tension. The cinematic and Box Alien movement is created with the BoxChaseSequence built in the Sequencer. You can find the **BoxChaseSequence** asset in the Sequences folder of your project.
- After the cutscene, players have to immediately start moving away as the Box Alien will chase them. The players are knocked out if the Box Alien catches them, which means they have to restart the chase scene.
- After the cutscene, this scene is controlled by the **box\_chase\_device** Verse device.

  ```verse
        using { /Fortnite.com/Devices }
        using { /Fortnite.com/Characters }
        using { /Fortnite.com/Game }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        box_chase_device := class(creative_device):

            # The editable attribute creates a reference which is assignable in the editor.
            @editable
            SequenceDevice : cinematic_sequence_device = cinematic_sequence_device{}

            @editable
            PlayerTrigger : trigger_device = trigger_device{}

            @editable
            EndCinematicTrigger : trigger_device = trigger_device{}

            @editable
            MonsterProp : creative_prop = creative_prop{}

            @editable
            MonsterBreathingAudioPlayer : audio_player_device = audio_player_device{}

            OnBegin<override>()<suspends>:void=
                # Hide the monster to avoid players spotting it before intended.
                MonsterProp.Hide()
                # Get the Fortnite character of the player in order to lock their movement during the cutscene.
                Players := GetPlayspace().GetPlayers()
                if (Player := Players[0], Character := Player.GetFortCharacter[]):
                    loop:
                        # Wait for the player to engage the trigger placed in the level.
                        PlayerTrigger.TriggeredEvent.Await()
                        PlayerTrigger.Disable()
                        MonsterProp.Show()
                        # Start playing the sequence starting with the cutscene.
                        SequenceDevice.Play()
                        # Lock player movement during the cutscene.
                        Character.PutInStasis(stasis_args{})
                        EndCinematicTrigger.TriggeredEvent.Await()
                        # Unlock player movement.
                        Character.ReleaseFromStasis()
                        # Play back the audio of the monster's breathing sounds.
                        MonsterBreathingAudioPlayer.Play()
                        # Detect if the player is eliminated by the monster.
                        Character.EliminatedEvent().Await()
                        Sleep(3.0)
                        # Reset the chase setup to run again after the players respawns at the checkpoint.
                        SequenceDevice.GoToEndAndStop()
                        MonsterProp.Hide()
                        PlayerTrigger.Enable()
  ```

### Meteor Crash Site

Once you get to the meteor impact site, you must move to the top of the rock to enter a portal, which takes you to the final room where you find the Boss Alien. This is an exploratory area, which has no mechanics for interaction except the portal that leads to the final area. You can add mechanics here or make use of the environment to guide the player to the portal.

### Space Outdoors (Boss Area)

[![Final area with monolith](https://dev.epicgames.com/community/api/documentation/image/7dcbd3b6-b9b7-417a-b465-154b01eabb85?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7dcbd3b6-b9b7-417a-b465-154b01eabb85?resizing_type=fit)

The portal in the Meteor Crash Site takes you to an outdoor Space area. This final area has a showcase of different design elements that include:

- An ending cinematic that focuses on creepy Boss Alien Monolith made specifically for this template.
- The cinematic zooms out to show the eerie background and spinning staircases. These creepy spinning staircases and other elemental elements demonstrate how you can build tension and create an atmosphere of cosmic horror by showing familiar things that look or act in alien/weird ways.

The final area sequence is controlled by the **end\_game\_manager\_device** Verse device.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# The purpose for this class is to handle the event triggered by the EndingSequence and activate the end game device.
end_game_manager_device := class(creative_device):

    # The editable attribute creates a reference which is assignable in the editor.
    @editable
    TriggerDevice : trigger_device = trigger_device{}

    @editable
    EndGameDevice : end_game_device = end_game_device{}

    # The trigger device is triggered with a gameplay event from the EndingSequence.
    OnBegin<override>()<suspends>:void=
        TriggerDevice.TriggeredEvent.Await()
        if (Player := GetPlayspace().GetPlayers()[0]):
            # The end game device needs to receive an agent or player in order to end the game.
            EndGameDevice.Activate(Player)
```

## UEFN Outliner Organization

The Outliner in this project is organized in a very convenient way. Each area in the game is numbered in order, so the Outliner follows the flow of the game. Inside each area folder is a series of other folders that are always in the same, alphabetical Order:

- **Floor**
- **Lights**
- **Props**
- **Roof**
- **Setups**
- **Walls**

Some areas have additional folders that are specific to that area. These folders contain all the assets used in building that area.

The **Setups** folder contains the devices (including the Verse devices) that create the cinematics and action sequences for that area. You may want to number these sequence folders, or add a prefix with **A** through **F** to match the instructional billboards that describe how each sequence was built.

In addition to the folders matching the areas in the game, there are also the following folders:

- **Environment**: This folder contains the devices that provide the bounds of the entire level, and that create ambience for the areas outside the spaceship.
- **Settings**: This folder contains devices that control settings for the entire game, including the Island Settings device. It also includes three initial instruction Billboard devices (labeled "Call to Action Billboards").
- **TUTORIAL Jump Scare**: This folder contains materials for the Jump Scare Tutorial (see next section).

## Jump Scare Tutorial

This is an unfinished jump scare sequence that you can finish and customize for your project. The billboard provides a basic description, but there are more details in the comments of the Verse code for the sequence. Try adding this or other new jump scares at other points in the template!

The Billboard describing the jump scare tutorial labels the Verse device **unfinished\_jump\_scare\_device**, however, you can see in Verse Explorer that the actual name of the Verse device and its code is **tutorial\_jump\_scare\_device**.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { Utility }

# The jump scare will work by the player looking out the window, and as they do a scary prop will swoosh by and a sound will be played.
# It is implemented using the perception trigger, to make sure the player is looking where you want them to.
# Follow the instructions below and finish the code.

tutorial_jump_scare_device := class(creative_device):

    # In the outliner assign the devices and props needed. They are placed close to the creative device in the level.
    @editable
    PerceptionTrigger : perception_trigger_device = perception_trigger_device{}

    @editable
    ScaryProp : creative_prop = creative_prop{}

    @editable
    AudioPlayer : audio_player_device = audio_player_device{}

    # How fast should the prop's movement be?
    Duration : float = 1.0

    # How far should the prop move?
    MovementDistance : float = 700.0

    # Below the steps are outlined to make a jump scare where the box monster will fly fast past the window when the player is looking.
    # Fill in the code according to the instructions.
    OnBegin<override>()<suspends>:void=
        # 0.
        # Begin by hiding the scary prop so you don't spot it from other places.
        ScaryProp.Hide()

        # 1.
        # Start by waiting for the player to look at the perception trigger.
        # Look up the perception_trigger_device in the Fortnite.digest.verse or search for it to find the name of the event.

        # 2.
        # Play back audio.

        # 3.
        # The prop needs to be shown.

        # 4.
        # Create the movement of the prop using the MoveTo function. For the functions parameters use the Duration, VectorUp from the utility script and MovementDistance variables.

        # 5.
        # After the jump scare, hide the prop again to leave no trace.

        # 6.
        # Test that everything works as intended. Play around with the variable values and maybe find other places in the level where the jump scare could be used!
```

## Design Decisions and Tips

Here are some insights into the design intent for this project template to guide and inspire you when you use it to create your own game.

- The goal of this project template is to introduce you to event-driven systems in UEFN, using either devices or Verse.
- The overall mood for this project is a genre called **cosmic horror**. This genre emphasizes ultimate insignificance in the face of the vastness of the universe. It often uses weird, alien, or grotesque elements to instill this sense of smallness and terror.
- Jump scares are a common technique in many horror genres across media, so this project uses them as well. You can learn how to make your own jump scare by following the Tutorial Jump Scare. You can also modify, move, or delete the existing jump scares that are built into the project.
- Inspect the Verse devices and Verse code to see how it works, and see what you can copy or reuse in other areas. You can look at and edit the Verse code by going to the **Menu** bar and clicking **Verse > Verse Explorer**. This opens in a tab docked next to the Outliner. You can also open the project's Verse code in VSCode.

## On Your Own

Now that you've learned how to create a creepy, scary space game on your LEGO island, get out there and build your own scary stuff!

If you want to learn more about building LEGO islands, check out our [Building LEGO Islands](https://dev.epicgames.com/documentation/en-us/fortnite-creative/building-lego-islands-in-fortnite-creative) section in the Fortnite Creative documentation. Or you can explore the UEFN documentation to learn more about UEFN–[get started here](https://dev.epicgames.com/documentation/en-us/uefn/starting-out-in-unreal-editor-for-fortnite).
