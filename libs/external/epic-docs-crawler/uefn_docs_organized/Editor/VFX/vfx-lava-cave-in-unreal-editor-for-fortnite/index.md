# Lava Cave with VFX

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/vfx-lava-cave-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:19:47.021859

---

The Lava Cave VFX template demonstrates a combination of visual effects that draw the player into the environment. These effects can add depth to your level design and gameplay.

Unreal Editor for Fortnite (UEFN) offers many [VFX](https://dev.epicgames.com/documentation/en-us/fortnite/visual-effects-in-unreal-editor-for-fortnite) tools, such as post-processing, [customizable lights](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-customizable-light-devices-in-fortnite-creative), and Niagara effects.

With Lava Cave, players set out on a brief volcanic journey to retrieve a lost sword. The gameplay theme is strengthened with dramatic cutscenes and a [post-processing](https://dev.epicgames.com/documentation/en-us/fortnite/intro-to-postprocessing-in-unreal-editor-for-fortnite) shimmer volume that creates visual heat waves.

Use a combination of VFXs and prop assets to add dynamic elements that enhance your environment visually. This template uses a variety of light sources to create glows and visual contrasts.

Lava Cave also uses props like customizable lights, firepits, and lava assets to highlight and give contrast to walls and statues. These props often come as Niagara actors with their own point lights attached, and can be found in the **Fortnite** > **Props** folder of the **Content Browser**.

Below is a peek at features and tools used to create the Lava Cave environment. You can find this experience in the **Feature Examples** section of the **Project Browser**.

## Brazier VFX

Use a combination of lights as VFX to create an ambiance that fits your theme.

[![FirePit](https://dev.epicgames.com/community/api/documentation/image/108468de-5b8a-40a8-8da8-830538412b0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/108468de-5b8a-40a8-8da8-830538412b0d?resizing_type=fit)

Combine the VFX device with Niagara [**point lights**](https://dev.epicgames.com/documentation/en-us/unreal-engine/point-lights-in-unreal-engine?application_version=5.3) to create effects similar to the braziers in Lava Cave.

[![Spot Lights](https://dev.epicgames.com/community/api/documentation/image/2a61e80a-9b95-4f6c-b81b-8723fd82201b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a61e80a-9b95-4f6c-b81b-8723fd82201b?resizing_type=fit)

Lava Cave also uses [spotlights](https://dev.epicgames.com/documentation/en-us/unreal-engine/spot-lights-in-unreal-engine?application_version=5.3) to cast an orange glow from statue bases and accent pieces in the environment.

## Torch Fires

Use assets like customizable lights as bursts of VFX in your project. These assets could be imported from the [Fab Marketplace](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite) or found in the **Fortnite** < **Galleries** < **Customizable Light Gallery** folder in the **Content Browser**.

[![Torchlight](https://dev.epicgames.com/community/api/documentation/image/ec704727-df78-4b45-b1e0-b967743279a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ec704727-df78-4b45-b1e0-b967743279a7?resizing_type=fit)

Lava Cave uses a torch Niagara asset from the [**Customizable Light Gallery**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-audio-and-visual-effect-galleries-in-fortnite-creative) that has an attached point light.

You can also use [Lumen](lighting-quick-start-guide-in-unreal-editor-for-fortnite) and other light tools to brighten specific areas.

For level lighting, Lava Cave also uses the [**Day Sequence**](day-sequence-device-in-unreal-editor-for-fortnite) device along with the [**Lumen Exposure Manager**](lumen-exposure-manager-in-unreal-editor-for-fortnite) to add level lighting to this experience.

## Falling Particles and Camera Effects

You can use the [**VFX Creator**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-vfx-creator-devices-in-fortnite-creative) device to create particle effects in your gameplay. VFXs such as [falling dust](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-realistic-dust-particle-effect-in-unreal-editor-for-fortnite) and fire pit smoke are used to bring the Lava Cave environment to life.

[![Falling Particles](https://dev.epicgames.com/community/api/documentation/image/ddb652a6-2ede-4847-92ad-2701cfa90422?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ddb652a6-2ede-4847-92ad-2701cfa90422?resizing_type=fit)

[**Trigger**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-trigger-devices-in-fortnite-creative) devices are used to start a [cinematic](cinematic-sequence-device-in-unreal-editor-for-fortnite) where particles fall from the ceiling, causing an earthquake-styled [camera shake](camera-shake-effect-in-unreal-editor-for-fortnite). A combination of [Niagra actors](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-using-niagara-in-unreal-editor-for-fortnite), VFX Creator devices, camera shakes, and post-processing are also used to further transform the environment.

## Lava Bursts

You can find many Niagara VFX under **Fortnite** < **VFX** of the **Content Browser**.

[![Lava Bursts](https://dev.epicgames.com/community/api/documentation/image/fdc5cc8d-331a-46c7-a53a-07c5dcf87fd1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdc5cc8d-331a-46c7-a53a-07c5dcf87fd1?resizing_type=fit)

Lava Cave uses Lava Burst Niagrara actors on top of lava tiles to create a realistic volcanic environment.

Combine the effects mentioned above to create an engaging environment that strengthens your gameplay.
