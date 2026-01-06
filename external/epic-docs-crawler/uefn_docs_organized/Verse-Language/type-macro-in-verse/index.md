# Type Macro

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/type-macro-in-verse
> **爬取时间**: 2025-12-26T23:52:03.476314

---

The `type` macro is a special Verse construct that can be used to define functions or construct new types from existing types using `where` clauses. The `type` macro can be used anywhere a type can be used. For example, the following example constructs a new type using a `where` clause, then uses that type in a function:

```verse
# Construct a new type with a where clause
uint8 := type{X:int where 0 <= X, X < 256}

# Define a new function using uint8
Foo():uint8 = 0
```

There `where` clause is only supported in function parameter definitions or as a range condition on numeric types.

The following example uses the `type` macro to define a function as an argument to a new function:

```verse
# Define a function with type
Bar(X:type{_():uint8}):uint8 = X()

# Call Bar with Foo argument
Y := Bar(Foo)
```

This example also makes use of the special `_` identifier, which can be used in `type` in places where an identifier is expected without having to actually provide a name that is otherwise unused. This is an indication to the reader that the expression itself is not important, but rather the definition that `_` is part of.

In addition to function with no special effects, the `type` macro is particularly useful to describe the types of functions with non-default effects. For example,

```verse
comparison := enum:
    LT
    EQ
    GT

Less(X:int, Y:int)<decides>:void =
    X < Y

Equal(X:t, Y:t where t:subtype(comparable))<decides>:void =
    X = Y

Greater(X:int, Y:int)<decides>:void =
    X > Y

# Type macro use with non-default effect <decides>
Comparison(Arg:comparison):type{_(:int,:int)<decides>:void} =
    case (Arg):
        comparison.LT => Less
        comparison.EQ => Equal
        comparison.GT => Greater
```

Here, the [comparison expression](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#comparison-expression) converts a comparison enumeration to the comparison operation each particular enumeration value corresponds to.
