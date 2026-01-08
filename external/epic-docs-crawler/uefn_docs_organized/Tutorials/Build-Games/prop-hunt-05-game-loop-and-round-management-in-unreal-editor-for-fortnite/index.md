# 5. Game Loop and Round Management

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-05-game-loop-and-round-management-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:23:32.739576

---

## Setting Up Teams

In this section, you’re learning to set up the Hunter and Prop teams at the start of the game and teleport them to their starting areas.

This page includes Verse snippets that show how to execute gameplay mechanics needed in this gameplay. Follow the steps below and copy the full script on [step 6](https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite) of this tutorial.

Follow these steps to set your teams up correctly:

1. Create a new function SetupTeams(). Here you’ll set up multiple subscriptions to functions you’ll define later, such as functions for when a prop is eliminated, or what to do when a player joins the game.

   ```verse
        # When a round is started, subscribe to team devices, randomly pick the hunter agents, enable the hunter timer, set the prop agents, and teleport them into the game area.
        SetUpTeams()<suspends>:void =
            Logger.Print("Setting up teams.")
   ```

2. First subscribe to the prop team’s score timer SuccessEvent, the prop team TeamManager’s Eliminated Event, and set the score manager’s score awarded.

   ```verse
                                # When a round is started, subscribe to team devices, randomly pick the hunter agents, enable the hunter timer, set the prop agents, and teleport them into the game area.
                                SetUpTeams()<suspends>:void =
                                    Logger.Print("Setting up teams.")

                                    # Subscribe to the prop team score timer, set the score award, and subscribe to the prop team's eliminated event.
                                    PropTeam.ScoreTimer.SuccessEvent.Subscribe(PropTeam.OnPropsScore)
                                    PropTeam.ScoreManager.SetScoreAward(PropTeam.ScorePerSecond)
                                    PropTeam.TeamManager.TeamMemberEliminatedEvent.Subscribe(OnPropEliminated) # Occurs when a prop agent is eliminated.
   ```

3. Next, do the same for the hunter team. Then set the hunter team’s wait timer to the spawn delay you want for the hunters.

   ```verse
                                # When a round is started, subscribe to team devices, randomly pick the hunter agents, enable the hunter timer, set the prop agents, and teleport them into the game area.
                                SetUpTeams()<suspends>:void =
                                    Logger.Print("Setting up teams.")

                                    # Subscribe to the prop team score timer, set the score award, and subscribe to the prop team's eliminated event.
                                    PropTeam.ScoreTimer.SuccessEvent.Subscribe(PropTeam.OnPropsScore)
                                    PropTeam.ScoreManager.SetScoreAward(PropTeam.ScorePerSecond)
                                    PropTeam.TeamManager.TeamMemberEliminatedEvent.Subscribe(OnPropEliminated) # Occurs when a prop agent is eliminated.

                                    # Subscribe to the hunter team's wait timer and set the duration. Also, subscribe to the hunter team's elimination event.
                                    HunterTeam.WaitTimer.SuccessEvent.Subscribe(HuntersGo)
                                    HunterTeam.WaitTimer.SetMaxDuration(HunterTeam.SpawnDelay)
                                    HunterTeam.TeamManager.EnemyEliminatedEvent.Subscribe(OnHunterEliminated) # Occurs when a hunter agent eliminates a prop agent.
   ```

4. Still within `SetupTeams()`, initialize the starting hunter and prop agents arrays, then enable the waiting HUD while you check if there are enough players to start the game. If there are, disable the waiting HUD.

   ```verse
                                # Initialize the starting hunter and prop agents arrays. Get the players and find the number of players in the server
                                var StartingHunterAgents:[]agent = array{}
                                var StartingPropAgents:[]agent = array{}
                                var Players:[]player = GetPlayspace().GetPlayers()
           
                                # Enable the HUD appropriate for waiting for players.
                                HUDControllerWaiting.Enable()
           
                                # Check if there are enough players to start the round.
                                set Players = WaitingForMorePlayers.WaitForMinimumNumberOfPlayers(Players)
                                Logger.Print("Round started.")
           
                                # Disable the waiting HUD to use the next highest priority HUD.
                                HUDControllerWaiting.Disable()
   ```

5. Now that the round has started, you need to handle what happens when a player joins or is removed from the match. You’ll set up the subscriptions here and define these functions later.

   ```verse
                                # Now that the round has started, we need to handle players being added or removed from the match. Subscribe to those events.
                                GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)
                                GetPlayspace().PlayerRemovedEvent().Subscribe(OnPlayerRemoved)
   ```

6. The number of starting hunters is based on how many players are in your game. You don’t want one hunter to have to deal with ten players, so you’ll set up a function that sets the number of hunters based on a formula. Convert the number of players to a float to use in the formula.

   ```verse
                                # Calculate the number of starting hunter agents for the game based on the player count and the number of hunter agents per number of players.
                                NumberOfPlayers:float = 1.0 * Players.Length # Converts Players.Length to a float so it can be used in the next Ceil function.
   ```

7. Now set the number of starting hunters to the ceiling of the following formula. Then shuffle the array of all players, since you want the initial hunters to be randomly chosen from the player list.

   ```verse
                                # Calculate the number of starting hunter agents for the game based on the player count and the number of hunter agents per number of players.
                                NumberOfPlayers:float = 1.0 * Players.Length # Converts Players.Length to a float so it can be used in the next Ceil function.
           
                                if (NumberOfStartingHunters:int = Ceil[NumberOfPlayers / Max(1.1, HunterTeam.HunterAgentPerNumberOfPlayers)]):
                                    # Shuffle the players and then slice the array to get the starting hunter agents. The remaining players are the starting prop agents. 
                                    var RandomizedPlayers:[]agent = Shuffle(Players)
   ```

8. Slice the randomized array to a size between 0 and your number of starting hunters. This will be the initial hunter's team, so set it to StartingHunterAgents. The rest of the players will be the initial prop team, so set them to StartingPropAgents.

   ```verse
                                # Calculate the number of starting hunter agents for the game based on the player count and the number of hunter agents per number of players.
                                NumberOfPlayers:float = 1.0 * Players.Length # Converts Players.Length to a float so it can be used in the next Ceil function.
           
                                if (NumberOfStartingHunters:int = Ceil[NumberOfPlayers / Max(1.1, HunterTeam.HunterAgentPerNumberOfPlayers)]):
                                    # Shuffle the players and then slice the array to get the starting hunter agents. The remaining players are the starting prop agents. 
           
                                    var RandomizedPlayers:[]agent = Shuffle(Players)
                                    if (set StartingHunterAgents = RandomizedPlayers.Slice[0,NumberOfStartingHunters]) {}
           
                                    if (set StartingPropAgents = RandomizedPlayers.Slice[NumberOfStartingHunters,RandomizedPlayers.Length]) {}
                                    # Iterate through the starting hunter agents and assign them to the hunter team. Then start the hunter wait timer.
                                    Logger.Print("Setting {StartingHunterAgents.Length} hunter agent(s).")
           
                                    for (StartingHunterAgent : StartingHunterAgents): HunterTeam.InitializeAgent(StartingHunterAgent)
                                        HunterTeam.WaitTimer.Start()
           
                                        # Iterate through the starting prop agents and assign them to the prop team. Teleport them into the play area.
                                        Logger.Print("Setting {StartingPropAgents.Length} prop agent(s).")
   ```

9. With the teams set, enable the lobby teleporter to teleport the props out of the starting room, and activate their HeartBeat. Then disable the lobby teleporter since you don’t need it after this. Finally set the number of props remaining in the PropsRemainingTracker to the size of the props team.

   ```verse
                                LobbyTeleporter.Enable()
           
                                for (StartingPropAgent : StartingPropAgents):
                                    PropTeam.InitializeAgent(StartingPropAgent)
           
                                    PropTeam.HeartBeat.SetUpUI(StartingPropAgent)
           
                                    LobbyTeleporter.Activate(StartingPropAgent)
           
                                    LobbyTeleporter.Disable()
           
                                    # Set the props remaining tracker's Target and Value to the current number of props.
                                    # In the future, we'll only update Value as props are eliminated.
                                    PropTeam.PropsRemainingTracker.SetTarget(PropTeam.Count())
                                    PropTeam.UpdatePropsRemainingTracker()
   ```

## Managing Player Eliminations

The hunters win by eliminating all props and converting them to hunters. Follow these steps to award hunters a score when a prop is eliminated, and to transfer eliminated props to the hunters’ team.

1. Create a function named OnHunterEliminated(). You subscribed the hunter team manager device EnemyEliminatedEvent to this earlier, so this will activate whenever a hunter eliminates a prop.

   ```verse
        # When a hunter agent eliminates a prop agent, award score. The score is divided by the number of prop agents remaining.
        OnHunterEliminated(HunterAgent:agent):void =
        Logger.Print("Hunter agent eliminated a prop agent.")
   ```

2. You first need to award the hunters a score proportional to the number of prop agents remaining. Create a variable `EliminationAward` equal to the `MaxEliminationScore` divided by the `PropTeamSize`. Set the hunter team score manager to that score, then award to the hunter who scored the elimination.

   ```verse
                                # When a hunter agent eliminates a prop agent, award score. The score is divided by the number of prop agents remaining.
                                OnHunterEliminated(HunterAgent:agent):void =
                                    Logger.Print("Hunter agent eliminated a prop agent.")
           
                                    PropTeamSize := PropTeam.Count()
           
                                    if (EliminationAward := Floor(HunterTeam.MaxEliminationScore / PropTeamSize)):
                                        Logger.Print("Awarding {EliminationAward} points.")
                                        HunterTeam.ScoreManager.SetScoreAward(EliminationAward
                                        HunterTeam.ScoreManager.Activate(HunterAgent)
   ```

3. You also need to handle what happens to the prop team when a prop is eliminated. Create a function named OnPropEliminated(). Like OnHunterEliminated(), you subscribed to this function earlier. When a prop is eliminated, you need to remove it from the prop team using the PropTeam’s EliminateAgent() function, then initialize them as a hunter with the HunterTeam’s InitializeAgent() function.

   ```verse
                                # When a prop agent is eliminated, remove the prop from the prop team, check for round end, and set them as a hunter.
                                OnPropEliminated(PropAgent:agent):void =
                                    Logger.Print("Prop agent eliminated.")
                                    spawn{ PropTeam.EliminateAgent(PropAgent) }
           
                                    HunterTeam.InitializeAgent(PropAgent)
   ```

## Managing Players Joining and Leaving Game

When a player joins the game mid-round, you want them to spawn as a hunter.

1. Create a function OnPlayerAdded() to handle this. This function just initializes the player who joins as a hunter.

   ```verse
        # When a player joins the match mid-round, make them a hunter.
        OnPlayerAdded(Player:player):void =
            Logger.Print("A player joined the game.")
            HunterTeam.InitializeAgent(Player)
   ```

2. Players leaving the match is a little more complicated. If a player leaves the match we need to remove them from the team they’re on, and also check if their leaving causes the game to end. This could be either because the player who leaves was the last prop or the only hunter. This logic is handled by the EliminateAgent() functions on each team, so you’ll spawn an instance of those depending on which team the removed player was from.

   ```verse
        # When a player leaves the match, check which team they were on and then check for the round end.
        OnPlayerRemoved(Player:player):void=
            Logger.Print("A player left the game.")
     
            if (PropTeam.FindOnTeam[Player]):
                Logger.Print("Player was a Prop.")
                spawn{ PropTeam.EliminateAgent(Player) }
     
            if (HunterTeam.FindOnTeam[Player]):
                Logger.Print("Player was a Hunter.")
                spawn{ HunterTeam.EliminateAgent(Player) }
   ```

## Round End

Once all the teams are set up, you need to monitor the size of each team to check for the end of the round. The game ends once either team is empty, or when the round time runs out, so you’ll use a race expression to see which comes first.

1. At the end of your OnBegin() function, in a race expression, Await() both the hunter and prop team’s TeamEmptyEvent, and the RoundTimer’s AwaitEnd() function. Once the race ends, call the EndRound() function which you’ll define in the next step.

   ```verse
        # When there are no more prop or hunter agents (whichever happens first), or the round timer finishes, or the round ends
        race: 
            PropTeam.TeamEmptyEvent.Await()
            HunterTeam.TeamEmptyEvent.Await()
            RoundTimer.AwaitEnd()
        Logger.Print("Round ending.")
        EndRound()
   ```

2. In the EndRound() function, you need to disable the heartbeat sensor for each player on the prop team, and call EndRound() on the RoundSettings device. Because the EndRound() function on the RoundSettings device requires a player to be passed to it, get the first player in the Players array, and pass them as the instigator.

   ```verse
        # Cleans up the heartbeat VFX and then ends the round.
        EndRound():void=
            PropTeam.HeartBeat.DisableAll()
         
            # Get any player to pass to EndRound
            Players:[]player = GetPlayspace().GetPlayers()
         
            if (RoundEndInstigator := Players[0]):
                Logger.Print("Round ended.")
                RoundSettings.EndRound(RoundEndInstigator)
   ```

## Next Section

[![6. Adding the Full Script](https://dev.epicgames.com/community/api/documentation/image/3fb872fd-5229-440c-b545-5b9168b720b2?resizing_type=fit&width=640&height=640)

1. Adding the Full Script

Use these devices to customize the gameplay experience in Unreal Editor for Fortnite.](<https://dev.epicgames.com/documentation/en-us/fortnite/prop-hunt-06-adding-the-full-script-in-unreal-editor-for-fortnite>)
