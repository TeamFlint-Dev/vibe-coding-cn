# 1. Device Information

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-1-device-information-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:42:25.301234

---

## Island Day Sequence Device

The default **Day Night Cycle** is based on the look of **Fortnite Chapter 4**. Press the **1** key to go to the **island center**. This is where the base look for the whole island is established.

Any adjustments made here will affect all the quadrants except the areas where a **Trigger Volume** functionality is used. Trigger Volumes will be examined in more detail later in this tutorial.

Bold, incremental changes are recommended to establish a middle ground for your natural lighting. Establish your base look first with as few adjustments as possible, then work on unique details for each biome individually.

Establishing a middle ground with minimal adjustments means you won’t have to dig through multiple settings every time you make adjustments.

The main goal in the island center is to start departing from the Fortnite look and establish effects and features that all the biomes will share. This includes [exposure compensation](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#exposure-compensation), [saturation](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#saturation), [chromatic aberration](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#chromatic-aberration), [bloom](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#bloom) and [local exposure](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#local-exposure).

[![Begin at the center of the island where the base look for the environment is created.](https://dev.epicgames.com/community/api/documentation/image/419a43d3-d491-4d3b-8283-b828c5bd008e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/419a43d3-d491-4d3b-8283-b828c5bd008e?resizing_type=fit)

### Lumen Exposure Manager

The **Lumen Exposure Manager** in the central part of the island provides a way to control how Lumen looks for high-end platforms and Non-Lumen looks for low-end platforms. However, controlling the look using the Lumen Exposure Manager is redundant because the default settings on the Day Sequence device already have functionality under the hood to handle these platforms.

Since the Day Sequence device cannot be modified, this tutorial uses the Lumen Exposure Manager as a solution for scalability limitations.

Start with the Lumen Exposure Manager to see which settings were adjusted. Select the **Lumen Exposure Manager C** and in the Details panel, click the cog on the right-hand side to select the **Show Only Modified Properties** setting.

For the purpose of this template, the Lumen Exposure Manager controls are pushed a bit for demonstration. Be mindful that this will have a performance impact as the post process stack will have more post processing values (PPVs) to go through.

[![Lumen Exposure Manager](https://dev.epicgames.com/community/api/documentation/image/18b08798-b090-4e53-9c04-1df9f7ecd5b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18b08798-b090-4e53-9c04-1df9f7ecd5b5?resizing_type=fit)

Inside the Lumen Exposure Manager are two pre-integrated post process volumes that control the look of the environment, depending on scalability. To change scalability settings, click the **Performance and Scalability** dropdown, and select **Viewport Scalability.**

[![Open the Performance and Scalability dropdown and select Viewport Scalability](https://dev.epicgames.com/community/api/documentation/image/17672de8-039e-43a8-93e2-925341b92f13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17672de8-039e-43a8-93e2-925341b92f13?resizing_type=fit)

Open the Viewport Scalability settings

For the Low to Medium settings, select **Non Lumen Post Process**, and for High to Epic settings, select **Lumen Post Process**.

Low-end platforms have lower budgets for lighting and do not use Lumen when rendering.

If you hide and unhide the **Lumen Exposure Manager** you can see that it makes a small adjustment to the overall scene.

Basically, the scene becomes desaturated and the exposure changes a bit and we add a bit more [vignetting](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#vignette). This is to have a more neutral look that starts to diverge from the default Fortnite look.

Here’s a quick breakdown of the changes made:

- The time of day was set between **4–6 am**, depending on the biome to keep the sun low.

  When working on exterior lighting, it’s important to choose your time of day first, as this affects the direction and length of your shadows, giving your map a more interesting look.
- The Exposure was lowered to **0**.
- Chromatic Aberration was set to **0.3** to add a cinematic look.
- Vignette was set to **0.6** to add to the cinematic" look.
- Global Saturation was set to **0.8** to make the scene look less cartoon-like.
- Film Grain was set to **0.2** to add some visual interest.

![Default look (Epic Scalability)](https://dev.epicgames.com/community/api/documentation/image/2f6f9e87-4dd4-468f-acc1-6c9be8155329?resizing_type=fit&width=1920&height=1080)

![Slightly adjusted / Neutral look (Epic Scalability)](https://dev.epicgames.com/community/api/documentation/image/e7c110de-94cc-4921-9b72-7a7878406fd2?resizing_type=fit&width=1920&height=1080)

Default look (Epic Scalability)

Slightly adjusted / Neutral look (Epic Scalability)

If you aren’t making significant changes to the look of your island, don't add the **Lumen Exposure Manager** as it will make your project more complex than it needs to be.

This template creates drastic changes that need the Lumen Exposure Manager to make the low-end scalability looks as consistent as possible to the high-end Lumen based looks.

Once the **neutral** or **base look** is established for the high-end scalability settings, here’s how it looks and feels on low scalability. The necessary settings are adjusted inside the **Non Lumen Post Process** for low-end platforms.

For this step, you’ll change your scalability settings by opening **Performance and Scalability** > **Viewport Scalability**.

![Slightly adjusted / Neutral look (Low Scalability)](https://dev.epicgames.com/community/api/documentation/image/de0d84b2-12d9-4d64-9075-3e11327597d3?resizing_type=fit&width=1920&height=1080)

![Slightly adjusted / Neutral look (Medium Scalability)](https://dev.epicgames.com/community/api/documentation/image/cfa9fcd1-2081-46ce-ba9c-bccd2fc786ff?resizing_type=fit&width=1920&height=1080)

Slightly adjusted / Neutral look (Low Scalability)

Slightly adjusted / Neutral look (Medium Scalability)

Hide and unhide the **Lumen Exposure Manager** again, but this time, select the **Non Lumen Post Process** component in the Details panel so you can see which settings were adjusted.

At this point, you’re still working on the general look of the project by adjusting a few key settings to get as close as possible to the Lumen scalability on low-end platforms. Experiment by adjusting the following settings:

- The **Exposure** setting is the same at **0.0**. Notice how it changes to **Auto Exposure Basic** automatically. This helps performance on low-end devices.
- For this template, the **Lumen Local Exposure** uses the default values, but in the **Non Lumen** category the **Shadow Contrast** setting was changed. This helps compensate for lost light in the shadowed areas since Global Illumination no longer affects the scene.

You should notice that even default settings will be different in Local Exposure between Lumen and Non-Lumen settings.

[![Local Exposure control for shadows.](https://dev.epicgames.com/community/api/documentation/image/8a5a2fa0-7910-402d-b5a1-9b4c7afaffb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a5a2fa0-7910-402d-b5a1-9b4c7afaffb3?resizing_type=fit)

[White balance](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#white-balance), or temperature, helps you get closer to your original look by shifting the overall temperature of the scene to a warmer or colder tone. This depends a lot on scene materials and light colors, so you will have to toggle between low and high scalability to make sure your colors look as close as possible between high and low-end platforms.

While global illumination is not as apparent in an exterior scene, it does have a significant effect on it. Adjust the [white balance](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#white-balance) to find the middle ground for your scene.

[![The scene is being edited according to White Balance / Temperature.](https://dev.epicgames.com/community/api/documentation/image/918c444a-1e10-4e38-9395-d20b38037839?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/918c444a-1e10-4e38-9395-d20b38037839?resizing_type=fit)

You could stop after adjusting these settings in your project, or continue to customize the environment to your own style. Remember that not all games use the same environmental look. You may want to set a certain mood for players elsewhere on your island.

## Next Section

[![2. North Biome](https://dev.epicgames.com/community/api/documentation/image/238560ea-2c86-4f21-bc94-11706df4a547?resizing_type=fit&width=640&height=640)

1. North Biome

Learn how to use the Day Sequence device to create custom outdoor lighting for cold environments.](<https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-2-north-biome-in-unreal-editor-for-fortnite>)
