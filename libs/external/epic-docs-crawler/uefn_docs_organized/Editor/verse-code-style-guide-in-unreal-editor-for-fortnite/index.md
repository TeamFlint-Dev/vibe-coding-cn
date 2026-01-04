# Verse Code Style Guide

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-code-style-guide-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:08:10.581452

---

This guide provides a set of recommended standards for writing consistent code that's easy to maintain. By adhering to these guidelines, developers can improve code readability, reduce errors, and facilitate collaboration. A standardized code style is necessary to ensure code is easy to understand and maintain by both current and future developers working on a project.

This guide provides recommendations, but ultimately the choice is up to your team.

## 1. Common Naming Patterns

Naming is crucial for readable and maintainable code. Try to be consistent in the naming style throughout your code.

### 1.1 Do

- **`IsX`**: Often used for naming logic variables to ask a question (for example, IsEmpty).
- **`OnX`**: An overloadable function called by the framework.
- **`SubscribeX`**: Subscribe to framework event named X, often passing an OnX function to it.
- **`MakeC`**: Make an instance of class c without overloading the c constructor.
- **`CreateC`**: Create an instance of class c, beginning its logical lifetime.
- **`DestroyC`**: End the logic lifetime.
- **`C:c`**: If you’re working with a single instance of class c, it’s fine to call it C.

### 1.2 Don’t

- Decorate type names. Just call it `thing`, not `thing_type` or `thing_class`.
- Decorate enumeration values. Not `color := enum{COLOR_Red, COLOR_Green}`, use `color := enum{Red, Green}`.

## 2. Names

### 2.1 Types use lower\_snake\_case

Type names should always be `lower_snake_case`. This includes all types: structs, classes, typedefs, traits/interfaces, enums, etc.

```verse
my_new_type := class
```

### 2.2 Interfaces are adjectives

Interfaces should be adjectives where possible, such as printable, enumerable. Where adjectives don’t seem right, append `_interface` to the name instead.

```verse
my_new_thing_interface := interface
```

### 2.3 PascalCase everything else

All other names should be PascalCase. Modules, member variables, parameters, methods, and so on.

```verse
MyNewVariable:my_new_type = …
```

### 2.4 Parametric Types

- Name parametric types t or thing, where thing explains what the type is supposed to represent. For example:
  `Send(Payload:payload where payload:type)`
  You’re sending some parameterized data, `Payload`, of any `payload` type.
- If there’s more than one parametric type, avoid using single letters, such as `t`, `u`, `g`
- Never use `_t` suffix.

## 3. Formatting

It is important to stay consistent with formatting throughout your codebase. This makes the code easier to read and understand for yourself and other developers. Choose a formatting style that works for the project.

As an example of staying consistent, you could choose one of the following spacing formats and use it throughout the codebase:

```verse
MyVariable : int = 5
MyVariable:int = 5
```

### 3.1 Indentation

- Use four spaces for indentation, never tabs.
- Code blocks should use indented blocks (spaced) rather than curly brackets (braced):

  ```verse
  my_class := class:
            Foo():void =
                Print("Hello World")
  ```

  - Except when writing single line expressions like `option{a}`, `my_class{A := b}`, etc.

### 3.2 Spaces

- Use spaces around operators, unless it makes sense to keep the code compact for its context. Add brackets to explicitly define the order of operations.

  ```verse
  MyNumber := 4 + (2 * (a + b))
  ```
- Don’t add spaces at the beginnings and ends of brackets. Multiple expressions inside brackets should be separated by a single space.

  ```verse
  MyEnum := enum{Red, Blue, Green}
  MyObject:my_class = my_class{X := 1, Y := 2}
  Vector := vector3{Left := 1000.0, Up := -1000.0, Forward := 0.0}
  Foo(Num:int, Str:[]char)
  ```
- Keep identifier and type together; add a space around the assignment `=` operator. Add a space around type definitions and constant initialization operators (`:=`).

  ```verse
  MyVariable:int = 5
  MyVariable := 5
  my_type := class
  ```
- Follow the same recommendations for brackets, identifiers, and types spacing for function signatures.

  ```verse
  Foo(X:t where t:subtype(class3)):tuple(t, int) = (X, X.Property)
        Foo(G(:t):void where t:type):void
        Const(X:t, :u where t:type, u:type):t = X
  ```

### 3.3 Line Breaks

- Use a spaced, multiline form to insert a line break.

  |  |  |  |
  | --- | --- | --- |
  | **Do** | ```verse MyTransform := transform:     Translation := vector3:         Left := 100.0         Up := 200.0         Forward := 300.0      Rotation := rotation:         Pitch := 0.0         Yaw := 0.0         Roll := 0.0 ``` | **More readable and easier to edit.** |
  | **Don't** | ```verse MyTransform := transform{Translation := vector3{Left := 100.0, Up := 200.0, Forward := 300.0}, Rotation := rotation{...}} ``` | **Hard to read on a single line.** |

- Define enums in spaced, multiline form if they need per-enumeration comments or if you need to insert a line break.

  ```verse
  enum:
      Red, # Desc1
      Blue, # Desc2
  ```

### 3.4 Brackets

Don’t use brackets for non-inheriting class definitions.

|  |  |
| --- | --- |
| **Do** | ```verse my_base_type := class: ``` |
| **Don't** | ```verse my_base_type := class(): ``` |

### 3.5 Avoid Dot-Space Notation

Avoid using dot-space ". " notation in place of braces. This makes it visually harder to parse whitespace and is a potential source of confusion.

|  |  |
| --- | --- |
| **Don't** | ```verse spawn { F() } -> spawn. F() ``` |
| **Don't** | ```verse using { Foo } -> using. Foo ``` |

## 4. Functions

### 4.1 Implicit return by default

Functions return their last expression value. Use that as an implicit return.

```verse
Sqr(X:int):int =
    X * X # Implicit return
```

If using any explicit returns, all returns in the function should be explicit.

### 4.2 GetX functions should be

Getters or functions with similar semantics that may fail to return valid values should be marked `<decides><transacts>` and return a non-option type. The caller should handle potential failure.

```verse
GetX()<decides><transacts>:x
```

An exception is functions that need to unconditionally write to a `var`. Failure would roll the mutation back, so they need to use `logic` or `option` for their return type.

### 4.3 Prefer Extension Methods to Single Parameter Functions

Use extension methods instead of a function with a single typed parameter.

Doing this helps Intellisense. By typing `MyVector.Normalize()` instead of `Normalize(MyVector)` it can suggest names with each character of the method name you type.

|  |  |
| --- | --- |
| **Do** | ```verse (Vector:vector3).Normalize<public>():vector3 ``` |
| **Don't** | ```verse Normalize<public>(Vector:vector3):vector3 ``` |

## 5. Failure Checks

### 5.1 Limit single line Failable Expressions count to three

- Limit conditional checks/failable expressions on a single line to a maximum of three.

  ```verse
  if (Damage > 10, Player := FindRandomPlayer[], Player.GetFortCharacter[].IsAlive[]):
            EliminatePlayer(Player)
  ```
- Use the form of `if` with parentheses `()` when the number of conditions is less than three.

|  |  |  |
| --- | --- | --- |
| **Do** | ```verse if (Damage > 10, Player := FindRandomPlayer[]):     EliminatePlayer(Player) ``` | **Keeps code concise but readable.** |
| **Don't** | ```verse if:     Damage > 10     Player := FindRandomPlayer[] then:     EliminatePlayer(Player) ``` | **Unnecessarily splits code over multiple lines with no readability improvements.** |

- If using more than two words for each expression, a maximum of two expressions on a single line is often more readable.

  ```verse
  if (Player := FindAlivePlayer[GetPlayspace().GetPlayers()], Team := FindEmptyTeam[GetPlayspace().GetTeamCollection().GetTeams()]):
            AddPlayerToTeam(Player, Team)
  ```
- You can also apply the rule as in a failure context on a single line, don't use more than nine words.
  When over the limit, use the spaced, multiline form.

|  |  |  |
| --- | --- | --- |
| **Do** | ```verse if:     Player := FindAlivePlayer[GetPlayspace().GetPlayers()]     Team := FindEmptyTeam[GetPlayspace().GetTeamCollection().GetTeams()]     Character := Player.GetFortCharacter[]     Character.GetHealth() < 50 then:     AddPlayerToTeam(Player, Team)     Character.SetHealth(100) ``` | **The text reads better and the context is understandable over multiple lines.** |
| **Don't** | ```verse if (Player := FindAlivePlayer[GetPlayspace().GetPlayers()], Team := FindEmptyTeam[GetPlayspace().GetTeamCollection().GetTeams()], Character := Player.GetFortCharacter[], Character.GetHealth() < 50):     AddPlayerToTeam(Player, Team)     Character.SetHealth(100) ``` | **The text is hard to parse.** |

- Evaluate whether grouping multiple failable conditions into a single `<decides>` function would make the code easier to read and reuse. Note that if the code is only ever used in one place, a "section" comment without an ad hoc function can suffice.

  ```verse
  if:
            Player := FindRandomPlayer[]
            IsAlive[Player]
            not IsInvulnerable[Player]
            Character := Player.GetFortCharacter[]
            Character.GetHealth < 10
        then:
            EliminatePlayer(Player)
  ```
- Can be rewritten as:

  ```verse
  GetRandomPlayerToEliminate()<decides><transacts>:player=
            Player := FindRandomPlayer[]
            IsAlive[Player]
            not IsInvulnerable[Player]
            Character := Player.GetFortCharacter[]
            Character.GetHealth < 10
            Player
        if (Player := GetRandomPlayerToEliminate[]):
            Eliminate(Player)
  ```
- The same guideline applies to expressions in `for` loops.
  For example:

  ```verse
  set Lights = for (ActorIndex -> TaggedActor : TaggedActors, LightDevice := customizable_light_device[TaggedActor], ShouldLightBeOn := LightsState[ActorIndex]):
        Logger.Print("Adding Light at index {ActorIndex} with State:{if (ShouldLightBeOn?) then "On" else "Off"}")
        if (ShouldLightBeOn?) then LightDevice.TurnOn() else LightDevice.TurnOff()
        LightDevice
  ```
- Better as:

  ```verse
  set Lights = for:
           ActorIndex -> TaggedActor : TaggedActors
           LightDevice := customizable_light_device[TaggedActor]
           ShouldLightBeOn := LightsState[ActorIndex]
       do:
           if (ShouldLightBeOn?) then LightDevice.TurnOn() else LightDevice.TurnOff()
           LightDevice
  ```

### 5.2 Group Dependent Failure Expressions together

When a condition in a failure context depends on a previous failure context succeeding, keep the two conditions together in the same failure context when possible, and follow guideline 5.1.

This improves code locality, which simplifies logical understanding and debugging.

|  |  |  |
| --- | --- | --- |
| **Do** | ```verse EliminatingCharacter := EliminationResult.EliminatingCharacter if (FortCharacter := EliminatingCharacter?, EliminatingAgent := FortCharacter.GetAgent[]):     GrantNextWeapon(EliminatingAgent) ``` | **Dependent or related conditions are grouped.** |
| **Do** | ```verse if:     FortCharacter := Player.GetFortCharacter[]     set AgentMap[Player] = 1     FirstItemGranter:item_granter_device = ItemGranters[0] then:     FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated)     FirstItemGranter.GrantItem(Player) ``` | **Dependent or related conditions are grouped.** |
| **Don't** | ```verse EliminatingCharacter := Result.EliminatingCharacter if:     FortCharacter := EliminatingCharacter? then:     if:         EliminatingAgent := FortCharacter.GetAgent[]     then:         GrantNextWeapon(EliminatingAgent) ``` | **Unnecessary indentation can make the flow harder to follow.** |
| **Don't** | ```verse if:     FortCharacter := Player.GetFortCharacter[] then:     FortCharacter.EliminatedEvent().Subscribe(OnPlayerEliminated) if:     set AgentMap[Player] = 1 if:     FirstItemGranter:item_granter_device = ItemGranters[0] then:     FirstItemGranter.GrantItem(Player) ``` | **Unnecessary indentation can make the flow harder to follow.** |

It’s acceptable to split failure contexts if you handle each potential failure (or failure groups) separately.

```verse
if (Player := FindPlayer[]):
    if (Player.IsVulnerable[]?):
        EliminatePlayer(Player)
    else:
        Print("Player is invulnerable, can’t eliminate.")
else:
    Print("Can’t find player. This is a setup error.")
```

## 6. Encapsulation

### 6.1 Prefer Interfaces to Classes

Use interfaces instead of classes where reasonable. This helps reduce implementation dependencies and allows users to provide implementations that can be used by the framework.

### 6.2 Prefer Private Access and Restrict Scope

Class members should be 'private' in most cases.

Class and module methods should be scoped as restrictively as possible - `<internal>` or `<private>` where appropriate.

## 7. Events

### 7.1 Postfix Events with Event and Prefix Handlers with On

Subscribable events or delegate list names should be postfixed with 'Event', and event handler names should be prefixed with 'On'.

```verse
MyDevice.JumpEvent.Subscribe(OnJump)
```

## 8. Concurrency

### 8.1 Don’t Decorate Functions with Async

Avoid decorating `<suspends>` functions with `Async` or similar terms.

|  |  |
| --- | --- |
| **Do** | ```verse DoWork()<suspends>:void ``` |
| **Don't** | ```verse DoWorkAsync()<suspends>:void ``` |

It’s acceptable to add the `Await` prefix to a `<suspends>` function that internally waits on something to happen.
This can clarify how an API is supposed to be used.

```verse
AwaitGameEnd()<suspends>:void=
    # Setup other things before awaiting game end…
    GameEndEvent.Await()

OnBegin()<suspends>:void =
    race:
        RunGameLoop()
        AwaitGameEnd()
```

## 9. Attributes

### 9.1 Separate Attributes

Put attributes on a separate line. It’s more readable, especially if multiple attributes are added to the same identifier.

|  |  |
| --- | --- |
| **Do** | ```verse @editable MyField:int = 42 ``` |
| **Don't** | ```verse @editable MyField:int = 42 ``` |

## 10. Import Expressions

### 10.1 Sort Import Expressions Alphabetically

For example:

```verse
using { /EpicGames.com/Temporary/Diagnostics }
using { /EpicGames.com/Temporary/SpatialMath }
using { /EpicGames.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }
```
