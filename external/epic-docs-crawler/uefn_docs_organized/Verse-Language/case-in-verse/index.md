# Case

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/case-in-verse>
> **爬取时间**: 2025-12-26T23:50:41.000874

---

With `case` [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression), you can [control the flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of a program from a list of choices. The case [statement](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#statement) in Verse is a way to test one value against multiple possible values (as though you were using `=`), and running code based on which one matches.

The use of case expressions can be found in all kinds of applications, like in games where there is a non-playable character ([NPC](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#npc)).

For example, let's say you use the [Guard Spawner](https://www.epicgames.com/fortnite/en-US/creative/docs/using-guard-spawner-devices-in-fortnite-creative) device to spawn a guard with its patrol option enabled. After the guard spawns into the game, it has a few possible active states, including **Idle**, **Patrol**, **Alert**, **Attack**, and **Harvest**. A high-level state-transition diagram for this could look like:

[![In-game state transition in Verse](https://dev.epicgames.com/community/api/documentation/image/dec9e8e5-fda5-4d9f-8e65-0e19c0760a4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dec9e8e5-fda5-4d9f-8e65-0e19c0760a4e?resizing_type=fit)

You can observe these state transitions [in-game](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#in-game).

*In this video, the guard has its patrol option enabled as the default behavior.*

In the video, the guard transitions from patrolling the science base to [harvesting](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#harvest) some [resources](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#resource). Then the guard spots the player, which sends the guard into an alert state (indicated by the hovering question mark) before entering its attack state (indicated by the hovering exclamation mark).

Depending on the state the guard is in, it will exhibit certain behaviors, and these behaviors are typically coded as [functions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that are [called](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) when the program chooses to enter a specific state.

As code, this high-level guard-state transition could look like this:

```verse
case(GuardStateVariable):
        idle_state =>
            RunIdleAnimation()
            SearchPlayerCharacter()
        harvest_state =>
            GatherResources()
        alert_state=>
            RunAlertAnimation()
            PlayAlertSound()
            DisplayAlertUIElement()
            TargetPlayerCharacter()
        attack_state =>
            RunAttackAnimation()
            DisplayAttackUIElement()
            TargetPlayerCharacter()
            AttackPlayerCharacter()
        _ =>
            RunPatrolAnimation()
            SearchPlayerCharacter()
            SearchResources()
```

This `case` expression passes a label that tells the program which functions to run if the guard enters a specific state.

In this expression, the guard's `patrol_state` is the default case because a guard with patrol enabled should run its default patrol behavior.

Syntactically, this is the same as:

```verse
expression0
    case (test-arg-block):
    label1 =>
        expression1
    label2 =>
        expression2
    _ =>
        expression3 for the default case
    expression4
```

[![Case flow diagram in Verse](https://dev.epicgames.com/community/api/documentation/image/4b80ee38-7ca9-4cb9-a33d-1ca09b37404f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b80ee38-7ca9-4cb9-a33d-1ca09b37404f?resizing_type=fit)

Each pattern in the `case` [block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block), such as `label1` and `label2`, must use the form `constant => block`, where the [constant](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant) can be an [integer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer), [logic](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), [string](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), [char](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#char), or [enum](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) constant. So case statements only work with `int`, `logic`, `string`, `char`, and enums.

## Structure

Structurally, the Verse case expression runs code based on input of the `GuardStateVariable` test argument block, and it functionally works the same as a series of [if expressions](if-in-verse).

[![Example of running expression3, the alert_state](https://dev.epicgames.com/community/api/documentation/image/9ad31088-1865-42d1-acc1-5cde9cd5a710?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ad31088-1865-42d1-acc1-5cde9cd5a710?resizing_type=fit)

In this example, the Verse program runs `expression3` if `GuardStateVariable` resolves to `alert_state`. If the program passes in `patrol_state`, Verse structurally jumps to the default case, and runs `expression5`.

[![Example of running the default state, expression5](https://dev.epicgames.com/community/api/documentation/image/3acd17bd-4255-4267-863c-f9f7a5ada202?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3acd17bd-4255-4267-863c-f9f7a5ada202?resizing_type=fit)

## Using Case with Other Control Flow

The blocks in a case statement are allowed to break and continue if the case statement is inside of a `loop`. Blocks of case statements are also allowed to return from the function they are in.

For example:

```verse
loop:
        case (x):
            42 => break
            _ => {}
```

This absurd loop will either complete immediately if `x = 42` or loop forever.

Another example:

```verse
Foo(x : int) : int =
        case (x):
            100 => return 200
            _ => return 100
```

This example is equivalent to:

```verse
Foo(x : int) : int =
        case (x):
            100 => 200
            _ => 100
```

This is because the case statement is the last expression of the function.

## Default Case

Case statements that do not have a `_=>` case (a default case) will [fail](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) if none of the cases match. It's fine to use such case statements in [failure contexts](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context) (such as functions with the `decides` effect).

Case statements that match all of the cases of an enumeration will be non-failing even if they do not have a `_=>` case.
