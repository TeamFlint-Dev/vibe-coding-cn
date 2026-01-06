# Movement and Interaction

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/sample-tutorial-02-movement-and-interaction-in-fortnite
> **爬取时间**: 2025-12-27T02:39:00.131377

---

The lanterns in the Scene Graph tutorial use multiple Verse-authored components to create 
dynamic and interactive prefabs. This is possible by programming movement and interactability into a Verse-authored component.

## Simulating Simple Movement

The light post prefab uses two different components to simulate moving the lantern. Both of these are attached to the **Pivot** entity, which provides a pivot point to move the lantern around. First, the **keyframed\_movement\_component** allows you to build animations from keyframes and then play them to animate an entity. This component can’t act alone however, and needs another piece of code to provide the keyframes and start the animation. This is where the custom **simple\_movement\_component** comes in. This script is reused across the project to control how different game objects move in the scene.

To learn more about using animations to move objects, check out [Animating Prop Movement](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-in-verse).

Let’s take a closer look at the **simple\_movement\_component**. Open up the `SimpleMovementComponent.verse` script from the **Verse Explorer** in Visual Studio Code to get started.

Animations use different playback modes to define what the animation should do when it completes. These are defined at the top of the file in the `movement_mode` enum:

- **One Shot** - The object stops moving when it finishes the animation.
- **Loop** - The object restarts the animation from the beginning when it reaches the end.
- **Ping Pong** - The object plays the animation in reverse, going back and forth from the start to the end.

```verse
movement_mode<public> := enum:
    OneShot
    Loop
    PingPong
```

The `basic_movement_component` class also defines variables needed to build animations. Each of these has the `@editable` attribute to allow you to edit them from the outliner:

- `Keyframes`: The array of `keyframed_movement_delta` used to build the animation. Each of these tracks the change in transform at this particular keyframe, the duration of the keyframe, and the type of movement easing used.
- `AutoPlay`: A `logic` variable that dictates whether the entity should animate when it begins simulating.
- `MovementMode`: The movement behavior the entity exhibits.

```verse
# A Verse-authored component that can be added to entities
basic_movement_component<public> := class<final_super>(component):

    @editable
    var Keyframes<public>: []keyframed_movement_delta = array{}

    @editable
    var AutoPlay: logic = true

    @editable
    MovementMode: movement_mode = movement_mode.Loop
```

The code in `OnSimulate()` starts running whenever the component is added to the scene and when the game begins. Here, the code first uses a short `Sleep()` call to make sure all entities and components are properly initialized before proceeding. Then, in an `if` expression, it checks if the entity has a `keyframed_movement_component`.

If so, it calls the `InitializeKeyFramedMovementComponent()` function to set the component up with proper values. What if the entity doesn’t have a `keyframed_movement_component`? In that case, you can create one dynamically at runtime and add it to the entity using the `AddComponents()` function. This way you guarantee that your entity is set up properly when the game begins!

```verse
   OnSimulate<override>()<suspends>:void =
        Sleep (0.1)
        if:
            KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            InitializeKeyframedMovementComponent(KeyframedMovementComponent)
        else:
            NewKeyFramedMovementComponent := keyframed_movement_component { Entity := Entity }
            Entity.AddComponents of array { NewKeyFramedMovementComponent }
            InitializeKeyframedMovementComponent(NewKeyFramedMovementComponent)
```

The `InitializeKeyframedMovementComponent()` function set the keyframed movement component with values based on the ones you assign in the editor. First, it creates a new `keyframed_movement_playback_mode` variable to determine the playback mode used during this animation. This is initialized with the `oneshot_keyframed_movement_playback_mode` value, meaning the animation will play only once.

```verse
InitializeKeyframedMovementComponent(InKeyframedMovementComponent:keyframed_movement_component):void =
        var PlaybackMode:keyframed_movement_playback_mode = oneshot_keyframed_movement_playback_mode{}
```

It then uses a `case` statement to set the `PlaybackMode` based on `MovementMode` value set in the editor.  Each value in the `MovementMode` enum corresponds to a different playback mode defined in the `SceneGraph/KeyframedMovement` module.

```verse
case (MovementMode):
    movement_mode.OneShot =>
        set PlaybackMode = oneshot_keyframed_movement_playback_mode{}
    movement_mode.Loop =>
        set PlaybackMode =  loop_keyframed_movement_playback_mode{}
    movement_mode.PingPong =>
        set PlaybackMode = pingpong_keyframed_movement_playback_mode{}
```

Finally, the function sets the keyframes and movement mode on the keyframed movement component, and the animation is now ready to play. If the `AutoPlay` variable is set to true, then the animation immediately starts by calling the keyframed movement component’s `Play()` function.

```verse
        InKeyframedMovementComponent.SetKeyframes(Keyframes, PlaybackMode)
        if:
            AutoPlay?
        then:
            InKeyframedMovementComponent.Play()
```

Back in the editor, the **simple\_movement\_component** gets added to the **Pivot** entity and set with the following values. Now, when the game begins, the lantern will start swinging back and forth!

[![The simple_movement_component gets added to the Pivot entity and set with the following values.](https://dev.epicgames.com/community/api/documentation/image/df0fc17b-06df-470e-b4c4-1fb3ea86cf1d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/df0fc17b-06df-470e-b4c4-1fb3ea86cf1d?resizing_type=fit)

### Complete Script

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph/KeyframedMovement }

movement_mode<public> := enum:
    OneShot
    Loop
    PingPong

# A Verse-authored component that can be added to entities
basic_movement_component<public> := class<final_super>(component):

    @editable
    var Keyframes<public>: []keyframed_movement_delta = array{}

    @editable
    var AutoPlay: logic = true

    @editable
    MovementMode: movement_mode = movement_mode.Loop
       

    OnSimulate<override>()<suspends>:void =
        Sleep (0.1)
        if:
            KeyframedMovementComponent := Entity.GetComponent[keyframed_movement_component]
        then:
            InitializeKeyframedMovementComponent(KeyframedMovementComponent)
        else:
            NewKeyFramedMovementComponent := keyframed_movement_component { Entity := Entity }
            Entity.AddComponents of array { NewKeyFramedMovementComponent }
            InitializeKeyframedMovementComponent(NewKeyFramedMovementComponent)

    InitializeKeyframedMovementComponent(InKeyframedMovementComponent:keyframed_movement_component):void=
       var PlaybackMode:keyframed_movement_playback_mode = oneshot_keyframed_movement_playback_mode{}
       
        case (MovementMode):
            movement_mode.OneShot =>
                # set PlaybackMode = oneshot_keyframed_movement_playback_mode{}
            movement_mode.Loop =>
                set PlaybackMode =  loop_keyframed_movement_playback_mode{}
            movement_mode.PingPong =>
                set PlaybackMode = pingpong_keyframed_movement_playback_mode{}

        InKeyframedMovementComponent.SetKeyframes(Keyframes, PlaybackMode)
       
        if:
            AutoPlay?
        then:
            InKeyframedMovementComponent.Play()
```

## Interacting with the Lantern

The lantern can sway back and forth, but you’ll need another piece to let your player interact with it. This is done by attaching an [Intractable component](https://dev.epicgames.com/documentation/en-us/uefn/interactable-components) to the **Lantern** entity and a custom Verse **lantern\_interaction\_component** to the light post that lets you turn the lantern on and off.

Open up the `LanternInteractionComponent.verse` script from the **Verse Explorer**. This script starts by importing the `LightPost` module defined in `Assets.digest.verse`. This is where all the assets related to the light post such as the prefab are stored. It also imports the `LightPost.Materials` module to access the light post and lantern’s materials and meshes.

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

LightPost := module:
    Materials<public> := module:

lantern_interaction_component<public> := class<final_super>(component):
```

The `lantern_interaction_component` class starts by defining a variable named `MaterialInstance`, which is initialized to `LightPost.Materials.MI_Lantern_01`. This is the material instance that contains all the variables related to the lantern’s material.

```verse
lantern_interaction_component<public> := class<final_super>(component):

    var MaterialInstance:LightPost.Materials.MI_Lantern_01 = LightPost.Materials.MI_Lantern_01{}
```

In `OnBeginSimulation()`, the script starts by finding each component on its descendant entities with an `interactable_component` attached. Because the `lantern_interaction_component` is attached to the light post, this will return the **Lantern** entity’s **interactable\_component** since it’s a descendant of the light post.

```verse
    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        InteractabeleComponents := Entity.FindDescendantComponents(interactable_component)
```

Next, in a `for` expression, the script iterates through every interactable component found and subscribes their `SucceededEvent` to the `OnInteractFinished()` function defined later in this file. Now when a player finishes interacting with the lantern, `OnInteractFinished()` will be fired.

```verse
        InteractabeleComponents := Entity.FindDescendantComponents(interactable_component)
        for (InteractableComponent : InteractabeleComponents):
            InteractableComponent.SucceededEvent.Subscribe(OnInteractFinished)
```

The `OnBeginSimulation()` function then calls `FindDescendantComponents` again to find each entity that has a `LightPost.SM_Lightpost_Lantern_01` component attached. This is the mesh component attached to the lantern. It then sets the mesh component to the `MaterialInstance` defined earlier, ensuring that the lantern’s mesh is properly initialized.

```verse
        MeshComponents := Entity.FindDescendantComponents(LightPost.SM_Lightpost_Lantern_01)
        for (MeshComponent : MeshComponents):
            set MeshComponent.M_Lantern = MaterialInstance
```

The `OnInteractFinished()` function takes the Agent, or player, as the instigator for the interaction. This function simply calls the `ToggleLight()` function to toggle the lantern on and off.

The `ToggleLight()` function does the heavy lifting in terms of turning the lantern on and off. First, in an `if` expression, it checks if the emissive level of the `MaterialInstance` is `0.0`, indicating that the light is off. If so, it sets the emissive level to `1.0`. Then in two `for` expressions, it finds every `light_component` and `particle_system_component` on descendant entities and turns them on by calling `Enable()` and `Play()` respectively.

```verse
    ToggleLight():void =
        if (MaterialInstance.Emissive_Multiply = 0.0):
            set MaterialInstance.Emissive_Multiply = 1.0
            for:
                Light : Entity.FindDescendantComponents(light_component)
            do:
                Light.Enable()

            for:
                Particle : Entity.FindDescendantComponents(particle_system_component)
            do:
                Particle.Play()
```

If the light was already on, the function does the reverse inside the `else` statement. It sets the material emissive levels to `0.0` and disables any light and particle system components on descendant entities.

```verse
        else:
            set MaterialInstance.Emissive_Multiply = 0.0
            for:
                Light : Entity.FindDescendantComponents(light_component)
            do:
                Light.Disable()

            for:
                Particle : Entity.FindDescendantComponents(particle_system_component)
            do:
```

The functions in this script combine together to make the lantern dynamic, turning multiple components on and off when a player interacts with it. Note that while the lantern is the one being turned on and off, its parent light post entity is the one providing the **lantern\_interaction\_component**.

Consider what you would need to do to have a light post with multiple lights, turning each of them on and off with the press of a single button. Because this code operates by finding descendant entities with a particular component type, you wouldn’t need an extra Verse code to implement this functionality. As long as each child lantern entity had a light component or a particle component you’d be good to go!

### Complete Script

```verse
using { /Verse.org }
using { /Verse.org/Native }
using { /Verse.org/SceneGraph }
using { /Verse.org/Simulation }

LightPost := module:
    Materials<public> := module:

lantern_interaction_component<public> := class<final_super>(component):

    var MaterialInstance:LightPost.Materials.MI_Lantern_01 = LightPost.Materials.MI_Lantern_01{}

    OnBeginSimulation<override>():void =
        (super:)OnBeginSimulation()

        InteractabeleComponents := Entity.FindDescendantComponents(interactable_component)
        for (InteractableComponent : InteractabeleComponents):
            InteractableComponent.SucceededEvent.Subscribe(OnInteractFinished)

        MeshComponents := Entity.FindDescendantComponents(LightPost.SM_Lightpost_Lantern_01)
        for (MeshComponent : MeshComponents):
            set MeshComponent.M_Lantern = MaterialInstance

    OnInteractFinished(Agent:agent):void =
        ToggleLight()

    ToggleLight():void =
        if (MaterialInstance.Emissive_Multiply = 0.0):
            set MaterialInstance.Emissive_Multiply = 1.0
            for:
                Light : Entity.FindDescendantComponents(light_component)
            do:
                Light.Enable()

            for:
                Particle : Entity.FindDescendantComponents(particle_system_component)
            do:
                Particle.Play()
        else:
            set MaterialInstance.Emissive_Multiply = 0.0
            for:
                Light : Entity.FindDescendantComponents(light_component)
            do:
                Light.Disable()

            for:
                Particle : Entity.FindDescendantComponents(particle_system_component)
            do:
                Particle.Stop()
```
