# VFX Spawner Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:32:33.344579

---

With **VFX Spawner** devices, you can place different [visual effects](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#vfx) around your island.

These effects fall into one of two types:

- **Continuous**: Once activated, the effect will continue to loop until it is deactivated.
- **Burst**: A quick effect that occurs once, then stops.

Things you can do with the VFX Spawner device include:

- Use a burst effect, such as a poof of dust or a small explosion, to mask the spawning of a prop.
- Use any of the musical note effects to visually show the source of music.
- Simulate weather with effects like rain or snow, or even a tornado!

These effects are also useful for ambience. Integrating an effect with your environment can create subtle, effective moods.

**Looking for more inspiration?** See [**D-Launcher Device Design Examples**](d-launcher-device-design-examples-in-fortnite-creative.INT.udn) to kick off your imagination!

To find the VFX Spawner device, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be helpful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](event-browser-in-fortnite-creative).

## Contextual Filtering

Some devices are affected by a feature called **contextual filtering**. This feature hides or displays options depending on the values selected for certain related options. This reduces clutter in the Customize panel and makes options easier to manage and navigate. To help identify them, values that trigger contextual filtering are in *italic*.

All options are listed, including those affected by contextual filtering; if they are hidden or displayed based on a specific option's value, there will be a note about it in the Description field for that option.

## Device Options

This device has some basic functionality, like setting the type of effect and the speed of the effect's looped animation. Additionally, there are some advanced options, like the phases when the effect is enabled.

Default values are **bold**. Values that trigger contextual filtering are *italic*.

You can configure this device with the following options.

| Option | Value | Description |
| --- | --- | --- |
| **Effect Type** | ***Continuous***, *Burst* | Determines whether the effect will play in a continuous loop, or in a short burst, then stop. The next option changes based on what you select here. |
| **Visual Effect** | **Fireworks**, Pick an effect | This sets the type of visual effect the device produces when the **Effect Type** is set to **Continuous**. See [Continuous Effects](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative#continuous-effects) for a list of available effects. |
| **Burst Visual Effect** | **Explosion Small**, Pick an effect | This sets the type of visual effect the device produces when the **Effect Type** to **Burst**. See [Burst Effects](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative#burst-effects) for a list of available effects. |
| **Sound Effect** | **Default**, None, Pick a sound | Determines what sound plays when the visual effect is spawned. **Default** plays whatever sound is attached to a visual effect (such as **Lightning**), but you can override the default by picking a different option. Some of the sounds are a short burst, while others are continuous. See the **Sound Effects** section for a list of available sounds. |
| **Enabled on Phase** | None, **Always**, Pre-Game Only, Gameplay Only, Create Only | Determines the phases in which the device is enabled. |
| **Colorize VFX** | *On*, **Off** | Sets whether the spawned effects use the color selected in the **Custom Color** option. This is useful if you want to assign colors to your effects based on teams. If set to **On**, this makes the next option, **Custom Color**, available |
| **Custom Color** | **Cerulean**, Pick a color | Choose a custom color for the VFX. Click the color swatch to open the Color Picker. Select a color, then click the checkmark. Note that this option only displays when the **Colorize VFX** option is set to **On**.  [Color Picker](https://dev.epicgames.com/community/api/documentation/image/8f029a0a-1690-4397-9df4-1617a13466ab?resizing_type=fit) |
| **Visible to Team** | **Any**, Pick or enter a team | Determines which team can see the VFX. |
| **Invert Team Selection** | On, **Off** | If this is set to **On**, all teams can see the VFX except the team selected in the **Visible to Team** option. |
| **Visible to Class** | No Class, All, **Any**, Pick or enter a class | Determines which classes can see the VFX.  Values for this option are:   - **No Class**: Only players without an assigned class can see this effect. - **All**: All players with an assigned class can see this effect. - **Any**: All players, with or without an assigned class, can see the effect. - **Pick or enter a class**: Only players on the selected class can see the effect. |
| **Invert Class Selection** | On, **Off** | If this is set to **On**, all classes can see the VFX except the class selected in the **Visible to Class** option. |
| **Spawn Rate** | **1.0**, Pick or enter a number | Determines the rate at which the effects are spawned. |
| **Enable on Reset** | **On**, Off | If this is set to **On**, the disabled device will automatically be enabled when the **Reset When Receiving From** function is triggered. |
| **Enabled Time** | **Infinite**, Pick an amount | The length of time the visual effect is enabled. |
| **Clear Particles on Disable** | **On**, Off | If this is set to **On**, spawned effects will be cleared when the device is disabled. If it is set to **Off**, spawned particles will be cleared at the end of their animation. |

## Direct Event Binding

Direct event binding allows devices to communicate directly, which makes your workflow more intuitive, and gives you more freedom to focus on your design ideas.

Below are the following direct event binding options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Event** and select the event that triggers this function.
3. If more than one device or event triggers a function, press the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Restart When Receiving From** | This function resets the device when an event occurs. |

### Events

Direct event binding uses events as transmitters. An event tells another device to perform a function.

1. For any event option, click the **option**, then **Select Device** to access and select from the **Device dropdown menu**.
2. Once you've selected a device, click **Select Function** to bind the event to a function for that device.
3. If more than one function is triggered by the event, press the **Add** button and repeat.

| Option | Description |
| --- | --- |
| **On Effect Enabled Send Event To** | When an effect is enabled, an event occurs. |
| **On Effect Disabled Send Event To** | When an effect is disabled, an event occurs. |

## Continuous Effects

Here is a list of the currently available continuous visual effects.

- **Fireworks**: Fireworks that go off randomly near the device, with sound effects.
- **Large Fireworks**: Fireworks that go off randomly but high in the sky, with sound effects.
- **Leaves**: Leaves that drift through the air, giving a sense of autumn.
- **Eyes**: A collection of creepy eyes, that might be peering out of the darkness.
- **Bats**: Bats flying through the air evoke Halloween.
- **Lightning**: Lightning striking the ground, with sound effects.
- **Lightning\_2**: Lightning bolts going away from the device, with sound effects.
- **Lightning\_3**: Lightning striking the ground with an explosion on impact, including sound effects.
- **Embers**: Small embers floating up, as though from an open fire.
- **Fog**: A drifting pattern of fog.
- **Sparkles**: Sparkly bits of light that move around.
- **Disco Balls**: An assortment of mirrored balls of varying sizes.
- **Laser Beams**: Focused, moving beams of light that shoot out of the top of the device.
- **ConcertRain**: Falling lights that suggest a mix of meteorites and distant strikes of lightning.
- **SparkRain**: Colorful rainfall that includes sound effects.
- **Area of Fog**: Ground-level clouds of fog that move continually.
- **Spooky Ghosts**: Ghostly figures that move in and out of the player's vision in a spooky fashion.
- **Balloons**: Colorful balloons that float up into the sky until they cheerfully disappear.
- **Snow**: A gentle sprinkle of snow.
- **Floating Space Rocks**: Space rocks (meteorites) that float mysteriously in the air.
- **Bubbles**: Iridescent bubbles that look like they're fresh from a bubble machine.
- **Falling Sparkles**: Similar to sparkles, but instead of moving around, they're slowing falling to the ground.
- **Confetti**: Falling bits of paper — perfect for a parade!
- **Flying Space Rocks**: Space rocks (meteorites) falling from the sky.
- **Dust Clouds**: Imagine moving across a dune on a dirt bike. These are the clouds your bike might kick up.
- **Rain**: A steady drizzle of rain.
- **Small Tornado**: A tornado that spins upward.
- **Light Fog**: A fog light enough to see through easily.
- **Sky Lanterns**: Colorful paper lanterns you might see rising over a pond or lake for a festival.
- **SkyLanterns\_A**: Like the previous lanterns, but these are all red.
- **SkyLanterns\_B**: Like the previous lanterns, but all blue.
- **SkyLanterns\_C**: Like the previous lanterns, but all green.
- **Waterfall Crash**: Roiling water like what appears at the bottom of a high waterfall.
- **Waterfall Splash**: Splashing water like what you might see at the foot of a smaller waterfall.
- **Waterfall Mist**: A light mist like you'd find at the edge of a gentle waterfall.
- **Musical Notes Bubbles**: Musical notes that act like bubbles and pop.
- **Musical Notes Chrome**: Notes with a metallic sheen.
- **Musical Notes Goo**: Notes that are dripping a black goo.
- **Musical Notes Retro**: Notes that look three-dimensional.
- **Musical Notes Glitch**: Notes that look like the colors are out of register, and that have odd, glitchy behavior.
- **Musical Notes Wood**: Notes that look like they're carved from wood.
- **Small Fire**: A small fire effect, like you might use with a torch or brazier.
- **Trash Can Flies**: A cloud of flies that would typically be seen around a garbage pile or container.
- **Ambient Dust**: Flecks of material floating in a random way, such as dust particles that hang in the air in an old abandoned building.

## Burst Effects

Here is a list of the currently available burst effects.

- **Explosion Small**: A small explosion with sound effects.
- **Explosion Medium**: A slightly larger explosion with sound effects.
- **Explosion Large**: An even larger explosion with sound effects.
- **Explosion Electrical**: A large explosion with sound effects that mimics a transformer blowing or a similar electrical explosion.
- **Dust Poof**: A light poof of dust, enough to partially hide the spawning of a new effect.
- **Small Splash**: A limited, small splash such as that made by dropping or throwing a small object into water.

## Sound Effects

Here is a list of the currently available sound effects you can use with your visual effect.

- **Default**: Uses any sound effects that are attached to a visual effect. If none are attached, then the effect is silent.
- **None**: Turns off any default sound effects.
- **Alpine**: Suggests wind moving briskly through an snowy forest.
- **Alpine\_Evening**: Similar to Alpine, but with a hollower and more resonant tone.
- **Alpine\_Morning**: Similar to Alpine, but with a softer and higher pitched whistling sound.
- **Bats**: The sound of bats soaring through the air. Works well with the Bats effect.
- **Beam**: A continuous rumble and whine that rises and falls in pitch. Could be used with the Laser Beam effect, or used for a rocket ignition.
- **Beam\_Attack**: Similar to the Beam, but this sound is a short burst.
- **Beam\_Impact**: This sound is also a short burst. Either Beam Attack or Beam Impact could be used for a laser weapon hitting a target.
- **Breeze**: Unlike Alpine, which is a brisk winter or snowy wind, this is gentler and slower, suggesting a warm breeze swaying the treetops.
- **Fireworks**: A short boom, trailing off into crackling.
- **Charge**: A large rumbling, leading into higher pitched whizzing.
- **Charged\_Attack**: A larger, more intense rumble followed by crackling instead of whizzing.
- **Charge\_Loop**: A slowly building, rising whine looped to stretch out the rising tone.
- **Ghost**: A ghost moaning.
- **Halloween\_Laugh**: An eerie laugh.
- **Halloween\_Singing**: A voice singing wordlessly in a minor key, in a large echoing space. This is randomized, slightly different each time it plays.
- **Halloween\_Whispers**: Unintelligible murmuring that may be human or machine, with distant laughter.
- **Lightning\_Strike**: The sound of lightning striking.
- **Lightning\_Strike\_02**: A variation of the lightning strike, with slightly different impact sound.
- **Lightning\_Strike\_03**: A variation of the lightning strike, with slightly different impact sound from the two other lightning strike effects.
- **Lightning\_Strike\_04**: A variation of the lightning strike, with slightly different impact sound from the two other lightning strike effects.
- **Electricity**: A crackling and buzzing sound, like a Tesla coil.
- **Electricity\_02**: A longer and quieter crackling, buzzing sound. Similar to the sound of laser swords swinging and connecting.
- **Electricity\_03**: Like Electricity 2, but with interrupting staccato zaps or shots.
- **Electricity\_04**: A solid ka-chunk with quiet buzzing in the background, as if you are throwing a large switch or breaker.
- **Electricity\_05**: Similar to Electricity 4, but louder. Could be an explosion or shot as much as it could be a switch thrown.
- **Electricity\_06**: Similar to Electricity, but smoother and with less crackling.
- **Explosion**: A small detonation, or a gun going off.
- **Explosion\_02**: A large detonation, or a large gun or cannon firing.
- **Explosion\_03**: A quieter large detonation, like a cannon firing from a distance.
- **Impact**: The sound of an small or medium sized object hitting a floor or wall.
- **Impact\_02**: An impact with some rattling, like a full bag hitting a floor or wall.
- **Impact\_03**: An impact with sounds of breaking or destruction.
- **Impact\_04**: A short muffled thud.
- **Impact\_05**: Another cannon shot, at medium distance.
- **Impact\_06**: A sharper gun shot sound.
- **Impact\_Junk**: The sound of junk (metal and glass) being tossed around and broken, or of something landing on a junk pile.
- **Impact\_Squish**: A thud ending in squelching sounds, like a thrown object landing on something wet.
- **Electric\_Blast**: Like Electricity combined with Explosion 2 or 3. Impact or blasting sound, but accompanied by buzzing and crackling.
- **Jolt**: A very short zap, like an energy weapon blast.
- **Whistling\_Projectiles**: A sound like a rocket or missile passing by, but with no impact sound at the end.
- **Ominous\_Loop**: An eery, resonant instrumental chord. Dies out, then comes back.
- **Projectile**: Like Whistling Projectiles, but with a larger number of missles or rockets, at varying distances.
- **Night\_Wind**: A high wind on a moor or a plain, with soft squeals and moans mixed in.
- **Steamy\_Vent**: The sound of liquid boiling, with a whistling sound like steam escaping through a small hole.
- **Storm**: A loud rumbling mixed with electric buzzing and crackling.
- **Spooky\_Laugh**: High pitched, echoing laughter.
- **Vent\_Launch**: A burst of air, sound of a vent releasing.
- **Weak\_Point**: The creaking sound of metal breaking.
- **Wind**: Similar to Alpine or Breeze, but with a louder burst like a gust of wind.
- **Woosh**: A wooshing sound, like something passing by very fast.
- **Woosh\_02**: The sound of an object being swung past you very fast, such as a sword.
- **Splash**: An impact sound and light splash, as if something had been thrown into a liquid.
- **Impact\_Soft**: A very quiet impact, like a small object landing on a soft surface.
- **Pickup**: Something being picked up.
- **Pickup\_02**: Like Pickup, but even quieter.
- **Pickup\_03**: Like Pickup, but with quiet rustling like cloth.
- **Fuse**: A crackling or fizzling sound, like a long fuse on a bomb.
- **Heal**: A quiet high pitched ringing with a deeper hum underneath it, on a loop.
- **Health\_Field**: A background sound similar to the Heal sound, but with crackling sounds of impacts on top of it.
- **Healing\_Grenade\_Underwater**: A plop into water followed by air bubbles moving up to the surface.
- **Health\_Zone**: Similar to Heal, but barely audible and with a more resonant background hum.
- **Heal\_Serene**: Similar to Health Zone, but instead of ringing there is high pitched chimes or voices on top.
- **Heal\_Tranquil**: Very faint ringing, with a higher pitched resonant hum similar to running your finger around the rim of a glass.
- **Burn**: The sound of a crackling fire.
