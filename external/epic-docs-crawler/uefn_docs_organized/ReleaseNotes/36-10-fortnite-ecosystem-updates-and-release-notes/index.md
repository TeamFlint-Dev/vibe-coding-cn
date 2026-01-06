# 36.10 Fortnite Ecosystem Updates and Release Notes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/36-10-fortnite-ecosystem-updates-and-release-notes
> **爬取时间**: 2025-12-27T00:36:25.848421

---

## LEGO® Brick Editor is Live!

You can now build with LEGO® bricks in UEFN! It’s time to unleash your creativity and build your own amazing props and environments for your islands.

The LEGO® Brick Editor comes with 50 original bricks in 42 original LEGO® colors. The [LEGO® Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-in-fortnite) generates static meshes, which you can glue together using the new Kragle functionality—so you can reuse that perfect section again and again.

LEGO® bricks use studs and tubes to automagically snap together, just like in the real world. That’s a little different than building with other LEGO® assets in UEFN, so have a look at the [Working With LEGO® Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-lego-islands-in-fortnite-creative).

Excited to get started? Get an overview of the editor in [Working With The LEGO® Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-the-lego-brick-editor-in-fortnite), and try the [LEGO® Brick Editor Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-template-in-fortnite) to get some hands-on experience with building!

### Brand Rules Update

Before you tip the box and let bricks tumble into your viewport, review the updated brand guidelines. There are some rules to using LEGO® bricks in your islands, [LEGO® Brand and Creator Rules](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brand-and-creator-rules-in-fortnite-creative).

## LEGO® Bloom Tycoon Template

Learn to create a grid system for players to spawn props into their island using the Bloom Tycoon template. You can expand your asset inventory and create new game experiences for players. Create a farming adventure with animal figures, a garden shop tycoon with plants that sprout over time, and more!

This packed template includes two levels to explore: LEGO® Bloom Tycoon and Brick Builder. LEGO® Bloom Tycoon features a quest with Park Ranger Peely to familiarize yourself with the grid system, and teaching pods that include a breakdown of the game's features. Release your imagination with the Brick Builder level, where you can practice placing props within specified zones. Expand your grid system with custom builds from the Brick Editor for a more unique experience.

To learn more, see [Bloom Tycoon](https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-in-fortnite).

## LEGO® Templates are Now Available Without Sign-Up

You can now access LEGO® Templates without having to first sign the IP Partner Licensing Agreement. Like with other Brand Game Collections, you can now access and build with all LEGO® assets, from 36.10 as well as previous versions. Just make sure to sign the agreement when you’re ready to publish your first LEGO® island!

## Discover Search UI/UX and Algorithm Improvements

We’re experimenting with some changes to the Browse tab in Discover. A portion of players may notice an updated UI/UX experience.

We’re also continuing to refine the search algorithm, experimenting with improvements using both Keyword and Semantic Search to deliver more relevant results. For more information, see [How Discover Works](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite).

### Create Mini-Games With Brand New Devices

We have developed a number of new devices to support mini-game and social gameplay. Use these devices to set up interesting and challenging experiences for multiple players; are they in a team? Will they help each other? Or are you setting them up to cause each other to fail?

The new devices are:

- [Disguise Device](https://dev.epicgames.com/documentation/en-us/fortnite/36-10-fortnite-ecosystem-updates-and-release-notes#new-disguise-device)
- [Carryable Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/36-10-fortnite-ecosystem-updates-and-release-notes#new-carryable-spawner-device)
- [Voting Group Device / Voting Options Device](https://dev.epicgames.com/documentation/en-us/fortnite/36-10-fortnite-ecosystem-updates-and-release-notes#new-voting-option-device-and-voting-group-device-nbsp)

We have also expanded the Skilled Interaction Device to support multiple players.

These devices are available in all islands except Fall Guys, Rocket Racing, and LEGO Islands.

These devices are a great fit for official Squid Game islands, which you’ll be able to start building on June 27. Some of these new devices will have Squid Games-specific options and content!

### New Disguise Device

The [Disguise Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-disguise-devices-in-fortnite) has a set of pre-defined disguises that you can assign to players, allowing you to build experiences that feature strong team identities and social deception mechanics.

You can configure features of the disguise, such as the outfit used, the conditions under which the disguise is broken, and many more. This device has a full Verse API that includes applying/removing disguises, querying whether a player has a disguise applied, and more.

### New Carryable Spawner Device

The [Carryable Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-carryable-spawner-devices-in-fortnite) spawns objects which can be picked up by players and thrown. You can configure a wide amount of properties of the objects, from the mesh used for the object, to the explosion it creates when thrown. The carryables don't have to explode; you can also set them up so that they can be used to activate triggers, which creates classic puzzle gameplay.

This device has full Verse API support, adding control over what the device does. It can spawn carryables, adjust explosion properties, modify throwing angles, and force players to carry an object, among other things.

The object spawned by the default version of the device is an Atlas stone. We will be releasing variations of this device with different defaults in the future.

New Carryable Device in Fortnite

### New Voting Option Device and Voting Group Device

Using the [Voting Option Device and Voting Group Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite) together, you can build voting gameplay which uses a choice of triggers. From running into a space defined by a Volume device, to interacting with a Button device, hitting a Target Dummy device, or even using event binding or Verse to trigger events from different stages of the vote itself, you can be as explicit or subtle with what’s happening as you want in your island experience.

The Voting Group device defines the vote itself, as well as when and how it starts and finishes. This device will listen for Voting Options devices it is connected to.

Voting Options device defines the choices players can vote for. Each choice needs its own Voting Options device.

We plan to release Verse APIs for this device in the future.

### Skilled Interaction Device Updates!

The [Skilled Interaction Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-skilled-interaction-devices-in-fortnite-creative) now supports multiplayer gameplay! You can now specify a Queue Type to let players interact in unique and powerful ways. You can configure interactions to be synchronous, sequential, and random, to create many types of minigames!

You can also configure the UI, to show how many other players are executing skill checks, specify who can interact next in the queue, or even customize how progress is displayed.

To find out more about the updates to the Skilled Interaction Device, read the updated documentation..

We have also updated the Verse API for this device to add tooling around queue management!

## Content Browser and Inventory Updates

Check out all the content updates available this release!

### Devices Updates and Fixes

New:

- Updated the Interaction Prompt for the Creator Profile Link device to Open Creator Profile instead of More.
- Added a Verse API for Hiding Prop Devices. This API allows creators to listen to events like a player entering the device and adjust values like maximum hide time in Verse, among other things. Use Verse to hide players in an area around the device, or eject specific players on demand! The full API can be found [here](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device).
- The Dash Sprite from Battle Royale has been added to the Wildlife Spawner. When players deploy the Dash Sprite and walk into the sprite’s area of effect, they get three charges of Super Dash.
- When using the Prop-O-Matic device, added player feedback to signal invalid props in game.

Fixes:

- Fixed an issue where the Assembly device would apply the wrong collision setting.
- Made several improvements to the HUD Controller device's Quickbar ViewModel.
- Fixed an issue where traps were not usable with the Item Granter device and other Item devices.

### Creator Most Wanted Weapons and Items

You wanted it, you got it!

- Midas’ Drum Gun

### New Weapons

- Ascended Myst

### New Prefabs & Galleries

- 2 New Prefabs

  - Underground Alpha Mining Company
  - Shiny Shafts Processing Building
- 5 New Galleries

  - Shiny Shafts Roof Gallery
  - Shiny Shafts Wall & Fence Gallery
  - Shiny Shafts Floor & Stair Gallery
  - Shiny Shafts Prop Gallery
  - Shiny Shafts Cave Gallery

### Verse Code Snippets

```verse
    @editable
    Disguise : disguise_device = disguise_device{}
    @editable
    DisguiseToggle : button_device = button_device{}

 OnBegin<override>()<suspends>:void=
        # Event subscriptions for devices      
        DisguiseToggle.InteractedWithEvent.Subscribe(OnDisguiseToggle)

    # Applies and Removes player Disguise...
    # ...as long as the Disguise Device is enabled
    OnDisguiseToggle(Agent:agent):void=
        if(Disguise.IsEnabled[]):
            if(Player := player[Agent]):
                if(Disguise.IsDisguiseApplied[Player]):
                    Disguise.RemoveDisguise(Player)
                    HUDMessageDevice.Show(LogMessageWithPlayer(Player, "disguise removed!"))
                else:
                    Disguise.ApplyDisguise(Player)
                    HUDMessageDevice.Show(LogMessageWithPlayer(Player, "disguise applied!"))
        else:
            var Message :string = "Disguise Device is disabled, please enable it"
            HUDMessageDevice.Show(StringToMessage(Message))
```

```verse
    @editable
    Carryable : carryable_spawner_device = carryable_spawner_device{}
    @editable
    ExplodeAgent : button_device = button_device{}
    @editable
    ForceCarry : button_device = button_device{}

        ExplodeAgent.InteractedWithEvent.Subscribe(OnExplodeAgent)
        ForceCarry.InteractedWithEvent.Subscribe(OnForceCarry)
        Carryable.ExplodeEvent.Subscribe(OnExplode)

    # Forces instigating player to carry the Carryable...
    # ... and gets the carrying agent and location of the carryable
    OnForceCarry(Agent:agent):void=
        if(Player := player[Agent]):
            Carryable.ForcePlayerToCarry(Player)
            MaybeAgent := Carryable.CarryingAgent
            MaybeTransform := Carryable.CarryableObjectTransform
            if (CarryAgent := MaybeAgent?):
                if (CarryTransform := MaybeTransform?):
                    HUDMessageDevice.Show(Message(Agent, "has the Carryable at {CarryTransform.Translation}!"))

    # Explodes the Carryble and assigns the passed agent as the instigator
    OnExplodeAgent(Agent:agent):void=
        Carryable.Explode(Agent)
    # Listening for Carryable explosion
    OnExplode(MaybeAgent:?agent, AgentArray:[]agent):void=
        if(Agent := MaybeAgent?):
            HUDMessageDevice.Show(Message(Agent, "exploded the Carryable! {AgentArray.Length} player(s) caught in the explosion!"))
```

### Fortnite Creative And UEFN Docs Are Now One!

As you can see, our documentation merge is complete! All your official learning content is all in one place now and rebranded from UEFN & Creative to Fortnite. All pages should be redirected to the new community. Let us know what you think and leave any suggestions in the forums!

### All New Home Page!

New docs merge? New [home page](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-documentation)! With all the content coming together, we wanted a visual refresh to orient new users to our latest content, where to get started and more!

### Refreshed Getting Started Page!

With our content merging into one, we also updated the [Getting Started](https://dev.epicgames.com/community/fortnite/getting-started) page in the EDC! Not only does it have with the latest links and content, but is also instantly accessible from the left-hand navigation, no matter where you are in the Fortnite EDC.

## Community Bug Fixes

The following fixes are from issues that you submitted to us on the forums. Thank you for your patience and for reporting these issues!

- Fixed an issue causing jittering when adding a component to Entity -> Scene -> Play

  - [Forum Report](https://forums.unrealengine.com/t/scene-graph-jittering-and-unstable-movement-of-keyframed-movement-component-and-fix-method/2519691)
- Fixed a Scene Graph quiet server crash when an entity is removed from the scene

  - [Forum Report](https://forums.unrealengine.com/t/scene-graph-quiet-server-crash-at-game-end/2519675)
- Fixed an issue where UEFN was stuck in a session loading state if the server crashes after pushing Verse changes

  - [Forum Report](https://forums.unrealengine.com/t/verse-push-changes-not-working/2445988/)
- Fixed an issue where Trap consumables cannot be dropped into granter devices from a VK Edit session.

  - [Forum Report](https://forums.unrealengine.com/t/traps-cannot-spawn-in-item-granters/2029868)

## Fortnite Ecosystem Updates and Fixes

New:

- We've updated the Epic Games Launcher to verify that UEFN updates and starts correctly. Please be sure to keep the launcher updated to the latest version.
- Set the timer for kicking inactive (AFK) players to 30 minutes.

Fixes:

- Fixed a bug where players could not use the dash ability after exiting a Water device set to use River Styx water.
- Fixed an issue where saving a placed Physics Tree, Physics Boulder, Nitro Barrel, or Nitro Hoop to the phone tool's Quick Menu would result in thumbnails with incorrect or off-center images.
- Game modes that require cross play will now warn players where that privilege is unavailable before any download or matchmaking is initiated.

## Brand Island Updates and Fixes

New:

- Added Morgan Myst, Killswitch and Lightrider as characters to the NPC Spawner.

### LEGO® Brick Editor Known Limitations

The bricks were excited to be released, so we decided to let them loose even though there are a few limitations:

- Kragling can take time on larger structures because the content is being optimized, so please be patient. Brick-built objects have building data that is temporarily stored so validation can verify the placement of the bricks as physically possible. This is editor-only data, but it can make the file sizes larger on disk.
- When dragging complex brick structures around, the viewport may become slow and have trouble rendering bricks. This is due to the precise collision detection being triggered. Work is being done to accelerate this in future releases. You can disable it from the toolbar, but that may lead to invalid configurations if you aren’t careful.
- The overlap validator does its best to only detect invalid placement of bricks. It can trigger on situations that are otherwise accepted, especially on kragled meshes. If it does, please take a look at the simple collision on the mesh. The collision optimization may have cut through empty space to make a convex hull.If you encounter this, try breaking down the kragled mesh into smaller chunks. This check tries to make the digital world feel as close to what you can do in the real world as possible, and catch meshes that are phased into each other.

## UEFN Updates and Fixes

New:

- Scrolling is now enabled for Text Block widgets.
- Fixed an issue where the AFK system could not detect player input when a UI widget was active.

Fixes:

- Increased the client Join Retry window to allow for slow clients to join in the case of backend server stalls. This should help prevent players from being kicked from their party and game when transitioning between servers if their data is slow to load.
- Fixed the editor getting stuck in the project upload state, which required a restart to resolve if it lost its connection to the server while pushing Verse.
- Fixed the editor continuing to appear as though it is in a session when it loses its connection to the server because it gets stuck in a state trying to reconnect.
- Fixed event/function property names being unlocalized in the details panel.
- Fixed a crash in SafeRenameEditorOnlyData() when EditorOnlyCurrent is null.

## Scene Graph

Fixes:

- Fixed an issue where the dropped entity sunk or phased through the ground.
- Fixed an issue where instanced entities were not being added to the quickbar correctly.
- Fixed an issue where the  Collide with copies option didn't work with entities.

## Verse Updates and fixes

New:

- Changed the description of the Explosive device's Explode function from "Triggers this device to explode. Passes `Agent` as the instigator of the explosion." to "Triggers this device to explode. Passes `Agent` as the instigator of the resulting `ExplodedEvent`.” This change is purely for clarification and does not affect functionality.

## Unreal Revision Control

Fixes:

- Fixed an issue where clicking Check-in Changes could result in an error if it quickly followed the addition and subsequent deletion of large numbers of files at once.
- Fixed an issue in which switching to a new project that needed to be synced from an already open project could result in a sync error that could only be resolved by closing and reopening the editor and trying again.
