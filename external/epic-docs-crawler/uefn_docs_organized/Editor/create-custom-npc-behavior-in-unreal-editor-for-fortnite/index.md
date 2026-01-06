# Create Custom NPC Behavior

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:03:08.159021

---

The behavior of an NPC character is defined by their behavior script. The behavior script is what tells characters what actions to take in the world, such as where to go, what to fight, and how to interact with other characters. Characters such as guards and wildlife may have additional behaviors, such as perception, alertness, and the ability to be hired or tamed.

An **NPC Behavior**  is a user-defined Verse script that adds extra functionality to an NPC character’s existing behaviors. The `npc_behavior` API lets you define code that runs when an NPC character spawns or despawns, and you can use it to create custom characters like medics, shopkeepers, or bosses. NPC Behaviors inherit from the `npc_behavior` abstract class and require importing the `/Fortnite.com/AI` module to use.

To run an NPC Behavior Script, you need to attach it to an [NPC Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite). How an NPC Behavior Script interacts with a character definition depends on the [NPC Character type](https://dev.epicgames.com/documentation/en-us/fortnite/npc-types-in-unreal-editor-for-fortnite). Custom-type NPCs need a behavior script to perform actions, while Guard and Wildlife-type NPCs will run their default behavior if they aren’t given a behavior script. For more information on creating an NPC Character Definition and the different character types, see the Character Definition page.

This tutorial goes over the basics of creating an NPC behavior script and teaches you how to spawn an NPC and navigate it to an objective.

## Creating a New NPC Behavior Script

Follow these steps to create an NPC Behavior Script in UEFN that spawns a guard and patrols them between two points.

1. Open your project in UEFN, then in the [Menu Bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), go to **Verse > Verse Explorer**.
2. In [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), right-click on your project name and choose **Add new Verse file to project** to open the **Create Verse Script** window.

   [![Add New Verse File to Project](https://dev.epicgames.com/community/api/documentation/image/25adbe7c-ffdc-4c11-8c09-d27b1b9fa470?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25adbe7c-ffdc-4c11-8c09-d27b1b9fa470?resizing_type=fit)
3. In the Create Verse Script window, click **NPC Behavior** to select it as your template.
4. Name your NPC Behavior by changing the text in the **NPC Behavior Name** field to the name of your device. In this example, the device is named **my\_first\_npc\_behavior**.

   [![My First NPC Behavior](https://dev.epicgames.com/community/api/documentation/image/f2dc08ec-86fa-4918-af82-e64a5143133c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2dc08ec-86fa-4918-af82-e64a5143133c?resizing_type=fit)
5. Click **Create** to create the Verse file.
6. In Verse Explorer, double-click the name of your Verse file to open it in Visual Studio Code.
7. Save your code, compile it, and create a new NPC character definition. For more information on creating an NPC character, see the [Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) page.
8. Assign your `my_first_behavior` script as the Verse behavior of your new Character Definition.
9. Click launch session in the UEFN toolbar to playtest your level. When you playtest your level, characters spawned from your NPC Spawner should pick a random point near when they spawn and navigate to it. When they reach that point, they should wait a certain amount of time and navigate back to their starting point. If you’ve enabled [Verse Debug Draw enabled](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse) from the [Island Settings device](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite), you should see arrows drawn that show where the character is focusing, as well as boxes that show the point a character is navigating to.

## Navigatable

You can use the `Navigatable` API to direct characters to certain targets and for things like patrolling, guarding a point, or following another character. Guard-type NPCs can do this with AI Patrol Path nodes, but here you’ll use verse code to extend this functionality to any type of character and avoid placing additional devices in the level. The character’s `navigatable` [interface](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) allows you to navigate characters to a `navigation_target`, which you can create from an `agent` or `position`. Custom, Guard, and Wildlife-type NPCs can all use the navigatable interface. To get the character’s `navigatable` interface you’ll first need to get a reference to their `fort_character`, which you can do by calling `GetFortCharacter[]`.

```verse
# Get the Navigatable Interface, this allows you to tell it to move.
Navigatable := Character.GetNavigatable[]
```

In the template example, the code chooses a position from a random offset where the character spawns and saves it in a variable `GoToPoint`. It then creates a `navigatoin_target` from both the `GotToPoint` and the character’s spawn point.

```verse
# Create a random offset from the spawn point to walk toward.
GoToPoint := NPCSpawnPoint + vector3{X := GetRandomFloat(-DistanceFromSpawnPtToMove,DistanceFromSpawnPtToMove),
                                     Y := GetRandomFloat(-DistanceFromSpawnPtToMove,DistanceFromSpawnPtToMove),
                                     Z := 0.0 }

if(ShowAIDebug?):
    Print(my_first_npc_behavior_message_module.OnNavigateBeginMessage(Agent,GoToPoint.X,GoToPoint.Y,GoToPoint.Z), ?Duration := AIDebugDrawTime)

# Create a navigation target from these two positions that the navigation interface can use.
NavTargetStart := MakeNavigationTarget(GoToPoint)
NavTargetEnd := MakeNavigationTarget(NPCSpawnPoint)
```

The `NavigateTo()` function returns a `navigation_result` [enum](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse), which contains info about whether the character reached their `navigation_target`. You can check the value of your `navigation_result` to give characters behaviors based on whether they reached their target or not.

```verse
# Check to see if something has interfered with the NPC reaching the intended location and print a
# message to the output log.
if (NavResultGoTo <> navigation_result.Reached):
    if(ShowAIDebug?):
        Print(my_first_npc_behavior_message_module.OnNavigateErrorMessage(Agent,GoToPoint.X,GoToPoint.Y,GoToPoint.Z), ?Duration := AIDebugDrawTime)
else:
    # Once it arrives at its location, wait for this duration in seconds
    Navigatable.Wait(?Duration := MoveToWaitDuration)
```

For more information on how characters navigate the world and to visualize the different areas characters can navigate to, see the [Navigation Mesh](https://dev.epicgames.com/documentation/en-us/fortnite-creative/navigation-mesh-in-fortnite-creative) page.

## Focus

When characters perform actions, they look at specific targets. The specific target a character is looking at is the character’s **focus**. Characters focus on the character they’re talking to, the target they’re attacking, or the position they’re navigating to. The `focus_interface` lets you specify specific targets for your characters to focus on. Custom, Guard, and Wildlife-type NPCs can all use the focus interface. The `MaintainFocus()` function focuses your character on a target, which can be either a `vector3` position or an `agent`. The `focus_interface` is part of the `fort_character` interface, and you can retrieve it using `GetFocusInterface[]`.

```verse
# Get the Focus Interface, this allows you to tell it to look at something or somewhere.
Focus := Character.GetFocusInterface[]
```

In the template example, after the character begins navigating back to the starting position, the code uses `MaintainFocus()` to force them to focus on the previous `navigation_target`. This causes the character to walk backward and watch behind them as they return to their starting point.

```verse
# Leveraging concurrency to wait until the NPC reaches its destination, while the calls to look back at its origin point 
# and drawing a debug arrow never completes, continuing, ensures only the NavigateTo can win the race.
NavResultGoToNext := race:
    # Move back to its starting position.
    Navigatable.NavigateTo(NavTargetEnd)

    # Sets NPC to look at its previous position which will make it walk backwards. 
    # This is meant to show the utility of the focus interface.
    block:
        Focus.MaintainFocus(GoToPoint)
        navigation_result.Interrupted
    block:
        if(ShowAIDebug?):
            DrawDebugLookAt(Character, GoToPoint) 
        else:
            Sleep(Inf)
        navigation_result.Interrupted
```

## Leashable

When guards guard an objective, you want to make sure they stay in an area around the objective and don’t wander off too far. The `fort_leashable` interface is a Guard-type NPC-specific interface that lets you specify a radius around a target that guards won’t patrol out of. You can leash guards to specific positions or other NPCs, and guards will update their position to stay near their leash target if it moves. Note that currently Custom and Wildlife-type NPC characters cannot use the `fort_leashable` interface. You can retrieve the `fort_leashable` interface using `GetFortLeashable[]`.

```verse
# Get the Leash Interface, which lets you confine a guard to a certain area.
Leashable := Character.GetFortLeashable[]
```

You can leash guards to either positions or other agents, such as when guarding a capture point or protecting an important NPC. Each leash has an `InnerRadius` and `OuterRadius`, which specify how close and how far in centimeters guards should stay from their leash target respectively. The template example does not use the `leashable` interface, but you might find it useful when creating your own guard NPCs.

```verse
# Leash the guard to a position so they stay between 500 and 1000
# cm of the position they're leashed to
Leashable.SetLeashPosition(NPCSpawnPoint, InnerRadius := 500.0, OuterRadius := 1000.0)

# Leash the guard to an agent so they stay between 500 and 1000
# cm of the agent they're leashed to
Leashable.SetLeashAgent(AgentToFollow, InnerRadius := 500.0, OuterRadius := 1000.0)
# Clear all leashes on the guard
Leashable.ClearLeash()
```

## Debug Draw

At the top of the file, this template defines a dedicated channel for debug draw. You can use the [Debug Draw](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse) to visualize certain game data for testing purposes. For instance, you can visualize the visibility range of your character, or draw a shape around the location they’re traveling to. **Verse Debug Draw** must be enabled from the **Debug** tab in **Island Settings** to visualize these debug shapes, and they will not appear in published experiences. The channel at the top of the file lets you hide, show, or clear all the debug shapes in a channel using a single method.

```verse
# Create a dedicated debug channel to draw to for this behavior
npc_debug_draw := class(debug_draw_channel) {}
```

The `new_npc_behavior` template class defines several values used for visualization and movement.

- The `MoveToWaitDuration` defines how long in seconds your character waits at a point before moving.

  ```verse
        # How long to wait in seconds after the NPC navigates to a point before moving on.
        @editable_number(float):
            Categories:=array{my_first_npc_behavior_message_module.SettingsCategory},
            MinValue:=option{0.5},
            MaxValue:=option{10.0}
        MoveToWaitDuration:float = 5.0
  ```
- The `DistanceFromSpawnPtToMove` defines the range of the random offset from the spawnpoint for your character to move.

  ```verse
        # The negative min and absolute max x & y coordinate offset in centimeters to tell the NPC to move to
        @editable_number(float):
            Categories:=array{my_first_npc_behavior_message_module.SettingsCategory},
            MinValue:=option{0.0}
        DistanceFromSpawnPtToMove:float = 1500.0
  ```
- The `ShowAIDebug` logic value lets you toggle drawing debug shapes from the editor.

  ```verse
        # Whether to draw debug to the NPC channel when Verse Debug Draw is enabled in Island Settings.
        @editable:
            Categories:=array{my_first_npc_behavior_message_module.SettingsCategory}
        ShowAIDebug:logic = true
  ```
- The `AIDebugDrawTime` float lets you specify the amount of time to render the debug draw location.

  ```verse
  # How long in seconds to render the debug draw location and print text. 
  # It is recommended to keep this in sync with MoveToWaitDuration otherwise the print will not be shown if a previous message is displayed. @editable_number(float): 
      Categories:=array{my_first_npc_behavior_message_module.SettingsCategory}, 
      MinValue:=option{0.5} 
  AIDebugDrawTime:float = 5.0
  ```
- The `LookAtDebugDrawDuration` float lets you specify how long to render the look arrow debug draw.

  ```verse
        # How long in seconds to render the look at arrow's debug draw.
        LookAtDebugDrawDuration:float = 0.5
  ```
- The `DebugDrawNPC` channel defines the debug draw instance, and uses the channel defined at the top of the file.

  ```verse
        # How long in seconds to render the look at arrow's debug draw.
        @editable_number(float):
            Categories:=array{my_first_npc_behavior_message_module.SettingsCategory},
            MinValue:=option{0.5}
        LookAtDebugDrawDuration:float = 0.5
  ```
- Finally the `VerticalOffsetToNPCHead` defines this offset from the NPC’s pelvis to the head to draw the debug look arrow from. Without this offset, the debug look arrow would be drawn from the center of the NPC.

  ```verse
        # Used for specifying a point offset from the NPC pelvis to the head to draw the look at arrow from.
        VerticalOffsetToNPCHead<private>:float = 55.0
  ```

Two functions in the `new_npc_behavior` template class draw debug shapes. The `DrawDebugLocation()` function draws a large point at a specified position for a `LookAtDebugDrawDuration`  amount of time.

```verse
# This function draws a box around a specified position for a finite amount of time.
# NOTE: To see this in game, Verse Debug Draw must be enabled in Island Settings.
DrawDebugLocation(Location:vector3):void = 
    DebugDrawNPC.DrawPoint( Location, 
                            ?Color := NamedColors.SteelBlue, 
                            ?Thickness := 100.0, 
                            ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration, 
                            ?Duration := AIDebugDrawTime )
```

The `DrawDebugLookAt()` function lets you visualize where a character is looking by drawing an arrow from the agent’s head to its look point.

```verse
# This function draws an arrow from the Agent's head to its look at point every half a second.
# NOTE: To see this in game, Verse Debug Draw must be enabled in Island Settings.
DrawDebugLookAt(Character:fort_character, LookAtPoint:vector3)<suspends>:void=
    loop:
        DebugDrawNPC.DrawArrow( Character.GetTransform().Translation + vector3{ Z := VerticalOffsetToNPCHead},
                                LookAtPoint,
                                ?ArrowSize := 50.0,
                                ?Color := NamedColors.Yellow,
                                ?Thickness := 5.0,
                                ?DrawDurationPolicy := debug_draw_duration_policy.FiniteDuration,
                                ?Duration := LookAtDebugDrawDuration )

        #This sleep matches the length of time the arrow is drawn to avoid duplicate draws.
        Sleep(LookAtDebugDrawDuration)
```

## Adding your Character to the Level

Now that you’ve learned about the NPC BehaviorScript, it’s time to create a character and use the script on an island. The following workflow is designed for Guard-type characters, but the NPC Behavior Script will still work for Custom and Wildlife-type characters.

1. Create a new NPC Character Definition named **MyFirstCharacterDefinition**. Click your new character definition to open the **Character Definition** screen.
2. In the **Character Definition** screen, modify the following properties:

   1. Under **NPC Character Type**, set **Type** to **Guard**. The guard interface lets you access guard-specific character functionality, such as events for when the guard is alerted or suspicious and lets you hire guards to use as allies. Guards may also equip weapons, while Custom and Wildlife-type characters currently cannot. You can also change the name of your character under the **Name** tab.
   2. Under **NPC Character Behavior**, set **Behavior** to **Verse Behavior**. Then set the **NPC Behavior Script** to `my_first_npc_behavior`. Your character will still have access to functionality from the guard interface, but will use your Verse script to decide what to do during `OnBegin` and `OnEnd`.
   3. In the **Modifiers** tab, under **Guard Spawn Modifier**, click the **Cosmetic** tab to change your character’s cosmetic appearance. You can choose from a preexisting cosmetic, or enable **Character Cosmetic Retargeting** to use a custom model. Note that only guards and Custom-type characters can use character cosmetic retargeting, while wildlife cannot. For more information on character modifiers and which ones apply to different character types, see the [NPC Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) page.
   4. On the **Modifiers** tab, click **Add Element** to add a new modifier to your character. Change the type of the new modifier to **Inventory Modifier**. Note that only guards can use the inventory modifier.
   5. Under **Inventory Modifier**, click **Add Element** to add a new item to your character’s inventory. Set the **Item Definition** to a weapon, item, item, or anything else your character should have. You can add multiple items to your character’s inventory, and your characters will use weapons to fight, items to heal, etc.
   6. On the **Modifiers** tab, click **Add Element** to add a new modifier to your character. Change the type of the new modifier to **UI Modifier**.
   7. Under **UI Modifier**, click the **Name** tab to change your character’s name. Your character’s name will display above their head.

[![My First Character Definition](https://dev.epicgames.com/community/api/documentation/image/e482bd43-6006-4706-820c-2d8f68f5cbe2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e482bd43-6006-4706-820c-2d8f68f5cbe2?resizing_type=fit)

1. Save your NPC character definition. In the **Content Browser**, drag your NPC character definition into the level. This will automatically create a new NPC Spawner and assign your character definition to it.

1. Select your NPC Spawner. In the **Outliner**, under **User Options**:

   1. Set **Spawn Count** to **20**. You’re going to want a few guards to help you out, so have some fun and max this out.
   2. Click **Launch Session** in the UEFN toolbar to playtest your level. When you playtest, your character should spawn and patrol between their starting point and a random point near it, and engage any enemies along the way.

## On Your Own

By completing this guide, you’ve learned how to create an NPC Behavior Script to make your very own custom characters. For more reading and to learn how to create specific types of characters and scenarios, check out some of the NPC Behavior tutorials listed below.

## Tutorials That Use NPC Behavior

[![Create your own NPC Medic](https://dev.epicgames.com/community/api/documentation/image/4eee7e77-f687-4360-9ca8-339fe4b09bc5?resizing_type=fit&width=640&height=640)

Create your own NPC Medic

Use Verse Code to create a custom NPC medic.](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-npc-medic-in-unreal-editor-for-fortnite)
