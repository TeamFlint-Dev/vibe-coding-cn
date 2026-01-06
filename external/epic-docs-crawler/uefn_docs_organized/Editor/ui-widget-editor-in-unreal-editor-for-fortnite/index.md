# UI Widget Editor

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:07:05.996336

---

The editor opens when you double-click a widget thumbnail. Inside the editor, you can add all the parts of your custom UI by dragging them into the viewport. Below is a breakdown of the Widget Editor.

[![widget editor](https://dev.epicgames.com/community/api/documentation/image/00307b24-52f9-40c5-8629-6cf1a7ce0b1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00307b24-52f9-40c5-8629-6cf1a7ce0b1d?resizing_type=fit)

*Click to enlarge image.*

| Number | Description |
| --- | --- |
| 1 | **Menu and Tab Bar** |
| 2 | **Quick Tools** |
| 3 | **Palette Panel** |
| 4 | **Viewport** |
| 5 | **Details Panel** |
| 6 | **Hierarchy Tab** |
| 7 | **Animations Tab** |
| 8 | **Bottom Toolbar** |

## Menu and Tab Bar

[![](https://dev.epicgames.com/community/api/documentation/image/d5fff353-05b9-45e0-9cca-1ca47a0b8032?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5fff353-05b9-45e0-9cca-1ca47a0b8032?resizing_type=fit)

### File

- **Recent Widget Blueprint Assets**: Shows a list of the recent widget assets blueprints that you've opened for the project.
- **Save All**: Saves all assets and levels to disk.
- **Save**: Saves the widget blueprint.
- **Save As...**: Saves the widget blueprint under a new name.
- **Compile**: Compiles the widget blueprint.
- **Reparent Blueprint**: Changes the parent of the blueprint.

### Edit

- **Undo**: Reverses the most recent change.
- **Redo**: Redoes the last action.
- **Undo History**: View the entire undo history.

### Asset

- **Find in Content Browser**: Browses to the associated asset and selects it in the most recently used Content Browser.
- **Reference Viewer**: Launches the Reference Viewer showing the selected assets' references.

### Window

- **Load Layout**: Provides additional options to load the layout using the **Default** layout or the **UE4** layout.
- **Save Layout**: Saves the selected layout view.
- **Remove Layout**: Removes a layout view.
- **Enable Fullscreen**: Opens the editor in fullscreen.
- **Details**: Opens the Details panel on the right side of the editor window.
- **Designer**: Opens the Designer tab.
- **Compiler Results**: Opens the Compiler Results tab and shows any errors or warnings generated when compiling this blueprint.
- **Animations**: Opens the Animations tab.
- **Hierarchy**: Opens the Hierarchy tab.
- **Palette**: Open the Palette tab.
- **View Bindings**: Opens the View Bindings tab.
- **Viewmodels**: Opens the Viewmodels tab.
- **Cinematics**: Provides additional options for **Take Recorder** or **Takes Browser**.
- **Content Browser**: Opens a Content Browser tab.
- **Message Log**: Opens the Message Log tab.
- **Output Log**: Opens the Output Log tab.

### Help

- **Widget Editor Documentation**: Opens the Widget Editor documentation in the **Epic Developer Community** site.
- **Dev Community**: Opens the Epic Development Community site.
- **Learning Library**: Opens the Learning Library.
- **Forums**: Opens the Unreal Editor for Fortnite (UEFN) forums.
- **Snippets**: Opens the Verse Snippets site.
- **About Unreal Editor**: Provides information about the editor Version, your Platform, and the copyright information.
- **Credits**: A list of employees past and present that worked on UEFN.
- **Visit UnrealEngine.com**: Opens the Unreal Engine site.

## Quick Tools

[![](https://dev.epicgames.com/community/api/documentation/image/0598b914-f468-4bc5-a980-8048105af79d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0598b914-f468-4bc5-a980-8048105af79d?resizing_type=fit)

Quick access buttons:

- **Save**: Saves the blueprint.
- **Folder**: Opens the Content Browser.
- **Compile**: Compiles the blueprint.

## Palette Panel

Contains the assets to create custom UI that can be dragged into the viewport. Search for assets in the search bar.

[![](https://dev.epicgames.com/community/api/documentation/image/946d7cd8-7052-403e-8179-a733c648ec71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/946d7cd8-7052-403e-8179-a733c648ec71?resizing_type=fit)

### Common

The material instances you create can be found in the **Common UI** section of the **Palette** panel. From there, add your button backgrounds along with a **Button** widget that can be customized through its settings.

- **Image**: Place an image as your UI background or for a button.
- **Named Slot**: Allows you to expose an external slot for your user widget. When others reuse your user control, they can put whatever they want in this named slot.
- **UEFN Text Block**: Craft a custom UI message.

### Panel

- **Canvas Panel**: The canvas panel is a designer friendly panel that allows widgets to be laid out at arbitrary locations, anchored and z-ordered with other children of the canvas. Use this widget for manual customization.
- **Grid Panel**: A table-like panel that retains the width of every column throughout the table. Allows for children's assets.
- **Overlay**: Allows widgets to eb stacked on top of eachother, uses simple flow layout for content on each layer.
- **Scale Box**: Allows you to place content with a desired size and have it scale to meet the constraints placed on this box's allotted area. if you needed to have a background image scale to fill an area but not become distorted with different aspect ratios, or if you need to auto fit some text to an area, this is the control you need.
- **Scroll Box**: An arbitrary scrollable collection of widgets. Great for presenting 10-100 widgets in a list. Doesn't support virtualization.
- **Size Box**: The **Size Box** allows you to resize the entire design within the Overlay boundary it lies within.
- **Stack Box**: A Stack Box is a layout panel that allows child panels to be placed vertically or horizontally. With all of the UI assets being contained in a Stack Box, a Size Box is placed as its child.
- **Uniform Grid Panel**: A panel that evenly divides up available space between all of its children.

### User Created

The top of the list includes the blueprint widget as the parent asset.

- **UEFN Button Loud**: A large button that includes a large print and yellow background color.
- **UEFN Button Quiet**: A small button that includes small print and white background color.
- **UEFN Button Regular**: A regular sized button that includes large print and a white background.
- **UEFN Slider**: A slider box that can take position values and size values.

## Viewport

The viewport shows the assets that make up the blueprint's layout.

[![](https://dev.epicgames.com/community/api/documentation/image/d343a6ed-6652-4fa4-83a4-4259358f8b4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d343a6ed-6652-4fa4-83a4-4259358f8b4f?resizing_type=fit)

## Details Panel

The **Details** panel contains information for the current selection in the Viewport. This panel provides information on location, size, images, and more.

[![](https://dev.epicgames.com/community/api/documentation/image/9fe00765-d3c7-45f7-b1b9-1398e29669b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fe00765-d3c7-45f7-b1b9-1398e29669b1?resizing_type=fit)

## Hierarchy Tab

How you arrange the list of assets in the **Hierarchy** tab determines the boundaries and positioning of each UI element. As you add to the **Hierarchy** tab, remember to use the **Details** panel to size and align every asset boundary.

While learning how to layer assets, it may be easier to draw a rough draft of your design on paper, creating an outer box outline that represents a canvas that holds your design.

The video above is a brief demonstration of adding and aligning grids.

[![Custom Hierarchy Tab](https://dev.epicgames.com/community/api/documentation/image/8e566793-3ef8-42b3-b4a4-fe7f4b43f950?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8e566793-3ef8-42b3-b4a4-fe7f4b43f950?resizing_type=fit)

The photo above is a reference for arranging assets in the **Hierarchy** tab using Overlays, Stack Boxes, and Size boxes.

### Overlays

**Overlays** are containers for assets. The first Overlay placed in the example above serves as a canvas. A second Overlay is placed as a child to serve as the container for assets that are organized in a **Stack Box**.

Another Overlay widget is set as the Size Box's child to serve as the container for all of the assets that are affected by the Size Box, which exists inside a grid.

### Stack Box

A Stack Box is a layout panel that allows child panels to be placed vertically or horizontally. With all of the UI assets being contained in a Stack Box, a Size Box is placed as its child.

### Size Box

The **Size Box** allows you to resize the entire design within the Overlay boundary it lies within.

The design's overall Size Box's Overlay contains three Size Box children that hold grouped pieces that make up the flower design, petals, disk flower, and buttons.

So, while the entire design can be resized, the pieces within the design can also be individually resized.

Within the Hierarchy layout, **UEFN Text Boxes** are placed within the button and UI containers to display text in the UI and on the buttons.

## Animations

Create an animation for your UI assets by using the **+Animation** button to create a new animation in the Widget Editor's Sequencer panel.

[![](https://dev.epicgames.com/community/api/documentation/image/e059468b-6e64-4cc1-8e0d-608d8972febd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e059468b-6e64-4cc1-8e0d-608d8972febd?resizing_type=fit)

## Bottom Toolbar

The bottom toolbar has a number of quick buttons to find assets, view bindings, check logs, and save or sync changes as well.

[![](https://dev.epicgames.com/community/api/documentation/image/f3381c3a-5bfa-4e02-a38a-9967b08bb3f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f3381c3a-5bfa-4e02-a38a-9967b08bb3f4?resizing_type=fit)

- **Content Drawer**: Opens the assets in the Content Drawer.
- **Animations**: Opens the Animation tab and allows you to create a new animation for your UI assets.
- **View Bindings**: Allows you to open the Viewmodel tab to add functions to UI buttons.
- **Output Log**: Opens the output log to view errors and warnings.
- **Command**: Opens the command panel where you can type commands.
- **Save Status**: Informs you of the blueprints saved status.
- **Check-in Changes**: Check in your changes to Unreal Revision Control.
- **Project Status**: Informs you whether your project is at latest or not.
- **Revision Control**: Opens the revision control options.
