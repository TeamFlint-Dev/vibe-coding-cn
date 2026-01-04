# UMG Widgets

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/umg-widgets-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:12:18.910264

---

User Widgets are designed in the [Widget Editor](https://dev.epicgames.com/documentation/en-us/uefn/ui-widget-editor-in-unreal-editor-for-fortnite) with UMG Widgets.

[![The Widget Editor in UEFN.](https://dev.epicgames.com/community/api/documentation/image/79bc866e-2dd9-4929-be6f-1f3c47430502?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79bc866e-2dd9-4929-be6f-1f3c47430502?resizing_type=fit)

The Widget Editor in UEFN.

User Widgets are like maps in that they trace the route between a UMG Widget and the device functions. Being able to read a User Widget will help you to understand the makeup of a UI. From the Widget Editor, you can examine:

- The UI [layout and design](http://ui-layout-in-umg-in-unreal-editor-for-fortnite).
- The [Viewmodel functions](http://using-the-viewmodel-in-umg-in-unreal-editor-for-fortnite).
- The widget bindings in View Bindings.

In the feature template, open the **HUD Controller** folder and double-click on the **UW\_HCD01** **widget** to learn more about how that widget was created and bound to the HUD Controller device.

![Opening the UW_HCD01 example widget.](https://dev.epicgames.com/community/api/documentation/image/0fbddc89-7a38-4c80-a0b9-391f14be2841?resizing_type=fit)

Opening the UW\_HCD01 example widget.

## Widget Layout

Widget layout is the design phase in creating a custom UI. In the Widget Editor, you can use UMG Widgets from the **Palette panel** to create the look, and to plan the functionality of your UI. The order in which you use UMG Widgets determines the look of the UI.

To learn more about what the UMG Widgets do, see the **Palette** section of the **Widget Editor document**.

With the **UW\_HCD01 widget** open, look in the **Hierarchy** panel. The Hierarchy panel shows you which UMG Widgets were used and the order in which they were added to the viewport.

[![The Hierarchy panel.](https://dev.epicgames.com/community/api/documentation/image/324db746-8e34-4f62-886a-131475016ea5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/324db746-8e34-4f62-886a-131475016ea5?resizing_type=fit)

The Hierarchy panel.

UMG Widgets can be renamed in the Hierarchy panel once they’ve been added to the viewport.

All widget designs must have a root widget that acts as the screen. An **Overlay** widget named Root sits at the root of the design and acts as the screen. The viewport is set to **Fill Screen**, which causes the design to fill the Root designated area.

[![Finding the root widget.](https://dev.epicgames.com/community/api/documentation/image/3e681c59-078c-4c0a-b636-fdbe3c5a9eb8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e681c59-078c-4c0a-b636-fdbe3c5a9eb8?resizing_type=fit)

Finding the root widget.

A **Grid Panel** is used to house the design of the Health and Shield bars. Grid Panels are flexible grids that organize their child widgets in rows and columns.

You can further customize rows and columns because the Grid Panel adds options to its child widgets that control the number of rows and columns, the space rows and columns take up, the layer the widget occupies in the design, and a special movement option called **Nudge**.

Nudge provides a way to move the child widget across the X and Y axes without taking up space. This means only the content inside the container is shifted, but the container maintains its position and the space it takes up in the layout.

The Overlay widget, named **ShieldBarContainer**, is the first child widget of the Grid Panel. This widget sits on **Row 1**, **Column 0** and displays across **Row Span 1**, **Column Span 0**. The ShieldBarContainer widgets display on **Layer1**.

This means that all child widgets of ShieldContainer show at the front of the design because they’re on Layer 1, but sit to the right of the widgets behind it because they sit in Row 1. The shield bar spans 2 rows (0 and 1), this determines the length of the shield bar.

Using the **Nudge** > **Y** option, you can move the ShieldBarContainer widget **-25.0** [Slate Units](https://forums.unrealengine.com/t/what-are-slate-units) down from its default position so that it  slightly covers the Health Container behind it.

[![Grid Panel adds extra options to its child widgets.](https://dev.epicgames.com/community/api/documentation/image/c3d78cad-29c6-4b62-8d44-1baa934830ce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3d78cad-29c6-4b62-8d44-1baa934830ce?resizing_type=fit)

Grid Panel adds extra options to its child widgets.

The Overlay widget named **HealthBarContainer** is the second child widget of the Grid Panel. This widget sits on **Row 1**, **Column 0** and displays across **Row Span 1**, **Column Span 0**. The HealthBarContainer widgets display on **Layer0**.

[![Grid Panel adds extra options to its child widgets.](https://dev.epicgames.com/community/api/documentation/image/faa8c2ac-954d-4b7c-b848-495b283ab142?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/faa8c2ac-954d-4b7c-b848-495b283ab142?resizing_type=fit)

Grid Panel adds extra options to its child widgets.

This means that all child widgets of HealthBarContainer show at the back of the design because they’re on Layer 0. The health bar sits in Row 0 so it displays to the left of the shield bar. The HealthBarContainer also spans Rows 0 and 1, which determines the length of the health bar.

Below is the breakdown of UMG Widgets that make up the shield and health bars, and their purpose in the overall design.

### ShieldBarContainer

The ShieldBarContainer houses all of the UMG Widgets that make up the shield bar design. The shield bar is made up of the following:

| UMG Widget | Widget Name | Purpose |
| --- | --- | --- |
| Image | ShieldBar\_backing | Used as a container to go around the entire shield bar design. This is a Material Instance named **MI\_HCD01\_Backplate**. |
| Stack Box | ShieldContent | Organizes its child widgets (shield bar icon and shield bar material) left to right inside the ShieldBar\_Backing material and ShieldBarContainer. |
| Image | ShieldIcon | The shield icon material used as the front layer. |
| Overlay | ShieldBarContainer | Used to layer its child widgets in the second column of the ShieldContent Stack Box.  These widgets make up the shield bar material. |
| Image | ShieldBarStroke | Used as a container to go around the shield bar. This is a Material Instance named **MI\_HCD01\_BarStroke**. |
| Image | ShieldBar | The **M\_ProgressBar\_Basic** material is a dynamic two-toned material that uses a material function to move left and right across the shield bar, depending on the information the widget receives from the HUD Controller device. |

### HealthBarContainer

The HealthContainer houses all the UMG Widgets that make up the health bar design. The health bar is made up of the following:

| UMG Widget | Widget Name | Purpose |
| --- | --- | --- |
| Stack Box | Health Content | Organizes its child widgets (health bar icon design and health bar material) left to right inside the HealthContainer.  This Stack Box stretches around the ShieldContainer Overlay widget and centers the shield bar in the overall UI design.  This is because the HealthContent Stack Box has a larger X-axis dimension than the ShieldContent Stack Box. |
| Image | HPIcon | The health icon material used as the front layer. |
| Overlay | HPBarContainer | Used to layer its child widgets in the second column of the HealthContent Stack Box.  These widgets make up the health bar material. |
| Image | HPBarStroke | Used as a container to go around the health bar. This is a Material Instance named **MI\_HCD01\_BarStroke**. |
| Image | HPBar | A dynamic two-toned material that uses a material function to move left and right across the health bar, depending on the information the widget receives from the HUD Controller device. |

Next you’ll learn how to select a Viewmodel to update the UI materials to show the player’s current health and shield status in-game.

## Viewmodel

A Viewmodel controls player information through a list of functions. The functions provide a way to control player information through the UMG Widget and device functionality. Viewmodels provide a specific way to bind UMG Widgets to Creative devices.

Viewmodels listen to functions executing in the device using the User Widget to replace the default user interface. The viewmodel then uses the device functions to update the UI through View Bindings.

For example, the Shield and Health bar viewmodels listen to the HUD Controller's Shield and Health functions. When the HUD Controller function executes on Player Shields and Health, the Viewmodel listens to these functions and passes the information through the View Bindings to update the UI.

There are a number of different Viewmodels to choose from. In the list of Viewmodels below, notice that there are device-specific Viewmodels. These contain the functions specific to that device.

[![List of Viewmodels.](https://dev.epicgames.com/community/api/documentation/image/9876f6b6-a068-46cd-8d92-90408db2a600?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9876f6b6-a068-46cd-8d92-90408db2a600?resizing_type=fit)

List of Viewmodels.

The following Viewmodels control more than one part of the UI through the device functions in the function lists.

The **Device - HUD Controller Team/Squad Player Info List** is used with the **UW\_HCD01** widget. It uses the **Controlling Player Info** to ingest your information from the HUD Controller because this template is meant to be played by one player – you!

For this UI sample, your **Health** and **Shield** are controlled through this viewmodel by listening to the functions of the HUD Controller.

[![The Device - HUD Controller Team/Squad Player Info List has viewmodels for Health and Shields.](https://dev.epicgames.com/community/api/documentation/image/8ba39229-b47f-49e9-af79-c40e62d3e4e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8ba39229-b47f-49e9-af79-c40e62d3e4e6?resizing_type=fit)

The Device - HUD Controller Team/Squad Player Info List has viewmodels for Health and Shields.

Next you’ll learn how to bind Health and Shield UI materials to the HUD Controller functionality in View Bindings.

### View Bindings

View Bindings maps the UMG Widget functionality to the functions of the bound device and updates the UI in the HUD. In the **UW\_HCD01** widget, the ShieldBar and HPBar materials are bound to the HUD Controller’s **Shield** and **Health** functions. These functions monitor your shields and health in-game and update the bar material based on how much shield and health you have.

Making the shield and health UI functional begins by selecting a UMG Widget and binding the widget properties to a specific device function. Bindings must be created in the **View Bindings** panel.

### Adding a UMG Widget

**Image widgets** (ShieldBar and HPBar) are selected from the **Hierarchy** panel first, then from the View Bindings panel. You can click the **+Add Widget button** to open the list of Viewmodel functions. A function is added to the widget to control the widget’s property information. In this case, it’s the Brush function to control the ShieldBar and HPBar materials.

[![The Brush function is added to HPBar to control the MI_HCD01_BarStroke material.](https://dev.epicgames.com/community/api/documentation/image/eafc37aa-c404-4bf1-bfa6-d6585821da37?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eafc37aa-c404-4bf1-bfa6-d6585821da37?resizing_type=fit)

The Brush function is added to HPBar to control the MI\_HCD01\_BarStroke material.

### Adding a Device Binding

After determining which widget to bind, the device binding type is selected. There is an empty field next to the widget field. Clicking in the empty field opens a list of available device bindings. The device binding options automatically appear under the widget and device binding fields. The options determine how the widget updates based on the information it receives from the device.

The **UW\_HCD01 widget** uses a **Set Scalar Parameter** to update the **Brush** properties.

#### View Bindings

| ShieldBar Brush Property | HealthBar Brush Property |
| --- | --- |
|  |  |

#### Details Panel

| ShieldBar Material | HealthBar Material |
| --- | --- |
|  |  |

In the **UW\_HCD01 widget**, the Image widgets (ShieldBar and HPBar) have dynamic materials in their Brush properties (found in the Details panel).

### Setting Device Parameters

To make the material reflect the current state of the player’s shield and health, the device bindings have parameters that need to be set in order to send the device information to the UMG Widgets.

In this sample, the **Image widget** and its **Brush** function are automatically added to the HUD Controller’s **Brush parameter**. This binding determines which Image widget’s Brush property to update.

[![The HPBar and ShieldBar Brush functions.](https://dev.epicgames.com/community/api/documentation/image/c0373afc-ecb4-40ca-8f29-f29dcdda0e9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0373afc-ecb4-40ca-8f29-f29dcdda0e9a?resizing_type=fit)

The HPBar and ShieldBar Brush functions.

Next, the **Parameter Name** specifies which parameter to update in the Brush material. Here, **Progress** is typed into the field.

[![The Parameter name is set to Progress.](https://dev.epicgames.com/community/api/documentation/image/ea060ec4-6378-4c85-99d4-1cdfa5c32f40?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea060ec4-6378-4c85-99d4-1cdfa5c32f40?resizing_type=fit)

The Parameter name is set to Progress.

Lastly, the Value for the binding is determined by the viewmodel. In the binding’s Value field, the **HUDPlayerInfoListViewmode**l > **Controlling Player Info** > **Shield** and **Health** functions are set.

[![Value bindings for the Shield and Health functions.](https://dev.epicgames.com/community/api/documentation/image/da3f0e0f-98ed-412d-905f-d3bf805d50b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da3f0e0f-98ed-412d-905f-d3bf805d50b8?resizing_type=fit)

Value bindings for the Shield and Health functions.

The HUD Controller functionality now updates the **Brush** property in the Image widget through the **Scalar Parameter** conversion function by looking at the **Progress** property and passing the Health and Shield value into it.

Progress is the value that moves the bar back and forth between the **Progress Start** and **ProgressEnd** values. This means that the Progress value is bound between **0** and **1**.

| ShieldBar Material Parameter Groups | HealthBar Material Parameter Groups |
| --- | --- |
|  |  |

If you start the game with full Health and Shields, damage causes the bar to move to the left based on the **Progress** and **Normalize Progress** properties. These properties determine how much the material moves to the left when the player takes damage.

The material will move across the bar to the right when Health and Shields are restored at the same rate they deteriorate using the **Progress** and **Normalize Progress** properties.

Open other User Widgets and see if you can read them and understand the order the UMG Widgets were added to the Hierarchy, the type of viewmodel selected for the User Widget, and how the UMG Widget parameters and device functions are bound in View Bindings.

## Equipped Item Viewmodel

This viewmodel can be used with the **HUD Controller** device to track the statistics of an equipped item using the **Equipped Item Info Widget Override** widget slot. All UI samples use the **WID\_Assault\_AutoHigh\_Athena\_C\_Ore\_T03** Assault Riffle as the equipped item.

[![The Equipped Item Info Widget Override widget.](https://dev.epicgames.com/community/api/documentation/image/7d2ad46d-27d2-47b9-9a6a-d8999c259cfd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d2ad46d-27d2-47b9-9a6a-d8999c259cfd?resizing_type=fit)

The Equipped Item Info Widget Override widget.

Open the **Devices** > **HUD Controller** > **Widgets** folder and double-click the **UW\_HCD03\_SelectedItem** widget. From this viewmodel, you can track a number of weapon info and statistics in the UI:

1. Item Icon
2. Item Name
3. Ammo Icon
4. Ammo Count
5. Ammo Surplus
6. Is Magazine Type Weapon

[![](https://dev.epicgames.com/community/api/documentation/image/360d3a74-225e-45ae-ad3f-ba8175110dbc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/360d3a74-225e-45ae-ad3f-ba8175110dbc?resizing_type=fit)
