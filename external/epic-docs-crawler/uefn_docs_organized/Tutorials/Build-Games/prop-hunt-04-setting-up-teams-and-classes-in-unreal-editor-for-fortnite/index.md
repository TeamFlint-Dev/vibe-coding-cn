# 4. Setting up Teams and Classes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-04-setting-up-teams-and-classes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:23:20.474752

---

This section will show you how to determine and customize teams and classes for players.

**Devices used:**

- 2 x [Team Settings and Inventory](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-team-settings-and-inventory-devices-in-fortnite-creative)
- 2 x [Class Designer](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-class-designer-devices-in-fortnite-creative)
- 2 x [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-class-selector-devices-in-fortnite-creative)

## Team Setting and Inventory

[![Team Setting and Inventory](https://dev.epicgames.com/community/api/documentation/image/38bc52cb-2b33-48f2-bd04-d38a68378c1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38bc52cb-2b33-48f2-bd04-d38a68378c1b?resizing_type=fit)

Use Team Settings and Inventory devices to set team names and colors for the scoreboard display.

Place one device for each team in an area unseen by players. To set up the Prop team, configure the **User Options** to match the table below.

[![Prop Team Setting and Inventory](https://dev.epicgames.com/community/api/documentation/image/1258d2ac-73f3-4827-8b5d-a917f5075668?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1258d2ac-73f3-4827-8b5d-a917f5075668?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Team Name** | Props | Sets a text string that will be used to identify the team in the Scoreboard and HUD elements. |
| **Team Color** | Sky Blue | Assigns a color to the selected team that is used in the scoreboard, HUD, and on certain devices. |
| **Team** | Team Index: 1 | Specifies which team the settings on this device apply to. |

To set up the Hunter team, configure the other device’s **User Options** to match the table below.

[![Hunter Team Setting and Inventory](https://dev.epicgames.com/community/api/documentation/image/4de233de-b0fa-4dc3-a14b-6a7a0cf29365?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4de233de-b0fa-4dc3-a14b-6a7a0cf29365?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Team Name** | Hunters | Sets a text string that will be used to identify the team in the Scoreboard and HUD elements. |
| **Team Color** | Orange | Assigns a color to the selected team which is used in the scoreboard, HUD, and on certain devices. |
| **Team** | Team Index: 2 | Specifies which team the settings on this device apply to. |

## Class Designer

[![Class Designer](https://dev.epicgames.com/community/api/documentation/image/17f60b80-2bab-453e-a477-ebee7bab2c5c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17f60b80-2bab-453e-a477-ebee7bab2c5c?resizing_type=fit)

Use a Class Designer to modify the teams you just created.

Place two Class Designer devices, one for each team, in an area unseen by players. To customize the Prop team, configure the **User Options** to match the table below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Prop | Determines the name of this class. |
| **Class Description** | Hide from hunters. Survive. | Sets the description of this class. |
| **Class Identifier** | Class Slot: 1 | Sets the unique identifier for this class. |
| **Max Health** | 1 | Determines the maximum health value players can reach during the game. Props will be eliminated with one hit. |
| **Item List** | Prop-O-Matic | Sets the list of items this class will have. |
| **Equip Granted Item** | First Item | Determines which item in the list will be equipped. |

To customize the Hunter team, configure the other device’s **User Options** to match the table below.

[![Modified Hunter Class Designer](https://dev.epicgames.com/community/api/documentation/image/e7aabb4f-e8b2-4677-a7de-0af39ed10fb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e7aabb4f-e8b2-4677-a7de-0af39ed10fb3?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class Name** | Hunter | Determines the name of this class. |
| **Class Description** | Find props. Eliminate them. | Sets the description of this class. |
| **Class Identifier** | Class Slot: 2 | Sets the unique identifier for this class. |
| **Item List** | Flashlight Pistol | Sets the list of items this class will have. |
| **Equip Granted Item** | First Item | Determines which item in the list will be equipped. |

## Class Selector

[![Class Selector](https://dev.epicgames.com/community/api/documentation/image/3bf19e2e-bef9-459f-8cab-e0dc014f0693?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bf19e2e-bef9-459f-8cab-e0dc014f0693?resizing_type=fit)

Pair the Class Designer with the Class Selector to manage the customized classes and teams you create.

Along with Verse, the settings from this device cause players in Class Slot 1 to transfer to Class Slot 2 when respawned.

Place two Class Selectors, one for each team, in an area unseen by players. To manage the Prop team, use the settings from the table below to configure the **User Options** for this device.

[![Modified Class Selector](https://dev.epicgames.com/community/api/documentation/image/94c592c7-9b73-4f9f-9f75-f47e5abec2ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94c592c7-9b73-4f9f-9f75-f47e5abec2ff?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class to Switch to** | Class Slot: 1 | Determines which class the player should switch to. |
| **Visible During Game** | False | This device will not be visible in-game. |
| **Zone Audio** | False | Determines whether the Class Selector should play audio effects when players enter the zone. |
| **Team to Switch to** | Team Index: 1 | Determines which team the player will switch to. |
| **Clear Items on Switch** | True | Determines whether items should be removed from the player’s inventory when the switch is applied. |
| **Volume Visible in Game** | False | Determines whether the device’s volume is visible during the game. |
| **Display VFX on Activation** | False | Determines whether the device should create a VFX effect when changing the class or team of a player. |

To manage the hunter team, use the settings from the table below to configure the **User Options** for this device.

[![Modified Class Selector](https://dev.epicgames.com/community/api/documentation/image/2204b90a-0e4e-446c-831f-f1530b44b8dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2204b90a-0e4e-446c-831f-f1530b44b8dc?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| **Class to Switch to** | Class Slot: 2 | Determines which class the player should switch to. |
| **Team to Switch to** | Team Index: 2 | Determines which team the player will switch to. |

## Creating Team Functionality With Verse

There are two teams in this Prop Hunt game: Hunters and Props. You need to be able to do some of the same things for both teams to make the game work. For example:

- adding players to a team
- removing players from a team
- displaying information to players about their team

To create this functionality for both teams without duplicating code, you’re going to create a class with the [`<abstract>`](https://dev.epicgames.com/documentation/en-us/uefn/subclass-in-verse) specifier. Classes with the `abstract` specifier are meant to have partial functionality that their subclasses inherit and build upon. You’ll first create an abstract class called `base_team` and give it the functionality that both Prop and Hunter teams will share.

This doc includes Verse snippets that show how to execute gameplay mechanics needed in this gameplay. Follow the steps below and copy the full script on [step 6](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite) of this tutorial.

Create a new Verse file in your project called **base\_team.verse**. This will not be a Verse device so you can create it as an empty Verse file.

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
log_team := class(log_channel){}
# This class defines the devices needed for the different teams in the experience.
# This class is abstract so it cannot be used on its own. It has to be inherited by another class.
base_team := class<abstract>:
    Logger:log = log{Channel:=log_team}
    @editable # Used to set a player to the team.
    ClassSelector:class_and_team_selector_device = class_and_team_selector_device{}
    @editable # Used to award score to agents on the team.
    ScoreManager:score_manager_device = score_manager_device{}
     @editable # Used to display the team assignment title.
    TeamTitle:hud_message_device = hud_message_device{}
    @editable # Used to display the team assignment description.
    TeamDescription:hud_message_device = hud_message_device{}
     @editable # Used to subscribe to team member (prop team) or enemy (hunter team) eliminated events.
    TeamManager:team_settings_and_inventory_device = team_settings_and_inventory_device{}
    # This is an array of agents on the team.
    var TeamAgents<private>:[]agent = array{}
    # This event is signaled when the TeamAgents array becomes empty (signaling the end of the round).
   TeamEmptyEvent:event() = event(){}
    # Returns the current TeamAgents array.
    # This is required because the TeamAgents array is private, so other classes cannot access it directly.
    GetAgents()<decides><transacts>:[]agent =
        TeamAgents
    # Return the size of the TeamAgents array
    # This requires a function because the TeamAgents array is private, so other classes cannot access it directly.
    Count()<transacts>:int =
        TeamAgents.Length
    # Returns an index in the TeamAgents array of an agent, fails otherwise.
    FindOnTeam(Agent:agent)<decides><transacts>: int =
        Index := TeamAgents.Find[Agent]
       # Set the agent to the team and notify the player.
    InitializeAgent(Agent:agent):void =
        AddAgentToTeam(Agent)
        ClassSelector.ChangeTeamAndClass(Agent)
        DisplayTeamInformation(Agent)
   # Add an agent to TeamAgents.
    AddAgentToTeam(AgentToAdd:agent):void =
        if (not FindOnTeam[AgentToAdd]):
            Logger.Print("Adding agent to team.")
            set TeamAgents += array{AgentToAdd}
    # Activates HUD message devices to show the player what team they are on
    DisplayTeamInformation(Agent:agent):void =
        TeamTitle.Show(Agent)
        TeamDescription.Show(Agent)
    # When an agent leaves the match, remove them from the TeamAgents array and check for the end of the round.
    EliminateAgent(Agent:agent)<suspends>:void =
        Sleep(0.0) # Delaying 1 game tick to ensure the player is respawned before proceeding.
        RemoveAgentFromTeam(Agent)
    # Remove an agent from TeamAgents.
    # If the agent removed was the last, signal TeamEmptyEvent.
    RemoveAgentFromTeam(AgentToRemove:agent):void =
        set TeamAgents = TeamAgents.RemoveAllElements(AgentToRemove)
        Logger.Print("{Count()} agent(s) on team remaining.")
        if (Count() < 1):
            Logger.Print("No agents on team remaining. Ending the round.")
            TeamEmptyEvent.Signal()
```

Now that you have this class, you can create the classes for the Prop team and Hunter team. Because each of these will inherit from `base_team`, there are a few advantages:

- The code to implement each team is much shorter because they already have their common functions and data defined in `base_team`.
- It’s easier to understand what code is specific to the Prop and Hunter teams because they are in their own classes instead of being mixed in with the common code.
- Adding more teams to the game mode is much easier. Any new teams inherit from `base_team` and the code that makes the new team different is in its own class.

Remember, you cannot create an instance of a class with the `<abstract>` specifier. You must create a class that inherits from the abstract class, and instantiate that class.

### Hunter Team

First, create the class for the Hunter team. Create a new Verse file in your project called **hunter\_team.verse**. This will not be a Verse device so you can create it as an empty Verse file.

Declare a class named `hunter_team`. It should be `<concrete>` and also inherit from `base_team`.

```verse
hunter_team := class<concrete>(base_team):
```

Making a class `<concrete>` means all the fields of the class must have a default value. See [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/uefn/specifiers-and-attributes-in-verse) to learn more.

Below is the full code for the hunter\_team.verse script.

The `hunter_team` class has two functions with the same name as functions in the `base_team` class. This is allowed because they both have the `<override>` specifier. This means that when these functions are called on an instance of `hunter_team`, the version in the `hunter_team` class is used.

For example, in the following code, the version of `InitializeAgent()` defined in `hunter_team` will be used because it overrides the function of the same name in `base_team`. Compare that to the call to `Count()` which will use the version defined in `base_team` because there is no override function.

```verse
 HunterTeam:hunter_team = hunter_team{}
# Uses the function from hunter_team
HunterTeam.InitializeAgent(StartingHunterAgent)
# Uses the function from base_team
HunterTeam.Count()
```

The two overridden functions also use `(super:)`. This allows them to call the version of the functions defined in `base_team` because `base_team` is the superclass of `hunter_team`. In the case of `InitializeAgent()` and `EliminateAgent()`, they both use `Logger.Print()` to print something to the log. Then they call their respective functions from `base_team`. This means that the functions work exactly the same as the versions in `base_team`, except for the calls to `Logger.Print()`.

See [Subclass](https://dev.epicgames.com/documentation/en-us/uefn/subclass-in-verse) to learn more about `<override>` and `(super:)`

### Prop Team

Now create the class for the Prop team. Create a new Verse file in your project called **prop\_team.verse**. This will not be a Verse device so you can create it as an empty Verse file.

You have to manage more for members of the Prop team. They have heartbeat effects that must be started and stopped based on a timer and how far they move. They must also be moved to the Hunter team when they are eliminated.

To manage the members of the Prop team, you’ll use the `RunPropGameLoop()` method. You can think of this method as the manager for a Prop’s entire journey through the game. From the time they spawn to the time they are either eliminated or leave the game, this method will be running for every Prop team member.

```verse
    # If the prop agent stops moving then race to see if the prop agent moves beyond the MinimumMoveDistance, the heartbeat timer completes, or the prop agent is eliminated.
    RunPropGameLoop(PropAgent:agent)<suspends>:void =
        Logger.Print("Starting prop agent game loop.")
        # Loop forever through the prop behavior until the prop agent is eliminated or the player leaves the session.
        race:
            PropAgent.AwaitNoLongerAProp()
            loop:
                # Wait until the prop agent moves less than the minimum distance, then advance.
                PropAgent.AwaitStopMoving(MinimumMoveDistance)
                # Until the prop agent moves beyond the minimum distance, countdown to the heartbeat and then play the heartbeat indefinitely.
                race:
                    PropAgent.AwaitStartMoving(MinimumMoveDistance)
                    block:
                        CountdownTimer(PropAgent)
                        PropAgent.StartHeartbeat()
                Sleep(0.0) # Once the race completes (the prop agent moves), start the loop again.
```

`RunPropGameLoop()` has one parameter, `PropAgent`. This is a constant that represents a player on the Prop team. It also has the `<suspends>` specifier, which means it takes time to finish. In this case, it will not finish until the `PropAgent` that is passed is no longer on the Prop team.

All the functionality of this method is contained within a race expression. This means that the method will not be complete until one of the expressions within this race is completed. Those expressions are:

- `PropAgent.AwaitNoLongerAProp()`
- `loop`

The loop expression within this race will never end. It is infinite on purpose. This means that `AwaitNoLongerAProp()` is the method that will **always** win the race and complete the method. Using race this way is like telling your program to run a certain set of code over and over until something happens. See [Race](https://dev.epicgames.com/documentation/en-us/uefn/race-in-verse) to learn more about this powerful expression.

With this code, `AwaitNoLongerAProp()` wins the race.

```verse
   # Loop until the prop agent is no longer a part of the PropAgents array. Removal happens if the prop agent is eliminated and turned into a hunter or if the player leaves the session.
    (PropAgent:agent).AwaitNoLongerAProp()<suspends>:void =
        loop:
            if (not FindOnTeam[PropAgent]):
                Logger.Print("Cancelling prop agent behavior.")
                break
            Sleep(0.0) # Advance to the next game tick.
```

This method constantly checks to see if `PropAgent` is on the Prop team. It starts with a loop that runs until `not FindOnTeam[PropAgent]` succeeds and then breaks, completing the method. See [Loop and Break](https://dev.epicgames.com/documentation/en-us/uefn/loop-and-break-in-verse) to learn more about them.

`FindOnTeam[]` is a failable function that is declared in `base_team`. It succeeds if the `PropAgent` is found on the Prop team. But you need to use the `not` operator because you want to break out of the loop only when the `PropAgent` is not found on the Prop team. See [Operators](https://dev.epicgames.com/documentation/en-us/uefn/operators-in-verse#notoperator) to learn more about `not`.

Finally, you need to add a `Sleep(0.0)` at the end of the loop. This ensures that the loop runs once then advances to the next [simulation update](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#simulation-update). You don’t need to run this check more often, so the `Sleep(0.0)` is added to help performance. See the Verse API Reference page for [Sleep](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/simulation/sleep) to learn more.

Now that you know how `AwaitNoLongerAProp()` works, you can write the infinite loop that races with it in `RunPropGameLoop()`.

## Next Section

[![5. Game Loop and Round Management](https://dev.epicgames.com/community/api/documentation/image/7d0d4062-a5b2-46bb-8235-d02eaff0750e?resizing_type=fit&width=640&height=640)

5. Game Loop and Round Management

Use the Verse code in this section to add a game loop and round management system.](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-05-game-loop-and-round-management-in-unreal-editor-for-fortnite)
