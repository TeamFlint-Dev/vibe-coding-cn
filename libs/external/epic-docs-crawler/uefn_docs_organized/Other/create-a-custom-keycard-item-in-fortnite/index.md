# Create a Custom Keycard Item

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-a-custom-keycard-item-in-fortnite
> **爬取时间**: 2025-12-27T00:34:43.286225

---

This feature is in an experimental state so you can try it out, provide feedback, and see what we are planning. You cannot publish a project that uses Custom Inventory and Items at this time.

Please keep in mind that we do not guarantee backward compatibility for assets created at the Experimental stage, the APIs for these features are subject to change, and we may remove entire experimental features or specific functionality at our discretion. Check out the list of known issues before you start working with the feature.

This tutorial shows you how to use the Custom Inventory and Items system with Scene Graph and Verse to make a custom keycard item.

Once you build this example to learn how to create a custom keycard, you can then use a custom keycard in games involving objectives to locate and use keycards to access locked areas. Some examples include:

- A locked room that contains the object for a heist
- The next area in your game
- Treasure or rewards for beating a boss

## Before You Begin

You should be familiar with UEFN, Scene Graph, and Verse code in order to successfully complete this tutorial.

## Set Up Your Project

Follow these steps to set up your project and enable Custom Inventory and Items.

1. Open UEFN and create a project from any island template. In Island Templates, you can use the **Blank** project if you want to ensure a flat area to work with. Name your new project, and click **Create** to open it in the editor.

   [![Open the Project Browser window, select a template, name the project and click Create.](https://dev.epicgames.com/community/api/documentation/image/bad4b293-04d9-4aca-b9ae-353f7b0d49a9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bad4b293-04d9-4aca-b9ae-353f7b0d49a9?resizing_type=fit)
2. From the tool bar, click **Project** and select **Project Settings**.

   [![](https://dev.epicgames.com/community/api/documentation/image/6ac003cc-33eb-475f-9686-17d89d0ce16e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ac003cc-33eb-475f-9686-17d89d0ce16e?resizing_type=fit)
3. Scroll down to the **Experimental Access** section, and check the box for **Inventory System**. This enables Custom Inventory and Items.

   [![In Project Settings, under Experimental Access click to enable Custom Items and Inventory.](https://dev.epicgames.com/community/api/documentation/image/0288557f-f65e-4503-82c8-b720457ec8e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0288557f-f65e-4503-82c8-b720457ec8e4?resizing_type=fit)

## Build Your Room

First you need to build the room for the example. The example is laid out like a demonstration that compares two locked doors:

- The first one demonstrates how a Fortnite keycard opens a door that has a Lock device, using a Conditional Button device to determine if the player has the keycard.
- The second one demonstrates how to use a custom keycard instead of the existing Fortnite keycard item, and uses Verse to determine if the player has the custom keycard.

To build the room for the example, you can use the following Fortnite assets:

- **Room**: In the Content Browser, navigate to **Fortnite > Graybox Assets > Demo**. This example uses the **DemoRoom** assets.
- **Demo booth**: In the Content Browser, navigate to **Fortnite > Graybox Assets > Demo**. Use the **DemoDisplay** asset.
- **Doors**:

  - **Door in Green Wall**: Navigate to **Fortnite > Galleries > Building > Tilted Towers Wall Gallery N**. Find **Suburban Interior Door C 02 a8a9d603** at the end of the first row.

    [![Find the door in the green wall in the Tilted Towers Wall Gallery N.](https://dev.epicgames.com/community/api/documentation/image/96239918-bac5-4f73-b978-e0f64f6e76bc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96239918-bac5-4f73-b978-e0f64f6e76bc?resizing_type=fit)
  - **Door in Tan Wall with Dark Trim at Top**: In the same gallery as above, just to the left is **Suburban Interior Door C 02 a9577d9d**.
- **Table**: Navigate to **Fortnite > Props > Super**. Find **Academy Round Table A 13a04066**.

  [![Find the Academy Round Table A in the Props > Super folder.](https://dev.epicgames.com/community/api/documentation/image/8a446b8c-8c77-474e-844b-a7589be854eb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8a446b8c-8c77-474e-844b-a7589be854eb?resizing_type=fit)

## Setting Up the Devices

**Devices Needed**:

- 1 x Player Spawner
- 2 x Lock device
- 1 x Conditional Button device
- 2 x Volume device
- 1 x Item Placer (Authority Keycard Item)

### Setting Up the Door For a Fortnite Keycard

Pick one door for setting up a typical Fortnite locked door. Follow these steps to set up the devices for the first door.

1. Place one Lock Device on the wall next to the door. In the Details panel, customize the device options as shown below. Options not listed can be left at their default values.

   |  |  |  |
   | --- | --- | --- |
   | **Option** | **Value** | **Explanation** |
   | **Visible During Gam**e | False (Unchecked) | This hides the Lock device when the game is running, so that players won't see it. |
   | **Starts Locked** | Locked | This makes the door locked when the game starts. |
   | **Hide Interaction When Locked** | True (Checked) | This hides the interaction prompt when the door is locked. |
   | **Initial Door Position** | Closed | This makes the default starting position for the door is Closed. |
2. Under **User Options - Functions**, set the following functions for the Lock device.

   You may not be able to set the Lock function until after you place the Volume device in step 3, below.

   |  |  |  |  |
   | --- | --- | --- | --- |
   | **Function** | **Target Device** | **Event to Bind** | **Explanation** |
   | **Unlock** | Conditional Button | On Activated | The door is unlocked when the Conditional Button activates. |
   | **Lock** | Volume | On Exit | The door is locked when the player exits the Volume for the Fortnite devices door. |
3. Place one Volume device centered on the door itself. In the Details panel, customize the device options as shown below. Options not listed can be left at their default values.

   |  |  |  |
   | --- | --- | --- |
   | **Option** | **Value** | **Explanation** |
   | **Volume Shape** | Cylinder | This determines the shape of the volume. |
   | **Volume Height** | 0.25x | This determines how high the volume cylinder goes. |
   | **Volume Radius** | 0.9x | This sets the radius of the volume cylinder, which determines how close or far it is from the device location. You want the radius relatively small, so the player has to come close to the door to enter the volume. |
4. Place the Conditional Button device next to the door, under the Lock device. Customize the options as shown below. Options not listed can be left at their default values.

   |  |  |  |
   | --- | --- | --- |
   | **Option** | **Value** | **Explanation** |
   | **Key Items Required** | True (Checked), 1 | Check this to indicate that a key item is required to pass the condition. Enter 1 in the field to indicate that only one keycard is required. |
   | **Key Item 1** | Authority Keycard (In-game name) or AGID\_CP\_Keycard\_Agency (Item ID) | To select the item that is required, click the dropdown and search for "keycard". There are several keycard items, but this example uses the "Authority Keycard" item. |
5. Under **User Options - Functions**, set the following functions for the Conditional Button device.

   |  |  |  |  |
   | --- | --- | --- | --- |
   | **Function** | **Target Device** | **Event to Bind** | **Explanation** |
   | **Activate** | Volume | On Enter | When the player enters  Volume for the Fortnite devices door, the Conditional Button activates. It checks if the player has the Authority Keycard. |

### Setting Up the Door For the Custom Keycard

For the second door, follow these steps to set up the devices.

1. Because the options for both Lock devices are the same, you can copy the first Lock device and paste the copy in your level. You may want to rename the device to distinguish it from the first one.
2. Under **User Options - Functions**, set the following functions for the Lock device.

   You may not be able to set this function until you have placed the Player Spawner (anchor link here to that section).

   |  |  |  |  |
   | --- | --- | --- | --- |
   | **Function** | **Target Device** | **Event to Bind** | **Explanation** |
   | **Lock** | Player 1 Spawn Pad | On Player Spawned | When a player spawns from Player 1 Spawn Pad, the Lock device activates and locks the door. |
3. The options for both Volume devices are the same, so you can also copy the first Volume and paste the copy in your level. You may want to rename the device to distinguish it from the first one.

### Setting Up the Table for the Keycards

Follow these steps to set up the Table with the Fortnite keycard and your custom keycard.

1. Place the Item Placer device on the side of the table nearest the locked door that just uses devices.
2. In the Details panel, customize the device options for the Item Placer as shown below.

   |  |  |  |
   | --- | --- | --- |
   | **Option** | **Value** | **Explanation** |
   | **Item List** | Authority Keycard | Click the + to add an array element, then click the dropdown and search for "keycard". Then select the Authority Keycard item. |
3. Locate your custom keycard item in the Content Browser, and drag it into the level. Place the custom keycard on the table, on the side nearest the locked door set up for it.
4. Once you've created the keycard\_gameplay\_device (add anchor link here), locate the Verse device in the Content Browser, and drag it into your level.

### Setting Up the Player Spawner

Lastly, you'll need to place a Player Spawner. For this example, you only need one Player Spawner. But if you build a game with multiple players, you can follow these steps to set up more. Or you can set them up differently based on your particular island experience.

1. Place the Player Spawner in a place where the player will immediately see the table and the two doors.
2. Customize the device options as shown below.

   |  |  |  |
   | --- | --- | --- |
   | **Option** | **Value** | **Explanation** |
   | **Visible In Game** | False (Unchecked) | For this example, the Player Spawner is invisible. |

  Now that you have your room and devices set up, you can create the custom keycard.

## Create a Custom Item Entity Prefab

1. In the Content Browser, right-click to open the context menu, and select **Entity Prefab Definition**. This adds a new Scene Graph entity prefab to the Content Browser.

   [![](https://dev.epicgames.com/community/api/documentation/image/316d094c-44d0-4b6f-a78e-c92740a18d4f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/316d094c-44d0-4b6f-a78e-c92740a18d4f?resizing_type=fit)
2. Rename the prefab **Item\_Keycard**.

   [![Rename the new prefab entity Item_Keycard](https://dev.epicgames.com/community/api/documentation/image/b9680189-bc01-49d1-9bd3-3090776cd463?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9680189-bc01-49d1-9bd3-3090776cd463?resizing_type=fit)
3. Drag an instance of the new prefab into the world by dragging it into the viewport. This makes it selectable in the Outliner.
4. With the **Item\_Keycard** prefab selected, in the Details panel click **+Component**, and select **[item\_component](https://dev.epicgames.com/documentation/en-us/fortnite/item-component-in-fortnite)**. You can scroll through the list to find it, or type "item" in the search bar to limit the results and find it more quickly.

   [![Click +Component and add the item_component to the Item_Keycard prefab.](https://dev.epicgames.com/community/api/documentation/image/6c470da8-ff94-4ba6-8046-68e78232e2c8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6c470da8-ff94-4ba6-8046-68e78232e2c8?resizing_type=fit)
5. Click **+Component** again, and select **[item\_details\_component](https://dev.epicgames.com/documentation/en-us/fortnite/item-details-component-in-fortnite)**. This component stores text data about the item.

   [![](https://dev.epicgames.com/community/api/documentation/image/6a827ad9-3674-46c2-a938-6e99732e4423?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6a827ad9-3674-46c2-a938-6e99732e4423?resizing_type=fit)
6. The item\_details component has three property fields displayed in the Details panel: **Name**, **Description**, and **ShortDescription**. Enter a name, a description of the item, and a short descriptive label in these fields.

   [![Fill in the fields for the item_details_component](https://dev.epicgames.com/community/api/documentation/image/e3b51b9a-3bb8-4959-9b57-7c5e5e640fec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3b51b9a-3bb8-4959-9b57-7c5e5e640fec?resizing_type=fit)
7. Click **+Component again**, and select **[item\_icon\_component](https://dev.epicgames.com/documentation/en-us/fortnite/item-icon-component-in-fortnite)**.

   [![Click +Component and select the item_icon_component.](https://dev.epicgames.com/community/api/documentation/image/9d3b0186-b965-42ab-b13b-e5f90c940ff1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d3b0186-b965-42ab-b13b-e5f90c940ff1?resizing_type=fit)
8. In the Details panel, expand the **item\_icon\_component**. You need to select a 2D image, which will be the image displayed in the game's UI (for example, in the player inventory) to represent the item.

   1. Click the dropdown next to the **None** tile to open a context menu, and type part of the name of your image in the Search bar. In this example, we are using a PNG image named **T\_Icon\_Keycard.png**.
   2. Select the image in the search results.

      [![Locate and select the 2D image you want to use as the item icon.](https://dev.epicgames.com/community/api/documentation/image/3999cc78-890c-4685-856e-ef9c04c9e32d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3999cc78-890c-4685-856e-ef9c04c9e32d?resizing_type=fit)
9. Click **+Component** again, and select **mesh\_component**. For this example, select **Plane**.

   [![Click +Component and select mesh_component.](https://dev.epicgames.com/community/api/documentation/image/c72a0c5f-ddc0-41c3-9bf6-ea106fe0679c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c72a0c5f-ddc0-41c3-9bf6-ea106fe0679c?resizing_type=fit)

   This will add a plane mesh to your item. Depending on your settings, this plane may at first be very large. Follow these steps to resize the plane to be the size of a keycard.

   1. In the toolbar at the top of the viewport, select the **Scale** tool. You can also press the **R** key to change to the Scale tool.

      [![](https://dev.epicgames.com/community/api/documentation/image/7d9e2ad4-2496-4e2c-95e5-0c32cdf1e4d2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7d9e2ad4-2496-4e2c-95e5-0c32cdf1e4d2?resizing_type=fit)
   2. Further to the right from the Scale tool, click the dropdown for the **Preset Ratio for Scale** setting. Set it to **0.0625**. This allows you to reduce the plane to a very small size, to represent a keycard.

      [![](https://dev.epicgames.com/community/api/documentation/image/314ca08c-1cf1-415e-9b48-bdb506ab320b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/314ca08c-1cf1-415e-9b48-bdb506ab320b?resizing_type=fit)
10. Click **+Component** again, and select **[fort\_item\_pickup\_component](https://dev.epicgames.com/documentation/en-us/fortnite/fort-item-pickup-component-in-fortnite)**. Adding this component adds all the functionality of Fortnite items:

    - An animation for picking up an item, and an animation for dropping an item
    - An interaction to add an item to the inventory
    - A default item widget that displays when a player looks at the item
    - The item's mesh is disabled when an item is picked up
    - The item's mesh is enabled when an item is dropped

Now that you have a basic custom keycard prefab, you can create a custom Verse component that will make this item unique, so that it can be checked with Verse code to see if it opens a particular locked door.

## Create a Custom Verse Component

Normally, for a large project that has a lot of Verse code files, you would want to create a new Verse file for a custom component. To do that, you would follow these steps.

Because the example for this tutorial is small, the custom `keycard_item_component` has been defined in the Verse file for the custom `keycard_gameplay_device`. See the **[Write the Verse Code for Gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/create-a-custom-keycard-item-in-fortnite#write-the-verse-code-for-gameplay)** section for those steps.

1. With your new keycard item selected, in the Details panel click **+Component** and select **New Verse Component**. The **Create Verse Component** window opens.

   You can also create a Verse component by adding a new Verse file using Verse Explorer.
2. Under **Choose a Template**, select **Scene Graph Component**.
3. At the bottom, in the **Component Name** field, type **keycard\_item\_component**. Then click **Create**.
4. In the Details panel, click **+Component** and type "keycard" into the Search bar. You should see your new Verse component listed, so select it to add it to your custom keycard item.
5. In the menu bar, click **Verse > Verse Explorer**. Locate your new Verse component, right click it and select **Open in Visual Studio Code**.

## Write the Verse Code for Gameplay

Because you are creating a custom item (the keycard), and you want to trigger a device when the player has the custom keycard in their inventory, you need to create a Verse device to make that happen.

1. In the Menu Bar, go to **Verse > Verse Explorer**. Verse Explorer opens in a tab next to the Outliner.
2. In Verse Explorer, right-click on your project name and choose **Add new Verse file to project** to open the **Create Verse Script** window.
3. In the Create Verse Script window under **Choose a Template**, click **Verse Device** to select it. In the **Device Name** field, type **keycard\_gameplay\_device**. Then click **Create** to create the Verse file.
4. In Verse Explorer, double-click your new Verse device to open the file in Visual Studio (VS) Code. Make sure all of the following are added in the top lines of code.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Fortnite.com/Itemization }
   using { /Verse.org/Simulation }
   using { /Verse.org/SceneGraph }
   using { /Verse.org/Random }
   using { /UnrealEngine.com/Itemization }
   using { /UnrealEngine.com/Temporary/Diagnostics }
   ```
5. Next, add the code that defines your custom item component.

   ```verse
   # KEYCARD ITEM COMPONENT
   keycard_item_component := class(item_component) :
   ```
6. We can add a helper function that will enable us to find the root inventory of the target agent:

   ```verse
   # Helper function that gets the first descendant inventory component from an agent.
   # This will be the root inventory.
   GetAgentInventory(Agent:agent)<decides><transacts>:inventory_component=
       TragetInventory := (for (I : Agent.FindDescendantComponents(inventory_component)) { I })[0]
   ```
7. Next, define your custom Verse device as a subclass of `creative_device`. Under that, set up an editable property for the Volume and Lock devices. This allows you to select a particular instance of the Volume or Lock device in the editor (important since you have two Volume devices and two Lock devices).

   ```verse
   # DEVICE //// GAMEPLAY
   keycard_gameplay_device := class(creative_device) :

       # Use a volume_device to be able to check when a player approaches
       @editable
       VolumeDevice:?volume_device = false

       # The lock device is attached to a wall/door prop. This can be activated to lock/unlock the door it is attached to.
       @editable
       LockDevice:?lock_device = false
   ```
8. Now you'll use the query to see if the Volume device is present, and subscribe to the Volume device's **On Agent Enters** and **On Agent Exits** events.

   ```verse
   # Subscribe to the entry and exit events on the Volume to determine when a player/agent approaches.
       OnBegin<override>()<suspends>:void=
           if:
               TargetVolume := VolumeDevice?
           then:
               TargetVolume.AgentEntersEvent.Subscribe(OnAgentEntersEvent)
               TargetVolume.AgentExitsEvent.Subscribe(OnAgentExitsEvent)
   ```
9. You want to check the player's inventory to see if they have the custom keycard in their inventory. This is accomplished by checking for anything with the `keycard_item_component`. This code also requires that the `keycard_item_component` is present in order to open the Lock device.

   ```verse
       OnAgentEntersEvent(Agent:agent):void=

           # Get the inventory from the player that is entering.
           if(TargetInventory := GetAgentInventory[Agent]):

               # Use a helper function to search for items in the inventory. If the return array has  a length > 0, it contains the item with the required component to proceed.
               if(TargetInventory.FindComponentsOfType[keycard_item_component].Length > 0):

                   # If there is a valid lock_device, then this opens the door.
                   if(TargetDoorLock := LockDevice?):
                       TargetDoorLock.Open(Agent)
   ```
10. Lastly, if there is more than one player present, and one player has the keycard, this code will make sure the lock stays open. But if the player with the keycard exits the volume, the Lock is closed again.

    ```verse
    OnAgentExitsEvent(Agent:agent):void=

            # Start by assuming that no one has the required keycard_item_component.
            var AgentWithKeycardInVolume:logic = false

            if(TargetVolume := VolumeDevice?):
                # Get the Agents that are inside the volume_device as an array.
                for(TargetAgent:TargetVolume.GetAgentsInVolume()):

                    # Use the same check to see if any of the agents in the volume_device have a keycard_item_component.
                     for(item : GetAgentInventory[Agent].FindItems(), KeycardComponent := Item.GetComponent[keycard_item_component]):
                        set AgentWithKeycardInVolume = true
                # If no agents in the volume have the keycard, close the door using the lock_device. 
                if:
                    AgentWithKeycardInVolume = false
                    TargetDoorLock := LockDevice?
                then:
                    TargetDoorLock.Close(Agent)
    ```

Here is the full Verse code snippet.

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Itemization }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /UnrealEngine.com/Itemization }
using { /UnrealEngine.com/Temporary/Diagnostics }

# KEYCARD ITEM COMPONENT
keycard_item_component := class(item_component) :

# INVENTORY FUNCTIONS
GetAgentInventory(Agent:agent)<decides><transacts>:inventory_component=
    Inventory := (for (I : Agent.FindDescendantComponents(inventory_component)) { I })[0]

# DEVICE //// GAMEPLAY
keycard_gameplay_device := class(creative_device) :

    # We use a volume_device to be able to check when a player approaches
    @editable
    VolumeDevice:?volume_device = false

    # The lock device is attached to a wall/door prop. This can be activated to lock/unlock the door it is attached to.
    @editable
    LockDevice:?lock_device = false

    # We need to subscribe to the entry and exit events on the volume to determine when a player/agent approaches.
    OnBegin<override>()<suspends>:void=
        if:
            TargetVolume := VolumeDevice?
        then:
            TargetVolume.AgentEntersEvent.Subscribe(OnAgentEntersEvent)
            TargetVolume.AgentExitsEvent.Subscribe(OnAgentExitsEvent)

    OnAgentEntersEvent(Agent:agent):void=

        # We must get the inventory from the player that is entering.
        if(TargetInventory := GetAgentInventory[Agent]):

            # Use a helper function to search for items that have the required component (keycard_item_component).
            # If the return array has a length > 0, we know it contains an item with the required component.
            if(TargetInventory.FindComponentsOfType[keycard_item_component].Length > 0):

                # If we have a valid lock_device, then we can Open on the door.
                if(TargetDoorLock := LockDevice?):
                    TargetDoorLock.Open(Agent)

    OnAgentExitsEvent(Agent:agent):void=

        # We start by assuming that no one has the required keycard_item_component.
        var AgentWithKeycardInVolume:logic = false

        if(TargetVolume := VolumeDevice?):
            # We get the Agents inside the volume_device as an array.
            for(TargetAgent:TargetVolume.GetAgentsInVolume()):

                # We use the same check to see if any of the agents in the volume_device have a keycard_item_component.
                for(Item : GetAgentInventory[Agent].FindItems(), KeycardComponent := Item.GetComponent[keycard_item_component]):
                    set AgentWithKeycardInVolume = true
            # If no agents in the volume have the key, close the door via the lock_device.
            if:
                AgentWithKeycardInVolume = false
                TargetDoorLock := LockDevice?
            then:
                TargetDoorLock.Close(Agent)
```
