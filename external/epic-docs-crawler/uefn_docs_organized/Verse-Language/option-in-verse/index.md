# Option

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/option-in-verse
> **爬取时间**: 2025-12-27T00:18:27.004208

---

The `option` [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) can contain one [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) or can be empty.

In the following example, `MaybeANumber` is an optional [integer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer) `?int` that contains no value. A new value for `MaybeANumber` is then set to `42`.

```verse
var MaybeANumber : ?int = false # unset optional value
set MaybeANumber := option{42} # assigned the value 42
```

[![Creating an option variable in Verse](https://dev.epicgames.com/community/api/documentation/image/eed62437-ec6c-443f-acdd-7879983d121d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eed62437-ec6c-443f-acdd-7879983d121d?resizing_type=fit)

|  |  |
| --- | --- |
| ```verse MaybeANumber : ?int = option{42} # initialized as 42  MaybeAnotherNumber : ?int = false # unset optional value ``` | **Creating an option:** You can [initialize](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) an option with one of the following:   - **No value:** Assign `false` to the option to mark it as unset. - **Initial value:** Use the [keyword](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#keyword) `option` followed by `{}`, and an [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) between the `{}`. If the expression fails, the option will be unset and have the value `false`.   Specify the type by adding `?` before the type of value expected to be stored in the option. For example `?int`. |
| ```verse if (Number := MaybeANumber?):     Number # if MaybeANumber is not empty, then its value is stored in Number for you to use. ``` | **Accessing an element in an option:** Use the query operator `?` with the option, such as `MaybeANumber?`. Accessing the value stored in an option is a [failable expression](failure-in-verse) because there might not be a value in the option, and so must be used in a [failure context](failure-in-verse). |

The following is an example of using an option type to save a reference to a spawned player and, when a player is spawned, to have the trigger device react:

```verse
my_device := class<concrete>(creative_device):
    var SavedPlayer : ?player = false # unset optional value
 
    @editable
    PlayerSpawn : player_spawner_device = player_spawner_device{}
 
    @editable
    Trigger : trigger_device = trigger_device{}
 
    OnBegin<override>() : void =
        PlayerSpawn.PlayerSpawnedEvent.Subscribe(OnPlayerSpawned)
 
    OnPlayerSpawned(Player : player) : void =
        set SavedPlayer = option{Player}
        if (TriggerPlayer := SavedPlayer?): 
            Trigger.Trigger(TriggerPlayer)
```

## Persistable Type

An option is persistable if its value is persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
