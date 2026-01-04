# Prefab Editor User Interface

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prefab-editor-user-interface-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:23:29.871870

---

The Prefab Editor consists of a menu bar, two toolbars, and three main regions.

[![](https://dev.epicgames.com/community/api/documentation/image/9361fff5-2232-4db4-ae2e-913dd1ac7b28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9361fff5-2232-4db4-ae2e-913dd1ac7b28?resizing_type=fit)

*Click image to enlarge.*

| Number | Description |
| --- | --- |
| 1 | Menu Bar |
| 2 | Toolbar |
| 3 | Viewport |
| 4 | Outliner Panel |
| 5 | Details Panel |
| 6 | Bottom Toolbar |

- Close panels by clicking the **X** in the corner of the panel.
- Open a panel from the **Window** menu.

## Menu Bar

[![](https://dev.epicgames.com/community/api/documentation/image/d253df22-2447-46e9-a035-20a7b1d6b601?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d253df22-2447-46e9-a035-20a7b1d6b601?resizing_type=fit)

*Click image to enlarge.*

### File

- **Recent Assets** - The dropdown menu displays a list of recently opened and viewed assets.
- **Save** - Saves the changes made to the prefab.
- **Save As…** - Saves the prefab under a new name.

### Edit

- **Undo** - Undoes the last action taken in the prefab editor.
- **Redo** - Returns the prefab to the state before Undo was used.
- **Undo History** - Views the entire undo history.

### Asset

- **Find** **in Content** **Browser…** - Browses to the associated asset and selects it in the Content Browser window.
- **Reference Viewer** - Launches the Reference Viewer, showing the selected asset.

### Window

- **Viewport** - Toggles open and close a viewport window.
- **Details** - Toggles open and close a Details tab.
- **Outliner** - Toggles open and close an Outliner tab.
- **Cinematics** - Opens a dropdown menu with options to:

  - **Take Recorder** - Opens the main Take Recorder UI.
  - **Takes** **Browser** - Opens the Take Browser UI.
- **Content Browser** - Opens a series of Content Browsers.
- **Message Log** - Opens the Message Log tab.
- **Output Log** - Opens the Output Log tab.
- **Load Layout** - Opens a dropdown menu with options to:

  - **Default Editor Layout** - Switches the editor layout to that of current Unreal Engine layout.
  - **UE4 Classic Layout** - Switches to the Unreal Engine 4 classic layout.
  - **Import Layout** - Imports a layout design for the editor.
- **Save Layout** - Opens a dropdown menu with options to:

  - **Save Layout As…** - Saves the current layout as the new editor layout.
  - **Export Layout** - Exports the current layout in use.
- **Remove Layout** - Opens a dropdown menu with an option to:

  - **Remove All User Layouts** - Removes all the customized layouts you have introduced.
- **Enable Full Screen** - Toggle on full screen view for the editor.

### Tools

- **View Changes** - Opens a dialogue displaying current changes.
- **Submit Content** - Opens a dialogue with check in options for content and levels.
- **Sync Content** - Saves all unsaved levels and assets to disk, then downloads the latest versions from revision control.
- **Connect to Revision Control** - Connects to revision control.

### Help

- **Dev Community** - Opens a link to the Dev Community in your web browser.
- **Learning Library** - Opens a learning library of videos for Unreal Engine in your web browser.
- **Forums** - Opens the Dev Community forums in your web browser.
- **Snippets** - Opens the Snippet Repository in your web browser.
- **About Unreal Editor** - Opens a window with information about the editor version and the platform you’re using to access the editor.
- **Credits** - Opens a scroll window that lists the names of everyone who worked on the editor.
- **Visit UnrealEngine.com** - Opens the Unreal Engine documentation site in your web browser.

## Toolbar

The toolbar includes quick buttons for frequently used tools. The table below lists the tools and their features.

[![](https://dev.epicgames.com/community/api/documentation/image/014b6093-352b-437d-b21e-83f95caecabd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/014b6093-352b-437d-b21e-83f95caecabd?resizing_type=fit)

| Icon | Description |
| --- | --- |
| [Save icon](https://dev.epicgames.com/community/api/documentation/image/45296a9c-1172-40a5-b287-0e666f03eae4?resizing_type=fit) | Saves your edits to the prefab. |
| [Browse icon](https://dev.epicgames.com/community/api/documentation/image/2ab0cc3d-c5d9-46de-8d26-1b2f00b6e824?resizing_type=fit) | Opens the Content Browser so you can browse the recently used assets. |

## Viewport

The viewport displays the prefab that you are currently editing.

[![The viewport in the Prefab Editor.](https://dev.epicgames.com/community/api/documentation/image/00c81ae5-d893-4a76-bbf4-cec94c3c269d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00c81ae5-d893-4a76-bbf4-cec94c3c269d?resizing_type=fit)

The Prefab Editor viewport has much of the same functionality as the viewport in UEFN and UE.

## Outliner Panel

The outliner panel contains the hierarchy of entities that make up the prefab. This includes other prefabs and their hierarchy of entities.

[![The outliner panel.](https://dev.epicgames.com/community/api/documentation/image/c1470753-8ca6-4e4a-ab6d-47096f5182bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1470753-8ca6-4e4a-ab6d-47096f5182bd?resizing_type=fit)

Right-clicking on an entity in the Outliner tab opens the Outliner drop down menu.

[![](https://dev.epicgames.com/community/api/documentation/image/c115f4a5-7e72-4bb5-8fa9-7e973342cced?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c115f4a5-7e72-4bb5-8fa9-7e973342cced?resizing_type=fit)

### Outliner Dropdown Menu

- **Add Entity** - Adds a new entity to the prefab or to the selected entity.
- **Delete** - Deletes the entity from the prefab.
- **Copy** - Copies the entity in the prefab hierarchy.
- **Paste** - Pastes the copied entity to the selected asset in the hierarchy.
- **Duplicate** - Duplicates the entity under the SimulationEntity in the hierarchy.
- **Frame Selected** - Centers the viewport on the selected asset.

## Details Panel

The Details panel contains all the component cards that make up the entity that is selected in the Outliner.

[![The details panel.](https://dev.epicgames.com/community/api/documentation/image/811a2f26-504e-46d0-8686-92ebdd00b3d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/811a2f26-504e-46d0-8686-92ebdd00b3d9?resizing_type=fit)

| Number | Option | Description |
| --- | --- | --- |
| 1 | **+Add Component** | Provides a way to add more components to the entity. |
| 2 | **Entity Icon** | Provides a way to add another entity to the prefab. |
| 3 | **Component Card** | Component cards feature editable options for the component.  You can make changes to a component’s default options. This automatically switches the override toggle next to a component option to Override. |
| 4 | [**Component Status**](working-with-entities-and-components-in-unreal-editor-for-fortnite) | The component status shows 3 states:   - **No Override** - **Override Inside** - **Unique Override** |
| 5 | **Component Override** | Shows the override status of the component option. |

### Property Overrides

You can override individual component options. To do so, toggle the button next to the component option, and select an option from the dropdown menu.

[![](https://dev.epicgames.com/community/api/documentation/image/7b3b283b-2220-4cfa-8200-c318927f3009?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b3b283b-2220-4cfa-8200-c318927f3009?resizing_type=fit)

- **Override Property** - Provides a way for you to override this property option.
- **Clear Override** - Returns the property option to its original state.

### Component Card Dropdown Menu

Clicking the component card control button opens the component card dropdown menu.

[![](https://dev.epicgames.com/community/api/documentation/image/e25c150c-598c-4073-a5e8-3122ff7a6881?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e25c150c-598c-4073-a5e8-3122ff7a6881?resizing_type=fit)

- **Override Component** - Provides a way for you to override this component.
- **Clear Override** - Returns the component to its original state.
- **Remove Component** - Removes the component from the hierarchy.

## Bottom Toolbar

The toolbar has buttons for easy access to frequently used tools. The table below lists the tools and their features.

[![](https://dev.epicgames.com/community/api/documentation/image/4ba57518-6457-402e-b25b-eb7c38a78c3a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4ba57518-6457-402e-b25b-eb7c38a78c3a?resizing_type=fit)

*Click image to enlarge.*

| Icon | Description |
| --- | --- |
|  | Opens the Content Drawer to access assets you imported or created. |
|  | The Output Log shows the stability of the prefab. |
|  | Shows the saved state of your prefab. |
|  | Opens the Revision Control dropdown menu with options for:   - **View Changes** - Opens a dialogue displaying all the recent changes. - **Submit Content** - Options for submitting changes. - **Check Out Modified Files** - Opens a dialogue to check out files. - **Connect to Revision Control…** - Connects to a revision control system. |
