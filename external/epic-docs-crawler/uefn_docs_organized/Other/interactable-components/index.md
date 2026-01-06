# Interactable Components

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/interactable-components
> **爬取时间**: 2025-12-27T00:43:33.312625

---

**Interactable components** are **Scene Graph components** designed to simplify basic player interactions in UEFN.

These components enable agents to interact with the entity that the components are attached to.

**Interaction** is defined by the agent attempting to start, and being signaled on, the success of the interaction — for instance, pressing the **E** key on PC. The component doesn’t dictate what an interaction does, but only handles the handshake between the interacting agent and the interactable component.

## interactable\_component

The **interactable\_component** is the basis for granting players the ability to interact with objects in a game.

[![](https://dev.epicgames.com/community/api/documentation/image/6372d129-f641-4bbc-baec-9a07c5568abd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6372d129-f641-4bbc-baec-9a07c5568abd?resizing_type=fit)

interactable component

Interactions typically happen when a player presses **the interact button** next to an object. This base component enables the minimal required interactivity to trigger a game event.

The **interactable\_component** needs to be attached to a **mesh\_component** to work.

Using Verse, you can override the default behavior of the component to create custom interactions. Consult the [interactable\_component class API reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/versedotorg/scenegraph/interactable_component) for more details.

### Verse Class

The interactable\_component class can start an interaction and manage cooldowns for both the component and for each agent that interacts with it.

```verse
# An interactable component allows an agent to start and succeed at an interaction.
# The functionality of what happens on success should be implemented by overriding the success event.
interactable_component<public> := class(component, enableable):
    # Set the enable/disable for interaction of the component.
    Enable<override>()<transacts> : void
    Disable<override>()<transacts> : void
    IsEnabled<override>()<decides><reads> : void

    # Event fires when an interaction starts. Sends the interacting agent.
    StartedEvent<public> : listenable(agent) = external{}

    # Event fires when an interaction has completed successfully. Sends the formerly interacting agent.
    SucceededEvent<public> : listenable(agent) = external{}

    # Event fires when an interaction has ended before completing successfully. Sends the formerly interacting agent.
    # This event is called on all interacting agents when Disable() is called on the component.
    CanceledEvent<public> : listenable(agent) = external{}

    # Fires the StartedEvent event.
    SignalStartEvent<protected>(:agent)<transacts> : void

    # Fires the SucceededEvent event.
    SignalSucceedEvent<protected>(:agent)<transacts> : void

    # Fires the CanceledEvent event.
    SignalCancelEvent<protected>(:agent)<transacts> : void

    # Attempt to start an interaction. Fails if the agent does not pass the CanInteract function.
    Start<public><final>(:agent)<decides><transacts> : void
    
    # Called from Start if CanInteract passes successfully to start the interaction. Overriding this function will allow you to create a custom interaction behaviour.
    OnStart<protected>(:agent)<decides><transacts> : void

    # Returns whether the specified agent can interact.
    CanInteract<public>(:agent)<decides><reads> : void

    # Returns an appropriate message to display to players to communicate the current state of the interactable.
    InteractMessage<public>(:agent)<decides><reads> : message
```

### Examples

In this first example, the user can interact with a mesh that modifies the state from Enabled to Disabled. The entity is composed of a **mesh\_component** of a computer and the customized **interactable\_enableable\_component**.

interactable button

Below is the code used for the interactable\_enableable\_component:

```verse
using { /Verse.org }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Fortnite.com/Game }

# Allows a Enable/Disable state on the interactable_component
interactable_enableable_component<public> := class<final_super>(interactable_component):

    # Default text to show on the UI
    EnabledText<localizes> : message = "Enabled"
    DisabledText<localizes> : message = "Disabled"

    # Handles to cancel the subscriptions
    var RoundStartedHandle<public>:?cancelable = false
    var RoundEndedHandle<public>:?cancelable = false
    var SucceededEventHandle<public>:?cancelable = false

    # Stores the state of the interaction
    var IsInteractEnabled<protected>:logic = true

    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()

        # Subscribes to round start/end 
        if (RoundManager := Entity.GetFortRoundManager[]):
            RoundStartedCancelable := RoundManager.SubscribeRoundStarted(OnBeginRound)
            set RoundStartedHandle = option{RoundStartedCancelable}

            RoundEndedCancelable := RoundManager.SubscribeRoundEnded(OnEndRound)
            set RoundEndedHandle = option{RoundEndedCancelable}

    OnEndSimulation<override>():void =
        # Run OnEndSimulation from the parent class before
        # running this component's OnEndSimulation logic
        (super:)OnEndSimulation()

        # Cancel round start/end
        if (RoundStartedCancelable := RoundStartedHandle?):
            RoundStartedCancelable.Cancel()

        if (RoundEndedCancelable := RoundEndedHandle?):
            RoundEndedCancelable.Cancel()

    OnBeginRound<protected>():void=
        Print("Round Started!")
        set SucceededEventHandle = option{SucceededEvent.Subscribe(OnSucceed)}

    OnEndRound<protected>():void=
        Print("Round Ended!")
        if (SucceededEventCancelable := SucceededEventHandle?):
            SucceededEventCancelable.Cancel()

    OnSucceed<protected>(Agent:agent):void=
        if (IsInteractEnabled?):
            set IsInteractEnabled = false
            Print("Interact is now Disabled.")
        else:
            set IsInteractEnabled = true
            Print("Interact is now Enabled.")

    InteractMessage<override>(Agent:agent)<decides><reads> : message =
        # Overriding this function will allow us to change the UI text depending on our custom behaviour.
        if (IsInteractEnabled?):
            return EnabledText
        else:
            return DisabledText
```

In this second example, the interaction triggers the light turning on inside the lantern. The entity is made of a **lamp mesh component** and the interactable\_enableable\_light\_component.

interactable lamp

Below is the code used for the interactable\_enableable\_light\_component:

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

# Will turn on/off a light after interacting with the entity
interactable_enableable_light_component<public> := class<final_super>(interactable_enableable_component):

    # Entity who has the light_component attached
    @editable
    LightEntity<public>:entity

    # Overrides the default texts to add light information related
    EnabledText<localizes><override> : message = "Light Off"
    DisabledText<localizes><override> : message = "Light On"

    OnBeginRound<override>():void=
        (super:)OnBeginRound()

        # Initialise IsInteractEnabled with the current state of the light component 
        if (Light:sphere_light_component = LightEntity.GetComponent[sphere_light_component]):
            if (Light.IsEnabled[]):
                set IsInteractEnabled = true
            else:
                set IsInteractEnabled = false

    OnSucceed<override>(Agent:agent):void=
        # Enable/Disable the light depending if the light component is disabled/enabled
        if (Light:sphere_light_component = LightEntity.GetComponent[sphere_light_component]):
            if (IsInteractEnabled?):
                Light.Disable()
            else:
                Light.Enable()

        (super:)OnSucceed(Agent)
```

## basic\_interactable\_component

This feature is in an Experimental state so you can try it out, provide feedback, and see what we are planning. Please keep in mind that we do not guarantee backward compatibility for assets created at the experimental stage, the APIs for these features are subject to change, and we may remove entire Experimental features or specific functionality at our discretion. Check out the [list of known issues](https://dev.epicgames.com/documentation/en-us/fortnite/scene-graph-known-issues-in-fortnite) before you start working with the feature.

The **basic\_interactable\_component** gives more control over the interaction parameters.

[![](https://dev.epicgames.com/community/api/documentation/image/65d2c044-975d-4d90-a2e7-185c84a66665?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65d2c044-975d-4d90-a2e7-185c84a66665?resizing_type=fit)

basic\_interactable component

The basic interactable component allows for interactions to have a duration that must elapse before the interaction succeeds, and it handles the complexity around this potentially by allowing multiple interactions simultaneously.

It also allows a way to manage the cooldown time between each interaction, which can vary based on the interacting agent.

Interactions are governed by the basic\_interactable\_component Verse class.

### Verse Class

```verse
# An interactable component with a composable feature set.
basic_interactable_component<public> := class(interactable_component):
    # Cooldowns begin elapsing on successful interactions. A cooldown which applies for all attempts to interact on this component.
    @editable
    Cooldown<public> : ?interactable_cooldown = false

    # Cooldowns begin elapsing on successful interactions. A cooldown which applies for future attempts to interact on this component by the agent which succeeded.
    @editable
    CooldownPerAgent<public> : ?interactable_cooldown_per_agent = false

    # Success limits prevent new interactions once the component has been successfully interacted with a specified number of times.
    @editable
    SuccessLimit<public> : ?interactable_success_limit = false

    # An interaction with a duration does not succeed until the duration has elapsed, and success is not guaranteed as it can be canceled while the duration is active.
    @editable
    InteractableDuration<public> : ?interactable_duration = false

    # The agents which are currently interacting with this interactable.
    var<private> InteractingAgents<public> : []agent

    # Attempt to cancel an interaction. Fails if the supplied agent is not currently interacting with the component.
    Cancel<public>(:agent)<decides><transacts> : void

    # Attempt to succeed at an interaction.
    # Success will also happen automatically after InteractDuration has elapsed after starting an interaction, provided that interaction wasn’t ended before then.
    # Fails if the agent is not currently interacting with the component.
    Succeed<public>(:agent)<decides><transacts> : void

    # Get the remaining cooldown of the interactable for the supplied agent.
    # This returns the duration left in seconds of either the shared or per agent cooldown, whichever is greater.
    # Returns the same value when called multiple times within a transaction.
    GetRemainingCooldownDurationAffectingAgent<public>(:agent)<reads> : float
```
