# input_events function

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/input_events
> **爬取时间**: 2025-12-27T01:17:59.653759

---

Input\_events is a container for user input events which can be subscribed to.

- Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an input\_events object for a given player.
- Low-level notifications of current user input: DetectionBeginEvent, DetectionOngoingEvent, and DetectionEndEvent.
- High-level notifications of triggered events: ActivationTriggeredEvent and ActivationCanceledEvent.

  /—----------<-------\
  DetectionBeginEvent -> DetectionOngoingEvent -> ActivationTriggeredEvent -> DetectionEndEvent
  /\ /\ /
  ---------------------> ActivationCanceledEvent ----------------------/

|  |  |
| --- | --- |
| Verse `using` statement | `using { /UnrealEngine.com/ControlInput }` |

`input_events<public>(t:any)<computes>:input_events(t)`

This function is a parametric type, meaning it returns a class or interface rather than a value or object instance.

## Parameters

`input_events` takes the following parameters:

| Name | Type | Description |
| --- | --- | --- |
| `t` | `any` |  |

### Generated Class

`input_events` returns the parametric class [`input_events(t)`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/input_events/input_events(t)).

## Attributes, Specifiers, and Effects

### Attributes

The following attributes determine how `input_events` behaves outside the Verse language. For the complete list of attributes, see the Attributes section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Attribute | Arguments | Meaning |
| --- | --- | --- |
| `available` | `MinUploadedAtFNVersion := 3630` | This feature is available beginning with the UEFN version specified by `MinUploadedAtFNVersion` and unavailable prior to that version. |

### Specifiers

The following specifiers determine how you can interact with `input_events` in your programs. For the complete list of specifiers, see the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Specifier | Meaning |
| --- | --- |
| `public` | The identifier is universally accessible. You can use this on modules, classes, interfaces, structs, enums, methods, and data. |

### Effects

The following effects determine how `input_events` behaves in your programs. For the complete list of effects, see the Effect Specifers section of the [Specifiers Page](/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).

| Effect | Meaning |
| --- | --- |
| `computes` | This effect requires that the function has no side effects, and is not guaranteed to complete. There's an unchecked requirement that the function, when provided with the same arguments, produces the same result. Any function that doesn't have the `native` specifier that would otherwise have the `converges` effect is a good example of using the `computes` effect. |
