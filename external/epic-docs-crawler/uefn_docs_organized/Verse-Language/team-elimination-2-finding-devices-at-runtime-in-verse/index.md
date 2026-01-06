# 2. Finding Devices at Runtime

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-2-finding-devices-at-runtime-in-verse
> **爬取时间**: 2025-12-27T00:18:57.903387

---

This section shows how to find the devices at runtime that you set up earlier.

1. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **team\_elimination\_game.verse** to open the script in Visual Studio Code.
2. At the top of the file:

   - Add `using { /Fortnite.com/Game }` to reference the `elimination_result` [struct](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary).
   - Add `using { /Fortnite.com/Characters }` to use the `GetFortCharacter[]` [API](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#api).

     ```verse
       using { /Fortnite.com/Characters }
       using { /Fortnite.com/Devices }
       using { /Fortnite.com/Game }
       using { /Fortnite.com/Teams }
       using { /Verse.org/Simulation }
     ```
3. In the `team_elimination_game` class definition, add the following fields:

   - An [editable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#editable) `item_granter_device` [array](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) named `WeaponGranters` to store all the item granters needed to grant weapons to players.

     ```verse
       @editable
       var WeaponGranters : []item_granter_device = array{}
     ```
   - An integer variable named `EliminationsToEndGame` to represent the number of eliminations needed for one player to win for their team. A team wins once one of their players advances past the final weapon in the sequence.

     ```verse
       var EliminationsToEndGame : int = 0
     ```
   - An editable `end_game_device` named `EndGameDevice` to end the game once a team reaches `EliminationsToEndGame`.

     ```verse
       @editable
       EndGameDevice : end_game_device = end_game_device{}
     ```
   - An editable `sentry_device` array variable named `Sentries` to store the sentries for testing eliminations.

     ```verse
       @editable
       var Sentries : []sentry_device = array{}
     ```
   - An editable `player_spawner_device` array variable named `PlayerSpawners` to store the player spawn pads for both teams.

     ```verse
       @editable
       var PlayerSpawners : []player_spawner_device = array{}
     ```
   - A team array variable named `Teams` to store a reference to each team in the game.

     ```verse
       var Teams : []team = array{}
     ```
   - Your `team_elimination_game` class definition should now look like the code below:

     ```verse
       team_elimination_game := class(creative_device):
           @editable
           EndGameDevice : end_game_device = end_game_device{}
           @editable
           var WeaponGranters : []item_granter_device = array{}
           @editable
           var PlayerSpawners : []player_spawner_device = array{}
           @editable
           var Sentries : []sentry_device = array{}
           var EliminationsToEndGame : int = 0
           var Teams : []team = array{}
     ```
4. In `OnBegin()`, update the `Teams` array with each team that you set up earlier in **Island Settings**. You can use the `GetTeams()` function from the `fort_team_collection` API to get an array of all teams in the playspace.

   ```verse
        OnBegin<override>()<suspends> : void =
            # Get all the players
            set Teams = GetPlayspace().GetTeamCollection().GetTeams()
   ```
5. Set the `EliminationsToEndGame` to the length of `WeaponGranters`. This ensures that the game only ends once a player progresses past the final weapon. Your `OnBegin()` code should now look like the code below:

   ```verse
       OnBegin<override>()<suspends> : void =
           # Get all the players
           set Teams = GetPlayspace().GetTeamCollection().GetTeams()
           set EliminationsToEndGame = WeaponGranters.Length
           Print("Number of eliminations to end game is {EliminationsToEndGame}")
   ```
6. Save the script in Visual Studio Code, and in the UEFN toolbar, click **Verse**, then **Build Verse Code** to update your Verse-authored device in the level.
7. Select the **team\_elimination\_game** device. In the **Details** panel, add each **Item Granter** to the **WeaponGranters** array, each **Player Spawn Pad** to the **PlayerSpawners** array, each **Sentry** to **Sentries**, and the **End Game Device** to **EndGameDevice.**

   [![Populated Arrays in the Verse device](https://dev.epicgames.com/community/api/documentation/image/6eff15d8-b31e-4aca-a0a6-b04fd847f5ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6eff15d8-b31e-4aca-a0a6-b04fd847f5ef?resizing_type=fit)

   The order in which you add the item granters is important! Make sure the order in the **Details** panel matches the order you want your players to progress through weapons in game.
8. Click **Launch Session** in the UEFN toolbar to playtest the level. When you playtest your level, `EliminationsToEndGame` should be equal to the length of your `WeaponGranters` array. Verify this behavior with the log.

   [![Number of Elminations to End Game](https://dev.epicgames.com/community/api/documentation/image/7c7fb42f-544d-4c3f-98b5-728594c44a73?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7c7fb42f-544d-4c3f-98b5-728594c44a73?resizing_type=fit)

## Next Step

In the [next step](https://dev.epicgames.com/documentation/en-us/fortnite/team-elimination-3-subscribing-to-player-events-in-verse) of this tutorial, you’ll learn how to assign players a weapon at the start of the game and subscribe to their spawn events.
