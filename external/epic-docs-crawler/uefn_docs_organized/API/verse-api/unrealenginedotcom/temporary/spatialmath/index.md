# SpatialMath module

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath
> **爬取时间**: 2025-12-27T00:39:35.692921

---

Module import path: /UnrealEngine.com/Temporary/SpatialMath

- [`UnrealEngine.com`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom)
- [`Temporary`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary)
- **`SpatialMath`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`rotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/rotation) |  |
| [`transform`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/transform) | A combination of scale, rotation, and translation, applied in that order. |
| [`vector2`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/vector2) | 2-dimensional vector with `float` components. |
| [`vector2i`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/vector2i) | 2-dimensional vector with `int` components. |
| [`vector3`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/vector3) | 3-dimensional vector with `float` components. |

## Functions

| Name | Description |
| --- | --- |
| [`MakeRotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/makerotation) | Makes a `rotation` from `Axis` and `AngleRadians` using a left-handed sign convention (e.g. a positive rotation around +Z takes +X to +Y). If `Axis.IsAlmostZero[]`, make the identity rotation. |
| [`MakeRotationFromYawPitchRollDegrees`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/makerotationfromyawpitchrolldegrees) | Makes a `rotation` by applying `YawRightDegrees`, `PitchUpDegrees`, and `RollClockwiseDegrees`, in that order:   - first a *yaw* about the Z axis with a positive angle indicating a clockwise rotation when viewed from above, - then a *pitch* about the new Y axis with a positive angle indicating 'nose up', - followed by a *roll* about the new X axis axis with a positive angle indicating a clockwise rotation when viewed along +X.   Note that these conventions differ from `MakeRotation` but match `ApplyYaw`, `ApplyPitch`, and `ApplyRoll`. |
| [`IdentityRotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/identityrotation) | Makes the identity `rotation`. |
| [`Distance`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distance) | Returns the 'distance' between `Rotation1` and `Rotation2`. The result will be between:   - `0.0`, representing equivalent rotations and - `1.0` representing rotations which are 180 degrees apart (i.e., the shortest rotation between them is 180 degrees around some axis). |
| [`AngularDistance`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/angulardistance) | Returns the 'smallest angular distance' between `Rotation1` and `Rotation2` in radians. |
| [`MakeShortestRotationBetween`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/makeshortestrotationbetween) | Makes the smallest angular `rotation` from `InitialRotation` to `FinalRotation` such that: `InitialRotation.RotateBy(MakeShortestRotationBetween(InitialRotation, FinalRotation)) = FinalRotation` and `MakeShortestRotationBetween(InitialRotation, FinalRotation)?.GetAngle()` is as small as possible. |
| [`MakeShortestRotationBetween`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/makeshortestrotationbetween-1) | Makes the smallest angular `rotation` from `InitialVector` to `FinalVector` such that: `InitialVector.RotateBy(MakeShortestRotationBetween(InitialVector, Vector)) = FinalVector` and `MakeShortestRotationBetween(InitialVector, FinalVector)?.GetAngle()` is as small as possible. |
| [`MakeComponentWiseDeltaRotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/makecomponentwisedeltarotation) | Makes a new `rotation` from the component wise subtraction of the Euler angle components in `RotationA` by the Euler angle components in `RotationB` and ensures the returned value is normalized. |
| [`Slerp`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/slerp) | Used to perform spherical linear interpolation between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that `0.0 <= Parameter <= 1.0`. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/tostring) | Makes a `string` representation of `rotation` in axis/degrees format with a left-handed sign convention. `ToString(MakeRotation(vector3{X:=1.0, Y:=0.0, Z:=0.0}, PiFloat/2.0))` produces the string: `"Axis: {x=1.000000,y=0.000000,z=0.000000} Angle: 90.000000"`. |
| [`DegreesToRadians`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/degreestoradians) | Returns radians from `Degrees`. |
| [`RadiansToDegrees`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/radianstodegrees) | Returns degrees from `Radians`. |
| [`FromVector3`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromvector3) | Util function for converting a translation/position `vector3` from /UnrealEngine.com/Temporary/SpatialMath to a `vector3` from /Verse.org/SpatialMath. |
| [`FromScalarVector3`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromscalarvector3) | Util function for converting a scalar `vector3` from /UnrealEngine.com/Temporary/SpatialMath to a `vector3` from /Verse.org/SpatialMath. Use this function when your vector indicates a magnitude on each axis but not a direction, such as when you convert a scale measurement rather than a translation or position. |
| [`FromRotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromrotation) | Util function for converting a `rotation` from /UnrealEngine.com/Temporary/SpatialMath to a `rotation` from /Verse.org/SpatialMath. |
| [`FromTransform`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromtransform) | Util function for converting a `transform` from /UnrealEngine.com/Temporary/SpatialMath to a `transform` from /Verse.org/SpatialMath. |
| [`FromVector3`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromvector3-1) | Util function for converting a translation/position `vector3` from /Verse.org/SpatialMath to a `vector3` from /UnrealEngine.com/Temporary/SpatialMath. |
| [`FromScalarVector3`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromscalarvector3-1) | Util function for converting a scalar `vector3` from /Verse.org/SpatialMath to a `vector3` from /UnrealEngine.com/Temporary/SpatialMath. Use this function when your vector indicates a magnitude on each axis but not a direction, such as when you convert a scale measurement rather than a translation or position. |
| [`FromRotation`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromrotation-1) | Util function for converting a `rotation` from /Verse.org/SpatialMath to a `rotation` from /UnrealEngine.com/Temporary/SpatialMath. |
| [`FromTransform`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/fromtransform-1) | Util function for converting a `transform` from /Verse.org/SpatialMath to a `transform` from /UnrealEngine.com/Temporary/SpatialMath. |
| [`TransformVector`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/transformvector) | Makes a `vector3` by applying `InTransform` to `InVector`. |
| [`TransformVectorNoScale`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/transformvectornoscale) | Makes a `vector3` by applying `InTransform` to `InVector` without applying `InTransform.Scale`. |
| [`ReflectVector`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/reflectvector) | Makes a `vector2` by inverting the `SurfaceNormal` component of `Direction`. Fails if `not SurfaceNormal.MakeUnitVector[]`. |
| [`DotProduct`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/dotproduct) | Returns the dot product of `V1` and `V2`. |
| [`Distance`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distance-1) | Returns the Euclidean distance between `V1` and `V2`. |
| [`DistanceSquared`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distancesquared) | Returns the squared Euclidean distance between `V1` and `V2`. |
| [`Lerp`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/lerp) | Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite. Returns `From*(1 - Parameter) + To*Parameter`. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/tostring-1) | Makes a `string` representation of `V`. |
| [`prefix'-'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/prefixminus) | Makes a `vector2` by inverting the signs of `Operand`. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorplus) | Makes a `vector2` by component-wise addition of `Left` and `Right`. |
| [`operator'-'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorminus) | Makes a `vector2` by component-wise subtraction of `Right` from `Left`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar) | Makes a `vector2` by component-wise multiplication of `Left` and `Right`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar-1) | Makes a `vector2` by multiplying the components of `Right` by `Left`. |
| [`operator'/'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorslash) | Makes a `vector2` by dividing the components of `Left` by `Right`. |
| [`operator'/'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorslash-1) | Makes a `vector2` by component-wise division of `Left` by `Right`. |
| [`ToVector2`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/tovector2) | Makes a `vector2` by converting the components of `V` to `float`s. |
| [`IsAlmostEqual`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/isalmostequal) | Succeeds when each component of `V1` and `V2` are within `AbsoluteTolerance` of each other. |
| [`DotProduct`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/dotproduct-1) | Returns the dot product of `V1` and `V2`. |
| [`Equals`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/equals) | Makes a `vector2i` that is component-wise equal to `V1` and `V2`. Fails if any component of `V1` does not equal the corresponding component of `V2`. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/tostring-2) | Makes a `string` representation of `V`. |
| [`ToVector2i`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/tovector2i) | Makes a `vector2i` by component-wise truncation of `V` to `ints`s. |
| [`prefix'-'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/prefixminus-1) | Makes a `vector2i` by inverting the signs of `Operand`. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorplus-1) | Makes a `vector2i` by component-wise addition of `Left` and `Right`. |
| [`operator'-'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorminus-1) | Makes a `vector2i` by component-wise subtraction of `Right` from `Left`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar-2) | Makes a `vector2i` by multiplying the components of `Left` by `Right`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar-3) | Makes a `vector2i` by multiplying the components of `Right` by `Left`. |
| [`ReflectVector`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/reflectvector-1) | Makes a `vector3` by inverting the `SurfaceNormal` component of `Direction`. Fails if `not SurfaceNormal.MakeUnitVector[]`. |
| [`DotProduct`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/dotproduct-2) | Returns the dot product of `V1` and `V2`. |
| [`CrossProduct`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/crossproduct) | Returns the cross product of `V1` and `V2`. |
| [`Distance`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distance-2) | Returns the Euclidean distance between `V1` and `V2`. |
| [`DistanceSquared`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distancesquared-1) | Returns the squared Euclidean distance between `V1` and `V2`. |
| [`DistanceXY`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distancexy) | Returns the 2-D Euclidean distance between `V1` and `V2` by ignoring the difference in `Z`. |
| [`DistanceSquaredXY`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/distancesquaredxy) | Returns the squared 2-D Euclidean distance between `V1` and `V2` by ignoring their difference in `Z`. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/tostring-3) | Makes a `string` representation of `V`. |
| [`Lerp`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/lerp-1) | Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite. Returns `From*(1 - Parameter) + To*Parameter`. |
| [`prefix'-'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/prefixminus-2) | Makes a `vector3` by inverting the signs of `Operand`. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorplus-2) | Makes a `vector3` by component-wise addition of `L` and `R`. |
| [`operator'-'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorminus-2) | Makes a `vector3` by component-wise subtraction of `R` from `L`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar-4) | Makes a `vector3` by component-wise multiplication of `L` and `R`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar-5) | Makes a `vector3` by multiplying the components of `L` by `R`. |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorstar-6) | Makes a `vector3` by multiplying the components of `R` by `L`. |
| [`operator'/'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorslash-2) | Makes a `vector3` by dividing the components of `L` by `R`. |
| [`operator'/'`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/operatorslash-3) | Makes a `vector3` by component-wise division of `L` by `R`. |
| [`IsAlmostEqual`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/spatialmath/isalmostequal-1) | Succeeds when each component of `V1` and `V2` are within `AbsoluteTolerance` of each other. |
