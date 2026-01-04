# 1. Setting up the Pizza Pursuit Level

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-1-setting-up-the-level-for-time-trial-in-verse
> **爬取时间**: 2025-12-27T00:20:48.158234

---

By completing this step in the [Time Trial: Pizza Pursuit](https://dev.epicgames.com/documentation/en-us/uefn/time-trial-pizza-pursuit-in-verse) tutorial, you'll have all the props and devices you'll need on your level.

## Setting up Props and Devices

This example uses the following props and devices.

- 1 x [ATK Spawner device](https://www.fortnite.com/en-US/creative/docs/using-atk-spawner-devices-in-fortnite-creative)
- 1 x [Capture Area device](https://www.fortnite.com/en-US/creative/docs/using-capture-area-devices-in-fortnite-creative)
- 1 x [End Game device](https://www.fortnite.com/en-US/creative/docs/using-end-game-devices-in-fortnite-creative)
- 1 x [Item Remover device](https://www.fortnite.com/en-US/creative/docs/using-item-remover-devices-in-fortnite-creative)
- 8 x [Item Spawner devices](https://www.fortnite.com/en-US/creative/docs/using-item-spawner-devices-in-fortnite-creative)
- 1 x [Map Indicator device](https://www.fortnite.com/en-US/creative/docs/using-map-indicator-devices-in-fortnite-creative)
- 1 x [Player Spawn Pad device](https://www.fortnite.com/en-US/creative/docs/using-player-spawn-pad-devices-in-fortnite-creative)
- 1 x [Score Manager device](https://www.fortnite.com/en-US/creative/docs/using-score-manager-devices-in-fortnite-creative)

Follow these steps to set up your test level:

1. Place an **ATK Spawner** device and set its properties:

   - Set **Water Destruction Timer** to **10.0**.

   [![ATK Spawner device settings for Pizza Pursuit game](https://dev.epicgames.com/community/api/documentation/image/d4951bda-7241-4976-a314-f6e89db87fa4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d4951bda-7241-4976-a314-f6e89db87fa4?resizing_type=fit)
2. Place a **Capture Area** device and set its properties:

   - Set **Capture Radius** to **0.66**.
   - Set **Item Delivery Score** to **0**.
   - Enable **Show in Objective HUD**.

   [![Capture Area device settings for Pizza Pursuit game](https://dev.epicgames.com/community/api/documentation/image/a5467953-1286-409c-a123-58490752fee2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5467953-1286-409c-a123-58490752fee2?resizing_type=fit)
3. Place an **End Game** device.
4. Place an **Item Remover** device and set its properties:

   - Set **Affected Items** to **All Items**.
   - Set **Amount to Remove** to **Percentage**.
   - Set **Percentage to Remove** to **100.0**.
   - Set **Apply To** to **All Players**.
   - Under **Advanced**, disable **Play Audio**.

   [![Item Remover device settings for Pizza Pursuit game](https://dev.epicgames.com/community/api/documentation/image/3f144638-5f46-47cb-af46-5de35469b48f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f144638-5f46-47cb-af46-5de35469b48f?resizing_type=fit)
5. Place an **Item Spawner** device and set its properties:

   - Set **Time Before First Spawn** to **0.0**.
   - Set **Time Between Spawns** to **0.0**.
   - Add the pizza slice item to **Item List**.
   - Under **Advanced**:

     - Disable **Base Visible During Game**.
     - Enable **Run Over Pickup**.
     - Enable **Allow Spawning when Blocked**.
     - Set **Item Scale** to **2.0**.
     - Disable **Enabled at Game Start**.

   [![Item Spawner device settings for Pizza Pursuit game](https://dev.epicgames.com/community/api/documentation/image/5c72d3c2-b70b-42bc-9fe0-94cca9886a11?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c72d3c2-b70b-42bc-9fe0-94cca9886a11?resizing_type=fit)
6. Duplicate the Item Spawner device so there are eight Item Spawner devices in the level.
7. Place a **Player Spawn Pad** device.
8. Place a **Score Manager** device and set its properties:

   - Set **Score Award Type** to **Set**.
   - Under **Advanced**, disable **Increment Score On Awarding**.

   [![Score Manager device settings for Pizza Pursuit game](https://dev.epicgames.com/community/api/documentation/image/dcf7909d-6640-4d0d-8799-0421cc4c38ee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcf7909d-6640-4d0d-8799-0421cc4c38ee?resizing_type=fit)

Your level should now look something like this.

[![Level setup for Pizza Pursuit game](https://dev.epicgames.com/community/api/documentation/image/ec8c16ee-d185-4597-9c74-2690d479fc21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ec8c16ee-d185-4597-9c74-2690d479fc21?resizing_type=fit)

## Setting up the Verse Device and Gameplay Tags

Follow these steps to set up your Verse device and [gameplay tags](unreal-editor-for-fortnite-glossary#gameplay-tag):

1. Create a new Verse device named `game_coordinator_device` and add it to the level. See [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) for steps.
2. Add the following [modules](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#module) at the top of the file:

   ```verse
   using { /Verse.org/Simulation } using { /Fortnite.com/Devices } using { /Fortnite.com/Vehicles } using { /Fortnite.com/Characters } using { /Fortnite.com/Playspaces } using { /Verse.org/Random } using { /UnrealEngine.com/Temporary/Diagnostics } using { /UnrealEngine.com/Temporary/SpatialMath } using { /UnrealEngine.com/Temporary/Curves } using { /Verse.org/Simulation/Tags }
   ```
3. Create five gameplay tags in Verse, named and assigned as follows. (See [Gameplay Tags](https://dev.epicgames.com/documentation/en-us/fortnite/gameplay-tags-in-verse) for steps.)

   - `pickup_zone_tag` and assign to all the Item Spawner devices.
   - `pickup_zone_level_1_tag` and assign to two of the Item Spawner devices.
   - `pickup_zone_level_2_tag` and assign to three other Item Spawner devices.
   - `pickup_zone_level_3_tag` and assign to the last three Item Spawner devices.
   - `delivery_zone_tag` and assign to the Capture Area device.
4. Your **game\_coordinator\_device.verse** file should now look like:

   ```verse
   using {/Verse.org/Simulation} 
   using {/Fortnite.com/Devices} 
   using {/Fortnite.com/Vehicles} 
   using {/Fortnite.com/Characters} 
   using {/Fortnite.com/Playspaces} 
   using {/Verse.org/Random} 
   using {/UnrealEngine.com/Temporary/Diagnostics} 
   using {/UnrealEngine.com/Temporary/SpatialMath} 
   using {/UnrealEngine.com/Temporary/Curves} 
   using {/Verse.org/Simulation/Tags} 

   # Game zones tags 
   pickup_zone_tag := class(tag) {} 
   pickup_zone_level_1_tag := class(pickup_zone_tag) {} pickup_zone_level_2_tag := class(pickup_zone_tag) {} pickup_zone_level_3_tag := class(pickup_zone_tag) {} delivery_zone_tag := class(tag) {} 
   game_coordinator_device := class(creative_device): 

   OnBegin<override>()<suspends> : void =
   ```

## Next Step

[![2. Defining the Pickup and Delivery Zones](https://dev.epicgames.com/community/api/documentation/image/350c587d-38e5-480b-9643-b91eed7fbba7?resizing_type=fit&width=640&height=640)

2. Defining the Pickup and Delivery Zones

Create a game with Verse where players must pick up and deliver pizzas before the time runs out!](https://dev.epicgames.com/documentation/en-us/fortnite/pizza-pursuit-2-defining-the-pickup-and-delivery-zones-for-time-trial-in-verse)
