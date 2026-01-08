# Interface

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse>
> **爬取时间**: 2025-12-26T23:50:34.178123

---

The **interface** type provides a contract for how to interact with any [class](class-in-verse) that implements the interface. An interface cannot be [instantiated](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#instantiate), but a class can inherit from the interface and implement its methods. An interface is similar to an [abstract class](subclass-in-verse), except that it does not allow partial implementation or fields as part of the definition.

For example, let’s create an interface for anything that you can ride on, such as a bicycle or a horse:

```verse
rideable := interface():
    Mount()<decides> : void
    Dismount()<decides> : void
```

Any classes that inherit the interface must implement the interface’s functions and add the override specifier:

```verse
bicycle := class(rideable):
    ...
    Mount<override>()<decides> : void =
        ...
    Dismount<override>()<decides> : void =
        ...

horse := class(rideable):
    ...
    Mount<override>()<decides> : void =
        ...
    Dismount<override>()<decides> : void =
        ...
```

An interface can extend another interface. For example, you can specify that anything that you can ride should also be able to move.

```verse
moveable := interface():
    MoveForward() : void

rideable := interface(moveable):
    Mount()<decides> : void
    Dismount()<decides> : void
```

A class can inherit from an interface and another class. For example, you can define a horse, and differentiate it from one that has a saddle you can ride on:

```verse
horse := class(moveable):
    ...
    MoveForward()<decides> : void =
        ...

saddle_horse := class(horse, rideable):
    ...
    Mount<override>()<decides> : void =
        ...
    Dismount<override>()<decides> : void =
        ...
```

A class can inherit from multiple interfaces.

```verse
lockable := interface():
    Lock() : void =
        ...
    Unlock() : void =
        ...

bicycle := class(rideable, lockable):
    …
    Mount<override>()<decides> : void =
        ...
    Dismount<override>()<decides> : void =
        ...
    Lock<override>() : void =
        ...
    Unlock<override>() : void =
        ...
    MoveForward<override>() : void =
        ...
```
