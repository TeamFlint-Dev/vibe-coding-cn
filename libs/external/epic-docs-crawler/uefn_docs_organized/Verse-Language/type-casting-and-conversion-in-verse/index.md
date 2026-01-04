# Type Casting and Conversion

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/type-casting-and-conversion-in-verse
> **爬取时间**: 2025-12-27T02:07:45.908173

---

When working with data, it is often necessary to convert variables from one data [type](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#type) to another. For example, displaying the result of a calculation requires converting from a [float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse) to a [string](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse).

All type conversion within Verse is explicit, which means that you must use a function like `ToString()` or use an operator like multiply (`*`) to convert an object to a different data type. Explicit conversion of one type to another is also called **type casting**.

## Converting Float to Int

Converting from a [float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse) to an [int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse) requires a function that explicitly specifies how it will convert from a floating point number to an integer. The following functions all handle the conversion, but they all work differently. It's up to you to decide which one works best in a given situation.

- [Round[]](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/round)
- [Floor[]](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/floor-1)
- [Ceil[]](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/ceil)
- [Int[]](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/int)

Conversion functions such as [Round[]](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse/round) require a finite argument and will fail if the argument passed to them is [NaN](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#nan) or `Inf`.

In this example, different functions convert four float literal values into int values using the [or operator](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse#and-or-operators) to create a failure context. Next, [set](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#set) assigns the values to variables of type int.

```verse
# The Int[] method has the <decides> effect,
# This means that we need to account for failure as it is a failable expression.                  
# This results in the following
# var WoodInt:int = failable expression or the value if it fails.

var WoodCollectedFloat:float = 10.5
var WoodInt:int = Int[WoodCollectedFloat] or 0 
Print("Printing WoodInt Value (10): {WoodInt}")
        
# Similar to Int[], Floor[], Ceil[], and Round[] also have the <decides> effect
# So we must account for failure.
var StoneCollectedFloat:float = 12.9
var StoneInt:int = Floor[StoneCollectedFloat] or 0
Print("Printing StoneInt Floor (12): {StoneInt}")

var GoldCollectedFloat:float = 19.1
var GoldInt:int = Ceil[GoldCollectedFloat] or 0
Print("Printing GoldInt Floor (20): {GoldInt}")

var FoodCollectedFloat:float = 25.4
var FoodInt:int = Round[FoodCollectedFloat] or 0
Print("Printing FoodInt Round (25): {FoodInt}")
```

In this example, the `if` expression creates the [failure context](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#failure-context) for these failable functions and `set` assigns the values to variables of type `int`.

```verse
var WoodCollected:int = 0
var StoneCollected:int = 0
var GoldCollected:int = 0
var FoodCollected:int = 0 

if:
    # This block is the condition of the if expression
    # Which creates the failure context
    # If any fail, the entire chain of execution is rolled back
    # And the else branch, if it exists, is executed
            
    # WoodCollected is now 2
    TempWoodInt:int = Round[1.6]
    set WoodCollected = TempWoodInt
        
    # StoneCollected is now 1
    TempStoneInt:int = Floor[1.9]
    set StoneCollected = TempStoneInt
        
    # GoldCollected is now 2
    TempGoldInt:= Ceil[1.2]
    set GoldCollected = TempGoldInt
        
    # FoodCollected is now 1
    TempFoodInt:= Int[1.56]
    set FoodCollected = TempFoodInt

then:
    # If the operations in the if expression succeed
    # Also perform the operations in the then block 
    Print("WoodCollected: {WoodCollected}")
    Print("StoneCollected: {StoneCollected}")
    Print("GoldCollected: {GoldCollected}")
    Print("FoodCollected: {FoodCollected}")
        
else:
    # The else block represents operations executed in the case of failure
    Print("Failure when attempting Float to Int conversion!")
```

## Converting Int to Float

The [multiply operator](https://dev.epicgames.com/documentation/en-us/fortnite/operators-in-verse) (`*`) converts the integer to a floating-point number before performing the multiplication.  The way to convert from an [int](https://dev.epicgames.com/documentation/en-us/fortnite/int-in-verse) to a [float](https://dev.epicgames.com/documentation/en-us/fortnite/float-in-verse) data type is to multiply the integer by 1.0.

This code converts the `int` variable `StartingPositionX` into a `float` through multiplication so it can be used in the declaration of a `vector3` variable. The data type `vector3` requires `float` type values for its `X`, `Y`, and `Z` fields.

```verse
# Required for the vector3 type
using { /UnrealEngine.com/Temporary/SpatialMath}

var StartingPositionX:int = 960

# CurrentX = 960.0
var CurrentX:float = StartingPositionX * 1.0
var CurrentPosition:vector3 = vector3{X := CurrentX, Y := 0.0, Z := 0.0}
Print("CurrentX: {CurrentX}")
```

## Converting to a String

You can convert multiple data types to a `string` using either a `ToString()` function or [string interpolation](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse), which calls a `ToString()` function. Currently, the following types have built-in `ToString()` functions in Verse.

- float
- int
- []char
- char
- vector2
- vector3
- rotation

In this example, you can see variables being converted to a string through string [interpolation](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#interpolation) and `ToString()` functions. Both methods have the same result because string interpolation calls `ToString()`.

```verse
var WoodCollected:int = 100
# Convert using string interpolation
Print("WoodCollected: { WoodCollected }")
# or ToString() function
Print("WoodCollected: " + ToString(WoodCollected))

var InitialDistance:float = 3.625
# Convert using string interpolation
Print("InitialDistance: { InitialDistance }")
# or ToString() function
Print("InitialDistance: " + ToString(InitialDistance))

var CurrentPosition : vector3 = vector3{X:= 960.0, Y:= 540.0, Z := 20.0}
# Convert using string interpolation
Print("CurrentPosition: { CurrentPosition }")
# or ToString() function
Print("CurrentPosition: " + ToString(CurrentPosition))
```

### Converting a Custom Data Type to a String

Custom data types can also be converted to strings by implementing a `ToString(custom_type)` function for the data type. If a `ToString(custom_type)` function exists, string interpolation will use it to automatically convert data types to strings.

Here is an example of a custom `ToString()` function for an `enum` of fruits.

```verse
fruit := enum:
    Apple 
    Banana 
    Strawberry

ToString(Fruit: fruit):string =
    case(Fruit):
        fruit.Apple => "Apple"
        fruit.Banana => "Banana"
        fruit.Strawberry => "Strawberry"

PickUpFruit():void =
    # Examples of using string interpolation to convert data to strings
    var FruitItem:fruit = fruit.Banana

    # Picked up: Banana
    Print("Picked up: {FruitItem}")
    
    set FruitItem = fruit.Apple
    # Picked Up: Apple
    Print("Picked up: {FruitItem}")
```

Here is an example of a custom `ToString()` function for a custom class. Notice that the `ToString()` function is declared outside of the `waypoint` class. In the `SetDestination()` function, the string interpolation of `Destination` is calling the custom `ToString()` function.

```verse
# Custom class with constructor and a ToString() function
waypoint := class():
    DisplayName:string
    Position:vector3 = vector3{}

MakeWaypoint<constructor>(Name:string, X:float, Y:float, Z:float) := waypoint:
    DisplayName := Name
    Position := vector3{X := X, Y := Y, Z := Z}

ToString(Waypoint: waypoint):string =
    return "{Waypoint.DisplayName} at {Waypoint.Position}"

SetDestination():void =
    Destination:waypoint = MakeWaypoint("River", 919.0, 452.0, 545.0)
    # River at {x=919.0, y=452.0, z=545.0}
    Print("Destination: {Destination}")
```

## Converting an Object Reference to a Different Type

You can explicitly convert references to objects (or **type cast**) to different [classes](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) or [interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse) using the following syntax:

```verse
if (NewObjectReference := object_type_to_cast_to[ObjectReference]) {}
```

The **object\_type\_to\_cast\_to** represents the class or interface that you are attempting to convert the reference to. This is a failable expression because the type conversion will fail if the object can't be converted to the specified type. Attempting to convert an object reference to a class will fail if the class does not match the object's type, the type of a superclass, or an interface that the object's class implements.

This code declares an interface `positionable`, an [abstract class](https://dev.epicgames.com/documentation/en-us/fortnite/abstract-class) `shape` that inherits from `positionable`, and two subclasses of `shape`: `triangle` and `square`. It then creates an object of type `square` called `MyShape` and attempts to type cast it to three other types. Here is a breakdown of the results.

| square Type Cast To | Result |
| --- | --- |
| `square` | **succeeds** because `MyShape` is a `square` |
| `triangle` | **fails** because `triangle` is not a superclass of `square`, and `triangle` is not an interface that `square` implements |
| `positionable` | **succeeds** because `square` is a subclass of `shape`, and all subclasses of `shape` must implement `positionable`. |

```verse
# Class and interface definitions
positionable := interface() {}
shape := class<abstract>(positionable) {}
triangle := class(shape) {}
square := class(shape) {}

# Create a square object referenced using the superclass type shape
MyShape:shape = square{}

# This will succeed since MySquare is a square object
if(MySquare := square[MyShape]):
    Print("Successfully cast shape to square")

if(MyTriangle := triangle[MyShape]):
    Print("This will never print.")
else:
    Print("Failed to cast MyShape to triangle. This is expected behavior.")

# This will succeed since the positionable interface must be implemented by subclasses of shape
if(MyDrawable := positionable[MyShape]):
    Print("Successfully cast shape to positionable")
```

In the last example, type casting will work but is not necessary. This code will have the same result:

```verse
MyDrawable:positionable = MyShape
```

## Examples Using Type Conversion

One use case for object type casting in UEFN is finding actors of a certain type and calling functions based on the type. To find out how to do this, see [Finding Actors with a Gameplay Tag in Gameplay Tags](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse).
