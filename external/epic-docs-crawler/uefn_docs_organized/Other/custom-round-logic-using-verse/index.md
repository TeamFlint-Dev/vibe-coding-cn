# Custom Round Logic

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/custom-round-logic-using-verse>
> **爬取时间**: 2025-12-26T23:18:11.801398

---

In racing games, it's common for players to have a different start position based on how well they performed in a previous round. It encourages players to finish the race quickly even when they aren’t in first place so they start ahead of the other players.

[![](https://dev.epicgames.com/community/api/documentation/image/d935ffbb-dacf-4c7b-8fc4-796132f566a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d935ffbb-dacf-4c7b-8fc4-796132f566a9?resizing_type=fit)

To accomplish this, the game needs to know what round the players are currently in and the racer finish order must persist across all the rounds – but not across all game sessions. A [session weak map variable in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) resets its data every round, so this round information has to be stored with each player, using a [player weak map variable](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse), and reset after the game ends.

Currently, a project can only have up to two player weak map variables. If your project already has a player weak map variable, it’s a good idea to have the second one record the round information to differentiate the data that should always persist from the data that you’ll reset after the game ends or a player leaves the session.

It's also important to know what round the players are currently on to apply round-specific logic and reset the round info on the last round. There’s currently no API for getting the current round, so this information needs to be recorded in the persistable data for each player as well.

In summary, you will need a player weak map variable that has at least the following information:

- Finish order
- Last completed round

The following sections show you how to set up this data and round-logic. You can find the complete code at the end of the page.

## Record Last Completed Round

Follow these steps to set up the persistable data for each player and record the last completed round.

1. Create a persistable class named `player_circuit_info` to store player info across rounds. This class should have the fields to represent the player’s last finish order, `LastRoundFinishOrder`, and their last completed round, `LastCompletedRound`. These fields are initialized with `-1` to represent invalid values, so you know when these fields actually contain useful information.

   ```verse
        # Tracks the number of and in what order a player finished the previous round.
        player_circuit_info<public> := class<final><persistable>:
            Version:int = 0
            LastRoundFinishOrder:int = -1
            LastCompletedRound<public>:int = -1
   ```

2. Create a player weak map variable using the `player_circuit_info` class to persist the round info with players.

   ```verse
        # A persistable map that maps each player to
        # what order they finished the previous round.
        var CircuitInfo<public>:weak_map(player, player_circuit_info) = map{}
   ```

3. As a best practice for working with persistable data, create a [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse) for the persistable class to be able to update the info for each player easily. For more details, see [using constructors for partial updates](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).

   ```verse
        # Creates a new player_circuit_info from the given older player_circuit_info.
        MakePlayerCircuitInfo<constructor>(OldPlayerCircuitInfo:player_circuit_info)<transacts> := player_circuit_info:
            Version := OldPlayerCircuitInfo.Version
            LastRoundFinishOrder := OldPlayerCircuitInfo.LastRoundFinishOrder
            LastCompletedRound := OldPlayerCircuitInfo.LastCompletedRound
   ```

4. Now that you’ve defined structures for this data, add a function to record a player’s finish order and update their persistent data. This function uses the constructor made in the previous step to partially update the data for the only information you’re concerned with: the finish order.

   ```verse
        # Creates a new player_circuit_info for the given player with the order they finished the round in.
        RecordPlayerFinishOrder<public>(Agent:agent, FinishOrder:int)<decides><transacts>:void=
            Player := player[Agent]
            Player.IsActive[]
            PlayerCircuitInfo:player_circuit_info = if:
                Info := CircuitInfo[Player]
            then:
                Info
            else:
                player_circuit_info{}

            set CircuitInfo[Player] = player_circuit_info:
                MakePlayerCircuitInfo<constructor>(PlayerCircuitInfo)
                LastRoundFinishOrder := FinishOrder
   ```

5. Create another function to update only the last completed round for the player.

   ```verse
        # Updates a player's player_circuit_info with their last completed round.
        UpdateRound<public>(Agent:agent, CompletedRound:int)<decides><transacts>:void=
            Player := player[Agent]
            Player.IsActive[]
            PlayerCircuitInfo := CircuitInfo[Player]
            set CircuitInfo[Player] = player_circuit_info:
                MakePlayerCircuitInfo<constructor>(PlayerCircuitInfo)
                LastCompletedRound := CompletedRound
   ```

6. Now that you can record the last completed round for the player, create a function to calculate the last completed round for the game by checking which players have the latest recorded round. You need to check all players to account for players that may have joined the session in progress. The last completed round variable is initialized with `-1` to represent invalid data. If any players have a value greater than `-1` then a round has already finished.

   ```verse
        # Returns the highest last completed round among all players.
        GetLastCompletedRound<public>(Players:[]player, TotalRounds:int)<transacts>:int=
            var LastCompletedRound:int = -1
            for:
                Player : Players
                Player.IsActive[]
                PlayerCircuitInfo := CircuitInfo[Player]
            do:
                # Update LastCompletedRound if this player has the highest last completed round.
                else if:
                    PlayerCircuitInfo.LastCompletedRound > LastCompletedRound
                then:
                    set LastCompletedRound = PlayerCircuitInfo.LastCompletedRound

            LastCompletedRound
   ```

7. Create a Verse device to test that the round and player finish order is working as expected. Make sure your project is set up for multiple rounds, by setting the Total Rounds property in [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite).

   ```verse
        # A Verse-authored creative device that can be placed in a level
        test_round_info_device := class(creative_device):

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                Players := GetPlayspace().GetPlayers()
                CurrentRound := GetLastCompletedRound(Players) + 1
                Print("Current round is {CurrentRound}")

                for:
                    Index -> Player : Players
                    RecordPlayerFinishOrder(Player, Index)
                    UpdateRound(Player, CurrentRound)
                do:
                    Print("Recorded finish order {Index} and current round {CurrentRound} for player")
   ```

## Reset Round Info on Player Leaving

The player's persistent data for round information should be reset when a player leaves during the game. You can subscribe to the playspace’s PlayerRemovedEvent to know when they leave.

Follow these steps to reset round information when a player leaves:

1. Create a function to reset the player's persistent data for round information. This means setting the values to `-1` or whatever you decide to represent the invalid data for those fields. This implementation opts-in on what data should be reset in case you add other information later to the persistent class that shouldn’t be reset here.

   ```verse
        # Resets a player's player_circuit_info.
        ResetCircuitInfo<public>(Agent:agent)<decides><transacts>:void=
            Player := player[Agent]
            Player.IsActive[]
            PlayerCircuitInfo := CircuitInfo[Player]

            set CircuitInfo[Player] = player_circuit_info:
                MakePlayerCircuitInfo<constructor>(PlayerCircuitInfo)
                LastRoundFinishOrder := -1
                LastCompletedRound := -1
   ```

2. Create a function named `OnPlayerRemoved` to reset the round information when a player leaves.

   ```verse
        # When a player is removed from the race, reset their circuit to prevent their
        # stats from showing up on billboards and player references.
        OnPlayerRemoved(Player:player):void=
            # Reset circuit info when player leaves the game.
            if:
                ResetCircuitInfo[Player]
            else:
                Print("Unable to reset circuit info for player")
   ```

3. Set up the `OnPlayerRemoved` function to be called when a player leaves the game, by subscribing to the event `GetPlayspace().PlayerRemovedEvent()`.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        test_round_info_device := class(creative_device):

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)

                Players := GetPlayspace().GetPlayers()
                CurrentRound := GetLastCompletedRound(Players) + 1

                Print("Current round is {CurrentRound}")

                for:
                    Index -> Player : Players
                    RecordPlayerFinishOrder(Player, Index)
                    UpdateRound(Player, CurrentRound)
                do:
                    Print("Recorded finish order {Index} and current round {CurrentRound} for player")
   ```

4. Test to verify that a player leaving the game resets their info.

## Reset Round Info on Game End

The `OnBegin` function for a Verse device runs at the start of every round. This is a good time to determine if a player has unexpected persistent data, such as if their last completed round is the same as the total number of rounds. If so, you need to reset the data for the player. There is currently no API for knowing the total number of rounds in a game. Instead, you’ll need to add an editable property to the Verse device for the total rounds in the Verse code and make sure it matches the Total Rounds property in [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite).

Follow these steps to reset the round info when the game has ended:

1. Add an editable property to your Verse device for the total number of rounds in the game. TotalRounds should not be less than or equal to `0`, so constrain the values of the property to greater than or equal to `1`.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        test_round_info_device := class(creative_device):

            # The total number of rounds in the race.
            @editable
            TotalRounds:type {Rounds:int where 1 <= Rounds} = 3

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)

                Players := GetPlayspace().GetPlayers()
                CurrentRound := GetLastCompletedRound(Players) + 1

                Print("Current round is {CurrentRound}")

                for:
                Index -> Player : Players
                    RecordPlayerFinishOrder(Player, Index)
                    UpdateRound(Player, CurrentRound)
                do:
                    Print("Recorded finish order {Index} and current round {CurrentRound} for player")
   ```

2. Update the function for `GetLastCompletedRound` to reset the player’s persistent data for the last completed round if it’s greater than the expected number of rounds in the game.

   ```verse
        # Returns the highest last completed round among all players.
        GetLastCompletedRound<public>(Players:[]player, TotalRounds:int)<transacts>:int=
            var LastCompletedRound:int = -1
            for:
                Player : Players
                Player.IsActive[]
                PlayerCircuitInfo := CircuitInfo[Player]
            do:
                # If player's recorded info is greater than the total rounds for whatever reason,
                # then need to reset the player's circuit info because they shouldn't have more than what's allowed.
                if:
                    # Total rounds should not be set to 0.
                    PlayerCircuitInfo.LastCompletedRound >= TotalRounds - 1
                then:
                    # Try to reset the player's circuit info so it's fresh.
                    if:
                        ResetCircuitInfo[Player]
                    else:
                        Print("Unable to reset circuit info for player")

                # Update LastCompletedRound if this player has the highest last completed round.
                else if:
                    PlayerCircuitInfo.LastCompletedRound > LastCompletedRound
                then:
                    set LastCompletedRound = PlayerCircuitInfo.LastCompletedRound

            LastCompletedRound
   ```

3. Update the call to `GetLastCompletedRound` to pass in the total rounds as an argument, to reset player round info if they’re in an unexpected state.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        test_round_info_device := class(creative_device):

            # The total number of rounds in the race.
            @editable
            TotalRounds:type {Rounds:int where 1 <= Rounds} = 3

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)

                Players := GetPlayspace().GetPlayers()
                CurrentRound := GetLastCompletedRound(Players, TotalRounds) + 1

                Print("Current round is {CurrentRound}")

                for:
                Index -> Player : Players
                    RecordPlayerFinishOrder(Player, Index)
                    UpdateRound(Player, CurrentRound)
                do:
                    Print("Recorded finish order {Index} and current round {CurrentRound} for player")
   ```

4. Test to verify that player round info resets even after playing and completing all the rounds.

## Adding Logic Based on Current Round

Now, you can use this information to have custom logic depending on which round the players are in. For example, you could show a [local leaderboard](https://dev.epicgames.com/documentation/en-us/fortnite/make-your-own-ingame-leaderboard-in-verse) for the first round of a game.

Calling `GetLastCompletedRound()` every time you need to know which round is being played isn’t ideal. Instead, you can do this once per round and record the round info in a session weak map variable so all Verse code in the project can access this value at any time without needing to recompute it every time.

This is a great example to show the differences and reasoning for using the session weak map variable and player weak map variable in your code:

- **Session weak map variables** are useful for singletons and storing data for the current round that you don’t want to recompute every time.
- The **player weak map variables** are designed for information that needs to persist across multiple rounds and game sessions but must be associated with individual players.

Follow these steps to set up a session weak map variable for storing the current round.

1. Create a class to store the round information. You at least need a field for `CurrentRound` but you could include other round information you want to save across all your Verse code such as the starting positions and vehicles of players. Initialize `CurrentRound` to `-1` to represent invalid data.

   ```verse
        round_info := class:
            CurrentRound:int = -1
   ```

2. Create a session weak map variable using the `round_info` class to store the round info with the session.

   ```verse
        # Maps the current session to its associated round info.
        var RoundInfo:weak_map(session, round_info) = map{}
   ```

3. Add a getter function for getting the current round from the session weak map variable.

   ```verse
        GetRound<public>()<decides><transacts>:int=
            RoundInfo[GetSession()].CurrentRound
   ```

4. Add a function to get the current round and store it in the session weak map variable.

   ```verse
        RecordCurrentRound<public>(Players:[]player, TotalRounds:int):void=
            var CurrentRoundInfo:round_info =
                if:
                    Info := RoundInfo[GetSession()]
                then:
                    Info
                else:
                    LastCompletedRound := GetLastCompletedRound(Players, TotalRounds)
                    round_info:
                        CurrentRound := LastCompletedRound + 1

            if:
                set RoundInfo[GetSession()] = CurrentRoundInfo
            else:
                Print("Unable to record round info in session weak map.")
   ```

5. Update your Verse device to use the new `RecordCurrentRound` function and call `GetRound` when you need to know which round it is.

   ```verse
        # A Verse-authored creative device that can be placed in a level
        test_round_info_device := class(creative_device):

            # The total number of rounds in the race.
            @editable
            TotalRounds:type {Rounds:int where 1 <= Rounds} = 3

            # Runs when the device is started in a running game
            OnBegin<override>()<suspends>:void=
                GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)

                Players := GetPlayspace().GetPlayers()
                RecordCurrentRound(Players, TotalRounds)

                for:
                    Index -> Player : Players
                    CurrentRound := GetRound[]
                    RecordPlayerFinishOrder(Player, Index)
                    UpdateRound(Player, CurrentRound)
                do:
                    Print("Recorded finish order {Index} and current round {CurrentRound} for player")
   ```

Now that this info is stored in a session weak map variable, you can easily add custom logic for rounds. For example, you can check if it’s the first round and set up a lobby and leaderboard viewing area for the players.

```verse
# Returns true if this is the first round of the game.
IsFirstRound<public>(RoundToCheck:int)<decides><transacts>:void=
    RoundToCheck <= 0
```

## On Your Own

Check out [Speedway Race with Verse Persistence](speedway-race-with-verse-persistence-in-unreal-editor-for-fortnite) for how to use this code in a racing game for determining the start order of players.

After checking out the template, try the following:

- Add additional round information, for example which vehicle is assigned to the player.
- Teleport players to different areas of the map at the beginning of each round.

What other games can you think of that use round-specific logic?

## Complete Code

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

# A persistable map that maps each player to
# what order they finished the previous round.
var CircuitInfo<public>:weak_map(player, player_circuit_info) = map{}

# Maps the current session to its associated round info.
var RoundInfo:weak_map(session, round_info) = map{}

round_info := class:
    CurrentRound:int = -1

# Tracks the number of and in what order a player finished the previous round.
player_circuit_info<public> := class<final><persistable>:
    Version:int = 0
    LastRoundFinishOrder:int = -1
    LastCompletedRound<public>:int = -1

# Creates a new player_circuit_info from the given older player_circuit_info.
MakePlayerCircuitInfo<constructor>(OldPlayerCircuitInfo:player_circuit_info)<transacts> := player_circuit_info:
    Version := OldPlayerCircuitInfo.Version
    LastRoundFinishOrder := OldPlayerCircuitInfo.LastRoundFinishOrder
    LastCompletedRound := OldPlayerCircuitInfo.LastCompletedRound

# Returns true if this is the first round of the game.
IsFirstRound<public>(RoundToCheck:int)<decides><transacts>:void=
    RoundToCheck <= 0

GetRound<public>()<decides><transacts>:int=
    RoundInfo[GetSession()].CurrentRound

    # Returns the highest last completed round among all players.
GetLastCompletedRound<public>(Players:[]player, TotalRounds:int)<transacts>:int=
    var LastCompletedRound:int = -1
    for:
        Player : Players
        Player.IsActive[]
        PlayerCircuitInfo := CircuitInfo[Player]
    do:
        # If player's recorded info is greater than the total rounds for whatever reason,
        # then need to reset the player's circuit info because they shouldn't have more than what's allowed.
        if:
            # Total rounds should not be set to 0.
            PlayerCircuitInfo.LastCompletedRound >= TotalRounds - 1
        then:
            # Try to reset the player's circuit info so it's fresh.
            if:
                ResetCircuitInfo[Player]
            else:
                Print("Unable to reset circuit info for player")

        # Update LastCompletedRound if this player has the highest last completed round.
        else if:
            PlayerCircuitInfo.LastCompletedRound > LastCompletedRound
        then:
            set LastCompletedRound = PlayerCircuitInfo.LastCompletedRound

    LastCompletedRound

RecordCurrentRound<public>(Players:[]player, TotalRounds:int):void=
    var CurrentRoundInfo:round_info =
        if:
            Info := RoundInfo[GetSession()]
        then:
            Info
        else:
            LastCompletedRound := GetLastCompletedRound(Players, TotalRounds)
            round_info:
                CurrentRound := LastCompletedRound + 1

    if:
        set RoundInfo[GetSession()] = CurrentRoundInfo
    else:
        Print("Unable to record round info in session weak map.")

# Updates a player's player_circuit_info with their last completed round.
UpdateRound<public>(Agent:agent, CompletedRound:int)<decides><transacts>:void=
    Player := player[Agent]
    Player.IsActive[]
    PlayerCircuitInfo := CircuitInfo[Player]
    set CircuitInfo[Player] = player_circuit_info:
        MakePlayerCircuitInfo<constructor>(PlayerCircuitInfo)
        LastCompletedRound := CompletedRound

# Resets a player's player_circuit_info.
ResetCircuitInfo<public>(Agent:agent)<decides><transacts>:void=
    Player := player[Agent]
    Player.IsActive[]
    PlayerCircuitInfo := CircuitInfo[Player]

    set CircuitInfo[Player] = player_circuit_info:
        MakePlayerCircuitInfo<constructor>(PlayerCircuitInfo)
        LastRoundFinishOrder := -1
        LastCompletedRound := -1

# Creates a new player_circuit_info for the given player with the order they finished the round in.
RecordPlayerFinishOrder<public>(Agent:agent, FinishOrder:int)<decides><transacts>:void=
    Player := player[Agent]
    Player.IsActive[]
    PlayerCircuitInfo:player_circuit_info = if:
        Info := CircuitInfo[Player]
    then:
        Info
    else:
        player_circuit_info{}

    set CircuitInfo[Player] = player_circuit_info:
        MakePlayerCircuitInfo<constructor>(PlayerCircuitInfo)
        LastRoundFinishOrder := FinishOrder

# A Verse-authored creative device that tests storing round information for a game.
test_round_info_device := class(creative_device):

    # The total number of rounds in the race.
    @editable
    TotalRounds:type {Rounds:int where 1 <= Rounds} = 3

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)

        Players := GetPlayspace().GetPlayers()
        RecordCurrentRound(Players, TotalRounds)

        for:
            Index -> Player : Players
            CurrentRound := GetRound[]
            RecordPlayerFinishOrder[Player, Index]
            UpdateRound[Player, CurrentRound]
        do:
            Print("Recorded finish order {Index} and current round {CurrentRound} for player")

# When a player is removed from the race, reset their circuit to prevent their
# stats from showing up on billboards and player references.
OnPlayerRemoved(Player:player):void=
    # Reset circuit info when player leaves the game.
    if:
        ResetCircuitInfo[Player]
    else:
        Print("Unable to reset circuit info for player")
```
