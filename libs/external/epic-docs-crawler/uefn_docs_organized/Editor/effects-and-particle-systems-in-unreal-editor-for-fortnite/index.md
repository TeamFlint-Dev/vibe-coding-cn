# Effects and Particle Systems

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/effects-and-particle-systems-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:19:31.901457

---

Visual effects ([VFX](unreal-editor-for-fortnite-glossary#vfx)) help create ambience in a level, and when used in a cinematic, they set the scene. Unreal Editor for Fortnite (UEFN) uses the [**Niagara** system](https://docs.unrealengine.com/system-and-emitter-module-reference-for-niagara-effects-in-unreal-engine/) to create custom VFX.

Here are a few interesting ways you can use custom effects in UEFN:

- Attach an effect to the [**Prop Mover**](https://www.fortnite.com/en-US/creative/docs/using-prop-mover-devices-in-fortnite-creative) device and move your effect across a section of your island to simulate snow, lightning, or magical effects.
- Trigger an effect with the [**Trigger**](https://www.fortnite.com/en-US/creative/docs/using-trigger-devices-in-fortnite-creative) device to cause surprise, or create a specific atmosphere or mood.
- Set off a sequence of effects and devices together with the [**Pulse Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-pulse-trigger-devices-in-fortnite-creative) device.
- Create an effect that looks like snow, or leaves falling from trees.

If you’re already familiar with the [Niagara](unreal-editor-for-fortnite-glossary#niagara) system tutorial [emitters](unreal-editor-for-fortnite-glossary#emitter), jump to the [firework tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-using-niagara-in-unreal-editor-for-fortnite) below to learn how to use [empty emitters](unreal-editor-for-fortnite-glossary#empty-emitter). If you aren’t, then refer to the [Creating Custom Modules](https://docs.unrealengine.com/getting-started-in-niagara-effects-for-unreal-engine/) documentation.

All custom VFX can be referenced by Fortnite devices, and can be selected to replace the effects that come natively with UEFN.

You can create your own VFX to:

- Add smoke effects to weapons and fires.
- Add weather effects like lightning and snow.
- Add moving dust particles to a cinematic.

For a deep dive on how the Niagara system works, refer to the following Unreal Engine documents.

- [**Niagara Overview**](https://docs.unrealengine.com/overview-of-niagara-effects-for-unreal-engine/): For information about how to modify and create an effect and its behavior.
- [**Events and Event Handlers Overview**](https://docs.unrealengine.com/events-and-event-handlers-in-niagara-effects-for-unreal-engine/): To learn more about using multiple effects together.

## Using the Standard VFX

The visual effects that come packaged with UEFN are in the [Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#content-browser) inside the **VFX** folder. All effects inside the folder are locked, meaning you cannot open them or change their configurations.

[![The VFX folder holds numerous visual effects.](https://dev.epicgames.com/community/api/documentation/image/5917e7ce-5a05-473e-9b7b-d6c071deee06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5917e7ce-5a05-473e-9b7b-d6c071deee06?resizing_type=fit)

*Click image to enlarge.*

Drag these effects into the [viewport](unreal-editor-for-fortnite-glossary#viewport) to use them on your level. Standard VFX packages that come with UEFN include:

| Effect Name | Description |
| --- | --- |
| **Campfire Smoke** | A curling length of dark smoke that rises. |
| **Gas Explosion** | A burst of firelight and smoke. |
| **Grenade Explosion** | A burst of firelight and smoke. |
| **Impact** | A series of sparks of differing weight and volume. |
| **Metal Impact** | A series of sparks of differing weight and volume, accompanied by smoke. |
| **Burst Rifle** | A burst of flame. |
| **Rifle Loop** | Looping bursts of fire and smoke. |
| **Shallow Water** | Gentle concentric rings and sparkle effects. |
| **Spawn Effect** | Smoke and sparkle effects. |
| **Stone Impact** | A dust cloud and scattering rock effects. |
| **Torch** | A flickering flame and slight amount of rising smoke. |
| **Wood Impact** | A small. translucent cloud of dust and wood splinters. |

## Creating Your Own VFX

Learn how to create your own effects by trying the different [**Niagara Tutorials**](https://docs.unrealengine.com/tutorials-for-niagara-effects-in-unreal-engine/).

Not all Effect nodes and Emitter settings are available in UEFN. This affects the following tutorials:

- **Particle Effects:** No Actor Component Interface Effect Node.
- **Beam Effect:** No Engine Content or Plugin Content settings.
- **GPU Sprite:** No Emitter, Sphere Location, or settings, but UEFN has additional Sprite Size Modes not available in Unreal Engine.
- **Sprite Smoke:** Requires a smoke material before beginning the tutorial.
- **Dark Smoke:** Depends upon the completion of the Sprite Smoke tutorial.
- **Steam Effect:** Depends upon the completion of the Sprite Smoke tutorial.

To help you understand how effects work, refer to the [basic firework tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-using-niagara-in-unreal-editor-for-fortnite) to build a simple fireworks display.
