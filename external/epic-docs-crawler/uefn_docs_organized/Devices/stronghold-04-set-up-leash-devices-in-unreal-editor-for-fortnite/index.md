# 4. Set Up Leash Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/stronghold-04-set-up-leash-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:14:51.593469

---

This section will show you how to set up the leash devices that control the areas that the AI guards will patrol.

[![Leashes](https://dev.epicgames.com/community/api/documentation/image/f795d949-a4bd-449d-babc-0289a432ff55?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f795d949-a4bd-449d-babc-0289a432ff55?resizing_type=fit)

A **leash** is a custom location set in Verse to tell guards where to move. Use a leash to designate locations for guards to patrol in the stronghold.

Guards will only patrol if they have the patrol flag enabled. Otherwise, they will stand still until they see a threat.

In this tutorial, we will use a prop, the Verse device, as a dummy to easily move the center of the leashes.

[![Verse Explorer](https://dev.epicgames.com/community/api/documentation/image/473b38f3-0b6b-46de-a095-fa333b1518c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/473b38f3-0b6b-46de-a095-fa333b1518c5?resizing_type=fit)

To create a new Leash Position device, click the Verse header make sure the Verse Explorer is checked.

[![Add Verse File](https://dev.epicgames.com/community/api/documentation/image/189a1e21-09b8-4e12-9b0d-8d6a38440c76?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/189a1e21-09b8-4e12-9b0d-8d6a38440c76?resizing_type=fit)

Next, navigate to the **Verse Explorer** tab and right-click your project file, then select **Add new Verse file to project**.

[![Verse Script](https://dev.epicgames.com/community/api/documentation/image/5aff7a57-f7d3-4ad7-8c1b-458d271fd3a0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5aff7a57-f7d3-4ad7-8c1b-458d271fd3a0?resizing_type=fit)

Select Verse device and give it a name, then click **Create**.

Double-click the device Verse file to bring up the Verse script. Copy and paste the code below.

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
# Defines a leash volume that can be assigned to guards
stronghold_leash_position := class(creative_device):
    # Leash is applied by default to all guards spawned by those devices
    @editable
    GuardsSpawners:[]guard_spawner_device := array{}
    # Guards on those patrol paths can go outside the leash (only one device per path)
    @editable
    PatrolPaths:[]ai_patrol_path_device := array{}
    # Set the leash inner radius. This value must be in centimeters.
    # This defines the volume that must be reached when this leash is assigned to guards
    @editable
    LeashInnerRadius<private>:float = 2300.0
    # Set the leash outer radius. This value must be in centimeters
    # This defines the volume in which guards must stay in when this leash is assigned
    @editable
    LeashOuterRadius<private>:float = 2400.0
    # List of guards currently assigned to this leash
    var<private> Guards : []agent = array{}
    OnBegin<override>()<suspends>:void=
        for (GuardSpawner : GuardsSpawners):
            GuardSpawner.SpawnedEvent.Subscribe(ApplyLeashOnGuard)
        for (PatrolPath : PatrolPaths):
            PatrolPath.PatrolPathStartedEvent.Subscribe(PatrolPathStarted)
            PatrolPath.PatrolPathStoppedEvent.Subscribe(PatrolPathStopped)
    ApplyLeashOnGuard(Guard:agent):void=
        if (Leashable:=Guard.GetFortCharacter[].GetFortLeashable[]):
            Leashable.SetLeashPosition(GetTransform().Translation, LeashInnerRadius, LeashOuterRadius)
           set Guards += array{Guard}
    ClearLeashOnGuard(Guard:agent):void=
        if (Leashable:=Guard.GetFortCharacter[].GetFortLeashable[]):
            Leashable.ClearLeash()
       option {set Guards = Guards.RemoveFirstElement[Guard]}
    DisableLeashAndPatrolPaths():void=
        for (Guard : Guards):
            if (Leashable:=Guard.GetFortCharacter[].GetFortLeashable[]):
                Leashable.ClearLeash()
        for (PatrolPath : PatrolPaths):
            PatrolPath.Disable()
        set Guards = array{}
    PatrolPathStarted(Guard:agent):void=
        if:
            Guards.Find[Guard]
            Leashable:=Guard.GetFortCharacter[].GetFortLeashable[]
        then:
            Leashable.ClearLeash()
    PatrolPathStopped(Guard:agent):void=
        if:
            Guards.Find[Guard]
            Leashable:=Guard.GetFortCharacter[].GetFortLeashable[]
        then:
            Leashable.SetLeashPosition(GetTransform().Translation, LeashInnerRadius, LeashOuterRadius)
```

In the **Verse** tab, select **Build Verse Code** to compile the Verse script.

[![Leash Device](https://dev.epicgames.com/community/api/documentation/image/6ecda892-ace8-4168-a074-232e990e0dcb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ecda892-ace8-4168-a074-232e990e0dcb?resizing_type=fit)

From the Content Browser, find the Verse device in **All/"Project Name"/Creative Devices/**.

Place two Leash Position devices, one for the stronghold leash and one for the fallback leash. You can name them to easily differentiate between the two.

[![Leash Settings](https://dev.epicgames.com/community/api/documentation/image/c6c9368c-a2fe-432e-a4b5-74e5a7a53992?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c6c9368c-a2fe-432e-a4b5-74e5a7a53992?resizing_type=fit)

In the Leash Position properties, uncheck **Visible in Game** so these devices are hidden when playing.

Earlier in the Stronghold Game Manager, you already set the inner and outer radius for the leash.

## AI Patrol Path Setup

You can use the [**AI Patrol Path Node**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-ai-patrol-path-node-devices-in-fortnite-creative) devices to set up with the default patrolling behaviors for the Guard AIs.

[![AI Patrol Path](https://dev.epicgames.com/community/api/documentation/image/909335c6-7047-43ce-a7b5-a9d25b58ae17?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/909335c6-7047-43ce-a7b5-a9d25b58ae17?resizing_type=fit)

To make the AI Patrol Path Node device work as the initial patrolling behavior, set the Guard Spawner’s setting **Spawn on Patrol Path Group** to be the same value of the AI Patrol Path Node device’s setting **Patrol Path Group**.

The AI Patrol Path Node device can also be assigned or disabled at runtime through event binding or its associated Verse APIs.

[![Patrol Path](https://dev.epicgames.com/community/api/documentation/image/40d9abc8-0221-4960-bcc2-dc8d96aac315?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40d9abc8-0221-4960-bcc2-dc8d96aac315?resizing_type=fit)

[![Patrol Path](https://dev.epicgames.com/community/api/documentation/image/3a53d976-14ac-40ea-a5c3-00cb77c6c768?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a53d976-14ac-40ea-a5c3-00cb77c6c768?resizing_type=fit)

Like the above images, you will need to set the **Patrol Path Group** option to same number for both the Guard Spawner and the AI Patrol Path Node. Doing this will cause the spawned AIs to pick the patrol path to use.

## Debug AI Navmesh

[![Debug View](https://dev.epicgames.com/community/api/documentation/image/ddfaab6c-15f8-41cb-a9e4-b40c3129bf48?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ddfaab6c-15f8-41cb-a9e4-b40c3129bf48?resizing_type=fit)

You can turn on the navmesh debug view from the Island Settings and enable both Debug & Navigation options. This would help determine if AIs can navigate to certain locations or not.

## Next Section

[![5. Set Up Audio and Visual Effects](https://dev.epicgames.com/community/api/documentation/image/0a5eaa22-1301-4499-bacd-15c9c7cb4326?resizing_type=fit&width=640&height=640)

1. Set Up Audio and Visual Effects

Learn how to set up audio and visual effects to enhance gameplay.](<https://dev.epicgames.com/documentation/en-us/fortnite/stronghold-05-set-up-audio-and-visual-effects-in-unreal-editor-for-fortnite>)
