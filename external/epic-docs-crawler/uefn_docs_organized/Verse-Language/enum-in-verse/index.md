# Enum

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse
> **爬取时间**: 2025-12-27T02:07:59.565511

---

Enum is short for **enumeration**, which means to name or list a series of things, called **enumerators**. This is a [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) in Verse that can be used for things like days of the week or compass directions.

[![Creating an enum in Verse](https://dev.epicgames.com/community/api/documentation/image/e75f19aa-3fa1-4f18-bdcc-d16a77091f55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e75f19aa-3fa1-4f18-bdcc-d16a77091f55?resizing_type=fit)

*Click image to enlarge.*

## Closed and Open Enums

Verse uses the `<open>` and `<closed>` attribute specifiers on enums to determine how you can change the definition of the enum once your island is published.

Enums are **closed** by default. With closed enums, you cannot add or reorder enum values or change a closed enum to an open one once your island has been published.

Closed enums are best used for cases where your values are expected to stay the same, like days of the week.

With **open** enums, you can:

- Add new enum values.
- Reorder enum values.
- Change an open enum to a closed enum.

Open enums are best used when you expect the number of values in your enum may increase in the future. For example, an enum of weapon types.

**Open** enums cannot be used in a [case statement](https://dev.epicgames.com/documentation/en-us/fortnite/case-in-verse) without a default case. **Closed** enums can be used in case statements without a default case only if all enumeration values have a case.

## Creating an Enum

| Action | Code Example |
| --- | --- |
| **Creating closed enums:**  Enums are closed by default.  Use the keyword `enum` followed by `{}`. If you want to specify initial elements in the enum, add the enumerators between the `{}`, separated by `,`.  You can explicitly define the enum as **closed** by including the `<closed>` specifier after the `enum` keyword. | ```verse # If not specified, enums are closed by default. direction := enum{Up, Down, Left, Right}  # The same as the previous enum, where its closed nature is explicit. direction := enum<closed>{Up, Down, Left, Right} ``` |
| **Creating open enums:**  You must explicitly define an **open**enum by including the `<open>` specifier after the `enum` keyword. | ```verse # You can add and reorder enum values, or change this to a <closed> enum direction := enum<open>{Up, Down, Left, Right} ``` |
| **Accessing an enumerator:** Use `.` on the enum, followed by the enumerator you want to use. For example `direction.Up`. | ```verse direction.Up ``` |

## Persistable Type

An enum is persistable when it is defined with the `<persistable>` specifier. This means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions.

For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).

Non-persistent enums cannot be used with persistable data.

The following is an example of a closed persistable enum for the days of the week that can be stored, updated, and accessed later for a player.

```verse
day := enum<persistable>:
    Monday
    Tuesday
    Wednesday
    Thursday
    Friday
    Saturday
    Sunday
```

If not specified, all enums are **closed** by default.

## Published Enums

Once you have published your island, certain aspects of closed and open enums with the `<persistable>` specifier are fixed.

Closed enums:

- Cannot be updated to become `<open>`.
- Cannot add, rename, reorder or remove enum values.
- If not specified, you can add the `<closed>` specifier.

Open enums:

- Can be updated to become a closed enum with the `<closed>` specifier.
- Can add and reorder enum values.
- Cannot rename or remove enum values.
- Cannot be used in case statements without a default case.
