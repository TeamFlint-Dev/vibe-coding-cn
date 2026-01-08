# UI Layout in UMG

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:07:18.197312

---

[Unreal Motion Graphics (UMG)](https://dev.epicgames.com/documentation/en-us/unreal-engine/umg-ui-designer-quick-start-guide-in-unreal-engine?application_version=5.5) is a powerful tool for building [user interfaces (UI)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#ui). Whether you’re creating a simple pop-up or complex UI systems, understanding the core concepts of working in UMG gives you the freedom to experiment with this powerful tool.

To take your UI designs from paper to playtest, you need to understand how UMG builds UI. To acquaint you with proper UI building workflows, this page is broken into the following sections:

- **[Designing UI Systems](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#designing-ui-systems)**
- **[Understanding UMG Widgets](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#understanding-umg-widgets)**
- **[Creating and Layering User Widgets](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#creating-and-layering-user-widgets)**
- **[Editing a Layout](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#editing-a-layout)**

## Designing UI Systems

Planning your UI design is key to creating good-looking and useful UI systems. Think about:

- The type of game you're building.
- The type of UI needed to support players and keep the gameplay fun and easy to understand.
- How the final UI is going to look.

For example, in the Fortnite HUD everything the player needs to understand about the game; relevant health and shield information to overall game stats are laid out around the screen.

[![The Fortnite Battle Rpyale HUD is a good example of UI design that informs the player of their stats in the game and also gives the player control over their inventory.](https://dev.epicgames.com/community/api/documentation/image/a13effbc-6a63-4559-91a1-6a1eb0eeef9a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a13effbc-6a63-4559-91a1-6a1eb0eeef9a?resizing_type=fit)

Sketch out the UI design ideas you have. Use these sketches to guide how the UI is built in UMG.

Basic web design approaches can help you plan the layout for your UI before you begin building [User Widgets](https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite). These approaches can be used to decide which parts of the UI need to be rigid and which can be flexible. Use the following web design approaches for UI layout:

- [Absolute](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#absolute-layout) vs [Relative](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#relative-layout) Layout
- [Padding and Spacing](https://dev.epicgames.com/documentation/en-us/fortnite/ui-layout-in-umg-in-unreal-editor-for-fortnite#padding-and-spacing)

### Absolute Layout

Absolute layouts usually use precise calculations and coordinates to specify where to place elements on a screen. This is useful when a UI element needs to remain in place using the X and Y coordinates. The UI element should consider where the parent element is placed on the screen, the parent element starts at the top left corner of the layout.

This style of layout is less flexible and hard to maintain for various screen sizes.

An absolute layout design is best used for small elements that are part of a larger design. For example, use an absolute position for an icon. In UEFN, this can be set using the **Alignment** and **Padding** settings of the Image widget.

[![An absolute layout design is usually best used in UI for small elements that are part of a larger design.](https://dev.epicgames.com/community/api/documentation/image/77d3d30c-8511-4e7f-b0a6-35a1c8c4e0f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/77d3d30c-8511-4e7f-b0a6-35a1c8c4e0f2?resizing_type=fit)

The icon remains in the same place regardless of the placement and size of the other UI elements around it.

### Relative Layout

This type of layout works best for games that can be played on multiple platforms because it will adapt the UI to a large television screen or a small cell phone screen.

### Padding and Spacing

Padding can be used to adjust small spaces between elements of a whole. Padding can be hard to manage for individual widgets in UMG. Instead, use the **Alignment** tools for images and text blocks, alignment provides more control over space and placement than padding.

This means after all the pieces are in place, if you still need a bit of space between elements, adjusting the padding settings of individual widgets adds the necessary space.

To force larger spaces between widgets, use an empty image or slot widget between container widgets and User Widgets. Below you can see that an Image widget is used to force space between each User Widget, providing space for each widget to clearly display information.

[![Force larger spaces between widgets with an Image widget.](https://dev.epicgames.com/community/api/documentation/image/bd043b78-d5e3-4fd7-ae08-e180009f505d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd043b78-d5e3-4fd7-ae08-e180009f505d?resizing_type=fit)

## Understanding UMG Widgets

A UI should be designed in sections in UMG. Build UI by creating individual User Widgets and working in layers. Once all elements of a UI are ready, layer the individual sections under one parent User Widget. Building UI in layers means having more control over the design and layout of the overall UI.

To plan and create individual User Widgets, you must first understand the widgets available in the **Palette panel**. There are two main types of widgets; **containers** and **elements**.

### Containers

A **container** holds multiple User Widgets, elements, and other containers to create a piece of the UI. An **element** can be an image, material, text, or more. The size of a container widget is determined by the size of the largest child element.

| Container Widget | Purpose | Image |
| --- | --- | --- |
| **Grid** | Lays out elements within a flexible grid pattern.  Adds options to child elements for:   - Row - Row Span - Column - Column Span - Layer - Nudge | [Example of a Grid container.](https://dev.epicgames.com/community/api/documentation/image/acf4e418-f1a1-401d-92d0-e6ba1853de36?resizing_type=fit) |
| **Uniform Grid** | Lays out child elements in rows and columns with equal spacing.  Adds options to child elements for:   - Row - Column | [Example of a Uniform Grid container.](https://dev.epicgames.com/community/api/documentation/image/4c768d58-34e7-485b-8c3f-ff7b6e88bb21?resizing_type=fit) |
| **Overlay** | Layers elements and other container widgets on top of one another.  Overlay containers do not add extra options or settings to their child elements. | [Example of an Overlay container.](https://dev.epicgames.com/community/api/documentation/image/dbb29eff-7429-4909-9371-c807b79f60ea?resizing_type=fit) |
| **Stack Boxes** | Lays out elements either horizontally or vertically (left to right, up to down). This container widget doesn’t space elements well on its own.  Use other container or element widgets to create space in a Stack box. | [Example of a Stack box container.](https://dev.epicgames.com/community/api/documentation/image/9f75bba0-a378-4a13-9b5d-710d7746eca0?resizing_type=fit) |
| **Size Box** | Introduces parameters that restrict the size of its child elements.  Size Box containers do not add extra options or settings to their child elements. | [Example of a Size Box container.](https://dev.epicgames.com/community/api/documentation/image/0eea1f83-3287-4e1f-abf4-c7f87188a1d0?resizing_type=fit) |
| **Scale Box** | Specifies how to scale UI to screen size. | [Example of a Scale box container.](https://dev.epicgames.com/community/api/documentation/image/a7d19320-9397-4ce5-9f26-f4099ae9ab87?resizing_type=fit) |
| **Scroll Box** | Creates a scrollable box to contain a collection of elements.  Scroll Box containers do not add extra options or settings to their child elements. | [Example of a Scroll Box container.](https://dev.epicgames.com/community/api/documentation/image/c5b84aae-5988-457c-9a53-e271568e8de8?resizing_type=fit) |
| **Widget Switcher** | Provides a way to "Tab" through widgets. In this container widget, one widget at a time is visible in the switcher.  Widget Switcher containers do not add extra options or settings to their child elements. | [Example of a Widget Switcher container.](https://dev.epicgames.com/community/api/documentation/image/101e7ab9-c4be-4076-8227-dff4e5801bfe?resizing_type=fit) |
| **Canvas** | Anchors elements within a defined space. It is best used at the end of the design process as the parent container.  Adds the following options to its child elements:   - Anchors - Position X - Position Y - Size X - Size Y - Alignment - Size to Content - ZOrder | [Example of a Canvas container.](https://dev.epicgames.com/community/api/documentation/image/a856f7ae-9ee2-4912-b5fb-14c86477e201?resizing_type=fit) |

### Element Widgets

All widgets have **Appearance** properties followed by settings specific to the selected widget in the Details panel.

The size of child elements can be set in the Details panel and inherit properties from the parent container widget.

| Element Widget | Purpose | Images |
| --- | --- | --- |
| **Action Widget** | Provides a way to take an input from a key bind for a specific action using Verse.  On its own, the widget is purely cosmetic. |  |
| **Image** | Provides a way to add textures (can be [imported images](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) or textures found natively in UEFN) and materials to the background or foreground of a User Widget. | [Example of an image element.](https://dev.epicgames.com/community/api/documentation/image/3530ab31-9b8e-446e-b3a4-44829c900ab3?resizing_type=fit) |
| **Text Block** | Adds text to the User Widget. You can control the size, font, spacing and more.. | [Example of a text block element.](https://dev.epicgames.com/community/api/documentation/image/f55b7d81-5a11-4dc1-ad44-d4856e8cbf0b?resizing_type=fit) |
| **Quiet Button** | A rectangular button with a transparent background. | [Example of a Canvas container.](https://dev.epicgames.com/community/api/documentation/image/5d302ee6-058f-48ad-ab57-f28cb200c72a?resizing_type=fit) |
| **Regular Button** | A rectangular button with an opaque background. | [Example of a Canvas container.](https://dev.epicgames.com/community/api/documentation/image/c003ced6-462d-42f1-93da-0a2faa7bd128?resizing_type=fit) |
| **Loud Button** | A rectangular button with a yellow background. | [Example of a Canvas container.](https://dev.epicgames.com/community/api/documentation/image/dfa0678f-e01f-4d80-b9f7-96d9d583fd4c?resizing_type=fit) |
| **Slider** | A value slider that increases or decreases within a specified range. | [Example of a Canvas container.](https://dev.epicgames.com/community/api/documentation/image/91a8bd97-0ba8-4ae9-b612-c97d54d52275?resizing_type=fit) |

To learn more about widgets in Verse, refer to [Widget Types](https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite).

## Creating and Layering User Widgets

User Widgets are UI files that contain everything you designed. When creating a User Widget, compartmentalize your design as much as possible. This means only using what you need in a User Widget to achieve the desired look for your UI element.

In the image below, four User Widgets were created for each component of the collected items hotbar. Each User Widget tracks the individual stats for the different components while maintaining the same UI design.

[![User Widgets are UI files that contain everything you designed within that UI file.](https://dev.epicgames.com/community/api/documentation/image/af5d21b9-6f6b-4742-ba33-81689e02fe0d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af5d21b9-6f6b-4742-ba33-81689e02fe0d?resizing_type=fit)

Designing separate User Widgets means that they can be layered inside a parent User Widget to create a more consistent and controlled look for the collection bar hotbar. It’s also easier for the Tracker device to track the stats for each individual component of the collection hotbar.

[![Creating and layering individual widgets is used to control the look of the collection bar hotbar.](https://dev.epicgames.com/community/api/documentation/image/885139db-81a1-4c1f-8ec4-5ae8f3f8072a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/885139db-81a1-4c1f-8ec4-5ae8f3f8072a?resizing_type=fit)

*Click to enlarge image.*

Designing UI in this manner takes practice. Follow the [Making a Custom HUD tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-hud-in-unreal-editor-for-fortnite) and the [Teenage Mutant Ninja Turtles tutorials](https://dev.epicgames.com/documentation/en-us/fortnite/teenage-mutant-ninja-turtle-islands-in-unreal-editor-for-fortnite) to practice creating individual User Widgets to create a custom Squad look for a game.

## Editing a Layout

Using individual User Widgets to create UI makes editing UI easy. Providing a way to edit that one piece without affecting other parts of the UI design.

Notice in the collection bar hotbar design above, all element labels are centered except for one. In this case the creator simply opens the User Widget for that one element and edits the label without causing issues for all the other elements of the collection bar hotbar.

If you are designing something more complex like an inventory system, you might find that you’re either using container widgets you don’t need, or are having trouble getting your element widgets to conform to the design. UMG has options that make editing a layout easy:

- **Replace With…**
- **Wrap With…**

### Replace Widgets

Replace unnecessary widgets from the Hierarchy without breaking the layout. Right-click on the unnecessary widget, then select **Replace With…** and choose another widget to replace it with. The substitute widgets are all container type widgets.

The child widgets’ options change according to the new parent container used.

### Wrap Widgets

One way to modify the layout without affecting all the child widgets is using the **Wrap With...** setting in the Hierarchy. Right-click on the child widget and select **Wrap WIth…** then select a container from the dropdown menu to take advantage of its properties and maintain the settings of the child widgets.

## Playtest

Once your design is complete, playtest your design. You should be looking for the following:

- The UI serves a purpose. Don’t create UI for the sake of having UI, it should be useful.
- The UI is helpful and user friendly, players shouldn’t have to guess what the UI does while playing a game.
- The UI should blend into the game and complement the gameplay.
- Your UI elements don’t block gameplay.
