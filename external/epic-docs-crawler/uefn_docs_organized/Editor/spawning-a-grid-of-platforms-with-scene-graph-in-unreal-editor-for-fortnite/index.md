# Spawning a Grid of Platforms with Scene Graph

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/spawning-a-grid-of-platforms-with-scene-graph-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:43:04.442787

---

Generating a unique grid sequence of platforms where only a couple platforms in each row are valid to jump on is common for platforming game modes. This requires players to slow down and figure out the sequence.

This tutorial shows how to generate a grid of platforms where platforms on each row are randomly selected to have collision and light color to distinguish them while the rest don't.

## Creating the Platform Prefab

Follow these steps to create a platform prefab that you'll spawn from Verse:

1. Place a new entity and promote it to a prefab named **choose\_one\_platform\_prefab**. For instructions, see [Prefab and Prefab Instances](prefab-and-prefab-instances-in-unreal-editor-for-fortnite).
2. In the Prefab Editor, add the following components to the entity:

   - **transform\_component:** The transform component to position the platform.
   - **mesh\_component:** The mesh component to set the static mesh of the platform. This example uses the **SM\_block\_02** mesh from the Stylized Egyptian World Pack asset in the [Fab Marketplace](https://dev.epicgames.com/documentation/en-us/fortnite/import-from-fab-in-unreal-editor-for-fortnite).
   - **collision\_component:** The collision component for enabling and disabling collision on the platform.
   - **parent\_constraint\_component:** The parent constraint component for easily setting the transform relative to the parent entity when spawning this prefab in the world using Verse.

   [![](https://dev.epicgames.com/community/api/documentation/image/0a5ffce7-93af-4bb7-be98-6b22dd8aa60e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a5ffce7-93af-4bb7-be98-6b22dd8aa60e?resizing_type=fit)
3. Add a child entity and name it **Light**.
4. Add the following components to the child entity Light:

   - **transform\_component:** The transform component that positions the entity above the platform.
   - **point\_light\_component:** The point light component to add a light source that changes colors based on whether the platform has collision.
   - **parent\_constraint\_component:** The parent constraint component that constrains the transform of this entity relative to the parent entity.

   [![](https://dev.epicgames.com/community/api/documentation/image/4f01ebb8-645d-4e79-b343-979b0315344f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f01ebb8-645d-4e79-b343-979b0315344f?resizing_type=fit)
5. Save the prefab.

Your prefab now appears in the **Assets.digest.verse** file as a [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse) with the same name as your prefab, `choose_one_platform_prefab`.

## Spawning a Grid of Platforms

Follow these steps to spawn a grid made from the platform prefab:

1. Create a Verse component named **choose\_one\_component**. For steps on how to create a Verse component, see [Creating Your Own Verse Component](creating-your-own-verse-component-in-unreal-editor-for-fortnite)
2. Add the following editable properties:

   - An integer 2D vector `vector2i` field named `GridSize` to define how many platforms are in the grid. X is the number of rows and Y is the number of columns in the grid.
   - A floating point 2D vector `vector2` field named `PlatformSpacing` to specify spacing between the platforms across the rows and columns.

     ~~~(verse)
     GridSizeTip<localizes>:message = "Size of the grid, where the grid is X units wide by Y units deep."
     PlatformSpacingTip<localizes>:message = "The distance between each platform on the grid."

     choose\_one\_component<public> := class(component):

     # Size of the grid, where the grid is X units wide by Y units deep.
     @editable\_vector\_number(int):
     ToolTip := GridSizeTip
     MinComponentValue := option{0}
     GridSize:vector2i = vector2i{X := 3, Y := 10}

     # Distance between each platform on the grid.
     @editable\_vector\_number(float):
     ToolTip := PlatformSpacingTip
     MinComponentValue := option{0.0}
     PlatformSpacing:vector2 = vector2{X := 256.0, Y := 256.0}
     ~~~

3. In the `OnSimulate` function, iterate across the `GridSize` vector to know how many platforms to spawn. In the loop, create an instance of your prefab class and add it to the entity this Verse component is attached to, to spawn the prefab in the world.

   ~~~(verse)
   GridSizeTip<localizes>:message = "Size of the grid, where the grid is X units wide by Y units deep."
   PlatformSpacingTip<localizes>:message = "The distance between each platform on the grid."

   choose\_one\_component<public> := class(component):

   # Size of the grid, where the grid is X units wide by Y units deep.
   @editable\_vector\_number(int):
   ToolTip := GridSizeTip
   MinComponentValue := option{0}
   GridSize:vector2i = vector2i{X := 3, Y := 10}

   # Distance between each platform on the grid.
   @editable\_vector\_number(float):
   ToolTip := PlatformSpacingTip
   MinComponentValue := option{0.0}
   PlatformSpacing:vector2 = vector2{X := 256.0, Y := 256.0}

   OnSimulate<override>()<suspends>:void=
   # Spawn platforms to create the grid.
   for (Column := 0..GridSize.Y - 1):
   for (Row := 0..GridSize.X - 1):
   # Creating an instance of a prefab and adding it to an existing entity will spawn the prefab in the world.
   ChooseOnePlatform := choose\_one\_platform\_prefab{}
   Entity.AddEntities(array{ChooseOnePlatform})
   ~~~

4. If you ran the code now, all the platforms would spawn in the same location. Since the prefab has the transform component and the parent constraint component, you can set the **InitialRelativeTransform** property on its transform component to spawn the prefab at an offset relative to the location of the entity you add the prefab to. Without the parent constraint component on the entity you're spawning, you'd have to specify the location in the world space (and not relative to the root entity).

   ```verse
        GridSizeTip<localizes>:message = "Size of the grid, where the grid is X units wide by Y units deep."
        PlatformSpacingTip<localizes>:message = "The distance between each platform on the grid."

        choose_one_component<public> := class(component):

            # Size of the grid, where the grid is X units wide by Y units deep.
            @editable_vector_number(int):
                ToolTip := GridSizeTip
                MinComponentValue := option{0}
            GridSize:vector2i = vector2i{X := 3, Y := 10}

            # Distance between each platform on the grid.
            @editable_vector_number(float):
                ToolTip := PlatformSpacingTip
                MinComponentValue := option{0.0}
            PlatformSpacing:vector2 = vector2{X := 256.0, Y := 256.0}

            OnSimulate<override>()<suspends>:void=
                # Spawn platforms to create the grid.
                for (Column := 0..GridSize.Y - 1):
                    for (Row := 0..GridSize.X - 1):
                        # The prefab has a parent constraint component so set the InitialRelative Transform
                        # on the transform component to offset each platform relative to this entity.
                        # This means the platform prefabs will spawn same distance from each other
                        # but moving the root entity will change where the platforms originate.
                        RelativeTransform := transform:
                            Translation := vector3:
                                X := PlatformSpacing.X * Row
                                Y := PlatformSpacing.Y * Column
                                Z := 0.0
                            Rotation := IdentityRotation()
                            Scale := vector3:
                                X := 1.0
                                Y := 1.0
                                Z := 1.0

                        # Creating an instance of a prefab and adding it to an existing entity will spawn the prefab in the world.
                        ChooseOnePlatform := choose_one_platform_prefab{}

                        if:
                            set ChooseOnePlatform.GetComponents(transform_component)[0].InitialRelativeTransform = RelativeTransform
                        else:
                            Print("Unable to set the initial relative transform of the platform at ({Row}, {Column})")

                        Entity.AddEntities(array{ChooseOnePlatform})
   ```

5. Save and compile your code.

If you attach this Verse component to an entity and launch a session, a grid of platforms will appear at that entity's location.

[![](https://dev.epicgames.com/community/api/documentation/image/6b2630bd-12e2-4db5-a4e6-c9a5cd5de59b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b2630bd-12e2-4db5-a4e6-c9a5cd5de59b?resizing_type=fit)

## Randomly Selecting Valid Platforms

Now that you have a grid of platforms spawned in the world, you can add more functionality to them. The following steps show how to randomly select platforms to have collision in order to generate a unique and changing sequence of platforms that a player can jump across.

Follow these steps to randomly select valid platforms in the grid:

1. Add the following editable properties to the Verse component:

   - An integer variable named `MinCorrectPlatformsPerRow` to specify the minimum number of platforms that have collision.
   - An integer variable named `MaxCorrectPlatformsPerRow` to specify the maximum number of platforms that have collision.
   - A color variable named `ChosenColor` to set the color of the platform if collision is enabled.
   - A color variable named `NotChosenColor` to set the color of the platform if collision is not enabled.

     ```verse
                               using { /UnrealEngine.com/Temporary/SceneGraph }
                               using { /UnrealEngine.com/Temporary/SpatialMath }
                               using { /Verse.org }
                               using { /Verse.org/Colors }
                               using { /Verse.org/Native }
                               using { /Verse.org/Random }
                               using { /Verse.org/Simulation }

                               GridSizeTip<localizes>:message = "Size of the grid, where the grid is X units wide by Y units deep."
                               PlatformSpacingTip<localizes>:message = "The distance between each platform on the grid."
                               MinCorrectPlatformsTip<localizes>:message = "The min number of platforms with collision to generate per row."
                               MaxCorrectPlatformsTip<localizes>:message = "The max number of platforms with collision to generate per row."

                               # This component spawns a grid of platforms using the choose_one_platform_prefab asset.
                               # The grid originates at the transform of the entity this component is attached to.
                               # The number of platforms and spacing between platforms in the grid is set in the editable properties
                               # For each row in the grid, some of the platforms are randomly chosen to have collision while the others don't.
                               # The platforms with collision will have the Chosen color for their light component.
                               # The platforms without collision will have the NotChosen color for their light component to visually distinguish them.
                               choose_one_component<public> := class(component):

                                   # Size of the grid, where the grid is X units wide by Y units deep.
                                   @editable_vector_number(int):
                                       ToolTip := GridSizeTip
                                       MinComponentValue := option{0}
                                   GridSize:vector2i = vector2i{X := 3, Y := 10}

                                   # Distance between each platform on the grid.
                                   @editable_vector_number(float):
                                       ToolTip := PlatformSpacingTip
                                       MinComponentValue := option{0.0}
                                   PlatformSpacing:vector2 = vector2{X := 256.0, Y := 256.0}

                                   # Min number of platforms that have collision.
                                   @editable_number(int):
                                       ToolTip := MinCorrectPlatformsTip
                                       MinValue := option{1}
                                       MaxValue := option{GridSize.X}
                                   MinCorrectPlatformsPerRow:int = 1

                                   # Max number of platforms that have collision.
                                   @editable_number(int):
                                       ToolTip := MaxCorrectPlatformsTip
                                       MinValue := option{1}
                                       MaxValue := option{GridSize.X}
                                   MaxCorrectPlatformsPerRow:int = 2

                                   # Color of the platform when collision is enabled.
                                   @editable
                                   ChosenColor:color = NamedColors.DarkOrange

                                   # Color of the platform when collision is not enabled.
                                   @editable
                                   NotChosenColor:color = NamedColors.Blue
     ```

2. The result of a `for` expression is an array of each iteration. Store all the platforms spawned for a row in an array and pass this array to a function for randomly setting the platforms named `RandomizeCollidablePlatformsPerRow()`.

   ```verse
        OnSimulate<override>()<suspends>:void=
            # For each row, spawn multiple platforms and pick a number of them to have collision while the others don't.
            # The platforms with collision will have the Chosen color for their light component.
            # The platforms without collision will have the NotChosen color for their light component.
            for (Row := 0..GridSize.Y - 1):
                EntitiesInRow := for (Column := 0..GridSize.X - 1):
                    # The prefab has a parent constraint component so set the InitialRelative Transform
                    # on the transform component to offset each platform relative to this entity.
                    # This means the platform prefabs will spawn same distance from each other
                    # but moving the root entity will change where the platforms originate.
                    RelativeTransform := transform:
                        Translation := vector3:
                            X := PlatformSpacing.X * Column
                            Y := PlatformSpacing.Y * Row
                            Z := 0.0
                        Rotation := IdentityRotation()
                        Scale := vector3:
                            X := 1.0
                            Y := 1.0
                            Z := 1.0

                    # Creating an instance of a prefab and adding it to an existing entity will spawn the prefab in the world.
                    ChooseOnePlatform := choose_one_platform_prefab{}

                    if:
                        set ChooseOnePlatform.GetComponents(transform_component)[0].InitialRelativeTransform = RelativeTransform
                    else:
                        Print("Unable to set the initial relative transform of the platform at ({Row}, {Column})")

                    Entity.AddEntities(array{ChooseOnePlatform})
                    ChooseOnePlatform

                # Since the row of platforms are spawned, select which ones have collision.
                RandomizeCollidablePlatformsPerRow(EntitiesInRow)
   ```

3. Create a function named `RandomizeCollidablePlatformsPerRow` that should randomly select entities to have collision, and have it disable collision on all of the entities. Since the point light component is on the child entity of the prefab, you can use `FindComponents` to search among the entity's children for the point light to change its color.

   ```verse
        # Randomly choose platforms to have collision in the row.
        RandomizeCollidablePlatformsPerRow(Entities:[]entity):void=
            # Disable all the entities before choosing which ones to enable.
                # It disables an entity by disabling the collision on the entity,
                # and finding a point light in its child entities to change its color.
                for:
                    EntityPlatform : Entities
                    Collision := EntityPlatform.GetComponents(collision_component)[0]
                    Light := EntityPlatform.FindComponents(point_light_component)[0]
                do:
                    Collision.Disable()
                    Light.SetColor(NotChosenColor)
   ```

4. Create an extension method for arrays named `ChooseOne` to choose a random element from the array. The result is a tuple containing both the chosen element and an array with all the other elements that are not selected.

   ```verse
        # An extension method for an array to get a randomly selected element from the array.
        (Input:[]t where t:subtype(comparable)).ChooseOne()<decides><transacts>:tuple(t, []t)=
            ChosenElement := Input[GetRandomInt(0, Input.Length - 1)]
            NotChosenElements := Input.RemoveFirstElement[ChosenElement]
            (ChosenElement, NotChosenElements)
   ```

5. Call `ChooseOne` from `RandomizeCollidablePlatformsPerRow` to select an entity to have collision and change its color.

   ```verse
        # Randomly choose platforms to have collision in the row.
        RandomizeCollidablePlatformsPerRow(Entities:[]entity):void=
            # Disable all the entities before choosing which ones to enable.
            # It disables an entity by disabling the collision on the entity,
            # and finding a point light in its child entities to change its color.
            for:
                EntityPlatform : Entities
                Collision := EntityPlatform.GetComponents(collision_component)[0]
                Light := EntityPlatform.FindComponents(point_light_component)[0]
            do:
                Collision.Disable()
                Light.SetColor(NotChosenColor)
     
            # Enable an entity by enabling the collision on the entity,
            # and finding a point light in its child entities to change its color.
            if:
                ChooseOneResult := RemainingEntities.ChooseOne[]
                ChosenEntity := ChooseOneResult(0)
                Collision := ChosenEntity.GetComponents(collision_component)[0]
                Light := ChosenEntity.FindComponents(point_light_component)[0]
            then:
                Collision.Enable()
                Light.SetColor(ChosenColor)
   ```

6. Update `RandomizeCollidablePlatformsPerRow` to choose multiple entities to have collision based on the editable properties. First, get a random value between the min and max number of correct platforms per row and choose an entity as many times, then remove the entity that was chosen from the list of next candidates to choose from.

   ```verse
        # Randomly choose platforms to have collision in the row.
        RandomizeCollidablePlatformsPerRow(Entities:[]entity):void=
            # Disable all the entities before choosing which ones to enable.
            # It disables an entity by disabling the collision on the entity,
            # and finding a point light in its child entities to change its color.
            for:
                EntityPlatform : Entities
                Collision := EntityPlatform.GetComponents(collision_component)[0]
                Light := EntityPlatform.FindComponents(point_light_component)[0]
            do:
                Collision.Disable()
                Light.SetColor(NotChosenColor)
     
            # Enable a random number of entities between min and max correct platforms per row.
            # After choosing an entity to enable, remove it from the list so it's not selected again.
            # It enables an entity by enabling the collision on the entity,
            # and finding a point light in its child entities to change its color.
            ChosenAmount := GetRandomInt(MinCorrectPlatformsPerRow, MaxCorrectPlatformsPerRow)
            var RemainingEntities:[]entity = Entities
            for:
                CurrentChosenCount := 0..ChosenAmount - 1
                ChooseOneResult := RemainingEntities.ChooseOne[]
                ChosenEntity := ChooseOneResult(0)
                Collision := ChosenEntity.GetComponents(collision_component)[0]
                Light := ChosenEntity.FindComponents(point_light_component)[0]
            do:
                set RemainingEntities = ChooseOneResult(1)
                Collision.Enable()
                Light.SetColor(ChosenColor)
   ```

7. Save and compile your code.

If you launch a session now, a grid of platforms are spawned in the world with a unique sequence of platforms that have collision and the chosen color.

[![](https://dev.epicgames.com/community/api/documentation/image/31d030e5-3dae-4a81-b3ca-ed47d90dc661?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31d030e5-3dae-4a81-b3ca-ed47d90dc661?resizing_type=fit)

## Complete Script

```verse
using { /UnrealEngine.com/Temporary/SceneGraph }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org }
using { /Verse.org/Colors }
using { /Verse.org/Native }
using { /Verse.org/Random }
using { /Verse.org/Simulation }

GridSizeTip<localizes>:message = "Size of the grid, where the grid is X units wide by Y units deep."
PlatformSpacingTip<localizes>:message = "The distance between each platform on the grid."
MinCorrectPlatformsTip<localizes>:message = "The min number of platforms with collision to generate per row."
MaxCorrectPlatformsTip<localizes>:message = "The max number of platforms with collision to generate per row."

# This component spawns a grid of platforms using the choose_one_platform_prefab asset.
# The grid originates at the transform of the entity this component is attached to.
# The number of platforms and spacing between platforms in the grid is set in the editable properties
# For each row in the grid, some of the platforms are randomly chosen to have collision while the others don't.
# The platforms with collision will have the Chosen color for their light component.
# The platforms without collision will have the NotChosen color for their light component to visually distinguish them.
choose_one_component<public> := class(component):

    # Size of the grid, where the grid is X units wide by Y units deep.
    @editable_vector_number(int):
        ToolTip := GridSizeTip
        MinComponentValue := option{0}
    GridSize:vector2i = vector2i{X := 3, Y := 10}

    # Distance between each platform on the grid.
    @editable_vector_number(float):
        ToolTip := PlatformSpacingTip
        MinComponentValue := option{0.0}
    PlatformSpacing:vector2 = vector2{X := 256.0, Y := 256.0}

    # Min number of platforms that have collision.
    @editable_number(int):
        ToolTip := MinCorrectPlatformsTip
        MinValue := option{1}
        MaxValue := option{GridSize.X}
    MinCorrectPlatformsPerRow:int = 1

    # Max number of platforms that have collision.
    @editable_number(int):
        ToolTip := MaxCorrectPlatformsTip
        MinValue := option{1}
        MaxValue := option{GridSize.X}
    MaxCorrectPlatformsPerRow:int = 2

    # Color of the platform when collision is enabled.
    @editable
    ChosenColor:color = NamedColors.DarkOrange

    # Color of the platform when collision is not enabled.
    @editable
    NotChosenColor:color = NamedColors.Blue

    OnSimulate<override>()<suspends>:void=
        # For each row, spawn multiple platforms and pick a number of them to have collision while the others don't.
        # The platforms with collision will have the Chosen color for their light component.
        # The platforms without collision will have the notchosen color for their light component.
        for (Row := 0..GridSize.Y - 1):
            EntitiesInRow := for (Column := 0..GridSize.X - 1):
                # The prefab has a parent constraint component so set the InitialRelative Transform
                # on the transform component to offset each platform relative to this entity.
                # This means the platform prefabs will spawn same distance from each other
                # but moving the root entity will change where the platforms originate.
                RelativeTransform := transform:
                    Translation := vector3:
                        X := PlatformSpacing.X * Column
                        Y := PlatformSpacing.Y * Row
                        Z := 0.0
                    Rotation := IdentityRotation()
                    Scale := vector3:
                        X := 1.0
                        Y := 1.0
                        Z := 1.0

                # Creating an instance of a prefab and adding it to an existing entity will spawn the prefab in the world.
                ChooseOnePlatform := choose_one_platform_prefab{}

                if:
                    set ChooseOnePlatform.GetComponents(transform_component)[0].InitialRelativeTransform = RelativeTransform
                else:
                    Print("Unable to set the initial relative transform of the platform at ({Row}, {Column})")

                Entity.AddEntities(array{ChooseOnePlatform})
                ChooseOnePlatform

            # Since the row of platforms are spawned, select which ones have collision.
            RandomizeCollidablePlatformsPerRow(EntitiesInRow)

    # Randomly choose platforms to have collision in the row.
    RandomizeCollidablePlatformsPerRow(Entities:[]entity):void=
        # Disable all the entities before choosing which ones to enable.
        # It disables an entity by disabling the collision on the entity,
        # and finding a point light in its child entities to change its color.
        for:
            EntityPlatform : Entities
            Collision := EntityPlatform.GetComponents(collision_component)[0]
            Light := EntityPlatform.FindComponents(point_light_component)[0]
        do:
            Collision.Disable()
            Light.SetColor(NotChosenColor)

        # Enable a random number of entities between min and max correct platforms per row.
        # After choosing an entity to enable, remove it from the list so it's not selected again.
        # It enables an entity by enabling the collision on the entity,
        # and finding a point light in its child entities to change its color.
        ChosenAmount := GetRandomInt(MinCorrectPlatformsPerRow, MaxCorrectPlatformsPerRow)
        var RemainingEntities:[]entity = Entities
        for:
            CurrentChosenCount := 0..ChosenAmount - 1
            ChooseOneResult := RemainingEntities.ChooseOne[]
            ChosenEntity := ChooseOneResult(0)
            Collision := ChosenEntity.GetComponents(collision_component)[0]
            Light := ChosenEntity.FindComponents(point_light_component)[0]
        do:
            set RemainingEntities = ChooseOneResult(1)
            Collision.Enable()
            Light.SetColor(ChosenColor)

# An extension method for an array to get a randomly selected element from the array.
(Input:[]t where t:subtype(comparable)).ChooseOne()<decides><transacts>:tuple(t, []t)=
    ChosenElement := Input[GetRandomInt(0, Input.Length - 1)]
    NotChosenElements := Input.RemoveFirstElement[ChosenElement]
    (ChosenElement, NotChosenElements)
```
