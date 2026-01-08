# If

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse>
> **爬取时间**: 2025-12-26T23:51:48.871013

---

With the `if` expression, you can make decisions that change the [flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of the program. As with other programming languages, the Verse `if` expression supports conditional execution, but in Verse, the conditions use success and failure to drive the decision.

For example, you can write code that defines the fall height a player can drop before taking damage.

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

# Players take damage if they fall more than 3 meters
if (PlayerFallHeight > 3.0):
    DealDamage()

# Reset the player’s fall height
ZeroPlayerFallHeight()
```

In this example, if `PlayerFallHeight` is greater than three meters, then the condition succeeds and `DealDamage()` is executed before the player’s fall height is reset. Otherwise, the condition fails so the player doesn’t take any damage but the player’s fall height is reset.

## if

The player fall height example would use the following [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax):

```verse
expression0
if (test-arg-block):
    expression1
expression2
```

After executing `expression0`, the Verse program enters the if-block. If the `test-arg-block` succeeds, then the Verse program executes `expression1`, which can be one expression or a block of expressions. Otherwise, if the `test-arg-block` fails, the Verse program skips `expression1` and only executes `expression2`.

[![Diagram of how if expressions work with the example of fall height](https://dev.epicgames.com/community/api/documentation/image/f0b0bff8-4ea6-4b96-a029-ffcc2515ce01?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f0b0bff8-4ea6-4b96-a029-ffcc2515ce01?resizing_type=fit)

*Flow diagram for if-block logic.*

## if ... else

You can also specify an expression to execute when the `if` expression fails.

For example, the player should gain a double-jump ability if they fall less than three meters and if their jump meter is at 100 percent. But if they fall more than three meters or their jump meter isn’t at 100 percent, then the character’s arms will flap to let the player know they cannot double jump.

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

    if (PlayerFallHeight < 3.0 and JumpMeter = 100):
    # Perform a double jump.
        ActivateDoubleJump()
    # Reset the player’s fall height.
        ZeroPlayerFallHeight()
    else:
    # Flap the character’s arms to tell the player they
    # cannot double jump right now!
        ActivateFlapArmsAnimation()

    # Set the double-jump cooldown so rapidly pressing Jump does
    # not cause the "flap arms" animation to play inappropriately.
    SetDoubleJumpCooldown()
```

In this example, the condition of `if` evaluates whether `PlayerFallHeight` is less than three meters and if `JumpMeter` is equal to 100 percent. If the condition succeeds, `ActivateDoubleJump()` and `ZeroPlayerFallHeight()` are executed before `SetDoubleJumpCooldown()`.

If the `if` condition fails, then the expression `ActivateFlapArmsAnimation()` following `else` is executed before `SetDoubleJumpCooldown()`.

Syntactically, the if-else example looks like this:

```verse
expression0
if (test-arg-block):
    expression1
else:
    expression2
expression3
```

[![Example of how if/else expressions work using logic for jumping and fall heights](https://dev.epicgames.com/community/api/documentation/image/cdebe1bd-5187-4404-af47-6ae39056e6bf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cdebe1bd-5187-4404-af47-6ae39056e6bf?resizing_type=fit)

*Flow diagram for if-else-block logic.*

## if ... else if ... else

If a player has 100 percent shields when they fall more than three meters, they should take maximal damage but still survive. And let’s modify the rule that gives players a double-jump ability, such that players will only gain double-jump if they fall less than three meters and if their jump meter is greater than 75 percent.

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

    if (PlayerFallHeight > 3.0 and shields = 100):
        DealMaximalDamage()
        return false
    else if (PlayerFallHeight < 3.0 and JumpMeter > 75):
        ActivateDoubleJump()
        return false
    else:
        return true

    # Reset the player’s fall height
    ZeroPlayerFallHeight()
```

Syntactically, the if-else if-else example looks like this:

```verse
expression0

    if (test-arg-block0):
        expression1
    else if (test-arg-block1):
        expression2
    else:
        expression3
    expression4
```

[![An example of if/else if/else expression in Verse using shield and jumping variables](https://dev.epicgames.com/community/api/documentation/image/decec420-1866-4ed3-b69e-804712d60edb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/decec420-1866-4ed3-b69e-804712d60edb?resizing_type=fit)

*Flow diagram for if-else if-else-block logic.*

## if ... then

You can write any of the `if` conditions in the previous examples on multiple lines without changing how they work:

```verse
expression0
if:
 test-arg-block
then:
    expression1
expression2
```

The code block `test-arg-block` can contain one or more lines of conditions but they must all succeed to execute `expression1` before `expression2`, otherwise only `expression2` will be executed.

The example from the if ... else section rewritten in this format looks like:

```verse
var PlayerFallHeight : float = CalculatePlayerFallHeight()

if:
    PlayerFallHeight < 3.0
    JumpMeter = 100
then:
    # Perform a double jump.
    ActivateDoubleJump()
    # Reset the player’s fall height.
    ZeroPlayerFallHeight()
else:
    # Flap the character’s arms to tell the player they
    # cannot double jump right now!
    ActivateFlapArmsAnimation()

# Set the double-jump cooldown so rapidly pressing Jump does
# not cause the "flap arms" animation to play inappropriately. 
SetDoubleJumpCooldown()
```

## Single-Line Expression

You can write an `if else` as a single-line expression, similar to ternary operators in other programming languages. For example, if you want to assign a maximum or minimum `Recharge` value based on a player’s `ShieldLevel`, you can write the following Verse code:

```verse
Recharge : int = if(ShieldLevel < 50) then GetMaxRecharge() else GetMinRecharge()
```

## Predicate Requirements

The [predicate](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#predicate) of the `if`, which is the expression between the parentheses (), is unlike other programming languages, in that it is not expected to return a Boolean (called `logic` in Verse). Instead, the predicate is expected to have the `decides` effect (note that though subtyping normally allows for a subset of effects in places allowing a set of effects, if requires the overall effect of the predicate to include `decides`). The effect is removed from the surrounding scope. That is to say, the `decides` effect from all operations in the `if` predicate is consumed by the `if` construct. For example, in the code below, `Main` does not have the `decides` effect, though it invokes `Foo`, which does.

```verse
Foo()<transacts><decides> : void = {}

Bar() : void = {}

Main() : void =
    if (Foo[]):
        Bar()
```

This is because, rather than using a `logic` input to `if` to choose which branch is taken, the success of the operations contained in the predicate of the `if` is used to decide the appropriate branch - the `then` branch if all operations succeed, the `else` branch (if present) if any operations fail. Note that this means arbitrary operations can be used in the `if` predicate, including introducing constants. For example:

```verse
Main(X : int) : void =
    Y = array{1, 2, 3}
    if:
        Z0 := Y[X]
        Z1 := Y[X + 1]
    then:
        Use(Z0)
        Use(Z1)
```

Put another way, the scope of the `then` branch includes any names introduced in the `if` predicate.

## Transactional Behavior

Another deviation of `if` with respect to other programming languages is the transactional behavior of the predicate to `if`. The predicate to `if` must not have the `no_rollback` effect (implicitly used by all functions that do not explicitly specify `transacts`, `varies`, or `computes`). This is because in the event the predicate fails, all operations taken during the execution of the predicate (short of any operation impacting resources outside of the runtime, such as file I/O, or writing to console) are undone before execution of the `else` branch. For example:

```verse
int_ref := class:
    var Contents : int

    Incr(X : int_ref)<transacts> : void =
        set X.Contents += 1

Foo(X : int) : int =
    Y := int_ref{Contents := 0}
    if:
        Incr(Y)
        X > 0
    then:
        Y.Contents
    else:
        Y.Contents
```

The function `Foo(-1)` will return `0`, while `Foo(1)` will return `1`. This is because, though the call to `Incr` occurs before the test of `X > 0`, the mutation of `Y` it causes is undone before execution of the `else` branch. Note that `Incr` had to manually specify the `transacts` effect. By default, transactional behavior is not provided, indicated by the implicit `no_rollback` effect, but it can be added by specifying the `transacts` effect manually (overriding the implicit `no_rollback` effect).
