# Struct

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse
> **爬取时间**: 2025-12-27T00:39:23.928486

---

Struct is short for **structure**, and is a way to group several related [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) together. Any variables can be grouped, including variables of different [types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type).

[

[![Instantiating a struct in Verse](https://dev.epicgames.com/community/api/documentation/image/8fd22294-8947-4e28-980b-5f30a6b85688?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8fd22294-8947-4e28-980b-5f30a6b85688?resizing_type=fit)

*Click image to enlarge.*

|  |  |
| --- | --- |
| ```verse coordinates := struct:     X : float = 0.0     Y : float = 0.0 ``` | **Creating a struct:** Use the [keyword](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#keyword) `struct` followed by a [code block](https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse). Definitions in the struct’s [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) define the fields of the struct. |
| ```verse Position := coordinates{X := 1.0, Y := 1.0} ``` | **Instantiating a struct:** You can construct an [instance](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#instance) of a struct from an [archetype](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#archetype). An archetype defines the values of a struct’s fields. |
| ```verse Position.X ``` | **Accessing fields on a struct:** You can access a struct’s fields to get their value by adding `.` between the struct instance and the field name. |

## Persistable Type

A struct is persistable when:

- Defined with the [persistable specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).
- Not [parametric](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse).
- Only contains members that are also persistable.

When a struct is persistable, it means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).

You cannot alter a persistable struct once you’ve published your island. For this reason, we recommend using persistable structs only when the schema is known to be constant.

The following is an example of a persistable struct X, Y coordinates that can be stored, updated, and accessed later for a player.

```verse
coordinates := struct<persistable>:
    X:float = 0.0
    Y:float = 0.0
```
