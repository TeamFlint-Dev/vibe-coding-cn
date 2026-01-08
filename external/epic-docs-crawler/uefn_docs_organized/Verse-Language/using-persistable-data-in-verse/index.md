# Using Persistable Data in Verse

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse>
> **爬取时间**: 2025-12-27T00:02:52.984334

---

By using persistable data, you can track and save data per player between play sessions. This opens a variety of progressional game modes where players can leave and then come back to resume their objectives or see the same state of the game as when they left.

Persistable data works by storing data for each individual player, such as their profile or stats, in Verse. This data can then be updated as many times as the data's value changes. Because this data is persistable, it will persist across game sessions and be available any time the player is online in the game.

Survival, Tycoon, RPGs, and Roguelites are some examples of game modes that utilize persistable data. These types of game modes require players to accumulate items that satisfy long-term goals that drive gameplay.

Use persistable data in your **Verse** scripts to store information that is saved on a per-player, per-[module](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#module) basis. Implement persistable data on game modes where you would like to retain players by incentivizing continuous progression.

To practice implementing persistence yourself, check out the [Persistent Player Statistics Tutorial](https://dev.epicgames.com/documentation/en-us/fortnite/persistent-player-statistics-in-unreal-editor-for-fortnite).

Though persistable data can be created and used in Verse, there are also **Creative** devices that have basic functionality that supports persistable data. For more details, see [Persistence Devices](https://dev.epicgames.com/documentation/en-us/fortnite/persistence-devices-in-unreal-editor-for-fortnite).

## What Persistence Means in Verse

In Verse, a [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) defined in a [module](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse) is global to any game instance running where the variable is in [scope](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#scope). Except for module-scoped variables associated with the [`session`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/simulation/session), a module-scoped variable requires persistence, the storing of data beyond the current game. Because of this, there are restrictions on what types are possible to use at module scope.

Currently, you can use the following types at module scope:

| Allowed Module-Scope Types | Definition | Restrictions |
| --- | --- | --- |
| `weak_map(session, t)` | Data of any type represented by `t` can be stored and accessed during the current game session. The only available `session` value is the current game session, and only supporting `weak_map(session, t)` allows for using the current server as the scope of the information. | Data is only stored during the current session and does not persist across subsequent rounds. |
| `weak_map(player, t)` | Data of any type represented by `t` that is [persistable](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) can be stored and accessed for a particular player and the data can be visible to subsequent game sessions. Whenever a player joins a game, their previous saved data is loaded into all module-scoped variables of type `weak_map(player, t)`. | Accessing the player's persistent data is only allowed when the player is in the current game. |

If a player leaves a game or is not in the current session, you can no longer store or access their data in that game session. If the player returns or plays the same game again, then you can access and update their data.

## Creating Persistable Data in Verse

You can create your own persistable data for each player that can be continuously updated, stored, and recalled whenever players rejoin the game. During matchmaking, the game will check for persistable data for the new player. If the player has available persistable data, the data is loaded and made available to Verse scripts.

If the player has persistable data for an island and the data load fails, the player will not be able to join the island. This is a protective measure that will prevent persistable data from being overwritten in the case of a data load failure.

To create persistable data in your Verse code, define a global [weak\_map](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) variable that uses the `player` type as the key and a persistable type as the value. See [Persistable Types](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) for the full list of types that can be persistable.

In the following example, the global 'weak\_map' variable **MySavedPlayerData** uses the player type as the [key](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#key-value-pair) and an integer as the value. Storing an integer value for a player in this variable means the data will persist across game sessions and can be accessed and updated at any time when the player is in the game.

```verse
var MySavedPlayerData:weak_map(player, int) = map{}
```

Once you've defined your persistable data, you'll need to initialize the data for each player. You can do this by checking to see if there's not already data stored for that player and then adding the player and an initial value to the `weak_map`.

```verse
# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void =
    InitialSavedPlayerData:int = 0
    Players := GetPlayspace().GetPlayers()
    for (Player : Players):
        if:
            not MySavedPlayerData[Player]
            set MySavedPlayerData[Player] = InitialSavedPlayerData
```

The previous example only stored one integer value but you can use other types, like classes and arrays, to store more data for each player in the `weak_map`. See [Persistable Types](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) for the full list of types that you can use.

The following Verse example shows how you can define a custom player profile in a class that can be stored, updated, and accessed later for a player. The class `player_profile_data` stores information for a player, such as their earned XP, their rank, and quests they've completed.

```verse
player_profile_data := class<final><persistable>:
    Version:int = 0
    Class:player_class = player_class.Villager
    XP:int = 0
    Rank:int = 0
    CompletedQuestCount:int = 0
    QuestHistory:[]string = array{}

var PlayerProfileDataMap:weak_map(player, player_profile_data) = map{}
```

There is a [limit](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse#limitations) to how much data you can store per player and per island. Whenever you save data, we recommend checking how your updates affect the total size by using the 'FitsInPlayerMap' function. For more details, check out [Testing Persistent Data Is Within Limits](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).

Now that you know how to create your own persistable data and initialize it for each player, be sure to check out [Best Practices](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) for recommended ways of working with persistable data in Verse!

### Modifying Data Between Published Versions of Your Island

After you have published the current version of your island, if you make updates to the persistable data, any stored data from a previous version of the island must be supported in later versions of the island.

To ensure this, a backwards compatibility check is run in UEFN and a compilation failure occurs if the Verse code is no longer compatible with the currently published version. This backwards compatibility check is run whenever you:

- Click **Launch Session** in the UEFN toolbar.
- Click **Push Changes** or **Push Verse Changes** in the UEFN toolbar.
- [Publishing your island](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-from-the-creator-portal-in-fortnite-creative) for the first time.
- Activating a new public version of your island.

This backwards compatibility check is essentially a type check on the value type of the module-scoped `weak_map` variable. For simple types like integers, the type may not be changed after the island is published. This includes `structs`, where you cannot alter the struct definition after the island is published.

Currently, the only persistable type that you can add more data to after you publish your island is the `class` type as long as new fields have default values. This means that loading saved data from a previous version will include the new fields and their default values. Check out the [best practice](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) for using classes as persistable data for more details.

### Resetting Persistable Data for Your Island

If you ever need to force a reset of the persistent data for your island, you can do so in Verse by assigning a default value for the persistable data into the `weak_map` for the player when they join the island.

In order to know if the player's data has already been reset, you can include a Version value for your class and update it with new changes as part of your persistable data. This is one of the [best practices](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) listed below, so be sure to check out the others!

## Persistable Types in Verse

The following are the persistable types that you can use in your module-scoped `weak_map` variable:

| Type | Description |
| --- | --- |
| [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) | An array is persistable if the type of elements in the array are persistable. |
| [char32](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse) | Character values are persistable. |
| [char8](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse) | Character values are persistable. |
| [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) | A class is persistable when:   - Defined with the [persistable specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse). - Defined with the [final specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse), because persistable classes cannot have [subclasses](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse). - Not [unique](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse). - Does not have a [superclass](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#superclass). - Not [parametric](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse). - Only contains [members](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#member) that are also persistable. - Does not have [variable](https://dev.epicgames.com/documentation/en-us/fortnite/constants-and-variables-in-verse) members. |
| [color](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/colors/color) | Color values are persistable. |
| [enum](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse) | An enum is persistable when defined with the [persistable specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse). |
| [float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse) | Floating point values are persistable. |
| [int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse) | Integer values are persistable. |
| [logic](https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse) | Logic values are persistable. |
| [map](https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse) | A map is peristable if both the key and value types are persistable. |
| [option](https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse) | An option is persistable if its value is persistable. |
| [struct](https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse) | A struct is persistable when:   - Defined with the [persistable specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse). - Not [parametric](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse). - Only contains [members](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#member) that are also persistable.   You cannot alter a persistable struct once you've published your island. For this reason, we recommend using persistable structs only when the schema is known to be constant. tuple |
| [tuple](https://dev.epicgames.com/documentation/en-us/fortnite/tuple-in-verse) | A tuple is persistable if every element type is persistable. |
| [vector2](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/unrealenginedotcom/temporary/spatialmath/vector2) | Vector2 values are persistable. |
| [vector2i](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/unrealenginedotcom/temporary/spatialmath/vector2i) | Vector2i values are persistable. |
| [vector3](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/unrealenginedotcom/temporary/spatialmath/vector3) | Vector3 values are persistable. |

## Testing with Persistent Data

If you want to test persistent data behavior before you publish the latest version of your island, you can set the following behavior on your [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite) device for both the **Persistence Behavior: Playtest Session** setting and the **Persistence Behavior: Edit Session** setting:

| Persistable Data Behavior | Description |
| --- | --- |
| **Import From Live** | Import session data from live data if live data is available. This requires that the island has been published live and that the player has played on the live version of the island. If live data is available, the playtest session data will be seeded with a copy of the live data. This can be very useful for testing for issues with persistable data associated with changes to your island logic. |
| **Simulate New User** | Starts the player with new persistable data as though they are playing the island for the first time. |

Both the **Import From Live** and **Simulate New Users** behaviors work for both Verse persistence and persistence devices such as the [Save Point](https://dev.epicgames.com/documentation/en-us/fortnite/using-save-point-devices-in-fortnite-creative) and [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) devices. **Simulate New User** will run the session with empty data for both Verse persistence and persistence devices without changing live data, and **Import From Live** will load persistent data from both if live data is available.

Persistence data behavior settings are applied when you playtest. There are two different scenarios where you can test with persistent data:

- **Edit Session:** Persistence data behavior settings are applied when you launch a session from UEFN. This means persistable data can persist across multiple games within a single session. If you exit the session and relaunch a new session, the persistent data will be reset and the persistence data behavior settings reapplied.
- **Playtest Session:** Persistence data behavior settings are applied when you set up a [playtest](https://dev.epicgames.com/documentation/en-us/fortnite-creative/adding-playtesters-in-fortnite-creative) in Creator Portal when a playtester joins either through a playtest code or private link code. The persistence data behavior settings are only applied the first time the player joins. When the player leaves and rejoins the playtest, their data will persist across sessions and the persistence data behavior settings will not be reapplied. To reset the persistable data, you will need to create a new playtesting link code.

For island updates that impact how persistable data is managed and updated, we recommend that you test in both scenarios, both launching a session from UEFN and a playtest that uses a link code. Be sure to test changes you make to persistable data with both live data and simulated new user data. This will help you ensure that your updates work for both current players of your island and new players.
Effects of Publishing New Versions of Your Island
Once your island is published, a persistable record is created for players when their data is stored in the `weak_map`. This data will then be stored and loaded on any subsequent visits to your island.

If new versions of your island are published, the persistable data will automatically be merged into the new version. See [Modifying Data Between Published Versions of Your Island](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) for more.

## Effects of Rolling Back Your Published Island

If you roll back your island to a previous version through the **[Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/using-creator-portal-in-fortnite-creative)**, the persistable data for all users will be reset.

There is not currently any support for notifying players that their data has been impacted by a rollback.

This will cause recent player data updates to be lost and can even result in player data being completely reset. This is true even if the rollback does not internally include changes to logic that would affect persistable data.

Because of its impact on persistable data, we recommend only using the rollback feature as a last resort.

## Limitations

The following are limitations for working with persistable data in Verse.

### Max Persistent Object Size

There is a limit to how much data can be stored in a `weak_map` per player.

A `weak_map` record is the total amount of data associated with a single `weak_map` element. A single `weak_map` record has a maximum data size of 256 kilobytes (KB) per player.

When a 'weak\_map' value is saved, the total amount of memory required to save the data is calculated.

The following are some examples of data that would be pushing the limits of 256 KB:

- Approximately 24,000 `float` or `int` values.
- Approximately 200,000 characters of text. This is equal to about 60 pages of text in an average novel.

If you attempt to save data that is larger than 256 KB for a player record, the save will fail and you will get a Verse runtime error.

You can avoid save failures by using the `FitsInPlayerMap` Verse helper function. The function `FitsInPlayerMap` takes a copy of the record you want to save and checks its size. If the record can be saved, the function call will succeed; otherwise, if the record is too large, it will fail.

The function `FitsInPlayerMap` is particularly useful when you are working with a dynamic `array` or `map` of data and adding new elements to them. Updating an `int`, `float`, or `logic` that was previously in the persistable record will not change the size of the persistable record.

### Max Persistent Player Weak Maps Per Island

A single island can have up to four persistent variables, that is, four `weak_map` variables with `player` as the key type. This requirement is enforced by the Verse compiler.

### Required Weak Map with Class Type

At least one persistent variable's `weak_map` value must be a class if the limit for max persistent variables has been met. This is to make sure the variables may have more data added later while satisfying [backwards compatibility](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse) upon subsequent island publishes.
