# Subclass

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse
> **爬取时间**: 2025-12-26T23:50:54.945680

---

In Verse, you can create a [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) that extends the [definition](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#definition) of another class by adding or modifying the [fields](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#member) and [methods](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#method) of the other class. This is often called subclassing or [inheritance](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#inheritance), because one class inherits definitions from the other class.

Let’s look at the [Class Designer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-class-designer-devices-in-fortnite-creative) device as an example of subclassing. With the Class Designer device, you can create character classes for player characters that let you define the attributes and inventories specific to a character class, such as a tank or DPS (damage per second) character.

|  |  |
| --- | --- |
|  |  |
| DPS character class created with the Class Designer device | Tank character class created with the Class Designer device |

In Verse, you could create a `tank` class and a `dps` class like this:

```verse
tank := class():
    StartingShields : int
    MaxShields : int
    AllowOvershield : logic
    DamageReduction : int

dps := class():
    StartingShields : int
    MaxShields : int
    AllowOvershield : logic
    MovementMultiplier : float
```

Because some of the fields in the two classes are the same, you can reduce duplication with a superclass that holds the shared properties and behaviors of the classes. Let’s call this superclass `player_character`, and make `tank` and `dps` subclasses of `player_character`:

```verse
player_character := class():
    StartingShields : int
    MaxShields : int
    AllowOvershield : logic

dps := class(player_character):
    MovementMultiplier : float

tank := class(player_character):
    DamageReduction : int
```

Since the `tank` and `dps` classes are subclasses of `player_character`, they automatically inherit the fields and methods of the `player_character` class, so you only need to specify what’s different in this class from the superclass.

For example, the `dps` class only adds the `Movement Multiplier` field, and the `tank` class only adds the `DamageReduction` field. This setup is useful if you change the shared behaviors of the two classes later because you’ll only need to change it in the superclass.

[![Diagram showing inheritance relationship between the superclass player_character and the subclasses dps and tank](https://dev.epicgames.com/community/api/documentation/image/7155564b-d349-4fd5-83a2-1c3598e697d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7155564b-d349-4fd5-83a2-1c3598e697d4?resizing_type=fit)

With Verse, you can add more changes to differentiate the tank and dps classes by adding methods to the subclasses.

A useful effect of subclassing is that you can use the relationship between a superclass and its subclasses. Because of inheritance, an instance of `tank` is a specialized `player_character`, and an instance of `dps` is a specialized `player_character`, which is referred to as an [is-a relationship](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#is-a-relationship). Since `tank` and `dps` are both subclasses of the same superclass and diverge from their shared superclass, `tank` does not have a relationship with `dps`.

## Override Specifier

To create instances of classes with initial [values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value), a common practice is to have a [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that generates the instances. For example:

```verse
CreateDPSPlayerCharacter() : dps =
    return dps{StartingShields := 0, MaxShields := 0, AllowOvershield := false, MovementMultiplier := 1.9}

CreateTankPlayerCharacter() : tank =
    return tank{StartingShields := 100, MaxShields := 200, AllowOvershield := true, DamageReduction := 50}
```

The `CreateTankPlayerCharacter()` and `CreateDPSPlayerCharacter()` functions create the instances with the appropriate initial values. Alternatively, you can override the fields from the superclass and assign initial values, so you don’t need to provide so many initial values when creating an instance.

For example, the tank class from the previous section could look like this with overrides on the fields:

```verse
tank := class(player_character):
    StartingShields<override> : int = 100
    MaxShields<override> : int = 200
    AllowOvershield<override> : logic = true
    DamageReduction : int = 50

CreateTankPlayerCharacter() : tank =
    return tank{}
```

[![Diagram showing overrides in the inheritance relationship between the superclass player_character and the subclasses dps and tank](https://dev.epicgames.com/community/api/documentation/image/f1d37b36-543b-4137-8135-56f8a1fdc510?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1d37b36-543b-4137-8135-56f8a1fdc510?resizing_type=fit)

You can also override methods in the subclass, which means you can use the overriding method everywhere the overridden method can be used. This means:

- The method must accept at least any argument accepted by the overridden method, so the parameter type must be a supertype of the overridden function's parameter type.
- The method must not return a value that the overridden method couldn't have, so the return type must be a subtype of the overridden method's return type.
- The method must not have more effects than the overridden method, so the [effect specifier](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse) must be a subtype of the overridden method's effect specifier.

## Super

Similar to [Self](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse#self), you can use `(super:)` to access the superclass implementations of fields and methods. To be able to use `(super:)`, the field or method must be implemented in the superclass definition.

```verse
pet := class():
    Sound : string

    Speak() : void =
        Log(Sound)

cat := class(pet):
    Sound<override> : string = "Meow"

    Speak<override>() : void =
        (super:)Speak() # "Meow" appears in the Output Log
        Log("Purr") # "Purr" appears in the Output Log
```

## Block Expressions in a Subclass Body

Any `block` expressions that are in a subclass [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body) will be executed after the `block` expressions specified in the superclass body. For example, in the following code, when the instance of the `cat` class named MrSnuffles is created, `Speak()` is executed first, then `Purr()`.

```verse
pet := class():
    Speak() : void =
    ...

    block:
        Speak()

cat := class(pet):
    Purr() : void =
    ...

    block:
        Purr()

MrSnuffles := cat{}
```

## Abstract Specifier

When a class or a class method has the [abstract specifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#abstract-class), you cannot create an [instance](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#instance) of the class. Abstract classes are intended to be used as a superclass with partial implementation, or as a common [interface](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). This is useful for when it doesn’t make sense to have instances of a superclass but you don’t want to duplicate properties and behaviors across similar classes.

In the following example, because pet is an abstract concept, an instance of the pet class isn’t specific enough, but a pet cat or pet dog does make sense, so those subclasses aren’t marked as abstract.

```verse
pet := class<abstract>():
    Speak() : void

cat := class(pet):
    Speak() : void =
    ...

dog := class(pet):
    Speak() : void =
    ...
```
