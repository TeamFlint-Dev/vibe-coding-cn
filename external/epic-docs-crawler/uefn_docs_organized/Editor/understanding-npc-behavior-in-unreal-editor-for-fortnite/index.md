# Understanding NPC Behaviors

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/understanding-npc-behavior-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:02:27.471725

---

Non-player character (NPC) behaviors play a critical role in many games. From companions to bosses, merchants to guards, how NPCs interact with the world around them drives engaging, immersive gameplay. At first glance, these behaviors may seem intimidating, but in reality, most NPCs follow a strict set of logical rules. Understanding these rules is key when creating NPCs, and on this page, you’ll learn about how NPCs interact with the world, and how you can visualize and manipulate their behaviors to create your own unique experiences.

The NPC Spawner Device facilitates a lot of NPC and AI interactions. To learn more about the device see, [NPC Spawner Device](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite), [NPC Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite), [Create Custom NPC Behavior page](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite), and [Using the NPC Spawner with Animations](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-npc-spawner-with-animations-in-unreal-editor-for-fortnite).

## Logic Rules

Most NPCs do not act randomly, and choose their next action based on their **state**. You can understand an NPC’s state as a snapshot of the NPC’s world at a particular moment. The actions the NPC is taking, the actions players are taking, and any other variables the NPC might know about all make up the NPC’s state. NPCs use logical rules to decide when to transition from state to state and may have many different rules depending on their current state.

### Finite-State Machines

A common way to visualize states is through a **Finite-State Machine** (FSM). A finite-state machine describes the different states an NPC can be in and the transitions it makes from state to state. Nodes represent the different states, and the arrows between them describe the conditions needed to transition from one state to the next. A basic FSM diagram might look like this:

[![Basic FSM](https://dev.epicgames.com/community/api/documentation/image/88d242c2-5b63-4179-991c-c812911d8d6f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88d242c2-5b63-4179-991c-c812911d8d6f?resizing_type=fit)

Here the FSM has three states and starts in State 1. Once specific conditions are reached the NPC jumps from one state to the next, and continues jumping states as conditions change.

For instance, consider the FSM for a simple battle medic character. If there are injured teammates nearby, the medic heals teammates. If there are enemies nearby, the medic attacks enemies. Otherwise, it stands idle. A basic FSM for this character might look like the following:

[![Basic Medic FSM](https://dev.epicgames.com/community/api/documentation/image/32d47a04-a286-427a-a017-40eb204f0938?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32d47a04-a286-427a-a017-40eb204f0938?resizing_type=fit)

FSMs help you visualize and understand the way characters work, and help you map out the ways characters respond to events and the world around them.

### Guard Example Finite-State Machine

For an in-game example, let’s look at the guard NPC. Guard NPCs can be either spawned from the guard spawner device or created with a guard-type [NPC Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite). A guard-type NPC follows a particular set of logic rules, which correspond to the different active states the guard can be in:

- **Idle**
- **Patrolling**
- **Suspicious**
- **Alert**
- **Attacking**

When a guard spawns, it either begins idle or starts patrolling if the patrol option is enabled. When the guard detects a target, it begins to fill the suspicion meter. If the meter is filled, the guard enters the alert phase, otherwise, it returns to patrolling. While alert, the guard will continuously navigate to their target, attacking them if they’re in range. If the target is eliminated or escapes the guard, the guard will return to patrolling. You can visualize the guard’s logic with the following FSM:

[![Guard FSM](https://dev.epicgames.com/community/api/documentation/image/24d34322-a188-4cc5-a990-cc13c6f48b42?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24d34322-a188-4cc5-a990-cc13c6f48b42?resizing_type=fit)

This FSM provides a high-level overview of guard behavior, but there may be many more rules and actions a guard take. NPCs may be acting on multiple things at once, and it’s important to consider environmental factors as you add them to your experiences.

## NPC States and Verse

NPCs in UEFN inherit from the AI module and expose functions you can use to directly control their state. For instance, the `navigatable` interface lets you navigate an NPC to an area, while the `focus_interface` lets you force a character to focus on a particular object or agent. By using these [interfaces](https://dev.epicgames.com/documentation/en-us/fortnite/interface-in-verse) within either Verse Devices or NPC Behaviors, you can create custom NPCs to populate your experiences.

For more information on creating your own NPC Behaviors, check out the [Create Custom NPC Behavior page](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite).

For instance, consider the following NPC Behavior:

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Game }
using { /Verse.org/Simulation }

on_damaged_behavior<public> := class(npc_behavior):

    # This function runs when the NPC is spawned in the world and ready to follow a behavior.
    OnBegin<override>()<suspends>:void=
        if:
            Agent := GetAgent[]
            FortCharacter := Agent.GetFortCharacter[]
        then:
            # Subscribe the character's damaged event to OnDamaged
            FortCharacter.DamagedEvent().Subscribe(OnDamaged)

    # When the NPC is damaged, start chasing the character
    # that instigated the damage
    OnDamaged(DamageResult:damage_result):void=
        Instigator := DamageResult.Instigator
        if:
            # Get the Agent and the Navigatable interface
            Agent := GetAgent[]

            Character := Agent.GetFortCharacter[]
            Navigatable := Character.GetNavigatable[]

            # Get the agent that instigated the damage
            InstigatingAgent := agent[Instigator?]

        then:
            # Start navigating to the InstigatingAgent
            NavigationTarget := MakeNavigationTarget(InstigatingAgent)
            spawn{Navigatable.NavigateTo(NavigationTarget)}
```

All NPCs implement the `damageable` interface, which allows them to take damage. Subscribing a function to the `damageable` interface’s `DamagedEvent` lets you know when your NPC is damaged, and lets you run code in response. In the above script, when an NPC that implements this behavior is damaged, it will get the agent that damaged it and store it in a variable `InstigatingAgent`. Then, using the NPC’s `navigatable` interface, it will set the instigator as a `NavigationTarget` and chase it down.

This behavior is an extension of the NPC’s original behavior. If this script is attached to guard-type character, they will still perform all their regular guard behaviors, but when damaged will navigate directly to their target. The same applies to wildlife and custom-type characters. NPC behavior scripts are a powerful tool to extend NPC functionality and allow you to create your own custom NPCs to fit your experiences. For more information on creating your own custom NPC behavior scripts, see [Create Custom NPC Behavior](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite).

## NPC Types

Different types of NPCs implement different base behaviors, and custom NPCs you create from these NPC types will inherit these behaviors. For more information on the different base types of NPCs and their associated behaviors, see [NPC Types](https://dev.epicgames.com/documentation/en-us/fortnite/npc-types-in-unreal-editor-for-fortnite).

## Navigating in World

When navigating the world, NPCs have to make choices about the best route to take to get to their destination. Does the guard mantle over a wall, or smash through it? Should it swim through water, or go around it? NPCs make these decisions based on the world’s **navigation mesh**. NPCs use the navigation mesh to make [pathfinding](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) decisions and update their choices as the world updates around them. For more information on using and visualizing the navigation mesh, see the [Navigation Mesh](https://dev.epicgames.com/documentation/en-us/fortnite/navigation-mesh-in-fortnite-creative) page.
