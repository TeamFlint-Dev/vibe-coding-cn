# Mission Selection Screen

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/making-a-mission-selection-screen-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:06:38.582006

---

**Mission selection screens** usually appear at the beginning of a game to provide players with a choice of missions. Sometimes a mission selection screen appears after a quick game tutorial familiarizes players with the game rules and mechanics.

Mission selection starts the game and takes players to a specific starting spot on the island for that mission. These screens can include details about mission statistics, provide information about the type of missions the player can choose from, or simply drop players into the selected mission.

The following tutorial teaches you how to create a mission screen that drops players into their selected mission.

## Step 1: Research Mission Selection Styles

 There are a number of ways to design a menu selection screen, depending on the amount of information you want to provide to players. Information can be in the form of mission descriptions or texture images of the mission level. For this example you’ll see examples of both to see the impact that you can create with just materials, or by strategically adding textures to your design.

Textures use a lot of memory and can eat up a significant portion of your total island memory count.

Deciding on the amount of information to include on the mission selection screen benefits the design phase.

## Step 2: Design the Layout

Design the mission screen layout before opening UMG. Any design choices you make at this point are not permanent and can be redesigned without breaking any UI functionality. The screen layout is dependent upon what’s included on the mission selection screen.

These are 4 initial layout decisions to make at this stage:

- **Color Scheme** - Use the 60 / 30 / 10 rule when using color in your UI.
- **Font Choice** - Currently there are two font choices; Burbank and HeadingNow.
- **Materials** - Use the [UI Feature Template Materials](https://dev.epicgames.com/documentation/en-us/uefn/material-assets-in-unreal-editor-for-fortnite) to create your own unique look for your UI.
- **Images / Textures** - Textures should be [reserved for complicated art](https://dev.epicgames.com/documentation/en-us/fortnite/material-assets-in-unreal-editor-for-fortnite) that cannot be easily re-created with materials, such as characters, or artistic containers.

The 60 / 30 / 10 rule means that 60% of the color used in your UI design should be the main color, 30% the secondary color, and 10% the accent color. This makes your UI easier to read and navigate.

When you’ve decided on a color scheme, [create materials and material instances](https://dev.epicgames.com/documentation/en-us/uefn/creating-custom-ui-with-material-instances-in-unreal-editor-for-fortnite) to use in your UI design.

For this example, the design is simple. There’s a call to action at the top of the screen telling players to “Choose Your Mission”, followed by three images labeled Mission 1, 2, and 3, and each with a START button.

[![An example of how the Mission screen should be laid out.](https://dev.epicgames.com/community/api/documentation/image/731c2043-f153-44a1-bee3-5f3c7b0929a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/731c2043-f153-44a1-bee3-5f3c7b0929a2?resizing_type=fit)

UI Layout Design

## Step 3: Design the Widget Layout

There are 4 main parts to the widget layout example:

1. Background Design
2. Mission 1 Tile Design
3. Mission 2 Tile Design
4. Mission 3 Tile Design

To create a widget that has working buttons, you need to use a **Modal Dialog Variant Widget.** There’s a special Viewmodel used with the Modal Dialog Variant Widget that provides a way to bind buttons to devices.

1. [Create and open a User Interface folder.](https://dev.epicgames.com/documentation/en-us/uefn/project-organization-in-unreal-editor-for-fortnite)
2. Inside the folder, create a **Modal Dialog Variant** [widget](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite).
3. Name the widget **Mission\_Select\_UI**.
4. Double-click the Mission\_Select\_UI widget to open the [Widget Editor](https://dev.epicgames.com/documentation/en-us/uefn/ui-widget-editor-in-unreal-editor-for-fortnite).

### Background Design

In this example, the background design of the mission selection screen involves using materials to add blocks of color to the background, adding a call to action at the top of the screen, and adding a texture image of a character.

In the Widget Editor, do the following:

1. From the **Palette** panel, drag an **Overlay** widget onto the widget graph. This widget becomes the root widget and acts as the screen where the UI appears.
2. In the Widget Graph, expand the Overlay widget until its size is **1920 X 1080**.

   [![](https://dev.epicgames.com/community/api/documentation/image/45f526b9-628d-41cd-b00e-74c69c470457?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/45f526b9-628d-41cd-b00e-74c69c470457?resizing_type=fit)
3. In the **Hierarchy** panel, right-click the **Overlay** widget to open the **Context Menu**. Select **Rename** from the dropdown menu and name the widget **Root**. This widget encompasses all widgets that make up the Mission Selection screen.

   [![](https://dev.epicgames.com/community/api/documentation/image/370e6ef5-98c9-4fab-8384-38473c3e564e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/370e6ef5-98c9-4fab-8384-38473c3e564e?resizing_type=fit)
4. Change the graph layout to **Desired**. This lets you set the UI to the exact size you want it to appear on any screen.

   [![](https://dev.epicgames.com/community/api/documentation/image/a8f02df0-052a-4b25-8d13-4cc95061507a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8f02df0-052a-4b25-8d13-4cc95061507a?resizing_type=fit)

   You can view how your UI changes according to platform by selecting a screen from the Screen Size dropdown menu.

   [![](https://dev.epicgames.com/community/api/documentation/image/c1d95ec1-0d51-457f-b1e3-4d00d5dd0a0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1d95ec1-0d51-457f-b1e3-4d00d5dd0a0a?resizing_type=fit)
5. Drag an **Overlay** panel from the **Palette** panel under the **Root** widget and rename it **Parent Container**. This Overlay widget will house all parts of the Mission Select screen.

   [![](https://dev.epicgames.com/community/api/documentation/image/21fad97f-b061-4083-a6e6-f43e8dbcd19b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/21fad97f-b061-4083-a6e6-f43e8dbcd19b?resizing_type=fit)

   This widget should be the same size as the Root widget.
6. Change the alignment options for the Parent Container widget to Fill Horizontal and Fill Vertical.

   [![](https://dev.epicgames.com/community/api/documentation/image/d395b660-1431-4696-8002-e2f52e875fb1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d395b660-1431-4696-8002-e2f52e875fb1?resizing_type=fit)
7. Drag an **Image** widget from the **Palette** panel into the **Hierarchy** panel under the **Parent Container** widget.
8. Right-click the **Image** widget to open the Context Menu. Select **Rename** from the dropdown menu and name the widget **UI Background Color**.

   [![](https://dev.epicgames.com/community/api/documentation/image/82043e94-83f5-4cee-bb72-49e4910e7bee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/82043e94-83f5-4cee-bb72-49e4910e7bee?resizing_type=fit)
9. Select the **UI Background Color** widget in the **Hierarchy** panel to open its options in the **Details** panel.
10. Under the **Slot (Overlay Slot)** options, use the following alignment settings:

    1. Horizontal Alignment = **Fill Horizontal**
    2. Vertical Alignment = **Fill Vertical**

    [![](https://dev.epicgames.com/community/api/documentation/image/b061ca69-7765-4d55-a0d4-7a21b64ab66e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b061ca69-7765-4d55-a0d4-7a21b64ab66e?resizing_type=fit)
11. Under the **Appearance** options, use the **Brush** > **Image** dropdown menu to select your primary color material. This makes the Image widget the color of the material.

    [![](https://dev.epicgames.com/community/api/documentation/image/e415eb59-ef21-4ce9-9ea9-74f3ffd49c82?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e415eb59-ef21-4ce9-9ea9-74f3ffd49c82?resizing_type=fit)
12. Drag a **Grid Panel** widget from the **Palette** panel into the **Parent Container** widget and rename it **Body**. The Grid panel acts as a container for all the content of the UI. It also adds a flexible grid to the layout that organizes its child widgets in rows and columns. In this example, the content of the mission screen and the character image.

    [![](https://dev.epicgames.com/community/api/documentation/image/f6367287-b72a-4cbc-ae5f-e49cb236f8f2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6367287-b72a-4cbc-ae5f-e49cb236f8f2?resizing_type=fit)
13. Under **Slot (Overlay Slot)** options, use the following settings:

    1. Horizontal Alignment = **Center Alignment**
    2. Vertical Alignment = **Center Alignment**
    3. Padding = **64.0**

    [![](https://dev.epicgames.com/community/api/documentation/image/ecd8b0d6-7079-4f00-aaff-c37962a82222?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecd8b0d6-7079-4f00-aaff-c37962a82222?resizing_type=fit)
14. Drag a **Stack Box** into the **Body** widget and rename it **Content**. A Stack Box uses either horizontal or vertical alignment to lay out its child widgets.

    [![](https://dev.epicgames.com/community/api/documentation/image/967f25c5-4077-46a9-84a5-f9724edf412b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/967f25c5-4077-46a9-84a5-f9724edf412b?resizing_type=fit)
15. Change the alignment settings for the **Content** widget to **Fill Horizontal** and **Fill Vertical**.

    [![](https://dev.epicgames.com/community/api/documentation/image/3fee67b8-7111-4c3b-92a6-0241c1665d74?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3fee67b8-7111-4c3b-92a6-0241c1665d74?resizing_type=fit)
16. Under the **Behavior** option, change the **Orientation** setting to **Vertical**.

    [![](https://dev.epicgames.com/community/api/documentation/image/43cbd5eb-7bf4-4516-9bbc-1f0cb1b979eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/43cbd5eb-7bf4-4516-9bbc-1f0cb1b979eb?resizing_type=fit)

#### Adding Callout Text

1. Drag a **Text Box** widget from the **Palette** panel and nest it under **Content**. This becomes the callout text prompting players to pick a mission.
2. Rename the Text Box to **Choose Your Mission**.

   [![](https://dev.epicgames.com/community/api/documentation/image/f9dd97e2-1df3-43ee-b0bc-99a1e603427a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f9dd97e2-1df3-43ee-b0bc-99a1e603427a?resizing_type=fit)
3. Select the **Choose Your Mission** widget from the **Hierarchy** panel to open its options in the **Details** panel.
4. Under **Slot (Slot Overlay)** options, use the following settings:

   1. Size = **Auto**
   2. Horizontal Alignment = **Left Alignment**
   3. Vertical Alignment = **Fill Vertical**

   [![](https://dev.epicgames.com/community/api/documentation/image/c7b65173-a649-4d18-90f0-cd3a90d4d0a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7b65173-a649-4d18-90f0-cd3a90d4d0a3?resizing_type=fit)
5. Click the Text field, delete the default text and type **Choose Your Mission**.

   [![](https://dev.epicgames.com/community/api/documentation/image/23ac9219-b80c-4cc4-9f50-fd10dd733356?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23ac9219-b80c-4cc4-9f50-fd10dd733356?resizing_type=fit)
6. Under the **Appearance** options, use the following settings:

   1. Color and Opacity = **Hex Linear E0137CFF**
   2. Font Family = **HeadingNow**
   3. Typeface = **86Bold**
   4. Size = **85**
   5. Outline Size = **2**
   6. Mitered Corners = **Check**
   7. Outline Color = **Hex Linear FFFFFFFF**

   [![](https://dev.epicgames.com/community/api/documentation/image/0d0b26da-4fc2-4934-aa47-71d7977370b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d0b26da-4fc2-4934-aa47-71d7977370b6?resizing_type=fit)
7. Drag an **Image** widget into the **Content** widget and rename it **Spacer**. This widget is used as a spacer to put space between the callout and the mission tiles.

   [![](https://dev.epicgames.com/community/api/documentation/image/8279fa1b-fbb7-42d0-945b-5ae877a8d5be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8279fa1b-fbb7-42d0-945b-5ae877a8d5be?resizing_type=fit)

#### Adding the Mission Tile Space

1. Drag an **Overlay** widget into the **Content** widget and rename it **Tiles**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c633d262-f009-4e83-9c21-735c39eaefc2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c633d262-f009-4e83-9c21-735c39eaefc2?resizing_type=fit)
2. Drag an **Image** widget into the **Tiles** widget and rename it **TileBG**.

   [![](https://dev.epicgames.com/community/api/documentation/image/91b69236-f587-4882-9f7e-361b7e3ebbb4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91b69236-f587-4882-9f7e-361b7e3ebbb4?resizing_type=fit)
3. Select the **TileBG** widget in the **Hierarchy** panel to open its options in the **Details** panel.
4. Under the **Slot (Overlay Slot)** options, use the following settings:

   1. Horizontal Alignment = **Fill Horizontal**
   2. Vertical Alignment = **Fill Vertical**

   [![](https://dev.epicgames.com/community/api/documentation/image/6b4a8321-6930-48da-8bcb-041689899cf5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b4a8321-6930-48da-8bcb-041689899cf5?resizing_type=fit)
5. Under the **Appearance** options, use the following settings.

   1. Brush > Image = Secondary background material
   2. Image Size:

      1. X = 1200
      2. Y = 32.0

   [![](https://dev.epicgames.com/community/api/documentation/image/90a2865b-b047-4b52-8f8e-6a8cfd70b332?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/90a2865b-b047-4b52-8f8e-6a8cfd70b332?resizing_type=fit)
6. Drag a **Stack Box** widget into the **Tiles** widget and rename it **Mission Tiles**. This Stack Box will order the mission tiles from left to right.

   [![](https://dev.epicgames.com/community/api/documentation/image/9d556ecf-42be-4a75-9c38-0cf3dc4678d1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d556ecf-42be-4a75-9c38-0cf3dc4678d1?resizing_type=fit)

The background layout is complete. The mission selection screen should look pretty empty at this stage.

[![](https://dev.epicgames.com/community/api/documentation/image/19241dcb-df35-4580-b8bc-b8870daebc44?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19241dcb-df35-4580-b8bc-b8870daebc44?resizing_type=fit)

Next, you will lay out the three mission selection tiles and build them inside the Stack Box widget. You will also add a Character texture to the design to add visual interest.Mission 1 Tile Design

Mission tile design can provide information on the level and objectives and feature statistics about player objectives, and can even track the player’s progress in those objectives. This tile example provides a more simplistic design. There is a background texture that shows a representation of the level, a mission number, and a start button. Using a series of Stack Boxes provides a way to lay out widgets left to right or up and down. When you have a vertical or horizontal layout, a Stack box helps to keep the layout consistent.All three Mission tiles follow the same design pattern. Follow the directions below to build all three selection tiles.

1. Drag an **Overlay** widget into the **Grid Panel** in the **Hierarchy** panel and rename it **Mission 1**. This becomes a bucket that contains all the design elements for the Mission 1 tile.

   [![](https://dev.epicgames.com/community/api/documentation/image/c3fe7a2b-c443-4467-b96d-5189a2ecf426?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3fe7a2b-c443-4467-b96d-5189a2ecf426?resizing_type=fit)
2. Select the **Mission 1** widget in the **Hierarchy** panel to open its options in the **Details** panel.
3. Under the **Slot (Stack Box Slot)** option, use the following **Padding** settings:

   1. Left = **0.0**
   2. Top = **0.0**
   3. Right = **24.0**
   4. Bottom = **0.0**

   [![](https://dev.epicgames.com/community/api/documentation/image/f418b6e6-9300-4889-b7d3-176a2ccc5a63?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f418b6e6-9300-4889-b7d3-176a2ccc5a63?resizing_type=fit)
4. Drag an **Image** widget into the **Mission 1** widget in the **Hierarchy** panel and rename it **Mission1Image**. This widget is the visual representation of Mission1.

   [![](https://dev.epicgames.com/community/api/documentation/image/ea43c1da-cfa9-4263-b0e5-92a325a9c051?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea43c1da-cfa9-4263-b0e5-92a325a9c051?resizing_type=fit)
5. Select **Mission1Image** in the **Hierarchy** panel to open its options in the **Details** panel.
6. Under the **Slot (Stack Box Slot)** options, use the following settings:

   1. Horizontal Alignment = **Full Horizontal**
   2. Vertical Alignment = **Full Vertical**

   [![](https://dev.epicgames.com/community/api/documentation/image/bdafe9ba-192f-403b-8f29-63b5a63abb77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bdafe9ba-192f-403b-8f29-63b5a63abb77?resizing_type=fit)
7. Under the **Appearance** options, change the following settings:

   1. Image = **Mission 1 texture**
   2. Image Size:

      1. X = **256.0**
      2. Y = 2**56.0**

   [![](https://dev.epicgames.com/community/api/documentation/image/ad7bbe23-3085-4190-a88b-4c071b0ce80e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad7bbe23-3085-4190-a88b-4c071b0ce80e?resizing_type=fit)

   Settling the image size provides another layer of control over the tile design.

#### Ordering the Tile Contents

1. Drag a **Stack Box** widget into the **Mission 1** widget and rename it **M1Content**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c4dad943-8475-43a5-a12f-1e9fd7a14c34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4dad943-8475-43a5-a12f-1e9fd7a14c34?resizing_type=fit)
2. Select **M1Content** in the **Hierarchy** panel to open its options in the **Details** panel.
3. Under the **Slot (Overlay Slot)** options, change the following settings:

   1. Horizontal Alignment = Central Alignment
   2. Vertical Alignment = Central Alignment

   [![](https://dev.epicgames.com/community/api/documentation/image/ebed9368-67a2-42b3-89ac-89770aaf5325?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ebed9368-67a2-42b3-89ac-89770aaf5325?resizing_type=fit)

   This causes all the Stack Box’s child widgets to align in the center.
4. Under the **Behavior** option, set **Orientation** to **Vertical**. This causes all child widgets to stack vertically.

   [![](https://dev.epicgames.com/community/api/documentation/image/0753c85d-3f8d-4287-a1cf-bdc4e08c7548?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0753c85d-3f8d-4287-a1cf-bdc4e08c7548?resizing_type=fit)
5. Drag an **Overlay** widget into **M1Content** and rename it **M1Header**. This overlay acts as a bucket for all the header assets and formats them according to the Overlay’s settings.

   [![](https://dev.epicgames.com/community/api/documentation/image/7643652a-0c13-45b8-a476-828a607f75eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7643652a-0c13-45b8-a476-828a607f75eb?resizing_type=fit)
6. Select **M1Header** in the **Hierarchy** panel to open its options in the **Details** panel.
7. Under **Slot (Stack Box Slot)**, change the following options:

   1. Padding:

      1. Left = **0.0**
      2. Top = **0.0**
      3. Right = **0.0**
      4. Bottom = **128.0**
   2. Size = **Auto**
   3. Horizontal Alignment = **Center Alignment**
   4. Vertical Alignment = **Full Vertical**

   [![](https://dev.epicgames.com/community/api/documentation/image/1ed4705d-ba03-4828-af33-e8f35a246cba?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ed4705d-ba03-4828-af33-e8f35a246cba?resizing_type=fit)

   The unique padding settings provide padding on the right side of the Mission 1 tile.

#### Styling Mission Tile Text

1. Drag an **Image** widget into **M1Header** and change its name to **M1Stroke**.

   [![](https://dev.epicgames.com/community/api/documentation/image/bd18fde5-eea3-47a2-89e7-2273d5f8fbf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd18fde5-eea3-47a2-89e7-2273d5f8fbf2?resizing_type=fit)
2. Select **M1Stroke** in the **Hierarchy** panel to open its options in the **Details** panel.
3. Under **Slot (Overlay Slot)**, set the alignment to **Full Horizontal** and **Full Vertical**.

   [![](https://dev.epicgames.com/community/api/documentation/image/19dbc894-93b3-4b69-9f13-c16ef32ad9fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19dbc894-93b3-4b69-9f13-c16ef32ad9fd?resizing_type=fit)
4. Under **Appearance** options, use the following settings:

   1. Image = **Slice material**
   2. Image Size:

      1. X = **200.0**
      2. Y = **32.0**

   [![](https://dev.epicgames.com/community/api/documentation/image/eacb3e07-2162-427a-ad2c-00792bf1aa45?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eacb3e07-2162-427a-ad2c-00792bf1aa45?resizing_type=fit)
5. Drag a **Text Box** into the **M1Header** widget and rename the widget, **Mission\_1**.

   [![](https://dev.epicgames.com/community/api/documentation/image/37a6ea73-4af2-47a9-98c2-61688f8fb36e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/37a6ea73-4af2-47a9-98c2-61688f8fb36e?resizing_type=fit)
6. Select the **Mission\_1** text widget in the **Hierarchy** panel to open its options in the **Details** panel.
7. Under **Slot (Overlay Slot)** options, use the following alignment settings:

   1. Horizontal Alignment = **Central Alignment**
   2. Vertical Alignment = **Top Alignment**

   [![](https://dev.epicgames.com/community/api/documentation/image/c475412f-1829-46f3-ad7a-d26a6b1fa4b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c475412f-1829-46f3-ad7a-d26a6b1fa4b6?resizing_type=fit)
8. Change the **Text** to **Mission 1**.

   [![](https://dev.epicgames.com/community/api/documentation/image/76c4252c-f21c-40ed-b9aa-b215b776a2cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76c4252c-f21c-40ed-b9aa-b215b776a2cd?resizing_type=fit)
9. From the **Brush** > **Image** tool, open the **Color Picker** and choose your accent color for the text.
10. Under **Font** set the following options:

    1. Typeface = **Bold**
    2. Size = **25.0**
    3. Letter Spacing = 6**5**
    4. Skew Amount = **0.28**

    [![](https://dev.epicgames.com/community/api/documentation/image/bd94bfcf-9236-4ac5-89c0-b8284409b665?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd94bfcf-9236-4ac5-89c0-b8284409b665?resizing_type=fit)
11. Under **Outline Settings** set the following options:

    1. Outline Size = **1**
    2. Separate Fill Alpha = **Check**
    3. Apply Outline to Drop Shadow = **Check**
    4. Outline Color = **Select your main color from the Color Picker tool**

    [![](https://dev.epicgames.com/community/api/documentation/image/e00c2e02-6f64-49c4-9bba-45851682e30a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e00c2e02-6f64-49c4-9bba-45851682e30a?resizing_type=fit)
12. Change the **Shadow Color** to your main color from the **Color Picker** tool. The font should look slightly 3D and have a distinct style different from the callout text.

    [![](https://dev.epicgames.com/community/api/documentation/image/36717874-f1bb-473f-a521-a0a2de2cee19?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36717874-f1bb-473f-a521-a0a2de2cee19?resizing_type=fit)

#### Adding a Start Button

1. Drag a Quiet Button widget into the M1Content widget and rename it, **START\_M1\_Button**.

   [![](https://dev.epicgames.com/community/api/documentation/image/2bcd9b86-10bd-4a88-930f-887ce119ca96?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2bcd9b86-10bd-4a88-930f-887ce119ca96?resizing_type=fit)
2. Select the **START\_M1\_Button** in the **Hierarchy** panel to open its options in the **Details** panel.
3. Change the button’s **Text** to **START**.

   [![](https://dev.epicgames.com/community/api/documentation/image/bbc50bda-a153-4475-b1bf-e901b0f40477?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbc50bda-a153-4475-b1bf-e901b0f40477?resizing_type=fit)
4. Under the **Slot (Stack Box Slot)** options, set the **Min Height** to **56**. This shortens the height of the button.

   [![](https://dev.epicgames.com/community/api/documentation/image/11df2623-a427-4454-bd2d-6946a35db2a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/11df2623-a427-4454-bd2d-6946a35db2a5?resizing_type=fit)
5. Check **Selection** > **Selectable**. This makes the button selectable to the player.

   [![](https://dev.epicgames.com/community/api/documentation/image/6599c898-7c63-476f-861b-db98c7cfe3c1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6599c898-7c63-476f-861b-db98c7cfe3c1?resizing_type=fit)
6. Under **Input**, set the following options:

   1. Touch Method = **Down**
   2. Press method = **Button Press**

   [![](https://dev.epicgames.com/community/api/documentation/image/36c0806c-fe40-45c4-9cea-8d4fed85b16c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36c0806c-fe40-45c4-9cea-8d4fed85b16c?resizing_type=fit)
7. Use the steps to build the layout for **Mission 2** and **Mission 3**.

Before you add the Mission 2 and Mission 3 tiles, the design should look like the picture below.

[![The mission tile section expands as more tiles are added to the Mission Tiles Stack Box.](https://dev.epicgames.com/community/api/documentation/image/26685ba9-169b-4927-9a32-07bce4069d1f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26685ba9-169b-4927-9a32-07bce4069d1f?resizing_type=fit)

Mission Tile Section

After all the mission tiles are complete, add a character to the design to give the UI some visual interest.

[![This is what the UI looks like after all the UI elements are added to the layout.](https://dev.epicgames.com/community/api/documentation/image/20bad2fe-c3aa-4bec-8774-3a84b2724317?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20bad2fe-c3aa-4bec-8774-3a84b2724317?resizing_type=fit)

Complete Mission Tile Section

#### Add a Character Texture

Adding a character texture to the UI pulls in all the colors chosen for the design and adds to the UIs visual style. Remember to use the [power-of-two](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#poweroftwo) and ensure the texture you use is a high quality that can scale to any size.

1. Drag an **Image** widget into the **Body** widget and rename it **Character**.

   [![](https://dev.epicgames.com/community/api/documentation/image/19133e95-0e38-4b9f-879d-72279871553e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19133e95-0e38-4b9f-879d-72279871553e?resizing_type=fit)
2. Select the **Character** widget in the **Hierarchy** panel to open its options in the **Detail**s panel.
3. Under **Appearance**, use the following settings:

   1. Brush > Image = **Character texture**
   2. Image Size:

      1. X = **700**
      2. Y = **700**

   [![](https://dev.epicgames.com/community/api/documentation/image/9d81449a-99ac-4882-a056-cfc426f55ee1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d81449a-99ac-4882-a056-cfc426f55ee1?resizing_type=fit)
4. Under **Slot (Grid Slot)** options, use the following settings:

   1. Horizontal Alignment = **Right Alignment**
   2. Vertical Alignment = **Full Vertical**
   3. Nudge = Use the **X** and **Y** axis tools to precisely place the character texture into place.

   [![](https://dev.epicgames.com/community/api/documentation/image/d202870b-ea1e-40ff-a2a7-7d28d29a385f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d202870b-ea1e-40ff-a2a7-7d28d29a385f?resizing_type=fit)

Once the mission section is complete, you’re ready to hook up the functionality of the buttons in your UI.

## Step 4: Add a Viewmodel

A Viewmodel controls player information through a list of functions and provides a specific way to bind UMG Widgets to Creative devices. There is a specific Viewmodel that works with buttons, the **CreativeModalDialogViewmodel**. This Viewmodel only works with the **Modal Dialog Variant Widget**, and provides numerous button functions.

To use the Viewmodel, do the following:

1. Open the **Windows** menu from the **Main menu bar**.

   [![](https://dev.epicgames.com/community/api/documentation/image/18265e4d-bb7b-418d-9fa8-b2a0a350f49c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18265e4d-bb7b-418d-9fa8-b2a0a350f49c?resizing_type=fit)
2. Select **Viewmodels** from the dropdown menu. The **CreativeModalDialogViewmodel** panel automatically docs in the Widget Editor window.

   [![](https://dev.epicgames.com/community/api/documentation/image/b1178af3-5fca-419b-8815-a44184caec4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1178af3-5fca-419b-8815-a44184caec4b?resizing_type=fit)

All the button functions are added to the widget. Now you have to add the bindings to make the buttons function.

## Step 5: Add Devices

Once the mission areas are set up, each area needs its own **Teleporter** [device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-teleporter-devices-in-fortnite-creative) set up to receive the player. A **Pop-Up Dialog** [device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-pop-up-dialog-devices-in-fortnite-creative) takes the Modal Dialog Variant widget and shows the widgets UI when triggered.

### Pop-Up Dialog Device

Start by adding a Pop-Up Dialog device to the project. Modify its options, then add the Modal Dialog Variant widget to the device.

1. Drag a **Pop-Up Dialog** device into the viewport.
2. In the **Details** panel, set the following **User Options**:

   1. Description = Mission Select Screen
   2. Auto Display = Game Start
   3. Response Type = 3 Buttons

   [![](https://dev.epicgames.com/community/api/documentation/image/17c29412-29d9-4953-ada5-81a3b88173c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17c29412-29d9-4953-ada5-81a3b88173c7?resizing_type=fit)

   These options identify the widget, determine when the UI shows in the HUD and the number of buttons attached to the widget.
3. Under the **Advanced** options, set the following options:

   1. Default back button = **None**
   2. Button 1 Text = **START**
   3. Button 2 Text = **START**
   4. Button 3 Text = **START**
   5. Mask background = **Check**
   6. Enabled During Phase = **Gameplay Only**

   [![](https://dev.epicgames.com/community/api/documentation/image/648894af-b078-46b7-89f6-33a3af3a47fd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/648894af-b078-46b7-89f6-33a3af3a47fd?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/96b66b11-db0a-4e3a-be3a-42499eef928e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96b66b11-db0a-4e3a-be3a-42499eef928e?resizing_type=fit)
4. Scroll down to **Modal Widget** > **Template Override Class** and select your **Mission\_Select\_UI** widget from the dropdown menu.

   [![](https://dev.epicgames.com/community/api/documentation/image/e794a097-61ea-4e66-8858-00e8755678a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e794a097-61ea-4e66-8858-00e8755678a4?resizing_type=fit)
5. Scroll up to **User Options - Functions** and under **Show**, open an **Array Element**.
6. Add the **Player 1 Spawn Pad** to the top field.
7. Select **On Player Spawned** for the Spawn Pad function.

   [![](https://dev.epicgames.com/community/api/documentation/image/a744eaaf-1b5f-498d-8293-d62d6947ee18?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a744eaaf-1b5f-498d-8293-d62d6947ee18?resizing_type=fit)

### Teleporter Devices

To reduce development time, create the first teleporter device and modify its options, then copy the device and put the additional devices in their respective mission areas.

1. Drag a **Teleporter** device into the viewport.
2. In the **Details** panel under **User Options**, uncheck **Teleporter Rift Visible** and **Play Visual Effects**.

   [![](https://dev.epicgames.com/community/api/documentation/image/6ce08aa0-3c53-4c31-a403-57d204de7c38?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ce08aa0-3c53-4c31-a403-57d204de7c38?resizing_type=fit)
3. Scroll down to **User Options - Functions** and under **Teleport**, open an **Array Element**.
4. Add the **Pop-Up Dialog** to the top field.
5. Select **On Responding Button 1**.

   [![](https://dev.epicgames.com/community/api/documentation/image/d0cddbd1-f228-4831-a339-8c000f036992?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0cddbd1-f228-4831-a339-8c000f036992?resizing_type=fit)
6. Duplicate the Teleporter device **2** times.
7. In each of the additional Teleporter’s **User Options - Functions** > **Teleport** > **Pop-up Dialog Device** functions, change the function to the corresponding button (**On Responding Button 2**, **On Responding Button 3**).

To start a mission, the player clicks the button associated with a mission area then is teleported to the selected mission area. To create this functionality, you will bind the button functionality to the buttons on the selection screen.

## Step 6: View Bindings

View Bindings adds the logic that binds the device and widget function together.

In this example, the buttons are bound to the **Teleporter** devices through the Teleport function. When the player selects a mission, clicking the **START** button activates the connected teleporter and teleports the player to that mission area.

All buttons added to the Hierarchy are numbered. This makes it easy when binding the button function to the device.

To add the bindings, do the following:

1. Select the **Start\_Mission\_1\_Button** in the **Hierarchy** panel to highlight it, then select **View Bindings** from the bottom toolbar. The View Bindings window opens with the Quiet Button already selected.

   [![](https://dev.epicgames.com/community/api/documentation/image/1c801edf-ce9d-4ef3-a027-ae84709793a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c801edf-ce9d-4ef3-a027-ae84709793a2?resizing_type=fit)
2. Select **+Add Widget Start\_Mission\_1\_Button**. This creates a binding view underneath.

   ![](https://dev.epicgames.com/community/api/documentation/image/636460ec-8196-4287-82be-fa3c118b6358?resizing_type=fit)
3. Select the **left field** that contains the **Start\_Mission\_1\_Button** and select **On Clicked** > **Event** from the dropdown menu. The **On Clicked** event is added to the Quiet Button.

   [![](https://dev.epicgames.com/community/api/documentation/image/9f226909-69eb-4446-b476-17672f0ba0f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9f226909-69eb-4446-b476-17672f0ba0f3?resizing_type=fit)
4. Select the **right field** next, and select **CreativeModalDialogViewmodel** > **Response** > **Select** from the dropdown menu. This adds a **Response** function to the button’s On Clicked event.

   [![](https://dev.epicgames.com/community/api/documentation/image/c989c439-898f-4023-90db-49d698dce38c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c989c439-898f-4023-90db-49d698dce38c?resizing_type=fit)
5. In the **Response** dropdown menu, select **Button 1**. The function is bound to the first Quiet Button.

   [![](https://dev.epicgames.com/community/api/documentation/image/b8ceb569-841c-4b4d-9a2c-0dda7dc230a1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8ceb569-841c-4b4d-9a2c-0dda7dc230a1?resizing_type=fit)
6. Repeat these steps to bind the next two buttons.

   [![](https://dev.epicgames.com/community/api/documentation/image/4ceddbe6-6737-459b-90ef-a48cea3a9d34?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ceddbe6-6737-459b-90ef-a48cea3a9d34?resizing_type=fit)

At this point, all buttons should be bound to the teleporters, and the Mission Selection screen should appear when the player spawns into the game at the game start.

## Result

The last step is to playtest the project to make sure that the UI works as intended. Launch a session, then the Mission Selection screen should appear after the player spawns onto the island, and the player should teleport to the mission selected from the UI.

### On Your Own

There are a few ways you can change the design of the Mission Selection screen to make it unique to your own project.

- You could change the background mission tile to a material instead of a texture. This can give the mission screen a different look.

  ![](https://dev.epicgames.com/community/api/documentation/image/e20c164b-67a9-4ec0-b01a-b9cdc83e00b4?resizing_type=fit)
- You could add a tracker to each mission to track player statistics, or collected objects.
- You could add a Round Settings device to respawn players and bring the Mission Selection screen back so players can select the other missions they haven’t played yet, and make selected missions unavailable after being successfully completed.
