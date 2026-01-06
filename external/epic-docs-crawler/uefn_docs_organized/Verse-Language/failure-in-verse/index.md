# Failure

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/failure-in-verse
> **爬取时间**: 2025-12-26T23:50:05.720254

---

**Failure is control flow in Verse.**

Unlike other programming languages that use the [Boolean](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#boolean) values true and false to change the flow of a program, Verse uses [expressions](https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse) that can either succeed or [fail](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). These expressions are called **failable expressions**, and can only be executed in a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context).

But `failure` is more than a simple Boolean value in Verse. Failure drives the flow of control. A failable expression can succeed and yield a value, or fail and return no value, and failable expressions are only allowed in a failure context, unlike other programming languages, where control flow is decided through Boolean values.

Using failure for [control flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) means that work doesn’t have to be duplicated, and that you can avoid subtle errors.

For example, in other languages, you have to check that an [index](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#index) for an [array](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) is valid before accessing the array element at that index, which is a common cause of errors in other languages.

In Verse, validation and access are combined to avoid this.

For example:

```verse
if (Element := MyArray[Index]):
        Log(Element)
```

## Failable Expression

A failable expression is an [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) that can either succeed and produce a [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value), or fail and return no value. Examples of failable expressions include indexing into an array because an invalid index will fail, and using [operators](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operator) such as comparing two values.

Code that you write isn’t failable by default. For example, to write a [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) that can fail, you must add the effect [specifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) `<decides>` to the function definition. Currently it is also necessary to add `<transacts>` when using `<decides>`.

For a full list of expressions that are failable, refer to the list of [Expressions](https://dev.epicgames.com/documentation/en-us/fortnite/expressions-in-verse) in Verse.

## Failure Context

A failure context is a [context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#context) where it is allowable to execute failable expressions. The context defines what happens if the expression fails. Any failure within a failure context will cause the entire context to fail.

A failure context allows nested expressions to be failure expressions, such as function arguments or expressions in a `block` expression.

A useful aspect of failure contexts in Verse is that they are a form of **speculative [execution](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#execution)**, meaning that you can try out actions without [committing](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#commit) them. When an expression succeeds, the effects of the expression are **committed**, such as changing the value of a variable. If the expression fails, the effects of the expression are [rolled back](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#rollback), as though the expression never happened.

This way, you can execute a series of actions that accumulate changes, but those actions will be undone if they fail anywhere.

To make this work, all functions called in the failure context must have the effect specifier `<transacts>`, and the compiler will complain if they don't.

User-defined functions do not have the `transacts` effect by default. An explicit `<transacts>` specifier must be added to their definitions. Some native functions also do not have the `transacts` effect and can't be called in failure contexts.

An example of a native function without `transacts` could be an audio\_component with a `BeginSound()` method. If the sound is started then even if it is stopped it could have been noticed.

The following list includes all of the failure contexts in Verse:

- The condition in `if` expressions.

  ```verse
  if (test-arg-block) { … }
  ```
- The iteration expressions and filter expressions in `for` expressions. Note that `for` is special in that it creates a failure context for each iteration. If iterations are [nested](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested), then the failure contexts will also be nested. When an expression fails, the innermost failure context is aborted, and the enclosing iteration, if any, continues with the next iteration.

  ```verse
  for (Item : Collection, test-arg-block) { … }
  ```
- The body of a function or method that has the `<decides>` effect specifier.

  ```verse
  IsEqual()<decides><transacts> : void = { … }
  ```
- The operand for the `not` operator.

  ```verse
  not expression
  ```
- The left operand for `or`.

  ```verse
  expression1 or expression2
  ```
- Initializing a variable that has the `option` type.

  ```verse
  option{expression}
  ```
