# 2. Finding Players at Runtime

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-02-finding-players-at-runtime-in-verse
> **爬取时间**: 2025-12-27T00:22:06.284898

---

This section shows how to find players and teams at runtime that you set up earlier.

## Defining Class Members

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **triad\_infiltration\_game.verse** to open the script in Visual Studio Code.
2. At the top of the file, add `using { /Verse.org/Random }` to access the `Shuffle()` function. You'll use this to randomly shuffle teams of players before balancing. Also add `using { /Fortnite.com/FortPlayerUtilities }` to access the `Respawn()` function for players, which you'll use later to teleport players to their spawn areas at the start of the game.
    `using { /Fortnite.com/Devices }
   using { /Fortnite.com/FortPlayerUtilities }
   using { /Verse.org/Simulation }
   using { /Verse.org/Random }
   using { /UnrealEngine.com/Temporary/Diagnostics }`
3. In the `triad_infiltration_game` class definition, add the following fields:

   1. Three editable integers named `MaximumInfiltrators`, `MaximumAttackers`, and `MaximumDefenders`. Initialize `MaximumInfiltrators` to 2 and `MaximumAttackers` and `MaximumDefenders` to 4. These track the maximum number of players on each team, you'll use them to balance teams dynamically. You can change these numbers for testing purposes, and to create interesting variations in the game.
       `triad_infiltration := class(creative_device):
      # To avoid players not being able to join a team, you should set the maximum number
      # of players in the island settings to the sum of all of the Maximum(Team) variables.
      # Maximum number of players on the Infiltrators Team.
      @editable
      MaximumInfiltrators:int = 2
      # Maxmimum number of players on the Attackers Team.
      @editable
      MaximumAttackers:int = 4
      # Maximum number of players on the Defenders Team.
      @editable
      MaximumDefenders:int = 4`
   2. A variable [map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse) named `TeamsAndTotals`. This will map teams of players to the maximum number of players on that team.
       `# Maximum number of players on the Infiltrators Team.
      @editable
      MaximumInfiltrators:int = 2
      # Maxmimum number of players on the Attackers Team.
      @editable
      MaximumAttackers:int = 4
      # Maximum number of players on the Defenders Team.
      @editable
      MaximumDefenders:int = 4
      # Map of teams to their maximum number of players.
      var TeamsAndTotals:[team]int = map{}`
   3. An editable array of teleporters named `Teleporters`. This holds a reference to the teleporters which you'll use to teleport players to their spawns after team balancing.
       `# Map of teams to their maximum number of players.
      var TeamsAndTotals:[team]int = map{}
      # Array of Teleporters that teleport players to their team's spawn once the game starts.
      @editable
      Teleporters:[]teleporter_device = array{}`
   4. An editable `item_granter_device` array named `WeaponGranters`. This stores the item granters needed to grant players a weapon based on their team when they spawn.
       `# Array of Teleporters that teleport players to their team's spawn once the game starts.
      @editable
      Teleporters:[]teleporter_device = array{}
      # Array of weapon granters for each team.
      @editable
      var WeaponGranters:[]item_granter_device = array{}`
   5. Three optional `team` variables named `MaybeInfiltrators`, `MaybeAttackers`, and `MaybeDefenders`. These store a reference to each team to allow you to check that teams are set up correctly.
       `# Array of weapon granters for each team.
      @editable
      var WeaponGranters:[]item_granter_device = array{}
      # Reference to the infiltrators team.
      var MaybeInfiltrators:?team = false
      # Reference to the attackers team.
      var MaybeAttackers:?team = false
      # Rerfernece to the defenders team.
      var MaybeDefenders:?team = false`
   6. A variable array of teams named `Teams`. This holds a reference to all teams in the game, and you'll use this to set the optional team variables above as well as find teams to assign players to when balancing.
       `# Reference to the infiltrators team.
      var MaybeInfiltrators:?team = false
      # Reference to the attackers team.
      var MaybeAttackers:?team = false
      # Rerfernece to the defenders team.
      var MaybeDefenders:?team = false
      # Array of all teams in the game.
      var Teams:[]team = array{}`

## Finding Players and Teams at Runtime

1. In `OnBegin()`, update the `Teams` array with each team that you set up earlier in **Experience Settings**. You can use the `GetTeams()` function from the `fort_team_collection` API to get an array of all teams in the playspace.
    `OnBegin<override>()<suspends>:void =
   # Get all the Teams.
   set Teams = GetPlayspace().GetTeamCollection().GetTeams()`
2. Save a reference to each team by assigning `MaybeInfiltrators`, `MaybeAttackers`, and `MaybeDefenders` to their respective teams in the `Teams` array.
    `# Save the teams to later reference them.
   set MaybeInfiltrators = option{Teams[0]}
   set MaybeAttackers = option{Teams[1]}
   set MaybeDefenders = option{Teams[2]}`
3. Now you check if all three teams have been set up correctly. Because `MaybeInfiltrators`, `MaybeAttackers`, and `MaybeDefenders` are each an `option`, you can do this by checking if they contain a real value. If so, set the value of each team in `TeamsAndTotals` to the maximum number of players for that team.

   ```verse
        if:
            Infiltrators := MaybeInfiltrators?
            Attackers := MaybeAttackers?
            Defenders :=  MaybeDefenders?
            Logger.Print("Found all three teams")
            set TeamsAndTotals[Infiltrators] = MaximumInfiltrators
            set TeamsAndTotals[Attackers] = MaximumAttackers
            set TeamsAndTotals[Defenders] = MaximumDefenders
            Logger.Print("Set all three teams in TeamsAndTotals")
        else:
            Logger.Print("Couldn't find all teams, make sure to assign the correct teams in your island settings.")
   ```
4. Your `triad_infiltration_game` code should now look like:

   ```verse
        triad_infiltration_game := class(creative_device):

            Logger:log = log{Channel := triad_infiltration_log_channel}

            # To avoid players not being able to join a team, you should set the maximum number
            # of players in the island settings to the sum of all of the Maximum(Team) variables.

            # Maximum number of players on the Infiltrators Team.
            @editable
            MaximumInfiltrators:int = 2

            # Maxmimum number of players on the Attackers Team.
            @editable
            MaximumAttackers:int = 4

            # Maximum number of players on the Defenders Team.
            @editable
            MaximumDefenders:int = 4

            # Array of Teleporters that teleport players to their team's spawn once the game starts.
            @editable
            Teleporters:[]teleporter_device = array{}

            # Array of weapon granters for each team.
            @editable
            var WeaponGranters:[]item_granter_device = array{}

            # Array of player spawners for each team.
            @editable
            PlayersSpawners:[]player_spawner_device = array{}

            # Reference to the infiltrators team.
            var MaybeInfiltrators:?team = false

            # Reference to the attackers team.
            var MaybeAttackers:?team = false

            # Rerfernece to the defenders team.
            var MaybeDefenders:?team = false

            # Array of all teams in the game.
            var Teams:[]team = array{}

            # Map of teams to their maximum number of players.
            var TeamsAndTotals:[team]int = map{}

            OnBegin<override>()<suspends>:void =
                # Get all the Teams
                set Teams = GetPlayspace().GetTeamCollection().GetTeams()
                # Save the teams to later reference them
                set MaybeInfiltrators = option{Teams[0]}
                set MaybeAttackers = option{Teams[1]}
                set MaybeDefenders = option{Teams[2]}

                if:
                    Infiltrators := MaybeInfiltrators?
                    Attackers := MaybeAttackers?
                    Defenders :=  MaybeDefenders?
                    Logger.Print("Found all three teams")
                    set TeamsAndTotals[Infiltrators] = MaximumInfiltrators
                    set TeamsAndTotals[Attackers] = MaximumAttackers
                    set TeamsAndTotals[Defenders] = MaximumDefenders
                    Logger.Print("Set all three teams in TeamsAndTotals")
                else:
                    Logger.Print("Couldn't find all teams, make sure to assign the correct teams in your island settings.")
   ```
5. Save the script in Visual Studio Code, and in the Main Menu, under Verse, click **Build Verse Scripts** to update your Verse-authored device in the level.
6. Click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, all three teams should be set up in `TeamsAndTotals`. Verify this behavior with the log.

   [![Found All Three Teams](https://dev.epicgames.com/community/api/documentation/image/d1d8c4e2-9a87-4d58-9464-b45d81335763?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d1d8c4e2-9a87-4d58-9464-b45d81335763?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-03-balancing-teams-asymmetrically-in-verse) of this tutorial, you'll learn how to balance teams of players asymmetrically at the start of a game.
