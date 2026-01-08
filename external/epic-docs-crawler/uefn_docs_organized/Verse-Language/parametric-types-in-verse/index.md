# Parametric Types

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse>
> **爬取时间**: 2025-12-26T23:51:21.920568

---

[Parametric types](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parametric-type) refer to any [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) that can take a [parameter](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#parameter). You can use parametric types in Verse to define generalized data structures and operations. There are two ways to use parametric types as arguments: either in [functions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) as explicit or implicit type [arguments](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#argument), or in [classes](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) as explicit type arguments.

[Events](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) are a common example of parametric types and are used extensively throughout devices in UEFN. For instance, the Button device has the `InteractedWithEvent`, which occurs whenever a player interacts with the button. To see a parametric type in action, check out the `CountdownEndedEvent` from the [Custom Countdown Timer](https://dev.epicgames.com/documentation/en-us/fortnite/making-a-custom-countdown-timer-using-verse) tutorial.

## Explicit Type Arguments

Consider a `box` that takes two arguments. The `first_item` initializes an `ItemOne`, and the `second_item` initializes an `ItemTwo`, both of type [type](https://dev.epicgames.com/documentation/en-us/fortnite/type-macro-in-verse). Both `first_item` and `second_item` are examples of parametric types that are **explicit** arguments to a class.

```verse
box(first_item:type, second_item:type) := class:
    ItemOne:first_item
    ItemTwo:second_item
```

Because `type` is the type argument for `first_item` and `second_item`, the `box` class can be created with any two types. You could have a box of two `string` values, a box of two `int` values, a `string` and an `int`, or even a box of two boxes!

For another example, consider the `MakeOption()` function, which takes any type and returns an [`option`](option-in-verse) of that type.

```verse
MakeOption(t:type):?t = false

IntOption := MakeOption(int)
FloatOption := MakeOption(float)
StringOption := MakeOption(string)
```

You could modify the `MakeOption()` function to instead return any other container type, such as an `array` or a `map`.

## Implicit Type Arguments

Implicit type arguments for functions are introduced using the `where` keyword. For example, given a function `ReturnItem()`, which simply takes a parameter and returns it:

```verse
ReturnItem(Item:t where t:type):t = Item
```

Here, `t` is an implicit type parameter of the function `ReturnItem()`, which takes an argument of type `type` and immediately returns it. The type of `t` restricts what type of `Item` we can pass to this function. In this case since `t` is of type `type`, we can call `ReturnItem()` with any type. The reason to use implicit parametric types with functions is that it allows you to write code that works regardless of the type passed to it.

For example, instead of having to write:

```verse
ReturnInt(Item:int):int = Item

ReturnFloat(Item:float):float = Item
```

The single function could be written instead.

```verse
ReturnItem(Item:t where t:type):t = Item
```

This comes with the guarantee that `ReturnItem()` doesn't need to know what particular type the `t` is — whatever operation it performs, it will work regardless of the type of `t`.

The actual type to be used for `t` depends on how `ReturnItem()` is used. For example, if `ReturnItem()` is called with argument 0.0, then `t` is a `float`.

```verse
ReturnItem("t") # t is a string
ReturnItem(0.0) # t is a float
```

Here `"hello"` and `0.0` are the explicit arguments (the `Item`) passed to `ReturnItem()`. Both of these will work because the implicit type of `Item` is `t`, which can be any `type`.

For another example of a parametric type as an implicit argument to a function, consider the following `MakeBox()` function which operates on the `box` class.

```verse
box(first_item:type, second_item:type) := class:
    ItemOne:first_item
    ItemTwo:second_item

MakeBox(ItemOneVal:ValOne, SecondItemVal:ValTwo where ValOne:type, ValTwo:type):box(ValOne, ValTwo) =
    box(ValOne, ValTwo){ItemOne := ItemOneVal, ItemTwo := SecondItemVal}

Main():void =
    MakeBox("A", "B")
    MakeBox(1, "B")
    MakeBox("A", 2) 
    MakeBox(1, 2)
```

Here the `MakeBox()` function takes two arguments, `FirstItemVal` and `SecondItemVal`, both of type `type`, and returns a box of type (`type`, `type`). Using `type` here means we’re telling `MakeBox` that the returned box could be made up of any two objects; it could be an array, a string, a function, etc. The `MakeBox()` function passes both arguments to `Box`, uses them to create a box, and returns it. Note that both `box` and `MakeBox()` use the same syntax as a function [call](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call).

A built-in example of this is the function for the [Map](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) container type, given below.

```verse
Map(F(:t) : u, X : []t) : []u =
    for (Y : X):
        F(Y)
```

## Type Constraints

You can specify a constraint on the type of an expression. The only currently supported constraint is subtype, and only for implicit type parameters. For example:

```verse
int_box := class:
    Item:int

MakeSubclassOfIntBox(NewBox:subtype_box where subtype_box:(subtype(int_box))) : tuple(subtype_box, int) = (NewBox, NewBox.Item)
```

In this example, `MakeSubclassOfIntBox()` will only compile when passed a class that subclasses from `IntBox`, since SubtypeBox has the type `(subtype(IntBox))`. Note that `type` can be seen as shorthand for `subtype(any)`. In other words, this function accepts any subtype of `any`, which is every type.

## Covariance and Contravariance

Covariance and Contravariance refer to the relationship of two types when the types are used in [composite types](composite-types-in-verse) or functions. Two types that are related in some way, such as when one subclasses from the other, are either covariant or contravariant to each other depending on how they are used in a particular piece of code.

**Covariant**: Using a more specific type when the code expects something more generic.

**Contravariant**: Using a more general type when the code expects something more specific.

For instance, if we we could use an `int` in a situation where any `comparable` would be accepted (such as a `float`), our `int` would be acting **covariantly**, since we’re using a more specific type when a more generic one is expected. On the reverse, if we could use any `comparable` when normally an `int` would be used, our `comparable` would be acting **contravariantly**, since we’re using a more generic type when a more specific one is expected.

An example of covariance and contravariance in a parametric type might look like the following:

```verse
MyFunction(Input:t where t:type):logic = true
```

Here `t` is used contravariantly as the input to the function, and `logic` is used covariantly as the output to the function.

It is important to keep in mind that the two types are not inherently covariant or contravariant to each other, rather whether they’re acting as covariant or contravariant depends on how they’re used in the code.

### Covariant

Covariance means to use something more specific when you expect something generic. Usually this is for output from a function. All type uses that aren’t inputs to functions are covariant uses.
A generic parametric type example below has `payload` acting covariantly.

```verse
DoSomething():int =
    payload:int = 0
```

For instance, suppose we have a class `animal`, and a class `cat` that subclasses `animal`. We also have a class `pet_sanctuary` that adopts out pets with the function `AdoptPet()`. Since we don’t know what kind of pet we’re going to get, `AdoptPet()` returns a generic `animal`.

```verse
animal := class:
cat := class(animal):
pet_sanctuary := class:
    AdoptPet():animal = animal{}
```

Suppose we have another pet sanctuary that only deals with cats. This class, `cat_sanctuary`, is a subclass of `pet_sanctuary`. Since this is a cat sanctuary, we [override](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) `AdoptPet()` to only return a `cat` instead of an `animal`.

```verse
cat_sanctuary := class(pet_sanctuary):
    AdoptPet<override>():cat = cat{}
```

In this case, the return type `cat` of `AdoptPet()` is **covariant** to `animal`. We’re using a more specific type when the original used a more general one.

This can also apply to composite types. Given an array of `cat`, we can initialize an array of `animal` using the cat array. The opposite does not work since `animal` cannot be converted to its subclass `cat`. The array of `cat` is covariant to the array of `animal`, because we’re treating a narrower type as a more generic type.

```verse
CatArray:[]cat = array{}
AnimalArray:[]animal = CatArray
```

Inputs to functions cannot be used covariantly. The following code will fail because the assignment of `AnimalExample()`, to `CatExample()`, is of type `cat`, which is too specific to be the return type of `AnimalExample()`. Reversing this order by assigning `CatExample()` to `AnimalExample` would work due to `cat` subtyping from `animal`.

```verse
CatExample:type{CatFunction(MyCat:cat):void} = …
AnimalExample:type{AnimalFunction(MyAnimal:animal):void} = CatExample
```

An additional example follows where the variable `t` is only used covariantly.

```verse
# The line below will fail because t is used only covariantly.
MyFunction(:logic where t:type):?t = false
```

### Contravariant

Contravariance is the opposite of covariant, and means to use something more generic when you expect something specific. This is usually input to a function. A generic parametric type example below has `payload` acting contravariantly.

```verse
DoSomething(Payload:payload where payload:type):void
```

Say our pet sanctuary has a specific procedure for handling new cats. We add a new method to `pet_sanctuary` called `RegisterCat()`.

```verse
pet_sanctuary := class:
    AdoptPet():animal = animal{}
    RegisterCat(NewAnimal:cat):void = {}
```

For our `cat_sanctuary`, we’re going to override this method to accept an `animal` as a type parameter because we already know that every `cat` is an `animal`.

```verse
cat_sanctuary := class(pet_sanctuary):
    AdoptPet<override>():cat = cat{}
    RegisterCat<override>(NewAnimal:animal):void = {}
```

Here `animal` is **contravariant** to `cat`, since we’re using something more generic when something more specific would work.

Using an implicit type introduced by a `where` clause covariantly produces an error. For example, `payload` here is used contravariantly, but errors out due to not being defined as an argument.

```verse
DoSomething(:logic where payload:type) : ?payload = false
```

To fix this, this could be rewritten to exclude a type parameter:

```verse
DoSomething(:logic) : ?false = false
```

Contravariant-only uses do not result in an error, but can be rewritten using `any` instead of `false`. For example:

```verse
ReturnFirst(First:first_item, :second_item where first_item:type, second_item:type) : first_item = First
```

Since `second_item` was of type `type` and was not returned, we can replace it with `any` in the second example and avoid doing type checking on it.

```verse
ReturnFirst(First:first_item, :any where first_item:type) : first_item = First
```

Replacing the type `first_item` with either `any` or `false` loses precision. For example, the following code will fail to compile:

```verse
ReturnFirst(First:any, :any) :any = First

Main() : void =
    FirstInt:int = ReturnFirst(1, "ignored")
```

## Known Limitations

|  |  |
| --- | --- |
| Explicit type parameters for data types may only be used with classes, and not [interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) or [structs](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). [Inheritance](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#inheritance) related to parametric types is also disallowed. | ```verse OriginalBox(item:type) := class:     Item:type = item # InheritingBox cannot inherit from OriginalBox # because Parametric types cannot inherit InheritingBox(item : type) := class(OriginalBox):     Item:type = item``` |
| Parametric types can reference themselves [recursively](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#recursion) as long as the recursion is direct. Parametric types cannot recursively reference other parametric types. | ```verse # Will compile box_with_a_box(FirstItem : type) := class:     ItemOne : FirstItem     SecondThing : box_with_a_box(FirstItem)  # Will not compile box_with_a_box(FirstItem : type) := class:     ItemOne : FirstItem     SecondThing : ListOfBoxes(FirstItem)``` |
| Currently, classes only support immutable parametric type data. For example, this code would not compile because `ItemOne` is a variable. | ```verse box(first_item:type, second_item:type) := class:     var ItemOne:first_item     ItemTwo:second_item``` |
| Explicit type parameters can be freely combined with a class, just as implicit type parameters can be combined with a function. | ```verse OptionBox(FirstItem : type) := class:     Item:?FirstItem  Flatten(Box1:?OptionBox(item) where item:type)<decides><transacts>:?item =     Box1?.Item  Main() : void =     Box1 := OptionBox(int){Item := option{1}}     if(Flatten[option{Box1}] = Box1.Item):         Print("Retrieved the item from Box1")``` |
