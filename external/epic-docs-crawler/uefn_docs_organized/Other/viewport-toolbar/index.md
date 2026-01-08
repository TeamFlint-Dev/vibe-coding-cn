# Viewport Toolbar

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/viewport-toolbar>
> **爬取时间**: 2025-12-26T23:54:55.990714

---

The **Viewport Toolbar** is located above the editor viewport. It includes quick-select tools and menu options that affect how you interact with objects, the level in general, and what you see there.

## Improved Viewport Toolbar versus the Legacy Viewport Toolbar

This viewport toolbar replaces the previous viewport toolbar entirely for the Level Viewport and any other asset editors that also have a viewport.

[![The improved level viewport toolbar in Unreal Engine 5.6 and later compared to the legacy viewport toolbar found in earlier versions of Unreal Engine.](https://dev.epicgames.com/community/api/documentation/image/f8882768-bfd5-4bc7-af52-f4f4d917f40a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8882768-bfd5-4bc7-af52-f4f4d917f40a?resizing_type=fit)

The improved level viewport toolbar in Unreal Engine 5.6 and later compared to the legacy viewport toolbar found in earlier versions of Unreal Engine.

This update to the viewport toolbar provides the following benefits:

- It has consistent locations for features ordered by logical categories, such as those for transforms, snapping, and view modes.
- Unification of related tools and options that were previously located in high-level settings dropdowns.
- Better overflow management for smaller viewports as quick-select elements and menu condense and collapse into an overflow menu.
- Unique toolbars for Level Editor Modes and asset editors with their own specific controls.

## Viewport Toolbar Interface

The toolbar — whether it’s in the level editor or an asset editor — is located just above the viewport window.

[![Toolbar interface](https://dev.epicgames.com/community/api/documentation/image/ba5c6ee6-43fc-4bc2-bb2f-eec5315bb3dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba5c6ee6-43fc-4bc2-bb2f-eec5315bb3dc?resizing_type=fit)

Toolbar interface

The tools and settings are grouped into the following categories:

The improved Viewport Toolbar is located at the top of any viewport as a separate toolbar above the viewport window. Its settings and tools are grouped into the following categories:

[![Toolbar settings grouped into 6 categories](https://dev.epicgames.com/community/api/documentation/image/897f5e54-7964-4c5e-bbcb-159378c4bf2f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/897f5e54-7964-4c5e-bbcb-159378c4bf2f?resizing_type=fit)

Toolbar settings grouped into 6 categories

1. [Transform and Snapping Tools](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-toolbar?application_version=5.6#viewport-toolbar-transform-amp-snapping-tools)
2. [Time of Day and Project Size](https://dev.epicgames.com/documentation/en-us/fortnite/viewport-toolbar#time-of-day-and-project-size)
3. [Camera-Related Tools](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-toolbar?application_version=5.6#viewport-toolbar-camera-settings)
4. [View Mode and Show Flag Options](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-toolbar?application_version=5.6#viewport-toolbar-view-mode-and-show-flag-options)
5. [Performance and Scalability Options](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-toolbar?application_version=5.6#viewport-toolbar-performance-and-scalability-tools)
6. [Viewport-Related Options](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-toolbar?application_version=5.6#viewport-related-settings)

## Transform & Snapping Tools

The **Transform** and **Snapping** tools make up most of the tools you’ll use to select and manipulate objects within the editor viewport. This includes tools for selection, snapping, space orientation, and quick-select options for the most common ones.

### Transform Tools

The **Transform** **tools** are a set of quick selection tools to move, rotate, and scale objects and set what space (local or world) these should operate in. These options are how you will interact with objects in the level. This part of the toolbar also includes a dropdown menu with additional transform-related options.

[![Viewport transform tools area](https://dev.epicgames.com/community/api/documentation/image/c51bade2-796d-4113-8945-e6a6e6c9d11e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c51bade2-796d-4113-8945-e6a6e6c9d11e?resizing_type=fit)

Viewport transform tools area

You can use these quick-select toolbar options to manipulate objects in the viewport:

[![Viewport quick-select transform tools](https://dev.epicgames.com/community/api/documentation/image/3b849d17-3ae4-4031-bec0-8a9309a5e3d7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b849d17-3ae4-4031-bec0-8a9309a5e3d7?resizing_type=fit)

Viewport quick-select transform tools

| Icon | Name | Keyboard Shortcut | Description |
| --- | --- | --- | --- |
| [Transform tool select icon](https://dev.epicgames.com/community/api/documentation/image/14a58e56-2c64-4ae8-b808-86b0edcfeb6d?resizing_type=fit) | **Select Objects** | **Q** | Use this option to select objects within the viewport. |
| [Select and transform icon](https://dev.epicgames.com/community/api/documentation/image/66ae41fa-65cb-4b3c-a80c-0e8c6c53f5f2?resizing_type=fit) | **Select and Translate Objects** | **W** | Use this option to select objects and move them around the world using the translate gizmo. Use the gizmo to move objects along individual axes, dual axes, or on all three axes. |
| [Select and rotate objects tool icon](https://dev.epicgames.com/community/api/documentation/image/ab5f5344-51af-46fe-9ea6-91f60e243cfd?resizing_type=fit) | **Select and Rotate Objects** | **E** | Use this option to select objects and rotate them using the rotate gizmo. Use the gizmos to rotate the selected object along individual axes. |
| [Select and scale objects tool icon](https://dev.epicgames.com/community/api/documentation/image/f4643e76-4a65-4f6d-b626-07a71d19d7d8?resizing_type=fit) | **Select and Scale Objects** | **R** | Use this option to select objects and scale them using the scale gizmo. Use the gizmo to scale objects along individual axes, dual axes, or uniformly on all three axes. |

|  |  |  |
| --- | --- | --- |
| [Transform tools video of object moving.](https://dev.epicgames.com/community/api/documentation/image/529faea7-2490-48e0-86a3-4ab319793109?resizing_type=fit) | [Transform tools video of object rotating..](https://dev.epicgames.com/community/api/documentation/image/c131cb5a-7efb-4228-9389-94ae6cef7dd9?resizing_type=fit) | [Transform tools video of object rotating.](https://dev.epicgames.com/community/api/documentation/image/dd130f72-6dee-462e-bf17-5cdd159ae8a1?resizing_type=fit) |
| **Move** | **Rotate** | **Scale** |

You can click the **Coordinate Space** icon to toggle between Local and World space that affects how objects in the viewport are translated and rotated.

[![Coordinate space tool in toolbar](https://dev.epicgames.com/community/api/documentation/image/d5b2a13f-73b0-4d56-ac6f-a341b7c5fde4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5b2a13f-73b0-4d56-ac6f-a341b7c5fde4?resizing_type=fit)

Coordinate space tool in toolbar

| Icon | Name | Keyboard Shortcut | Description |
| --- | --- | --- | --- |
| [Local space coordinates icon](https://dev.epicgames.com/community/api/documentation/image/3fb4a8a7-1d2f-4b1b-88e2-8afbad871ac7?resizing_type=fit) | **Local Space Coordinates** | **CTRL + `** | This icon is the coordinate system used for Local (Object) Space with its coordinate system relative to the scene component to which the actor is attached. Every actor has a local space coordinate system within a scene relative to the actor’s pivot point. Use local space to translate or rotate an object relative to its parent. |
| [World space coordinates icon](https://dev.epicgames.com/community/api/documentation/image/c51d9fbc-2e2c-4032-87fa-df93ce428061?resizing_type=fit) | **World Space Coordinates** | **CTRL + `** | This icon is the coordinate system used for World Space (the entire level), with its origin being the center of the scene (the world grid). This coordinate system is fixed — you cannot transform it. Objects are translated and rotated in absolute units relative to the level’s origin and scale relative to the entire level. |

|  |  |
| --- | --- |
| [Video of world space view and rotate.](https://dev.epicgames.com/community/api/documentation/image/70bff3fb-f358-4728-9c57-8214284b4ddc?resizing_type=fit) | [Video of local space move and rotate.](https://dev.epicgames.com/community/api/documentation/image/3b95dfb6-a1ae-4c21-8c9f-05afc04f356c?resizing_type=fit) |
| **World Space Move and Rotate** | **Local Space Move and Rotate** |

For more in-depth explanations of the coordinate system and coordinate spaces for transforming objects within a 3D space, see [Coordinate System and Spaces](https://dev.epicgames.com/documentation/en-us/unreal-engine/coordinate-system-and-spaces-in-unreal-engine).

#### Viewport-Related Transform Tools Menu

The **Transform** toolbar dropdown menu contains a list of transform options, coordinate spaces, and options for how the gizmo is displayed in the level editor viewport. Some options here, such as transform tool and coordinate system are available as quick-select options in the viewport toolbar.

[![Image of transform tools menu with checkbox options](https://dev.epicgames.com/community/api/documentation/image/aad1fe42-9279-4bed-8611-d7b40ac43950?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aad1fe42-9279-4bed-8611-d7b40ac43950?resizing_type=fit)

Image of transform tools menu with checkbox options

  The menu is broken down into the following categories:

| Menu Section | Name | Description |
| --- | --- | --- |
| [Transform tools menu.](https://dev.epicgames.com/community/api/documentation/image/a0a1180d-9384-44b3-b64e-2019230f322a?resizing_type=fit) | **Transform Tools** | Menu options to select the transform tool or coordinate space you want to use. These options are available as quick-select options in the viewport toolbar. |
| [Transform tools menu, gizmo options.](https://dev.epicgames.com/community/api/documentation/image/6ae705cb-f101-46fc-ae35-b165f30d7841?resizing_type=fit) | **Gizmo Options** | Menu options to change how you view and interact with the transform tools gizmo when objects are selected. |
| [Transform tools menu, selection options.](https://dev.epicgames.com/community/api/documentation/image/10684e51-9c01-4e64-95a1-66590a292695?resizing_type=fit) | **Selection Options** | Menu options to change how you select objects in the viewport. |

### Snapping Tools & Snap Settings

The **Snapping** tools includes a set of quick selection tools for snap sizes and angles to move, rotate, and scale objects in incremental steps. The snap settings also include options for how objects should snap to other objects and surfaces.

The **Snapping Settings** dropdown displays a list of optional toggles for how objects snap within the world.

[![Snapping tools menu](https://dev.epicgames.com/community/api/documentation/image/6e850543-2cca-42fb-8d78-087a8cd85c06?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e850543-2cca-42fb-8d78-087a8cd85c06?resizing_type=fit)

Snapping tools menu

The **Fortnite Cell Snap** option lets you choose if you want building actors to snap to the Fortnite grid. For more  info, check out [Grid Snapping in UEFN](https://dev.epicgames.com/documentation/en-us/fortnite/using-grid-snapping-in-unreal-editor-for-fortnite).

|  |  |
| --- | --- |
|  |  |
| **With Fortnite Snap** | **Without Fortnite Snap** |

The toolbar includes quick-select snapping toggles and size / angle increments settings.

[![Snapping tools increment settings](https://dev.epicgames.com/community/api/documentation/image/8472444b-59d9-4aba-aa7d-a226f360415d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8472444b-59d9-4aba-aa7d-a226f360415d?resizing_type=fit)

Snapping tools increment settings

When clicking on the values next to any quick-select snapping icon in the toolbar, you can use its dropdown to set a value, or select from available ones to use.

|  |  |  |  |
| --- | --- | --- | --- |
| [Surface snapping setting options.](https://dev.epicgames.com/community/api/documentation/image/aadbd59c-fa2f-448f-bc4f-f84ee750e0ad?resizing_type=fit) | [Snapping menu, grid snap options.](https://dev.epicgames.com/community/api/documentation/image/c7bc39c7-3c11-4544-8273-f716af47a2fe?resizing_type=fit) | [Rotation angle snap increments.](https://dev.epicgames.com/community/api/documentation/image/fa0e7f41-7b77-448e-a88c-8c68019b39b5?resizing_type=fit) | [Snapping menu scaling options.](https://dev.epicgames.com/community/api/documentation/image/022e6a39-bd73-4c1c-8894-72fbcda5695a?resizing_type=fit) |
| **Surface Snapping Settings** | **Grid Snap Sizes** | **Rotation Angle Snap Increments** | **Scaling Snap Sizes** |

#### Snap to Surfaces Settings

The **Surface Snapping** settings dropdown sets the snapping behavior of objects when you drag them around in the scene.

[![Surface snapping menu](https://dev.epicgames.com/community/api/documentation/image/d5e0e492-e53a-404c-8de3-3d0078bdf023?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5e0e492-e53a-404c-8de3-3d0078bdf023?resizing_type=fit)

Surface snapping menu

The **Rotate to Normal Surface** setting toggles whether objects should align to the surface's normal direction they are being snapped to. For example, when an object, like the pillar below, is dragged along a curved surface, it aligns to the direction of the curved surface when this setting is enabled. When disabled, the pillar will always face in the direction it is oriented.

|  |  |
| --- | --- |
| [Video clip of normal rotate to surface action.](https://dev.epicgames.com/community/api/documentation/image/1f2c01d6-61a7-4aad-b09b-42f0c73a84a3?resizing_type=fit) | [Video of Rotate to surface in off mode.](https://dev.epicgames.com/community/api/documentation/image/4bb25296-0ea7-4605-8e44-9bb6d234d259?resizing_type=fit) |
| **Rotate to Surface Normal: ON (default)** | **Rotate to Surface Normal: OFF** |

## Time of Day and Project Size

The **Time of Day** slider contains values between **0.0** and **23.99** and lets you preview the island's lighting at different times of the day. If you want to set your island to display a specific time of day, you can do so in the project's [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite).

[![Time of Day slider](https://dev.epicgames.com/community/api/documentation/image/024750a6-7c05-4a47-a640-d992a2af58b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/024750a6-7c05-4a47-a640-d992a2af58b1?resizing_type=fit)

Time of Day slider

**Project Size** displays the download size of your [cooked](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#cook) project. Clicking on it will give you a more detailed breakdown of the project.

[![Project Size popup](https://dev.epicgames.com/community/api/documentation/image/252ca1cb-d09f-4940-934d-ce9df081f8a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/252ca1cb-d09f-4940-934d-ce9df081f8a9?resizing_type=fit)

Project Size popup

## Camera Settings

The **Camera Settings** contain options that affect the camera view for the viewport and the look of the scene.

[![Toolbar camera settings.](https://dev.epicgames.com/community/api/documentation/image/dfdf9f1c-e1f0-4bb0-a5ec-82e9b9a46fda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dfdf9f1c-e1f0-4bb0-a5ec-82e9b9a46fda?resizing_type=fit)

| Icon | Name | Description |
| --- | --- | --- |
| [Camera perspective options](https://dev.epicgames.com/community/api/documentation/image/b52ef0fa-5fa3-4843-a4ee-57820edd43f0?resizing_type=fit) | **Camera Options** | A selection of options that affect the look of the viewport, its view, and includes the access to the high resolution screenshot tool. |
| [Camera speed options icon](https://dev.epicgames.com/community/api/documentation/image/2530e41c-0b63-4359-9dc2-0d0e3c12e440?resizing_type=fit) | **Camera Speed Options** | Options that control the speed of the camera when moving through the world. |

### Camera Options Menu

You can click on the **Camera Options** dropdown menu that includes options to change the look of the viewport, switch between camera views for perspective and orthographic, set the viewport to a cinematic view, and more. The options available in this menu change depending on cameras placed in the level and whether you are using a perspective or orthographic view.

[![Camera toolbar menu](https://dev.epicgames.com/community/api/documentation/image/a93fde6a-2db1-4e22-b3b3-3e6c6b86508c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a93fde6a-2db1-4e22-b3b3-3e6c6b86508c?resizing_type=fit)

Camera toolbar menu

This menu is broken up into the following sections:

| Menu Section | Name | Description |
| --- | --- | --- |
| [Camera perspective menu options.](https://dev.epicgames.com/community/api/documentation/image/6e09ccc9-6384-4508-b777-6662a7a50c23?resizing_type=fit) | **Perspective** | This camera view simulates how the human eye perceives the world. This camera view is the default view used for all viewports. The **View** options in this menu that affect field of view, near view plane, and far view plane are specific to the perspective camera view. |
| [Camera orthographic menu options.](https://dev.epicgames.com/community/api/documentation/image/a38071a5-be7b-42e7-a8d3-ef1a59317ccd?resizing_type=fit) | **Orthographic** | This camera view uses a projection that maintains parallel lines, whereby objects appear to have the same scale regardless of their distance from the camera. This includes views for top, bottom, left, right, front, and back. |
| [Camera movement menu options.](https://dev.epicgames.com/community/api/documentation/image/08a9772d-4784-4aba-8004-8092ccd40817?resizing_type=fit) | **Movement** | Options to change how the viewport camera moves. You can pilot other actors in the scene and change the movement of the camera. |
| [Camera view menu options.](https://dev.epicgames.com/community/api/documentation/image/65b34adc-99e1-4926-879d-fe2044ac5b8c?resizing_type=fit) | **View** | When the **Perspective** view is used, these options change the field of view, near view plane, and far view plane for how content is shown in the viewport. |
| [Camera exposure menu options.](https://dev.epicgames.com/community/api/documentation/image/4d1d6c9c-55b6-4177-ade4-30a9a4e8956d?resizing_type=fit) | **Exposure** | Override settings change the exposure value in the viewport. When Game Settings is disabled, you can use the text field to override the camera exposure for the viewport. |
| [Camera viewport type menu options.](https://dev.epicgames.com/community/api/documentation/image/9ba924b0-a823-4b6d-979e-9b864ff24535?resizing_type=fit) | **Viewport Type** | Choose a viewport layout to use. The **Cinematic Viewport** layout is tailored for cinematic workflows and adds the **Composition Overlays** options menu to the toolbar, where you can select different overlays for framing, masking, and composition. |
| [Camera create menu options.](https://dev.epicgames.com/community/api/documentation/image/cd662067-b578-4533-8022-3f3a925bab04?resizing_type=fit) | **Create** | Options to create camera actors in the world and scene bookmarks for camera views in the world. |
| [Camera options menu choices.](https://dev.epicgames.com/community/api/documentation/image/0a512fac-8823-4467-b2f6-e581b7188e1f?resizing_type=fit) | **Options** | Toggleable settings that affect the viewport, such as game view that disables selection highlight and gizmos tools, or **Preview Selected Cameras** sets how large the preview window for a selected camera is in the bottom-right of the viewport. |

### Camera Perspective & Orthographic Views

You can use the Camera Options menu to select how content is displayed in the viewport. The default viewport uses the Perspective view, but you can select from a list of Orthographic views to use as well.

[![Perspective and orthographic menu options.](https://dev.epicgames.com/community/api/documentation/image/dc69ab57-229d-48fb-8a27-6c45a3428fb4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc69ab57-229d-48fb-8a27-6c45a3428fb4?resizing_type=fit)

Below is an example of different views in the viewport for both orthographic and perspective.

[![Orthographic and perspective views in 4 viewports](https://dev.epicgames.com/community/api/documentation/image/12c8ad67-bada-4c4b-aafa-9baf2aa5446a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12c8ad67-bada-4c4b-aafa-9baf2aa5446a?resizing_type=fit)

Orthographic and perspective views in 4 viewports

### Movement Options

The **Movement** options section of the menu includes options for how you pilot actors using the viewport, and change camera movement in the viewport.

[![Camera movement options menu.](https://dev.epicgames.com/community/api/documentation/image/68ed074a-c70b-43e0-8083-b120682ee511?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68ed074a-c70b-43e0-8083-b120682ee511?resizing_type=fit)

This section of the menu includes the following settings:

| Setting Name | Description |
| --- | --- |
| Pilot |  |
| **Pilot [Selected Actor]** | Move the selected actor around using the viewport controls, and bind the viewport to the actor’s location and orientation. |
| **Stop Piloting Actor** | When piloting is enabled for an actor, this stops piloting of an actor with the current viewport. It unlocks the viewport’s position and orientation from the actor the viewport is currently piloting. |
| **Exact Camera View** | Toggles showing the exact camera view when using the viewport to pilot a camera. |
| **Selected Piloted Actor** | Selects the currently piloted actor in the Outliner. |
| Camera Movement |  |
| --- | --- |
| **Camera Speed** | Set the camera speed for movement in the viewport. These options are available from the quick-select toolbar as well. |
| **Frame Selected** | Centers the viewport on the selected actor(s). |
| **Move Camera to Object** | Move the current camera to match the location and rotation of the selected object. |
| **Move Object to Camera** | Move the selected object to match the location and rotation of the current camera. |
| **Orbit Around Selection** | If enabled, the camera will orbit around the current selection in the viewport. |
| **Link Ortho Camera Movement** | If enabled, all orthographic viewports are linked to the same position and move together. When disabled, they move independent of one another. |
| **Ortho Zoom to Cursor** | If enabled, orthographic viewport zooming centers on the mouse cursor’s position. When disabled, the zoom is around the center of the viewport. |

### View Options

The **View** options are available when the viewport is using the **Perspective** view. These options configure the viewing angle of the viewport camera, and at what distance content should be visible from this camera.

[![Image of menu options for field of view.](https://dev.epicgames.com/community/api/documentation/image/671b1515-7270-4e75-9ff6-ffb8dcd0614c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/671b1515-7270-4e75-9ff6-ffb8dcd0614c?resizing_type=fit)

This section includes the following settings:

| Setting Name | Description |
| --- | --- |
| **Field of View** | Sets the viewing angle of the viewport camera. This angle defines the extent of the world that is visible to the camera at any given time. The default is a **90 degree** viewing angle. Higher angles give you wider views to see more of the world but this skews the camera view. Lower angles show less of the world, feeling zoomed in, but the view of content is limited. |
| **Near View Plane** | Sets the size of the plane used to clip through objects when the camera is close to a surface. Large values make the clip plane bigger to see through objects more easily. |
| **Far View Plane** | Sets the far distance at which objects stop being rendered on screen.  This value does not affect objects that have Nanite enabled. |

In the example below, you can see how adjusting the field of view angle affectss your view:

|  |  |  |
| --- | --- | --- |
| [Example field of view at 65 degrees.](https://dev.epicgames.com/community/api/documentation/image/c64253f9-a40d-4518-8587-1c2698e09df5?resizing_type=fit) | [Example field of view at 90 degrees.](https://dev.epicgames.com/community/api/documentation/image/d573dd85-12e2-4307-9771-ff0954e5e646?resizing_type=fit) | [Example field of view at 120 degrees.](https://dev.epicgames.com/community/api/documentation/image/4acd70b8-8d50-4e7c-aea0-e21a786e830c?resizing_type=fit) |
| **Field of View: 65 Degrees** | **Field of View: 90 Degrees (Default)** | **Field of View: 120 Degrees** |

### Create Options

The **Create** options provide a way to place cameras and bookmarks in the world based on the current viewport location and orientation.

[![Options in the Create camera menu.](https://dev.epicgames.com/community/api/documentation/image/eda5e831-8b23-4e2f-bd22-b66b66660dd8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eda5e831-8b23-4e2f-bd22-b66b66660dd8?resizing_type=fit)

This section includes the following options:

| Setting Name | Description |
| --- | --- |
| Create Camera |  |
| **Camera Actor** | Spawn a Camera actor in the current location and orientation of the viewport. |
| **Cine Camera Actor** | Spawn a Cine Camera actor in the current location and orientation of the viewport. |
| Bookmarks |  |
| --- | --- |
| **Set Bookmark** | Choose a bookmark from the list to set with the current viewport location and orientation. |
| **Manage Bookmarks** | - **Clear Bookmark**: Clears a specific bookmark that has been saved. - **Compact Bookmarks**: Attempts to move bookmark indices so they are continuous. For example, if you have bookmarks for 1, 2, and 4 slots bookmarked, this will attempt to move bookmark 4 to the bookmark 3 slot. - **Clear All Bookmarks**: Clears any saved bookmarks. |
| **Bookmarks List** | A list of any bookmarks that have been saved and what keyboard shortcut they are assigned to. |

### General Options

The **Options** section of the menu includes general settings you can enable for the viewport. It also includes access to the **High Resolution Screenshot** tool, to capture still images from the viewport quickly.

[![General options menu items.](https://dev.epicgames.com/community/api/documentation/image/bcacd1e0-d730-401a-953c-05b34faf3eca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bcacd1e0-d730-401a-953c-05b34faf3eca?resizing_type=fit)

This section includes the following options:

| Setting Name | Description |
| --- | --- |
| **Allow Cinematic Control** | When enabled, this allows for cinematic (Sequencer) previews to play in this viewport. |
| **Game View** | When enabled, the viewport shows the scene as it appears in the game — without editor widgets, selection highlights, or any other element usually only visible in the editor. |
| **Allow Camera Shakes** | When enabled, it allows for the camera shake previewer panel to apply shaking to this viewport. |
| **Preview Selected Cameras** | When enabled, selecting a camera actor displays a live picture-in-picture preview from the camera’s perspective within the current editor viewport. This can be used to make adjustments to positioning, post processing, and other settings without having to possess the camera itself. The **Preview Size** value adjusts the size of this picture-in-picture preview window for the camera view. |
| **High Resolution Screenshot** | Opens the control panel dialog to take high resolution screenshots of the currently used viewport. |

#### High Resolution Screenshot Tool

The **High Resolution Screenshot** tool is a dialog window you can use to capture still images of the current viewport window or you can use the **Crop** tool to select a part of the viewport to capture. It includes additional output options you can toggle on.

[![Menu options for the high resolution screenshot tool.](https://dev.epicgames.com/community/api/documentation/image/1405648d-aaa1-4e25-b4be-5b5f857af5ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1405648d-aaa1-4e25-b4be-5b5f857af5ed?resizing_type=fit)

For more information on using this tool, see [High Resolution Screenshot Tool](https://dev.epicgames.com/documentation/en-us/unreal-engine/taking-screenshots-in-unreal-engine#highresolutionscreenshottool).

### Camera Speed Options

The **Camera Speed** dropdown menu includes options that affect the speed at which the camera can move around the world.

[![View of camera speed menu items.](https://dev.epicgames.com/community/api/documentation/image/95a8fe9d-ef49-42c7-ae85-351c5b14d3d0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95a8fe9d-ef49-42c7-ae85-351c5b14d3d0?resizing_type=fit)

| Setting Name | Description |
| --- | --- |
| **Camera Speed** | Sets the speed of the camera in first person mode.  Hold either mouse button (LMB or RMB) and use the scroll wheel to adjust the camera speed up or down. |
| **Speed Scalar** | Multiplies the effective value of the camera speed slider, changing how quickly the slider changes camera speed. |
| **Distance Based Camera Speed** | When enabled, this scales the perspective camera speed based on the distance between the camera and its look-at position. |

## View Mode and Show Flag Options

The **View Mode** and **Show Flag** options for the viewport enable different visualization modes and options to enable or disable elements being rendered in the viewport.

[![View of toolbar icons for view mode and show flag.](https://dev.epicgames.com/community/api/documentation/image/884ebc20-e7c6-45e9-8860-5ec59e648715?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/884ebc20-e7c6-45e9-8860-5ec59e648715?resizing_type=fit)

| Icon | Name | Description |
| --- | --- | --- |
| [Image of view mode button.](https://dev.epicgames.com/community/api/documentation/image/df069908-3265-4e94-a2d7-0937f583882b?resizing_type=fit) | **View Modes** | A listing of visualization modes to help see specific types of data being processed in your scene, such as lighting only, reflections, or buffer visualizations. These can help you diagnose and investigate specific issues for your project. |
| [View of show flag icon.](https://dev.epicgames.com/community/api/documentation/image/4ee0e968-f97c-4f77-ac93-bc0ea2af9587?resizing_type=fit) | **Show Flags** | A list of engine features you can show and hide within the viewport. For example, you can disable all particle systems, individual post processing features, and more. |

### View Modes

The **View Modes** dropdown menu includes many visualization options to select from. When selected, they apply to the current viewport only.

[![Image of the view modes dropdown menu items](https://dev.epicgames.com/community/api/documentation/image/e9f92ea9-1f70-46ca-8103-5ead2814400c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9f92ea9-1f70-46ca-8103-5ead2814400c?resizing_type=fit)

Image of the view modes dropdown menu items

These are some examples of different view modes being applied to the viewport:

|  |  |
| --- | --- |
| [View of a set with the walls and actors lit.](https://dev.epicgames.com/community/api/documentation/image/535f6a6f-b4b5-4602-970c-ee665a2d978c?resizing_type=fit) | [View of a set with the walls and actors unlit.](https://dev.epicgames.com/community/api/documentation/image/fffdc34f-1b69-4e50-98ba-a0e743c15ada?resizing_type=fit) |
| View Mode: Lit (default) | View Mode: Unlit |

For more information on using these view modes in your project workflows, see [View Modes](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-modes-in-unreal-engine) in the Unreal Engine documentation.

### Show Flags

The **Show Flags** dropdown menu includes many options to toggle visibility of editor features, such as lighting, post processing, geometry types, and more.

[![Image of show flags menu items](https://dev.epicgames.com/community/api/documentation/image/d618d3c0-ddc8-4558-9edb-b9af0e93ef1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d618d3c0-ddc8-4558-9edb-b9af0e93ef1e?resizing_type=fit)

Image of show flags menu items

For more information on using these show flags in your project, see [Viewport Show Flags](https://dev.epicgames.com/documentation/en-us/unreal-engine/viewport-show-flags-in-unreal-engine).

## Performance and Scalability Tools

The **Performance** and **Scalability Tool** menu includes options that affect the look and performance of content in the viewport. These tools are useful for approximating what content looks like on a particular platform, setting scalability for the project (to make it easier to work with), and looking at how the game can look with different scalability options. This can help you to set up your own scalability options for your project.

[![Image of scalability menu options on the toolbar.](https://dev.epicgames.com/community/api/documentation/image/b1f8e376-3cf5-4cc7-989c-210200bb7deb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1f8e376-3cf5-4cc7-989c-210200bb7deb?resizing_type=fit)

### Realtime Viewport

The **Realtime Viewport** toggles whether the current viewport should update every frame.

When disabled, the viewport only updates when you move around the scene. A warning icon is added to the viewport toolbar next to the performance and scalability dropdown menu. Clicking it restores realtime to the viewport.

[![Image of warning icon next to the realtime viewer.](https://dev.epicgames.com/community/api/documentation/image/e6f1c4c4-8b2f-4127-b8a7-c1a18f08d6ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6f1c4c4-8b2f-4127-b8a7-c1a18f08d6ea?resizing_type=fit)

### Preview Platform

The **Preview Platform** rollout menu includes a variety of platform options to select from. Selecting platform and its target, triggers a shader recompile for the engine. Once completed, the viewport updates to display an approximation of what the scene would render like using this target.

Each platform can have multiple targets depending on what rendering paths of the engine it supports.

[![Preview platform menu dropdowns.](https://dev.epicgames.com/community/api/documentation/image/4078d01c-389b-4abd-b920-780bd8ad380e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4078d01c-389b-4abd-b920-780bd8ad380e?resizing_type=fit)

This menu rollout includes the following options:

| Setting Name | Description |
| --- | --- |
| Preview Platform |  |
| **Disable Preview** | Disables any currently selected preview platform target and sets it back to the operating system's default preview. For Windows, this would be Windows with Shader Model 6 (SM6). |
| **[Platform Preview Select]** | Choose from a list of platform targets to preview in the main editor viewport. Each platform can support multiple targets, such as Android with OpenGL and Vulkan preview options. Some platform preview options, such as console platforms, only become available when their SDKs are installed. |

The scene below shows a comparison of the default viewport preview settings on WIndows compared to previewing the scene on Android in the viewport.

|  |  |
| --- | --- |
| [Statue in a foyer, darker version image.](https://dev.epicgames.com/community/api/documentation/image/37ce1866-bad8-49ec-8863-dcb1d0c41792?resizing_type=fit) | [Statue in a foyer, better lighting.](https://dev.epicgames.com/community/api/documentation/image/7606e06d-1735-43ed-9f34-1e610c5f63b2?resizing_type=fit) |
| **Windows with SM6** | **Android with Vulkan High** |

For more information, see [Mobile Previewer](https://dev.epicgames.com/documentation/en-us/unreal-engine/using-the-mobile-previewer-in-unreal-engine) in the Unreal Engine documentation.

### Viewport Scalability

The **Viewport Scalability** options include a rollout menu of common settings of the engine. You can change individual feature categories to be Low, Medium, High, Epic, or Cinematic, or you can select any of these quality options to set all categories to be Low, Medium, High, Epic, or Cinematic. Optionally, you can use **Auto** to configure the scalability options based on your system specifications and its performance.

[![Image of viewport scalability groups](https://dev.epicgames.com/community/api/documentation/image/ecb1dc84-eed2-48c5-bdd9-a82faeb165b9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecb1dc84-eed2-48c5-bdd9-a82faeb165b9?resizing_type=fit)

Image of viewport scalability groups

When the scalability options are set to anything other than the default, this warning icon appears in the toolbar. This is an indicator that what the game would look like running outside of the editor doesn’t reflect the options currently set in the scalability options. You can click this icon to reset the scalability options to their default settings.

[![Viewport scalability icon on the toolbar.](https://dev.epicgames.com/community/api/documentation/image/e21b32e9-acec-4df9-85a7-297d44600dd4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e21b32e9-acec-4df9-85a7-297d44600dd4?resizing_type=fit)

For more information, see [Scalability](https://dev.epicgames.com/documentation/en-us/unreal-engine/scalability-in-unreal-engine) in the Unreal Engine documentation.

### Material Quality Level

The **Material Quality Level** rollout menu lists quality levels for Low, Medium, High, and Epic to choose from. You can use these to check any materials that use the **Quality Switch** node in a material. You can use these menu options to inspect only materials in the viewport. The material quality switches also work with the scalability options.

[![Material quality menu options.](https://dev.epicgames.com/community/api/documentation/image/166a8ce1-fd09-40ce-ad75-b56bee684c55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/166a8ce1-fd09-40ce-ad75-b56bee684c55?resizing_type=fit)

### Screen Percentage

The **Screen Percentage** rollout menu includes information about the current screen percentage used in the viewport, and options to override screen percentage in the viewport. The summary in this menu provides specific information about the viewport and its current settings.

[![Image of the screen percentage menu options.](https://dev.epicgames.com/community/api/documentation/image/9ef64dbe-213d-4eec-a7b9-2bb221fbddaa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ef64dbe-213d-4eec-a7b9-2bb221fbddaa?resizing_type=fit)

## Viewport-Related Settings

The viewport **Settings** and **Overlay** menus assist with audio settings, mouse movement within the viewport, viewport layout options (for working with multiple viewports), and more.

[![Image of the settings and viewport-layout icons on the toolbar.](https://dev.epicgames.com/community/api/documentation/image/b64760e3-7d8c-4822-b236-cb2717109d56?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b64760e3-7d8c-4822-b236-cb2717109d56?resizing_type=fit)

| Icon | Name | Description |
| --- | --- | --- |
| [Viewport settings icon.](https://dev.epicgames.com/community/api/documentation/image/6f76dc94-c2fa-4158-bc41-22737572d733?resizing_type=fit) | **Viewport Settings** | A list of settings to control the volume of sounds in the level editor, configurable controls for interacting and traversing the scene in the level editor viewport, and more. |
| [Viewport layout icon.](https://dev.epicgames.com/community/api/documentation/image/303bad55-568e-44f8-8e81-90f8b10c56b8?resizing_type=fit) | **Viewport Layout Options** | A list of viewport layouts to choose from when using more than one viewport. |

### Viewport Settings

The **Viewport Settings** menu includes options that affect controls and interactions with objects within the viewport, sound levels for audio playback, and quick access to the **Editor Preferences** you can configure for the viewport.

[![Viewport settings menu options.](https://dev.epicgames.com/community/api/documentation/image/07e70ae4-bfe8-4cd7-b8fb-21c238043889?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/07e70ae4-bfe8-4cd7-b8fb-21c238043889?resizing_type=fit)

| Settings Name | Description |
| --- | --- |
| Settings |  |
| **Level Editor Volume (dB)** | Sets the preview volume (in decibels) of audio placed in the level while working in the level editor. |
| Controls |  |
| --- | --- |
| **Mouse Sensitivity** | How fast the perspective camera moves through the world when using the mouse scroll wheel. |
| **Mouse Scroll Zoom Speed** | Sets the incremental speed at which the camera should move in a forward or reverse direction when using the mouse scroll wheel. |
| **Invert Middle Mouse Pan** | When enabled, the direction of the middle mouse panning in the viewport is inverted. |
| **Invert Orbit Axis** | When enabled, the Y-axis of the mouse movement when orbiting is inverted. |
| **Invert Right Mouse Dolly** | When enabled, the direction of the right mouse dolly on the Y-axis in orbit mode is inverted. |
| **Scroll Gestures** | Set whether scroll gestures should use standard or natural scrolling when working in the **Perspective** and **Orthographic** viewports. |
| **Open Viewport Preferences** | Opens the advanced viewport settings of the **Editor Preferences**. There, you can configure settings for the look and feel, controls, grid snapping, and more. |
| Cascade |  |
| --- | --- |
| **Cascade** | These settings only apply to the deprecated particle systems created with Cascade.   - Enable Particle Systems LOD Switching: When enabled, Cascade particle systems will use distance level of detail (LOD) switching in perspective viewports. - **Toggle Particle System Helpers**: When enabled, Cascade particle systems show helper widgets in viewports. - **Freeze Particle Simulation**: When enabled, Cascade particle systems will freeze their simulation state. |

### Viewport Layouts and Sizing Settings

The **Viewport Layouts** includes a layouts window to select the type of viewport layout you prefer, and a quick-toggle to switch between a selected layout and maximized viewport screen.

[![Viewport layouts icon and ellipses on the toolbar.](https://dev.epicgames.com/community/api/documentation/image/6756ac18-7b37-40b5-b7fc-43d003e0436c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6756ac18-7b37-40b5-b7fc-43d003e0436c?resizing_type=fit)

The vertical ellipses menu includes different layout configurations you can choose from, including an option to use **Immersive View** with the selected viewport.

[![Viewport panes menu options in the toolbar.](https://dev.epicgames.com/community/api/documentation/image/47787e75-a917-4622-b8dd-1e578dc99892?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47787e75-a917-4622-b8dd-1e578dc99892?resizing_type=fit)

The quick-toggle button switches between maximizing the currently selected viewport or switching to the selected layout configuration with multiple viewports displayed in the editor window.

[![Quick toggle menu icon on the toolbar.](https://dev.epicgames.com/community/api/documentation/image/8e989615-c1f3-43b6-88bf-1bdbf3964a8e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8e989615-c1f3-43b6-88bf-1bdbf3964a8e?resizing_type=fit)

In this example, clicking the overlay toggle buttons will switch between the maximized and selected layout for the editor viewports.

Video of clicking through adjusting to multiple viewports view.

### Warning Indicators

When the interaction within a menu alters something critical that affects the viewport, such as a change that could cause visual or performative differences, actionable warning indicators appear in the viewport toolbar alongside the category they affect. This is helpful to indicate a change has occurred that can affect what you see in the viewport in some way.

For example, when **Realtime Viewport** is disabled, the warning indicator can clue you into the fact that the viewport isn’t updating what you see, which can have unintended consequences.

When these indicators are shown, you can click them to rest the changed setting to its default state, in turn removing the warning.

[![Realtime viewport warning icon on the toolbar.](https://dev.epicgames.com/community/api/documentation/image/f768787d-3370-4242-a175-3f5b123ffb12?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f768787d-3370-4242-a175-3f5b123ffb12?resizing_type=fit)

### Other Editor Viewports

The **Viewport Toolbar** is adapted to different modes of the level editor and to the individual asset editors it has.

The sections below are some examples of these differences.

### Level Editor Viewport Modes

The level editor can be put into different **Modes** to enable specialized editing interfaces and workflows for editing particular types of actors and geometry within the viewport.

You can change the level editor mode using the dropdown selection menu in the main toolbar.

[![Menu of categories you can select via the selection tool](https://dev.epicgames.com/community/api/documentation/image/0da22bcc-4ed1-43b8-912b-f8ead53c7000?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0da22bcc-4ed1-43b8-912b-f8ead53c7000?resizing_type=fit)

Menu of categories you can select via the selection tool

These modes change the primary behavior of the level editor viewport for a specialized task, such as moving and transforming assets in the world, sculpting landscapes, generating foliage, animating objects, and more.

| Level Editor Mode | Viewport Toolbar |
| --- | --- |
| **Selection (default)** | [Default toolbar for level editor modes.](https://dev.epicgames.com/community/api/documentation/image/63576155-1926-4394-a927-1d1fad0ae900?resizing_type=fit) |
| **Animation** | [Animation toolbar for level editor modes.](https://dev.epicgames.com/community/api/documentation/image/bf912d43-ac98-4a57-b6a7-106eba01c123?resizing_type=fit) |
| **Modeling** | [Modeling toolbar for level editor modes.](https://dev.epicgames.com/community/api/documentation/image/540b8fa6-825c-4ee1-86df-0aa99907fce4?resizing_type=fit) |

For more information on these editor modes, see [Level Editor Modes](https://dev.epicgames.com/documentation/en-us/unreal-engine/level-editor-modes-in-unreal-engine) in the Unreal Engine documentation.

### Asset Editors

Individual **Asset Editors** use a viewport toolbar adapted to their editors and functionality within.

In this example, you can see a comparison of the legacy viewport toolbar to the improved viewport toolbar.

[![Legacy editor under current toolbar for comparison.](https://dev.epicgames.com/community/api/documentation/image/84e5add5-88bc-45ac-9c52-0eeb1eaee144?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84e5add5-88bc-45ac-9c52-0eeb1eaee144?resizing_type=fit)

Below are examples of the different viewport toolbars you’ll see in different editors:

| Viewport Toolbar Location | Viewport Toolbar Representation |
| --- | --- |
| **Level Editor Selection Mode** | [Level editor selection mode toolbar layout.](https://dev.epicgames.com/community/api/documentation/image/0aded3d7-9b52-481d-ad42-cb4a4b413f05?resizing_type=fit) |
| **Static Mesh Editor** | [Static mesh editor toolbar layout.](https://dev.epicgames.com/community/api/documentation/image/130d8af8-7030-41c8-bbe9-d13b69441d98?resizing_type=fit) |
| **Material / Material Instance Editor** | [Material instance editor toolbar layout.](https://dev.epicgames.com/community/api/documentation/image/ec9beeb4-1981-4547-a696-91ae688b5f0a?resizing_type=fit) |

### Asset Editor Preview Scene Settings

**Asset Editor** viewports use a preview scene to display their assets. This scene can give you an idea of how that asset will look in a lit environment. You can change properties of the scene using the **Preview Scene Settings**.

You can access a portion of these settings from the viewport toolbar by clicking its menu.

[![Asset editor preview scene menu settings](https://dev.epicgames.com/community/api/documentation/image/ff89d23e-01a0-4686-9580-a7e2b8f79671?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff89d23e-01a0-4686-9580-a7e2b8f79671?resizing_type=fit)

Asset editor preview scene menu settings
