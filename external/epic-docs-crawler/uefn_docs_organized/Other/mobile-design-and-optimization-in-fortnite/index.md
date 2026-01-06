# Mobile Design and Optimization

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/mobile-design-and-optimization-in-fortnite
> **爬取时间**: 2025-12-26T23:57:35.632300

---

All **Unreal Editor for Fortnite (UEFN)** islands support a range of hardware, from high-end PCs to mobile devices, but to create successful islands for mobile, you have to build with optimization and memory efficiency in mind from the start.

This page guides you through key considerations when designing for mobile.

## Mobile Design Best Practices In a Nutshell

- **Design with players in mind**:

  - Understand your audience and what they want from a mobile gaming experience.
  - Create a custom UI that is simple, clean, and easy to navigate on a mobile screen.
  - Design for variable screens, and [playtest often](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite) on many types of screens and resolutions.
  - Make use of [Fortnite's existing mobile controls](https://www.epicgames.com/help/en-US/fortnite-battle-royale-c-202300000001636/gameplay-c-202300000001721/what-are-the-controls-on-fortnite-for-ios-android-a202300000014090) and design your game accordingly.
- **Create engagement through gameplay**:

  - Make a short but compelling [gameplay loop](https://dev.epicgames.com/documentation/en-us/fortnite/level-design-best-practices-in-fortnite-creative), making the game easy to pick up and put down.
  - Create quick, [compelling introductions](https://dev.epicgames.com/documentation/en-us/fortnite/onboarding-players-in-fortnite-creative) that showcase game mechanics that excite players.
  - Give a sense of progression, [persistence](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse), and rewards to encourage repeat play.
  - Choose game modes and genres that attract mobile gamers.
- **Optimize your project**:

  - [Manage textures](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) effectively.
  - [Optimize assets](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fortniteready-assets-in-unreal-editor-for-fortnite).
  - Prioritize [memory efficiency](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite).

## Scalability Settings

UEFN is designed to handle platform scalability. Due to hardware limitations, some features are disabled or scaled down at lower-quality levels. Use the in-editor Visual Scalability tool to preview your island at different scalability groups. Testing at various levels is highly recommended.

[![Performance and Scalability Tools menu](https://dev.epicgames.com/community/api/documentation/image/66a17f32-c64d-40ed-92f5-23adebe6ccab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/66a17f32-c64d-40ed-92f5-23adebe6ccab?resizing_type=fit)

Performance and Scalability Tools menu

The table below shows key features that scale or are disabled at different quality levels:

[![Scalability of key features at different quality levels](https://dev.epicgames.com/community/api/documentation/image/a4df90a3-0df2-41c8-865c-89d3a9f533ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4df90a3-0df2-41c8-865c-89d3a9f533ca?resizing_type=fit)

Scalability of key features at different quality levels

Building your island and assets with scalability ensures the best possible performance and visuals, regardless of the device. Key areas to consider:

- **Mesh LODs**: Use [Mesh LODs](https://dev.epicgames.com/documentation/en-us/fortnite/setting-the-level-of-detail-in-unreal-editor-for-fortnite) for custom Static or Skeletal Meshes to reduce polygon counts and increase Frames Per Second (FPS).
- **World and HLODs**: Stream the map using [HLODs and World Partition](https://dev.epicgames.com/documentation/en-us/fortnite/streaming-and-hlods-in-unreal-editor-for-fortnite) to reduce what's rendered, easing GPU strain and increasing FPS.
- **Texture Groups and Mip Mapping**: Enable runtime material scaling via MIP mapping. Ensure textures are in the correct group and created in [powers of two](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite) for smooth scaling and visual quality. Textures that do not comply with the power of two will not stream.
- Material Quality: Complex materials can be too costly on lower-end platforms. We have created material function wrappers to help you further customize different aspects of a material for different platform tiers.

  Navigate to **Fortnite** > **Materials** > **Functions**, where you will find `MF_QualitySwitch_MaterialAttributes`, `MF_QualitySwitch_Scalar`, and `MF_QualitySwitch_Vector`. Using these quality switch wrappers to streamline material functions at a lower-quality setting will improve performance. See the [Material Functions](https://dev.epicgames.com/documentation/en-us/fortnite/material-functions-in-unreal-editor-for-fortnite) page for more information.

### Tips to Optimize Art and Assets for Mobile

- Be conscious of mobile limitations from the outset.
- Avoid overdraw. Flatten layers, limit transparencies, and trim overlapping clutter.
- Simplify textures. Use a minimizer tool.
- Test your island thoroughly on mobile devices. Look for UI conflicts and elements overlapping with gameplay controls. You can use Amazon Luna or Xbox Cloud Gaming to playtest mobile experiences.
- Run the Memory Calculation tool to get a detailed list of the most expensive assets in your level.

## More Optimization Tips

While UEFN offers excellent engine scalability, you still need to streamline and optimize content. Overloading hardware leads to low FPS, poor loading times, and a suboptimal experience. Use these guidelines for improved performance:

- **Optimize Meshes**: Keep polygon count as low as possible. See [Creating Fortnite-Ready Assets](https://dev.epicgames.com/documentation/en-us/fortnite/creating-fortniteready-assets-in-unreal-editor-for-fortnite) for polygon count budgets.
- **Number of Materials**: Use the fewest materials possible. Ideally, use only one material section per mesh.
- **Texture Resolution**: Mobile devices have limited texture memory. Use 512x512 pixel textures and avoid larger sizes if possible.
- **Reduce Draw Calls**: Avoid rendering too many unique objects and textures simultaneously. Use [Instances](https://youtu.be/k9fAXZ4U4XA?si=1yMgPdEa4aK8Zxi4&t=1275) and [Hierarchical Instanced Static Meshes (HISM)](https://youtu.be/k9fAXZ4U4XA?si=n1vCkI2x2Sy0dyyy&t=1323), and group smaller objects into larger props where feasible.
- **World Partition and Data Layers**: Reduce on-screen assets and load times. Learn about World Partition on the [Memory Management](https://dev.epicgames.com/documentation/en-us/fortnite/memory-management-in-unreal-editor-for-fortnite) documentation page.
- **Optimize Lighting**: Use the smallest possible light radius, avoid overlapping lights, and set the mobility of lights to **Stationary**.
- **Turn off Cast Shadows** on lights that do not require sharp shadows, especially in outdoor areas where the skylight provides sufficient ambient lighting.
- **Use the [Lighting Scalability Manager](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-scalability-manager-in-unreal-editor-for-fortnite)**: Create different lighting scenarios for each ESS level. You can set up a simplified, more performant lighting scheme for the low and medium levels (mobile and older consoles).

## Mipmaps and Why We Need Them

Think of Mipmaps as LODs for textures. Texture resolution can swap based on camera distance and orientation.

While it's tempting to use textures with no mipmaps for sharper rendering, such textures remain in device memory and bypass the UEFN streaming process.

The chart below shows texture memory usage by size. Consider, for example, that a 1024x512 texture uses half the memory of a 1024x1024 texture.

[![Texture memory usage by size](https://dev.epicgames.com/community/api/documentation/image/5f352863-f0ce-4342-912a-348616bc3b29?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f352863-f0ce-4342-912a-348616bc3b29?resizing_type=fit)

Texture memory usage by size

Though seemingly small individually, many textures load onto the screen at once and don't immediately clear from memory when the camera looks away. This accumulation can lead to device crashes due to exceeding memory limits.

## Troubleshooting for Mobile

Here are some common issues and solutions to optimize your island for mobile.

#### Low Frames Per Second (FPS) on Mobile Devices

**The problem**: Too many [draw calls](https://dev.epicgames.com/documentation/en-us/fortnite/draw-call?application_version=1.0) and overloading the graphics card.

- **Solution**: Reduce visible content at one time. Use World Partition to divide the level and reduce what's rendered.
- **Solution**: Use HLOD and Mesh LODs to reduce asset complexity and polygon count, allowing the GPU to render objects faster.
- **Solution**: Simplify complex materials at lower quality settings or reduce the number of unique materials, which require more GPU calculations per frame. Reuse materials when possible.
- Solution: Group smaller objects into one larger asset when possible. This allows the graphics card to render them as a single item or draw call.

**The problem**: Loading too many assets at once.

- **Solution**: Use World Partition to divide the level and reduce the amount of loaded content.
- **Solution**: Use HISM and Instances to reduce the number of unique assets.
- **Solution**: Reuse materials when possible to reduce GPU calculations per frame.

#### Island Memory Use Is Too High

**The problem**: Unoptimized content.

- **Solution**: Use 512x512 textures when possible, assign the correct Texture Group, and ensure streaming is enabled.
- **Solution**: For custom meshes, use the smallest polygon count for effective LODs and reduced cook size.

**The problem**: Too many unique meshes.

- **Solution**: Use HISM and Instances when possible. Reusing the same asset in different ways reduces the number of unique assets stored in memory.
- **Solution**: Group smaller objects into one larger asset when possible.

## Supported Mobile Devices

The following tables list devices and specifications that you should consider when testing mobile experiences.

### Android

| Category | Minimum Requirements |
| --- | --- |
| **Operating System** | Android OS 10.0 or higher |
| **Architecture** | 64-bit Android on an ARM64 processor |
| **RAM** | 4GB of RAM |
| **GPU** | Adreno 530 or higher, Mali-G71 MP20, Mali-G72 MP12 or higher |

### Apple

| Device | Model |
| --- | --- |
| **iPhone** | 11, 11 Pro, 11 Pro Max, 12, 12 mini, 12 Pro, 12 Pro Max, 13, 13 mini, 13 Pro, 13 Pro Max, 14, 14 Plus, 14 Pro, 14 Pro Max, 15, 15 Plus, 15 Pro, 15 Pro Max, 16, 16 Plus, 16 Pro, 16 Pro Max |
| **iPhone SE** | 3rd gen 2022 |
| **iPad Pro** | 12.9in 2nd gen or later, 11in 1st gen or later, 10.5in |
| **iPad Air** | 4th gen 2020, 5th gen 2022 |
| **iPad** | 10th gen 2022 |
| **iPad mini** | 6th gen 2021 |

## Additional Resources

Deepen your knowledge by checking out the following resources:

- [Memory and Optimization](https://dev.epicgames.com/documentation/en-us/fortnite/memory-and-optimization-in-unreal-editor-for-fortnite) section in the Fortnite documentation
- [Project Optimization in UEFN](https://youtu.be/k9fAXZ4U4XA?si=o6PxvXbcYwq5YOfh) YouTube video
- [Memory Management in UEFN](https://youtu.be/gtX0gPOSkbU?si=rbI7JaQBUi2PrEha) YouTube video
