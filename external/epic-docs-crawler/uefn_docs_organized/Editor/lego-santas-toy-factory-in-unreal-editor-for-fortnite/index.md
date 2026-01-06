# LEGO® Santa's Toy Factory

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lego-santas-toy-factory-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:36:58.554258

---

This UEFN-only [template](https://dev.epicgames.com/documentation/en-us/fortnite/template) contains a small, factory-style game that features both **[persistence](https://dev.epicgames.com/documentation/en-us/fortnite/persistence)** and **[offline progression](https://dev.epicgames.com/documentation/en-us/fortnite/offline-progression)**.

The tutorials inside the template require basic knowledge of **Unreal Editor for Fortnite (UEFN)** and the ability to open a **Verse** file. There are no other requirements. The template itself provides the tutorial instructions.

Welcome to **Santa's Toy Factory**, a LEGO® template that focuses on player retention through engaging gameplay loops using:

- **Persistence:** Saving of player data between game sessions.
- **Offline progression:** The factory keeps producing toys even when the player is not in the game as long as there is room in the factory container while the candy cane forest keeps growing with or without players.

With both of these combined, you can also create daily mechanics that encourage players to continue returning to your island. Use this template to learn how to implement these mechanics on your own cozy holiday island!

The template contains three short tutorials.

- **Beginner**: Shows how to change the Candy Cane Forest growth time in Verse.
- **Intermediate**: Walks you through editing a variable in Verse.
- **Advanced**: Gets you to modify and add to the Verse code.

Each tutorial within the project shows you how to use Verse to accomplish the mechanics used.

The template is split into three parts:

- **Play:** Start by playing the game for 5–10 minutes to get a feel for how it works.
- **Create:** Next, you'll make three mods, following the challenges in the tutorial.
- **Explore:** Finally, you can explore on your own and take apart all the documented code to see how it works, then create your own game for the holidays!

[![Get the factory cranking out those toys!](https://dev.epicgames.com/community/api/documentation/image/1f2dfe5b-104d-4b93-9967-238883b006d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f2dfe5b-104d-4b93-9967-238883b006d2?resizing_type=fit)

## Play

1. From UEFN, load the template. You'll find it with the other LEGO templates.
   Start playing the game.
2. In-game, to follow the quest, walk up to Sir Pawlar, who will explain what to do.

   [![Sir Pawlar explains how to start!](https://dev.epicgames.com/community/api/documentation/image/1ebdd807-a8e2-4e1f-8f27-0b48f82077ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ebdd807-a8e2-4e1f-8f27-0b48f82077ae?resizing_type=fit)
3. Follow the instructions in the game.
4. At some point, the tutorial will ask you to end the game. Press **Esc**, then **End Game**.
5. Wait 2 minutes.
6. After the 2 minutes is up, press **Esc** again, then **Start Game**.

   [![Time to test offline production.](https://dev.epicgames.com/community/api/documentation/image/f0f29066-a41b-403f-9424-cde427885be4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f0f29066-a41b-403f-9424-cde427885be4?resizing_type=fit)

   This might seem like a strange thing to ask for, but it demonstrates a very important point. **In this game, things keep happening while you are not playing!** The factory keeps producing, and the candy cane forest keeps growing.

   These are key mechanics that can encourage players to come back to your game to harvest or collect crops that have grown or resources that have been produced over time.
7. When you come back to the game, you can see what was produced while you weren't in the game:

   [![See what your factory produced.](https://dev.epicgames.com/community/api/documentation/image/9faeae04-1e1b-4246-9b49-faa9ec6aeb6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9faeae04-1e1b-4246-9b49-faa9ec6aeb6e?resizing_type=fit)

   This is done in the **factory\_manager.verse** file. It measures how much time has passed while the player was away by using **persistent data** and the **Real Time Clock** device. It then calculates how much the factory would produce during that time.
8. After producing the second factory build, you will get a message to go back to UEFN.

   [![First tutorial is complete!](https://dev.epicgames.com/community/api/documentation/image/8c646142-98c9-4f25-a3a3-f2efdbb9ac41?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c646142-98c9-4f25-a3a3-f2efdbb9ac41?resizing_type=fit)

Your first tutorial is complete! Time to move on to the creative challenges.

## Create

Time for the fun stuff! You have three challenges waiting.

Locate the first one, **Freshman Flapjack**. He's waiting for you on one of the three yellow squares.

### Beginner Challenge: Modify Candy Cane Regrowth Time

The first challenge is straightforward. It will show you how much you can change the game just by tweaking some values — in this case, the regrowth time of the candy cane fields.

[![](https://dev.epicgames.com/community/api/documentation/image/d339938c-68a1-4577-823d-0da656bef631?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d339938c-68a1-4577-823d-0da656bef631?resizing_type=fit)

1. Next to Freshman Flapjack, you will see the **Candy Cane** Verse-authored device.
2. Select it and ensure you also have the **Details** panel selected.
3. Adjust the `CandyCaneRegrowthTime` parameter – experiment and see how it affects gameplay.

   [![Adjust the value for the candycanefield.](https://dev.epicgames.com/community/api/documentation/image/864a6ca4-4a2c-4530-b404-c3d72372b150?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/864a6ca4-4a2c-4530-b404-c3d72372b150?resizing_type=fit)

### Intermediate Challenge: Modify Upgrade Prices

The second challenge will take you into the Verse code itself.

[![Blubberchops explains your second challenge.](https://dev.epicgames.com/community/api/documentation/image/97fc8e59-b8f1-4f67-9997-fcf2e7348587?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97fc8e59-b8f1-4f67-9997-fcf2e7348587?resizing_type=fit)

Again, you will see how much you can change the pace and feeling of the game just by tweaking the prices for upgrading your factory.

1. Open the **upgrade\_config.verse** file from [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite).

   [![Open the Verse file upgrade_config.verse.](https://dev.epicgames.com/community/api/documentation/image/b8f99462-b587-4692-a551-cff5a1e20843?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8f99462-b587-4692-a551-cff5a1e20843?resizing_type=fit)
2. You can see all prices for upgrading the various factory elements. The first batch of prices are for the factory belts. There are four belts in the factory, so the table of prices contains four columns. Each row in the table is the price for upgrading a belt to that level.

   ```verse
        # This file contains the data used to configure the factory in the game.
        # This includes upgrade prices, max levels, production speeds, storage capacities and more.
        # It also contains functions for getting all this data.
   		
   		
        using { /Verse.org/Simulation }
        using { Persistence }
   		
   		
        # Blubberchops: "Looks like this is the place to modify the upgrade prices for belts."
        #               "Let's make them cheaper!"
   		
   		
        # Defines the upgrade price per level for each factory belt.
        FactoryBeltPrices: [][]int =
            # Each column is a belt.       0             1               2               3
            # Each row is a level.
            array{  array{                 5,           25,            500,          5000},
                    array{                25,          125,           2500,         25000},
                    array{               100,          500,          10000,        100000},
                    array{               200,         1000,          20000,        200000},
                    array{               300,         1500,          30000,        300000},
                    array{               400,         2000,          40000,        400000},
                    array{               500,         2500,          50000,        500000},
                    array{               750,         3750,          75000,        750000},
                    array{              1000,         5000,         100000,       1000000},
                    array{              1500,         7500,         150000,       1500000},
                    array{              2000,        10000,         200000,       2000000},
                    array{              2500,        12500,         250000,       2500000},
                    array{              3000,        15000,         300000,       3000000},
                    array{              4000,        20000,         400000,       4000000},
                    array{              5000,        25000,         500000,       5000000}}
   ```
3. Follow Blubberchops's advice and make the price for upgrading the belts less expensive. You can also experiment with increasing the price to make the pace of the game slower.
4. When you are ready, build the Verse code and push Verse changes to try out your changes.

   [![Build the Verse code then push the Verse changes.](https://dev.epicgames.com/community/api/documentation/image/c01d578a-a0e1-4680-980f-f7343b3b2fb7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c01d578a-a0e1-4680-980f-f7343b3b2fb7?resizing_type=fit)

   For more on what you're doing on this step, see [Modify and Run Your First Verse Program](https://dev.epicgames.com/documentation/en-us/uefn/modify-and-run-your-first-verse-program-in-unreal-editor-for-fortnite).
5. Note that every time you push changes to the session, the factory progress will be reset.

### Expert Challenge: The Daily Gift

The third and final challenge asks you to work on the **daily gift** next to Professor Flopkins.

[![Work on the gift device.](https://dev.epicgames.com/community/api/documentation/image/59c7d3f4-1af1-46e3-8b11-ff84c23c31bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/59c7d3f4-1af1-46e3-8b11-ff84c23c31bd?resizing_type=fit)

To do this, you will need to add some extra persistable data to store when the gift was last opened. You will also need to fix the logic in the **Daily Gift** Verse-authored device.

Look at [Using Persistable Data](https://dev.epicgames.com/documentation/en-us/uefn/using-persistable-data-in-verse) for more information on working with persistable data in Verse.

If you need a little help on this challenge, take a peek at the **Daily Gift Device**  section below!

1. Open the **player\_info.verse** file from Verse Explorer.

   [![Open the Verse player_info.verse file.](https://dev.epicgames.com/community/api/documentation/image/ff14be0b-9de0-4af5-9b2b-ddaaf83227db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff14be0b-9de0-4af5-9b2b-ddaaf83227db?resizing_type=fit)
2. Look for Professor Flopkins's comments near the top of the file.

   Make sure that you add a `date_and_time` array field to the `player_info` class for storing the last time the gift was opened. Also ensure that the field value is set in the `MakePlayerInfo` constructor.

   ```verse
    # This file defines player_info, the collection of persistable information stored for each player.
    # It also contains functions for creating, updating and returning information about a player.

    using { /Verse.org/Simulation }
    using { Config }
    using { Time }

    # Maps each player to their persisted information.
    var PlayerInfoMap:weak_map(player, player_info) = map{}

    # This tracks all persistable information for a player.
    player_info := class<final><persistable>:

        # The version of the current player info.
        Version:int = 0

        # Latest harvest times of all candy canes.
        CandyCaneHarvestTimes:[]date_and_time =  array{date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}}

        # The amount of gold the player has.
        Gold:int = 0

        # The state of the factory.
        FactoryBeltInfos:[]factory_belt_info = array{factory_belt_info{}, factory_belt_info{}, factory_belt_info{}, factory_belt_info{}}
        FactoryMouldInfos:[]factory_mould_info = array{factory_mould_info{}, factory_mould_info{}, factory_mould_info{}, factory_mould_info{}}
        FactoryWrapperInfos:[]factory_wrapper_info = array{factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}}
        FactoryStorageInfo:factory_storage_info = factory_storage_info{}

        # The current order.
        OrderNumber:int = 0
        OrderInfo:order_info = order_info{}

        # Professor Flopkins: "Hmm, we should store the date and time."
        #                     "Maybe we could use something similar to line 18?"

    # Creates a new player_info with the same values as the previous player_info.
    MakePlayerInfo<constructor>(Src:player_info)<transacts> := player_info:
        Version := Src.Version
        CandyCaneHarvestTimes := Src.CandyCaneHarvestTimes
        Gold := Src.Gold
        FactoryBeltInfos := Src.FactoryBeltInfos
        FactoryMouldInfos := Src.FactoryMouldInfos
        FactoryWrapperInfos := Src.FactoryWrapperInfos
        FactoryStorageInfo := Src.FactoryStorageInfo
        OrderNumber := Src.OrderNumber
        OrderInfo := Src.OrderInfo
        # Professor Flopkins: "We need to make sure to copy over the latest gift opening time"
        #                     "It should look completely similar to the other lines in this constructor."
   ```
3. Fix the functions for getting and setting the newly added field. This time, look for Professor Flopkins’s comments near the bottom of the file.

   Fill out the missing lines to make the functions behave correctly. You can look at some of the other functions in the file for inspiration.

   ```verse
    # This file defines player_info, the collection of persistable information stored for each player.
    # It also contains functions for creating, updating and returning information about a player.

    using { /Verse.org/Simulation }
    using { Config }
    using { Time }

    # Maps each player to their persisted information.
    var PlayerInfoMap:weak_map(player, player_info) = map{}

    # This tracks all persistable information for a player.
    player_info := class<final><persistable>:

        # The version of the current player info.
        Version:int = 0

        # Latest harvest times of all candy canes.
        CandyCaneHarvestTimes:[]date_and_time =  array{date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}}

        # The amount of gold the player has.
        Gold:int = 0

        # The state of the factory.
        FactoryBeltInfos:[]factory_belt_info = array{factory_belt_info{}, factory_belt_info{}, factory_belt_info{}, factory_belt_info{}}
        FactoryMouldInfos:[]factory_mould_info = array{factory_mould_info{}, factory_mould_info{}, factory_mould_info{}, factory_mould_info{}}
        FactoryWrapperInfos:[]factory_wrapper_info = array{factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}}
        FactoryStorageInfo:factory_storage_info = factory_storage_info{}

        # The current order.
        OrderNumber:int = 0
        OrderInfo:order_info = order_info{}

        # Professor Flopkins: "Hmm, we should store the date and time."
        #                     "Maybe we could use something similar to line 18?"

    # Creates a new player_info with the same values as the previous player_info.
    MakePlayerInfo<constructor>(Src:player_info)<transacts> := player_info:
        Version := Src.Version
        CandyCaneHarvestTimes := Src.CandyCaneHarvestTimes
        Gold := Src.Gold
        FactoryBeltInfos := Src.FactoryBeltInfos
        FactoryMouldInfos := Src.FactoryMouldInfos
        FactoryWrapperInfos := Src.FactoryWrapperInfos
        FactoryStorageInfo := Src.FactoryStorageInfo
        OrderNumber := Src.OrderNumber
        OrderInfo := Src.OrderInfo
        # Professor Flopkins: "We need to make sure to copy over the latest gift opening time"
        #                     "It should look completely similar to the other lines in this constructor."
   ```
4. With the the new functionality for the persistable data ready, open the **daily\_gift.verse** file to change the logic that makes the gift appear only once a day.

   [![Open the daily_gift.verse Verse file.](https://dev.epicgames.com/community/api/documentation/image/443dd058-e4ad-4d4f-bd79-8f28b19d2c51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/443dd058-e4ad-4d4f-bd79-8f28b19d2c51?resizing_type=fit)
5. You will see that there are two vital pieces missing:

   - Storing the current time when the gift is opened, and
   - Checking if the date has rolled over since the gift was last opened.

   Follow the professor’s comments and add the missing code.

   ```verse
    # When the gift is opened (harvested), give the selected player gold.
    OnHarvesting(Agent:agent):void=
        # Hide gift.
        set Opened = true
        PropManipulator.HideProps()

        # Show effect.
        spawn:
            ShowGiftEffect()

        # Play audio.
        GiftOpenAudioPlayer.Play()

        # Give player some gold and store opening time.
        if:
            SelectedPlayer := MaybeSelectedPlayer?
            GrantGold[SelectedPlayer, Gold]

            # Professor Flopkins: "Looks like the code to store the opening time is missing!"
            #                     "First, we should get the current date and time."
            #                     "Look in the IsDateRolledOver function for a hint on how to do this."

            # Professor Flopkins: "And then, we should store that time in the persistable player data."
            #                     "I saw a function for doing this in the bottom of player_info.verse."

           
        then:
            # Update all players' UI.
            UIManager.UpdateAllPriceUIs()
            UIManager.UpdateAllResourceUIs()
   ```

   ```verse
    # Succeeds if the current date is different from the opening time.
    IsDateRolledOver()<decides><transacts>:void=
        # Get the current date.
        Now := RealTime.GetDateAndTime()

        # Professor Flopkins: "Hmm, the code to determine if the date has rolled over is also missing."
        #                     "Let's see.. first we'll get the selected player."
        #                     "Look in the OnHarvesting function to see how to do that."

        # Professor Flopkins: "Now, we should retrieve the last date and time the gift was opened."
        #      "There is a function for doing this in player_info.verse."

        # Professor Flopkins: "Finally, we should compare that date with the current date."
        #       "We want the year, month or date to be different as that means the date"
        #       "has rolled over."
   ```
6. You are now ready to test your solution! Build the Verse code and push the Verse changes to try it in your session.

You can use **Sub Zero's debug button** as a shortcut for skipping ahead in time to test if the gift respawns when the date changes.

## Explore

Now that you've met your challenges, time to explore some of the other devices used in this template.

### Real Time Clock Device

The [Real Time Clock](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-real-time-clock-devices-in-fornite-creative) device gives you the current time in **Coordinated Universal Time (UTC)**. It also animates the hands of a clock.

You can use it for driving events that should happen at a certain time each day or to keep track of how much time has passed.

It comes with a built-in test function that can offset the current time. Check out the **real\_time\_device.verse** file, the **date\_and\_time.verse** and **time\_interval.verse** files.

[![Real Time device instructions.](https://dev.epicgames.com/community/api/documentation/image/cfa819bf-f0c3-4af6-a690-6778fe89c54a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cfa819bf-f0c3-4af6-a690-6778fe89c54a?resizing_type=fit)

### Candy Cane Field Device

The **Candy Cane Field** Verse-authored device keeps track of a field of harvestable candy canes. It provides resources when they are harvested and makes them regrow over time. You can use it for all kinds of regrowing resources. Check out the **candy\_cane\_field.verse** file.

[![Candy Cane Field device instructions.](https://dev.epicgames.com/community/api/documentation/image/25463972-bc01-4ed6-b092-39bab5469cb3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/25463972-bc01-4ed6-b092-39bab5469cb3?resizing_type=fit)

### Persistence Module

This module holds all the persistable data associated with each player. The main class is the `player_info` class in the **player\_info.verse** file.

This file also contains all the functions for reading and manipulating the data. You should also check out the other classes in the module – they each define some of the data stored for each player. You can modify them or add more data to suit your needs.

```verse
# This file defines player_info, the collection of persistable information stored for each player.
# It also contains functions for creating, updating and returning information about a player.
using { /Verse.org/Simulation }
using { Config }
using { Time }
# Maps each player to their persisted information.
var PlayerInfoMap:weak_map(player, player_info) = map{}
# This tracks all persistable information for a player.
player_info := class<final><persistable>:
    # The version of the current player info.
    Version:int = 0
    # Latest harvest times of all candy canes.
    CandyCaneHarvestTimes:[]date_and_time =  array{date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}}
    # The amount of gold the player has.
    Gold:int = 0
    # The state of the factory.
    FactoryBeltInfos:[]factory_belt_info = array{factory_belt_info{}, factory_belt_info{}, factory_belt_info{}, factory_belt_info{}}
    FactoryMouldInfos:[]factory_mould_info = array{factory_mould_info{}, factory_mould_info{}, factory_mould_info{}, factory_mould_info{}}
    FactoryWrapperInfos:[]factory_wrapper_info = array{factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}}
    FactoryStorageInfo:factory_storage_info = factory_storage_info{}
    # The current order.
    OrderNumber:int = 0
    OrderInfo:order_info = order_info{}
```

### Daily Gift Device

This device spawns a daily gift — or at least it would if it were working!

Here's a solution to the **expert challenge** to help you make full use of the Daily Gift Verse-authored device. You can use it to perform all kinds of daily events and rewards.

1. Start by adding the required data to the `player_info` class and modify the `MakePlayerInfo` constructor in the **player\_info.verse** file:

   ```verse
        # This tracks all persistable information for a player.
        player_info := class<final><persistable>:

            # The version of the current player info.
            Version:int = 0

            # Latest harvest times of all candy canes.
            CandyCaneHarvestTimes:[]date_and_time =  array{date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}, date_and_time{}}

            # The amount of gold the player has.
            Gold:int = 0

            # The state of the factory.
            FactoryBeltInfos:[]factory_belt_info = array{factory_belt_info{}, factory_belt_info{}, factory_belt_info{}, factory_belt_info{}}
            FactoryMouldInfos:[]factory_mould_info = array{factory_mould_info{}, factory_mould_info{}, factory_mould_info{}, factory_mould_info{}}
            FactoryWrapperInfos:[]factory_wrapper_info = array{factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}, factory_wrapper_info{}}
            FactoryStorageInfo:factory_storage_info = factory_storage_info{}

            # The current order.
            OrderNumber:int = 0
            OrderInfo:order_info = order_info{}

            # Latest time the daily gift was opened.
            GiftOpeningTime:date_and_time = date_and_time{}

        # Creates a new player_info with the same values as the previous player_info.
        MakePlayerInfo<constructor>(Src:player_info)<transacts> := player_info:
            Version := Src.Version
            CandyCaneHarvestTimes := Src.CandyCaneHarvestTimes
            Gold := Src.Gold
            FactoryBeltInfos := Src.FactoryBeltInfos
            FactoryMouldInfos := Src.FactoryMouldInfos
            FactoryWrapperInfos := Src.FactoryWrapperInfos
            FactoryStorageInfo := Src.FactoryStorageInfo
            OrderNumber := Src.OrderNumber
            OrderInfo := Src.OrderInfo
            GiftOpeningTime := Src.GiftOpeningTime
   ```
2. Fill in the `SetGiftOpeningTime` and `GetGiftOpeningTime` functions:

   ```verse
        # Sets the gift opening time for the player.
        SetGiftOpeningTime<public>(Player:player, GiftOpeningTime:date_and_time)<decides><transacts>:void=
            CheckPlayerInfoForPlayer[Player]
            SourceInfo := PlayerInfoMap[Player]

            set PlayerInfoMap[Player] = player_info:
                MakePlayerInfo<constructor>(SourceInfo)
                GiftOpeningTime := GiftOpeningTime

        # Gets the gift opening time for the player.
        GetGiftOpeningTime<public>(Player:player)<decides><transacts>:date_and_time=
            CheckPlayerInfoForPlayer[Player]
            PlayerInfoMap[Player].GiftOpeningTime
   ```
3. Turn your attention to the `daily_gift` class in the **daily\_gift.verse** file. First, fill in the storing of the current time when opening the gift:

   ```verse
        # When the gift is opened (harvested), give the selected player gold.
        OnHarvesting(Agent:agent):void=
            # Hide gift.
            set Opened = true
            PropManipulator.HideProps()
   		
            # Show effect.
            spawn:
                ShowGiftEffect()
   		
            # Play audio.
            GiftOpenAudioPlayer.Play()
   		
            # Give player some gold and store opening time.
            if:
                SelectedPlayer := MaybeSelectedPlayer?
                GrantGold[SelectedPlayer, Gold]
   		
                Now := RealTime.GetDateAndTime()
                SetGiftOpeningTime[SelectedPlayer, Now]
   		        
            then:
                # Update all players' UI.
                UIManager.UpdateAllPriceUIs()
                UIManager.UpdateAllResourceUIs()
   ```
4. Implement the `IsDateRolledOver` function:

   ```verse
       # Succeeds if the current date is different from the opening time.
       IsDateRolledOver()<decides><transacts>:void=
           # Get the current date.
           Now := RealTime.GetDateAndTime()

           SelectedPlayer := MaybeSelectedPlayer?
           GiftOpeningTime := GetGiftOpeningTime[SelectedPlayer]
           Now.Years <> GiftOpeningTime.Years or Now.Months <> GiftOpeningTime.Months or Now.Days <> GiftOpeningTime.Days
   ```

### Factory Manager Device

The **Factory Manager** Verse-authored device initializes and runs the factory. It handles the calculation of how many products were made while the player was away.

This calculation can be complex since the factory storage is shared between multiple factory belts. In a simpler setup, you could calculate the number of products made by calculating how much time has passed since the last production, then dividing that with the production speed.
