# 3. South Biome

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-3-south-biome-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:42:30.877357

---

## South - Jungle/Swamp

Remember that the Day Sequence device at the center of the island establishes the neutral look for the entire island. To create a biome that is different from the neutral island center, another Day Sequence device was added to the Southern quadrant.

Travel to the Jungle biome by pressing the **4** key.

*Trigger Volume Area transition point.*

To begin creating the look of the Southern quadrant, think about the major differences between the looks you want to achieve.

For example, in the Jungle biome, you have to think about the lighting and environmental changes that will make this quadrant feel like a jungle, aside from the large trees, vegetation, and mossy rocks used as set dressing to build the terrain.

### Jungle Secondary Day Sequence Device

To create the jungle environment, you’ll need to simulate humidity, with around 80% cloud coverage, and rays of light coming through the tree canopies, creating lots of light and shadow in the scene.

[![The Southern biome](https://dev.epicgames.com/community/api/documentation/image/677c0ea6-7aac-4ffa-97c6-6af41c255482?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/677c0ea6-7aac-4ffa-97c6-6af41c255482?resizing_type=fit)

Select the **Day Sequence Device\_South** asset from the **South** folder in the Outliner and ensure **Show Only Modified Properties** is toggled on in the Details panel.

Below is a list of options and settings used to achieve the jungle aesthetic.

Remember, start with the adjustments that matter most, like time of day, sunlight color, skylight color, and temperature. After these, you can add more refined changes, like lens flares or lens effects such as vignetting and chromatic aberration.

- **Time of Day:** The time value is set to **4.2am**. This setting lowers the angle of the sun and causes rays of light to pour through the tree canopy. This is a good example of how Time of Day affects or influences the mood of a scene for a drastic change in look.

- **Rotation on Z:** The value is set to **-10**. This rotates the whole system and moves the sun disk to the left, which results in more rays of light through the tree canopy.
- **Fog:** The fog density value was increased to **0.3** from the default (0.01). For reference, the North quadrant is set to 1.2.

  - **Fog Color:** The jungle is saturated in hues of green to create a swampy environment. (The North quadrant is desaturated using hues of blue.)

You’ll have to experiment with color for your own purposes. Remember to be bold, you’ll find a middle ground to create the look you’re going for much faster. You’ll also know how much of the color you selected is too much.

- **Directional Inscattering Color:** This is the color that the volumetric fog takes from the sun. The change should be subtle — don’t make drastic changes with this setting.
- **Skylight**: A middle tone of green and aqua was used to stop the shadows from looking blue and take on a greenish tint.

Skylight is one of the most important settings that affects your scene along with Time of Day. These options should be your focus when doing a first pass.

Once you’ve established your Time of Day value, the Skylight will be key to finding the look you want.

- **Sky:** Here you can change the color of the sky gradient and blend it with sky of the default Day Sequence device, or completely override it based on the Intensity value.

  - **Sky Gradient Low Color:** The value is set to **0.5,** which blends with the default Day Sequence device by **50%**. This adds a lighter color to the horizon.

Clouds play a big role in the jungle biome, along with Sun and Sky. First decide how much of the environment you want to cover with clouds.

- **Clouds:** The value is set to **0.8** for 80% cloud coverage.

  - **Cloud Size:** The value is set to **1.5** to make the clouds seem more wispy.
  - **Light Color:** This option is set to a **gray** color. Light Color is used to highlight the color of the clouds. This results in the sunlight hitting the clouds.
  - **Shadow Color:** This option is set to a **gray-blue** color. This color is used for the darker side of the clouds.

## Next Section

[![4. East and West Biomes](https://dev.epicgames.com/community/api/documentation/image/0dea01d3-a1d4-42e6-bb0a-0b4b2549d52f?resizing_type=fit&width=640&height=640)

4. East and West Biomes

Learn how to use the Day Sequence device to create custom outdoor lighting for a hot desert or beach environment.](https://dev.epicgames.com/documentation/en-us/fortnite/day-sequence-4-east-and-west-biomes-in-unreal-editor-for-fortnite)
