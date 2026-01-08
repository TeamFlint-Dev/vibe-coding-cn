# Puzzle Component

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-02-puzzle-component-in-fortnite>
> **爬取时间**: 2025-12-27T02:38:34.458775

---

This page guides you through creating a new Scene Graph component named `puzzle_component` that manages a puzzle built with Scene Graph entities. Once built, place a `puzzle_component` on a Scene Graph entity to determine whether a puzzle consisting of descendant Scene Graph entities with triggerable [components](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#component) that are specified as puzzle pieces is solved.

For example, the following image is a simple puzzle you will construct in the last section of this tutorial.

[![Create a puzzle_component that manages a puzzle built with Scene Graph entities.](https://dev.epicgames.com/community/api/documentation/image/9e0a9fb6-5c1a-4f0e-bee9-337e9368672d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e0a9fb6-5c1a-4f0e-bee9-337e9368672d?resizing_type=fit)

The **[Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner-panel)** corresponding to this puzzle is shown in the next image.

[![The list of prefabs in the Outliner that make up the puzzle and puzzle functionality.](https://dev.epicgames.com/community/api/documentation/image/972b43b6-f812-4d59-beb0-b26003223a55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/972b43b6-f812-4d59-beb0-b26003223a55?resizing_type=fit)

Every descendant [entity](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#entity) of **Prefab\_PuzzleManager** is part of the puzzle managed by the **Prefab\_PuzzleManager**'s corresponding `puzzle_component`. The `puzzle_component`:

- Receives events when a puzzle piece has been switched to the solved configuration.
- Determines when the puzzle is solved.
- Sends events down the Scene Graph [hierarchy](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#hierarchical) when the puzzle is solved to trigger actions corresponding to the solution.

When the player steps on the platforms and turns on both of the lights, the [mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#mesh) animates and [transforms](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#transform).

[![](https://dev.epicgames.com/community/api/documentation/image/4f39f5bc-b192-45a1-bee9-c9b26cd2d3c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f39f5bc-b192-45a1-bee9-c9b26cd2d3c5?resizing_type=fit)

For more information about the Verse language features used on this page, see:

- [Scene Events](https://dev.epicgames.com/documentation/en-us/fortnite/scene-events-in-unreal-editor-for-fortnite)
- [Creating Your Own Component Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite)

## Define the Puzzle Solved Event

1. To begin, navigate to the **[Verse Explorer](https://dev.epicgames.com/documentation/en-us/uefn/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite)**, right-click the project name, and choose **Add new Verse file to project**.

   [![](https://dev.epicgames.com/community/api/documentation/image/232bece4-8b5a-4ef2-97bf-035111c6b77b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/232bece4-8b5a-4ef2-97bf-035111c6b77b?resizing_type=fit)
2. Choose the template **Scene Graph Component** and change the **Component Name** to **puzzle\_component**.

   [![Select Scene Graph Component, name the component, then select Create or Create Empty.](https://dev.epicgames.com/community/api/documentation/image/5251d901-53e1-4025-a546-57fbf05bb8a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5251d901-53e1-4025-a546-57fbf05bb8a6?resizing_type=fit)
3. Define the `puzzle_solved_event`. This is the event that is transmitted through the Scene Graph hierarchy when the puzzle is solved to trigger an action, such as opening a gate or extending a bridge so the player can move beyond the area gated by the puzzle. Define the `puzzle_solved_event` as a child class of `scene_event`. This event does not require any parameters passed down the hierarchy.

   ```verse
   puzzle_solved_event<public> := class(scene_event){}
   ```

## Define the Puzzle Component

Next, define the `puzzle_component` with fields and functions to manage the puzzle and whether or not it is solved.

1. Add fields to track whether or not the puzzle is solved, an array of which puzzle pieces are in the solved configuration, and whether or not puzzle pieces continue to trigger after the puzzle is solved:

   ```verse
   puzzle_component := class<final_super>(component):

       # Is this puzzle component solved
       var<private> Solved<public>:logic = false

       # Map of puzzle pieces and whether they have been "solved"
       var<private> TriggerableEntities<private>:[]entity = array{}

       # Disable puzzle pieces triggering once puzzle is solved
       @editable
       DisablePuzzleTriggerablesWhenSolved<private>:logic = false
   ```

2. Add a function named `InitializeTriggerableDescendantEntities` to initialize the list of all puzzle pieces that are part of this puzzle. This function traverses down the Scene Graph hierarchy to find all triggerable entities marked as being a puzzle piece and adds them to the `TriggerableEntities` array.

   ```verse
       # Initialize array of triggerable entities
       InitializeTriggereableDescendantEntities<private>()<transacts>:void=
           for:
               DescendantEntity : Entity.FindDescendantEntities(entity)
               DescendantEntityComponent : DescendantEntity.GetComponents()
               CastToTriggerable := triggerable[DescendantEntityComponent]
               CastToTriggerable.PuzzlePiece?
           do:
               set TriggerableEntities += array{DescendantEntity}
   ```

3. Add a function named `DisableTriggerableComponents` to disable any triggerable components on descendant entities.

   ```verse
       # Disable puzzle pieces
       DisableTriggerableComponents<private>():void=
           for:
               DescendantEntity : Entity.FindDescendantEntities(entity)
               DescendantEntityComponent : DescendantEntity.GetComponents()
               CastToTriggerable := triggerable[DescendantEntityComponent]
               CastToTriggerable.PuzzlePiece?
               CastToEnableable := enableable[DescendantEntityComponent]
           do:
               CastToEnableable.Disable()
   ```

4. Add a function named `IsPuzzleSolved` that decides whether the puzzle is in a solved state. This is done by iterating through all previously found descendant entities with a component that implements the `triggerable` interface, checking whether the associated entity is marked as a puzzle piece, and whether the entity's component that implements `triggerable` is in a solved state.

   ```verse
       # Decides whether puzzle is solved
       IsPuzzleSolved<private>()<decides><transacts>:void=
           for:
               TriggerableEntity : TriggerableEntities
               TriggerableEntityComponent : TriggerableEntity.GetComponents()
               CastToTriggerable := triggerable[TriggerableEntityComponent]
               CastToTriggerable.PuzzlePiece?
           do:
               CastToTriggerable.InSolvedState[]
   ```

5. Add a function named `HandlePuzzleSolved` to perform all necessary actions once it is determined that the puzzle is solved. This includes setting the `Solved` field on this class, disabling puzzle triggerables based on the class field `DisablePuzzleTriggerablesWhenSolved`, and sending the `puzzle_solved_event` down the Scene Graph hierarchy.

   ```verse
       # Handle all necessary actions once puzzle is known to be solved
       HandlePuzzleSolved<private>():void=
           set Solved = true
           if (DisablePuzzleTriggerablesWhenSolved?):
               DisableTriggerableComponents()
           Entity.SendDown(puzzle_solved_event{})
   ```

6. Next, add a function named `CheckPuzzleSolution`. This is an asynchronous wrapper function for determining if the puzzle is solved with `IsPuzzleSolved` and, if it is, also calls `HandlePuzzleSolved` to perform the necessary actions when the puzzle is solved.

   ```verse
       # Async wrapper for determining whether puzzle is solved
       CheckPuzzleSolved()<suspends>:void=
           Sleep(0.25)
           if (not Solved?, IsPuzzleSolved[]):
               HandlePuzzleSolved()
   ```

7. Add an override for the Scene Graph component class `OnReceive` function.

   ```verse
       # Handle triggered events sent through the Scene Graph hierarchy
       OnReceive<override>(SceneEvent:scene_event):logic=
           if (TriggeredEvent := triggered_event[SceneEvent], TriggeredEntity := TriggeredEvent.TriggeredEntity?):
               spawn{CheckPuzzleSolved()}
               true
           false
   ```

8. Add a call to `InitializeTriggerableDescendantEntities` to the component `OnBeginSimulation` function.

   ```verse
       # Runs when the component should start simulating in a running game.
       OnBeginSimulation<override>():void =
           # Run OnBeginSimulation from the parent class before
           # running this component's OnBeginSimulation logic
           (super:)OnBeginSimulation()
           InitializeTriggereableDescendantEntities()
   ```

## Next Steps

Next, create the Trigger Component and the Triggerable components that implement the Triggerable interface.

## Final Code for Puzzle.verse

```verse
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/SceneGraph }
using { Logging }

puzzle_solved_event<public> := class(scene_event){}

# Scene Graph component handling puzzle component triggered events and when the puzzle is solved.
puzzle_component := class<final_super>(component):

    # Is this puzzle component solved
    var<private> Solved<public>:logic = false

    # Map of puzzle pieces and whether they have been "solved"
    var<private> TriggerableEntities<private>:[]entity = array{}

    # Disable puzzle pieces triggering once puzzle is solved
    @editable
    DisablePuzzleTriggerablesWhenSolved<private>:logic = false

    # Initialize array of triggerable entities
    InitializeTriggereableDescendantEntities<private>()<transacts>:void=
        for:
            DescendantEntity : Entity.FindDescendantEntities(entity))
            DescendantEntityComponent : DescendantEntity.GetComponents()
            CastToTriggerable := triggerable[DescendantEntityComponent]
            CastToTriggerable.PuzzlePiece?
        do:
            set TriggerableEntities += array{DescendantEntity}

    # Decides whether puzzle is solved
    IsPuzzleSolved<private>()<decides><transacts>:void=
        for:
            TriggerableEntity : TriggerableEntities
            TriggerableEntityComponent : TriggerableEntity.GetComponents()
            CastToTriggerable := triggerable[TriggerableEntityComponent]
            CastToTriggerable.PuzzlePiece?
        do:
            CastToTriggerable.InSolvedState[]

    # Clean up or subsequent events after puzzle is solved
    HandlePuzzleSolved<private>():void=
        set Solved = true
        Log("Puzzle Solved!", LogPuzzleComponent, ?Level:=log_level.Normal)
        if (DisablePuzzleTriggerablesWhenSolved?):
            DisableTriggerableComponents()
        Log("Sending down solved event", LogPuzzleComponent, ?Level:=log_level.Normal)
        Entity.SendDown(puzzle_solved_event{})

    # Async wrapper for determining whether puzzle is solved
    CheckPuzzleSolved()<suspends>:void=
        Sleep(0.25)
        if (not Solved?, IsPuzzleSolved[]):
            HandlePuzzleSolved()

    # Disable puzzle pieces
    DisableTriggerableComponents<private>():void=
        for:
            DescendantEntity : Entity.FindDescendantEntities(entity)
            DescendantEntityComponent : DescendantEntity.GetComponents()
            CastToTriggerable := triggerable[DescendantEntityComponent]
            CastToTriggerable.PuzzlePiece?
            CastToEnableable := enableable[DescendantEntityComponent]
        do:
            CastToEnableable.Disable()

    # Handle triggered events sent up from child entities
    OnReceive<override>(SceneEvent:scene_event):logic=
        Log("Received scene event.", LogPuzzleComponent, ?Level:=log_level.Normal)
        if (TriggeredEvent := triggered_event[SceneEvent], TriggeredEntity := TriggeredEvent.TriggeredEntity?):
            spawn{CheckPuzzleSolved()}
            true
        false

    # Runs when the component should start simulating in a running game.
    OnBeginSimulation<override>():void =
        # Run OnBeginSimulation from the parent class before
        # running this component's OnBeginSimulation logic
        (super:)OnBeginSimulation()
        InitializeTriggereableDescendantEntities()
```

[![Trigger Component and Triggerable Child Classes](https://dev.epicgames.com/community/api/documentation/image/5a4a1239-b1b0-4070-9bec-ba18edcee333?resizing_type=fit&width=640&height=640)

Trigger Component and Triggerable Child Classes

Create a component that triggers triggerable Scene Graph entities.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-03-trigger-component-and-triggerable-child-classes-in-fortnite>)
