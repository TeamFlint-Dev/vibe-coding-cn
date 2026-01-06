# ControlInput module

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput
> **爬取时间**: 2025-12-26T23:26:42.163098

---

Module import path: /UnrealEngine.com/ControlInput

- [`UnrealEngine.com`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom)
- **`ControlInput`**

## Classes and Structs

| Name | Description |
| --- | --- |
| [`input_events(t)`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/input_events/input_events(t)) | Input\_events is a container for user input events which can be subscribed to.   - Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an input\_events object for a given player. - Low-level notifications of current user input: DetectionBeginEvent, DetectionOngoingEvent, and DetectionEndEvent. - High-level notifications of triggered events: ActivationTriggeredEvent and ActivationCanceledEvent.  /—----------<-------\   DetectionBeginEvent -> DetectionOngoingEvent -> ActivationTriggeredEvent -> DetectionEndEvent   /\ /\ /   ---------------------> ActivationCanceledEvent ----------------------/ |
| [`player_input`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/player_input) | This is the main manager class for input-related settings and functions for a player. |

## Functions

| Name | Description |
| --- | --- |
| [`input_events`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/input_events) | Input\_events is a container for user input events which can be subscribed to.   - Use the 'GetPlayerInput' and 'GetInputEvents' functions to retrieve an input\_events object for a given player. - Low-level notifications of current user input: DetectionBeginEvent, DetectionOngoingEvent, and DetectionEndEvent. - High-level notifications of triggered events: ActivationTriggeredEvent and ActivationCanceledEvent.  /—----------<-------\   DetectionBeginEvent -> DetectionOngoingEvent -> ActivationTriggeredEvent -> DetectionEndEvent   /\ /\ /   ---------------------> ActivationCanceledEvent ----------------------/ |
| [`GetPlayerInput`](/documentation/en-us/fortnite/verse-api/unrealenginedotcom/controlinput/getplayerinput) | Access input-related data and settings for a player. |
