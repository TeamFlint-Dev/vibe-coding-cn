# 2. Defining the Pickup and Delivery Zones

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-2-defining-the-pickup-and-delivery-zones-for-time-trial-in-verse>
> **爬取时间**: 2025-12-27T00:19:45.004229

---

A **zone** is an area of the map (represented by a device) where the player can pick up items or deliver items. By completing this step in the [Time Trial: Pizza Pursuit](https://dev.epicgames.com/documentation/en-us/fortnite/time-trial-pizza-pursuit-in-verse) tutorial, you’ll learn how to create these pickup and delivery zones and activate / deactivate them for the player.

## Using Abstraction for Creating a Zone Class

**Abstraction** is a programming principle where unnecessary details are hidden from a user where the user doesn't need to understand the hidden complexities. Abstraction describes what something is without knowing how it works. For example, you can put money in a vending machine and get a treat out without understanding how the mechanics function.

In **Time Trial: Pizza Pursuit**, there are two kinds of zones: pickup zones, which use the [**Item Spawner**](https://www.epicgames.com/fortnite/en-US/creative/docs/using-item-spawner-devices-in-fortnite-creative) device, and delivery zones, which use the [**Capture Area**](https://www.epicgames.com/fortnite/en-US/creative/docs/using-capture-area-devices-in-fortnite-creative) device. Since these zones will behave the same way even though they’re different devices — meaning that both can be activated and deactivated — you can create a [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) to abstract this behavior into a generic zone object that handles the specific device interactions.

Abstracting this behavior into a class means you have only one place to change out what kind of devices you use. This implementation also means that you can change its specifics without changing any of your other code, because any code that uses this class only knows about the activate / deactivate functions.

Follow these steps to create this zone class:

1. Create a new empty Verse file named **pickup\_delivery\_zone.verse** and open it in Visual Studio Code.
2. In the Verse file, create a new class named `base_zone` with the `public` specifier and add:

   - A `creative_object_interface` constant named `ActivatorDevice` with the `public` specifier, to store the device used in the zone.
   - An event named `ZoneCompletedEvent` that has the `public` specifier, to signal when the player interacts with this zone, such as picking up items or delivering them.
   - A function named `ActivateZone()` that has the `void` return type and the `public` specifier, to enable the device used for the zone.
   - A function named `DeactivateZone()` that has the `void` return type and the `public` specifier, to disable the device used for the zone.

     ```verse
     base_zone<public> := class:
                                   ActivatorDevice<public> : creative_object_interface
                                   ZoneCompletedEvent<public> : event(base_zone) = event(base_zone){}
             
                                   ActivateZone<public>() : void =
          Print("Zone activated")
             
                                   DeactivateZone<public>() : void =
          Print("Zone deactivated")
     ```

     When a class and its members have the `public` specifier, then they are universally accessible from other code. For more details, see [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse).
3. In the `ActivateZone()` function, check whether the `ActivatorDevice` is a Capture Area device or Item Spawner device by type casting the `ActivatorDevice` to the different types and call the `Enable()` function on the converted device. Do the same with the `DeactivateZone()` function, except call the `Disable()` function.

   ```verse
        base_zone<public> := class:
            ActivatorDevice<public> : creative_object_interface
     
            ActivateZone<public>() : void =
                Print("Zone activated")
                if (CaptureArea := capture_area_device[ActivatorDevice]):
                    CaptureArea.Enable()
                else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                    ItemSpawner.Enable()
     
            DeactivateZone<public>() : void =
                Print("Zone deactivated")
                if (CaptureArea := capture_area_device[ActivatorDevice]):
                    CaptureArea.Disable()
                else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                    ItemSpawner.Disable()
   ```

4. Create a function named `WaitForZoneCompleted()` that has the `private` specifier and `suspends` specifier. This function will signal the `ZoneCompletedEvent` when the device-specific event occurs. This setup means that other code just needs to wait for the `ZoneCompletedEvent` and not care what kind of event the underlying device uses.

   ```verse
        WaitForZoneCompleted<private>(ZoneDeviceCompletionEventOpt : ?awaitable(agent))<suspends> : void =
            if (DeviceEvent := ZoneDeviceCompletionEventOpt?):
                DeviceEvent.Await()
                ZoneCompletedEvent.Signal(Self)
   ```

   This function must have the `suspends` effect to be able to call `DeviceEvent.Await()`.
5. Update `ActivateZone()` with a `spawn` expression that calls `WaitForZoneCompleted()` with the appropriate device event for the player interacting with the device: `AgentEntersEvent` for the Capture Area device and `ItemPickedUpEvent` for the Item Spawner device. `WaitForZoneCompleted` expects an `option` (indicated by `?`) parameter of type `awaitable(agent)`, so we can pass any type that implements the `awaitable` interface, with its parametric type equals to `agent`. Both `CaptureArea.AgentEntersEvent` and `ItemSpawner.ItemPickedUpEvent` respect this condition, so we can use them as the parameter. This is another example of abstraction.

   ```verse
        ActivateZone<public>() : void =
            Print("Zone activated")
            if (CaptureArea := capture_area_device[ActivatorDevice]):
                CaptureArea.Enable()
                spawn { WaitForZoneCompleted(option{CaptureArea.AgentEntersEvent})}
            else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                ItemSpawner.Enable()
                spawn { WaitForZoneCompleted(option{ItemSpawner.ItemPickedUpEvent}) }
   ```

6. Add another event named `ZoneDeactivatedEvent` that has the `protected` specifier. This event is necessary to terminate the `WaitForZoneCompleted()` function if the zone is deactivated before the player completes it. Signal this event in the `DeactivateZone()` function.

   ```verse
        ZoneDeactivatedEvent<protected> : event() = event(){}
     
        DeactivateZone<public>() : void =
            Print("Zone deactivated")
            if (CaptureArea := capture_area_device[ActivatorDevice]):
                CaptureArea.Disable()
            else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                ItemSpawner.Disable()
            ZoneDeactivatedEvent.Signal()
   ```

7. Update `WaitForZoneCompleted()` with a `race` expression so the function will wait for either the player to complete the zone, or the zone is deactivated. With the `race` expression, the `ZoneDeactivatedEvent.Await()` asynchronous function call and the `block` expression with the device event and `ZoneCompletedEvent` signal will run at the same time but the expression that doesn’t finish first is canceled.

   ```verse
   WaitForZoneCompleted<private>(ZoneDeviceCompletionEventOpt : ?awaitable(agent))<suspends> : void = if (DeviceEvent := ZoneDeviceCompletionEventOpt?): race: block: DeviceEvent.Await() ZoneCompletedEvent.Signal(Self) ZoneDeactivatedEvent.Await()
   ```

8. Finally, make a [constructor](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) for the `base_zone` class which will [initialize](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#initialize) the `ActivatorDevice` field.

   ```verse
   MakeBaseZone<constructor><public>(InActivatorDevice : creative_object_interface) := base_zone: ActivatorDevice := InActivatorDevice
   ```

9. The following is the complete code for the `base_zone` class.

   ```verse
        # A zone is an area of the map (represented by a device) that can be Activated/Deactivated and that provides events to signal when the zone has been "Completed" (can't be completed anymore until next activation).
        # Zone "Completed" depends on the device type (ActivatorDevice) for the zone.
        # Suggested usage: ActivateZone() -> ZoneCompletedEvent.Await() -> DeactivateZone() #
     
        base_zone<public> := class:
            ActivatorDevice<public> : creative_object_interface
            ZoneCompletedEvent<public> : event(base_zone) = event(base_zone){}
     
            GetTransform<public>() : transform =
                ActivatorDevice.GetTransform()
     
            # Activates the Zone.
            # You should enable devices and any visual indicators for the zone here. 
            ActivateZone<public>() : void =
                # The base zone can handle zones defined as item spawners or capture areas.
                # Try and cast to each type to see which we're dealing with.
                if (CaptureArea := capture_area_device[ActivatorDevice]):
                    CaptureArea.Enable()
                    spawn { WaitForZoneCompleted(option{CaptureArea.AgentEntersEvent}) }
                else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                    ItemSpawner.Enable()
                    spawn { WaitForZoneCompleted(option{ItemSpawner.ItemPickedUpEvent}) }
             
            # Deactivates the Zone.
            # You should disable devices and any visual indicators for the zone here. 
            DeactivateZone<public>() : void =
                if (CaptureArea := capture_area_device[ActivatorDevice]):
                    CaptureArea.Disable()
                else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                    ItemSpawner.Disable()
                ZoneDeactivatedEvent.Signal()
     
            # This event is necessary to terminate the WaitForZoneCompleted coroutine if the zone is deactivated without being completed. 
            ZoneDeactivatedEvent<protected> : event() = event(){}
     
            WaitForZoneCompleted<private>(ZoneDeviceCompletionEventOpt : ?awaitable(agent))<suspends> : void =
                if (DeviceEvent := ZoneDeviceCompletionEventOpt?):
                    race:
                        block:
                            DeviceEvent.Await()
                            ZoneCompletedEvent.Signal(Self)
                         
                        ZoneDeactivatedEvent.Await()
     
        MakeBaseZone<constructor><public>(InActivatorDevice : creative_object_interface) := base_zone:
            ActivatorDevice := InActivatorDevice
   ```

## Finding Zones at Runtime with Gameplay Tags

Now that you have a way to create zones and activate / deactivate them, let’s add a way to initialize all the zones that you tagged in the level and how to select the next one to activate.

This example shows how to do this with a class that is responsible for creating the zones and selecting the next zone to activate.

Follow these steps to create the class for creating and selecting zones:

1. Create a new class named `tagged_zone_selector` in the **pickup\_delivery\_zone.verse** file. Add a variable array to store all the zones in the level.
    `tagged_zone_selector<public> := class:
   var Zones<protected> : []base_zone = array{}`
2. Add a method named `InitZones()` that has the `public` specifier and a `tag` parameter to find all zones associated with that Gameplay Tag and cache them.

   ```verse
   InitZones<public>(ZoneTag : tag) : void =
    
   # On creation of a zone selector, find all available zones and cache them so we don't consume time searching for tagged devices every time the next zone is selected.
    
   ZoneDevices := GetCreativeObjectsWithTag(ZoneTag) 
   set Zones = 
     for (ZoneDevice : ZoneDevices): MakeBaseZone(ZoneDevice)
   ```

3. Add a method named `SelectNext()` that has the `decides` and `transacts` specifiers so the method will either find another zone or fail. Select the zone at a random index in the array using `GetRandomInt(0, Zones.Length - 1)` for the index.

   ```verse
        SelectNext<public>()<transacts><decides> : base_zone =
            Zones[GetRandomInt(0, Zones.Length - 1)]
   ```

4. The complete code for pickup\_delivery\_zone.verse file should now look like:

   ```verse
        using { /Verse.org/Simulation }
        using { /Verse.org/Random }
        using { /Verse.org/Concurrency }
        using { /Verse.org/Simulation/Tags }
        using { /UnrealEngine.com/Temporary/SpatialMath }
        using { /Fortnite.com/Devices }

        <# A zone is an area of the map (represented by a device) that can be Activated/Deactivated and that provides events
        to signal when the zone has been "Completed" (can't be completed anymore until next activation).
        Zone "Completed" depends on the device type (ActivatorDevice) for the zone.
        Suggested usage: ActivateZone() -> ZoneCompletedEvent.Await() -> DeactivateZone() #>
        base_zone<public> := class:
            ActivatorDevice<public> : creative_object_interface
            ZoneCompletedEvent<public> : event(base_zone) = event(base_zone){}

            GetTransform<public>() : transform =
                ActivatorDevice.GetTransform()

            <# Activates the Zone.
            You should enable devices and any visual indicators for the zone here. #>
            ActivateZone<public>() : void =
                # The base zone can handle zones defined as item spawners or capture areas.
                # Try and cast to each type to see which we're dealing with.
                if (CaptureArea := capture_area_device[ActivatorDevice]):
                    CaptureArea.Enable()
                    spawn { WaitForZoneCompleted(option{CaptureArea.AgentEntersEvent}) }
                else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                    ItemSpawner.Enable()
                    spawn { WaitForZoneCompleted(option{ItemSpawner.ItemPickedUpEvent}) }

            <# Deactivates the Zone.
            You should disable devices and any visual indicators for the zone here. #>
            DeactivateZone<public>() : void =
                if (CaptureArea := capture_area_device[ActivatorDevice]):
                    CaptureArea.Disable()
                else if (ItemSpawner := item_spawner_device[ActivatorDevice]):
                    ItemSpawner.Disable()
                ZoneDeactivatedEvent.Signal()

            <# This event is necessary to terminate the WaitForZoneCompleted coroutine if the zone is deactivated without being completed. #>
            ZoneDeactivatedEvent<protected> : event() = event(){}

            WaitForZoneCompleted<private>(ZoneDeviceCompletionEventOpt : ?awaitable(agent))<suspends> : void =
                if (DeviceEvent := ZoneDeviceCompletionEventOpt?):
                    race:
                        block:
                            DeviceEvent.Await()
                            ZoneCompletedEvent.Signal(Self)

                        ZoneDeactivatedEvent.Await()

        MakeBaseZone<constructor><public>(InActivatorDevice : creative_object_interface) := base_zone:
            ActivatorDevice := InActivatorDevice

        # The tagged_zone_selector creates zones based on triggers tagged with the tag passed to InitZones.
        tagged_zone_selector<public> := class:
            var Zones<protected> : []base_zone = array{}

            InitZones<public>(ZoneTag : tag) : void =
                <# On creation of a zone selector, find all available zones
                and cache them so we don't consume time searching for tagged devices
                every time the next zone is selected. #>
                ZoneDevices := GetCreativeObjectsWithTag(ZoneTag)
                set Zones = for (ZoneDevice : ZoneDevices):
                    MakeBaseZone(ZoneDevice)

            SelectNext<public>()<transacts><decides> : base_zone =
                Zones[GetRandomInt(0, Zones.Length - 1)]
   ```

## Testing Pickup and Delivery Zones

Now that you've created two classes, it's a good idea to test your code and make sure that your zone selection works the way you expect.

Follow these steps to update your **game\_coordinator\_device.verse** file:

1. Add a constant for the delivery zone selector and a variable array for the pickup zone selectors to the `game_coordinator_device`. Since the game will later increase the pickup level after each pizza pickup, you will need one `tagged_zone_selector` for each pickup level you want in the game, hence the `PickupZoneSelectors` array.
   Each zone selector holds all the pickup zones of a certain level. It needs to be a variable because its setup is determined by the number of `pickup_zone_tag`s in `PickupZoneLevelTags`.
2. Use this setup to extend the number of pickup levels with minimal changes to the code: you just need to update the `PickupZoneLevelTags` with additional ones deriving from `pickup_zone_tag`, then tag the devices in the editor.

   ```verse
   game_coordinator_device<public> := class<concrete>(creative_device): DeliveryZoneSelector<private> : tagged_zone_selector = tagged_zone_selector{} 
   var PickupZoneSelectors<private> : []tagged_zone_selector = array{}
   ```

3. Add a method named `SetupZones()` and call the method in `OnBegin()`:

   - Set the method to have the `private` specifier and a `void` return type.
   - Initialize the delivery zone selector with the `delivery_zone_tag`.
   - Create the pickup zone level tags and initialize the pickup zone selectors.

     ```verse
     OnBegin<override>()<suspends> : void =
        SetupZones()
             
     SetupZones<private>() : void =
                                   DeliveryZoneSelector.InitZones(delivery_zone_tag{})
             
                                   PickupZoneLevelTags : []pickup_zone_tag = array{pickup_zone_level_1_tag{}, pickup_zone_level_2_tag{}, pickup_zone_level_3_tag{}}
             set PickupZoneSelectors = 
     for(PickupZoneTag : PickupZoneLevelTags):
     PickupZone := tagged_zone_selector{}
                                       PickupZone.InitZones(PickupZoneTag)
     PickupZone
     ```

4. Create a loop in `OnBegin()` that selects the next pickup zone, activates it, waits for the player to complete the zone, and then deactivates the zone.

   ```verse
   OnBegin<override>()<suspends> : void =
   SetupZones()
     
   var PickupLevel : int = 0
     
   loop:
      if (PickupZone : base_zone = PickupZoneSelectors[PickupLevel].SelectNext[]):
         PickupZone.ActivateZone()
         PickupZone.ZoneCompletedEvent.Await()
         PickupZone.DeactivateZone()
      else:
         Print("Can't find next PickupZone to select")
                    return
     
      if (DeliveryZone := DeliveryZoneSelector.SelectNext[]):
                    DeliveryZone.ActivateZone()
                    DeliveryZone.ZoneCompletedEvent.Await()
                    DeliveryZone.DeactivateZone()
      else:
                    Print("Can't find next DeliveryZone to select")
                    return
   ```

5. Save your Verse files, compile your code, and playtest your level.

When you playtest your level, one of the Item Spawner devices will activate at the start of the game. After you pick up the item, the Item Spawner device will deactivate and a Capture Area device will then activate. This continues until you manually end the game.

## Next Step

[![3. Creating the Game Loop](https://dev.epicgames.com/community/api/documentation/image/806c8e89-6c49-46fb-91aa-c9ba4d92a621?resizing_type=fit&width=640&height=640)

1. Creating the Game Loop

Create a game with Verse where players must pick up and deliver pizzas before the time runs out!](<https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-3-creating-the-game-loop-for-time-trial-in-verse>)
