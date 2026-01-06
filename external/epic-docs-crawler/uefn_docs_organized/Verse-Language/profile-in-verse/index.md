# Profile

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/profile-in-verse
> **爬取时间**: 2025-12-27T02:08:04.983542

---

With the `profile` expression, you can instrument your code to measure its performance. The following is the syntax for using a `profile` expression in a code block.

```verse
code-before
profile:
    code-to-measure
code-after
```

In this example, `slow-code` represents a code block that the user wants to measure for performance. When the code is run, the amount of time in milliseconds between entering and exiting the `profile` code block is printed to the [Output Log](user-interface-reference-for-unreal-editor-for-fortnite#outputlog) in UEFN.

You can find the output for the code profiled as `LogVerse: VerseProfile: 0.023900 ms`. If you have multiple profile expressions in your code and want to organize the output, you can add a string to your profile expression as a user Tags:

```verse
profile(“User String to Categorize Output”):
    code-to-measure
```

In this example, the output would look like `LogVerse: VerseProfile: User String to Categorize Output 0.023900 ms`.

If you use the `profile` expression within a [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context) that also has print logging, all profile output is reported first before the prints in the Output Log, regardless of the order of the `profile` expressions and print calls in the code.

If the `profile` code block has a [`defer`](defer-in-verse) expression, the `defer` expression will also be profiled but will run last on exiting the `profile` code block.

```verse
MyFunction1():void=
    defer:
        MyFunction2() # code is not profiled
    profile:
        defer:
            MyFunction3() # code is profiled and run last
       MyFunction4()  # code is profiled and run first
```

## Result

Everything in Verse is an expression, which means it has a result, and this includes the `profile` expression. The `profile` expression passes result values through in the same way as [if](https://dev.epicgames.com/documentation/en-us/fortnite/if-in-verse) expressions.

In this example, `MyFunction` returns some value which is passed through the `profile` expression and stored in the `ResultOfFunction` variable. This means you can facilitate code instrumentation around function calls and be able to use the results of the function calls outside the profile code block scope.

```verse
ResultOfFunction := profile(“MyFunction”):
    MyFunction()
```

## Tips and Best Practices

When working with the `profile` expression, keep in mind the following tips and best practices:

- The timings reported by the `profile` expressions are not deterministic for a given piece of code. The actual measured time may or may not depend on many factors out of your control such as the state of the game, the number of players, load on the server hardware, network latency, and more. It is best to profile a piece of code multiple times to determine the best, average, and worst cases as well as to understand which data points are outliers.
- Profiling has a small overhead, mostly due to the logging and any string interpolation for the user tag. This may add a small amount of time to your profiling result, so try to target your profiling to areas of interest, and keep your user tags simple.
- Avoid nesting `profile` expressions. It will work, but the profiling overhead of the inner `profile` expression will be included in the timing of the outer `profile` expression which will affect your results.
- Remove `profile` expressions from your shipping game code. The profile code generation is not currently excluded from the shipping builds, so it will introduce an undesired overhead on any in-game code that you have if you keep it in.

## Known Limitations

The following are known limitations of using the `profile` expression.

You can use the `profile` expression within an async context, but you cannot currently call async code in a `profile` code block. The following example demonstrates this.

```verse
MyAsyncFunction()<suspends>:void=
    profile: # Allowed inside <suspends> function
        MyRandomInt := GetRandomInt(10, 100) # Allowed inside profile
        Sleep(0.0) # Not allowed inside profile
```

You cannot use the `profile` expression with static data initialization of `class` members. The following example is not allowed.

```verse
my_class := class:
    Value:int = profile{ 1 + 2 + 3 }
```
