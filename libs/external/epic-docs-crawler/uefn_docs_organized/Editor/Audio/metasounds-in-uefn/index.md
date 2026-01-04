# MetaSounds in UEFN

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/metasounds-in-uefn
> **爬取时间**: 2025-12-26T23:16:22.752292

---

[MetaSounds](https://dev.epicgames.com/documentation/en-us/unreal-engine/metasounds-in-unreal-engine?application_version=5.5), the powerful audio system that provides node-based procedural sound design in Unreal Engine, is now available in UEFN as read-only. It replaces traditional static wave files with a flexible, modular approach, offering greater creativity and efficiency in sound design.

UEFN now has **two** exposed MetaSound source files, allowing you to make **MetaSound presets**. Currently, you cannot add your own [MetaSound nodes](https://dev.epicgames.com/documentation/en-us/unreal-engine/metasounds-reference-guide-in-unreal-engine?application_version=5.5) in the MetaSound editor or edit the exposed MetaSounds graph. This is a first step in the process of fully exposing MetaSounds to UEFN creators.

## Creating MetaSound Presets

Open a UEFN project, then in the Content Browser, navigate to **Epic** > **Audio** > **MetaSounds** > **Sources**.

You can also set the search filter to **Audio** > **MetaSound Source**.

[![](https://dev.epicgames.com/community/api/documentation/image/c4e20a40-d7dd-4cd9-87fe-39ef2f3f0f3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4e20a40-d7dd-4cd9-87fe-39ef2f3f0f3e?resizing_type=fit)

Right-click one of the MetaSound Sources and select **Create MetaSound Source Preset**.

[![](https://dev.epicgames.com/community/api/documentation/image/b0348f02-4bdf-487a-a13b-a0d0d6b9cad5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0348f02-4bdf-487a-a13b-a0d0d6b9cad5?resizing_type=fit)

Select a location in your project folder and press **Save**.

A MetaSound Preset maintains a reference to the base MetaSound Source and allows you to override settings, including adding your own sound waves and modifying other properties.

## The MetaSound Sources

The two exposed MetaSound Sources are **MSS Play Random Loop** and **MSS Play Random Oneshot**.

[![](https://dev.epicgames.com/community/api/documentation/image/2f928d08-c693-4347-8ae5-87619b555435?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f928d08-c693-4347-8ae5-87619b555435?resizing_type=fit)

Once you have created the presets in your project folders, you can use the **MSS Play Random Loop** as a simple looping MetaSound that randomly selects from an array of Sound Waves. Parameters to randomize the volume and pitch of the sounds are also exposed.

**MSS Play Random Oneshot**is a one-shot variant but otherwise identical.

To edit any of the properties, click **Override Inherited Default**, then make your own selections or add your own sound wave files.

[![](https://dev.epicgames.com/community/api/documentation/image/ee3f3a02-0687-46c7-9aee-9e581eb891f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee3f3a02-0687-46c7-9aee-9e581eb891f9?resizing_type=fit)

## Playing the MetaSound Presets

MetaSound Presets inherit from SoundBase and are playable using [Audio Devices in UEFN](https://dev.epicgames.com/documentation/en-us/uefn/audio-in-unreal-editor-for-fortnite).

To learn more about MetaSounds in Unreal Engine, check out the [MetaSounds documentation](https://dev.epicgames.com/documentation/en-us/unreal-engine/metasounds-in-unreal-engine).
