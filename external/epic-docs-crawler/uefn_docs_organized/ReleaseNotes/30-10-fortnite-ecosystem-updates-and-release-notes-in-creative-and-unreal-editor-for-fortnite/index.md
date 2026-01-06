# 30.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/30-10-fortnite-ecosystem-updates-and-release-notes-in-creative-and-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:32:56.796110

---

We've combined Patch Notes and Release Notes into one document! Now you can read all about the updates and changes in one place on the Epic Developer Community! If you are looking for bug fixes, you can find them in the **Release Notes** section further down this page.

In the Fortnite Ecosystem v30.10 update, there's a new Experimental feature in UEFN called Scene Graph! Scene Graph is an entity and component framework that enables you to dynamically manipulate objects in your game. There's a great new collaboration tool in UEFN called **Notes** which allows you to capture feedback and action items from collaborators directly in your viewport.

We've also added Player-Built Walls and Structures to LEGO® islands, there are new assets for you to use in Creative and UEFN, new Feature Examples in UEFN and updates to our official documentation.

More tools for creators are now in the Creator Portal! Team owners can now access a Monetization tab in the new navigation panel in Creator Portal, which provides metrics related to your island's engagement payout.

### Patch Notes

## New Experimental Feature: Scene Graph

[Scene Graph](https://dev.epicgames.com/documentation/en-us/uefn/scene-graph-in-unreal-editor-for-fortnite) is now available to try in UEFN as an Experimental feature! An Experimental feature gives you a chance to try out the feature while it's still in development. You'll be able to try out this early version of the Scene Graph feature, but you won't be able to publish islands using scene graphs until the Early Access release of the feature.

However, this Experimental release gives you the opportunity to learn a brand new core feature for UEFN that is critical for our long-term goals for the UEFN development platform. Our aim is to put these exciting new features into your hands, so you can give us important feedback and how we can improve them before final release.

New to scene graphs? **Scene graphs** provide a unified structure for connecting all the objects within an island. This makes it faster and easier to create, manipulate, and iterate on elements in your islands. Scene graphs are particularly useful when working on projects populated with a large amount of content, or that feature more complex interactions. If you're looking for a way to build richer, deeper Fortnite islands in the future, this feature is for you.

Want to explore Scene Graph? Check out the documentation for Scene Graph.

### Scene Graph FAQ

**Q: Why can't I publish using Scene Graph?**

**A**: Scene Graph is currently an Experimental feature. During this period, we are working with the community to gather insights and feedback to ensure stability and functionality. As a result, there may be changes that would break your islands. To avoid these potential disruptions to your published projects, we are temporarily preventing publishing for projects that use Scene Graph until Early Access.

**Q: There aren't enough components to do what I need to do. How do I proceed?**

**A**: You can create custom components using Verse to meet your specific needs. We acknowledge that the current list of components is limited, but you can expect more components to be added over time.

**Q: How can I use devices to meaningfully integrate this with existing gameplay I've made?**

**A**: We are working on a bridge component that will enable limited interoperability, helping creators add existing gameplay to their scene graph.

**Q: How do I animate my objects using Verse?**

**A**: You can use Verse to animate objects, but the result may not work the way you intend it to. Right now, animating entity transforms using Verse can result in janky updates due to network latency. We'll be introducing Verse APIs that improve animation in the future.

### Scene Graph Feature Example

[![Feature Example Screenshot](https://dev.epicgames.com/community/api/documentation/image/9103c1e3-4695-4715-ac8a-685e18bb25f9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9103c1e3-4695-4715-ac8a-685e18bb25f9?resizing_type=fit)

Learn how to use the basic building blocks of Scene Graph with the **Prefabs template** and tutorial. The Prefabs template is designed to illustrate how quickly you can scale your level design and build gameplay components.

[![Viewing a Prefab in the Prefab Editor](https://dev.epicgames.com/community/api/documentation/image/ad231449-22a1-4982-bb35-5b1bd4d78947?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad231449-22a1-4982-bb35-5b1bd4d78947?resizing_type=fit)

The tutorial highlights key Scene Graph workflows to demonstrate how Scene Graph tools are used for world building and creating gameplay by showing you examples of:

- Prefab Iteration
- Prefab Overrides
- Prefab Hierarchies
- Custom Verse Components

## Notes in UEFN — a New Collaborative Feedback Tool

To bring collaborative feedback and iteration workflows deeper into the editor, we've added **Notes** as a new tool in UEFN. With it, you can capture feedback and action items from your real-time collaborators directly in your viewport.

[![Showing a note in the viewport](https://dev.epicgames.com/community/api/documentation/image/8dad2d50-e523-416f-8bf7-1945f35b70b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8dad2d50-e523-416f-8bf7-1945f35b70b8?resizing_type=fit)

Notes are saved with key contextual data, including camera location and orientation, coordinates, your current URC snapshot, and an image of the state of the viewport at the time of creation. You also can add attachments to any note, including additional screenshots, actors, and external reference images, so you can provide as much information as possible for your teammates. To learn more, see the [Using Notes](https://dev.epicgames.com/documentation/en-us/uefn/using-notes-in-unreal-editor-for-fortnite) documentation.

[![Notes panel in the Editor with multiple notes](https://dev.epicgames.com/community/api/documentation/image/55c93bfc-7816-44f7-9860-ca259022ce1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55c93bfc-7816-44f7-9860-ca259022ce1d?resizing_type=fit)

## New Feature Example Projects in UEFN

As our UEFN Feature Examples grow, we've reorganized them to make them easier to find and more clearly identify their purpose. You can find them in the Project Browser under **Feature Examples**. If UEFN opens the last project you worked on, you can open the Project Browser by clicking **File > New/Open Project**. We also added some new smaller Feature Examples to help you get started:

- **Intro to UEFN**: This project demonstrates the basics of UEFN, including tools, features, and available assets.
- **Modeling**: This project showcases how meshes, units and grids work. It also shows you how to use the powerful UEFN Modeling Tools.
- **Materials**: This project shows you some examples of materials, from basic to advanced.
- **Landscape**: This project demonstrates how you can set up and use the Landscape and Foliage tools in the editor.
- **Greyboxing 101**: This project explores how to quickly prototype levels and layouts, giving you a range of tools and methods, as well as tips and tricks!
- **Character, Cameras and NPCs**: This project shows you how to set up and manipulate a range of Characters, Cameras and NPCs.

These small Feature Example projects demonstrate how various parts of UEFN work. Each one focuses on a particular part of game development or a feature of UEFN (as described in the list above). Each level in the project can contain multiple corridors with demo stations, each of which shows individual features and has text that explains how those features work.

## Creative Island Creation: Visual Update

The User Interface (UI) for creating new islands in Creative has been updated! The visual style of the **Select Island** and **New Island** dialogs now matches the updated UI in the rest of Creative.

[![New Select Island dialog](https://dev.epicgames.com/community/api/documentation/image/5776604f-34eb-448e-b19f-44c798807fb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5776604f-34eb-448e-b19f-44c798807fb5?resizing_type=fit)

[![New Island dialog](https://dev.epicgames.com/community/api/documentation/image/9b0feddc-2e40-4196-98d7-867493651454?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9b0feddc-2e40-4196-98d7-867493651454?resizing_type=fit)

## Device Updates

- Update to **Third Person Controls** device:

  - Added an **Autofire** value for the twin stick option **Auto Fire on Controller**. If enabled, the player will automatically fire their weapon in the direction they are aiming while the Aim control is being pressed.

## New Assets for Creative and UEFN

Here are even more new assets for you to use in Creative and UEFN!

### New Items

- Nitro Barrels

### New Weapons

- Tow Hook Cannon

### New Prefabs & Galleries

- Neon Rush Sign Galleries
- Neon Rush Prop Galleries

## LEGO Islands: Player-Built Walls and Structures

If you build LEGO Islands, you can now enable Player-Built Walls and Structures (PBWS) in your islands! This expands your players' options for building on your islands.

Known Issues with using PBWS in LEGO Islands:

- Sometimes when building walls as part of ground terrain, the automatic second piece will place at regular grid scale.
- In situations where traps have become accessible, they will be placed at regular grid scale.
- Ledges for PBWS are not supported.

If you're looking for a way to show off your new LEGO Islands with PBWS, the LEGO Islands row will return to Discover soon for a limited time. Get your islands ready for your players to start building!

## New Monetization tab in Creator Portal

You'll now find a new and improved Monetization tab in a [new navigation panel](https://dev.epicgames.com/documentation/fortnite-creative/project-navigation-in-fortnite-creative) on each published project within Creator Portal. This new tab provides metrics related to your island's engagement payout. Team owners can now access this feature in Creator Portal. We also updated the existing [Engagement Payouts](https://dev.epicgames.com/documentation/en-us/fortnite-creative/engagement-payouts-in-fortnite-creative) documentation page with the updated information and analytics. More project-level analytics are coming soon!

## Documentation Updates

In addition to the docs linked above, we have more updates for you!

- Brand NEW [Party Game](https://dev.epicgames.com/documentation/en-us/uefn/party-game-in-unreal-editor-for-fortnite) tutorial: After watching those [awesome video tutorials](https://youtu.be/foG5iv20-yM?si=tnOkqBZJhKBYh0NH), did you wish you had a written version to dig into even more detail of how to make your own party game and hub? Now you can with our accompanying written tutorial on the EDC!

[![Tilt 'N' Boom Party Game](https://dev.epicgames.com/community/api/documentation/image/a34c3cee-5dd8-4fdc-9f8d-12bcf747c813?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a34c3cee-5dd8-4fdc-9f8d-12bcf747c813?resizing_type=fit)

### Release Notes

## Community Bug Fixes

The following list of fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue where the player could fall through the floor after exiting the Inflate-A-Bu

  - [Forum Issue Report](https://forums.unrealengine.com/t/inflatable-cow-critical-bug/1875443)
- Saving a large amount of assets in UEFN takes an extremely long time to save
- Canceling a submission for a map doesn't do anything

  - [Forum Issue Report](https://forums.unrealengine.com/t/important-cancelling-a-submission-for-a-map-doesnt-do-anything/1874884)
- Fixed an issue where the Falcon Scout was unavailable in published islands.

  - [Forum Issue Report](https://forums.unrealengine.com/t/falcon-scout-does-not-work-in-published-game/1316424))
- Fixed an issue with the Tracker Device in UEFN, where a tracker would mistakenly be shown as completed in the HUD but actually was not completed.

  - [Forum Issue Report](https://forums.unrealengine.com/t/uefn-tracker-device-bug/1768648))
- Fixed an issue with the Class Selector device's **Clear Items on Switch** option. The device now correctly preserves a player's items when this option is set to **Off**.

  - [Reddit Report](https://www.reddit.com/r/FortniteCreative/comments/15b5itp/class_selector_bug))
- Fixed an issue where Checkpoints' teleport function was not working correctly in some Rocket Racing experiences. If teleporting is enabled on a checkpoint, it will now teleport every time the checkpoint is passed.

  - [Forum Issue Report](https://forums.unrealengine.com/t/major-issue-teleporters-dont-work-in-every-rocket-racing-experiences/1840105))
- Fixed an issue where the Map Controller would only show place names and not a full minimap.

  - [Forum Issue Report](https://forums.unrealengine.com/t/mini-map-controller-show-blank/1784985)

## Creative

**Fixes**:

- Fixed an issue where the player could fall through the floor after exiting the Inflate-A-Bull.
- Fixed an issue where the touch screen UI would not appear for many vehicles in Creative. This issue is known to persist for the Inflate-A-Bull.
- Fixed an issue where the Legendary Tactical Assault Rifle had the wrong number of rarity stars in the Creative Inventory.

### Devices

**Fixes**:

- Fixed an issue where players were unable to pick-up items spawned by the Elimination Manager device when the **Pickup Allowed Class** option is set to a value other than **Any**.
- Fixed an issue with an unreliable Patchwork Note Trigger event firing.
- Fixed an issue causing Round Settings devices to fail to disable Join In Progress.
- Fixed an issue with Patchwork Drum Player and Note Trigger devices, where modulator cables would connect to the side of knobs instead of the front.
- Players will now drop Patchwork cables when they are emoting.
- Fixed an issue where the Zipline device's spline points could not be moved using the Phone tool.
- Fixed an issue where the Item Spawner device would have an incorrect default name.
- Fixed an issue with the Patchwork Value Setter: If the **Delay** is set, the **On Value Set** event will occur when the delay finishes instead of immediately.
- Fixed an issue with the **Triggered By** option for the Pulse Trigger.
- Fixed a bug with the Patchwork Value Setter device that occurred when the output cable is connected to another device's control knob, where the connected device text would not update correctly on all clients.

## Creative and UEFN

**Fixes**:

- Fixed a crash that occurred when checking whether to delay activating a camera controller.
- Fixed an issue where the Report screen stays open after the player is eliminated.

## UEFN

**Fixes**:

- Solved an issue where the **Self-Damage** island setting does not work in UEFN projects.
- Exposed the Find/Replace tab in animation editors.
- Exposed additional skeletal mesh LOD info details.
- Fixed an issue where animation editors were selecting the incorrect bone for non-mesh bones.

### Devices

**Fixes**:

- Fixed an issue with the Map Controller device, where the **Capture Map** editor button was not visible.
- Fixed an issue where **Replace Selected Actors** was not working when the selected asset was not loaded.
- The redirector is now hidden by default in the Content Browser like in Unreal Engine. To show them, use the **Show Redirector** filter.
- Fixed an issue where the editor was closing without asking to save changes if servers were taken offline or network connection was lost after startup.
- Made several updates to Landscape messages:

  - Added a tooltip when the widget is collapsed to help the user understand what it's about without having to expand it.
  - Messages now show the number of affected Landscape Actors even in the "dirty actors" case to help the user assess how "out-of-date" the overall landscape is.
- Fixed case where the Phone tool's quick bar would not appear after launching a UEFN edit session.
- Several improvements have been made to how Decal material selection displays:

  - Filtered the material selection list to Decal-only materials.
  - Added a popup message for when a Decal component has a non-decal material. This tells the user about the issue, and gives a hyperlink to edit the material.
  - Editor now shows a map check warning when a Decal component has a non-decal material.
- Added a Capsule Primitive tool to Modeling Mode.
- Fixed an issue with Lumen rendering for meshes created in Modeling Mode.
- Fixed a crash when resizing the brush using the **B** hotkey in the Edit Materials tool.
- Fixed a crash when resizing the brush using the **B** hotkey in the Paint Maps tool.
