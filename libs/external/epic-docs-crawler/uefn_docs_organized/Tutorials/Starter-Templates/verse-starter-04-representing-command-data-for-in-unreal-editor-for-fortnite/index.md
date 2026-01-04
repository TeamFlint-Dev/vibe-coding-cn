# 4. Representing Command Data

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-04-representing-command-data-for-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:30:55.317209

---

A common pattern in programming is creating a data representation of a concept, like character commands, that you can pass around and treat as data within your code. In this minigame, commands need to be treated as data to generate from the UI interaction and pass to the character to perform.

In this project, a command is represented as an [abstract](https://dev.epicgames.com/documentation/en-us/fortnite/subclass-in-verse) class, and each specific command is a subclass of this `command` class, such as `forward_command` and `turnright_command`. Using an abstract class for the command means that the only valid commands are the subclasses that are not abstract. If you try to create an instance of the `command` class directly, you'll get an error when you try to compile your code.

Because the character commands are subclasses of the `command` class, you can use them anywhere the `command` class is expected, such as the character's `ExecuteCommand()` function in the previous step. The first parameter in `ExecuteCommand()` expects the command type, which means you can use an instance of a `command` subclass as the argument without issue.

[![Using subclasses of the command class as data for the character to perform.](https://dev.epicgames.com/community/api/documentation/image/0ffd48e6-9697-439a-9975-ca90d8c73836?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ffd48e6-9697-439a-9975-ca90d8c73836?resizing_type=fit)

Each subclass provides its own implementation of `DebugString()` so when you print a command value it has the correct text associated with it, but you can add more differences to the classes if you need to.

These classes also have the [unique](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) specifier so we can compare instances of the classes. This specifier makes them comparable.

The classes also have the [computes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse) specifier so you can create instances of them at module-scope (in the `Commands` module directly). This means we can create a single unique instance to represent each command, for example, `Commands.Forward` for the forward command.

This example uses instances of command subclasses instead of the [enum](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse) type so you can add more commands later by creating more subclasses. With an `enum` type, you cannot change it or add more values to the enum after the initial published version of the project, so the `enum` type is better when you don't expect your data to change after you publish your project.

The following is the complete code for the command implementation.

```verse
# This file contains the data representation of all the commands that the NPC can receive
# and utilities for the data to help with debugging and troubleshooting issues.

# Each type of command that the NPC can perform will be an instance of this class.
# The class has the unique specifier to make instances of the class comparable.
# The class has the computes specifier to be able to instantiate it at module-scope.
# The class has the abstract specifier so it cannot be instantiated directly, and
# requires subclasses to implement any non-initialized functions, like DebugString().
command := class<computes><unique><abstract>:
    DebugString():string

# The Commands module contains definitions of commands that the NPC can perform.
# This example uses instances of command subclasses instead of the enum type
# so you can add more commands after the initial published version of the project.
Commands := module:
    # The following are subclasses of the command class
    # that implement the abstract command class and define what commands are valid.
    # Each has their own implementation of DebugString(), for example,
    # so when you print a command value it has the correct string associated with it.
    # Since the command class is abstract, it means these subclasses are the only valid commands,
    # otherwise there will be a compiler error.
    forward_command<public> := class<computes><unique>(command):
        DebugString<override>():string = "Forward"

    turnright_command<public> := class<computes><unique>(command):
        DebugString<override>():string = "TurnRight"

    turnleft_command<public> := class<computes><unique>(command):
        DebugString<override>():string = "TurnLeft"

    # Instances of each command type that can be used in the minigame.
    Forward<public>:forward_command = forward_command{}
    TurnRight<public>:turnright_command = turnright_command{}
    TurnLeft<public>:turnleft_command = turnleft_command{}

# Convert the command data to a string to be able to print it when debugging issues.
# For example, Print("Player selected {Command} command.")
ToString(Command:command):string=
    Command.DebugString()
```

## Next Step

We've defined the commands and shown how to add as many as you want.

In the next step, learn how these commands are used in the UI and how to add a custom UI for controlling the character.

[![5. Controlling the NPC with UI](https://dev.epicgames.com/community/api/documentation/image/88690df5-0ea4-459a-8142-896f2f202c8a?resizing_type=fit&width=640&height=640)

5. Controlling the NPC with UI

Learn how to create and update a custom, dynamic in-game UI using Verse.](https://dev.epicgames.com/documentation/en-us/fortnite/verse-starter-05-controlling-the-npc-with-ui-in-unreal-editor-for-fortnite)
