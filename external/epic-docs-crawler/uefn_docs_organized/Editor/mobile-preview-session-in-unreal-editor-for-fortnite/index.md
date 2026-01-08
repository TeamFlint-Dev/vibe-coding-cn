# Mobile Preview

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/mobile-preview-session-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:57:20.813240

---

The **Mobile Preview** session lets you launch your experience on PC as though it were running on a target iOS or Android device. This allows you to easily test how your islands look and feel to mobile players, and make crucial adjustments to improve the user experience.

## Launch an Island with Mobile Preview

To launch a session in mobile preview:

1. Click the **vertical ellipsis** dropdown next to **Launch Session**.
2. Select **Mobile Preview (This PC)** under the **Platform** section.
3. Hover over the Mobile Preview (This PC) option to select the desired screen size. Available sizes include **Common Mobile (20:9)**, **Older Mobile (16:9)**, or **Tablets (4:3)**.
4. Select a **Device Profile** based on the target devices for your tests.
5. Click **Launch Session**.

[![Choosing a mobile preview in UEFN.](https://dev.epicgames.com/community/api/documentation/image/a27a081b-d99c-4aec-a88e-03b247325ad7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a27a081b-d99c-4aec-a88e-03b247325ad7?resizing_type=fit)

Choosing a mobile preview in UEFN.

## Test Controls

When the session is running:

- Clicking and dragging the mouse on the left side of the screen emulates touch movement inputs.

  ![Click and drag the mouse to simulate touch directional input.](https://dev.epicgames.com/community/api/documentation/image/3b15457a-425c-4f80-b6c9-3c3d3f3a0a75?resizing_type=fit)

  Click and drag the mouse to simulate touch directional input.
- Mouse clicks emulate touch controls.

  ![Click on the buttons to simulate touch controls.](https://dev.epicgames.com/community/api/documentation/image/a8e4e3d8-caef-44f4-ac3c-9188c62a67d3?resizing_type=fit)

  Click on the buttons to simulate touch controls.
- Use the WASD keys to move around to simulate two-handed gameplay.

  ![Keyboard and mouse to simulate two-handed gameplay.](https://dev.epicgames.com/community/api/documentation/image/341a3d99-4e3b-4bf8-87b0-81429776678a?resizing_type=fit)

  Keyboard and mouse to simulate two-handed gameplay.

If you are using a Windows device with a touch screen, you can use the touch inputs directly while interacting with the screen.

## Mobile Testing Checklist

Here are the main points to consider when testing your islands for mobile platforms:

### Appearance

Does your island look significantly different on mobile than on PC or console? Ensure that:

- Assets are appearing as they should on Android/iOS.
- The quality of art assets, lighting, material, and visual effects is in line with your expectations.
- Light actors such as the Day Sequence device and Environment Light Rig device are lighting your island correctly.

You can take screenshots of both the mobile session and the PC session to compare and discover inconsistencies in your lighting setup.

**Visual Issues to look out for:**

- Issues with exposure within interiors and exteriors.
- Issues with color.
- Issues with decal resolution.
- Issues with post process effects.

### UI/HUD Look and Feel

The mobile preview is essential for ensuring that your user interface elements are correctly placed and optimized for a touch-based environment. Check :

- Whether your HUD layout looks correct on mobile.
- How your widgets look on mobile.
- If your designs are truly touch friendly.
- That buttons are the correct size for fingers.
- That icons and text are readable.

### Performance Profiling

You can profile the performance of your game by launching the [Spatial Profiler](https://dev.epicgames.com/documentation/en-us/fortnite/spatial-profiler-in-unreal-editor-for-fortnite) tool in the Editor. The profiler can provide values specific to the mobile target platform, allowing you to better understand performance issues and target improvements.

Key performance metrics captured by the Spatial Profiler:

- **Object counts**.
- **Rendering draw calls** and **primitive counts**.
- Time metrics, including **Frame Time**, **Game update time**, **GPU Time**, **Render Time**, and **RHI Time**.

  These metrics use cooked PC data and will not accurately reflect results on a real mobile device. See the FAQ below for more info.

## FAQ

##### Q: Can I use the Mobile Preview to test my experience after it has been published or made private?

**A**: At this time, you cannot use it to launch mobile gameplay in published or private islands. This restriction is in place to address fraud and security concerns.

##### Q: Is the Mobile Preview available for all testing scenarios?

**A**: No. The Mobile Preview session can only be used in the context of a Live Edit session.

##### Q: Does the Mobile Preview accurately measure how much memory my experience uses on a physical device?

**A**: Since the session uses cooked PC data instead of a mobile cook, it is not reflecting actual memory usage on mobile devices while running memory calculations. To get the most accurate results for memory calculation, it is recommended to select **Connect to platform** from the **Session** menu and calculate memory on the targeted device.

##### Q: What are other known limitations for Mobile Preview?

**A**: Since the session utilizes cooked PC data and the game performance can vary based on different PC specs, the preview is not fully representative of the actual mobile performance and accurate visual quality.
