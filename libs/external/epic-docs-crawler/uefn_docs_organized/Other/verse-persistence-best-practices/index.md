# Verse Persistence Best Practices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-persistence-best-practices
> **爬取时间**: 2025-12-27T00:03:21.585715

---

Persistable data allows you to track and save data per player between play sessions. Persistable data works by storing data for each individual player, such as their profile or stats, in Verse. This data can then be updated as many times as the data's value changes. Because this data is persistable, it will persist across game sessions and be available any time the player is online in the game. For more information, see [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse#what-persistence-means-in-verse).

This page covers some best practices when working with persistable data in Verse.

## Use Classes to Add New Fields Later

Currently the only type of persistable data that you can change after you publish your island is the `class` type, as long as new fields have default values. This means that loading saved data from a previous version will then include the new fields and their default values.

Let's look at an example of publishing a project with the following persistable data.

```verse
player_profile_data := class<final><persistable>:
    Class:player_class = player_class.Villager
    XP:int = 0
    Rank:int = 0
```

Since the project is published and live, players who have played the game will have this persistent data associated with them. If we added more fields to the player profile data, like quest count and history, the persistable data could then look like the following in the updated project.

```verse
player_profile_data := class<final><persistable>:
    Class:player_class = player_class.Villager
    XP:int = 0
    Rank:int = 0
    CompletedQuestCount:int = 0
    QuestHistory:[]string = array{}
```

The persistent data for any players who played with the first version of the `player_profile_data` class will now include the new fields:

- `CompletedQuestCount` with the value of `0`, which is the default value that was specified.
- `QuestHistory` with an empty string array, which is the default value that was specified.

This works because a default value was provided for the new fields to be able to update the older version of the data.

Because only classes may be updated after a project is published, we strongly recommend using a class as the value type of any module-scoped `weak_map` variable.

For more details on how to create a persistable class, see[Persistable Types](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse#persistable-types-in-verse).

## Using Constructors for Partial Updates

If you are using classes, we recommend using a [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/constructor-in-verse) to create a new instance of your class that contains the updated state, because constructors allow you to do partial updates of classes.

The following example shows how you can update the `PlayerProfileDataMap`. The `GrantXP()` function gets the current data of the given player and then calls the `MakePlayerProfileData()` constructor to make a new version of their profile data. Because the player's source data gets passed to the constructor along with the new XP value, only the XP value will get updated while all of the player's other data will remain the same.

```verse
MakePlayerProfileData<constructor>(Src:player_profile_data)<transacts> := player_profile_data:
    Version := Src.Version
    Class := Src.Class
    XP := Src.XP
    Rank := Src.Rank
    CompletedQuestCount := Src.CompletedQuestCount
    QuestHistory := Src.QuestHistory

GrantXP(Agent:agent, GrantedXP:int):void=
    if:
        CheckSaveDataForPlayer[Agent]
        Player := player[Agent]
        SourceData := PlayerProfileDataMap[Player]

        set PlayerProfileDataMap[Player] = player_profile_data:
            MakePlayerProfileData<constructor>(SourceData)
            XP := SourceData.XP + GrantedXP

CheckSaveDataForPlayer(Agent:agent)<decides><transacts>:void=
        if(Player := player[Agent]):
            if(PlayerProfileDataMap[Player]):
                # no-op
            else:
                set PlayerProfileDataMap[Player] = player_profile_data{}
```

The previous example showed how to update one field, but you can update as many as you need to in this way:

```verse
set PlayerProfileDataMap[Player] = player_profile_data:
    QuestHistory := UpdatedSaveData.QuestHistory
    CompletedQuestCount := OldData.CompletedQuestCount + 1
    MakePlayerProfileData<constructor>(OldData)
```

## Versioning Persistable Data

We recommend using versioning in persistable classes to detect the instance's version for data previously saved for a player. By using versions, you can detect and apply migrations if your persistable class definition or gameplay logic changes over time.

While you can use integer or string values to denote the version of your persistent class, we recommend using `option` values to store references to current and past versions of your data. Consider the following setup:

```verse
var SavedPlayerData:weak_map(player, player_data) = map{}

# A player data class containing optional fields of versioned player data. Only one of these
# optional values should contain a real value at any given time.
player_data := class<final><persistable>:
    V1:?v1_player_data = false
    V2:?v2_player_data = false

# Original version of player data.
v1_player_data := class<final><persistable>:
    XP:int = 0
    Rank:int = 0
    Playtime:int = 0

# Updated version of player data, where the Playtime field has been changed to a float and 
# two new fields have been added. 
v2_player_data := class<final><persistable>:
    XP:int = 0
    Rank:int = 0
    Playtime:float = 0.0
    CompletedQuestCount:int = 0
    QuestHistory:[]string = array{}
```

Here, the `player_data` class contains `option` values for both the first and second versions of the associated data class, which are represented by the `v1_player_data` and `v2_player_data` classes. Only one of `V1` or `V2` should ever be set to prevent players from having multiple versions of data associated with them.

The original `V1` player data contains three `int` fields. The `V2` version of the data changes the `Playtime` field to a `float`, as well as adding two new fields. Because the type of the `Playtime` field changed in the `V2` version, it will need to be converted for any player who still has the old `V1` data. When a player with old `V1` data joins an experience, you can use helper constructor functions to build a new `V2` data class based on their old data like so:

```verse
# Create v1_player_data using existing v1_player_data.
MakeV1PlayerData<constructor>(SourceData:v1_player_data)<transacts> := v1_player_data:
    XP := SourceData.XP
    Rank := SourceData.Rank
    Playtime := SourceData.Playtime

# Create v2_player_data using existing v2_player_data.
MakeV2PlayerData<constructor>(SourceData:v2_player_data)<transacts> := v2_player_data:
    XP := SourceData.XP
    Rank := SourceData.Rank
    Playtime := SourceData.Playtime
    CompletedQuestCount := SourceData.CompletedQuestCount
    QuestHistory := SourceData.QuestHistory

# Create v2_player_data using v1_player_data. Fields present in v2_player_data but not 
# v1_player_data will be initialized with v2_player_data defaults, and the Playtime field will be 
# converted from an int to a float.
MakeV2PlayerData<constructor>(SourceData:v1_player_data)<transacts> := v2_player_data:
    XP := SourceData.XP
    Rank := SourceData.Rank
    Playtime := SourceData.Playtime * 1.0
```

There may be times when you want to force a data reset for players joining your island. This can be done by reassigning a default value for the persistable data in the 'weak\_map' for all the players and changing the `Version` field of the class. If you use optional versioned data, you can reset data by setting the optional fields to `false`.

To know if the player's data has already been reset, you can check the `Version` value in the player's persistable data to see if it's the latest.

## Testing Persistent Data Is Within Limits

If your update can affect the persistent data's total size, you should verify that the persistent data still fits within Verse's persistence system constraints. If you try to update the persistable data and it exceeds the size limits, you will get a Verse runtime error. See[Max Persistent Object Size](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse#max-persistent-object-size) for more details.

You can check how your updates affect the total size by using the `FitsInPlayerMap()` function.

In the following example, the persistable data contains an array of strings. If that array ever gets too large to store in the `weak_map`, which happens when `FitsInPlayerMap()` fails, the example empties the array and only adds the most recent saved element.

```verse
# Construct and return a new player_profile_data with updated quest history.
SetQuestHistory(Src:player_profile_data, NewQuestHistory:[]string)<transacts>:player_profile_data =
    NewData:player_profile_data = player_profile_data:
        MakePlayerProfileData<constructor>(Src)
        QuestHistory := NewQuestHistory

# Set a player's quest history in the PlayerProfileDataMap. 
RecordQuestHistory(Agent:agent, QuestHistory:string):void=
    if:
        CheckSaveDataForPlayer[Agent]
        Player := player[Agent]
        SaveData := PlayerProfileDataMap[Player]
    then:
        if:
            # Copy and update the player's save data with the new QuestHistory.
            var UpdatedSaveData:player_profile_data = SaveData
            set UpdatedSaveData = SetQuestHistory(UpdatedSaveData, array{QuestHistory} + SaveData.QuestHistory)

            # Check if the updated data fits in the PlayerProfileDataMap.
            FitsInPlayerMap[UpdatedSaveData]
            set PlayerProfileDataMap[Player] = player_profile_data:
                MakePlayerProfileData<constructor>(SaveData)
                QuestHistory := UpdatedSaveData.QuestHistory
                CompletedQuestCount := SaveData.CompletedQuestCount + 1
        # If the new data is too big to fit in the player map, update the data until it fits.
        else:
            var TestUpdatedSaveData:player_profile_data = SaveData
            set TestUpdatedSaveData = SetQuestHistory(TestUpdatedSaveData, array{})
            var UpdatedSaveData:player_profile_data = TestUpdatedSaveData

            ProposedQuestHistory:[]string = array{QuestHistory} + SaveData.QuestHistory
            var DataFits:logic = true
            for (CurQuestHistory : ProposedQuestHistory, DataFits?):
                set TestUpdatedSaveData = SetQuestHistory(TestUpdatedSaveData, array{CurQuestHistory})
                if (FitsInPlayerMap[TestUpdatedSaveData]):
                    set UpdatedSaveData = SetQuestHistory(UpdatedSaveData, TestUpdatedSaveData.QuestHistory)

                if:
                    SourceData := PlayerProfileDataMap[Player]
                    set PlayerProfileDataMap[Player] = player_profile_data:
                        MakePlayerProfileData<constructor>(SourceData)
                        QuestHistory := UpdatedSaveData.QuestHistory
                        CompletedQuestCount := SourceData.CompletedQuestCount + 1
                set DataFits = false
```

## Reacting to Player Joining Your Island

When a new player joins your island, they will not have an entry automatically added to the persistable `weak_map`. You will have to add that entry in Verse.

To do this, you can either check whether a player is already in the `weak_map` whenever you access it, or you can add default data to the `weak_map` whenever a player joins, which you can know by subscribing to the game's `PlayerAddedEvent()` event.

```verse
GetPlayspace().PlayerAddedEvent().Subscribe(OnPlayerAdded)

# Later in your file
OnPlayerAdded(Player:player):void=
    if:
        not PlayerProfileDataMap[Player]
        set PlayerProfileDataMap[Player] = player_profile_data{}
```
