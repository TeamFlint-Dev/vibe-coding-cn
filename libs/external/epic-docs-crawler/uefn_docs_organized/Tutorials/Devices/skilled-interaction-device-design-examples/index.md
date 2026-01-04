# Skilled Interaction Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/skilled-interaction-device-design-examples
> **爬取时间**: 2025-12-26T23:04:23.673758

---

This interactive device is perfect for creating fun mini-games where players can practice various in-game skills.

### Starting a Fire

Use the **Skilled Interaction** device to quickly make a more engaging interaction for basic gameplay moments like lighting a campfire!

### Devices Used

- 1 x Skilled Interaction device
- 1 x Player Spawner device
- 1 x Campfire device

### Set Up the Devices

1. Place a **Player Spawner** device.
2. Place a **Campfire** device.
3. Customize the **Campfire** device:

   [![](https://dev.epicgames.com/community/api/documentation/image/e595d34a-35e1-4106-8f2e-83219eefc44e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e595d34a-35e1-4106-8f2e-83219eefc44e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Can Be Lit | No |
   | Can Be Extinguished | No |
   | Campfire Zone Size | 2.5 Meters |
4. Place a **Skilled Interaction** device.
5. Customize the device:

   [![](https://dev.epicgames.com/community/api/documentation/image/c9132c84-fabe-44d3-a3c2-7771786fbb9d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9132c84-fabe-44d3-a3c2-7771786fbb9d?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/a11331f1-57c9-48f5-a1be-29e33dae792d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a11331f1-57c9-48f5-a1be-29e33dae792d?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interaction Type | Charge and Release |
   | UI Type | Pulsing |
   | Meter Thickness | 100 |
   | Good Zone Position | 100% |
   | Perfect Zone Size | 0% |
   | Scrubber Color | White |

## Bind Functions and Events

[Direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#directeventbinding) is how you set devices to communicate directly with other devices. This involves setting [functions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#function) and [events](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#event) for the devices involved.

1. Configure the following event on the Skilled Interaction device so that a successful interaction lights the fire.

   [![](https://dev.epicgames.com/community/api/documentation/image/42dddbe4-b534-4865-8019-fe453b2163bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42dddbe4-b534-4865-8019-fe453b2163bd?resizing_type=fit)

   | Event | Select Device | Select Function |  |
   | --- | --- | --- | --- |
   | On Success | Campfire | Light |  |
2. Configure the following events on the campfire so that entering the zone will trigger the Skilled Interaction device and leaving the zone will extinguish the fire.

   [![](https://dev.epicgames.com/community/api/documentation/image/b33da682-be55-4b0f-85a1-0fc35127e0bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b33da682-be55-4b0f-85a1-0fc35127e0bb?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Entering Area | Skilled Interaction Device | Begin Interaction for Instigator |
   | On Leaving Area | Campfire | Extingui |

You now have the basic functionality for a custom fire-starting interaction!

### Design Tip

Setting the size of the **Perfect** interaction zone to **0%** makes it so that there is only one successful interaction zone. This is especially  good for simple interactions like this one where there’s no difference in outcome between **Good** and **Perfect**.

## Build a Volcano Escape

You can configure the Skilled Interaction device to require multiple player successes to complete the interaction. When paired with a time limit, this can create a tense and exciting interaction!

### Devices Used

- 1 x Skilled Interaction device
- 1 x Player Spawner device
- 1 x [Water](https://dev.epicgames.com/documentation/en-us/fortnite/using-water-devices-in-fortnite-creative) device
- 1 x [Baller Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-baller-spawner-devices-in-fortnite-creative) device
- 1 x [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) device

### Set Up the Basic Gameplay

1. Start with the **Volcano Island** starter island.
2. Create a small platform inside the volcano using a rock from the **Tropical Rock** gallery.
3. Place a **Player Spawner** device on top of the rock and customize so it isn't visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/b53196b7-c2f0-47fc-9a89-8b3fe0e85953?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b53196b7-c2f0-47fc-9a89-8b3fe0e85953?resizing_type=fit)
4. Place a **Water** device at the bottom of the volcano and tweak the placement of the zone and the dimensions to make it appear as if the water is contained within the volcano as it’s rising.
5. Customize the Water device:

   [![](https://dev.epicgames.com/community/api/documentation/image/05c451d5-a52e-4ba9-ae7b-00816614586d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/05c451d5-a52e-4ba9-ae7b-00816614586d?resizing_type=fit)

   |  |  |
   | --- | --- |
   | Option | Value |
   | Zone Depth | 3.5 |
   | Zone Height | 3.5 |
   | Default Vertical Water Percentage | 0.0 |
   | Vertical Filling Speed (T PM) | 8.0 |
   | Water Type | Red River Styx |
6. Configure the following event on the **Player Spawner** device so that the water begins rising right when the game begins.

   [![](https://dev.epicgames.com/community/api/documentation/image/48bf02f3-7ada-4f54-8e3a-5ab8d5cc332a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48bf02f3-7ada-4f54-8e3a-5ab8d5cc332a?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Player Spawned | Water | Start Vertical Filling |

### Set Up the Skilled Interaction

1. Place a **Baller Spawner** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/3213cb8b-7733-42fa-9e49-2c5ecd568fe5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3213cb8b-7733-42fa-9e49-2c5ecd568fe5?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Enabled During Phase | None |
   | Visible in Game | Off |
2. Place a **Skilled Interaction** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/80b25c8c-5b0b-460a-ac0f-18ddfe35fe13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/80b25c8c-5b0b-460a-ac0f-18ddfe35fe13?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/3af8a507-4110-4ebc-8888-c241f95c3d4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3af8a507-4110-4ebc-8888-c241f95c3d4e?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Movement Speed | 75% |
   | Good Zone Size | 10% |
   | Perfect Zone Size | 0% |
   | Success Target | 3 |
   | Show Successes | On |
   | Success Counter Color | White |
   | Failure Limit | 3 |
   | Show Failures | On |
   | Fail Counter Color | White |
   | Scrubber Color | White |
3. Configure the following event on the **Skilled Interaction** device so that it will spawn a baller when the interaction is completed successfully. If the interaction fails, the **Button** will be disabled and the player will not be able to complete the challenge!

   [![](https://dev.epicgames.com/community/api/documentation/image/789a6cb6-73f6-460d-9220-241d1c63c7f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/789a6cb6-73f6-460d-9220-241d1c63c7f5?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Fail | Button | Disable |
4. Place a **Button** device on the wall and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/442dc805-d394-4a70-acdb-d9d7e032c5e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/442dc805-d394-4a70-acdb-d9d7e032c5e5?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Interaction Text | Create a Baller to Escape! |
5. Configure the following event on the **Button** device so that it will start the **Skilled Interaction** when pressed.

   [![](https://dev.epicgames.com/community/api/documentation/image/55219166-3792-4739-8fc4-1c2233cbb692?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55219166-3792-4739-8fc4-1c2233cbb692?resizing_type=fit)

| Event | Select Device | Select Function |
| --- | --- | --- |

You now have the basic functionality for a volcano escape!

### Design Tip

With the events that the Skilled Interaction device can send, anything is possible. Use these interactions to trigger doors unlocking, new gameplay areas opening, item upgrades, or anything else you can imagine. Get creative with how to tailor the interactions to the action that the player is performing!

## Build a Fishing Quest Mini-Game

The Skilled Interaction device can be combined with a **Fishing Zone** and some **Item Granter** devices to create a fun and engaging fishing mini-game! With some other devices, you’ll create a basic quest in which the player must fish successfully to unlock a new gameplay area!

### Devices Used

- 1 x Skilled Interaction device
- 1 x Player Spawner device
- 1 x [Fishing Rod Barrel](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-rod-barrel-devices-in-fortnite-creative) device
- 2 x [Item Granter](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-granter-devices-in-fortnite-creative) devices
- 1 x [Fishing Zone](https://dev.epicgames.com/documentation/en-us/fortnite/using-fishing-zone-devices-in-fortnite-creative) device
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative) device
- 1 x [Character](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative) device
- 1 x [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/hud-message-device) device
- 1 x [Tracker](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative) device

### Set Up the Basic Fishing Devices

1. Begin with the **Mountain Ridge Island** starter island.
2. Place the **Lockie’s Lighthouse** prefab near the water.
3. Place a **Player Spawner** device and customize so it does not show in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/91ec32a3-071e-4465-af2a-e877fa99200b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/91ec32a3-071e-4465-af2a-e877fa99200b?resizing_type=fit)
4. Place a **Fishing Rod Barrel** device next to the lighthouse.
5. Place an **Item Granter** device and register a **Flopper** to the device.
6. Customize the Item Granter:

   [![](https://dev.epicgames.com/community/api/documentation/image/4d50c515-9d1e-428e-8bb1-fc2161ccd8ea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d50c515-9d1e-428e-8bb1-fc2161ccd8ea?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Drop Items at Player Location | Alway |
7. Duplicate the Item Granter and rename the duplicate to **Perfect Item Granter**. Unregister the **Flopper** and register a **Slurpfish**.
8. Place a **Fishing Zone** device in the water and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/bad0107e-ba0d-4e3b-b4de-0ad0f697ac8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bad0107e-ba0d-4e3b-b4de-0ad0f697ac8c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Pool Type | Trigger Only |
9. Place a **Skilled Interaction** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/b011b8b8-d3b4-483e-be62-16c63207a2ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b011b8b8-d3b4-483e-be62-16c63207a2ff?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/d8c993f3-b4ed-4f18-b3a3-30ccb44e41af?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d8c993f3-b4ed-4f18-b3a3-30ccb44e41af?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Description Text | The better you do, the better the fish! |
   | UI Type | Bar |
   | Movement Type | Wiggle |
   | Wiggle Time Min | 0.25 Seconds |
   | Wiggle Time Max | 0.5 Seconds |
   | Movement Speed | 100% |
   | Good Zone Size | 25% |
   | Position Zone Randomly | On |
   | Scrubber Color | White |

### Set Up the Quest Devices

1. Place a **Lock** device on the door frame of the lighthouse, making sure that it glows blue to indicate that it is successfully connected.
2. Customize the lock so it is not visible in-game:

   [![](https://dev.epicgames.com/community/api/documentation/image/261e7494-4e8c-45e4-aadb-0d4ba06e96ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/261e7494-4e8c-45e4-aadb-0d4ba06e96ef?resizing_type=fit)
3. Place a **Character** device next to the lighthouse and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/99f7a9d3-7092-4bec-b60f-45ec4da35a32?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99f7a9d3-7092-4bec-b60f-45ec4da35a32?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Use Animated Idle | On |
   | Interact Type | Send Event Only |
   | Interaction Text | Talk |
4. Place a **HUD Message** device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/819ef1ad-1a3f-4dd1-9e2a-ec3249df8a3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/819ef1ad-1a3f-4dd1-9e2a-ec3249df8a3c?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Message Recipient | All |
   | Placement | Top Center |
   | Text Color | White |
5. Place a Tracker device and customize:

   [![](https://dev.epicgames.com/community/api/documentation/image/617a9f48-784d-43a7-b0ad-d171f0225c24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/617a9f48-784d-43a7-b0ad-d171f0225c24?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | Target Value | 3 |
   | Assign on Game Start | Off |
   | Tracker Title | Catch Fish |
   | Description Text | Catch 3 Fish to Unlock the Lighthouse! |
   | Quest Icon | Fishing |

### Bind Functions and Events

1. Configure the following event on the **Fishing Zone** device to trigger the **Skilled Interaction** device when the player catches a fish in the zone.

   [![](https://dev.epicgames.com/community/api/documentation/image/537ee58f-8b32-490b-9fba-a5eaf9adc29e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/537ee58f-8b32-490b-9fba-a5eaf9adc29e?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
2. Configure the following events on the **Skilled Interaction** device so that when a fish is caught, it increments the value on the **Tracker** device and grant different fish, depending on whether the input was **Good** or **Perfect**.

   [![](https://dev.epicgames.com/community/api/documentation/image/54c93d0f-2cb6-4abd-acf7-e78fe50b8051?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54c93d0f-2cb6-4abd-acf7-e78fe50b8051?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/24b41f7a-b2e7-4c51-af51-e09409aeccd0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24b41f7a-b2e7-4c51-af51-e09409aeccd0?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Good Input | Good Item Granter | Grant Item |
   | On Perfect Input | Perfect Item Granter | Grant Item |
3. Configure the following events on the **Character** device so that when the player interacts with it, it will trigger both the quest and the **HUD message** that delivers the accompanying line of dialogue:

   [![](https://dev.epicgames.com/community/api/documentation/image/3b7458f6-faed-44aa-8fda-07710d1a0c10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b7458f6-faed-44aa-8fda-07710d1a0c10?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |
   | On Interacted With | Fishstick Dialogue Device | Show |
4. Configure the following event on the tracker so that when the quest is completed, the lighthouse will open.

   [![](https://dev.epicgames.com/community/api/documentation/image/6a6446a3-1eb9-473b-b8e8-c4c916cb1af7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a6446a3-1eb9-473b-b8e8-c4c916cb1af7?resizing_type=fit)

   | Event | Select Device | Select Function |
   | --- | --- | --- |

You now have a working fishing mini-game connected to a quest system!

### Design Tip

This type of fishing mini-game is very common in cozy farming games and other similar games. But more and more games of all genres are adding fishing as a fun side mechanic that players can use to unlock additional items.

Consider different types of games that could benefit from a fishing mini-game and try adding one!
