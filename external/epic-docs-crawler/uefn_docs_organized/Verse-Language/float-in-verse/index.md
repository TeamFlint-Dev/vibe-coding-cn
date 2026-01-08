# Float

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse>
> **爬取时间**: 2025-12-26T23:52:21.004166

---

Verse uses `float` as the [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) for storing and handling [floating point numbers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#floating-point-number), such as `1.0`, `-50.5`, and `3.14159`.

A float in Verse is an [IEEE 64-bit float](https://en.wikipedia.org/wiki/Double-precision_floating-point_format), which means it can contain a positive or negative number that has a decimal point in the range [`-2^1024 + 1`, … , `0`, … , `2^1024 - 1`], or has the value `NaN` (Not a Number).

The implementation for float differs from the [IEEE standard](https://standards.ieee.org/ieee/754/4211/) in the following ways:

- There is only one `NaN` value.
- `NaN` is equal to itself.
- Every number is equal to itself. If two numbers are equal, then no pure Verse code can observe the difference between them.
- `0` cannot be negative.

You can include predefined float values within your code as float [literals](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#literal). A float literal is a floating point number in your code.

The following is an example of how to create a float [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) named `MaxHealth`, [initialized](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) with the float literal `100.0`:

```verse
MaxHealth : float = 100.0
```

## Float Operations

Floats support math [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation) and [comparisons](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) with other floats.

### Math

You can do the four basic [math operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#math-expression) with floats in Verse: `+` for addition, `-` for subtraction, `*` for multiplication, and `/` for division.

There are also combined [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) for doing the basic math operations (addition, subtraction, multiplication, and division), and updating the dereferenced value of a [pointer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#pointer). These combined operators are the same as assigning the result to the first operand of the math operation.

For example, the following code instantly halves the value of `CurrentHealth`:

```verse
# Start with the original health value
var CurrentHealth : float = 75.0
 
# Reduce it to half
set CurrentHealth *= 0.5
 
# CurrentHealth is now 37.5.
```

### Signed Floating Point Numbers

A signed float is a value that can be positive, or negative, or zero. The operator `-` can be used to negate a float if `-` appears before the float, for example `-3.2`.
You can also use the operator `+` before a float to help align your code visually, but it won’t change the value of the float.
In the following code, a "life drain" attack heals the attacker for one eighth of the damage inflicted on the target.

```verse
# Set up the parameters that describe the situation
DamageInflicted : float = 10.0
LifeDrainMultiplier : float = 0.125
var CurrentAttackerHealth : float = 99.0
 
# Increase current health based on damage inflicted.
set CurrentAttackerHealth += DamageInflicted * HealingMultiplier
 
# CurrentAttackerHealth is now 100.25.
```

### Comparison

You can use the [failable operator](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression) `=` to test if two floats are equal, and the failable operator `<>` to test for inequality.

Since numbers are ordered, you can use the failable operator `<` to test if one float is less than another float, and the failable operator `>` to test if one float is greater than another float.

You can use the failable operator `<=` to test if one float is less than or equal to another float, and the failable operator `>=` to test if one float is greater than or equal to another float.

`NaN` is comparable like other floats, and `NaN` is larger than all other floats and equal to itself.

```verse
# Set up the parameters that describe the situation
DamageInflicted : float = 10.0
LifeDrainMultiplier : float = 0.125
var CurrentAttackerHealth : float = 99.0
MaxAttackerHealth : float = 100.0
 
# Increase current health based on damage inflicted.
set CurrentAttackerHealth += DamageInflicted * HealingMultiplier
 
# Ensure that the attacker does not heal beyond their maximum health
if (CurrentAttackerHealth > MaxAttackerHealth):
    # Too high! Reduce to the maximum value.
    set CurrentAttackerHealth = MaxAttackerHealth
 
# CurrentAttackerHealth is now 100.0.
```

## Standard Library

The [standard library](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) provides functions to help with creating and using floats, and common math structures and functions. Refer to the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api) for more details on these functions.

Persistable Type
Floating point values are persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
