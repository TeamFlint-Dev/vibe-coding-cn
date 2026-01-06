# Camera Movement and Framing

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-3-camera-movement-and-framing-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:15:44.219805

---

Camera movement and framing are important for moving the story forward, revealing information, and engaging the player in your world. Deciding the type of game you’re creating early on can help you decide what type of camera angle to use and how you want your cinematic to be shot. UEFN has different [camera device options](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-camera-and-control-devices-in-unreal-editor-for-fortnite) to capture gameplay or Level Sequences.

## Camera Movement

There are a number of camera movements you can perform in UEFN, most can be accomplished using the [Camera Rig Rails and Rig Crane](camera-rig-rail-and-rig-crane-in-unreal-editor-for-fortnite):

- **Panning**
- **Tilt**
- **Dolly**
- **Truck**
- **Boom / Jib**
- **Roll**
- **Tracking Shot**

The video below illustrates the different axes a camera’s movement can take. The X-axis is from side-to-side in the frame, the Y-axis is the foreground and background of the frame, and the Z-axis is from the top and bottom of the frame.

These movements can be used in conjunction with the [camera shake effect](camera-shake-effect-in-unreal-editor-for-fortnite) to add urgency or danger to a cinematic.

Check out the Unreal Engine documentation to learn more about how to use [**Sequencer**](https://docs.unrealengine.com/5.0/en-US/cinematics-and-movie-making-in-unreal-engine/), [**camera actors**](https://docs.unrealengine.com/5.0/en-US/cinematic-cameras-in-unreal-engine/), and the [**rig systems**](https://docs.unrealengine.com/5.0/en-US/camera-jibs-and-dollies-in-unreal-engine/).

### Panning

Panning means the camera remains stationary as it sweeps horizontally either left or right around the X-axis. This can be used with a wide shot for a dramatic effect to show the terrain, a boss level, or the result of a fight.

In this video, panning is used to show the player the starting area of the race. The camera pans from the stadium over to the motorcycles and circles the bikes to show the player how many racers are in the game.

**COMMON USES:**

- Show upcoming obstacles in an unassuming way.
- Reveal terrain to create the player’s readiness for the journey ahead.
- Show racetrack terrain to prepare the player for obstacles, turns and more.
- Juxtapose the player against the upcoming stages of the level to give an idea of perspective and length of the level.
- Keeps players engaged without drawing their attention away from the gameplay.

**FRAMING A PANNING SHOT:**

- Wide shot is best for terrain and landscape shots.
- High shots provide a look around while keeping the subject in focus in the shot.
- Point of View shots can reveal secrets that the player needs to continue playing.

### Tilt

Keep the camera stationary as you tilt the camera up and down the Z-axis. A tilt is effective for showing how high an objective is, or where a player needs to travel to accomplish a goal. You can frame a camera tilt using the point of view of the [character](unreal-editor-for-fortnite-glossary#character), over the character’s shoulder, or with the character in a medium shot.

In this video, the tilt of the camera is used to show the point of view of a character looking for the player. The camera uses a long frame to provide more visual stimulation and information about where the character is traveling.

**COMMON USES:**

- Reveal a boss in a boss fight sequence with a slow tilt to increase anticipation of the fight ahead.
- Illustrate the height of a drop to increase the player’s sense of dread or show the height of an obstacle amping the player’s excitement for the level.
- Reveal a secret that would have gone unnoticed.
- Shows the scale of the path ahead.

**FRAMING A TILT SHOT:**

- A low and tight shot is typically used to reveal a foe.
- A medium or long shot can be used effectively to examine obstacles in a level.
- A point of view shot can mimic a character examining a part of a room or an object in the level.

### Dolly

The camera remains stationary as it moves forward and backward on the Y-axis. This can be accompanied by the camera lens zooming in or out depending on what you’re trying to capture in your shot. This type of movement can be used with a number of framing shots, such as a wide shot, extreme close up, or a tight close up.

This is a great way to show players what’s important in a level or focus on the player in the level as they prepare to start the game. In the video the camera slowly moves toward the box office, with the color palette the scene feels warm and the shot increases the feelings of anticipation.

**COMMON USES:**

- An artistic way to reveal set dressing, characters, obstacles, or terrain.
- Following a player as they transition from one level to another can be a satisfying way to mollify the player’s curiosity.
- Following the player into action, whether it’s a fight or flight sequence can create a feeling of anticipation.
- A beginning sequence that either moves toward or away from the player can meet or exceed a player’s expectations for the start of the game.
- A Reverse Dolly can be used to illustrate isolation, and heighten the player’s sense of fear.
- A Parallax Dolly shot moves slowly with the player or NPC which can intensify suspense and immersion in a horror game.

**FRAMING A DOLLY SHOT:**

- Tightly framed Dolly shots are effective in horror games because they focus more on the player and increase the suspense of the gameplay.
- A wide or long shot that moves slowly and uses temperature can enforce hot or cold feelings in a scene.

### Truck

The camera remains stationary as it moves side-to-side on the Y-axis. This can be used to illustrate the juxtaposition between two forces or reveal the path before the player. You can create an effective truck camera movement using a wide shot or a medium shot.

In the video, the truck shot is used to show how busy the street in front of the cinema is. A truck shot can be used to track where a player needs to traverse, how many enemies are in an area, or the movement of NPC characters.

**COMMON USES:**

- To illustrate movement or action, whether it’s the player’s, an NPC’s, or an object’s.
- A truck shot filmed in slow motion can increase the player’s anticipation or suspense.

**FRAMING A TRUCK SHOT:**

- Wide framing can show the level around the subject of the cutscene.
- A tight shot could be used to express the intensity of a character’s mood before a fight or action sequence.

### Boom / Jib

The camera sits stationary while moving up and down the Z-axis. Using a boom in combination with a low camera angle and low framing can impress the size of a character or boss to a player or the height of an obstacle the player has to overcome.

A Jib is used in this video example to show the large size of the ghost using a close up.

**COMMON USES:**

- Illustrates the scale of terrain or an enemy to manage the expectations for the gameplay ahead.
- Demonstrates the scale of a crowd or expansive landscape to immerse the player deeper in the scene.
- Can be used to reveal information about gameplay or characters.
- Can be used in a closing shot of the game or gameplay sequence.

**FRAMING A BOOM SHOT:**

- A close up framing of the subject in the shot can escalate a player’s fear and anticipation.
- A wide or long frame can be used for landscape and scale.

### Roll

The camera is stationary as it rolls side-to-side on the X-axis. A roll is best used by framing the camera for a point of view, long, or wide shot. Adding a camera shake to this type of movement would be great for filming a car accident, or a battle shot showing a wounded player or NPC.

This example video used a long shot to frame the Character device in the center of the shot while the camera rolls back and forth.

A **camera roll** can only be achieved by changing the angle of rotation on the Camera Actor.

**COMMON USES:**

- Create an action sequence where the camera is rolling beside a car or action sequence to follow the path of the subject.
- Create feelings of intensity or of being damaged by rolling with a subject that is in the midst of a struggle.

**FRAMING A ROLL SHOT:**

- Tight or detailed framing can feel claustrophobic, but also immerse the player in the action.

### Tracking Shot

The camera follows the character or subject’s action toward a final shot. This could be used narratively in a cinematic to provide background information, show an action shot before a large-scale fight, follow a vehicle to its destination, or reveal the total terrain of a world to show the player how far they are from the end of the game.

The tracking shot in this example video follows a car down the street using a tight frame. The camera focuses on the driver’s side and follows the car for a few meters.

**COMMON USES:**

- Move the narrative in the game forward by physically moving through the scene.
- Follow an object or character through the world to a secret or important revelation.

**FRAMING A TRACKING SHOT:**

- Play around with framing to find a style that works best for your type of game.

## Framing

Framing refers to the placement of the camera in relation to the position of the subject. In video games the subject can be the player’s avatar, an NPC character, or the landscape. There are different ways to frame a shot that informs the player about the game and the expectations of the gameplay.

Below are different framing techniques and ways a subject can be captured in a cinematic.

### Wide

The subject is centered in the frame and the camera slightly angles down toward the subject. This type of framing is usually used to see the game environment behind the player.

[![](https://dev.epicgames.com/community/api/documentation/image/1466065c-6a9b-4e18-96fc-97315009917f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1466065c-6a9b-4e18-96fc-97315009917f?resizing_type=fit)

### Low

The camera sits low and points upward toward the subject. The subject is usually centered in the frame.

[![](https://dev.epicgames.com/community/api/documentation/image/412434b2-6e10-4a78-a6d4-6b9ea211f064?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/412434b2-6e10-4a78-a6d4-6b9ea211f064?resizing_type=fit)

### Long

The subject is centered in the frame with the camera capturing them straight on in their entirety. If it’s a character, they are captured from head to toe in this type of framing.

[![](https://dev.epicgames.com/community/api/documentation/image/228262c0-6abb-4d43-addd-7a9fac6a1074?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/228262c0-6abb-4d43-addd-7a9fac6a1074?resizing_type=fit)

### High

The camera sits higher than a wide shot and points downwards to frame the subject. The subject is usually centered in the frame. This type of framing can be complemented by using the rule of thirds or leading lines.

[![](https://dev.epicgames.com/community/api/documentation/image/ecab9abb-9c87-4393-82c0-35e59a7c1b63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecab9abb-9c87-4393-82c0-35e59a7c1b63?resizing_type=fit)

### Medium

The subject is captured part in, and part out of the frame. A character is framed from the hips up. This type of framing is useful for juxtaposition between the character and the environment. Dialogue shots can use medium framing when players talk with an NPC.

This type of framing can be used with the rule of thirds or leading lines.

[![](https://dev.epicgames.com/community/api/documentation/image/50e9ff22-80ea-44e8-b532-806ea5065f14?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/50e9ff22-80ea-44e8-b532-806ea5065f14?resizing_type=fit)

### Cowboy

This type of framing is usually used with players or characters and not objects in the world.

Typically, the subject is framed from the knees up. Similar to a Medium shot, but includes more of the subject in the shot. This type of framing is more effective when used with the rule of thirds or leading lines.

The image below uses leading lines to focus your attention to the subject and the theater box office in the background.

[![](https://dev.epicgames.com/community/api/documentation/image/1a3f2d9f-1949-4443-af8c-20e1bc727a29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a3f2d9f-1949-4443-af8c-20e1bc727a29?resizing_type=fit)

### Tight Shot / Close-Up

The subject is in the center of the shot filling the frame and the focus of the camera. Players and NPCs are captured from the shoulders up.

Close-ups are useful for focusing on important gameplay elements, an NPC or character. A tight shot is also useful for capturing character reactions.

[![](https://dev.epicgames.com/community/api/documentation/image/9a83cfd0-c1f2-47e9-8d2c-0d28c6053ffa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a83cfd0-c1f2-47e9-8d2c-0d28c6053ffa?resizing_type=fit)

### Detailed / Extreme

The camera is zoomed in extremely close on a subject. If the focus is a character, the face is usually captured so the eyes and bridge of the nose fill the frame. This type of frame can be used for internal dialogue to better understand a character’s motivation.

[![](https://dev.epicgames.com/community/api/documentation/image/0486ba78-f4ba-4c9a-991a-bfbc9e211071?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0486ba78-f4ba-4c9a-991a-bfbc9e211071?resizing_type=fit)

### Over the Shoulder

An over the shoulder frame is exactly as it sounds: the subject is centered in the frame and is captured from over the shoulder of a character. This can be used to capture what’s in the background and not necessarily what’s in the foreground.

This type of framing can be used as a creative way to capture dialogue between characters.

[![](https://dev.epicgames.com/community/api/documentation/image/e4199760-f79d-4deb-994e-d48d3e4b7ee8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e4199760-f79d-4deb-994e-d48d3e4b7ee8?resizing_type=fit)

### Point of View

The subject of the frame is centered and the camera faces and focuses on what is being looked at by a player or character. The player or character is out of the frame, but recording the character or player leading up to a point of view shot should make it clear that the subject of the frame is what the player or character is looking at.

This type of framing is effective for escape rooms, action adventure games, and role playing games.

[![](https://dev.epicgames.com/community/api/documentation/image/2ac4e442-1f41-4939-b404-03089e5886a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ac4e442-1f41-4939-b404-03089e5886a2?resizing_type=fit)

## Character Framing

Consider the character’s personality and the best way to capture them. Usually, when filming an adversarial character, they are filmed in a low frame using a low camera angle to show how intimidating the bad guy is.

On the other hand, heroes are filmed using a high frame and high camera angle to separate the neck from the chin and to show how attractive they are. This is the same technique that’s used to capture a selfie!

|  |  |
| --- | --- |
|  |  |
| Low Angle | High Angle |

## More Topics

[![Composition Techniques](https://dev.epicgames.com/community/api/documentation/image/7d443d0c-08fd-4b45-8cb5-68f8bf733334?resizing_type=fit&width=640&height=640)

Composition Techniques

Use composition to capture artful cinematics for your gameplay.](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-1-composition-techniques-in-unreal-editor-for-fortnite)[![Lighting and Color](https://dev.epicgames.com/community/api/documentation/image/762eee9b-f756-457e-9082-ccb1d2ee760f?resizing_type=fit&width=640&height=640)

Lighting and Color

Use lighting and color effectively in a cinematic to create emotion and set the scene.](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-2-lighting-and-color-in-unreal-editor-for-fortnite)[![Integrating Cinematics](https://dev.epicgames.com/community/api/documentation/image/496064bc-9b66-4940-bfdf-84ac6154089a?resizing_type=fit&width=640&height=640)

Integrating Cinematics

Discover all the elements you need to create satisfying and thoughtful cinematics for your game.](https://dev.epicgames.com/documentation/en-us/fortnite/making-cinematics-4-integrating-cinematics-in-unreal-editor-for-fortnite)
