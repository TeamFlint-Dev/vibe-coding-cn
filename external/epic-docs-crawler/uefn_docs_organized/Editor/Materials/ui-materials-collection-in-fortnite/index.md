# UI Materials Collection

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/ui-materials-collection-in-fortnite>
> **爬取时间**: 2025-12-27T00:07:13.051550

---

**Primary materials** are materials with multiple materials functions built into them which provides a way to create dynamic and highly customizable materials with as few materials as possible.

Creating complex materials for tracking player stats and customizing UI textures is time consuming and requires deep knowledge of [material functions](https://dev.epicgames.com/documentation/en-us/fortnite/material-functions-in-unreal-editor-for-fortnite) and material set up. To make custom UI materials more accessible, Unreal Editor for Fortnite (UEFN) has a series of highly customizable primary materials that can be used for [meter materials](https://dev.epicgames.com/documentation/en-us/fortnite/meter-material-in-unreal-editor-for-fortnite) and [textures](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#texture).

## UI Materials

You can find the UI Materials folder in the content browser under **Fortnite** > **UI** > **Materials**. The materials are split into two types:

- **Meter Materials**: Typically used for measuring health and shields.
- **Textures**: Typically used as a iconography and in UI animations.

|  |  |  |
| --- | --- | --- |
| **Linear Delta Meter Materials** | **Linear Meter Material** | **Pip Meter Material** |
| Linear Delta Meter materials track the loss and gain of player stats in a linear bar that tracks the delta (the space between the full end of the meter and empty end of the meter) by moving the delta meter and full meter from left to right, based on minimum and maximum progress ranges. | Linear Meter materials track the loss and gain of player stats in a linear bar that moves from left to right according to minimum and maximum progress ranges. | Pip Meter materials track the loss and gain of player stats in a series of shapes that can move from left to right, or up and down, to track stats. |
| [Linear Delta Meter](https://dev.epicgames.com/community/api/documentation/image/bdc9167f-5f47-4ffe-9da6-7542dd2d9dbd?resizing_type=fit)  Click image to enlarge, | [Linear Progress Meter](https://dev.epicgames.com/community/api/documentation/image/44ac3c62-6c3f-417b-b84d-9794750ff5f2?resizing_type=fit)  Click image to enlarge. | [Pip Meter](https://dev.epicgames.com/community/api/documentation/image/dc38db3e-3bbb-4951-8524-884ac297a3d6?resizing_type=fit)  Click image to enlarge. |
| **Radial Meter Material** | **Texture Meter Material** |  |
| Radial Meter materials track the loss and gain of player stats in a radial dial that moves from left to right according to minimum and maximum progress ranges. | The Texture Meter tracks the loss and gain of player stats in a texture that moves from left to right as health is lost and gained according to minimum and maximum progress ranges. |  |
| [SDF Texture](https://dev.epicgames.com/community/api/documentation/image/e7bb6b03-f015-4690-99e4-7f859e5fff01?resizing_type=fit)  Click image to enlarge. | [Texture Effects](https://dev.epicgames.com/community/api/documentation/image/63efae7c-75c7-41f1-92d7-28d46cf65f25?resizing_type=fit)  Click image to enlarge. |  |

## Create a Material Instance

To use a material from the UI folder, you must turn it into a material instance. Material instances use less memory than materials, and are much more customizable in [UMG](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#umg) due to the parameters available.

Parameters are manipulated in the [View Model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#view-model) where they are bound to a device function or Verse code that manipulates the material into behaving a certain way. To create a material instance from a material, follow these steps:

1. Open the **Project** > **Fortnite** > **UI** > **Materials** folder.

   [![The material collection can be found in the UI folder under Fortnite in the main project folder.](https://dev.epicgames.com/community/api/documentation/image/62212281-6ca2-41f5-8ad4-0fedce77a517?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/62212281-6ca2-41f5-8ad4-0fedce77a517?resizing_type=fit)

   Click image to enlarge.
2. **Right-click** a material to open the dropdown context menu.
3. Select **Create Material Instance** from the dropdown menu.

   [![Open the context menu and select Create Material Instance to turn a UI material into a material instance.](https://dev.epicgames.com/community/api/documentation/image/f73215da-2d36-4c53-a04b-3137d0ddd475?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f73215da-2d36-4c53-a04b-3137d0ddd475?resizing_type=fit)

   Click image to enlarge.

A material instance automatically generates in the main project folder.

## Linear Delta Meter

The Linear Delta Meter has a number of customizable parameters that provide a way for you to customize the empty meter, delta meter, and full meter. You can use the meter parameters with the [View Model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#view-model) in [UMG](https://dev.epicgames.com/documentation/en-us/unreal-engine/API/Runtime/UMG) and in Verse code through Verse fields. Use the table below to learn more about using the different parameters.

### Basic Parameters

Basic stat-tracking parameters.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Animate Delta** | An animation that visualizes the delta between the full meter and the empty meter.   - **0-1** Animates progress to the delta value. - **1-0** Animates progress from the delta value.   The material function **ConstantBiasScale** drives the delta marker between the established minimum and maximum values.  In the [View Model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#view-model), this parameter is bound in the Sequencer to animate the meter movement. |  |
| **Delta** | A layer that showcases the difference between the previous progress and the current progress.   - Delta **more than** **0** shows progress lost. - Delta **less than 0** shows progress gained.   The material function **Stepped Gradient** drives the delta marker between established minimum and maximum values.  This parameter is bound in the View Model to the **Brush** binding. |  |
| **Progress** | Progress determines how fast the bars move from one end of the bar to the other.  The **Progress value** should be between **0** and **1** when the **ProgressIsNormalized** parameter equals 1.  The material function **Linear Time** drives the delta marker between established minimum and maximum values.  This parameter is bound to the **Brush** binding in the View Model using **Set Scalar Parameter** to track the player’s progress using the **Progress parameter** in the material instance. |  |
| **Progress Is Normalized** | ProgressNormalized affects the **Progress**, **ProgressRangeMin** and **ProgressRangeMax** values.  **Normalized = 1.0** means that the range of Progress will be between 0 to 1 (as its normalized to a standard range to make it standardized).  **Normalized = 0.0** means the range of Progress will be between **ProgressRangeMin** and **ProgressRangeMax** - you can decide what the floor and ceiling values of Progress are. Useful if you don't want to convert raw values (e.g. Health) to a 0 to 1 range. |  |
| **Parameter Minimum Range** | The smallest amount that shows on the meter. When the tracked stat goes down, the minimum range is the last point on the scale shown before complete depletion of the tracked stat.  This parameter is typically bound to health or shields in the View Model and in Verse fields. |  |
| **Parameter Maximum Range** | The largest amount on the meter.  his sets the maximum range for the Progress parameter, which is typically bound to a player’s health or shields in the View Model and in Verse fields. |  |

### Color Parameters

Changes the meter color.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Background Color** | Changes the background meter color. |  |
| **Color** | Changes the Progress meter color. |  |
| **Delta Color** | Changes the Delta meter color. |  |

## Linear Meter

The Linear Meter has a number of customizable parameters you can use with the [View Model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#view-model) in UMG, and in Verse code through Verse fields. The parameters control appearance of the Linear Meter on-screen. Use the table below to learn more about using the different parameters.

### Basic Parameters

Basic stat tracking parameters.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Is Vertical** | Setting this parameter’s value to **1** causes the meter bar to start from the bottom.  When the material is bound in UMG or specified in a Verse field, the meter will move from top to bottom or bottom to top when tracking the stat. |  |
| **Progress** | Progress determines how fast the bars move from one end of the bar to the other.  The **Progress value** should be between **0** and **1** when the **ProgressIsNormalized** parameter equals **1**.  The material function **Linear Time** drives the delta marker between established minimum and maximum values.  This parameter is bound to the **Brush** binding in the View Model using **Set Scalar Parameter** to track the player’s progress using the **Progress parameter** in the material instance. |  |
| **Progress Is Normalized** | ProgressNormalized affects the **Progress**, **ProgressRangeMin** and **ProgressRangeMax** values.  **Normalized = 1.0** means that the range of Progress will be between 0 to 1 (as its normalized to a standard range to make it standardized).  **Normalized = 0.0** means the range of Progress will be between **ProgressRangeMin** and **ProgressRangeMax** - you can decide what the floor and ceiling values of Progress are. Useful if you don't want to convert raw values (e.g. Health) to a 0 to 1 range. |  |
| **Parameter Range Minimum** | The smallest amount that shows on the meter. When the stat being tracked goes down, the minimum range amount is the last point on the scale shown before the complete depletion of the tracked stat.  This parameter is typically bound to health or shields in the View Model and in Verse fields. |  |
| **Parameter Range Maximum** | The largest range amount that shows on the meter.  This sets the maximum range for the Progress parameter which is typically bound to a player’s health or shields in the View Model and in Verse fields. |  |

### Shape

Parameters to change the meter’s shape.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Corner Roundness Bottom Left** | Changing this parameter adds a rounded corner to the bottom left corner based on the value used. |  |
| **Corner Roundness Bottom Right** | Changing this parameter adds a rounded corner to the bottom right corner based on the value used. |  |
| **Corner Roundness Top Left** | Changing this parameter adds a rounded corner to the top left corner based on the value used. |  |
| **Corner Roundness Top Right** | Changing this parameter adds a rounded corner to the top right corner based on the value used. |  |
| **Glow Max** | Adds a glow filter to the inside of the meter bar. |  |
| **Offset X** | Moves the meter along the X-axis. |  |
| **Offset Y** | Moves the meter along the Y-axis. |  |
| **Rounded Progress** | Adds rounded corners to the progress bar. |  |
| **Scale** | Determines the size of the bar. |  |
| **Fill Direction** | Changes the direction the bar moves, from right to left. |  |
| **Slant X** | Slants the bar along the X-axis. |  |
| **Slant Y** | Slants the bar along the Y-axis. |  |
| **Skew Amount** | Provides a perspective view of the meter bar. The degree of perspective is determined by the parameter value. |  |
| **Skew Rotation** | Rotates the skew of the meter around the X and Y axes. |  |

### Endcap Parameters

These parameters can be used to add style to the meter and its endcap.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **End Cap Color** | Adds color to the endcap of the meter bar.  This parameter only works when you set the **EndCap Opacity** parameter to **1**.  If you want this color to cover the entire meter, set **EndCap Thicknes**s to the maximum value, **0.8**. |  |
| **End Cap Color Dodge** | Adjusts the end cap color.  Lower values cause it to appear as a solid block of color.  High values cause it to appear washed out. |  |
| **End Cap Glow** | This parameter is dependent on the **End Cap Opacity** parameter being set to **0.1 and higher**.  Adds a glow to the end cap  color.  Values of **0.15 or less** cause the End Cap Color to appear as a large glowing block of color.  Values of **0.15 or more** cause the End Cap Color to appear as a glow coming from the end of the Progress meter. |  |
| **End Cap Opacity** | Controls the opacity of the end cap color with values from **0.0** to **1.0**. |  |
| **End Cap Slant** | Creates a small slant on the end cap of the linear meter material.  Lower values add the slant effect to the top of the meter material.  Higher values add the slant effect to the bottom of the meter material. |  |
| **End Cap Thickness** | Determines how  thick the linear meter material is. Higher values create a larger surface area. Lower values create a smaller surface area. |  |

### Background

These parameters add style to the background of the linear meter. Some of the style choices complement the EndCap parameters.

|  |  |  |
| --- | --- | --- |
| **Parameters** | **Description** | GIF |
| **Background Color 1** | Determines the background color of the meter material.  This color is also used as the first color in the background gradient. |  |
| **Background Color 1 Position** | Determines the position for the first color in the gradient.  This option only works when the **Background GradientOn** option is selected and a value set. |  |
| **Background Color 2** | Determines the background color for the second position in the background gradient of the meter material. |  |
| **Background Color 2 Position** | Determines the position for the second color in the gradient.  Higher values shift the gradient to start on the opposite side.  Lower values increase the appearance of the second color selection.  This option only works when the **Background GradientOn** option is selected and a value set. |  |
| **Background Color 3** | Determines the background color for the third position in the background gradient of the meter material. |  |
| **Background Color 3 Position** | Determines the position for the third color in the gradient.  Higher values shift the gradient to start on the opposite side.  Lower values increase the appearance of the third color selection.  This option only works when the **Background GradientOn** option is selected and a value set. |  |
| **Background Color 4** | Determines the background color for the fourth position in the background gradient of the meter material. |  |
| **Background Color 4 Position** | Determines the position for the fourth color in the gradient.  Higher values shift the gradient to start on the opposite side.  Lower values increase the appearance of the fourth color selection.  This option only works when the **Background GradientOn** option is selected and a value set. |  |
| **Background Color 5** | Determines the background color for the fifth position in the background gradient of the meter material. |  |
| **Background Color 5 Position** | Determines the position for the fifth color in the gradient.  Higher values shift the gradient to start on the opposite side.  Lower values increase the appearance of the fifth color selection.  This option only works when the **Background GradientOn** option is selected and a value set. |  |
| **Background Gradient On** | Turn on the gradient features for the background meter material. |  |
| **Background Gradient Rotation** | Rotates the gradient around the **Y-a******xi**s**. |  |
| **Background Opacity** | Determines the opacity value of the background color.Lower values decrease the material’s opacity and higher values increase the material’s opacity. |  |

## Pip Meter

The Pip Meter has a number of customizable parameters that you use with the [View Model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#view-model) in UMG and in Verse code through Verse Fields. Use the table below to learn more about the different parameters.

### Basic Parameters

Basic stat tracking parameters.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Progress** | The values determine the progression of the pip meter material.  The **Progress val**ue should be between **0** and **1** when the **ProgressIsNormalized** parameter equals 1.  This parameter is bound to the **Brush** binding in the View Model, using **Set Scalar Parameter** to track the player’s progress by the **Progress parameter** in the material instance. |  |
| **Progress Is Normalized** | ProgressNormalized affects the **Progress**, **ProgressRangeMin** and **ProgressRangeMax** values.  **Normalized = 1.0** means that the range of Progress will be between 0 to 1 (as its normalized to a standard range to make it standardized).  **Normalized = 0.0** means the range of Progress will be between **ProgressRangeMin** and **ProgressRangeMax** - you can decide what the floor and ceiling values of Progress are. Useful if you don't want to convert raw values (e.g. Health) to a 0 to 1 range. |  |
| **Parameter Range Minimum** | The smallest amount that shows on the meter. When the stat being tracked goes down, the minimum range value is the last point on the scale shown before the complete depletion of the tracked stat.  This parameter is typically bound to health or shields in the View Model and in Verse fields. |  |
| **Parameter Range Maximum** | The largest amount that shows on the meter.  This sets the maximum amount for the Progress parameter, which is typically bound to a player’s health or shields in the View Model and in Verse fields. |  |
| **Fill Direction** | Determines the direction the material fills.  Lower values cause the meter to fill from the left and higher values cause the material to fill from the right. |  |
| **Is Vertical** | Changes the position of the meter material. This parameter can also be specified in a Verse field.  Lower values cause the position of the meter to run left to right, while high values cause the meter to run top to bottom. |  |
| **Snapping** | Determines if progress fill should snap to each segment or fill smoothly. |  |
| **Shape** | Changes the shape of the pip meter. The pip meter changes as the value increases.  Available shapes:   - Circle - Square - Triangle - Heart |  |

### Shape

Parameters to change the meter’s shape.

|  |  |  |
| --- | --- | --- |
| **Parameters** | **Description** | **GIF** |
| **Slant X** | Slants the bar along the **X-axis**.  Lower values slant the meter to the left, and higher values slant the meter to the right. |  |
| **Slant Y** | Slants the bar along the **Y-axis**.  Lower values slant the meter upward to the left, and higher values slant the meter downward to the right. |  |
| **SDF Texture** | Provides a way to add a custom [SDF](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sdf) texture that the material instance can take advantage of with the parameters. |  |
| **Triangle Corner Roundness** | When the **Basic** > **Shape** value is set to Triangle, this parameter rounds the corners of the triangle meter.  The higher the value, the more rounded the corners appear. |  |
| **Box Corner Roundness Bottom Left** | This parameter affects the box pip meter.  Changing this parameter adds a rounded corner to the bottom left corner based on the value used. |  |
| **Box Corner Roundness Bottom Right** | This parameter affects the box pip meter.  Changing this parameter adds a rounded corner to the bottom right corner based on the value used. |  |
| **Box Corner Roundness Top Left** | This parameter affects the box pip meter.  Changing this parameter adds a rounded corner to the top left corner based on the value used. |  |
| **Box Corner Roundness Top Right** | This parameter affects the box pip meter.  Changing this parameter adds a rounded corner to the top right corner based on the value used. |  |
| **Flipped Triangles Offset Y** | This parameter affects the triangle pip meter.  Provides a way to lift the flipped triangles in the meter, creating more space between all triangles. |  |

### Color

Parameters to change the meter’s color.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Empty Color** | Determines the color of the meter when the meter is empty. |  |
| **Empty Opacity** | Determines the opacity of the meter when the meter is empty.  Lower values decrease the material’s opacity and higher values increase the material’s opacity. |  |
| **Empty Outline Color** | Determines the outline color of the meter when the meter is empty. |  |
| **Filled Color** | Determines the color of the meter when the meter is full. |  |
| **Filled Opacity** | Determines the opacity of the meter when the meter is full.  Lower values decrease the material’s opacity and higher values increase the material’s opacity. |  |
| **Filled Outline Color** | Determines the outline color of the meter when the meter is full. |  |

### Pip SDF

Parameters that create effects on [SDF](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sdf) textures.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **GlowMax** | Increases and decreases the glow of the shape’s edge.  Values closer to **0** solidify the outline of the shape.  Values closer to **1** increase the shape’s outline glow. |  |
| **NumSteps** | Increases and decreases the number of shapes in the meter.  Higher values create more shapes. Lower values reduce the number of shapes in the meter. |  |
| **Stroke Thickness** | Increases and decreases the shape’s outline thickness.  Lower values decrease the thickness. Higher values increase the thickness. |  |
| **Pip Size X** | Increases and decreases the shape’s size along the **X-axis**.  High values increase the size. Lower values decrease the size. |  |
| **Pip Size Y** | Increases and decreases the shape’s size along the **Y-axis**.  High values increase the size. Lower values decrease the size. |  |
| **SDF Texture Feather Amount** | Determines how much feathering to enforce on a custom [SDF](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sdf) texture.  High values increase the amount of feathering. Lower values decrease the amount of feathering. |  |

## Radial Meter

The Radial Meter has a number of customizable parameters that you can use with the [View Model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#view-model) in UMG and in Verse code through Verse fields. Use the table below to learn more about using the different parameters.

### Basic Parameters

Basic stat tracking parameters.

|  |  |  |
| --- | --- | --- |
| **Parameters** | **Description** | **GIF** |
| **Progress** | Progress determines how fast the bars progress from one end of the bar to the other.  The **Progress value** should be between **0** and **1** when the **ProgressIsNormalized** parameter equals 1.  The material function Linear Time drives the delta marker between established minimum and maximum values.  This parameter is bound to the **Brush** binding in the View Model using **Set Scalar Parameter** to track the player’s progress using the **Progress parameter** in the material instance. |  |
| **Progress Normalized** | ProgressNormalized affects the **Progress**, **ProgressRangeMin** and **ProgressRangeMax** values.  **Normalized = 1.0** means that the range of Progress will be between 0 to 1 (as its normalized to a standard range to make it standardized).  **Normalized = 0.0** means the range of Progress will be between ProgressRangeMin and ProgressRangeMax - you can decide what the floor and ceiling values of Progress are. Useful if you don't want to convert raw values (e.g. Health) to a 0 to 1 range. |  |
| **Parameter Minimum Range** | The smallest amount that shows on the meter. When the stat being tracked goes down, the minimum is the last point on the scale shown before the complete depletion of the tracked stat.  This parameter is typically bound to health or shields in the View Model and in Verse fields. |  |
| **Parameter Maximum Range** | The largest range amount that shows on the meter.  This sets the maximum range for the Progress parameter which is typically bound to a player’s health or shields in the View Model and in Verse fields. |  |

### Shape

Parameters that change the appearance of the radial meter.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Edge Softness** | Determines how soft or hard the edges of the radial are.  The higher the value, the softer the edge.  The lower the value, the harder the edge. |  |
| **Position Beginning** | Determines where the radial meter begins, how close the segments are, and how large the segment slices are.  A value of 0.0 does not move the beginning of the radial.  Values closer to 1.0 move the beginning of the radial around the circle and cluster the segments on the left side of the radial until the radial meter disappears. |  |
| **Position End** | Determines where the radial meter ends, how close the segments are, and how large the segment slices are.  A value of **1.0** does not move the end of the radial.  Values closer to **0.0** move the end of the radial around the circle and cluster the segments on the right side of the radial until the radial meter disappears. |  |
| **Rotation** | Rotates the radial segments around the circle.  A value of **0.25** rotates the radial segments 90 degrees. |  |
| **Scale** | Determines the size of the radial meter.  Higher values increase the scale of the radial meter.  Lower values decrease the size of the radial meter. |  |
| **Thickness** | Determines the thickness of the radial segments.  Lower values decrease the thickness of the radial segments.  High values increase the thickness of the radial segments. |  |

### Segments

Parameters to determine the appearance of the radial segments.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Segment Count** | Determines how many segments appear in the radial dial.  Lower values decrease the number of radial segments.  High numbers increase the number of radial segments. |  |
| **Segment Gap** | Determines the size of the gap between the radial segments.  Lower values decrease the gap size between the radial segments.  High numbers increase the gap size between the radial segments. |  |
| **Segment Edge Softness** | Determines how hard the edge of the radial segments are.  Lower values increase the appearance of hard edges on the radial segments.  Higher values decrease the appearance of hard edges on the radial segments. |  |
| **Snapping** | Determines if progress fill should snap to each segment or fill smoothly.   - **0.0** - No snapping - **1.0** - Snapping |  |

### Color

Parameters to change the meter’s color.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Empty Color** | Determines the color of the empty radial meter segments. |  |
| **Empty Opacity** | Determines the opacity of the empty radial meter segment color.  Values closer to **1** increase the opacity of the selected color.  Values closer to **0** decrease the opacity of the color. |  |
| **Color 1** | Determines the color of the full radial meter segments. |  |
| **Color 1 Position** | Determines the color position for the first color in the gradient.  This option only works when the **GradientOn** option is selected and a value set. |  |
| **Color 2** | Determines the second color of the full radial meter segments.  This parameter is only visible when the **GradientOn** option is selected. |  |
| **Color 2 Position** | Determines the color position for the second color in the gradient.  Higher values shift the gradient to start on the opposite side.  Lower values increase the appearance of the second color selection.  This option only works when the **GradientOn** option is selected and a value set. |  |
| **Color 3** | Determines the thief color of the full radial meter segments.  This parameter is only visible when the **GradientOn** option is selected. |  |
| **Color 3 Position** | Determines the color position for the third color in the gradient.  Higher values shift the gradient to start on the opposite side.  Lower values increase the appearance of the third color selection.  This option only works when the **GradientOn** option is selected and a value set. |  |
| **Gradient On** | Provides a way to create a gradient effect on the radial meter material.  Values closer to **1** create a greater gradient effect.  Values closer to **0** reduce the gradient effect. |  |
| **Radial Gradient** | Determines the overall gradient values for the radial segments.  Values closer to **1** create a greater gradient effect.  Values closer to **0** reduce the gradient effect. |  |
| **Radial Gradient Size** | Determines the blend amount of  the gradient colors.  Values closer to **1** create a greater gradient effect.  Values closer to **0** reduce the gradient effect. |  |

### Stroke

Parameters that affect the appearance of the radial segment strokes.

|  |  |  |
| --- | --- | --- |
| **Parameters** | **Description** | **GIF** |
| **Stroke Empty Color** | Determines the empty color of the stroke around the empty radial segments. |  |
| **Stroke Color** | Determines the color of the stroke around the radial segments. |  |
| **Stroke Thickness** | Determines the thickness of the stroke around the radial segments.  Higher values increase the thickness of the stroke.  Lower values decrease the thickness of the stroke. |  |

## Texture Meter

The Texture Meter has a number of customizable parameters that you use with the View Model in UMG and in Verse code through Verse Fields. Use the table below to learn more about using the different parameters.

### Basic Parameters

Basic stat tracking parameters.

|  |  |  |
| --- | --- | --- |
| **Parameters** | **Description** | **GIF** |
| **Progress** | Progress determines how fast the bars progress from one end of the bar to the other.  The **Progress** **value** should be between **0** and **1** when the **ProgressIsNormalized** parameter equals **1**.  The material function **Linear Time** drives the delta marker between established minimum and maximum values.  This parameter is bound to the **Brush** binding in the View Model using **Set Scalar Parameter** to track the player’s progress using the **Progress parameter** in the material instance. |  |
| **Progress Is Normalized** | ProgressNormalized affects the **Progress**, **ProgressRangeMin** and **ProgressRangeMax** values.  **Normalized = 1.0** means that the range of Progress will be between 0 to 1 (as its normalized to a standard range to make it standardized).  **Normalized = 0.0** means the range of Progress will be between **ProgressRangeMin** and **ProgressRangeMax** - you can decide what the floor and ceiling values of Progress are. Useful if you don't want to convert raw values (e.g. Health) to a 0 to 1 range. |  |
| **Parameter Minimum Range** | The smallest range amount that shows on the meter. When the stat being tracked goes down, the minimum range is the last point on the scale shown before the complete depletion of the tracked stat.  This parameter is typically bound to health or shields in the View Model and in Verse fields. |  |
| **Parameter Maximum Range** | The largest range amount that shows on the meter.  This sets the maximum range for the Progress parameter which is typically bound to a player’s health or shields in the View Model and in Verse fields. |  |
| **Bar Scale** | Determines the scale of the overall bar meter.  Larger values increase the meter’s scale, smaller values decrease the meter’s scale. |  |
| **Bar Shape Softness** | Determines how hard or soft the edges of the meter appear.  Smaller values increase the sharp appearance of the meter’s edges, larger values increase the softness of the meter’s edges. |  |
| **Bar Size** | Determines the size and appearance of the meter.  Larger values decrease the appearance of the meter. Smaller values increase the size of the meter. |  |
| **Edge Softness** | Determines the appearance of the fill material’s edge.  Smaller values cause a sharper appearance to the material’s edge, larger numbers increase the softness of the fill material’s edge. |  |
| **Fill Direction** | Determines the direction of the fill material.  A value of **0.0** causes the fill material to start from the left. Values **larger than 0.0** cause the fill material to start from the right. |  |
| **Fill Vertical** | Determines the axis and direction of the fill material.  A value of **0.0** causes the fill material to start from the left along the **X-axis**. Values **larger than 0.0** cause the fill material to start from the top of the meter and fill along the **Y-axis**. |  |
| **Rotation** | Rotates the meter from the center.  This parameter provides a way to make the meter stand vertically, or off center. |  |
| **Shine Offset** | Determines the Shine placement on the meter.  Values closer to **-1.0** begin the shine offset on the right side of the meter. Values closer to **0**.0 move the shine offset to the left side of the meter. |  |
| **Stroke Size** | Determines the size of the stroke around the meter.  Smaller values decrease the stroke size. Larger values increase the stroke size. |  |
| **Texture** | Provides a way to use a different texture for the meter.  Select a new texture from the dropdown menu. |  |
| **Texture Offset X** | Offsets the meter texture along the **X-axis**. |  |
| **Texture Offset Y** | Offsets the meter texture along the **Y-axis**. |  |
| **Texture Size Height** | Determines the height size of the meter. |  |
| **Texture Size Width** | Determines the width size of the meter. |  |

### Fill Texture Overlay

Parameters to determine the appearance of the Texture meter’s overlay.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Fill Texture Overlay** | Determines which Fill Texture Overlay to apply to the meter.  Select an overlay texture from the dropdown menu. |  |
| **Fill Texture Overlay Offset X** | Offsets the overlay Fill Texture Overlay along  the **X-axis**. |  |
| **Fill Texture Overlay Offset Y** | Offsets the overlay Fill Texture Overlay along  the **Y-axis**. |  |
| **Fill Texture Overlay Opacity** | Determines the opacity amount for the Fill Texture Overlay.  Values closer to **1** increase the opacity of the selected color.  Values closer to **0** decrease the opacity of the color. |  |
| **Fill Texture Overlay Panning Speed X** | Determines the pan speed for the Fill Texture Overlay along the **X-axis**.  A value of **0.0** does not pan the Fill Texture Overlay pattern across the meter.  Values above **0** pan the Fill Texture Overlay pattern across the meter at increasing speeds. |  |
| **Fill Texture Overlay Panning Speed Y** | Determines the pan speed for the Fill Texture Overlay along the **Y-axis**.  A value of **0.0** does not pan the Fill Texture Overlay pattern across the meter.  Values above **0** pan the Fill Texture Overlay pattern across the meter at increasing speeds. |  |
| **Fill Texture Overlay Rotation** | Rotates the Fill Texture Overlay from the center of the meter. |  |
| **Fill Texture Overlay Scale X** | Scales the Fill Texture Overlay along the **X-axis**. |  |
| **Fill Texture Overlay Scale Y** | Scales the Fill Texture Overlay along the **Y-axis**. |  |

### Background Texture Overlay

Parameters that determine the appearance of the Background Overlay Texture.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Background Texture Overlay** | Determines which background overlay texture to apply to the meter.  Select an overlay texture from the dropdown menu. |  |
| **Background Texture Overlay Offset X** | Offsets the overlay Background Texture Overlay along  the **X-axis**. |  |
| **Background Texture Overlay Offset Y** | Offsets the overlay Background Texture Overlay along  the **Y-axis.** |  |
| **Background Texture Overlay Opacity** | Determines the opacity amount for the Background Texture Overlay.  Values closer to **1** increase the opacity of the selected color.  Values closer to **0** decrease the opacity of the color. |  |
| **Background Texture Overlay Panning Speed X** | Determines the pan speed for the Fill Texture Overlay along the **X- axis**.  A value of **0.0** does not pan the Background Texture Overlay pattern across the meter.  Values above **0** pan the Background Texture Overlay pattern across the meter at increasing speeds. |  |
| **Background Texture Overlay Panning Speed Y** | Determines the pan speed for the Fill Texture Overlay along the **Y-axis**.  A value of **0.0** does not pan the Background Texture Overlay pattern across the meter.  Values above **0** pan the Background Texture Overlay pattern across the meter at increasing speeds. |  |
| **Background Texture Overlay Rotation** | Rotates the Background Texture Overlay from the center of the meter. |  |
| **Background Texture Overlay Scale X** | Scales the Background Texture Overlay along the **X- axis**. |  |
| **Background Texture Overlay Scale Y** | Scales the Background Texture Overlay along the **Y- axis**. |  |

### Colors

Parameters to determine the colors used in the Texture Meter.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Bar Color** | Determines the color for the meter bar. |  |
| **BG Texture Overlay Color** | Determines the color for the Background Texture Overlay. |  |
| **Fill Color 1** | Determines the first fill color. |  |
| **Fill Color 20r Stroke Color** | Determines the color of the stroke around the meter. |  |
| **Fill Texture Overlay Color** | Determines the color of the Fill Texture Overlay. |  |
| **Shine Color** | Determines the color of the Shine. |  |
| **Warning Color** | Determines the warning color. |  |

### Warning State

Parameters that determine the appearance of the meter during a warning state.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Pulse Speed** | Determines the pulse speed of the warning color. |  |
| **Warning Percent** | Determines what percent threshold is necessary to begin the warning state of the meter. |  |

### Slant

Parameters that determine the amount of slant to apply to the texture meter.

|  |  |  |
| --- | --- | --- |
| **Parameter** | **Description** | **GIF** |
| **Fill Slant X** | Determines the slant on the fill material along the **X-axis**. |  |
| **Fill Slant Y** | Determines the slant on the fill material along the **Y-axis**. |  |
