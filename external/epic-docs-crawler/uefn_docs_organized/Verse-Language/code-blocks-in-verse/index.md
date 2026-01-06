# Code Blocks

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/code-blocks-in-verse
> **爬取时间**: 2025-12-26T23:52:26.293413

---

A **code block**, or block, is a group of zero or more [expressions](expressions-in-verse) that introduces a new [scoped](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#scope) [body](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#body). (A block with zero expressions would be an empty block, and ideally would only be used as a placeholder to be filled in later.)

Code blocks can only appear after [identifiers](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#identifier).

**Scope** refers to the part of the program where the association of an identifier (name) to a [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) is valid, and where that name can be used to refer to the value. For example, any [constants](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant) or [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that you create within a code block only exist in the context of the code block. This means that the [lifetime](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#lifetime) of objects is limited to the scope they're created in and they cannot be used outside of that code block.

The following example shows how to calculate the maximum number of arrows that can be bought with the number of coins the player has. The constant `MaxArrowsYouCanBuy` is created within the `if` block and therefore its scope is limited to the `if` block. When the constant `MaxArrowsYouCanBuy` is used in the print string, it produces an error because the name `MaxArrowsYouCanBuy` doesn't exist in the scope outside of the `if` expression.

```verse
CoinsPerQuiver : int = 100
ArrowsPerQuiver : int = 15
var Coins : int = 225

if (MaxQuiversYouCanBuy : int = Floor(Coins / CoinsPerQuiver)):
    MaxArrowsYouCanBuy : int = MaxQuiversYouCanBuy * ArrowsPerQuiver

Print("You can buy at most {MaxArrowsYouCanBuy} arrows with your coins.") # Error: Unknown identifier MaxArrowsYouCanBuy
```

Verse doesn't support reusing an identifier even if it's declared in a different scope, unless you can [qualify](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#qualify) the identifier by adding `(qualifying_scope:)` before the identifier, where qualifying\_scope is the name of an identifier's module, class, or interface. Whenever you define and use the identifier, you must also add a qualifier to the identifier.

For more details, see [module](https://dev.epicgames.com/documentation/en-us/fortnite/modules-and-paths-in-verse), [class](class-in-verse), and [interface](interface-in-verse).

## Code Block Formats

Code blocks have three possible formats in Verse. They are all [semantically](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#semantics) equivalent, so you can change the style of a code block without changing what it does.

If you [nest](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested) a code block inside of another code block, you must still use an identifier at the beginning of the nested code block. To nest code, use the [block](https://dev.epicgames.com/documentation/en-us/fortnite/block-in-verse) expression.

### Spaced Format

With this format, the block begins with `:`, with each expression that follows on its own line. Each line is uniformly indented four spaces.

```verse
if (test-arg-block):
    expression1
    expression2
```

Note that `if (test-arg-block)` is not part of the block, but the block starts at the end of that line with `:`.

You can also use `;` to separate multiple expressions on a single line.

### Multi-Line Braced Format

The block is enclosed by `{}`, and expressions are on new lines.

```verse
if (test-arg-block)
{
    expression1
    expression2
}
```

You can also use `;` to separate multiple expressions on a single line.

### Single-Line Dot Format

With this format, the block begins with `.` with each expression on the same line, and each expression is separated by `;` instead of being placed on a new line.

```verse
if (test-arg-block). expression1; expression2
```

If you use the single-line dot format in an `if` expression that has an `else`, then you can only have one expression before the `else`. For example:

```verse
if (test-arg-block). expression1 else. expression2
```
