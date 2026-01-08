# Left-Up-Forward Coordinate System

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:21:22.503303

---

As of 36.00, UEFN uses the LUF coordinate system for the editor and all `/Verse.org` module transforms. `/UnrealEngine.com` and `/Fortnite.com` module transforms use the XYZ coordinate system.

## Introducing the LUF Coordinate System

All major 3D content creation tools use a Cartesian coordinate system (X, Y, and Z) to position and rotate objects. However, the specific interpretations for which axes (X, Y, and Z) represent which directions (such as left/right, up/down, and front/back) are different between tools. In addition, the way rotations are modeled —known as the **handedness** of the coordinate system—also varies between different tools.

To better align Verse and UEFN with emerging standards in 3D content creation and other prominent toolsets, we're making fundamental changes to our coordinate system presentation.

**First**, instead of labeling coordinate axes with **X**, **Y** and **Z**, we're introducing more descriptive axis names:

- **Left** (was -Y)
- **Up** (was Z)
- **Forward** (was X)

The change from the previous XYZ and FRU to LUF therefore corresponds to a handedness change in the axes from a left-handed coordinate system (XYZ and FRU) to a right-handed coordinate system (LUF).

**Second**, the UEFN viewport gizmo colors have changed to align with other 3D content creation software:

- **Left: Red** (was green)
- **Up: Green** (was blue)
- **Forward: Blu****e** (was red)

**Third**, many improvements have been made to the `/Verse.org/SpatialMath` module:

- Verse spatial math module functions are all now right-handed operations. As a result, all functions with explicit right-handedness variants have been removed and replaced with versions that default to right-handed operations, and right-handedness indicators have been dropped from function names. For more information, see the **Right-Handedness** section of this page below.
- Rotation functions that involve an angle parameter or return value now have versions that accept or return radians or degrees, and are suffixed with `Radians` or `Degrees` for the respective variant.
- `RotateBy`, `UnrotateBy`, and all `(:rotation).Apply*` functions have been removed in favor of a multiplication operator that composes two `rotations` left to right. For more information, see the [Transform and Rotation Multiplication Order]() section of this page.
- `RotateVector` and `UnrotateVector` have been removed in favor of a multiplication operator that rotates a `vector3` by a `rotation`, in that order. For more information, see the **Spatial Math Operation Changes** section of this page.
- `TransformVector` and `TransformVectorNoScale` have been removed in favor of a multiplication operator that transforms a `vector3` by a `transform` in the following order: scale, rotation, translation. For more information, see the **Spatial Math Operation Changes** section of this page.

**Fourth**, default imports of skeletal meshes from FBX now use the option to align Up and Forward axes so all imported skeletal meshes face the forward axis.

### What This Affects

This coordinate system change affects anyone using UEFN or transforms in the `/Verse.org` module, in particular, several aspects of UEFN and Verse that include:

- UEFN Details panel
- UEFN viewport and gizmo
- Verse transform

You don't need to change the code or content for your published islands to work properly with LUF.

![XYZ](https://dev.epicgames.com/community/api/documentation/image/a05bd61c-e166-4752-a591-5ad61114157a?resizing_type=fit&width=1920&height=1080)

![LUF](https://dev.epicgames.com/community/api/documentation/image/e6563dd1-369c-44e6-b28c-92c812d3d89c?resizing_type=fit&width=1920&height=1080)

XYZ

LUF

#### UEFN Details Panel

Transforms in the UEFN Details panel now display coordinates in terms of the LUF system.

#### UEFN Viewport

The mapping between gizmo axes and colors has changed in the UEFN viewport.

#### Verse Transforms

`/Verse.org` module transforms use the **LUF** system. The `/UnrealEngine.com` module transform using the **XYZ** coordinate system still exists, and is used as the default transform in the `/UnrealEngine.com` and `/Fortnite.com` modules.

Since both of these modules contain transform types, keep the following in mind:

- If you are using API functions that use both `/Verse.org` module transforms and `/UnrealEngine.com` module transforms in the same file, the type names need to be qualified by their path to avoid ambiguity between the two modules. This is shown in the example snippet below.

  ```verse
  using { /UnrealEngine.com/Temporary/SpatialMath }
  using { /Verse.org/SpatialMath }
   
  my_class := class:
   MyUnrealEngineVector:(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = (/UnrealEngine.com/Temporary/SpatialMath:)vector3{}
   MyVerseVector:(/Verse.org/SpatialMath:)vector3 = (/Verse.org/SpatialMath:)vector3{}
  ```

- Scene Graph uses `/Verse.org` module transforms. This means that Scene Graph now only uses the LUF coordinate system.
- The Verse Digest uses fully-qualified Verse identifiers to disambiguate between transform types defined in the [UnrealEngine.com/Temporary/SpatialMath](http://unrealengine.com/Temporary/SpatialMath) and [Verse.org/SpatialMath](http://verse.org/SpatialMath) modules.

To learn more about the Unreal Engine coordinate system, see [Coordinate System and Spaces in Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/coordinate-system-and-spaces-in-unreal-engine).

## Converting from XYZ to LUF

If you are using any existing API functions that have switched to the `/Verse.org` module transforms (LUF), you need to convert your user-defined `/UnrealEngine.com` transforms (XYZ) to use LUF, or use the newly created `FromTransform` conversion functions. In this section, you can find several potential conversion problems and the solutions for them.

### Constant or Variable Type Ambiguity

With recent changes to the Verse API, both `/UnrealEngine.com/Temporary/SpatialMath` and `/Verse.org/SpatialMath` define the types `vector3`, `rotation`, and `transform`. As a result, type ambiguity will arise if you include both domains in your verse file.

### Type Ambiguity Example

The following Verse file imports both the [/UnrealEngine.com/Temporary/SpatialMath](http://unrealengine.com/Temporary/SpatialMath) module path and the [/Verse.org/SpatialMath](http://verse.org/SpatialMath) module path, and the user-defined class uses the unqualified type `vector3`:

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/SpatialMath }
 
my_class := class:
 MyVectorOne:vector3 = vector3{} 
        #Compile Error: Identifier vector3 could be one of many types: UnrealEngine.com.Temporary.SpatialMath.vector3 or Verse.org.SpatialMath.vector3
 MyVectorTwo:vector3 = vector3{} 
        #Compile Error: Identifier vector3 could be one of many types: UnrealEngine.com.Temporary.SpatialMath.vector3 or Verse.org.SpatialMath.vector3
```

As a result, the type ambiguity causes a compile error if you attempt to compile this file since the compiler does not know whether to compile `MyVectorOne` and `MyVectorTwo` as an `/UnrealEngine.com` `vector3` type, or as a `/Verse.org` `vector3` type. The user has not given the compiler enough information for it to know which type is indicated.

To resolve this compile error, you must path qualify the type of `vector3` each variable uses. There are several different ways you can path qualify these constants to resolve the error:

You can fully qualify any constant or variable of type `vector3`, as shown in the code snippet below:

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/SpatialMath }
 
my_class := class:
 MyVectorOne:(/UnrealEngine.com/Temporary/SpatialMath:)vector3 = (/UnrealEngine.com/Temporary/SpatialMath:)vector3{}
 MyVectorTwo:(/Verse.org/SpatialMath:)vector3 = (/Verse.org/SpatialMath:)vector3{}
```

You can qualify a constant or variable from the `/Verse.org` module, as shown in the code snippet below:

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org } # Change the module path to avoid import ambiguity
 
my_class := class:
 MyVectorOne:vector3 = vector3{}
 MyVectorTwo:SpatialMath.vector3 = SpatialMath.vector3{} # Specify the submodule
```

You can qualify a constant or variable from the `/UnrealEngine.com` module, as shown in the code snippet below:

```verse
using { /UnrealEngine.com/Temporary } # Change the module path to avoid import ambiguity
using { /Verse.org/SpatialMath }
 
my_class := class:
 MyVectorOne:SpatialMath.vector3 = SpatialMath.vector3{} # Specify the submodule
 MyVectorTwo:vector3 = vector3{}
```

### Scene Graph Type Change

If you are using the Scene Graph APIs in your Verse files and aren't using other APIs that use spatial math, you can change the spatial math types in your Verse code by changing the spatial math module you import with the `using` keyword. For example, if you have the following code:

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
 
my_component := class<final_super>(component):
 @editable # This change will work regardless of this field being editable or not
 MyVector3:vector3 = vector3{}
 MyVector2:vector2 = vector2{}
```

You can change it to:

```verse
using { /Verse.org/SpatialMath } # Changed the module path
 
my_component := class<final_super>(component):
 @editable # This change will work regardless of this field being editable or not
 MyVector:vector3 = vector3{} # All transform types now use /Verse.org/SpatialMath
 # MyVector2:vector2 = vector2{} Removed since /Verse.org/SpatialMath does not define a vector2
```

The only exception is that any `vector2` types must be removed or converted to use `vector3`, since the `/Verse.org` module does not currently define the type `vector2`.

### Function Type Mismatch

Another scenario where you might need to path-qualify types or convert your code is when:

- A called function or assigned variable expects a type from the `/UnrealEngine.com` module, but is provided a type from the `/Verse.org` module.
- A called function or assigned variable expects a type from the `/Verse.org` module, but is provided a type from the `/UnrealEngine.com` module.

### Function Type Mismatch Example

The following two verse files exist in the same project. `FileOne.verse` defines a function to print a transform from the `/UnrealEngine.com/Temporary/SpatialMath` module. `FileTwo.verse` defines a constant transform from the `/Verse.org/SpatialMath` module and a function to print this value that calls the function from `FileOne.verse`.

```verse
using { /UnrealEngine.com/Temporary/SpatialMath }
 
PrintTransform(T:transform):void=
 Print("T: {T}")
```

```verse
using { /Verse.org/SpatialMath }
 
my_class := class:
 T:transform = transform{}
 
 DoPrint():void=
  PrintTransform(T) # Compile error: This function parameter expects a value of type (/UnrealEngine.com/Temporary/SpatialMath:)transform, but this argument is an incompatible value of type (/Verse.org/SpatialMath:)transform.
```

This results in a compile error due to the transform types referring to two different transform types, defined in different modules.

To fix this compile error, you must convert the transform type to the correct transform type from the appropriate module. Edit the code in `FileTwo.verse` to use the `FromTransform` function, which converts a transform from `/Verse.org/SpatialMath` to a transform from `/UnrealEngine.com/Temporary/SpatialMath`.

For a complete list of available conversion functions, see the next section.

```verse
# Include /UnrealEngine.com to access conversion functions
using { /UnrealEngine.com }
using { /Verse.org/SpatialMath }
 
my_class := class:
 T:transform = transform{}
 
 DoPrint():void=
  PrintTransform(Temporary.SpatialMath.FromTransform(T))  # Compile error fixed after converting transform to the correct type from the proper module
```

### Vector, Rotation, and Transform Type Conversion

The `/UnrealEngine.com` module provides several new conversion functions to convert between the potentially ambiguous types defined in the `/UnrealEngine.com` module and the `/Verse.org` module.

#### From Unreal Engine Spatial Math to Verse Spatial Math

```verse
# Util function for converting a `vector3` from /UnrealEngine.com/Temporary/SpatialMath to a `vector3` from /Verse.org/SpatialMath.
FromVector3<public>(InVector3:(/UnrealEngine.com/Temporary/SpatialMath:)vector3)<reads>:(/Verse.org/SpatialMath:)vector3
```

```verse
# Util function for converting a `rotation` from /UnrealEngine.com/Temporary/SpatialMath to a `rotation` from /Verse.org/SpatialMath
FromRotation<public>(InRotation:(/UnrealEngine.com/Temporary/SpatialMath:)rotation)<reads>:(/Verse.org/SpatialMath:)rotation
```

```verse
# Util function for converting a `transform` from /UnrealEngine.com/Temporary/SpatialMath to a `transform` from /Verse.org/SpatialMath.
FromTransform<public>(InTransform:(/UnrealEngine.com/Temporary/SpatialMath:)transform)<reads>:(/Verse.org/SpatialMath:)transform
```

#### From Verse Spatial Math to Unreal Engine Spatial Math

```verse
# Util function for converting a `vector3` from /Verse.org/SpatialMath to a `vector3` from /UnrealEngine.com/Temporary/SpatialMath.
FromVector3<public>(InVector3:(/Verse.org/SpatialMath:)vector3)<reads>:(/UnrealEngine.com/Temporary/SpatialMath:)vector3
```

```verse
# Util function for converting a `rotation` from /Verse.org/SpatialMath to a `rotation` from /UnrealEngine.com/Temporary/SpatialMath.
FromRotation<public>(InRotation:(/Verse.org/SpatialMath:)rotation)<reads>:(/UnrealEngine.com/Temporary/SpatialMath:)rotation
```

```verse
# Util function for converting a `transform` from /Verse.org/SpatialMath to a `transform` from /UnrealEngine.com/Temporary/SpatialMath.
FromTransform<public>(InTransform:(/Verse.org/SpatialMath:)transform)<reads>:(/UnrealEngine.com/Temporary/SpatialMath:)transform
```

## Verse Spatial Math Operations and Functions

### Right-Handedness

Verse spatial math module functions are all now right-handed operations. As a result, all functions with explicit handedness variants have been removed and replaced with versions that default to right-handed operations, and handedness indicators have been dropped from function names. All operations where there is a handedness choice, such as multiplication of a `vector3` by a `rotation` or multiplication of a `vector3` by a `transform`, are right-handed operations.

For example, the following code illustrates that constructing a rotation of positive 90 degrees about the Up-axis and applying this rotation to a unit Forward vector results in a unit Left vector:

```verse
ForwardToLeft:rotation = MakeRotationFromEulerDegrees(0.0, 90.0, 0.0)
ForwardVector:vector3 = vector3{Forward := 1.0}

ResultantVector:vector3 = ForwardVector * ForwardToLeft  # Apply rotation on the right of the multiplication operator
Print("{ResultantVector}") # {Forward = 0.000000, Left = 1.000000, Up = 0.000000} = {Forward = 1.000000, Left = 0.000000, Up = 0.000000} * {Axis = {Forward = 0.000000, Left = 0.000000, Up = 1.000000}, Angle = 90.000000}
```

### Transform and Rotation Multiplication Order

You can think of rotations as being internally represented by a matrix. When a rotation `R` is applied to a vector `v`, they are applied in row-vector multiplication order. That is, the vector `v` is a row vector and when a vector is rotated, multiplication is applied on the right to obtain the result, `v' = v * R`. Here, the resultant vector `v'` is a new row vector. This works similarly for applying a `transform T` to a `vector v`, `v' = v * T` and the resultant vector `v'` is another row vector.

Order matters when applying rotations and transforms to vectors. Hold an object, such as a book, in your hand with the top facing up and the front/cover facing you. Applying a right-handed, positive 90 degree rotation about the Forward axis results in the top of the book now facing right. Next, applying a 90 degree rotation about the Left axis results in the front of the phone facing up and the top of the book facing to your right.

Now, apply the same rotations in the reverse order. Apply a 90 degree rotation about the Left axis resulting in the top of the book facing forward and the front of the book facing up. Next, applying a 90 degree rotation about the Forward axis results in the top of the book facing forward and the front of the book facing to your right. This is not the same orientation as applying the rotations in the other order illustrating that the order of rotations matters.

With this in mind, if you want to apply two rotations `R` and `R'` to a vector `v`, you must take care to apply them in the order you desire. If you want to apply the rotation `R` before the rotation `R'`, then the correct order is `v' = v * R * R'`.

The same principle applies to rotations themselves. If you have a rotation `R` and you want to apply a pre-rotation `PreR` to `R`, which takes place before the rotation `R` and a post-rotation `PostR` that takes place after the rotation `R`, this is done in the order `PreR * R * PostR`. Similarly, if you want to apply a pre-transform `PreT` and a post-transform `PostT` to a transform `T`, this is done in the order `PreT * T * PostT`. Subsequently, applying these to a vector `v` to achieve a new vector `v'` is done as above, `v' = v * PreR * R * PostR` or `v' = v * PreT * T * PostT`.

Associativity of transformations and rotations is also important. If you want to apply multiple operations on a vector in the same line of Verse code such as a transformation, followed by a rotation, association of the operations matters. For example, you might try:

```verse
ForwardVector:vector3 = vector3{Forward := 1.0}
ForwardToLeftUpOne:transform = transform:
    Translation := vector3{Up := 1.0}
    Rotation := MakeRotationFromEulerDegrees(0.0, 90.0, 0.0)
UpToForward:rotation = MakeRotationFromEulerDegrees(90.0, 0.0, 0.0)

ResultantVector:vector3 = ForwardVector * ForwardToLeftUpOne * UpToForward  # compiles
```

This compiles fine since it is implicitly associating operations as:

```verse
ResultantVector:vector3 = (ForwardVector * ForwardToLeftUpOne) * UpToForward  # compiles
```

But if you explicitly try to associate differently as:

```verse
ResultantVector:vector3 = ForwardVector * (ForwardToLeftUpOne * UpToForward)  # error, no operator'*'(:transform,:rotation)
```

This results in an error. To avoid these errors, explicitly associate your first operation between a vector and a transformation or a vector and a rotation.

```verse
ResultantVector:vector3 = (ForwardVector * ForwardToLeftUpOne) * UpToForward  # explicitly associated
```

### Spatial Math Operation Changes

#### Rotation and Rotation Multiplication

`RotateBy` and `UnrotateBy` are removed and replaced with a multiplication operator for two rotations.

```verse
ForwardToLeft:rotation = MakeRotationFromEulerDegrees(0.0, 90.0, 0.0)
UpToForward:rotation = MakeRotationFromEulerDegrees(90.0, 0.0, 0.0)

UpToLeft:rotation = UpToForward * ForwardToLeft   # RotateBy, correcting for handedness
```

To reverse a rotation ("unrotate"), first invert the rotation, then multiply the rotations. To get back the `UpToForward` rotation from `UpToLeft`, invert the `ForwardToLeft` rotation and apply it on the right to the `UpToLeft` rotation. The following shows how this is accomplished step by step.

```verse
# The following comments show the steps involved to reach the desired result.
# This involves multiplication on the right by the inverse, associativity, existence and definition of inverse rotation, and existence and definition of identity rotation

# Pseudocode Steps:
# UpToLeft * ForwardToLeft.Invert() = (UpToForward * ForwardToLeft) * ForwardToLeft.Invert()  # multiply on the right by the same expression on both sides of the equality operator
# UpToLeft * ForwardToLeft.Invert() = UpToForward * (ForwardToLeft * ForwardToLeft.Invert())  # reassociate
# UpToLeft * ForwardToLeft.Invert() = UpToForward * IdentityRotation()     # rotation * inverse = identity
# UpToLeft * ForwardToLeft.Invert() = UpToForward        # rotation * identity = rotation

UpToForwardAgain:rotation = UpToLeft * ForwardToLeft.Invert() # UnrotateBy, correcting for handedness
```

#### Vector3 and Rotation Multiplication

Similarly, `Rotate` and `Unrotate` are removed and replaced with a multiplication operator for a `vector3` rotated on the right by a `rotation`.

```verse
ForwardVector:vector3 = vector3{Forward:=1.0}
ForwardToLeft:rotation = MakeRotationFromEulerDegrees(0.0, 90.0, 0.0)

LeftVector:vector3 = ForwardVector * ForwardToLeft   # Rotate, correcting for handedness
```

To reverse a rotation (unrotate), first invert the rotation, then multiply the rotation by the vector. To get back the `ForwardVector` from `LeftVector`, invert the `ForwardToLeft` rotation and apply it on the right to the `LeftVector`

```verse
# The steps involved in achieving this calculation are very similar to the steps shown above for obtaining the correct expression for unrotating by a rotation

ForwardVectorAgain:vector3 = LeftVector * ForwardToLeft.Invert() # Unrotate, correcting for handedness
```

#### Vector3 and Transform Multiplication

`TransformVector` and `TransformVectorNoScale` are removed and replaced with a multiplication operator for a `vector3` transformed on the right by a transform.

```verse
DoubleLengthForwardToLeftTranslateUp := transform:
    Translation := vector3{Left := 0.0, Up := 1.0, Forward := 0.0}
    Rotation := MakeRotationFromEulerDegrees(0.0, 90.0, 0.0)
    Scale := vector3{Left := 2.0, Up := 2.0, Forward := 2.0}

ForwardVector:vector3 = vector3{Forward:=1.0}

ResultantVector:vector3 = ForwardVector * DoubleLengthForwardToLeftTranslateUp  # TransformVector
```

To perform a transform with no scaling, `TransformVectorNoScale`, leave the default scale value on the `transform` you construct.

```verse
ForwardToLeftTranslateUpNoScale := transform:
    Translation := vector3{Left := 0.0, Up := 1.0, Forward := 0.0}
    Rotation := MakeRotationFromEulerDegrees(0.0, 90.0, 0.0)

ForwardVector:vector3 = vector3{Forward:=1.0}

ResultantVector:vector3 = ForwardVector * ForwardToLeftTranslateUpNoScale   # TransformVectorNoScale
```
