# Known Issues

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite
> **爬取时间**: 2025-12-26T23:23:53.042856

---

Following are known issues when you work with with Scene Graph in your project. If you [have any feedback or find issues](https://forums.unrealengine.com/t/scene-graph-feedback-thread/1901696) that are not captured in the list below, report them in the forums.

- Scene Graph is a Beta feature, and you might encounter unexpected crashes and instability.
- Light components in entities do not display lighting wireframes. The workaround for this is to reselect an entity in the viewport to get the visualizers to show up.
- You cannot clear all overrides from a Prefab instance at once. You must clear each override, one at a time.
- At this time, entities do not use the one file per actor system, and instead are saved in the UMAP asset, resulting in side effects with revision control workflows (URC & Perforce). If you use URC with your project, editing  an entity will  lock the main level, making it not possible for multiple members of a team to work on entities simultaneously. Additional side effects you may note with revision control include:

  - Entities will not reflect revision control status individually in the outliner or in-viewport status highlighting.
  - The revision control sub-menu for entities is disabled, meaning entity-specific actions like revert are not possible.
  - The submit dialog’s list of changed files will not include entity-specific information.
  - URC’s snapshot history information will not capture changes to specific entities in a given snapshot.
- There is no way to save overridden Prefab instances to the Prefab asset.
- Duplicated entities are not named correctly in the Prefab Editor.
- Expand All and Collapse All do not work on components.
- There is currently no way to remove overrides from a Prefab.
- Right-clicking the override icon should have the same effect as a left click.
- You cannot detach a child entity by dragging it onto its parent.
- Scrubbing the Static Mesh Component Rotation along the left axis causes unexpected movement.
- There is unexpected player behavior when colliding with Scene Graph objects.
- Once an entity has been manually renamed, the entity name cannot be changed again.
- Negative scaling can cause abnormal interactions in child entities when rotated.
- Dragging transform values in the Prefab Editor is slower and less performant than changing the values from the widget.
- Entities in the Prefab Editor are not always selectable.
- Deleting a prefab creates a "ghost" prefab in Live Edit sessions.
- Prefab assets do not have thumbnails.
- Component logic runs in both Edit and Play modes.
- Components are initialized much earlier than Creative devices, which means that trying to fetch a Creative device from `component.OnBeginSimulation` or `component.OnSimulate` will not work. To work around this, you can loop and sleep until the components are found, or can spawn your prefabs from a Creative device's `OnBegin` call.
- The ability to hide selected entities in the level editor (hotkey **H**) and Prefab Editor is not working.
- Changes made in the Prefab Editor will not propagate to placed instances of the prefab unless you save your changes.
- Saving the project while Verse code is not compiling can result in corrupted prefab data.
- Running Verse Asset digest generation for the first time can be slow.
- When you copy and paste or duplicate a prefab in the level editor, descendent prefabs and descendent entities that belong to the base prefab asset will be incorrectly marked as fully overridden.
- Mesh, sound, and particle effect components are only generated in Verse for assets you import into or create in your project, along with a small selection of built-in mesh shapes. By default, you can’t use Fortnite or FAB assets with Scene Graph.
- When you import a new mesh or sound into your project, or you create a new particle system asset, you must build Verse code for your project to generate a component class for that asset before you can use it with the Scene Graph system.
- As you add and change parameters in the Material or Niagara Editors, you will need to build Verse code for those changes to be exposed to the level editor.
- If you move, rename, or delete meshes, sounds, or particle system assets in the editor, it is possible to lose references to the generated component instances in the level editor as the classes that are generated currently cannot utilize redirectors.
- Asset-generated components are not generated until you have at least one buildable Verse file in your project and compile Verse.
- Scene Graph is shipping without redirectors. Without redirectors, renaming assets can trigger the either of the following two scenarios:

  - Objects referenced by other objects in the Details panel will have their references break. This will require them to be set back up.
  - Objects referenced in Verse code will trigger compiler errors, and the references will need to be manually updated.
- The new [LUF coordinate system](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite) affects existing content and Scene Graph content. Any existing Verse code will continue to work. However, if you want to use the same code with Scene Graph, you'll have to convert from the old /UnrealEngine.com/Temporary/SpatialMath types to /Verse.org/SpatialMath types. There are new conversion functions that can transform between the old and new types:

  - FromVector3
  - FromScalarVector3
  - FromRotation
  - FromTransform

  ```verse
                   TeleportLocation := (/Verse.org/SpatialMath:)vector3{Left := 330.0, Up := 20.0, Forward := 50.0}
          TeleportRotation := (/Verse.org/SpatialMath:)MakeRotationFromYawPitchRollDegrees(90.0, 0.0     ,0.0)
          if: 
              FortCharacter := Agent.GetFortCharacter[]
              FortCharacter.TeleportTo[FromVector3(TeleportLocation), FromRotation(TeleportRotation)]
          then:
              Print("Character Teleported")
  ```
- Enabling Scene Graph changes some of the code generation rules for classes generated into `Assets.digest.verse`. This can mean that existing Verse code will no longer compile. You will need to fix up the Verse code before proceeding with your project.

  **Key Examples**

  ```verse
  # Assets.digest.verse
  MyMesh := class(mesh){}

  MyMaterial := MakeAsset(material, "MyMaterial.uasset")

  # YourVerseFile.verse
  SetMesh(MyMesh)
  SetMaterial(MyMaterial)
  ```

  **After Scene Graph**

  ```verse
  # Assets.digest.verse
  MyMesh_asset := class(mesh){}
  MyMesh := class(mesh_component){}

  MyMaterial := class(material){}

  # YourVerseFile.verse
  SetMesh(MyMesh_asset)
  SetMaterial(MyMaterial{})
  ```
- Both the `tag_component` and the Scene Event systems are still being iterated on and are still experimental. Avoid using these features if you want to publish islands containing Scene Graph code.
- Simulation Entity will not be available unless a scene graph entity has already been placed in the level.
- There is a problem with Verse classes referencing prefab classes in their member variables. This results in an error message when starting the editor. You'll get an ensure from the `StaticAllocateObject()`that you are trying to create an instance of an abstract class, and the class is `Object`. This `StaticAllocateObject()`is called from the $InitCDO of your Verse class.
- Changing the type of default object value in a Verse component class between an entity copy-and-paste will end up importing the reference to the instance of the old type even though the property wasn't overridden.
- Reloading an entity prefab asset with an added entity child triggers an ensure `OldToNew.Value->HasAnyClassFlags(CLASS_TokenStreamAssembled)`.
- Recommend only one person at a time editing in Scene Graph.
- Only users with Admin permissions for their Creator Team can create new URC repositories for new projects

### Itemization

- Players are currently unable to select some or all items in the Inventory menu after having been in [Edit Mode](https://dev.epicgames.com/documentation/en-us/fortnite/edit-mode-settings-in-fortnite-creative).  The workaround for this issue is to close and relaunch your UEFN session.
- NPCs are currently unable to use the new custom items and inventories.
- Remapped keys are not respected by some of the inventory inputs.
- Items maybe placed in the wrong inventory.
- Some icons for gamepad input binding are absent when a controller is used.
- Picking up an item entity can result in the player's movement being broken. The workaround is to close and relaunch the session.
- There are some UI and presentation issues for inventories and items.
