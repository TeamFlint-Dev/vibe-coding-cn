# Interchange Import System

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/interchange-import-system-in-fortnite
> **爬取时间**: 2025-12-26T23:55:32.839238

---

The Interchange Framework provides greater customization for imported FBX files. Learn more below about using Interchange to import your important files.

## Interchange Import Window

The Interchange import window is separated into two panels: the **simplified** panel and the **advanced** panel showing the advanced settings. Developers who import glTF assets or textures are already familiar with the look and feel of the **advanced** panel.

The Interchange import window opens when importing the following file types:

- FBX
- OBJ
- glTF
- textures

|  |  |
| --- | --- |
| [An example of the legacy import system.](https://dev.epicgames.com/community/api/documentation/image/3fffbb27-212d-4dc2-8de6-3541588d18d9?resizing_type=fit)  Click image to enlarge. | [An example of the Interchange import system with Advanced Options open.](https://dev.epicgames.com/community/api/documentation/image/cc171a5c-5cba-4cd5-9461-c248df15caf5?resizing_type=fit)  Click image to enlarge. |
| Legacy Import Options | Interchange Import Options |

The simplified panel lists all assets found in the FBX file. You can deselect the type of assets you want to exclude before starting the import process. Expand the default view to reveal more settings by toggling **Advanced Settings** on.

## Simplified Import Panel

The simplified panel is similar to the advanced panel. The simplified panel lists the assets for import by their name and quantity. That list is based on the **content** of the imported file and the **settings** selected in the pipelines of the **advanced** panel.

The options available in the simplified panel are related to the options selected in the advanced panel. This means that if you modify options from the advanced panel, you might change options available in the simplified panel.

You can access the advanced settings by pressing **Advanced Settings**. Selecting **Import** will automatically import your asset.

## Advanced Settings

The Advanced Settings panel contains most of the legacy settings you are familiar with. However some legacy settings have moved, been renamed, or split into distinct sub settings.

[![](https://dev.epicgames.com/community/api/documentation/image/b3ea6735-a9c4-472c-88b8-655fa643166f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3ea6735-a9c4-472c-88b8-655fa643166f?resizing_type=fit)

1. **Translator Settings menu**: Opens the Translator Settings menu with additional FBX Translator options.
2. **Pipeline Stack Preset**: Determines which pipeline stack to prioritize in the Settings List. Choose between Assets, Materials, and Textures.
3. **Use Pipeline Defaults**: Resets all options to their default settings.
4. **Pipeline Selection**: Details which pipeline is selected for importing.
5. **Search bar**: Search for an import setting in the search bar.
6. **Import Settings List**: A list of import sub settings. The import sub settings available are determined by the pipeline stack preset.

The Interchange framework settings are separated in two categories:

- **Translator Settings**: Reads the imported file and parses the FBX file.
- **Pipeline Settings**: Perform the processing operations on the content of the FBX file and convert them into UEFN assets.

In FBX import there is only one pipeline but for other formats like glTF there will be more than one pipeline represented in a stack.

You can edit the settings on the pipeline to adapt to the file you’re importing. Changes are stored between import tasks. That means after you import the first FBX file and begin importing a second FBX file, the settings remain the same from the previous FBX import.

Modified settings can be reverted back to their default values with the **revert arrow icon**. You can also select **Use Pipeline Defaults** to revert all settings.

Import settings can be filtered using the Search bar, Section bar, and the cog icon.

- The Search bar provides a way to quickly filter settings by name.
- The Section bar filters by content type.
- The cog icon provides a way to open the **Filter menu**.

### Filter Menu

Filter options include:

- **Show Only Essential Properties**: Pipelines come with predefined tags on settings to classify them between essential or not. Activating that filter will only show essential settings in the advanced settings window.
- **Filter Based on Import Contents**: This option hides settings in the advanced panel related to asset types that are not found in the imported file. For example, you can hide skeletal mesh and animation options when importing static meshes.

[![The Interchange filter options are accessible after clicking the cog icon.](https://dev.epicgames.com/community/api/documentation/image/bfb669a3-698a-4473-9e5e-c89e775d3557?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bfb669a3-698a-4473-9e5e-c89e775d3557?resizing_type=fit)

Click image to enlarge.

### Translator Settings

Translator settings determine how the Editor reads imported files, these settings are stored in a separate window. The Translator settings differ from the Pipeline settings which relate to how the Editor processes and prepares the file content to convert it into UE assets.

[![The Translator Settings window.](https://dev.epicgames.com/community/api/documentation/image/cd5e82a3-9126-4b5e-a100-25165a4e2f85?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd5e82a3-9126-4b5e-a100-25165a4e2f85?resizing_type=fit)

Click image to enlarge.

The Translator settings include:

1. **Coordinate System Policy**: Determines the direction of the asset’s coordinates.
2. **Convert Scene Unit**: Determines whether to convert the scene from FBX units into UE units (centimeters).
3. **Keep FBX Namespace**: Determines whether to keep the name space from the FBX name.

## Switching between Legacy and Interchange

You can always fallback to using the legacy importer and options by enabling the following Console Variable I`nterchange.FeatureFlags.Import.FBX False`.

- The console variable can be added in the `DefaultEngine.ini` file of the project so that Legacy FBX is turned on by default when a project is launched.

  - Add following text in the `DefaultEngine.ini` fileInterchange.

    `[ConsoleVariables]`

    `FeatureFlags.Import.FBX=False`
- It is NOT recommended to deactivate the full Interchange plugin as it is primarily used to import textures, MaterialX, and glTF.
