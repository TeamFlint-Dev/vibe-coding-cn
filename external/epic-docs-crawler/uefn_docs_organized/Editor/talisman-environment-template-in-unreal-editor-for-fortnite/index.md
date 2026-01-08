# Talisman Environment Template

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:06:06.008247

---

This page is a companion to the **Talisman: Environment** template, which showcases the best practices for creating highly detailed, realistic environments. The Talisman is created using modular construction and optimization best practices in Unreal Editor for Fortnite (UEFN).

You can find the template in the **Feature Examples** section of the **Project Browser**.

You can play the Talisman experience shown during the 2024 Game Developers Conference by opening Fortnite and entering island code **7100-3544-3074**.

[![Talisman: Environment in the Project Browser](https://dev.epicgames.com/community/api/documentation/image/f2a90e56-bd96-40ff-91fc-e897f55af2f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2a90e56-bd96-40ff-91fc-e897f55af2f7?resizing_type=fit)

*Location of the Talisman: Environment template in the Project Browser.*

This overview walks you through the optimization challenges faced during the creation of the Talisman project and how each challenge was overcome:

- [Managing Project and Runtime Memory Limits](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#managing-project-and-runtime-memory-limits)
- [Using Custom UI Elements](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#using-custom-ui-elements)
- [Lighting Large Spaces](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#lighting-large-spaces)
- [Mesh Design and Construction](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#mesh-design-and-construction)
- [Designing Materials using Dynamic Material Control](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#designing-materials-using-dynamic-material-control)
- [Using the Orbit Camera Device](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#using-the-orbit-camera-device)

Because the template is designed to run on all available platforms, the assets and style of the Talisman has to conform to [UEFN’s memory and project size limit requirements](https://dev.epicgames.com/documentation/en-us/fortnite/memory-and-optimization-in-unreal-editor-for-fortnite). This creates several challenges for projects designed with a more detailed art style:

- Project size: High-detail assets in games can be large and UEFN has a 400 MB project size limitation.
- Runtime memory limits: UEFN has a 100,000 memory unit streaming memory restriction that limits the amount of assets, custom landscapes, and devices that can be on the screen at one time.
- Quality on all supported platforms: These limits ensure that your UEFN experience is available to all players on all Fortnite-supported platforms.

UEFN supports a variety of techniques to meet these requirements, including [Levels of Detail(LODs)](https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite), [Hierarchical Levels of Detail (HLODs)](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite), [World Partition](https://dev.epicgames.com/documentation/en-us/fortnite/world-partition), [Level Instancing](https://dev.epicgames.com/documentation/unreal-engine/level-instancing-in-unreal-engine), and [Data Layers](https://dev.epicgames.com/documentation/uefn/streaming-and-hlods-in-unreal-editor-for-fortnite).

## Applying Best Practices

The Talisman: Environment template is designed to showcase a variety of best practices and processes to bring AAA realism to Unreal Editor for Fortnite. This template uses the following best practices to manage project and streaming memory to optimize performance:

- Create custom content that is modular and lightweight.
- Improve the look of hard surface geometry using face weighted normals.
- Add detail to meshes using Mesh Decals.
- Build your experience for the lowest end target platform and add features from there.
- Minimize draw calls on non-Nanite meshes.

### Create Custom Content that is Modular and Lightweight

The Talisman environment was built using kitbashing, a modular modeling technique that uses preexisting meshes from a modular environment and repurposing them to create new assets. By reusing assets, the artists were able to decrease the project size by minimizing the number of single use meshes.

[![Talisman Mid Poly Asset](https://dev.epicgames.com/community/api/documentation/image/6c0296dd-62e9-430b-82ac-9935d47d69c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c0296dd-62e9-430b-82ac-9935d47d69c2?resizing_type=fit)

*This asset is made of six different static meshes.*

Traditionally, artists create this type of environment by mapping a high detail, high polygon mesh onto a low polygon mesh using unique baked [normal maps](https://en.wikipedia.org/wiki/Normal_mapping) to preserve the detail between the two. This method requires additional texture maps that can increase the size of your project, are expensive at runtime, and do not scale well during the kitbashing process.

Mid-poly meshes with face weighted normals were used to save memory, and [Mesh Decals](https://www.youtube.com/watch?v=Aihha0sAOJI) were used to add small details.

For more information, see [Mesh Design and Construction](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#mesh-design-and-construction).

### Build Your Experience for All Target Platform

Fortnite is designed to run on a variety of platforms. To make sure that your content gives players the best experience on each of these devices, it is important to design with every platform in mind, and then add additional features for high end platforms during development.

For example, [Nanite virtualized geometry](https://dev.epicgames.com/documentation/en-us/unreal-engine/nanite-virtualized-geometry-in-unreal-engine) helps platforms render highly detailed meshes and improve performance, but is only available to certain high end devices such as PCs running DirectX 12. Because of this, it is still important to optimize your content so that it will perform well on all platforms.

The following images show Mesh LODs at Epic, High, Medium, and Low settings.

[![Epic Settings](https://dev.epicgames.com/community/api/documentation/image/37146992-b72f-4938-af25-663df3d0da92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/37146992-b72f-4938-af25-663df3d0da92?resizing_type=fit)

Epic settings

[![High Settings](https://dev.epicgames.com/community/api/documentation/image/166cdfb7-e4bd-4767-95b7-de4bcf83358f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/166cdfb7-e4bd-4767-95b7-de4bcf83358f?resizing_type=fit)

High settings

[![Medium Settings](https://dev.epicgames.com/community/api/documentation/image/121a4bd4-8012-43c4-91ec-2e215deeb808?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/121a4bd4-8012-43c4-91ec-2e215deeb808?resizing_type=fit)

Medium settings

[![Low Settings](https://dev.epicgames.com/community/api/documentation/image/50ea32bf-6211-4b66-b337-099e30dc6728?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50ea32bf-6211-4b66-b337-099e30dc6728?resizing_type=fit)

Low settings

For more information on creating your own custom assets for UEFN, see [Mesh Design and Construction](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-environment-template-in-unreal-editor-for-fortnite#mesh-design-and-construction).

### Minimize Draw Calls When Using Non-Nanite Meshes

[Draw calls](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#draw-call) are the process of telling the graphics API what to draw and how to draw it during each frame. Nanite bypasses standard draw calls by streaming geometry into the scene as needed. For non-Nanite meshes, each of the following initiates a draw call in a scene:

- Every individual mesh.
- Each material on a mesh.
- Every light.
- Every shadow cast.

The Talisman: Environment template uses both [Nanite](https://dev.epicgames.com/documentation/unreal-engine/nanite-virtualized-geometry-in-unreal-engine) and non-Nanite meshes. To optimize the performance while using non-Nanite meshes, the number of draw calls in the scene was minimized by:

- Removing non-critical meshes.
- Removing non-critical mesh decals.
- Removing shadow-casting lights and supplementing them using [light functions](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-light-functions-in-unreal-engine?application_version=5.4).

## Managing Project and Runtime Memory Limits

Runtime [memory management](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite) and managing project size are key components of any project made in UEFN. The Talisman: Environment tackles these challenges by:

- Narrowing the project scope.
- Reusing custom assets.
- Managing runtime memory.

### Narrow project scope

To meet the 400 MB project size limit, the MetaHuman character has been moved to the Talisman: MetaHuman template. You can find this template in the **Feature Examples** section of the **Project Browser**. To learn about MetaHumans in UEFN, see [Talisman: MetaHuman template](https://dev.epicgames.com/documentation/en-us/fortnite/talisman-metahuman-template-in-unreal-editor-for-fortnite).

### Levels of detail

Each mesh used to build the Talisman uses three [Levels of Detail (LODs)](https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite) to keep the project within the 100,000 streaming memory unit budget.

[![Static Mesh Levels of Detail](https://dev.epicgames.com/community/api/documentation/image/ad5949b9-5c0f-4bce-a1d3-545e9e2f2c59?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad5949b9-5c0f-4bce-a1d3-545e9e2f2c59?resizing_type=fit)

*The automatic LOD settings are located in the Static Mesh browser.*

The LOD meshes are auto-generated using UEFN’s automatic LOD tools and are assigned to specific quality levels. For more information on using Levels of Detail in UEFN, see [Setting the Level of Detail](https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite).

### Management of Runtime Memory

The Talisman: Environment template uses a custom streaming solution created using [Data Layers](https://dev.epicgames.com/documentation/unreal-engine/world-partition---data-layers-in-unreal-engine) and [Sequencer](https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-sequencer-movie-tool-overview) to keep the level within the 100,000 memory unit streaming budget. The vertical size of areas like the Cargo area and the length of the hallways meant that the ship did not fit within the [World Partition](https://dev.epicgames.com/documentation/en-us/fortnite/world-partition) streaming grid.

[![Talisman Environment Data Layers](https://dev.epicgames.com/community/api/documentation/image/2804af30-ff88-49cd-9cb8-36d79473e6a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2804af30-ff88-49cd-9cb8-36d79473e6a5?resizing_type=fit)

*Each data layer corresponds to a different room on the Talisman.*

To overcome this limitation, Data Layers were combined with Sequencer to load and unload areas of the ship based on the location of the player.

[![Talisman Environment Level Sequence](https://dev.epicgames.com/community/api/documentation/image/82567229-d318-492a-9e95-f0e31409255d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82567229-d318-492a-9e95-f0e31409255d?resizing_type=fit)

*Mutator Zones trigger loading events in the Level Sequence.*

Each room has its own corresponding data layer and [Mutator Zones](https://dev.epicgames.com/documentation/fortnite-creative/using-mutator-zone-devices-in-fortnite-creative) spread throughout the ship that trigger events in the Level Sequence. These events load and unload sections of the ship as the player moves through the level. The Mutator Zones are strategically placed in areas of the ship to hide this from the player.

This solution is not compatible with multiplayer experiences. The Data Layers and Level Sequence have been included, but the Mutator Zones have been removed to make the template multiplayer ready.

## Using Custom UI Elements

This template uses Verse to display a custom quest icon widget and play audio when the player interacts with the console in the starting room.

[![Talisman Custom Quest Banner](https://dev.epicgames.com/community/api/documentation/image/cf3d3ede-6449-4edf-8076-70c45e392224?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf3d3ede-6449-4edf-8076-70c45e392224?resizing_type=fit)

*The custom quest banner is triggered by Verse script.*

When the player uses the Crew Quarters VO Button device, the starting\_sequence\_device.verse script file will:

```verse
using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /Fortnite.com/Characters }

using { /UnrealEngine.com/Temporary/UI }

using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# Registers the channel for debug logs.

starting_sequence_log := class(log_channel){}

# Coordinates audio for the start of the game and enables the minimap

# when a player interacts with a console.

starting_sequence_device := class(creative_device):

    # A device for printing debug log information.

    Logger:log = log{Channel := starting_sequence_log}

    # HUD message device for displaying quest message.

    @editable

    AssignQuestHudMsg:hud_message_device = hud_message_device{}

    # The button to activate the upper deck map.

    @editable

    CrewQuartersButton:button_device = button_device{}

    # How long to wait before enabling the minimap and HUD.

    @editable

    MapAndHUDDelay:float = 1.0

    # Audio played when map indicator is added.

    @editable

    MapIndicatorAudio:audio_player_device = audio_player_device{}

    # HUD controller that only displays minimap.

    @editable

    MapOnlyHud:hud_controller_device = hud_controller_device{}

    # Map for the lower deck.

    @editable

    NewUpperDeckMap:map_controller_device = map_controller_device{}

    # Enables multiple ambient audio zones around the ship.

    @editable

    TriggerAudioChannelEnable:trigger_device = trigger_device{}

    # Starts playing ambient audio from multiple zones around the ship.

    @editable

    TriggerAudioChannelPlay:trigger_device = trigger_device{}

    # Initial audio that plays when the player spawns.

    @editable

    WelcomeAudio:audio_player_device = audio_player_device{}

    # Runs when the device is started in a running game.

    OnBegin<override>()<suspends>:void =

        # Transmit on the channel to enable ambient audio volumes throughout the ship.

        TriggerAudioChannelEnable.Trigger()

        # Transmit on the channel to start playing audio from ambient audio volumes.

        TriggerAudioChannelPlay.Trigger()

        # Wait for the player to interact with the console in the crew quarters.

        CrewQuartersButton.InteractedWithEvent.Await()

        # Cancel the welcome audio if its already playing.

        WelcomeAudio.Stop()

        # Enable the upper deck map controller, then enable the minimap.

        Sleep(MapAndHUDDelay)

        NewUpperDeckMap.Enable()

        MapOnlyHud.Enable()

        Sleep(MapAndHUDDelay)

        # Show the quest message and play the map indicator audio.

        AssignQuestHudMsg.Show()

        MapIndicatorAudio.Play()
```

1. Cancel the welcome audio if the audio message is still playing.
2. Enable a minimap of the ship to help players explore the Talisman.
3. Display the custom **quest\_icon\_widget** UI widget blueprint.
4. Play a sound clip.

For more information on using Verse to customize your UEFN projects, see the [Verse Programming Onboarding Guide](https://dev.epicgames.com/documentation/en-us/fortnite/onboarding-guide-to-programming-with-verse-in-unreal-editor-for-fortnite).

## Lighting Large Spaces

The Talisman uses [Lumen global illumination](https://dev.epicgames.com/documentation/unreal-engine/lumen-global-illumination-and-reflections-in-unreal-engine) to help light the environment, providing the player with shadows and accurate indirect lighting throughout the ship.

[![Talisman Environment Hallway](https://dev.epicgames.com/community/api/documentation/image/bf7ec06e-4ade-4d23-a377-b3e8d8b8c8d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf7ec06e-4ade-4d23-a377-b3e8d8b8c8d7?resizing_type=fit)

*This corridor demonstrates all of the techniques described here.*

Lumen provides ambient occlusion and global illumination to objects that are not lit by direct lighting. While Lumen is a powerful tool for creating lighting solutions, it is still important to optimize your environment to maximize performance. Lumen is used with the **Talisman: Environment** template with several optimizations.

Shadow casting is toggled off on all static meshes that are indirectly lit throughout the level. Lumen provides excellent shadows for these meshes, so turning off the **Cast Shadows** property increased performance without sacrificing visual quality.

[![Cast Shadows in the Details panel](https://dev.epicgames.com/community/api/documentation/image/e7cf6363-4449-4e68-8f0c-ba6c600bb47d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7cf6363-4449-4e68-8f0c-ba6c600bb47d?resizing_type=fit)

*Most of the lights in the template have Cast Shadows toggled off.*

Shadow casting is also supplemented through the use of light functions and a striped texture with some overhead lights.

Lumen noise and light flickering from emissive light panels is reduced by pairing each one with a non shadow-casting spotlight.

[![Spotlight Supplementing Light Panel](https://dev.epicgames.com/community/api/documentation/image/241c9edb-3b6d-4978-adb3-713d1ecea23e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/241c9edb-3b6d-4978-adb3-713d1ecea23e?resizing_type=fit)

*This spotlight enhances the light from this light panel*

The emissive value for each panel is reduced and supplemented with a non shadow-casting spotlight. Each spotlight is given a small radius of effect and provides additional light while making it seem as if the light is still coming from the light panel.

The environment lighting was optimized further by having each light have the smallest max draw distance possible. This setting culls each light from view when it does not need to be rendered.

The [Lighting Complexity](https://dev.epicgames.com/documentation/unreal-engine/viewport-modes-in-unreal-engine?application_version=5.4) visualizer was also used throughout the lighting of the Talisman.

[![Lighting Complexity Visualizer](https://dev.epicgames.com/community/api/documentation/image/34ac57b7-dad5-4708-9605-cc96325c225d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34ac57b7-dad5-4708-9605-cc96325c225d?resizing_type=fit)

*The Lighting Complexity visualizer can be toggled using Alt+7*

This viewport viewmode shows the number of non-static lights affecting your geometry in your level as color shading and helps to track the performance cost of lighting. This visualizer is helpful in minimizing the overlap of lights in the level to keep performance costs low.

## Mesh Design and Construction

Kitbashing and mid-poly custom meshes were used to create the detailed interior of the Talisman. Kitbashing is a powerful technique that helps minimize the number of assets your project needs while still giving you the ability to reuse and combine the meshes to create new geometry.

Each mesh in the project uses a variety of different techniques to improve the look of the asset without adding additional geometry.

Face weighted normals is a technique that aligns the vertex normals of the model with the larger, flat faces to improve shading without lowering performance.

[![Face Weighted Normals](https://dev.epicgames.com/community/api/documentation/image/89e7a1ab-1eab-4d80-8a1e-ebef5ba1badb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89e7a1ab-1eab-4d80-8a1e-ebef5ba1badb?resizing_type=fit)

*The vertex normals (green lines) align with the larger, flat faces to improve shading.*

Details such as bolts, branding, and damage were added using [Mesh Decals](https://dev.epicgames.com/documentation/unreal-engine/using-mesh-decals-in-unreal-engine). These decals use custom UVs to project complex geometry onto surfaces and have the ability to wrap around corners or stretch along splines while still maintaining their look.

![Door Panel base mesh](https://dev.epicgames.com/community/api/documentation/image/e3e0ee37-4ca2-46b4-a44e-8cba768b514e?resizing_type=fit&width=1920&height=1080)

![Door panel base mesh with Mesh Decals](https://dev.epicgames.com/community/api/documentation/image/d7baa2ed-0c1b-4483-8512-ae2631a465e6?resizing_type=fit&width=1920&height=1080)

Door Panel base mesh

Door panel base mesh with Mesh Decals

## Designing Materials Using Dynamic Material Control

Textures and materials are often the largest part of any UEFN project. To further reduce the project size, the template uses a dynamic approach to textures and materials that avoids the use of unique texture maps. For this final result, a procedural workflow that stores ambient occlusion, curvature, and mask data on the mesh using Vertex Colors was used. The stored data was then used to apply and blend the materials.

### Vertex Color Data

It is best to avoid using unique texture maps for each asset by packing ambient occlusion, curvature, and texture mask data into each mesh using [Vertex Colors](https://dev.epicgames.com/documentation/unreal-engine/vertex-color-materials-in-unreal-engine). Meshes for the Talisman are designed with supporting geometry and mesh density (polygons per square inch) to provide smooth gradation between vertex colors. This helps create clean transitions between materials.

The data is stored using the following method:

| Map | Color Channel |
| --- | --- |
| **Ambient Occlusion** | Red |
| **Curvature** | Green |
| **Material ID Mask** | Blue |

For more information on Vertex Color painting, see [Vertex Color Materials](https://dev.epicgames.com/documentation/unreal-engine/vertex-color-materials-in-unreal-engine).

Material slots on each mesh are then used to define what part of the mesh receives a specific material. For more information on material slots, see [FBX Material Pipeline](https://dev.epicgames.com/documentation/unreal-engine/fbx-material-pipeline-in-unreal-engine?application_version=5.4).

[![Bridge Chair Asset with Material Slots](https://dev.epicgames.com/community/api/documentation/image/21a387c7-29f3-48ac-ac53-b0e91873cb8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21a387c7-29f3-48ac-ac53-b0e91873cb8d?resizing_type=fit)

*This chair has material slots for metal and rubber.*

### Dynamic Material Control

Meshes for the Talisman use a combination five main material types:

- Metal
- Painted metal
- Plastics
- Rubbers
- Textiles

Each material relies on a single master material that uses world-aligned tiling textures and user-defined parameters to generate the result. This keeps the overall memory cost of materials low by reusing letting our artists use the same materials across the ship.

[![Talisman Environment Master Material](https://dev.epicgames.com/community/api/documentation/image/66ba4a9a-aac5-471e-97a0-543f53bec7ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/66ba4a9a-aac5-471e-97a0-543f53bec7ca?resizing_type=fit)

*One part of the Talisman: Environment master material*

Dust, scratches and other wear marks are also included in the master material and are applied to meshes using parameter-driven masks. These parameters are stored on the mesh using custom primitive data.

## Using the Orbit Camera Device

The [Orbit Camera device](https://dev.epicgames.com/documentation/fortnite-creative/using-orbit-camera-devices-in-fortnite-creative) provides a view that follows the player character, but that the player can rotate to freely look around. The template uses this device to give the player the ability to switch between a third person view and a simulated first person view.

*Players can shift between three different views using the Orbit Camera device*

This is done using camera\_switch\_mode\_device Verse script.

```verse
# This file handles swapping between different cameras when an input is pressed.

using { /Fortnite.com/Devices }

using { /Verse.org/Simulation }

using { /Fortnite.com/Characters }

using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# Registers the channel for debug logs.

camera_switch_mode_log := class(log_channel){}

# Container class for a gameplay camera and whether it should

# hide the player character when the camera is added to a player.

gameplay_camera := class<concrete>():

    # The camera device associated with this class.

    @editable

    Camera:gameplay_camera_orbit_device = gameplay_camera_orbit_device{}

    # Whether this camera should hide the player character.

    @editable

    ShouldHideCharacter:logic = false

# Swaps between different cameras when an input trigger is activated.

camera_switch_mode_device := class(creative_device):

    # A device for printing debug log information.

    Logger:log = log{Channel := camera_switch_mode_log}

    # How long to wait before hiding the player character model

    # when a camera is added to a player.

    @editable

    HideDelay:float = 0.20

    # How long to wait before showing the player character model

    # when a camera is removed from a player.

    @editable

    ShowDelay:float = 0.3

    # Listens for a given input and swaps the camera between different modes when the input is pressed.

    @editable

    SwapCameraInputTrigger:input_trigger_device = input_trigger_device{}

    # The array of cameras to swap between. You can change the order of elements in this

    # array to change the order of camera switching.

    @editable

    Cameras:[]gameplay_camera = array{}

    # Runs when the device is started in a running game

    OnBegin<override>()<suspends>:void=

        # Spawn a camera loop per player.

        Players := GetPlayspace().GetPlayers()

        for(Player : Players):

            spawn{CameraLoop(Player)}

    # Listen for the input trigger, and swap through camers in the Cameras array.

    CameraLoop(Agent:agent)<suspends>:void=

        # Index of the current camera in the Cameras array.

        var CameraIndex:int = 0

        # Reference to the current camera.

        var MaybeCurrentCamera:?gameplay_camera_device = false

        # Continuously listen for the input trigger, then swap

        # to the next camera. Return to the default camera when

        # reaching the end of the array.

        loop:

            SwapCameraInputTrigger.PressedEvent.Await()

            # If the player has a camera, remove it from their camera stack.

            if:

                CurrentCamera := MaybeCurrentCamera?

            then:

                CurrentCamera.RemoveFrom(Agent)

                Logger.Print("Removed a camera at {CameraIndex}.")

            if:

                # Get the next camera in the Cameras array.

                NextCamera := Cameras[CameraIndex]

            then:

                # Add the camera to the agent.

                NextCamera.Camera.AddTo(Agent)

                set MaybeCurrentCamera = option{NextCamera.Camera}

                set CameraIndex += 1

                Logger.Print("Added a camera at {CameraIndex}.")

                # Check if the next camera should hide the agent's fort_character.

                # Otherwise, show the fort_character.

                if:

                    NextCamera.ShouldHideCharacter?

                then:

                    HideCharacter(Agent)

                else:

                    ShowCharacter(Agent)

            else:

                # Otherwise return to the default camera and reset the

                # CameraIndex count.

                set CameraIndex = 0

                set MaybeCurrentCamera = false

                ShowCharacter(Agent)

                Logger.Print("Reset Cameras")

            # Sleep for a short amount of time to prevent spamming

            # the input trigger.

            Sleep(1.0)

    # Wait for a HideDelay amount of seconds, the hide the

    # agent's fort_character.

    HideCharacter(Agent:agent)<suspends>:void=

        Sleep(HideDelay)

        if (FortCharacter := Agent.GetFortCharacter[]):

            FortCharacter.Hide()

    # Wait for a HideDelay amount of seconds, the show the

    # agent's fort_character.

    ShowCharacter(Agent:agent)<suspends>:void=

        Sleep(ShowDelay)

        if (FortCharacter := Agent.GetFortCharacter[]):

            FortCharacter.Show()
```

The Verse code listens for the player to trigger the [Target Creative Input action](https://dev.epicgames.com/documentation/fortnite-creative/using-input-trigger-devices-in-fortnite-creative), which by default is mapped to mouse right-click or the left trigger on a controller. It then does the following:

1. Removes the current camera from the camera stack.
2. Gets the next camera in the Cameras array.
3. Adds the new camera to the agent.
4. Hides the player character, if needed.
5. Unhide the player character, if needed.
