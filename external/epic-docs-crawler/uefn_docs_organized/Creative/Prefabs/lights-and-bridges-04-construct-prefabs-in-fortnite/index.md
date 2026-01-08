# Construct Prefabs

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-04-construct-prefabs-in-fortnite>
> **爬取时间**: 2025-12-27T02:38:40.037380

---

[Prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prefab) are [hierarchies](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#hierarchical) of [entities](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#entity) and [components](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#component) you can use to construct reusable [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay) objects in UEFN.

This page walks you through the creation of five different prefabs:

- **Prefab\_TriggerableMesh**
- **Prefab\_TriggerableLight**
- **Prefab\_TriggerableMovingMesh**
- **Prefab\_PuzzleManager**
- **Prefab\_Trigger**

## Triggerable Mesh Prefab

The **Prefab\_TriggerableMesh** is a prefab with the following hierarchy:

- Entity: `transform_component`, `mesh_component`, `triggerable_mesh_component`

The `transform_component` is included on all entities by default. This is because all entities physically exist in the [level](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level) and, in order to exist in the level, they must have a [transform](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#transform) that enables them to be located. To create the **Prefab\_TriggerableMesh**, follow these steps:

1. Navigate to the **Quickly Add to Project** button and place an [actor](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#actor) by dragging **Entities > entity** into the level.

   [![Add an entity to the scene from the Place Actors dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/c30affb6-cb76-4e49-8438-84f38b9f62b1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c30affb6-cb76-4e49-8438-84f38b9f62b1?resizing_type=fit)

   Click to enlarge image.
2. Rename the entity by right-clicking the entity in the [Outliner](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#outliner-panel) and selecting **Edit > Rename** then changing the name to **Prefab\_TriggerableMesh.**

   [![Right click on an entity in the Outliner to rename it from the context menu.](https://dev.epicgames.com/community/api/documentation/image/12b9df87-ff81-455b-a01d-56b04daf6364?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12b9df87-ff81-455b-a01d-56b04daf6364?resizing_type=fit)

   Click to enlarge image.
3. Add the `mesh_component`.undefined

   - Navigate to your **Prefab\_TriggerableMesh** entity then click the **+Component** button in the **[Details Panel](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#details-panel)** and search for `mesh_component`.

     [![Add the mesh_component to the Prefab_TriggerableMesh entity.](https://dev.epicgames.com/community/api/documentation/image/cfd0eeff-252e-4070-9c52-7e8bd3c8184a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cfd0eeff-252e-4070-9c52-7e8bd3c8184a?resizing_type=fit)

     Click to enlarge image.
   - Once you search for `mesh_component`, you must choose a specific [mesh](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#mesh). In this case, choose the provided plane basic shape mesh.

     [![Select a Plane from the mesh dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/c357f718-7aeb-4585-bebd-b56a350f9ed8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c357f718-7aeb-4585-bebd-b56a350f9ed8?resizing_type=fit)

     Click to enlarge image.
4. Add the `triggerable_mesh_component`. Navigate to your **Prefab\_TriggerableMesh** entity then click the **+Component** button in the **Details** panel and search for `triggerable_mesh_component`.

   [![Add the triggerable_mesh_component to the Prefab_TriggerableMesh entity.](https://dev.epicgames.com/community/api/documentation/image/732fdadc-f655-440d-ba5c-d9d744a6e2bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/732fdadc-f655-440d-ba5c-d9d744a6e2bb?resizing_type=fit)

   Click to enlarge iamge.
5. To make this a prefab, right-click on the **Prefab\_TriggerableMesh** and select **Save As Prefab…**

   [![Save the Entity as a Prefab from the right-click context menu in the Outliner.](https://dev.epicgames.com/community/api/documentation/image/87f76bb3-84a4-406a-bbae-197890a11bad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87f76bb3-84a4-406a-bbae-197890a11bad?resizing_type=fit)

   Click to enlarge image.
6. A **Create New Prefab** dialog pops up where you can change the name of your new class or choose the content path for your class. Once you are satisfied with your choices, choose **Create Entity Class**. You can now choose this prefab in the **[Content Browser](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#content-browser)** and place it in the level to use and configure each instance as you want.

   [![Name your new entity class from the pop-up dialog.](https://dev.epicgames.com/community/api/documentation/image/ae067a3c-93d1-447c-924a-3a83ac37da81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae067a3c-93d1-447c-924a-3a83ac37da81?resizing_type=fit)

   Click to enlarge image.

You'll repeat a similar process for the other prefabs you create in this project.

## Triggerable Light PrefabThe Prefab\_TriggerableLight is a prefab with the following hierarchy

- Entity: `transform_component`, `triggerable_light_component`

  - Entity: `transform_component`, `mesh_component`
  - Entity: `transform_component`, `mesh_component, light_component`

To create the **Prefab\_TriggerableLight**, follow these steps:

1. Navigate to the **Quickly Add to Project** button and place an actor by dragging **Entities** > **entity** into the level.

   [![Add an entity from the Place Actors dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/f37925f1-e74c-4156-a955-4032d351ab2f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f37925f1-e74c-4156-a955-4032d351ab2f?resizing_type=fit)

   Click to enlarge image.
2. Rename the entity by right-clicking the entity in the **Outliner** and selecting **Edit** > **Rename** then change the name to **Prefab\_TriggerableMesh**.

   [![Rename your entity using the Outliner's right-click context menu.](https://dev.epicgames.com/community/api/documentation/image/8d83f41e-8474-48f9-ade1-199740b47c78?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8d83f41e-8474-48f9-ade1-199740b47c78?resizing_type=fit)

   Click to enlarge image.
3. Add the `triggerable_light_component`. Navigate to your **Prefab\_TriggerableLight** entity clicking the **+ Component** button and searching for `triggerable_light_component`.

   [![Add the triggerable_light_component to the entity.](https://dev.epicgames.com/community/api/documentation/image/e0347fdf-0747-4d22-b0a8-c9546d2ac73f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0347fdf-0747-4d22-b0a8-c9546d2ac73f?resizing_type=fit)

   Click to enlarge image.
4. Navigate to the **Prefab\_TriggerableLight** entity in the **Outliner**. Right-click on the entity and choose **Add Entity…** > **entity**. Rename this entity to **LightOff**.

   [![Select the Prefab_TriggerableLight entity then right-click and select Add Entity from the dropdown context menu.](https://dev.epicgames.com/community/api/documentation/image/7be72054-0fde-45a9-8efe-cf69d824d08f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7be72054-0fde-45a9-8efe-cf69d824d08f?resizing_type=fit)

   Click to enlarge image.
5. Customize the **LightOff** entity.

   1. Choose the **LightOff** entity in the **Outliner**. Navigate to the **Details Panel** and click the **+Component** button to add a **[mesh\_component](https://dev.epicgames.com/documentation/en-us/fortnite/mesh-component-in-unreal-editor-for-fortnite)**, then choose the **sphere** mesh.

      [![Add a mesh component to the new entity.](https://dev.epicgames.com/community/api/documentation/image/0072470d-00b9-48af-b2ab-639411752431?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0072470d-00b9-48af-b2ab-639411752431?resizing_type=fit)

      Click to enlarge image.
6. Navigate to the **Prefab\_TriggerableLight** entity in the **Outliner**. Right-click the entity and choose **Add Entity…** > **entity**. Rename this entity to **LightOn**.
7. Customize the **LightOn** entity.

   1. Choose the LightOn entity in the Outliner. Navigate to the Details panel and click the **+Component** button to add a **mesh\_component**, then choose **sphere** mesh. Change the following editable fields on the mesh\_component to:

      - Uncheck the **Enabled**checkbox.

      [![](https://dev.epicgames.com/community/api/documentation/image/d6233d5d-3275-4296-8f0e-39a2d1447041?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6233d5d-3275-4296-8f0e-39a2d1447041?resizing_type=fit)

      Click to enlarge image.
   2. Choose the **LightOn** entity in the **Outliner**. Navigate to the **Details** panel and click the **+ Component** button to add a **sphere\_light\_component**. Change the following editable fields on the **sphere\_light\_component** to:

      - Uncheck the **Enabled** checkbox.
      - **Intensity**: 10.0
      - **AttenuationRadius**: 1000.0
      - **SourceRadius**: 50.0

      [![](https://dev.epicgames.com/community/api/documentation/image/e146d0e4-1e58-49e4-8bdd-b9c482e4f041?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e146d0e4-1e58-49e4-8bdd-b9c482e4f041?resizing_type=fit)

      Click to enlarge iamge.
8. To make this a prefab, right-click the **Prefab\_TriggerableLight** and select **Save As Prefab…**

   [![Select the Prefab_TriggerableLight entity, then right-click and select Save as Prefab.](https://dev.epicgames.com/community/api/documentation/image/f506998d-5479-4867-b530-eb41a2a1d526?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f506998d-5479-4867-b530-eb41a2a1d526?resizing_type=fit)

   Click to enlarge image.
9. A **Create New Prefab** dialog pops up where you can change the name of your new class or choose the content path for your class. Once you are satisfied, choose **Create Entity Class**. You can now select this prefab in the **Content Browser,** place it in the level to use, and configure each instance as you want.

   [![Turn the prefab into an Entity Class.](https://dev.epicgames.com/community/api/documentation/image/c84533ce-c694-4947-85fe-665136ba270b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c84533ce-c694-4947-85fe-665136ba270b?resizing_type=fit)

   Click to enlarge image.

## Triggerable Moving Mesh PrefabThe Prefab\_TriggerableMovingMesh is a prefab with the following hierarchy

- Entity: `transform_component`, `triggerable_movement_component`, `mesh_component`

  - Entity: `transform_component`
  - Entity: `transform_component`

To create the **Prefab\_TriggerableMovingMesh**, follow these steps:

1. Navigate to the **Quickly Add to Project** button and place an actor by dragging **Entities** > **entity** into the level.

   [![Open the Place Actors dropdown menu and select Entity > entity.](https://dev.epicgames.com/community/api/documentation/image/09137661-5d23-44c6-8d17-f5ddf3e44b28?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09137661-5d23-44c6-8d17-f5ddf3e44b28?resizing_type=fit)

   Click to enlarge image.
2. Rename the entity by right-clicking the entity in the **Outliner** and selecting **Edit** > **Rename,** then change the name to **Prefab\_TriggerableMovingMesh**.

   [![Select the entity from the Outliner and use the right-click menu to rename the entity.](https://dev.epicgames.com/community/api/documentation/image/738c1499-dd09-482a-b572-412e67d30849?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/738c1499-dd09-482a-b572-412e67d30849?resizing_type=fit)

   Click to enlarge image.
3. Add the `triggerable_movement_component`. Navigate to your **Prefab\_TriggerableMovingMesh** entity clicking the **+Component** button and searching for `triggerable_movement_component`.

   [![Add the triggerable_movement_component to the Prefab_TriggerableMovingMesh.](https://dev.epicgames.com/community/api/documentation/image/4766c98e-475d-443b-a1f2-f420d0842ea4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4766c98e-475d-443b-a1f2-f420d0842ea4?resizing_type=fit)

   Click to enlarge image.
4. Add the `keyframed_movement_component`. Navigate to your **Prefab\_TriggerableMovingMesh** entity by clicking the **+Component** button and searching for `keyframed_movement_component`.

   [![Add the Keyframed_movement_component to the Prefab_TriggerableMovingMesh.](https://dev.epicgames.com/community/api/documentation/image/e1f57610-8cef-4b14-8307-aa5288d1a360?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e1f57610-8cef-4b14-8307-aa5288d1a360?resizing_type=fit)

   Click to enlarge image.
5. Add the `mesh_component`.

   - Navigate to your **Prefab\_TriggerableMovingMesh** entity by clicking the **+Component** button and searching for `mesh_component`.
   - Once you search for `mesh_component`, you must choose a specific mesh. In this case, choose the provided **plane** basic shape mesh.

   [![Add a plane mesh to the Prefab_TriggerableMovingMesh entity.](https://dev.epicgames.com/community/api/documentation/image/35c72f68-9316-42f3-ac4c-07d3b3461368?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35c72f68-9316-42f3-ac4c-07d3b3461368?resizing_type=fit)

   Click to enlarge image.
6. Navigate to the **Prefab\_TriggerableMovingMesh** entity in the **Outliner**. Right-click the entity and choose **Add Entity…** > **entity**. Rename this entity to **TransformOne**.

   [![Rename the new entity to Trasnform 1.](https://dev.epicgames.com/community/api/documentation/image/ff698817-3d5a-4eee-b81a-d218cd8381ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff698817-3d5a-4eee-b81a-d218cd8381ff?resizing_type=fit)

   Click to enlarge image.
7. Navigate to the **Prefab\_TriggerableMovingMesh** entity in the **Outliner**. Right-click the entity and choose **Add Entity…** > **entity**. Rename this entity to **TransformTwo**.

   [![Rename the new entity to Transform 2.](https://dev.epicgames.com/community/api/documentation/image/451d4432-0676-4e9a-8e1c-e9bc7b8d6e27?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/451d4432-0676-4e9a-8e1c-e9bc7b8d6e27?resizing_type=fit)

   Click to enlarge image.
8. Make this a prefab by right-clicking the **Prefab\_TriggerableMovingMesh** and selecting **Save As Prefab…**

   [![Save entities as a prefab.](https://dev.epicgames.com/community/api/documentation/image/36f20de5-09c9-4f14-8f72-e8c956b0ef5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36f20de5-09c9-4f14-8f72-e8c956b0ef5d?resizing_type=fit)

   Click to enlarge image.
9. A **Create New Prefab** dialog pops up where you can change the name of your new class or choose the content path for your class. Once you are satisfied , choose **Create entity Class**. You can now choose this prefab in the **Content Browser,** place it in the level to use, and configure each instance as you wish.

   [![Turn prefab into an entity class.](https://dev.epicgames.com/community/api/documentation/image/84688a11-5072-4b94-aeba-db880aed5307?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84688a11-5072-4b94-aeba-db880aed5307?resizing_type=fit)

   Click to enlarge image.

## Puzzle Manager Prefab

The **Prefab\_PuzzleManager** is a prefab with the following hierarchy:

- Entity: `transform_component`, `puzzle_component`

To create the **Prefab\_PuzzleManager**, follow these steps:

1. Navigate to the **Quickly Add to Project** button and place an actor by dragging **Entities** > **entity** into the level.

   [![Open the Place Actors dropdown menu and select Entity > entity.](https://dev.epicgames.com/community/api/documentation/image/7e95ebcb-6aed-49f3-ab31-bd4908d3b48c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e95ebcb-6aed-49f3-ab31-bd4908d3b48c?resizing_type=fit)

   Click to enlarge image.
2. Rename the entity by right-clicking the entity in the Outliner, selecting **Edit > Rename,** and changing the name to Prefab\_PuzzleManager.

   [![Rename the entity.](https://dev.epicgames.com/community/api/documentation/image/f11a70b1-3121-40c4-887c-907573bcd32e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f11a70b1-3121-40c4-887c-907573bcd32e?resizing_type=fit)

   Click to enlarge image.
3. Add the `puzzle_component`. Navigate to your Prefab\_PuzzleManager entity clicking the **+Component** button and searching for `puzzle_component`.

   [![Add the puzzle_component to the entity.](https://dev.epicgames.com/community/api/documentation/image/dd7d8fc6-be17-4236-bf76-22280697f1a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd7d8fc6-be17-4236-bf76-22280697f1a8?resizing_type=fit)

   Click to enlarge image.
4. Make this a prefab by right-clicking the Prefab\_PuzzleManager and selecting **Save As Prefab… .**

   [![Save the entity as a prefab.](https://dev.epicgames.com/community/api/documentation/image/a7efd055-bb3a-47e8-9731-04352b6dc59d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7efd055-bb3a-47e8-9731-04352b6dc59d?resizing_type=fit)

   Click to enlarge image.
5. A Create New Prefab dialog pops up where you can change the name of your new class or choose the content path for your class. Once you are satisfied, choose **Create Entity Class**. You can now choose this prefab in the Content Browser, place it in the level to use, and configure each instance as you wish.

   [![Turn the prefab into an entity class.](https://dev.epicgames.com/community/api/documentation/image/09e44968-b3c3-4c53-8186-13bae6740e36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09e44968-b3c3-4c53-8186-13bae6740e36?resizing_type=fit)

   Click to enlarge image.

## Trigger Prefab

The **Prefab\_Trigger** is a prefab with the following hierarchy:

- Entity: `transform_component`, `trigger_component`, `mesh_component`

To create the **Prefab\_Trigger**, follow these steps:

1. Navigate to the **Quickly Add to Project** button and place an actor by dragging **Entities** > **entity** into the level.

   [![Select Entity form the Place Actors dropdown mene.](https://dev.epicgames.com/community/api/documentation/image/95c8f9ff-f279-447c-8389-ed36e22aeb58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95c8f9ff-f279-447c-8389-ed36e22aeb58?resizing_type=fit)

   Click to enlarge image.
2. Rename the entity by right-clicking the entity in the Outliner, selecting **Edit > Rename,** and changing the name to **Prefab\_Trigger**.

   [![Rename the entity to Prefab_Trigger.](https://dev.epicgames.com/community/api/documentation/image/708c7e23-1611-43ea-b667-d2614917268f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/708c7e23-1611-43ea-b667-d2614917268f?resizing_type=fit)

   Click to enlarge image.
3. Add the `trigger_component`. Navigate to your **Prefab\_Trigger**entity by clicking the **+Component**button and searching for `trigger_component`.

   [![Add the trigger_component to the entity.](https://dev.epicgames.com/community/api/documentation/image/89fb36ce-67f3-44a3-bd0c-b439e0a777b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/89fb36ce-67f3-44a3-bd0c-b439e0a777b7?resizing_type=fit)

   Click to enlarge image.
4. Add the `mesh_component`.

   - Navigate to your **Prefab\_Trigger** entity by clicking the **+ Component** button and searching for `mesh_component`.
   - Once you search for `mesh_component`, you must choose a specific mesh. In this case, choose the provided plane basic shape mesh.

   [![Add a mesh_component to the entity and select a plane mesh.](https://dev.epicgames.com/community/api/documentation/image/12b2860a-5935-4d49-870a-91da3583b388?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12b2860a-5935-4d49-870a-91da3583b388?resizing_type=fit)

   click to enlarge image.
5. Make this a prefab by right-clicking the **Prefab\_Trigger** and selecting **Save As Prefab… .**

   [![Save the entity as a prefab.](https://dev.epicgames.com/community/api/documentation/image/432303a3-44f3-46fe-b78e-8bf32ac0c861?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/432303a3-44f3-46fe-b78e-8bf32ac0c861?resizing_type=fit)

   Click to enlarge image.
6. A Create New Prefab dialog pops up where you can change the name of your new class or choose the content path for your class. Once you are satisfied, choose **Create Entity Class**. You can now choose this prefab in the Content Browser, place it in the level to use, and configure each instance as you want.

   [![Turn the prefab into an entity class.](https://dev.epicgames.com/community/api/documentation/image/32e4ec08-4407-48ee-a7ff-ece9d0965780?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32e4ec08-4407-48ee-a7ff-ece9d0965780?resizing_type=fit)

   Click to enlarge image.

## Next Steps

Now that all prefabs have been constructed from Scene Graph entities and components, all these pieces can be put together to create a puzzle in UEFN.

[![Create a Puzzle with Prefabs](https://dev.epicgames.com/community/api/documentation/image/e63ed803-be82-4bdf-836a-a024b334a2ee?resizing_type=fit&width=640&height=640)

Create a Puzzle with Prefabs

Use prefabs to construct a puzzle experience.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-05-create-a-puzzle-with-prefabs-in-fortnite>)
