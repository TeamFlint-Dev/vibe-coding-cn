# String

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse
> **爬取时间**: 2025-12-26T23:52:40.797260

---

Verse uses `string` as the [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) for storing and handling text, such as `"Hello Verse"` and `"Epic Games"`. In Verse, a string can contain letters, numbers, punctuation, spaces, and emojis. A string containing no characters `""` is called an **empty string**.

You can include predefined string [values](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) within your code as string [literals](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#literal). A string literal is a sequence of characters in your code surrounded by double quotation marks `" "`.

The following is an example of how to create a string [variable](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) named **Hello**, and [initialized](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) with the string literal `"Hello world"`:

```verse
Hello : string = "Hello world"
```

## Character Encoding

Character encoding is the mapping between a text character and data that the computer can understand, called a [code point](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-point).

Verse uses the UTF-8 [Unicode](https://www.unicode.org/versions/Unicode14.0.0/) character-encoding scheme, a standard developed by the [Unicode Consortium](http://www.unicode.org/consortium/consort.html) to provide comparable support for characters across languages, platforms, and devices.

For example, the emoji in this string `"🐈"` can also be represented by the emoji’s Unicode [code point](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-point) `"{0u1f408}"`. For a full list of characters supported in Unicode and their corresponding code points, refer to the [Unicode documentation](https://www.unicode.org/versions/Unicode14.0.0/).

The UTF-8 [code unit](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-unit) is [8-bits](unreal-editor-for-fortnite-glossary#bit) (one [byte](unreal-editor-for-fortnite-glossary#byte)), and encodes characters with code points that are one to four bytes long. Code points with a lower value use fewer bytes than code points with higher values. For example, `"a"` uses one byte `"{0o61}"`, while `"á"` uses two bytes `"{0oC3}{0oA1}"`.

## String Operations

Strings support [concatenation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#concatenation), [comparison](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), [indexing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#index), getting the length of the string, and string [interpolation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#interpolation).

### Concatenation

Concatenation is when one string is appended to another string. You can use the [operator](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) `+` to concatenate strings.

For example, the following code results in the variable `Announcement` containing the string `"...And the winner is: Player One!"`.

```verse
# The winning player's name:
WinningPlayerName : string = "Player One"
# Build a message announcing the winner.
Announcement : string = "...And the winner is: " + WinningPlayerName + "!"
```

### String Interpolation

You can inject a value into a string if it has a valid `ToString()` function defined in the current scope.

For example, the following code results in the variable `Announcement` containing the string `"...And the winner is: Player One!"`.

```verse
# The winning player's name:
WinningPlayerName : string = "Player One"
# Build a message announcing the winner.
Announcement : string = "...And the winner is: {WinningPlayerName}!"
```

### Comparison

Whether two strings are equal depends on whether they use the same characters.

Comparison of strings in Verse is done by comparing the code points of each character. Comparison of two strings is case sensitive, because uppercase and lowercase characters have different code points.

You can use the failable operator `=` to test if two strings are equal, and the failable operator `<>` to test for inequality.

There can be multiple ways to represent the same character in Unicode. For example, `"é"` is `"{0u0049}"`, but you can also use two code points: `"{0u0065}"`, which is `"e"`, and `"{0u0301}"`, which is a combining accent. This means that if you compare these strings, which both appear to be the character `"é"` but the strings use different code points, the strings will not be equal. `"{0u0049}"` is not the same as `"{0u0065}{0u0301}"`.

The following example would check to see if the player has used the correct item to make progress in an adventure/puzzle game:

```verse
# This is the item the puzzle requires to unlock the next step:
ExpectedItemInternalName : string = "RedPotion"
# This is the item that the player has selected:
SelectedItemInternalName : string = "BluePotion"
	
# Check to see if the player has the right item selected.
if (SelectedItemInternalName = ExpectedItemInternalName):
    # They do! Report that the puzzle can proceed to the next step.
    return true

# They do not. Report that this item does not advance the puzzle.
return false
```

### Length

You can get the number of UTF-8 code units in a string by accessing the member `Length` on the string. For example, `"hey".Length` is 3.

The length of a string accounts for the amount of data it takes to represent the string in UTF-8 code units. For example, `"héy".Length` is 4, because it takes an extra UTF-8 code unit to represent the character `é`, even though the string appears to have three characters. The following code displays a "seconds" timer with two digits. It will pad the display with a leading zero if needed.

```verse
# SecondsRemaining is assumed to be non-negative
SecondsRemaining : int = 30
	
# Automatically convert the int representation to a string:
SecondsString:string = SecondsRemaining

# Set up the timer display string.
var Combined : string = "Time Remaining: "
	
# If the string is too long, replace it the maximum two-digit value, 99.
if (SecondsString.Length > 2):
    # Too much time on the clock! Set the string to a hard-coded max value.
    set Combined += "99"
else if (SecondsString.Length < 2):
    # Pad the display with a leading zero.
    set Combined += "0{SecondsString}"
else:
    # The string is already the exact length, so add it.
    set Combined += SecondsString
```

### Index

You can access the UTF-8 code unit at a specific index of the string. The first UTF-8 code unit in a string has an index of 0, and each subsequent code unit index increases in number.

For example, `"cat"[0]` is `"c"` and `"cat"[1]` is `"a"`.

|  |  |  |  |
| --- | --- | --- | --- |
| **Index** | 0 | 1 | 2 |
| **Character** | `"c"` | `"a"` | `"t"` |
| **Code Unit** | `"{0o63}"` | `"{0o61}"` | `"{0o74}"` |

In cases where a string has characters that are represented by more than one code unit, there will be an index for each code unit. For example, `"á"` is represented by two UTF-8 code units `"{0oC3}{0oA1}"`, so `"cát"[1]` is `"{0oC3}"` and `"cát"[2]` is `"{0oA1}"`.

|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| **Index** | 0 | 1 | 2 | 3 |
| **Character** | `"c"` | `"á"` |  | `"t"` |
| **Code Unit** | `"{0o63}"` | `"{0oC3}"` | `"{0oA1}"` | `"{0o74}"` |

The last index in a string is one less than the length of the string. For example, `"cat".Length` is 3 and the index for `"t"` in `"cat"` is 2.

## Standard Library

The [standard library](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) provides functions to help with creating and using strings. Refer to the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api) for more details on these functions.

## Alternate Representations of Characters

Some characters have alternate representations when they’re used in a string. For example, `"{}"` can be used for [string interpolation](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse) or for the code points of characters, but they can also be used as the brace characters {} themselves in text.

To be able to use an alternate representation of a character in a string, you must add the [escape character](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#escape-character) `"\"` before the character in the string. For example, `"\{\}"` is rendered as {} in text, and `"\n"` starts a new line in text.

## Implementation Details

The `string` type is a [type alias](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type-alias) of `[]char`, an [array](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) of UTF-8 code units. Because string is a type alias for an array, string has the same behavior as arrays.

There are two [primitive types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#primitive-type) for characters, depending on their size and code point format — `char` and `char32`. The only capabilities of `char` and `char32` in Verse are for comparison, and to access their values.

| Primitive Type | Description | Supported Formats |
| --- | --- | --- |
| **char** | A primitive type that represents a single UTF-8 code unit (one byte), up to the value 256 (`0off`). | Code units of the form 0oXX. For example, `0o52`. |
| **char32** | A primitive type that represents a Unicode code point. | Code points of the form 0uXXXX. For example, `0u0041`. |

You can also express literals with single quotes. Whether the primitive type of the string in single quotes is `char` or `char32` depends on the UTF-8 code units used for the character. For example, `'e'` is `char`, and `'é'` is `char32`.

## Persistable Type

String, char, and char32 values are all persistable, which means that you can use them in your module-scoped `weak_map` variables and have their values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).
