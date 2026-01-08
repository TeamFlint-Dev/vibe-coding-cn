# Logic

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse>
> **爬取时间**: 2025-12-26T23:50:10.732310

---

Verse uses `logic` as the [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) for Boolean values, which means `logic` only has two possible values: `true` and `false`.

Both `true` and `false` are logic [literals](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#literal) when you use them in Verse code.

The following is an example of how to create a logic [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) named `TargetLocked`, [initialized](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) with the logic literal `false`:

```verse
var TargetLocked : logic = false
```

## Logic Operations

The `logic` type supports [query](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#query) [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation) and [comparison](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) operations.

## Query

Query expressions use the [operator](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) `?` (query) and check if a `logic` value is `true`. Otherwise, the expression fails if the `logic` value is `false`.

```verse
# Determine whether to show the target-locked icon if a target is locked
if (TargetLocked?):
    ShowTargetLockedIcon()
```

For more on query operations, see [Operators](operators-in-verse).

## Comparison

For comparison operations, you can use the failable [operator](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) `=` to test if two logic values are equal, and the failable operator `<>` to test for inequality.

For example, the sample code below will make an "unavailable action" icon appear if the player has equipped a weapon but doesn't have a target, or has a target but no weapon. This can be expressed by comparing `logic` values that represent the two factors.

- If both are false, you won't see the icon because the player isn't trying to attack.
- If both are true, you won't see the icon because the player is able to attack.

  ```verse
  # Initialize logic variables for demonstration purposes.
        var TargetLocked : logic = false
        var WeaponEquipped : logic = true
     
        # Determine whether or not the "unavailable action" icon is appropriate.
        if (WeaponEquipped <> TargetLocked):
            # The icon should show up, because the player appears to be trying to
            # attack, but is missing either a weapon or a target.
            ShowUnavailableIcon()
  ```

For more on comparison operations, see [**Operators**](operators-in-verse).

## Convert Failable Expression to Logic

You can cast a failable expression to a `logic` type using `logic{failable-expression}`, where `failable-expression` is an [expression that can fail](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression).

In the following example, the failable expression `GetRandomInt(0, MineFrequency) <> 0` is converted to the `logic` value `false` if the random integer is 0 and `true` otherwise.

```verse
IsMined := logic{GetRandomInt(0, MineFrequency) <> 0}
```

## Standard Library

The [standard library](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) provides functions to help with creating and using logic values. Refer to the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api) for more details on these functions.

## Persistable Type

Logic values are persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
