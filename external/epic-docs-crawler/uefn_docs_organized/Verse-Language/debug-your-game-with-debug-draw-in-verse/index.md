# Debug Your Game with Debug Draw

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse>
> **爬取时间**: 2025-12-27T00:03:41.318736

---

To help with [debugging](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#debugging) your game, you can display certain game data for testing purposes while hiding that information from the player. One way to do this is logging, but you can show some game data in a more visual way with the **Debug Draw API**.

Using the Debug Draw API, you can draw basic shapes and set their location, size, color, and the length of time they appear on screen. For example, you might want to visualize the visibility range of an NPC or the distance from which audio can be heard from its point of origin. With the box debug shape, you could draw a box with dimensions and a location that match any volume, even if that volume is invisible in your game. This can help with figuring out the placement of volumes with certain effects.

[![Debug arrows drawing the line of sight of guards](https://dev.epicgames.com/community/api/documentation/image/5a472f69-550a-4221-827b-cf44b913105a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a472f69-550a-4221-827b-cf44b913105a?resizing_type=fit)

*The arrow debug shape drawn from an NPC’s face to the limit of their visibility range can be used to help design the perfect placement for guards.*

## Enable Verse Debug Draw

The first step is to make sure you can see the shapes you draw.

1. Select **Island Settings** in the UEFN Outliner.
2. In the Details panel search bar, type **debug**. This will filter results to the User Options - Debug category.
3. Click **Debug**, then **Verse Debug Draw** to activate Debug features and Verse Debug Draw.

[![The details panel of Island Settings showing Debug and Verse Debug draw enabled.](https://dev.epicgames.com/community/api/documentation/image/9aa006ed-7e4c-4eda-9fa2-3cc0a790d067?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9aa006ed-7e4c-4eda-9fa2-3cc0a790d067?resizing_type=fit)

Verse Debug Draw will only be active during a play session of UEFN. It is enabled per user, which means only those who have activated Debug and Verse Debug Draw will see debug shapes. Debug shapes will **not** appear in the UEFN viewport or on a published island, even if this option is checked in Island Settings.

## Draw Your First Debug Shape

To draw your first shape with the Debug Draw API, follow these steps.

1. Add this import expression to your Verse file.

   ```verse
   using { /UnrealEngine.com/Temporary/Diagnostics }
   ```

2. Create a **channel** by declaring a [subclass](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that inherits from the `debug_draw_channel` [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type). Channels are for grouping related shapes together. They are optional but it is a good practice to use them. There are [functions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) in the Debug Draw API that you can use to show, hide, or clear many shapes all at once, but showing and hiding only works at the channel level.

   ```verse
   my_debug_draw := class(debug_draw_channel) {}
   ```

3. Declare a new [constant](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant) of type `debug_draw`. This will be the object you use to call the [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) to draw shapes. This example shows the use of the Channel parameter (created in the previous step), but it is optional.

   ```verse
   DebugDraw:debug_draw = debug_draw{Channel := my_debug_draw}
   ```

4. Call the `DrawSphere` method. This example uses two [parameters](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter).

- `Center:= vector3{Z:= 150.0}`: This is a required parameter of type [vector3](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/unrealenginedotcom/temporary/spatialmath/vector3) which determines the location of the sphere’s center. In this example you will use the [constructor](https://dev.epicgames.com/documentation/en-us/uefn/class-in-verse#constructingaclass) of the `vector3` type to create a literal value. This will set the center of the sphere at location `0.0, 0.0, 150.0`.
- `?DrawDurationPolicy:= debug_draw_duration_policy.Persistent`: This parameter is optional but its default value will make the sphere disappear after a few seconds, so set it to the **Persistent** policy. This means that the sphere will remain visible on the island until it is hidden or cleared by other code.

  ```verse
  DebugDraw.DrawSphere(Center := vector3{Z:=150.0}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
  ```

[![The debug sphere shape.](https://dev.epicgames.com/community/api/documentation/image/d0b5ba6f-bba4-4a19-a674-8b194bcbfde1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0b5ba6f-bba4-4a19-a674-8b194bcbfde1?resizing_type=fit)

After building your Verse code and launching a session, you should see a sphere appear at the location set by the `Center` parameter.

## Shapes

With the Debug Draw API, you can draw several shapes that appear as simple wireframes in a running UEFN session. Each shape is useful in different scenarios. The following sections explain the methods to draw each shape and the parameters that are unique to each method. A later section explains the parameters that are common to every method. Each code example in this section assumes you have added the code from Draw Your First Debug Shape to your Verse file.

### Box

Use the `DrawBox()` method to draw a cube.

[![The debug box shape.](https://dev.epicgames.com/community/api/documentation/image/5f3a5063-3976-4a9f-871c-a937724361e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f3a5063-3976-4a9f-871c-a937724361e9?resizing_type=fit)

```verse
DebugDraw.DrawBox(vector3{Z:=150.0}, rotation{}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Center:vector3 | Sets the center of the box |
| Rotation:rotation | Sets how the box is rotated |
| ?Extent:vector3 | Sets the length, width, and depth of the box |

### Capsule

Use the `DrawCapsule()` method to draw a capsule. A capsule is made up of a cylinder with one half of a sphere on either end.

[![The debug capsule shape.](https://dev.epicgames.com/community/api/documentation/image/319122ee-7ac3-4ed0-b46a-b305c5e9b15e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/319122ee-7ac3-4ed0-b46a-b305c5e9b15e?resizing_type=fit)

```verse
DebugDraw.DrawCapsule(vector3{Z:=200.0}, rotation{}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Center:vector3 | Sets the center of the capsule |
| Rotation:rotation | Sets how the capsule is rotated |
| ?Height:float | Sets the length of the capsule |
| ?Radius:float | Sets the radius of the capsule at its widest point |

### Sphere

Use the `DrawSphere()` method to draw a sphere.

[![The debug sphere shape.](https://dev.epicgames.com/community/api/documentation/image/5e500903-104a-41a7-b502-ae67d1cee695?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5e500903-104a-41a7-b502-ae67d1cee695?resizing_type=fit)

```verse
DebugDraw.DrawSphere(vector3{Z:=150.0}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Center:vector3 | Sets the center of the sphere |
| ?Radius:float | Sets the radius of the sphere at its widest point |
| ?NumSegments:int | Sets the number of lines that make up the sphere |

### Cone

Use the `DrawCone()` method to draw a cone.

[![The debug cone shape.](https://dev.epicgames.com/community/api/documentation/image/1a12cb71-7615-42bf-9932-c151d46e12ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a12cb71-7615-42bf-9932-c151d46e12ac?resizing_type=fit)

```verse
DebugDraw.DrawCone(vector3{Z:=150.0}, vector3{Z:=-1.0}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Origin:vector3 | Sets the location of the point of the cone |
| Direction:vector3 | Sets the direction in which the cone opens |
| ?Height:float | Sets the length of the cone |
| ?NumSides:int | Sets the number of sides |
| ?AngleWidthRadians:float | Sets the width of the cone in the X direction |
| ?AngleHeightRadians:float | Sets the width of the cone in the Y direction |

To make the bottom of your cone a perfect circle, `AngleWidthRadians` and `AngleHeightRadians` must be equal.

### Cylinder

Use the `DrawCylinder()` method to draw a cylinder.

[![The debug cylinder shape.](https://dev.epicgames.com/community/api/documentation/image/17dbe54f-ef0e-4937-ad9c-1fb010b7e5d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17dbe54f-ef0e-4937-ad9c-1fb010b7e5d0?resizing_type=fit)

```verse
DebugDraw.DrawCylinder(vector3{Z:=100.0}, vector3{Z:=200.0}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Start:vector3 | Sets the location of one end of the cylinder |
| End:vector3 | Sets the location of the other end of the cylinder |
| ?NumSegments:int | Sets the number of lines connecting one end of the cylinder to the other |
| ?Radius:float | Sets the radius of the two circles making up each end of the cylinder |

### Line

Use the `DrawLine()` method to draw a line.

[![The debug line shape.](https://dev.epicgames.com/community/api/documentation/image/480e0de5-536d-4b3b-ab6c-b779c38ab187?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/480e0de5-536d-4b3b-ab6c-b779c38ab187?resizing_type=fit)

```verse
DebugDraw.DrawLine(vector3{Z:=100.0}, vector3{Z:=200.0}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Start:vector3 | Sets the location of one end of the line |
| End:vector3 | Sets the location of the other end of the line |

### Arrow

Use the `DrawArrow()` method to draw an arrow.

[![The debug arrow shape.](https://dev.epicgames.com/community/api/documentation/image/84228dda-2d84-4b35-9284-1ca78ac1aae6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84228dda-2d84-4b35-9284-1ca78ac1aae6?resizing_type=fit)

```verse
DebugDraw.DrawArrow(vector3{Z:=100.0}, vector3{Z:=200.0}, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Start:vector3 | Sets the location of the start of the arrow |
| End:vector3 | Sets the location of the head of the arrow |
| ?ArrowSize:float | Sets the length of the two lines that make up the head of the arrow |

### Point

Use the `DrawPoint()` method to draw a point.

[![The debug point shape.](https://dev.epicgames.com/community/api/documentation/image/10cda316-1b75-4431-a2b4-420816dc9c41?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/10cda316-1b75-4431-a2b4-420816dc9c41?resizing_type=fit)

```verse
DebugDraw.DrawPoint(vector3{Z:=200.0}, ?Thickness:= 10.0, ?DrawDurationPolicy := debug_draw_duration_policy.Persistent)
```

| Unique Parameter | What It Does |
| --- | --- |
| Position:vector3 | Sets the location of the point |

The default `Thickness` of `DrawPoint` is too small to be visible. Set `Thickness` to a larger value as shown in the above example to see the point.

## Common Parameters

These parameters are common to all the methods that draw shapes. They are also all optional, and do not need to be included as arguments when calling a method. If you do choose to include them, be sure to use the parameters name prepended by a `?`. See [Calling Functions in Functions](https://dev.epicgames.com/documentation/en-us/uefn/functions-in-verse#callingfunctions) for more information on named and optional arguments.

### Color

Set the color of shapes using the `Color` parameter. Values must be of type `color`. The list of valid colors can be found in the [NamedColors module](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/colors/namedcolors). Be sure to have the import expression for the `Colors` module at the top of your Verse file. Below is an example of setting a point to a different color.

```verse
DebugDraw.DrawPoint(Position := vector3{Z:= 200.0}, ?Thickness := 20.0, ?Color := NamedColors.MediumSeaGreen)
```

### DrawDurationPolicy

The `DrawDurationPolicy` determines how long a debug shape remains on screen. There are three possible values.

- `SingleFrame` : The shape will remain on screen for the length of a single [frame](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#frame). This policy can be useful when you want to frequently redraw a shape.
- `FiniteDuration`: This policy is used with the `Duration` parameter to display a shape for a certain number of seconds.
- `Persistent`: With the Persistent policy, the shape will remain on screen until hidden or cleared by other code.

### Duration

The `Duration` parameter is used with the `FiniteDuration` policy to display a shape for a certain number of seconds. Below is an example of code that draws a sphere that displays for 30 seconds.

```verse
DebugDraw.DrawSphere(vector3{}, ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration, ?Duration := 30.0)
```

### Thickness

The `Thickness` parameter sets the thickness of the lines that make up each debug shape. In the case of `DrawPoint()`, it sets the thickness of the single point.

## Channels

You can use channels to group related shapes together, and then hide, show, or clear all the shapes in a channel at once.

To create a channel, use the `Channel` parameter when declaring an instance of `debug_draw`.

```verse
DebugDraw:debug_draw = debug_draw{Channel := debug_draw_defaults}
```

Now any shape you draw using the `DebugDraw` instance can be hidden, shown, or cleared with a single method. For example, if you draw a point, a sphere, and an arrow with the `DebugDraw` instance, you can then hide them for some time, then show them again, and finally clear them when they are no longer needed.

```verse
# Point
DebugDraw.DrawPoint(vector3{Z := 200.0}, ?Thickness:= 50.0, ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)

# Sphere
DebugDraw.DrawSphere(vector3{Z := 200.0}, ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)

# Arrow
DebugDraw.DrawArrow(vector3{Z := 200.0}, vector3{Z := 400.0}, ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)

Sleep(5.0)
DebugDraw.HideChannel()
Sleep(5.0)
DebugDraw.ShowChannel()
Sleep(5.0)
DebugDraw.ClearChannel()
```

## Default Parameter Values

| Parameter | Value |
| --- | --- |
| ?Color:color | `NamedColors.Yellow` |
| ?DrawDurationPolicy:debug\_draw\_duration\_policy | `debug_draw_duration_policy.FiniteDuration` |
| ?Duration:float | `5.0` |
| ?Thickness:float | `0.0` |
| ?Radius:float | `10.0` |

## Examples

### Visualize the Range of an Audio Player Device

The [Audio Player Device](https://dev.epicgames.com/documentation/en-us/uefn/intro-to-audio-in-unreal-editor-for-fortnite) has a setting to visualize its attenuation. But you can only see this visualization during edit mode. Follow these steps to learn how to to recreate the attenuation visuals in a play session.

[![Two debug sphere shapes showing the attenuation falloff of an audio player device.](https://dev.epicgames.com/community/api/documentation/image/ad03e5b0-0011-4b49-a0c6-b00318920823?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad03e5b0-0011-4b49-a0c6-b00318920823?resizing_type=fit)

1. Drag an [Audio Player Device](https://dev.epicgames.com/documentation/en-us/uefn/intro-to-audio-in-unreal-editor-for-fortnite#theaudioplayerdevice:playingyoursoundwavesandsoundcues) into your level. In the Details panel, make sure that **Enable Attenuation Visuals** is checked. This will help you verify that you are recreating the visuals correctly with the debug shapes.
2. In your Verse file, create a new `debug_draw` instance called `DebugDrawAudio`. Give it a channel with the name `debug_draw_audio`.

   ```verse
   DebugDrawAudio:debug_draw = debug_draw{Channel := debug_draw_audio}
   ```

3. Add two `@editable` constants of type `float`. Name them `DebugAttenuationMinDistance` and `DebugAttenuationFalloffDistance`. These will be the two radii of the spheres drawn to visualize the attenuation of the Audio Player Device.

   ```verse
   @editable
        DebugAttenuationMinDistance:float = 100.0
     
        @editable
        DebugAttenuationFalloffDistance:float = 100.0
   ```

4. Add another `@editable` to represent the Audio Player Device. Name it `AudioPlayerDevice`.

   ```verse
   @editable
        AudioPlayerDevice:audio_player_device = audio_player_device{}
   ```

5. Declare a function called `DrawAudioDeviceRange()` and give it two parameters of type `float`: `AttenuationMinDistance` and `AttenuationFalloffDistance`.

   ```verse
   DrawAudioDeviceRange(AttenuationMinDistance:float, AttenuationFalloffDistance:float):void =
   ```

6. In the new function, get the Transform object of the Audio Player Device.

   ```verse
   AudioPlayerDeviceTransform:= AudioPlayerDevice.GetTransform()
   ```

7. Using the `DrawSphere` function from the Debug Draw API, draw two spheres to represent the Attenuation Min Distance and the Attenuation Falloff Distance. The `Radius` in the second `DrawSphere` call must be set to the sum of `AttenuationMinDistance` and `AttenuationFalloffDistance` because attenuation only starts outside the radius of the Attenuation Min Distance.

   ```verse
   DebugDrawAudio.DrawSphere(
            AudioPlayerDeviceTransform.Translation,
            ?Radius:= AttenuationMinDistance,
            ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)
        DebugDrawAudio.DrawSphere(
            AudioPlayerDeviceTransform.Translation,
            ?Radius:= AttenuationMinDistance + AttenuationFalloffDistance,
            ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)
   ```

8. In the `OnBegin()` function of your Verse file, call the `DrawAudioDeviceRange()` function.

   ```verse
   OnBegin<override>()<suspends>:void=
        DrawAudioDeviceRange(DebugAttenuationMinDistance, DebugAttenuationFalloffDistance)
   ```

9. Build your Verse code. In the Details panel of your Verse device, make sure you set the values for **DebugAttenuationMinDistance** and **DebugAttenuationFalloffDistance**. These values should be equivalent to the **Attenuation Min Distance** and **Attenuation FalloffDistance** values for your Audio Player Device multiplied by 100.

   The Audio Player Device uses meters for Attenuation Min Distance and Attenuation Falloff Distance. Since the Debug Draw API uses centimeters, you must convert the values.
10. Complete Script

    ```verse
    using { /Fortnite.com/Devices }
         using { /Fortnite.com/Characters }
         using { /Fortnite.com/Playspaces }
         using { /UnrealEngine.com/Temporary/Diagnostics }
         using { /UnrealEngine.com/Temporary/SpatialMath }
      
         debug_audio_device := class(creative_device):
      
             @editable
             AudioPlayerDevice:audio_player_device = audio_player_device{}
      
             @editable
             DebugAttenuationMinDistance:float = 100.0
      
             @editable
             DebugAttenuationFalloffDistance:float = 100.0
      
             DebugDrawAudio:debug_draw = debug_draw{Channel := debug_draw_audio}
      
             OnBegin<override>()<suspends>:void=
      
                 DrawAudioDeviceRange(DebugAttenuationMinDistance, DebugAttenuationFalloffDistance)
      
             DrawAudioDeviceRange(AttenuationMinDistance:float, AttenuationFalloffDistance:float):void =
                 AudioPlayerDeviceTransform:= AudioPlayerDevice.GetTransform()
                 DebugDrawAudio.DrawSphere(
                     AudioPlayerDeviceTransform.Translation,
                     ?Radius:= AttenuationMinDistance,
                     ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)
                 DebugDrawAudio.DrawSphere(
                     AudioPlayerDeviceTransform.Translation,
                     ?Radius:= AttenuationMinDistance + AttenuationFalloffDistance,
                     ?DrawDurationPolicy:= debug_draw_duration_policy.Persistent)
    ```
