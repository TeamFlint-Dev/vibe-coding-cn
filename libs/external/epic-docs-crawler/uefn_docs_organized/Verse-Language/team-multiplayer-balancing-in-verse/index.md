# Team Multiplayer Balancing

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/team-multiplayer-balancing-in-verse
> **爬取时间**: 2025-12-26T23:18:39.523978

---

In multiplayer games, teams of players compete or collaborate to accomplish some objective. The number of players on each team can have radical effects on gameplay, and many developers choose particular ratios of players to create enjoyable experiences.

Team balancing splits players into teams following a designed ratio. Most multiplayer games balance teams evenly so no one team has an advantage. Some games intentionally create imbalanced scenarios, such as pitting four players against one overpowered player. Regardless of the setup, team balance is critical for creating interesting experiences for multiple teams of players.

By completing this guide, you’ll learn how to dynamically balance teams of players at runtime, and whenever a new player joins the game. The [complete script](https://dev.epicgames.com/documentation/en-us/fortnite/team-multiplayer-balancing-in-verse) is included at the end of this guide for reference.

## Verse Language Features Used

- [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse): This device uses [arrays](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) to store a reference to each team.
- [option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse): This device uses options to determine if there is a team with fewer players than the team a player is currently on.
- [for](https://dev.epicgames.com/documentation/en-us/fortnite/for-in-verse): With the [for expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#for-expression), you can iterate over the arrays the device uses.
- [if](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse): The [if expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression) is used to check whether players should move to a new team based on team sizes.
- [failure](https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse): [Failure contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context) are used to access arrays and to control the flow of the program.

## Verse APIs Used

- **Subscribable:** You’ll [subscribe](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#subscribe) `PlayerAddedEvent()` to dynamically rebalance teams when a new player joins a game in progress.
- **Teams:** The team [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) adds, removes, and retrieves players from teams. You’ll use the team class in this tutorial to manipulate players and their team assignments directly.
- **Playspace:** The [playspace](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#playspace) tracks subscribable events related to players joining and leaving the game. It also handles retrieving lists of players and teams, and finding the team for a given player. In this tutorial, you’ll subscribe to multiple playspace events, and retrieve players and teams using playspace [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) so you can manipulate them directly.

## Setting Up the Level

This example uses the following device.

4 x [Player Spawn Pad device](https://www.epicgames.com/fortnite/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative): This device defines where the player spawns at the start of the game.

Follow these steps to set up your level:

1. Add a **Player Spawn Pad** to the level.
2. Select the spawn pad in the **Outliner** to open its **Details** panel.
3. In the **Details** panel, under **User Options**:

   - Set **Player Team** to **Team Index** with a value of **1**
   - Enable **Visible in Game**

     [![Spawn Pad Settings](https://dev.epicgames.com/community/api/documentation/image/5f9cf861-694a-400f-8c67-a0df7a2460e3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f9cf861-694a-400f-8c67-a0df7a2460e3?resizing_type=fit)

     *Click image to expand.*
4. Duplicate the spawn pad and place it next to the first spawn pad.
5. Duplicate both spawn pads and place them further away from the first group of spawn pads. This is where players on Team 2 will spawn.
6. Select the duplicated spawn pads, and in the **Details** panel under **User Options**, change the value of **Team Index** to **2** for both.
7. In the **Outliner,** select the **Island Settings** Device to open its **Details** panel. Under **User Options - Game Rules**:

   - Set **Teams** to **Team Index** with a value of **2**. This example uses two teams, but you can have any number of teams.
   - Set **Team Size** to **Dynamic**. This means your Verse code can take over team balancing.
   - Set **Join in Progress** to **Spawn** so new players can join the game while it’s running.

     [![Island Settings](https://dev.epicgames.com/community/api/documentation/image/a7dd2858-3ced-438c-8290-fe54a6203c77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7dd2858-3ced-438c-8290-fe54a6203c77?resizing_type=fit)

     *Click image to expand.*
8. Create a new Verse device named **team\_multiplayer\_balancing** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level. (To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).)

Your level should look similar to this setup:

[![Completed Level Setup](https://dev.epicgames.com/community/api/documentation/image/b90228f0-f6bc-46f7-8719-1d6748858c53?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b90228f0-f6bc-46f7-8719-1d6748858c53?resizing_type=fit)

## Splitting Teams Equally

### Balancing Teams at Start of Game

This step shows how to split players into teams equally at the start of a game, and when a new player joins the game.

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **team\_multiplayer\_balancing.verse** to open the script in Visual Studio Code.
2. In the `team_multiplayer_balancing` class definition, add a [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) `team` array named `Teams` that will store references to each team players are on.

   ```verse
        team_multiplayer_balance := class(creative_device):
            # Holds the teams found with GetTeams() 
            var Teams : []team = array{}
   ```
3. In the `OnBegin()` [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), update the `Teams` array to match the teams set up earlier in **Island Settings**. [Call](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) the `GetTeams()` function from the `fort_team_collection` API to get all the teams in the playspace.

   ```verse
        OnBegin<override>()<suspends>:void=
            Print("Verse Device Started!")
            set Teams = Self.GetPlayspace().GetTeamCollection().GetTeams()
   ```
4. Find all players in the game by calling the `GetPlayers()` function and save them in a player array named `AllPlayers`.

   ```verse
        OnBegin<override>()<suspends>:void=
            Print("Verse Device Started!")
            set Teams = Self.GetPlayspace().GetTeamCollection().GetTeams()
            AllPlayers := GetPlayspace().GetPlayers()
   ```
5. Iterate through the list of all players and create teams with the same number of players. You'll compare the team a player is currently on to any other team and determine whether it is the best fit for that player. In this case, you can use the team a player is automatically assigned to when the game starts by using `GetTeam[]`(since players must be on a team in game modes with multiple teams). Note that `GetTeam[]` requires a [parameter](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter) of type agent, but since player is a subclass of agent, you can pass a player without [type casting](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type).

   ```verse
        AllPlayers := GetPlayspace().GetPlayers()
        for (TeamPlayer : AllPlayers, CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]):
            # Assign Players to a new team if teams are unbalanced
   ```

   Because team is an internal class, it cannot be initialized and can only be used as a reference to an existing team object.
6. You want to assign players to the team with the least amount of players until all teams are balanced. To do this, you need to check each player, and then each team using a `for` [loop](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#loop). You could use two for loops, one to iterate through players and one to iterate through teams, but in this example you’ll extract the team for loop into its own method. Set up the player for loop by getting a reference to each player, and then reference to each team they’re on in a constant named `CurrentTeam`.

   - Create a new variable integer `TeamSize` and initialize it to `0`, then set it to be equal to the size of the team this player is currently on. Because `GetAgents[]` is a failable expression, you need to enclose this set in an if statement.

     ```verse
       for (TeamPlayer : AllPlayers, CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]):
           # Assign Players to a new team if teams are unbalanced
           var TeamSize : int = 0
           if(set TeamSize = GetPlayspace().GetTeamCollection().GetAgents[CurrentTeam].Length):
               Print("Size of this player's starting team is {TeamSize}")
     ```
   - Create a method named `FindSmallestTeam()`. This will return an optional team (`?team`) when passed `TeamSize` as an argument, and will handle finding and returning the team with the least amount of players. Initialize a new team [option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse) named `SmallestTeam` inside `FindSmallestTeam()`. You’ll use an option here because a player may already be on the smallest team when you call `FindSmallestTeam()`.
   - Since your `SmallestTeam` option defaults to false, it will remain `false` if no smaller team is found. If `FindSmallestTeam()` returns `false`, you know definitively that the given player was already on the smallest team. You also need to initialize a variable int `CurrentTeamSize` to the value of `TeamSize`. You need `CurrentTeamSize` to be variable so you can update it to the size of any other team you find with less players.

     ```verse
                               FindSmallestTeam(CurrentTeamSize : int) : ?team=
                                   var SmallestTeam : ?team = false     
                                   var TeamSize : int = CurrentTeamSize
     ```
   - Since `TeamSize` tracks the size of `SmallestTeam`, you need to compare it to the size of every team. Iterate through each team and get their size in a local int `CandidateTeamSize`. If `CandidateTeamSize` is smaller than `TeamSize`, set `SmallestTeam` to this team and `TeamSize` to the size of that team.

     The condition `TeamSize > CandidateTeamSize` is a filter condition because it is checked within the parentheses of the for loop. Using a filter condition guarantees that the code inside your loop runs only if the filter condition succeeds. This guarantees that `SmallestTeam` will be set to the team with the least players if one is found. If no team with less players is found, `SmallestTeam` will remain false.

     Finally, return `SmallestTeam` once all teams have been checked.

     ```verse
      for(Team : Teams, CandidateTeamSize := GetPlayspace().GetTeamCollection().GetAgents[Team].Length, TeamSize &gt; CandidateTeamSize):
       set SmallestTeam = option{Team}
       set TeamSize = CandidateTeamSize
       Print("Found a team with less players: {CandidateTeamSize}")               
      return SmallestTeam
     ```
   - In `OnBegin()`, create a new team [option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse) named `SmallestTeam` inside the `for` loop and initialize it to the value of `FindSmallestTeam()` when passed `TeamSize` as an argument.

     ```verse
       SmallestTeam : ?team = FindSmallestTeam(TeamSize)
     ```
   - Next, try to access the value in the `SmallestTeam` optional variable. If the value is false, the player was already on the smallest team, and no assignment is necessary. Otherwise, you’ll want to assign the player to their new team.
     Since many methods do not allow us to directly pass an option as an argument, you have to extract the value to a local variable `TeamToAssign`. You can attempt to assign a player to this team using `AddToTeam[player, team]` Note that this assignment will fail if you attempt to assign a player to a team they’re already on. This won’t have any negative effects however, as the `for` loop will just iterate to the next player and leave the first on their original team.

     ```verse
       if (TeamToAssign := SmallestTeam?, GetPlayspace().GetTeamCollection().AddToTeam[TeamPlayer, TeamToAssign]):
           Print("Attempting to assign player to a new team")
     ```
7. `OnBegin()` should look like the code block below.

   ```verse
        OnBegin<override>()<suspends> : void =
            Print("Verse Device Started!")
            set Teams = Self.GetPlayspace().GetTeamCollection().GetTeams()
            Print("Beginning to Assign Players")
            Playspace := GetPlayspace()
            AllPlayers := Playspace.GetPlayers()
            for (TeamPlayer : AllPlayers, CurrentTeam := Playspace.GetTeamCollection().GetTeam[TeamPlayer]):
                var TeamSize : int = 0
                if(set TeamSize = Playspace.GetTeamCollection().GetAgents[CurrentTeam].Length):
                    Print("Size of this player's starting team is {TeamSize}")
                SmallestTeam : ?team = FindSmallestTeam(TeamSize)
                if (TeamToAssign := SmallestTeam?, Playspace.GetTeamCollection().AddToTeam[TeamPlayer, TeamToAssign]):
                    Print("Attempting to assign player to a new team")
   ```

### Handling a Player Joining Mid-Game

Since you also want to be able to auto-balance teams for a game in progress, you will have to subscribe to the event that fires when a new player joins. Since you don’t want to repeat all the code you just wrote, you can refactor it into a common method.

1. Create a method named `BalanceTeams()` and move all the code from after you set the `Teams` variable using `GetTeams()`. This is called in the `OnBegin()` method so teams are balanced when the game starts. `BalanceTeams()` should look something like this.

   ```verse
        BalanceTeams() : void =
            AllPlayers := GetPlayspace().GetPlayers()
            for (TeamPlayer : AllPlayers, CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]):
                var TeamSize : int = 0
                if(set TeamSize = GetPlayspace().GetTeamCollection().GetAgents[CurrentTeam].Length):
                    Print("Size of this player's starting team is {TeamSize}")          
                SmallestTeam : ?team = FindSmallestTeam(TeamSize)
                if (TeamToAssign := SmallestTeam?, GetPlayspace().GetTeamCollection().AddToTeam[TeamPlayer, TeamToAssign]):
                    Print("Attempting to assign player to a new team")
   ```
2. Create another method named `OnPlayerAdded()` which contains a call to `BalanceTeams()`. Although you won’t use the `player` variable, the method definition requires it since you subscribe to `PlayerAddedEvent()` using this method. See the [Coding Device Interactions](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse) page for more details on subscribable events.

   ```verse
                                OnPlayerAdded(InPlayer : player) : void =
                                Print("A new Player joined, assigning them to a team!")
                                BalanceTeams()
   ```
3. In `OnBegin()`, subscribe to `PlayerAddedEvent()` using `OnPlayerAdded`. Now, when a player joins the game, `OnPlayerAdded` will call `BalanceTeams()` to automatically balance the teams.

   ```verse
        OnBegin<override>()<suspends> : void =
                GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
                Print("Beginning to balance teams")
                BalanceTeams()
   ```
4. Save the script in Visual Studio Code and click **Build Verse Code** to compile your script.
5. Click **Launch Session** in the UEFN toolbar to playtest the level.

When you playtest your level, you should see the size of each team, as well as any smaller teams the script finds printed to the output log. Players should be balanced across teams evenly, and a new player joining the game should keep this even balance.

## Complete Script

The following code is the complete script for a device that automatically balances teams of players.

```verse
    using { /UnrealEngine.com/Temporary/Diagnostics }
    using { /Fortnite.com/Devices }
    using { /Verse.org/Simulation }

    team_multiplayer_balance := class(creative_device):
        # Holds the teams found with GetTeams()
        var Teams : []team = array{}
        OnBegin<override>()<suspends> : void =

            Print("Verse Device Started!")
            set Teams = Self.GetPlayspace().GetTeamCollection().GetTeams()
            AllPlayers := GetPlayspace().GetPlayers()
            #Subscribe to PlayerAddedEvent to allow team rebalancing when a new player joins the game
            Self.GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
            Print("Beginning to balance teams")
            BalanceTeams()

        #Handles a new player joining the game

        OnPlayerAdded(InPlayer : player) : void =
            Print("A new Player joined, assigning them to a team!")
            BalanceTeams()

        <#
        For each player, find the number of players of the team they're on. Iterate through the
        list of teams and assign them to the team with the least amount of players, or their
        starting team in case of ties.
        #>

        BalanceTeams() : void =
            AllPlayers := GetPlayspace().GetPlayers()
            for (TeamPlayer : AllPlayers, CurrentTeam := GetPlayspace().GetTeamCollection().GetTeam[TeamPlayer]):
                # Assign Players to a new team if teams are unbalanced
                var TeamSize:int = 0

                if(set TeamSize = GetPlayspace().GetTeamCollection().GetAgents[CurrentTeam].Length):
                    Print("Size of this player's starting team is {TeamSize}")

                SmallestTeam : ?team = FindSmallestTeam(TeamSize)
                if (TeamToAssign := SmallestTeam?, GetPlayspace().GetTeamCollection().AddToTeam[TeamPlayer, TeamToAssign]):
                    Print("Attempting to assign player to a new team")

        FindSmallestTeam(CurrentTeamSize : int) : ?team =
            var SmallestTeam : ?team = false
            var TeamSize : int = CurrentTeamSize

            <#
            For each team Team, get the number of players on that team. If it has less players than SmallestTeam,
            set SmallestTeam to Team and update TeamSize to the number of players on the new Team
            #>

            for(Team : Teams, CandidateTeamSize := GetPlayspace().GetTeamCollection().GetAgents[Team].Length, TeamSize > CandidateTeamSize):
                set SmallestTeam = option{Team}
                set TeamSize = CandidateTeamSize
                Print("Found a team with less players: {CandidateTeamSize}")
            return SmallestTeam
```

## On Your Own

By completing this guide, you’ve learned how to create a device using Verse that automatically balances teams of players.

Using what you’ve learned, try to create intentionally imbalanced teams for asymmetric game modes, like one player versus four players.
