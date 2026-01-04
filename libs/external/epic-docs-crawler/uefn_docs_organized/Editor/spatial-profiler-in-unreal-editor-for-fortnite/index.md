# Spatial Profiler

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/spatial-profiler-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:17:06.055039

---

**What's New?**

- The **Tree View** allows you to select the metrics you want to measure and get results at a glimpse.
- The **Session system** allows you to sample multiple sources simultaneously.
- The **Search bar** lets you quickly find the required metric.
- You can open multiple saved sessions for easier comparison, without having to close the session that you're currently running.
- You can capture metrics simultaneously from multiple sources.
- The **Histogram view** lets you dive into the distribution of each metric over the sampling period.
- Prefixes are automatically added to your saved files to make sessions easier to identify.

**Unreal Editor for Fortnite (UEFN)** gives you the tools you need to understand and improve the performance of your project. Since Fortnite runs on many platforms, knowing specific metrics for your project means that you can make any necessary adjustments to ensure smooth performance across your UEFN experiences.

Jump to [Launch a Sampling Session](https://dev.epicgames.com/documentation/en-us/fortnite/spatial-profiler-in-unreal-editor-for-fortnite) for a quick look at the workflow, or keep reading for an in-depth look at the **Spatial Profiler** tool.

## Useful Terms

A **Spatial Metric** is measured for any property that uses a 3D spatial position in a world. It consists of a certain number of spatial values, each having a number that corresponds to a measurement, with an associated coordinate that gives the spatial position where the value was measured within the world.

A **Spatial Value** is a concrete measurement of a spatial metric in a 3D location. Spatial values have three spatial coordinate values **X**,  **Y**, **Z**, and a measurement result value. Spatial values are aggregated in a Spatial Metric Sample.

A **Spatial Metric Sample** is a measurement of a concrete spatial metric over a defined period. It may contain several spatial values measured with an associated result. A sample also includes other relevant data, such as the 3D bounds enclosing all the enclosing spatial values, the distance precision used, and the date it was taken.

The **Spatial Metric Properties** represent all the information included in a spatial metrics sample:

| Property | Definition |
| --- | --- |
| **Metric ID** | Defines the unique metric identifier, which is directly tied to the type of metric. |
| **Min Value** | The minimum value among the recorded spatial values. |
| **Max Value** | The maximum value among the recorded spatial values. |
| **Threshold Value** | The maximum value expected for the metric. |
| **Spatial Precision** | The 3D cell size used in world units, so all values contained contribute to the same spatial value. Usually, the highest value is selected. |
| **Unit** | The unit used by the recorded values, for example, milliseconds for time or meters for distance. |

The **Spatial Profiler** is a visualization widget that provides you with a 2D heatmap of Spatial Metrics. Here, you can also record, save, and load spatial metric samples. It collects data from the spatial metrics update function, meaning that data is updated periodically.

[![Spatial Profiler in editor](https://dev.epicgames.com/community/api/documentation/image/8fa895e4-3919-45fe-818f-31b562cc3120?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8fa895e4-3919-45fe-818f-31b562cc3120?resizing_type=fit)

Spatial Profiler in editor

*UEFN Editor with the Spatial Profiler docked window.*

The Spatial Profiler currently supports seven spatial metrics:

| Metric | Definition | Unit |
| --- | --- | --- |
| **Draw Call Count** | Tracks the number of draw calls on a single frame | Draw calls |
| **Primitive Count** | Tracks the number of primitives rendered on a single frame. Primitives are the basic drawing components used to render objects in 3D. | Primitives |
| **Game Update Time** | Tracks the platform’s game thread, measuring the time taken to update a single frame. | Microseconds |
| **Render Time** | Tracks the platform’s render thread, measuring the time taken to update a single frame. | Microseconds |
| **Frame Time** | Tracks the time spent to update a single frame. Both the Game Update Time and the Render Time metrics are included in this metric. | Microseconds |
| **GPU Time** | Tracks the platform's GPU time. | Microseconds |
| **RHI Time** | Tracks the platform's Render Hardware Interface thread time. | Microseconds |
| **Actor Count** | Tracks the number of actors in the world accounting for streaming events. This is especially useful for worlds with [World Partition](https://dev.epicgames.com/documentation/en-us/uefn/streaming-and-hlods-in-unreal-editor-for-fortnite) streaming enabled. Seeing inconsistent actor counts in the level can highlight the most important areas of gameplay. However, really high actor counts can also indicate an excessive number of small actors and a potential stress point for the experience.  It is a good idea to evaluate this metric together with Game Update Time to evaluate game logic complexity, or with Render Time to evaluate render complexity. | Actors |
| **Building Count** | A specialized version of the Actor Count metric that tracks the number of actors that have been categorized as buildings. This category also includes other types of persistent static mesh actors. | Actors |
| **Loot Container Count** | A specialized version of the Actor Count metric that tracks the number of actors that have been categorized as loot containers. This category includes actors like chests, ammo boxes and other pickup spawners. | Actors |
| **Pickup Count** | A specialized version of the Actor Count metric that tracks the number of actors that have been categorized as pickups. This category includes lootable gameplay items. | Actors |
| **Memory Usage** | Tracks the platform's executable memory usage. You can use this to evaluate the memory requirements of each platform the experience has to run on. | Kilobytes |
| **Available Memory** | Tracks the platform's available physical memory. You can use this to evaluate the memory requirements of each platform the experience has to run on. | Kilobytes |

## Spatial Profiler UI

The Spatial Profiler is a dockable standalone widget divided into four areas:

[![profiler areas](https://dev.epicgames.com/community/api/documentation/image/1593dbf0-6139-4bfe-b0c1-7df8c7bae775?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1593dbf0-6139-4bfe-b0c1-7df8c7bae775?resizing_type=fit)

*Spatial Profiler widget areas.*

1. Control toolbar
2. Heatmap view
3. Metrics tree view
4. Histogram view

### Control Toolbar

This area contains the main interactive elements to operate the Spatial Profiler. It gives you the controls to produce, visualize, and save Spatial Metrics samples. You can use the samples you capture to generate data that can improve your UEFN experience.

[![profiler toolbar](https://dev.epicgames.com/community/api/documentation/image/6f8f9c10-d025-4033-aea8-366f40ec0a53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f8f9c10-d025-4033-aea8-366f40ec0a53?resizing_type=fit)

*Spatial Profiler control toolbar elements.*

The control toolbar includes the following elements:

1. **Start sampling**: this button starts the capture of the set of metrics the user selected. You have to be connected to a UEFN session for metrics to be sampled. During sampling, the heatmap automatically centers the view at the session’s player pawn location and focuses on the spatial values captured.
2. **Stop sampling**: this button stops the capture of the selected metrics.
3. **Open a sample file**: this button opens a pre-existing sample file, which can contain multiple metrics. On opening, all loaded metrics are loaded into the metric browser so that you can assess the data.
4. **Save a sample to file**: you can use this button to save active profiling sessions. It opens a save-to-file dialog and proposes a file name with the sample timestamp by default. The Spatial Profiler saves all metrics in the current sampling session to the destination file.
5. **UEFN session selector**: You can have more than one client connected to a session. You can use the session selector to choose which session to connect and run metrics. The Spatial Profiler automatically connects to the client when launching a session, and then updates the session selector with the name of the user connected to that session.
6. **Settings**: this button displays the Spatial Profiler preference settings. You can use this to toggle the visibility of certain widget elements.

### Metrics Tree View

This section allows you to select and deselect the metrics you want in your sampling session by clicking the check boxes to the left of the metrics.

The top dropdown field is used to choose between a Live Session and a previously saved session. You can switch between your current sampling session and a saved session by selecting the session you want to view from the dropdown.

With the second dropdown field, you can switch between the sampling targets in your live session, such as clients or the server. You can monitor the metrics for all connected clients, and can sample **multiple sources at the same time**.

The **Search bar** lets you look up a specific metric.

[![metric browser](https://dev.epicgames.com/community/api/documentation/image/d709edfb-14b2-46eb-a8cb-138ff55cf7bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d709edfb-14b2-46eb-a8cb-138ff55cf7bb?resizing_type=fit)

When you click on a metric to select it, the Heatmap view updates to show any data samples, and Stats view updates to display the aggregate statistics for the data. The colored circles next to each metric represent their relative values based on the thresholds you set before the sampling session, showing your results at a glance.

[![Draw Call Count selected and displays on the heatmap.](https://dev.epicgames.com/community/api/documentation/image/fd7f730d-29ce-48e7-9932-f0aa631e28d3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd7f730d-29ce-48e7-9932-f0aa631e28d3?resizing_type=fit)

Draw Call Count selected and displays on the heatmap.

### Heatmap View

The Heatmap View displays a heatmap of your chosen metric, with an overlay of all the spatial values in the sample. Each spatial value is colored according to the sample’s data. You can quickly set cutoff values for each metric to define the range of expected values.

You can interact with the heatmap and customize it to your preferences using the four buttons at the top:

- Hamburger Menu
- Show Options
- Focus Player
- Focus Bounds

[![heatmap buttons](https://dev.epicgames.com/community/api/documentation/image/e23f76da-14ab-46dc-a37f-c25a71204bda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e23f76da-14ab-46dc-a37f-c25a71204bda?resizing_type=fit)

Double-clicking on any location in the Heatmap View places the Editor camera at the corresponding location within the project. If a session is launched, the player pawn teleports to the location you double-click.

#### Hamburger Menu

This button gives you access to the heatmap visualization options, containing two sections:

- Metric Settings
- Heatmap Color Settings

[![hamburger menu](https://dev.epicgames.com/community/api/documentation/image/97f87e03-cac5-4225-a810-7227188680e1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97f87e03-cac5-4225-a810-7227188680e1?resizing_type=fit)

*Spatial Profiler hamburger menu options.*

You can reset the settings in these sections by clicking the reset arrow button on the right side of each field.

##### Metric Settings

The **Metric Settings**group all the settings affecting visualization of the metrics.

| Value | Definition |
| --- | --- |
| Threshold | A threshold value defines the expected maximum value for normal gameplay. |
| Display Unit | When specified, this option defines the preferred visualization unit for a metric. If left unspecified, the tool selects the best fitting unit for each metric. The Display Unit affects the units used by the Heatmap View and the Summary View. |
| Cell Method | This setting specifies the reduction method the tool uses to calculate each 2D cell value from the list of values that fall within each cell's boundaries. The available reduction methods are:   1. Median Value (default) 2. Min Value 3. Max Value 4. Average Value |
| Cell Size | This settings changes the size of the grid and can increase or decrease the level of detail for a particular sampling area. |

##### Heatmap Color Settings

The **Heatmap Color Settings** contain all the settings affecting the visualization of the metrics.

The **Heat Colors** offer a readable color palette with considerations for colorblindness. You can define the key colors to customize the heatmap color range.

| Value | Definition |
| --- | --- |
| Low | This color represents the low spectrum of the heatmap color range, and maps to the minimum value in a metric sample. |
| Midpoint | This color represents the middle of the heatmap color range defined between the Minimum and the Threshold color. If a threshold value is not specified, it maps to the median spatial value in a sample. |
| High | This color represents all values that are above the set threshold. |
| Max | This color represents the maximum value. It’s only displayed when users define a threshold value for the represented metric. When you specify a threshold value, the heatmap adds a range that exceeds the threshold, going from white to the color set for Maximum. |
| Min Alpha | The starting value given to spatial values. The alpha value of all spatial values in a sample increases according to their value, from the Minimum value (using Min Alpha) to the Maximum or Threshold values with maximum alpha. Using a low Min Alpha value highlights spatial values closer to the Maximum or Threshold values by making low spatial values less visible. |
| Max Alpha | The maximum starting value given to spatial values. |

The Alpha Settings show spatial values outside of the expected range. Adjusting these options becomes especially useful when looking at a metric sample with pockets of high-density spatial values, as you can get a more granular read on the metrics.

#### Axes

This option toggles the visualization of the 3D axes on the bottom-left corner corresponding to the Heatmap View’s top-down orientation. This orientation is in parity with the client’s minimap view and not with the Editor's.

[![heatmap axes](https://dev.epicgames.com/community/api/documentation/image/00b74a28-1038-436d-95be-6f57abd9294d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00b74a28-1038-436d-95be-6f57abd9294d?resizing_type=fit)

*Showing Heatmap axes*

#### Grid

Toggles the visualization of the 2D heatmap grid, subdividing the visible space into multiples of the sample value’s extents. The grid size can be modified in the hamburger menu

![No grid](https://dev.epicgames.com/community/api/documentation/image/f35f0d26-4f61-4f99-b091-da9de50f7589?resizing_type=fit&width=1920&height=1080)

![Show grid](https://dev.epicgames.com/community/api/documentation/image/de4fe993-c0d0-484e-a456-2d7be3512e89?resizing_type=fit&width=1920&height=1080)

No grid

Show grid

#### Heatmap Legend

This option turns the visualization of the heatmap’s color range legend on or off at the bottom right corner of the Heatmap View.

[![heatmap legend](https://dev.epicgames.com/community/api/documentation/image/e85499e2-f50e-4181-9f99-99db4c0fb19f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e85499e2-f50e-4181-9f99-99db4c0fb19f?resizing_type=fit)

*Displaying Heatmap color palette legend*

#### Bounds

This option lets you toggle the 2D bounding box, which comprises all the spatial values in the sample.

[![sample bounds](https://dev.epicgames.com/community/api/documentation/image/3a8891a1-d933-4a0c-b537-9207ddc6003e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a8891a1-d933-4a0c-b537-9207ddc6003e?resizing_type=fit)

*Showing sample bounds (white) on the Heatmap*

#### Focus Player

[![focus player](https://dev.epicgames.com/community/api/documentation/image/15279be6-91f9-4b20-aae7-f6d92572060a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15279be6-91f9-4b20-aae7-f6d92572060a?resizing_type=fit)

This button centers the view around the player pawn in the connected session. This action requires a connected session.

#### Focus Bounds

[![focus bounds](https://dev.epicgames.com/community/api/documentation/image/e9cd8183-92b4-40ce-add4-52576254431a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9cd8183-92b4-40ce-add4-52576254431a?resizing_type=fit)

This button centers the Heatmap View around the 2D bounding box.

### Contextual Menu

You can access the contextual menu by right-clicking on the Heatmap View area. This menu contains the following options:

- Teleport
- Default View
- Focus Bounds
- Track Focus Location

[![heatmap contextual menu](https://dev.epicgames.com/community/api/documentation/image/dbd10339-7121-4324-8c5c-f27726498c7f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dbd10339-7121-4324-8c5c-f27726498c7f?resizing_type=fit)

*Spatial Profiler Heatmap View contextual menu*

#### Teleport

You can use this option to bring both the camera view and the player pawn to a chosen right-clicked location in the Heatmap View. This action requires a connected session to teleport the player pawn. If no session is connected, it is the equivalent to double-clicking on any location in the Heatmap View, which places the Editor camera at the corresponding location within the project.

#### Default View

This option resets the Heatmap View focus and zoom values to their default settings.

### Histogram View

The **histogram** helps you visualize the data as it is being collected in real time. You can to go back through your test of the level and assess each metric at a specific point in your playtest. By scrolling through the open session's histogram you can identify the location of a particular reading that you want to investigate.

[![histogram](https://dev.epicgames.com/community/api/documentation/image/fa6697c9-4f4b-446a-a27d-8f153f6e1854?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa6697c9-4f4b-446a-a27d-8f153f6e1854?resizing_type=fit)

Adjusting the values in the Hamburger menu will modify the various cutoff points displayed in the histogram.

Right-clicking the histogram allows you to select **Display Threshold Guidelines**, **Auto Scroll**, **Shade Values by Cell**, choose the Next and Previous values, and **Scale Histogram**. You can change the scale of the histogram by holding **Shift + Scrolling** the mouse wheel.

[![](https://dev.epicgames.com/community/api/documentation/image/4884e499-e474-4f2f-a6ed-4d98f460a361?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4884e499-e474-4f2f-a6ed-4d98f460a361?resizing_type=fit)

Right-clicking the histogram displays the above options.

You can also zoom in and out of the histogram to get a more detailed look at your metrics.

![More Zoomed Out](https://dev.epicgames.com/community/api/documentation/image/0f534f3a-ccee-4b7a-9162-c05dee185b1b?resizing_type=fit&width=1920&height=1080)

![More Zoomed In](https://dev.epicgames.com/community/api/documentation/image/f5b67efc-b085-433e-9d2a-2700a8a2bc1d?resizing_type=fit&width=1920&height=1080)

More Zoomed Out

More Zoomed In

When you mouse over a segment of the sample, a tooltip will display its value.

[![](https://dev.epicgames.com/community/api/documentation/image/ba332122-7338-4ea6-aae1-dee1fe109a84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba332122-7338-4ea6-aae1-dee1fe109a84?resizing_type=fit)

Clicking on the sample segment highlights the location of the segment on the heatmap.

To the right of the histogram you can see a summary of statistics for the selected metric. It displays the following stats compiled from the sample’s spatial values:

| Statistic | Definition |
| --- | --- |
| Values | The total number of spatial values included in the sample. |
| High | The number of spatial values exceeding the threshold value, if defined. |
| Min Value | The smallest spatial value. |
| Max Value | The largest spatial value. |
| Average Value | The average spatial value. |
| Median Value | The median spatial value. |

## Launch a Sampling Session

This section covers how to launch a sampling session using the Spatial Profiler tool, and shows you how to save your spatial metric sample.

1. Go to **Tools** > **Spatial Metrics** > **Spatial Profiler**. This opens the Spatial Profiler widget.
2. In the **Tree View**, select the metrics that you want to measure in your sampling session.
3. Set your sampling parameters from the Hamburger menu.
4. Click **Launch Session** to start a game through the Fortnite client.
5. (Optional) Once the client loads, press **End Game** to get into **Edit Mode**, which allows your pawn to fly through the level more quickly.
6. Press **Start Sampling**.
7. In the game session, use your pawn to run around the island and play the game as intended. The Spatial Profiler heatmap will update as you do so.
8. Press the **Stop Sampling**button to end the sampling session.
9. Press the **Save** icon on the Spatial Profiler widget, and choose a location inside the local directory of your project. The profiler provides read access to any sample saved in the project. Samples are organized by metric type and timestamp.
10. You can click the **Open** icon to access any previous project sample recordings.

[![](https://dev.epicgames.com/community/api/documentation/image/486c663c-31eb-4c66-b350-ac115f5567d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/486c663c-31eb-4c66-b350-ac115f5567d4?resizing_type=fit)
