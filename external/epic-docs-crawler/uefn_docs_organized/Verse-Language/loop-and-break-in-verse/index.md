# Loop and Break

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/loop-and-break-in-verse
> **爬取时间**: 2025-12-26T23:51:55.611364

---

With the **`loop` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression)**, the expressions in the loop [block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) are repeated for every [iteration](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#iterate) of the loop.

The GIF below of the Fortnite Emote Clean Sweep is an example of how a `loop` works. The GIF plays to the end, then repeats from the beginning, and the player emoting is like the expressions in a loop block.

[![GIF of a character sweeping](https://dev.epicgames.com/community/api/documentation/image/fc91afc2-279c-453e-ac64-5cb6c3eab408?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fc91afc2-279c-453e-ac64-5cb6c3eab408?resizing_type=fit)

```verse
# GIF
    loop:
        DoCleanSweepEmote()
```

Like a GIF, a loop block will repeat forever unless instructed to do otherwise. This is called an **infinite loop**.

Infinite loops are not very useful in most cases since they will block progress for the program, so Verse provides a way to end and / or suspend.

- **End**: You can end a loop by exiting with either [break](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#break) or `return`.
- **Suspend**: You can suspend a loop if it's used in an `async` expression. See [Concurrency Overview](concurrency-overview-in-verse) for more details.

It's also possible to do both in the same loop. In this example, the loop block repeats until the random number that's generated is less than twenty.

```verse
loop:
        # generate random number
        RandomNumber : int = GetRandomInt(0, 100)
        # check if random number is less than twenty
        if (RandomNumber < 20):
            # exit loop
            break
```

Syntactically, this is the same as:

```verse
expression0
    loop:
        expression-block
        if (test-arg-block):
            break
        expression-block
    expression2
```

[![Loop flow diagram](https://dev.epicgames.com/community/api/documentation/image/e9f8747f-0f71-4ece-8278-306e9c1e513c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9f8747f-0f71-4ece-8278-306e9c1e513c?resizing_type=fit)

Unlike some of the other [control flow](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) expressions, the loop expression returns [void](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), so it may not be useful in cases where you want an expression to return a result. If the loop is inside a [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary), then it's possible to return a value with `return`, but this will exit not only out of the loop but also out of the function.

## Nested Loop Expressions

You can [nest](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nested) one loop inside another loop. The first loop is sometimes called the **outer loop**, and the second loop is called the **inner loop**. When the `break` [expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#expression) is executed in an inner loop, it only breaks out of the inner loop.

In the example below, the outer loop continues to `expression3`, then the `if` expression after the inner loop exits and can execute `expression1` and the inner loop again.

```verse
expression0
    # outer loop
    loop:
        expression1
        # inner loop
        loop:
            expression2
            if (test-arg-block0):
                # exit inner loop
                break
        expression3
        if (test-arg-block1):
            # exit outer loop
            break
    expression4
```

[![Nest loop block diagram](https://dev.epicgames.com/community/api/documentation/image/31f2a49c-b0c5-4503-a204-9d79f6142ea7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31f2a49c-b0c5-4503-a204-9d79f6142ea7?resizing_type=fit)
