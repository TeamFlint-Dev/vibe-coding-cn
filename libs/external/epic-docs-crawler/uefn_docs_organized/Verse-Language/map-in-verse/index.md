# Map

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/map-in-verse
> **爬取时间**: 2025-12-26T23:50:27.117352

---

A `map` is a [container type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#container-type) that holds [key-value pairs](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#key-value-pair), which are mappings from one [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) to another value. Elements in a map are ordered based on the order of key-value pairs when you create the map, and you access [elements](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#element) in the map using the unique keys you define.

For example, if you want to keep a count of how many times you encounter a word, you can create a map using the word as the key and its count as the value.

```verse
WordCount : [string]int = map{"apple" => 11, "pear" => 7}
```

[![](https://dev.epicgames.com/community/api/documentation/image/129d4bd3-8bde-4bbf-9473-3edbc4151054?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/129d4bd3-8bde-4bbf-9473-3edbc4151054?resizing_type=fit)

*Click image to enlarge.*

If you use the same key multiple times when initializing a map, the map will only keep the last value provided for that key. In the following example, `WordCount` will only have the `"apple" => 2` key-value pair. The `"apple" => 0` and `"apple" => 1` pairs are discarded.

```verse
WordCount : [string]int = map{"apple" => 0, "apple" => 1, "apple" => 2}
```

## Supported Key Types

Key-value pairs can be of any type as long as the key type is [comparable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), because there needs to be a way to check if a key already exists for a map.

The following types can be used as keys:

- [logic](logic-in-verse)
- [int](int-in-verse)
- [float](float-in-verse)
- [char](strings-in-verse)
- [string](strings-in-verse)
- [enum](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary)
- A [class](class-in-verse), if it’s comparable
- An [option](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), if the element type is comparable
- An [array](array-in-verse), if the element type is comparable
- A map if both the key and the value types are comparable
- A [tuple](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) if all elements in the tuple are comparable

## Map Length

You can get the number of key-value pairs in a map by accessing the field `Length` on the map. For example, `map{"a" => "apple", "b" => "bear", "c" => "candy"}.Length` returns 3.

## Accessing Elements in a Map

You can access an [element](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#element) in a map by using a key, for example `WordCount["apple"]`.

Accessing an element in a map is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression) and can only be used in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context), such as an [if expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression). For example:

```verse
ExampleMap : [string]string = map{"a" => "apple", "b" => "bear", "c" => "candy"}
for (Key->Value : ExampleMap):
    Print("{Value} in ExampleMap at key {Key}")
```

|  |  |  |  |
| --- | --- | --- | --- |
| **Key** | "a" | "b" | "c" |
| **Value** | "apple" | "bear" | "candy" |

## Adding and Modifying Elements in a Map

You can add elements to a map variable by setting the key in a map to a specific value. For example `set ExampleMap["d"] = 4`. Existing key-value pairs can be updated by similarly assigning a value to a key that already exists in the map.
Adding an element to a map is a [failable expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression) and can only be used in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context), such as an [if expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#if-expression). For example:

```verse
var ExampleMap : [string]int = map{"a" => 1, "b" => 2, "c" => 3}
# Modifying an existing element
if (set ExampleMap["b"] = 3, ValueOfB := ExampleMap["b"]):
    Print("Updated key b in ExampleMap to {ValueOfB}")
# Adding a new element
if (set ExampleMap["d"] = 4, ValueOfD := ExampleMap["d"]):
    Print("Added a new key-value pair to ExampleMap with value {ValueOfD}")
```

## Removing Elements from a Map

Elements can be removed from a map variable by creating a new map that excludes the key you want to remove. An example of a function that provides removal from `[string]int` maps is provided below.

```verse
# Removes an element from the given map and returns a new map without that element
RemoveKeyFromMap(ExampleMap:[string]int, ElementToRemove:string):[string]int=
    var NewMap:[string]int = map{}
    # Concatenate Keys from ExampleMap into NewMap, excluding ElementToRemove
    for (Key -> Value : ExampleMap, Key <> ElementToRemove):
        set NewMap = ConcatenateMaps(NewMap, map{Key => Value})
    return NewMap
```

## Weak Map

The type `weak_map` is a supertype of the `map` type. You would use a `weak_map` in a similar way to how you’d use the `map` type in most cases, but with the following exceptions:

- You cannot query how many elements a `weak_map` contains because `weak_map` does not have a `Length` member.
- You cannot iterate through the elements of a `weak_map`.
- You cannot use `ConcatenateMaps()` on a `weak_map`.

Another difference is that the type definition for a `weak_map` requires you to define the key-value pair types using the `weak_map` function, such as `MyWeakMap:weak_map(string, int) = map{}`, which defines a weak map named `MyWeakMap` that will have a string key paired with an integer value. Since `weak_map` is a supertype of `map`, you can initialize it with a standard `map{}`.

The following shows an example of creating a `weak_map` variable, and accessing an element in the weak map:

```verse
ExampleFunction():void=
    var MyWeakMap:weak_map(int, int) = map{} # Supertype of the standard map, so it can be assigned from the standard map
    if: 
        set MyWeakMap[0] = 1 # Same means of mutation of a particular element as the standard map
    then:
        if (Value := MyWeakMap[0]):
            Print("Value of map at key 0 is {Value}")
    set MyWeakMap = map{0 => 2} # Same means of mutation of the entire map as the standard map
```

## Persistable Type

A map is peristable if both the key and value types are persistable. When a map is persistable, it means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
