# 12. Cinematics

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-12-custom-assets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:17:36.762418

---

To create the mood and atmosphere for the escape room four cinematics were captured using a [level sequence](https://dev.epicgames.com/documentation/en-us/fortnite/sequencer-and-control-rig-in-unreal-editor-for-fortnite) and a [camera shake effect](https://dev.epicgames.com/documentation/en-us/fortnite/camera-shake-effect-in-unreal-editor-for-fortnite). The camera work complements and propels the story forward.

Each cinematic cohesively drives the story by using the same first-person camera view point. The first sequence provides background information, the second and third sequences create urgency, and the fourth sequence watches as the player leaves the cabin behind, then turns to watch the cabin burn and completes the game.

## Creating Camera Shake Effects

The camera work uses a camera shake effect to create the illusion of a first-person view. To effectively use the camera shake effect in a sequence make sure the camera shake is subtle. Movements that are too jerky or dramatic won’t look natural and may make players feel nauseous.

Three camera shake effects were created for each cinematic. The settings used for each camera shake effect differ slightly depending on the type of camera shake needed for the sequence.

### Opening Camera Shake

This camera shake imitates a person’s stride.

1. Use the **Perlin Noise Camera Shake Pattern**.
2. Use the following **Location** settings:

   1. Location Amplitude Multiplier = **12.0**
   2. Location Frequency Multiplier = **2.0**
3. Set the **Duration** to **220.0** seconds.
4. Set the **Blend** times for:

   1. Blendin = **2.0**
   2. Blendout = **2.0**

The camera shakes at an amplitude of 12 every 2 seconds spanning a 220 second time period.

### Kidnapper Returns Shake

This camera shake imitates the footsteps of someone climbing stairs.

1. Use the **Perlin Noise Camera Shake Pattern**.
2. Use the following **Location** settings:

   1. Location Amplitude Multiplier = **1.5**
   2. Location Frequency Multiplier = **1.0**
3. Set the **Duration** to **168.0** seconds.
4. Set the **Blend** times for:

   1. Blendin = **0.2**
   2. Blendout = **0.2**

The camera shakes at an amplitude of 1.5 every second spanning a 168 second time period.

### Truck Shake

This camera shake is meant to mimic a truck bouncing over potholes in the driveway.

1. Use the **Wave Oscillator Camera Shake Pattern**.
2. Use the following **Location** settings:

   1. Location Amplitude Multiplier = **9.0**
   2. Location Frequency Multiplier = **2.0**
3. Set the **Duration** to **30.0** seconds.
4. Set the **Blend** times for:

   1. Blendin = **0.2**
   2. Blendout = **0.8**

The camera shakes at an amplitude of 9.0 every 2 seconds spanning a 30 second time period.

## Using Camera Shake Effects

Add a camera shake effect to a specific place in the sequence by doing the following:

1. Playtest the level sequence in Sequencer.
2. Identify a time in the cinematic sequence where the addition of a camera shake effect would add to the aesthetic of the horror genre.
3. Add the camera shake to the level sequence.
4. Playtest the level sequence again to see if the duration of the camera shake is long enough or should be shortened or lengthened for the cinematic.
5. Save the Sequence when you’re happy with the way the cinematic looks.
6. Add the cinematic to a Cinematic Sequence device.
