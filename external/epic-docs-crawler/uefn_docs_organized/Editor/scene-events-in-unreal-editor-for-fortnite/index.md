# Scene Events

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:22:52.082725

---

This Scene Graph feature is in an experimental state. In Project Settings check the box to enable the Experimental Scene Graph Features setting to access these experimental features within Scene Graph.

Should your project contain any experimental Scene Graph features, they will be caught during the [validation process in the Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite-creative/verse-runtime-error-reporting-in-fortnite-creative). You’ll receive a notice about assets restricting your ability to publish your island. Disable the experimental features in Project Settings to publish your island.

[![Enable and disable experimental Scene Graph features in Project Settings.](https://dev.epicgames.com/community/api/documentation/image/a33de478-3270-432d-a2ef-d4bcc7353a24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a33de478-3270-432d-a2ef-d4bcc7353a24?resizing_type=fit)

Enable and disable experimental Scene Graph features in Project Settings.

Scene Graph has a feature built into all entities and components that creates single events or a chain of events in your Scene Graph called **Scene Events**. Scene events are communication protocols that provide a way for different parts of a Scene Graph to talk to one another by  overriding and defining new behavior for entities and components.

Scene events can be reused across your projects, you can expand upon scene events by adding additional events or tweaking the behavior of entities and components in a chain of events to do something slightly different

Multiple components can respond to a scene event, and events can be sent up or down the Scene Graph hierarchy. It might be helpful to imagine them as messages passing across the Scene Graph, giving each component an opportunity to respond to the message.

For example, if you set up a graveyard using Scene Graph, you can use scene events to define a chain of events that begin when the static mesh graveyard gates swing open. The gates’ opening could act as the starting point for a chain of events which cause a particle effect of ghosts to fly out from behind grave stones and spooky music to begin playing.

This could be a scene event you use multiple times in the graveyard, or you could tweak the event so that you can use the basic functions of the scene event – a static mesh door of some kind being opened and causing a series of events to follow.

Scene events are all about decoupling parts of the scene graph from each other, allowing them to communicate through messages instead of directly binding to each other.

## How Scene Events Work

Verse is used to broadcast events across the Scene Graph to specific entities and components. To handle a scene event in a `component`, override the existing `OnReceive(scene_event):logic` function in `component`. Every scene event that passes through your component will then invoke this function, providing a way for you to respond to the event.

A scene event is any class that implements the `scene_event` interface. Scene events can be sent in one of three ways: **SendUp**, **SendDown**, or **SendDirect**.

### SendUp

SendUp, will send the event to the targeted entity and its parent. The parent entity will then pass that event onto its parent and so on, until it reaches the Simulation Entity that the entities in your world are parented to.

The sender doesn't know exactly which receiver will handle the event, or if anything will respond to the event at all. This kind of sending is great for sending telemetry, signaling to higher-level systems, or various kinds of requests that may or may not be handled.

As an example, imagine that you strike a character's feet with a sword, with the foot being deep in its hierarchy. The leg might not handle damage in any way, so the event propagates up to the base of the character, where you've placed a **`damage_receiever_component`** that is able to receive the damage event and process the hit.

In the diagram below, the Parent entity is the event labeled **1** that fires in the first green entity. The SendUp call begins on the Parent entity in the hierarchy and sends the event upward to the Simulation Entity.

[![Diagram depicting SendUp that shows how a scene event is sent up to a targeted parent entity.](https://dev.epicgames.com/community/api/documentation/image/f54b2666-7c90-4f9b-aefe-151e2372ae77?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f54b2666-7c90-4f9b-aefe-151e2372ae77?resizing_type=fit)

Diagram depicting SendUp that shows how a scene event is sent up to a targeted parent entity.

### SendDown

Alternatively, you could use the Simulation Entity as the catalyst and send a series of changes down the tree of entities. SendDown sends the event to the targeted entity and all of its children. Each child then passes that event onto their children.

This could be used in a situation where a global event has occurred, and anything in the scene should have an opportunity to respond to it.

[![Diagram depicting how a parent entity send down a scene event.](https://dev.epicgames.com/community/api/documentation/image/371f790f-6910-42b5-bd6c-950bc4192fa0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/371f790f-6910-42b5-bd6c-950bc4192fa0?resizing_type=fit)

Diagram depicting how a parent entity send down a scene event.

### Send Direct

SendDirect sends an event directly to the targeted entity, but does not pass on the event to parents or children. This is used to target a specific entity or component as illustrated in the diagram below.

[![Diagram depicting a send direct event targeting one entity.](https://dev.epicgames.com/community/api/documentation/image/3892d0b8-df16-4337-8a95-1d8394f0f60a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3892d0b8-df16-4337-8a95-1d8394f0f60a?resizing_type=fit)

Diagram depicting a send direct event targeting one entity.

## Consuming Events

When an event is being sent up or down an entity hierarchy, individual components can choose not to respond to the event. The component marks the event as complete and doesn’t send the event on to its children or parents–essentially acting as an off switch.

Consuming events lets you control the scope of an event’s effect. It works in two ways:

- Making the event relevant to only one entity, not the entity's children, nor its parents.
- Avoids sending the relevant event directly to an entity’s children or parents.

By avoiding sending an event on to a child or parent, you can decide what this event means for the entity’s parents and children, and make it so you can manually send them a different event in response for more control over how those entities respond to the initial event.

For example, an entity receives a damage event via SendDown. A component on one entity could decide to respond to this by taking health away and would not send this event further through the entity hierarchy as it’s not necessary for the child entities to take damage.

However, in the case where a scoring system is in place above the receiving entity, the entity's chain of parents would need to send the damage information to award a medal to the player for damaging enemies. In this situation, a SendUp call could be used on the receiving entity with a special event that sends the damage score on to a parent component listening for the scoring information.

### Consuming Events During SendUp and SendDown

Events can be consumed during event propagation triggered by either SendUp or SendDown by returning `true` from a component's `OnReceive(SceneEvent:scene_event):logic` implementation.

If any component on an entity chooses to consume an event during a `SendUp`, all components on the entity still invoke their respective `OnRecieve` callbacks. Propagation then stops and does not pass on to the entity's parent.

If any component on an entity chooses to consume an event during a `SendDown`, all components on the entity still invoke their respective `OnRecieve` callbacks. The event does not pass on to the entity's children. However, the event will still be passed to the rest of the entities at the same level.

In the diagram below, you’ll notice that while **scene event 4** continues down the chain of events, **scene event 3** does not.

[![Diagram depicting an event that consumes a SendDown event.](https://dev.epicgames.com/community/api/documentation/image/7173a212-e332-4641-8540-c966c1d111f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7173a212-e332-4641-8540-c966c1d111f4?resizing_type=fit)

Diagram depicting an event that consumes a SendDown event.

## Creating a Scene Event

There is some initial setup and sequence work to do before creating scene events. Build the assets listed below to populate mesh components with trees and the particle effects with the appropriate effect.  When you save the particle effect assets they are automatically saved into a Verse file called the **Assets.digest.verse** as Verse objects you can reference in your code.

1. [Lightning Bolt VFX](https://dev.epicgames.com/documentation/unreal-engine/how-to-create-a-beam-effect-in-niagara-for-unreal-engine)

   To make the lightning start at a random point in the sky above an entity and end at a scene graph entity on the ground, modify the lightning bolt VFX as follows:

   - Set **Beam Emitter Setup** > **Beam Start** as **Add Vector to Position**, set **Position** to **SimulationPosition**, set **Vector** to **Random Range Vector** with **Minimum** as (-200.0, -200.0, 1000) and **Maximum** as (200.0, 200.0, 2000.0).
   - Set **Beam Emitter Setup** > **Beam End** as **SimulationPosition**.

   Now the lightning bolt will start somewhere in the sky above the entity and end at the entity on which the `particle_system_component` is attached.
2. [Fire VFX](https://dev.epicgames.com/community/learning/tutorials/q3ZK/creating-fire-with-unreal-engine)
3. Static Mesh Trees and Grass

   Model your own trees with [Modeling Mode](https://dev.epicgames.com/documentation/en-us/uefn/modeling-mode-in-unreal-editor-for-fortnite).

Add these assets to entities, then place multiple Lightning Target entities throughout the Scene Graph where lightning could strike. Each of these Lightning Target entities has a lightning bolt particle\_system\_component ready to receive the instructions you define in your scene event. No additional setup is required.

Entities can be nested in a prefab or entirely separate and spread out in the scene.

[![Example of all the custom assets in the scene.](https://dev.epicgames.com/community/api/documentation/image/e3c8e746-b339-4cc4-a608-bd930af23664?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3c8e746-b339-4cc4-a608-bd930af23664?resizing_type=fit)

Example of all the custom assets in the scene.

Migrate assets from the UE Starter Content pack to make the Fire VFX, or you can make the Lightning and Fire VFX in UE and migrate those assets into your UEFN project.

Make all your assets before adding entities to the scene, this way all the Static Mesh assets you create appear in the mesh component menu.

With the entities in place, think about the sequence of events that cause the forest fire, then think about names for the events that describe what the event is doing. Afterward, follow along with the Verse tutorial in the **Coding the Behavior** section.

### Scene Event Naming Conventions

You can use as many characters as you need when naming a scene event. The nomenclature should describe your event and make the intent of the event clear, for example `damage_taken_event`, `health_power_up_event`, and so on.

There are two major events in the forest fire sequence of events:

- Lightning Strike
- Fire Spreading

To describe what these events are doing, name the lightning event, `struck_by_lightning_event`, and name the fire spreading event, `fire_propagation_event`.

### Sequence of Events

When creating a scene event, view it as an interface that has effects up and down a hierarchy of entities and components. Also, because scene events can be used by other people, consider how another developer could build upon your event or use your event in their own Scene Graph.

The scene event you are building is going to report on the major events that happen before kicking off another event related to the parent event. So the sequence of events is as follows:

1. A scene event occurs in the world called `struck_by_lightning_event`.
2. Entities report whether they were struck by the `struck_by_lightning_even`t or not. Entities struck by lightning trigger the `fire_propagation_event`.
3. The `fire_propagation_event` causes other entities to decide whether or not they are close enough to the `fire_propagation_event` to catch fire as well.
4. The `fire_propagation_event` spreads to the other Mesh components

The `fire_propagation_event` continues to run until every Mesh component that decides it was close enough to the `fire_propagation_event` has caught fire. It should resemble an actual forest fire when running in the scene.

[![Diagram depicting the flow of scene events failure and success flows.](https://dev.epicgames.com/community/api/documentation/image/e2e2a279-4a03-4141-b324-3bc8bb8c393c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2e2a279-4a03-4141-b324-3bc8bb8c393c?resizing_type=fit)

Diagram depicting the flow of scene events failure and success flows.

### Expanding a Sequence

While the `struck_by_lightning_event` causes the `fire_propagation_event`, you could choose to extend the game by adding new things that propagate fire. For example, you add an `explosive_event` that sends a `fire_propagation_event` when it explodes.

Another interesting thing about scene events is that the entities handling the `fire_propagation_event` do not need to know what caused the fire, only that something is causing them to consider whether or not they should be on fire. This makes the code easier to maintain for two reasons:

- A scene event occurs in the world called `struck_by_lightning_event`.

  It's easier to change how the `struck_by_lightning_event` behaves without breaking entities that only care about the `fire_propagation_event`.
- It's easier to write an `explosive_event`, because flammable things only care about the `fire_propagation_event`.

## Coding the Behavior

When the Scene Graph is complete with all the necessary entities, use the code below to create a scene event that starts with a strike of lightning and causes a fire to break out in the trees and cause fire damage.

The **Assets.digest.verse** automatically searches for the Verse objects to reference them in the scene. The particle effects you created are referenced under a VFX module.

```verse
VFX := module:
    Fire_NS<scoped {/InvalidDomain/Scene_Events_Test}> := class<final><public>(particle_system_component):

    Lightning_NS<scoped {/InvalidDomain/Scene_Events_Test}> := class<final><public>(particle_system_component):
```

### Step 1: Create a Scene Graph Component

To create a scene event in UEFN, open the **Verse menu** from the Menu bar and select **Verse Explorer** from the dropdown menu. The Verse Explorer panel opens in the editor, this contains the list of Verse files associated with your project.

Create a new Verse file by doing the following:

1. Right-click on the project name at the top of the list.
2. Select **Add new Verse file to project** from the dropdown menu. The Create Verse Script window opens.
3. Select **Scene Graph Component** from the list of Verse files and name the file **fire\_event\_component**.
4. Click **Create**. The file opens automatically in **Visual Studio Code** (VS Code) and contains boilerplate APIs necessary for creating new component behavior.

   [![Create anew Scene Graph Component named fire_event_component.](https://dev.epicgames.com/community/api/documentation/image/b6f457db-5055-4990-baad-699bafd8e20f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6f457db-5055-4990-baad-699bafd8e20f?resizing_type=fit)

   Create anew Scene Graph Component named fire\_event\_component.

When you are ready to test your script, open the **Verse menu** and select **Build Verse Code** from the dropdown menu. Afterward, select the **Verse button** to run your code.

### Step 2: Add Verse Libraries

Begin your scene event by first building out the sequence of events and conditions that cause the lightning to strike. After the lightning event is defined, build out the forest fire event by defining the properties of the fire damage, fire spreading protocols, and fire extinguishing protocols.

1. Add the following libraries to your component to ensure that you can use spatial math for the location of your lightning and fire, create concurrency, and other Verse features.

   ```verse
   using { /Verse.org/SpatialMath }
   using { /Verse.org/Random }
   using { /Verse.org/Concurrency }
   using { /Verse.org/Simulation }
   using { /Verse.org/SceneGraph }
   ```

### Step 3: Define the Lightning Event Class

This event class determines the source location for the lightning, the lightning hit location, and the `DamageRadius` of the hit location.

1. Create an event class named, `struck_by_lightning_event := class(scene_event):`. The class defines the properties of the scene event in constant expressions that describe where the lightning event occurs in the scene using a vector for location information and the damage radius of the lightning strike using a `float` value.

   ```verse
   # Event to indicate an entity is struck by lightning
   struck_by_lightning_event<public> := class(scene_event):

       # Lightning hit location
       HitLocation:vector3 = vector3{}

       # Lightning damage radius
       DamageRadiusCentimeters:float = 100.0
   ```

### Step 4: Create a Weather Component and Add Editable Properties with Variables

Use editable properties and variables to establish whether the lightning appears in the scene, random lightning strikes, the time between strikes and the damage radius of the lightning strike.

1. Define how the lightning behaves by adding `editable` properties to a component class named, `lightning_weather_component := component ():`. Outline the minimum and maximum amount in the editable properties for the time between lightning strikes and the damage radius of those strikes in centimeters.

   ```verse
   # Component that lives on an entity, and randomly creates lightning strikes
   lightning_weather_component<public> := class<final_super>(component):

       # Minimum random time between lightning strikes
       @editable
       MinRandomLightningDelaySeconds:float = 10.0

       # Maximum random time between lightning strikes
       @editable
       MaxRandomLightningDelaySeconds:float = 60.0

       # Damage radius of lightning bolt in centimeters
       @editable
       LightningDamageRadiusCentimeters:float = 10.0 * 100.0

       # Minimum random duration of lightning strike
       @editable
       MinRandomLightningDurationSeconds:float = 2.0

       # Maximum random duration of lightning strike
       @editable
       MaxRandomLightningDurationSeconds:float = 6.0
   ```

### Step 5: Define the Lightning Event

Use a method to check for the lightning VFX and use its start and end beam properties to determine how close the Mesh components are to the VFX and broadcast this information up and down the event

1. Create an `OnSimulate` conditional `method`.

   ```verse
        OnSimulate<override>()<suspends>:void=
   ```

2. Create and add a `loop` that randomly plays and rests the lightning component using a constant that uses minimum and maximum delay values for the play time.

   ```verse
          loop:
               # Sleep for a random delay before next lightning strike
               RandomDelay := GetRandomFloat(MinRandomLightningDelaySeconds, MaxRandomLightningDelaySeconds)
               Sleep(MaxRandomLightningDelaySeconds
   ```

3. Add an `if` expression that uses the Simulation Entity to find other entities in the simulation since all other entities are children of the Simulation Entity. This way a random entity can be selected to be struck by lightning, rather than using collision to find entities in the scene.

   ```verse
              # Randomly hit an entity in the world with lightning
               if (SimEntity := Entity.GetSimulationEntity[]):
   ```

   Next, the code needs to provide a target for the lightning to hit.
4. Add a `then` expression that broadcasts a request to be the lightning target down from the SimEntity. Then add a conditional `if` expression that responds to this broadcast and causes all the entities that can respond to send an event back up to the SimEntity. Next, you’ll need to find the source of the lightning because a Beam Emitter uses a two-point location for the start and end of the beam.

   ```verse
                  LightningTargets := for (EntityWithLightning : SimEntity.FindDescendantEntitiesWithComponent(particle_system_component)):
                       EntityWithLightning

                   if:
                       LightningTargets.Length > 0
                       RandomIndex := GetRandomInt(0, LightningTargets.Length - 1)
                       RandomEntity := LightningTargets[RandomIndex]
   ```

5. Call the `LightningVFXComponent` to the random location using an if statement. Then add a then expression that plays the beam particle effect in the location set for the source and target locations.

   The `lightning_entity` uses the **Beam Emitter Setup** > **Beam Start** to play the lightning event at random points in the sky. `LightningVFXComponent` then uses
   the Beam particle option Beam Emitter Setup > Beam End to determine where the end of the Beam particle appears in the scene. The setting is set to Simulation Position which uses the end coordinates of the particle effect for the `lightning_entity`.

   Afterward, create and define the damage done by the `struck_by_lightning_event` using the source and target data to locate where the damage occurs on the mesh component target using `DamageRadius` to describe the area affected by the lightning damage. This event will be sent down to the simulation entity to add random lightning duration, so end the chain of events with `SimulationEntity.SendDown(Event)`.

   ```verse
                      if (VFX := RandomEntity.GetComponent[particle_system_component]):
                           RandomDurationOfStrike := GetRandomFloat(MinRandomLightningDurationSeconds, MaxRandomLightningDurationSeconds)
                           VFX.Play()
                           Sleep(RandomDurationOfStrike)
                           VFX.Stop()
                       else:
                           Print("Could not find particle_system_component on this entity")

                       Event := struck_by_lightning_event:
                           HitLocation := Entity.GetGlobalTransform().Translation
                           DamageRadiusCentimeters := LightningDamageRadiusCentimeters
                       
                       SimEntity.SendDown(Event)
   ```

### Step 6: Define the Fire Event

Create event classes that define the damage amount the fire causes and whether the fire should propagate based on the fire damage in the scene.

1. Create two classes. A `fire_damage_event` class and a `fire_propagation_event` class that checks on the `DamageAmount` being done and plays the fire particle when the `DamageAmount` hits the float threshold.

   ```verse
   # Event indicating an entity was damaged by fire
   fire_damage_event<public> := class(scene_event):
       BurningEntity:entity = entity{}
       DamageAmount:float = 100.0

   # Event indicating an entity propagates fire
   fire_propagation_event<public> := class(fire_damage_event):
       FireRadiusCentimeters:float = 100.0
   ```

2. Create a `flammable_component` class that determines that a mesh is flammable and the editable properties that can be set to cause meshes in the scene to catch fire.

   ```verse
   # Component that makes something flammable
   flammable_component<public> := class<final_super>(component):

       # Fire damage amount applied every second
       @editable
       FireDamageAmount:float = 10.0

       # Fire tries to propagate on this interval
       @editable
       FirePropagationIntervalSeconds:float = 10.0
   ```

3. A conditional variable is added to the `flammable_event` that decides whether the fire VFX are playing or should be playing.

   ```verse
       # Is it on fire?
       var IsOnFire:logic = false
   ```

4. An `IsCloseEnoughToBurningEntityToIgnite` function determines if the fire is close enough to to trigger further Fire VFX events.

   ```verse
      # Is this component close enough to the source of a fire propagation event to burst into flames?
       IsCloseEnoughToBurningEntityToIgnite(FirePropogationEvent:fire_propagation_event)<decides><transacts>:void =
           EntityLocation := Entity.GetGlobalTransform().Translation
           FirePropogationLocation := FirePropogationEvent.BurningEntity.GetGlobalTransform().Translation
           DistanceToFire := Distance(EntityLocation, FirePropogationLocation)
           DistanceToFire <= FirePropagationEvent.FireRadiusCentimeters
   ```

5. A `IsCloseEnoughToLightningToIgnite` function determines whether the lightning strike was close enough to the mesh to cause it to burst into flames.

   ```verse
      # Is this component close enough to a lightning strike to burst into flames?

   IsCloseEnoughToLightningToIgnite(LightningEvent:struck_by_lightning_event)<decides><transacts>:void =
           EntityLocation := Entity.GetGlobalTransform().Translation
           LightningStrikeLocation := LightningEvent.HitLocation
           DistanceToFire := Distance(EntityLocation, LightningStrikeLocation)
           DistanceToFire <= LightningEvent.DamageRadiusCentimeters
   ```

6. The OnRecieve function determines which meshes catch fire once the IsCloseEnoughToBurningEntityToIgnite function determines the proximity of the fire propagation, and the IsCloseEnoughToLightningToIgnite variable determines the proximity of the lightning strike to the mesh.

   ```verse
      # Receive scene events
       OnReceive<override>(SceneEvent:scene_event):logic =
           # Burst into flames if lightning hit close enough
           if (LightningEvent := struck_by_lightning_event[SceneEvent], IsCloseEnoughToLightningToIgnite[LightningEvent]):
               Ignite()
           # Burst into flames if something close enough is burning
           if (FireEvent := fire_propagation_event[SceneEvent], IsCloseEnoughToBurningEntityToIgnite[FireEvent]):
               Ignite()
           false
   ```

7. An `Ignite method` is used to play the effect automatically through a conditional if statement that searches for the fire particle system. A `then` statement defines whether it’s true that the component is playing the fire VFX.

   Add asynchronous tasks to the method to check for the fire particle system **Fire\_NS** so the fire spawns and spreads when called.

   ```verse
      # Burst into flames
       Ignite():void =
           if (not IsOnFire?):
               set IsOnFire = true

               # Add a new fire VFX component
               FireVFX := VFX.Fire_NS{Entity := Entity}
               Entity.AddComponents(array{FireVFX})

               # Spawn async tasks to implement the state of being on fire
               spawn{OnFire()}
               spawn{FirePropagation()}
   ```

### Step 7: Define the End of the Fire Event

Next you’ll create a series of methods that determine when Mesh components burst into flames, when the flames extinguish, the damage a fire causes, and when to cause the fire to spread.

1. Now create an `Extinguish method` that stops the fire effect by searching for components playing the fire effect using conditional statements to find the fire particle system and remove the effect.

   ```verse
      # Put out the flames
       Extinguish():void=
           if (IsOnFire?):
               set IsOnFire = false

               # Remove the fire VFX component
               if (FireVFX := Entity.GetComponent[particle_system_component]):
                   FireVFX.RemoveFromEntity()
   ```

2. Create an `OnFire method` that uses a loop that monitors the `FireDamage` and sends the event down the chain of entities toward the end of the event and causes the event to stop playing.

   ```verse
       # Suspends function called when we're on fire
       OnFire()<suspends>:void=
           # Damage self every second
           loop:
               # Fill out a fire damage event - replace this with whatever properties should go here
               FireDamage := fire_damage_event:
                   DamageAmount := FireDamageAmount

               Entity.SendDown(FireDamage)
               Sleep(1.0)
               
               # Keep running task until we stop being on fire
               if:
                   not IsOnFire?
               then:
                   break
   ```

3. Lastly, create a `FirePropagation method` that uses a `loop` to spread the fire down the chain of entities and causes them to extinguish when it reaches the simulation entity.

   ```verse
       # Propagate fire to other entities
       FirePropagation()<suspends>:void=
           loop:
               Sleep(FirePropagationIntervalSeconds)
               if:
                   SimulationEntity := Entity.GetSimulationEntity[]
                   FirePropagationEvent := fire_propagation_event{ BurningEntity := Entity }
               then:
                   # Broadcast fire propagation event down from simulation entity
                   SimulationEntity.SendDown(FirePropagationEvent)

               # Keep running task until we stop being on fire
               if:
                   not IsOnFire?
               then:
                   Break
   ```

When the code is complete, compile the code and add the appropriate entities to the scene graph to support the lightning strikes and forest fire effects. Afterward, add the `flammable_component` to entities in the scene that should catch fire. There needs to be a top-level entity under the simulation entity with the `lightning_weather_component` controlling the weather.

Once all the entities are updated with the appropriate scene events, launch a [Live Edit](https://dev.epicgames.com/documentation/en-us/uefn/playtesting-your-island-in-unreal-editor-for-fortnite) session to see your code working in the scene.

## Result

Copy and paste the code into your project to see the scene event working.

**lightning.verse**

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/Random }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

# Event to indicate an entity is struck by lightning
struck_by_lightning_event<public> := class(scene_event):

    # Lightning hit location
    HitLocation:vector3 = vector3{}

    # Lightning damage radius
    DamageRadiusCentimeters:float = 100.0

# A Verse-authored component that can be added to entities
lightning_weather_component<public> := class<final_super>(component):

    # Minimum random time between lightning strikes
    @editable
    MinRandomLightningDelaySeconds:float = 10.0

    # Maximum random time between lightning strikes
    @editable
    MaxRandomLightningDelaySeconds:float = 60.0

    # Damage radius of lightning bolt in centimeters
    @editable
    LightningDamageRadiusCentimeters:float = 10.0 * 100.0

    # Minimum random duration of lightning strike
    @editable
    MinRandomLightningDurationSeconds:float = 2.0

    # Maximum random duration of lightning strike
    @editable
    MaxRandomLightningDurationSeconds:float = 6.0
  
    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()

        # TODO: Place logic to run when the component starts simulating here
        Print("OnBeginSimulation")

    # Runs when the component should start simulating in a running game.
    # Can be suspended throughout the lifetime of the component. Suspensions
    # will be automatically cancelled when the component is disposed or the
    # game ends.
    OnSimulate<override>()<suspends>:void =
        loop:
            # Sleep for a random delay before next lightning strike
            RandomDelay := GetRandomFloat(MinRandomLightningDelaySeconds, MaxRandomLightningDelaySeconds)
            Sleep(MaxRandomLightningDelaySeconds)

            # Randomly hit an entity in the world with lightning
            if (SimEntity := Entity.GetSimulationEntity[]):
                LightningTargets := for (E : SimEntity.FindDescendantEntitiesWithComponent(particle_system_component)). E

                if:
                    LightningTargets.Length > 0
                    RandomIndex := GetRandomInt(0, LightningTargets.Length - 1)
                    RandomEntity := LightningTargets[RandomIndex]
                then:
                    Print("Chose Lightning target entity")
                    if (VFX := RandomEntity.GetComponent[particle_system_component]):
                        RandomDurationOfStrike := GetRandomFloat(MinRandomLightningDurationSeconds, MaxRandomLightningDurationSeconds)
                        VFX.Play()
                        Sleep(RandomDurationOfStrike)
                        VFX.Stop()
                    else:
                        Print("Could not find particle_system_component on this entity")

                    Event := struck_by_lightning_event:
                        HitLocation := Entity.GetGlobalTransform().Translation
                        DamageRadiusCentimeters := LightningDamageRadiusCentimeters
                    
                    SimEntity.SendDown(Event)
                else:
                    Print("Found no entities with particle_system_component")
```

**fire.verse**

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SpatialMath }

# Event indicating an entity was damage by fire
fire_damage_event<public> := class(scene_event):
    BurningEntity:entity = entity{}
    DamageAmount:float = 100.0

# Event indicating an entity propogates fire
fire_propagation_event<public> := class(fire_damage_event):
    FireRadiusCentimeters:float = 100.0

# Component that makes something flammable
flammable_component<public> := class<final_super>(component):

    # Fire damage amount applied every second
    @editable
    FireDamageAmount:float = 10.0

    # Fire tries to propogate on this interval
    @editable
    FirePropogationIntervalSeconds:float = 10.0

    # Is this component on fire?
    var IsOnFire:logic = false

    # Is this component close enough to the source of a fire propogation event to burst into flames?
    IsCloseEnoughToBurningEntityToIgnite(FirePropogationEvent:fire_propagation_event)<decides><transacts>:void =
        EntityLocation := Entity.GetGlobalTransform().Translation
        FirePropogationLocation := FirePropogationEvent.BurningEntity.GetGlobalTransform().Translation
        DistanceToFire := Distance(EntityLocation, FirePropogationLocation)
        DistanceToFire <= FirePropogationEvent.FireRadiusCentimeters

    # Is this component close enough to a lightning strike to burst into flames?
    IsCloseEnoughToLightningToIgnite(LightningEvent:struck_by_lightning_event)<decides><transacts>:void =
        EntityLocation := Entity.GetGlobalTransform().Translation
        LightningStrikeLocation := LightningEvent.HitLocation
        DistanceToFire := Distance(EntityLocation, LightningStrikeLocation)
        DistanceToFire <= LightningEvent.DamageRadiusCentimeters

    # Receive scene events
    OnReceive<override>(SceneEvent:scene_event):logic =
        # Burst into flames if lightning hit close enough
        if (LightningEvent := struck_by_lightning_event[SceneEvent], IsCloseEnoughToLightningToIgnite[LightningEvent]):
            Ignite()
        # Burst into flames if something close enough is burning
        if (FireEvent := fire_propagation_event[SceneEvent], IsCloseEnoughToBurningEntityToIgnite[FireEvent]):
            Ignite()
        false

    # Burst into flames
    Ignite():void =
        if (not IsOnFire?):
            set IsOnFire = true

            # Spawn async tasks to implement the state of being on fire
            spawn{OnFire()}
            spawn{FirePropagation()}

            # Add a new fire VFX component
            FireVFX := VFX.Fire_NS{Entity := Entity}
            Entity.AddComponents(array{FireVFX})
            

    # Put out the flames
    Extinguish():void=
        if (IsOnFire?):
            set IsOnFire = false

            # Remove the fire VFX component
            if (FireVFX := Entity.GetComponent[particle_system_component]):
                FireVFX.RemoveFromEntity()

    # Suspends function called when we're on fire
    OnFire()<suspends>:void=
        # Damage self every second
        loop:
            # Fill out a fire damage event - replace this with whatever properties should go here
            FireDamage := fire_damage_event:
                DamageAmount := FireDamageAmount

            Entity.SendDown(FireDamage)
            Sleep(1.0)
    
            # Keep running task until we stop being on fire
            if:
                not IsOnFire?
            then:
                break

    # Propagate fire to other entities
    FirePropagation()<suspends>:void=
        loop:
            Sleep(FirePropogationIntervalSeconds)
            if:
                SimulationEntity := Entity.GetSimulationEntity[]
                FirePropagationEvent := fire_propagation_event{BurningEntity := Entity}
            then:
                # Broadcast fire propagation event down from simulation entity
                SimulationEntity.SendDown(FirePropagationEvent)

            # Keep running task until we stop being on fire
            if:
                not IsOnFire?
            then:
                break
```
