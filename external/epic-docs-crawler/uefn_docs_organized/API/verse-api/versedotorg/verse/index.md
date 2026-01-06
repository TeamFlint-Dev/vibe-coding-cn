# Verse module

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/verse
> **爬取时间**: 2025-12-26T23:27:02.719879

---

- [`Verse.org`](/documentation/en-us/fortnite/verse-api/versedotorg)
- **`Verse`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`classifiable_subset(element_type)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/classifiable_subset/classifiable_subset(element_type)) | A `classifiable_subset` is a container that holds a set of elements. A classifiable\_subset can hold multiple elements of the same type. |
| [`diagnostic`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/diagnostic) | An opaque diagnostic message that only shows up in diagnostic logs. The format of the diagnostic may change at any time without warning and may not be inspected by Verse code. |
| [`event(t)`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/event/event(t)) | A *recurring*, successively signaled parametric `event` with a `payload` allowing a simple mechanism to coordinate between concurrent tasks. |
| [`locale`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/locale) | Used for message localization. |
| [`message`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/message) | A localizable text message. |

## Interfaces

| Name | Description |
| --- | --- |
| [`cancelable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/cancelable) | Implemented by classes that allow users to cancel an operation. For example, calling `subscribable.Subscribe` with a callback returns a `cancelable` object. Calling `Cancel` on the return object unsubscribes the callback. |
| [`disposable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/disposable) | Implemented by classes whose instances have limited lifetimes. |
| [`enableable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/enableable) | Implemented by classes whose instances can be enabled and disabled. |
| [`invalidatable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/invalidatable) | Implemented by classes whose instances can become invalid at runtime. |
| [`showable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/showable) | Implemented by classes whose instances can change visibility to be shown or hidden. |

## Functions

| Name | Description |
| --- | --- |
| [`operator'='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorequals) |  |
| [`operator'<>'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorlessgreater) |  |
| [`prefix'-'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/prefixminus) |  |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus) |  |
| [`operator'-'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorminus) |  |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstar) |  |
| [`operator'/'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorslash) |  |
| [`operator'+='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplusequals) |  |
| [`operator'-='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorminusequals) |  |
| [`operator'*='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstarequals) |  |
| [`Abs`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/abs) |  |
| [`operator'>'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorgreater) |  |
| [`operator'>='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorgreaterequals) |  |
| [`operator'<'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorless) |  |
| [`operator'<='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorlessequals) |  |
| [`Ceil`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/ceil) |  |
| [`Floor`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/floor) |  |
| [`prefix'-'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/prefixminus-1) |  |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-1) |  |
| [`operator'-'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorminus-1) |  |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstar-1) |  |
| [`operator'/'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorslash-1) |  |
| [`operator'+='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplusequals-1) |  |
| [`operator'-='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorminusequals-1) |  |
| [`operator'*='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstarequals-1) |  |
| [`operator'/='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operator/equals) |  |
| [`Abs`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/abs-1) |  |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstar-2) |  |
| [`operator'*'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorstar-3) |  |
| [`operator'>'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorgreater-1) |  |
| [`operator'>='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorgreaterequals-1) |  |
| [`operator'<'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorless-1) |  |
| [`operator'<='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorlessequals-1) |  |
| [`operator'?'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorquestionmark) |  |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-2) |  |
| [`operator'+='`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplusequals-2) |  |
| [`operator'()'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operator()) |  |
| [`operator'()'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operator()-1) |  |
| [`operator'()'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operator()-2) |  |
| [`ConcatenateMaps`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/concatenatemaps) |  |
| [`operator'()'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operator()-3) |  |
| [`operator'()'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operator()-4) |  |
| [`weak_map`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/weak_map) |  |
| [`operator'?'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorquestionmark-1) |  |
| [`FitsInPlayerMap`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/fitsinplayermap) |  |
| [`Print`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/print) | Writes `Message` to a dedicated `Print` log while displaying it in `Color` on the client screen for `Duration` seconds. By default, `Color` is `NamedColors.White` and `Duration` is `2.0` seconds. |
| [`Print`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/print-1) | Writes `Message` to a dedicated `Print` log while displaying it in `Color` on the client screen for `Duration` seconds. By default, `Color` is `NamedColors.White` and `Duration` is `2.0` seconds. |
| [`Print`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/print-2) | Writes `Message` to a dedicated `Print` log while displaying it in `Color` on the client screen for `Duration` seconds. By default, `Color` is `NamedColors.White` and `Duration` is `2.0` seconds. |
| [`Concatenate`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/concatenate) | Makes a flattened `array` by concatenating the elements of `Arrays`. |
| [`classifiable_subset`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/classifiable_subset) | A `classifiable_subset` is a container that holds a set of elements. A classifiable\_subset can hold multiple elements of the same type. |
| [`MakeClassifiableSubset`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/makeclassifiablesubset) | Constructs a `classifiable_subset` containing the `InElements`. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-3) | Returns a new set that is the union of all elements in `InSetL` set and `InSetR`. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-4) | Concatenates two diagnostic messages. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-5) | Concatenates a diagnostic message with a normal string, yielding a diagnostic message. |
| [`operator'+'`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/operatorplus-6) | Concatenates a normal string with a diagnostic message, yielding a diagnostic message. |
| [`ToDiagnostic`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/todiagnostic) | Converts any Verse value into an opaque diagnostic message. |
| [`Err`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/err) | Halts the Verse runtime with error `Message`. |
| [`event`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/event) | A *recurring*, successively signaled parametric `event` with a `payload` allowing a simple mechanism to coordinate between concurrent tasks. |
| [`event`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/event-1) | A *recurring*, successively signaled event allowing a simple mechanism to coordinate between concurrent tasks. |
| [`Ceil`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/ceil-1) | Returns the smallest `int` that is greater than or equal to `Val`. Fails if `not IsFinite(Val)`. |
| [`Floor`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/floor-1) | Returns the largest `int` that is less than or equal to `Val`. Fails if `not IsFinite(Val)`. |
| [`Round`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/round) | Returns `Val` rounded to the nearest `int`. When the fractional part of `Val` is `0.5`, rounds to the nearest *even* `int` (per the IEEE-754 default rounding mode). Fails if `not IsFinite(Val)`. |
| [`Int`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/int) | Returns the `int` that equals `Val` without the fractional part. Fails if `not IsFinite(val)`. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/tostring) | Makes a `string` representation of `Val`. |
| [`GetSecondsSinceEpoch`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/getsecondssinceepoch) | Returns the number of seconds since January 1, 1970 UTC, ignoring leap seconds. I.e, this function implements Unix time. This function always returns the same value within the same transaction. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/tostring-1) | Makes a printable `string` representation of `Val`. |
| [`listenable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/listenable) | A parametric interface combining `awaitable` and `subscribable`. |
| [`listenable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/listenable-1) | A parameterless interface combining `awaitable` and `subscribable`. |
| [`Localize`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/localize) | Makes a `string` by localizing `Message` based on the current `locale`. |
| [`Clamp`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/clamp) | Constrains the value of `Val` between `A` and `B`. Robustly handles different argument orderings. Returns the median of `Val`, `A`, and `B`, such that comparisons with `NaN` operate as if `NaN > +Inf`. |
| [`Clamp`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/clamp-1) | Constrains the value of `Val` between `A` and `B`. Robustly handles different argument orderings. Returns the median of `Val`, `A`, and `B`. |
| [`Min`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/min) | Returns the minimum of `X` and `Y`. |
| [`Max`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/max) | Returns the maximum of `X` and `Y`. |
| [`Min`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/min-1) | Returns the minimum of `X` and `Y` unless either are `NaN`. Returns `NaN` if either `X` or `Y` are `NaN`. |
| [`Max`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/max-1) | Returns the maximum of `X` and `Y` unless either are `NaN`. Returns `NaN` if either `X` or `Y` are `NaN`. |
| [`Sqrt`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/sqrt) | Returns the square root of `X` if `X >= 0.0`. Returns `NaN` if `X < 0.0`. |
| [`Sin`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/sin) | Returns the sine of `X` if `IsFinite(X)`. Returns `NaN` if `not IsFinite(X) |
| [`Cos`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/cos) | Returns the cosine of `X` if `IsFinite(X)`. Returns `NaN` if `not IsFinite(X) |
| [`Tan`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/tan) | Returns the tangent of `X` if `IsFinite(X)`. Returns `NaN` if `not IsFinite(X). |
| [`ArcSin`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/arcsin) | Returns the inverse sine (arcsine) of `X` if `-1.0 <= X <= 1.0`. |
| [`ArcCos`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/arccos) | Returns the inverse cosine (arccosine) of `X` if `-1.0 <= X <= 1.0`. |
| [`ArcTan`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/arctan) | Returns the inverse tangent (arctangent) of `X` such that:`-PiFloat/2.0 <= ArcTan(x) <= PiFloat/2.0`. |
| [`ArcTan`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/arctan-1) | Returns the angle in radians at the origin between a ray pointing to `(X, Y)` and the positive `X` axis such that `-PiFloat < ArcTan(Y, X) <= PiFloat`. Returns 0.0 if `X=0.0 and Y=0.0`. |
| [`Sinh`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/sinh) | Returns the hyperbolic sine of `X`. |
| [`Cosh`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/cosh) | Returns the hyperbolic cosine of `X`. |
| [`Tanh`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/tanh) | Returns the hyperbolic tangent of `X`. |
| [`ArSinh`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/arsinh) | Returns the inverse hyperbolic sine of `X` if `IsFinite(X)`. |
| [`ArCosh`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/arcosh) | Returns the inverse hyperbolic cosine of `X` if `1.0 <= X`. |
| [`ArTanh`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/artanh) | Returns the inverse hyperbolic tangent of `X` if `IsFinite(X)`. |
| [`Pow`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/pow) | Returns `A` to the power of `B`. |
| [`Quotient`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/quotient) | Returns the quotient `X/Y` as defined by Euclidean division, i.e.:   - `Quotient[X/Y] = Floor[X/Y]` when `Y > 0` - `Quotient[X/Y] = Ceil[X/Y]` when `Y < 0` - `Quotient[X/Y] * Y + Mod[X,Y] = X`   Fails if `Y = 0`. |
| [`Mod`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/mod) | Returns the remainder of `X/Y` as defined by Euclidean division, i.e.:   - `Mod[X,Y] = X - Quotient(X/Y)*Y` - `0 <= Mod[X,Y] < Abs(Y)`   Fails if `Y=0`. |
| [`Exp`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/exp) | Returns the natural exponent of `X`. |
| [`Ln`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/ln) | Returns the natural logarithm of `X`. |
| [`Log`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/log) | Returns the base `B` logarithm of `X`. |
| [`Lerp`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/lerp) | Used to linearly interpolate/extrapolate between `From` (when `Parameter = 0.0`) and `To` (when `Parameter = 1.0`). Expects that all arguments are finite. Returns `From*(1 - Parameter) + To*Parameter`. |
| [`Sgn`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/sgn) | Returns the sign of `Val`:   - `1` if `Val > 0` - `0` if `Val = 0` - `-1` if `Val < 0` |
| [`Sgn`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/sgn-1) | Returns the sign of `Val`:   - `1.0` if `Val > 0.0` - `0.0` if `Val = 0.0` - `-1.0` if `Val < 0.0` - `NaN` if `Val = NaN` |
| [`IsAlmostEqual`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/isalmostequal) | Succeeds if `Val1` and `Val2` are within `AbsoluteTolerance` of each other. |
| [`result`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/result) | Implemented by classes that provide a result for an operation, which can fail or be successful |
| [`MakeSuccess`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/makesuccess) |  |
| [`MakeError`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/makeerror) |  |
| [`signalable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/signalable) | A parametric interface implemented by events with a `payload` that can be signaled. Can be used with `awaitable`, `subscribable`, or both (see: `listenable`). |
| [`Join`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/join) | Makes a `string` by concatenating `Separator` between the elements of `Strings`. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/tostring-2) | Returns `String` without modification. |
| [`ToString`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/tostring-3) | Makes a `string` from `Character`. |
| [`subscribable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/subscribable) | A parametric interface implemented by events with a `payload` that can be subscribed to. Matched with `signalable.` |
| [`subscribable`](/documentation/en-us/fortnite/verse-api/versedotorg/verse/subscribable-1) | A parameterless interface implemented by events that can be subscribed to. |

## Data

| Name | Description |
| --- | --- |
| `Inf` |  |

|  |  |
| --- | --- |
| `NaN` |  |

|  |  |
| --- | --- |
| `PiFloat` |  |
