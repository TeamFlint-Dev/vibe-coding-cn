# Common Types

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/common-types-in-verse
> **爬取时间**: 2025-12-26T23:52:52.387601

---

Verse is a [strongly-typed](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#strongly-typed) programming language, which means a [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) is assigned to every [identifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#identifier). With strong typing, code won't produce unpredictable results during [runtime](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#runtime) because the types for identifiers are known, along with how [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation) affect those types.

There are instances where the type is not explicitly required, such as when creating a [constant](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#constant). In the example `MyConstant := 0`, the type for `MyConstant` is inferred to be [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) because an [integer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#integer) value is assigned to it even though the `int` type wasn’t explicitly provided. In instances like this, the type is inferred.

Verse has [built-in types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#built-in-type) that support the fundamental [operations](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#operation) most programs need to perform. You can create your own types by combining these into larger structures, but these common types are important to understand as the foundation for using variables and constants in Verse.

The following pages describe the common types of Verse:

[![Logic](https://dev.epicgames.com/community/api/documentation/image/940c8e7a-3edd-4c17-9b60-044c1b8fb207?resizing_type=fit&width=640&height=640)

Logic

The logic type represents the Boolean values true and false.](https://dev.epicgames.com/documentation/en-us/fortnite/logic-in-verse)[![Int](https://dev.epicgames.com/community/api/documentation/image/8decb59c-4ee8-4147-ab27-d947f58dd688?resizing_type=fit&width=640&height=640)

Int

The int type represents integer (non-fractional number) values.](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse)[![Float](https://dev.epicgames.com/community/api/documentation/image/e39f7e56-3f93-47d2-937f-97d688e2b15c?resizing_type=fit&width=640&height=640)

Float

The float type represents all non-integer numerical values. It can hold large values and precise fractions.](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse)[![String](https://dev.epicgames.com/community/api/documentation/image/1fd3ea7a-7c0d-4dea-bcf1-a4e529b04c54?resizing_type=fit&width=640&height=640)

String

The string type represents non-numerical values like words, names, sentences, and other collections of characters.](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse)[![Rational](https://dev.epicgames.com/community/api/documentation/image/3af49836-b19d-4549-bc4b-10fb2a5ea546?resizing_type=fit&width=640&height=640)

Rational

The rational type is used as the result of integer division.](https://dev.epicgames.com/documentation/en-us/fortnite/rational-in-verse)[![Any](https://dev.epicgames.com/community/api/documentation/image/10698879-a819-4c66-b956-803caad59804?resizing_type=fit&width=640&height=640)

Any

Any is the supertype of all types, meaning whatever behavior is defined for it is also defined for all the any subtypes.](https://dev.epicgames.com/documentation/en-us/fortnite/any-in-verse)[![Comparable](https://dev.epicgames.com/community/api/documentation/image/6c3addbb-ae62-46d0-b665-8959d351896c?resizing_type=fit&width=640&height=640)

Comparable

A subtype of any, comparable adds the requirement that any value of this type can be compared to any other value of this type.](https://dev.epicgames.com/documentation/en-us/fortnite/comparable-in-verse)[![Void](https://dev.epicgames.com/community/api/documentation/image/3a01a400-ef16-4523-afd9-782576c6e6c6?resizing_type=fit&width=640&height=640)

Void

The void type can only be used as a return type of a function and indicates that the result of the function is not useful.](https://dev.epicgames.com/documentation/en-us/fortnite/void-in-verse)
