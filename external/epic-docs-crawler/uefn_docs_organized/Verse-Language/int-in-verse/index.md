# Int

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse
> **爬取时间**: 2025-12-26T23:49:35.157042

---

Verse uses `int` as the [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) for storing and handling [integers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer). An `int` in Verse can contain a positive number, a negative number, or zero, and has no fractional component. Supported integers range from -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807, inclusive.

You can include predefined `int` values within your code as `int` [literals](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#literal). An `int` literal is an integer in your code.

The following are examples of how you can create integer [constants](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant) and [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) with `int` literals:

```verse
# This variable will never change, because it is universally correct.
AnswerToTheQuestion : int = 42
# A quiver of arrows costs this many coins, and cannot change:
CoinsPerQuiver : int = 100
# A quiver of arrows contains this many arrows, and cannot change:
ArrowsPerQuiver : int = 15
# The player currently has 225 coins and 3 arrows. These values can change.
var Coins : int = 225
var Arrows : int = 3
# The game keeps track of the total number of purchases the player makes.
# So far, the player has not bought anything.
var TotalPurchases : int = 0
```

## Int Operations

The `int` type supports math [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation) and comparisons with other integers.

### Math

You can use the four basic math operations with integers in Verse: `+` for addition, `-` for subtraction, `*` for multiplication, and `/` for division.

For integers, the operator `/` is [failable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failable-expression), and the result is a [rational](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) type if it succeeds.

The rational type can only be used as a parameter to the following functions:

- [`Floor()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/verse/floor): Rounds the rational value down to the closest integer.
- [`Ceil()`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/verse/ceil): Rounds the rational value up to the closest integer.

The following code uses integer division to determine how many arrows the player can buy with their coins. The integer division is used in an `if` expression because integer division is failable and so must be in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context):

```verse
if (NumberOfQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):
    NumberOfArrowsYouCanBuy : int = NumberOfQuiversYouCanBuy * ArrowsPerQuiver
```

You can also combine operators for basic math operations (addition, subtraction, and multiplication), and updating a variable's value. These combined operators are the same as assigning the result to the first [operand](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operand) of the math operation. The following code uses `int` math to sell the player arrows in exchange for coins:

```verse
# Take coins from the player. This can cause the player to go into negative
# coins if there is no check that the player has enough coins in advance.
set Coins -= CoinsPerQuiver
# Give arrows to the player.
set Arrows += ArrowsPerQuiver
# Count this as a purchase. We do not have a variable for this.
set TotalPurchases += 1
```

The operator `/=` is not supported for `int`, since the result of integer division is a rational type and therefore cannot be assigned to an `int`.

### Signed Integers

A signed integer is a value that can be positive, or negative, or zero. The operator `-` can be used to negate an integer if `-` appears before the integer, for example `-3`.
You can also use the operator `+` before an integer to help align your code visually, but it won’t change the value of the integer.

```verse
# This is an alternate way to sell arrows to the player. It is
# functionally identical to the code in the Math section above.
set Coins += -CoinsPerQuiver
set Arrows += +ArrowsPerQuiver
set TotalPurchases += +1
```

### Comparison

You can use the failable operator `=` to test if two integers are equal, and the failable operator `<>` to test for inequality.

Since numbers are ordered, you can use the failable operator `<` to test if one integer is less than another integer, and the failable operator `>` to test if one integer is greater than another.

You can use the failable operator `<=` to test if one integer is less than or equal to another integer, and the failable operator `>=` to test if one integer is greater than or equal to another integer.

```verse
# Check that the player can afford this purchase.
if (Coins >= CoinsPerQuiver):
    # They can! Proceed with the purchase
    set Coins -= CoinsPerQuiver
    set Arrows += ArrowsPerQuiver
    set TotalPurchases += 1
```

## Standard Library

The [standard library](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) provides functions to help with creating and using integers, and common math structures and functions. Refer to the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api) for more details on these functions.

## Alternate Representations of Integers

You can also use the [hexadecimal](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#hexadecimal) numeral system to represent integers, which is [base-16](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#base-16), instead of the decimal numeral system which uses base-10. This means that hexadecimal values are represented with the digits `0-9` and the letters `A-F`. For example, `0x7F` is the same as `127`, and `0xFACE` is the same as `64206`.

## Implementation Details

In a future update, `int` will semantically represent an integer of any size, but currently, an `int` in Verse is implemented as a signed 64-bit integer. Until this update, an `int` must be in the range [`-2^63`, … , `-1`, `0`, `1`, … , `2^63 - 1`], and integers, including the results of math operations that are outside this range for int sizes, will produce a runtime error called an *integer overflow*.

Although integers currently have these restrictions, Verse code with integers that you write today will semantically be the same as when integers can have arbitrary precision.

## Persistable Type

Integer values are persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
