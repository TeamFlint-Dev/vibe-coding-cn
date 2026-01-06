# Designing with Cameras and Controls

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:12:35.093148

---

The player's perspective can change everything about a game: a dynamic camera can intensify the sense of action, making intense moments more exhilarating, while a fixed viewpoint can create suspense and terror. Switching between cameras can intensify emotions, or create a deeper connection between the player and the in-game character. Carefully selecting different camera perspectives can significantly shape the player's engagement, emotional investment, and overall enjoyment of their gaming experience.

On this page, you will learn about how each type of camera can be used, and how to adjust the controls for the kind of gameplay you’re looking to make.

For more information on each of the devices covered here, see:

- [Fixed Point Camera device](using-fixed-point-camera-devices-in-fortnite-creative)
- [Fixed Angle Camera device](using-fixed-angle-camera-devices-in-fortnite-creative)
- [Third Person Controls device](using-third-person-controls-devices-in-fortnite-creative)
- [First Person Mode Controls device](using-first-person-mode-devices-in-fortnite-creative)

Please note that, when switching cameras, the **Third Person Controls** device must be used to retain control over the player character. This will be covered in more detail in the [Adapting Controls](https://dev.epicgames.com/documentation/en-us/fortnite/designing-with-cameras-and-controls-in-fortnite-creative) section.

## Fixed Point Cameras

[![fixed point camera](https://dev.epicgames.com/community/api/documentation/image/907c1106-835a-427e-ba77-cc32f74853bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/907c1106-835a-427e-ba77-cc32f74853bf?resizing_type=fit)

Fixed point cameras maintain a predetermined location and angle throughout gameplay or in specific areas. These cameras adjust dynamically to player actions.

Fixed point cameras are useful in a variety of situations, some of which are explored below.

### Using a Static Camera for Mini Games

Static cameras remain completely still, capturing a specific view of the game environment. They often provide a consistent perspective and can be used to create compelling mini games.

In the following example, the Fixed Camera device is used for a party game. Players must remain on the platform for as long as possible while trying to get the other players off the platform and avoid cannonballs.

Notice how the camera slightly follows the player as they move around the floating platform.

The fixed camera in this example uses the following modified settings:

| Option | Value | Description |
| --- | --- | --- |
| **Field of View** | 50.0 | The degrees of the vertical axis that the camera can view. |
| **Look at Offset Distance** | 1.2 | Moves the camera a bit forward, offsetting the view [target](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#target). |
| **Look at Offset Horizontal** | 0.24 | Moves the camera left or right, offsetting the view target. |
| **Look at Offset Vertical** | 0.24 | Moves the camera up or down, offsetting the view target. |
| **Yaw Accelerations** | 0.24 | Determines how fast the camera accelerates left or right towards the target, 0 being instant. |
| **Pitch Acceleration** | 0.24 | Determines how fast the camera accelerates up or down towards the target, 0 being instant. |

In order for players to be able to aim their weapons and have their characters change direction, a **Player Controller** device is placed in the level with the default settings.

### Using Multiple Fixed Cameras for Added Suspense

Use multiple fixed cameras positioned strategically throughout the level in any game where you want to build tension. In this example, as the player progresses the game switches between these camera perspectives to reveal different aspects of the environment. This naturally builds suspense because players don't know what may be hiding behind the next corner!

As a player enters a **Mutator Zone** device, the fixed camera linked to this zone is added to the player.

If you're working in UEFN, it can be helpful to use the **World** setting with the transform gizmo when you’re placing cameras. This ensures they stay level to the ground.

[![world setting](https://dev.epicgames.com/community/api/documentation/image/595d0e89-a593-483b-ad3b-7e0a796c570c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/595d0e89-a593-483b-ad3b-7e0a796c570c?resizing_type=fit)

As the player moves from one mutator zone to another, the cameras get added and removed to match the player’s location. Since the basement is a closed space with only one exit, a **Trigger** device on the floor is used instead of a mutator zone.

The Fixed Camera devices in this example use the following modified settings:

| Option | Value | Description |
| --- | --- | --- |
| **Add to Players on Start** | False | Players are added to cameras through their interaction with devices. |
| **Transition In Time** | 0.0 | To create a more dramatic effect, transitions between cameras are instantaneous. |
| **Transition Out Time** | 0.0 | To create a more dramatic effect, transitions between cameras are instantaneous. |

The Mutator Zone has the **Enable VFX** setting disabled to maintain immersion.

The Trigger device uses the following modified settings:

| Option | Value | Description |
| --- | --- | --- |
| **Visible In Game** | False | Players should not know they are walking on a trigger. |
| **Trigger VFX** | False | Players should not know they are walking on a trigger. |
| **Trigger SFX** | False | Players should not know they are walking on a trigger. |

**Direct Event Binding**

The cameras are linked to devices in the following way:

| Device | Function | Device | Event |
| --- | --- | --- | --- |
| **Fixed Point Camera** | Add to Player | Mutator Zone | On Player Entering Zone |
| **Fixed Point Camera** | Remove from Player | Mutator Zone | On Player Exiting Zone |
| **Fixed Point Camera** | Add to Player | Trigger | On Triggered |

### Advantages of Fixed Point Cameras

Fixed point cameras offer a wide variety of advantages:

- **Cinematic Presentation**: Create cinematic moments by presenting scenes from carefully chosen angles, which enhances storytelling and immersion.
- **Controlled Viewpoints**: Designers can control what the player sees, ensuring that key elements or surprises are revealed at specific times.
- **Artistic Direction**: Fixed cameras can showcase the game's art style, architecture, or specific details in the environment.
- **Gameplay Challenges**: Challenge players by restricting their view, adding difficulty, or creating puzzles that rely on obscured information.

### Limitations of Fixed Point Cameras

If you're not careful, fixed point cameras can negatively impact player experience. Keep these points in mind when making your game.

- **Limited Player Control**: Players might feel restricted or disoriented if they can't control the camera freely, affecting their overall experience.
- **Potential for Frustration**: In certain situations, fixed cameras might hinder gameplay, leading to frustration when they obscure important information or impede progress.

As island creators and game designers, you must balance the benefits and drawbacks of fixed point cameras to ensure they enhance the gaming experience without causing unnecessary hindrances to the player.

## Fixed Angle Cameras

[![fixed angle camera](https://dev.epicgames.com/community/api/documentation/image/940b2d20-be33-42a4-8bcd-425f08f14391?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/940b2d20-be33-42a4-8bcd-425f08f14391?resizing_type=fit)

Fixed angle cameras move with the player, remaining in a locked angle and giving them a consistent perspective. They can offer various viewpoints, such as top-down, side-scrolling, or isometric angles, giving players a consistent visual reference as they navigate through the game. They're commonly used in many classic games.

### Using a Fixed Angle Camera for a Zombie Survival Game

This example uses a Fixed Angle Camera device to emulate the feeling of a classic top-down shooter. Here, players must eliminate hordes of zombies in order to level up and obtain better weapons.

You can see that there are [transitions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#camera-transition) between two fixed angle cameras. The first is enabled when the player must purchase weapons, and transitions to the second camera when the player leaves the shop to fight the hordes of zombies.

The first **Fixed Angle Camera** device in this example uses the following modified settings:

| Option | Value | Description |
| --- | --- | --- |
| **Add to Players on Start** | False | This camera is not added to players at the start of the game. |
| **Transition in Priority** | 10 | Camera transition is determined by the highest priority, comparing the Out Priority of the current camera to the In Priority of the destination camera. |
| **Transition in Type** | Linear | Behavior of the camera when activating. |
| **Transition in Time** | 0 | This is an immediate transition. |
| **Transition Out Type** | Linear | Determines the style of transition. |
| **Transition Out Time** | 0 | This is an immediate transition. |

The second **Fixed Angle Camera** device in this example uses the following modified settings:

| Option | Value | Description |
| --- | --- | --- |
| **Transition in Type** | Linear | Behavior of the camera when activating. |
| **Transition in Time** | 0 | This is an immediate transition. |
| **Transition Out Priority** | 2 | Camera transition is determined by the highest priority, comparing the Out Priority of the current camera to the In Priority of the destination camera. |
| **Transition Out Type** | Linear | Determines the style of transition. |
| **Transition Out Time** | 0 | This is an immediate transition. |
| **Collision Type** | Transparency | Makes objects that obscure the target invisible when line of sight is broken. |

The **Third Person Controls** device in this example uses the following modified settings:

| Option | Value | Description |
| --- | --- | --- |
| **Interact Distance** | 50 | Distance from player required to perform an interaction. |
| **Rotation Rate** | 600 | The player’s turning rate, in degrees per second. |
| **Shooting Locomotion Movement Speed** | 400 | Movement speed while shooting, in meters per second. |
| **Shooting Locomotion Rotation Rate** | 600 | The player’s turning rate while shooting, in degrees per second. |
| **Aiming Locomotion Movement Speed** | 400 | Movement speed while aiming, in meters per second. |
| **Aiming Rotation Rate** | 600 | The player’s turning rate while aiming, in degrees per second. |
| **Scale Weight by Angle** | 0.7 | This setting affects the prioritization of targets. As targets get closer to you, aiming at it becomes prioritized. |
| **Ranged Targeting Angle** | 180 | Depending on where the player is facing, the range in degrees where targets are considered valid. |
| **Aim Targeting Angle** | 180 | Depending on where the player is facing, the range in degrees where targets are considered valid. |

### Advantages of Fixed-Angle Cameras

- **Artistic Presentation**: Allows for meticulously crafted views, showcasing the game's visual elements and artistic design from specific angles.
- **Controlled Narrative**: Designers can guide players' attention to key story elements or scenic views by positioning the camera strategically.
- **Consistency**: Offers a stable perspective, providing players with a familiar and reliable viewpoint as they progress through the game.
- **Optimized Design**: Simplifies level design and game mechanics because developers can anticipate what the player can see from a fixed angle, aiding themn in creating focused experiences.

### Limitations of Fixed-Angle Cameras

- **Limited Exploration**: Players might feel constrained or miss out on certain details as they cannot freely adjust the camera to explore the environment.
- **Obstructed Views**: Fixed angles can sometimes hide crucial information or obstruct the player's view, leading to frustration or confusion.

Staying true to your vision should be the priority, so try not to sacrifice gameplay at the cost of using a better-looking camera!

## Orbit Cameras

[![orbit camera](https://dev.epicgames.com/community/api/documentation/image/29591a38-5e07-477e-8a68-b37b8f3c8d28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/29591a38-5e07-477e-8a68-b37b8f3c8d28?resizing_type=fit)

Using an [orbit camera](using-orbit-camera-devices-in-fortnite-creative) is like being the director of your own action movie. You can rotate it around a central point or your character, and view the environment from different perspectives. This type of camera is commonly used in open-world games and 3D platformers to give players a greater sense control over their view of the virtual world and enhance immersion.

Check out the [Orbit Camera Device Design Example](https://dev.epicgames.com/documentation/en-us/fortnite/orbit-camera-device-design-example-in-fortnite-creative) page to learn about a fun way to use the orbit camera in your projects!

## First Person Mode Cameras

Use the Gameplay Mode: First Person Mode device to put players in a first-person perspective.

You can use this device to create unique First Person Shooters that fully immerse players into your gameplay experience.

### Limitations of First Person Mode Cameras

Below are the limitation of using the First Person Mode device.

- Most ranged weapons, except Akimbo and Ballistic Shield are available, but not all available weapons have custom reload animations.
- Some player actions are not available in first-person view. Players performing some actions (such as swimming, gliding and skydiving) will automatically switch to the default Third Person Camera. Additionally, there are some other player actions that might cause the player's hands or weapon to be hidden.
- Shadows are missing when using the first-person view, and in certain situations there might be some clipping or other rendering issues.
- Melee weapons and vehicles are not supported in the current version of the device.

## Priority System

For the Camera devices, **Priority** determines which device takes priority when multiple devices are active.

When placing a device, the default priority is **0**, which is the lowest priority assignment. Any device with a higher Priority number (1 and above) will override devices with a lower priority.

### Visualizing Priorities

In this example, three Fixed Angle cameras are connected to ON/OFF switches. The first camera is set to **Priority 0**, and the two cameras to the right are both set to **Priority 1**.

The player always sees the highest priority active camera. When cameras are the same priority, the camera that is most recently added is what the player sees.

Reactivating the Priority 0 camera will not work until both Priority 1 cameras have been turned off. A lower priority camera can never override a high priority camera.

### How to Use Priorities

The priority system can really simplify your workflow when used correctly!

Instead of working out complicated trigger logic, you can automatically add higher priority cameras to players as they enter a building, then remove them when they go back outside.

Try coming up with your own scenarios!

## Adapting Controls

[![Controls device](https://dev.epicgames.com/community/api/documentation/image/b4634ad4-3d0f-4d99-845f-87a47ca4c361?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4634ad4-3d0f-4d99-845f-87a47ca4c361?resizing_type=fit)

Simply putting down a camera device in your level will result in your player character always facing the same direction as the camera. The Third Person Control device attempts to capture player intent, allowing your character to face a target or your movement direction.

Depending on the type of game you’re looking to make, you may need to calibrate the targeting logic to achieve the desired player experience.

On the left side, the device's settings are left on default. Zombies are not targeted until they are very close and the player needs to make adjustments often to get them into the weapon’s sights.

On the right side, the automatic targeting was significantly increased, so much so that the player only needs to press the Fire button to eliminate every zombie that appears on the screen!

Here are the modified settings for the example on the right:

- Rotation Rate: 800
- Rotate Toward Target: True
- Shooting Locomotion Rotation Rate: 800
- Aiming Rotation Rate: 800
- Scale Weight by Angle: 1.0
- Ranged Targeting Angle: 180
- Aim Targeting Angle: 180

The best way to determine what feels right for your island is to playtest often, alone and with other players.

## Boundaries and Deadzones

The [deadzone](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#deadzone) refers to an established area within which the player character can move around without affecting the camera. When the player moves to an edge of the deadzone, the camera will move to follow the target.

In the example below, notice how the camera is static as the player runs inside the deadzone, and starts to move again when the player exits the deadzone.

Deadzones help you manage what players can see or do in certain areas.

You can use deadzones for artistic purposes as well! By limiting the camera's movement within predefined zones, create picturesque views or cinematic compositions, and spruce up the game's visual storytelling.

**Boundaries** are pre-defined points beyond which the camera will not move.

Notice in the example below how the camera follows the player within the volume, but stops once the player exits the volume. This movement is defined by the camera’s boundaries.

For sidescroller games, boundaries are often placed at the edges of the screen. When the player reaches these zones, the camera doesn't move further until the player advances. Once a player moves beyond a certain point, the camera's boundary might restrict them from returning, focusing on the forward movement through the level design.

## Using UEFN to Level Up Your Design

While camera and controls devices are fully available to use in Fortnite Creative, you can take your design work to the next level using Unreal Editor for Fortnite (UEFN).

To learn about using cameras in UEFN, see:

- [Gameplay Camera and Control Devices](https://dev.epicgames.com/documentation/en-us/uefn/gameplay-camera-and-control-devices-in-unreal-editor-for-fortnite)
- [Making a Title Sequence](https://dev.epicgames.com/documentation/en-us/uefn/making-a-title-sequence-in-unreal-editor-for-fortnite) gameplay example
