# Make a Physics Puzzle Dungeon

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/make-a-physics-puzzle-dungeon-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:59:43.536291

---

Follow this tutorial to build a puzzle room that uses the new experimental Physics feature. The object of this puzzle room is to clear the gap in the room and reach the exit. You can make this more complex, or even expand on it to create an entire puzzle dungeon.

## Setup Your Project

  Follow these steps to set up your project, enable Physics, and customize Island Settings.

1. Open UEFN and create a project from any island template. The **Blank** template is recommended if you want to ensure a flat area to work with.

   [![Create a new project](https://dev.epicgames.com/community/api/documentation/image/d3932cc9-de79-4dbc-8684-60045caf6251?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3932cc9-de79-4dbc-8684-60045caf6251?resizing_type=fit)

   Create a new project
2. From the tool bar, click **Project** and select **Project Settings**.

   [![Open Project Settings](https://dev.epicgames.com/community/api/documentation/image/4c298d1e-d9ac-466d-a79f-da48c5c5cf54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c298d1e-d9ac-466d-a79f-da48c5c5cf54?resizing_type=fit)

   Open Project Settings
3. Scroll down to the **Experimental Access** section, and check the box for **Physics**.

   [![Enable Physics in Experimental Access](https://dev.epicgames.com/community/api/documentation/image/fb9ef9d2-cb91-42a8-9fc2-22b97d5d08db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb9ef9d2-cb91-42a8-9fc2-22b97d5d08db?resizing_type=fit)

   Enable Physics in Experimental Access
4. In the Outliner, locate and select the Island Settings device to open the settings in the Detail panel.

   [![Island Settings](https://dev.epicgames.com/community/api/documentation/image/dffd1fdc-7dbd-498a-9ba4-594a81013e3d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dffd1fdc-7dbd-498a-9ba4-594a81013e3d?resizing_type=fit)

   Island Settings
5. Customize the following settings:

   1. Click the arrow to expand **Mode**, then expand **Structure**.
   2. Change the following settings as shown in the image and the table below.

      [![Mode - Structure Settings](https://dev.epicgames.com/community/api/documentation/image/b1a3968a-d977-47ac-9cea-85f21a09f559?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b1a3968a-d977-47ac-9cea-85f21a09f559?resizing_type=fit)

      Mode - Structure Settings

      | Setting | Value | Explanation |
      | --- | --- | --- |
      | **Max Players** | 1 | This tutorial is designed for a single player. |
      | **Teams** | Team Index: 1 | You want to set this to a Team Index so you can set up the Player Spawner correctly. |
      | **Team Size** | 1 | Since this is single-player, the team will only have one player. |

   3. Click the arrow to expand **Player**, then expand **Equipment**.
   4. Change the following settings as shown in the image and the table below.

      [![Player - Equipment Settings](https://dev.epicgames.com/community/api/documentation/image/1e2cdc09-5476-43f4-8005-51a7f195fb7e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e2cdc09-5476-43f4-8005-51a7f195fb7e?resizing_type=fit)

      Player - Equipment Settings

      | Setting | Value | Explanation |
      | --- | --- | --- |
      | **Start With Pickaxe** | Unchecked | The player doesn't need the pickaxe in this game. |
      | **Environment Damage** | Off | The player shouldn't be able to destroy or damage anything in the environment. |

## Build The Puzzle Room

First you need to build the room itself.

**Building Set Used**: Underworld

To find this set,
open the **Fortnite** folder in your project, and go to **Props > Underworld**. In this folder you'll find building pieces and props that you can use to build the puzzle room.

[![Find the Underworld Assets](https://dev.epicgames.com/community/api/documentation/image/be50e2c4-1ce4-4d13-bb19-cc5ee5236da4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/be50e2c4-1ce4-4d13-bb19-cc5ee5236da4?resizing_type=fit)

Find the Underworld Assets

Alternatively, you could launch a Fortnite session, and in Edit Mode open the **Creative Content Browser** by pressing **M** and then clicking the **Content** tab. Type "underworld" in the search bar. This will display the **Underworld Wall & Roof Gallery**, the **Underworld Floor & Stair Gallery**, the **Underworld Prop Gallery**, the **Underworld Nature Gallery**, and the **Styx Water Gallery**. You can select building pieces and props from the **Underworld Wall & Roof Gallery** and the **Underworld Floor & Stair Gallery**, and props from the **Underworld Prop Gallery**.

Use the UEFN Content Browser or the Creative method, whichever feels easier to you.
Refer to the diagrams below to see how the example was built.

| Side View | Top Down View |
| --- | --- |
| [Side View of Example](https://dev.epicgames.com/community/api/documentation/image/d160df38-ab33-41dd-9fc5-87867e6d370b?resizing_type=fit) | [Top Down View of Example](https://dev.epicgames.com/community/api/documentation/image/345df16d-ecfa-4ea6-ac7d-030d4fe3418e?resizing_type=fit) |

You can change the layout, but the following elements are needed for the puzzle gameplay:

- There should be one entrance and one exit.
- You need two platforms to hold the physics-enabled cubes.
- Place fences or walls to block access to the exit (only the bridge should enable the player to reach the exit door).
- There should be something to form a bridge, along with a way for the bridge to be knocked down (in the example, there is a building piece that will be pushing the bridge down).

Once the room is built, you will need a Player Spawner device so the player can spawn into your game. To find the Player Spawner, select **Fortnite > Devices** in the Content Browser. Type "player" in the search bar. Locate the Player Spawner, and drag it into your level.

You might want to build a hallway leading to the entrance door if you want the player to spawn outside the door. Otherwise, place the Player Spawner device in front of the entrance door.

Follow these steps to set up the Player Spawner device.

1. Select the **Player Spawner** device in the Outliner.
2. In the **Details** panel, click the arrow to expand **User Options**.
3. Next to **Player Team**, click the dropdown and select **Team Index**. Keep the default team index number as **1**.

## Add Physics-Enabled Props

Next you will add the physics-enabled props for the puzzle room.

1. In the Content Browser, select the **Fortnite** folder in your project.
2. In the search bar, type "cube". This will display all the cubes available.

   [![Find a cube in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/550f1b11-883f-4a2e-b4f1-2c14d402ddc6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/550f1b11-883f-4a2e-b4f1-2c14d402ddc6?resizing_type=fit)

   Find a cube in the Content Browser
3. Pick one of the colored cubes, such as the Dark Grey cube used in this example. Drag it from the Content Browser into your level.
4. With the cube selected, in the Details panel select the **StaticMeshComponent**.
5. In the **Transform** section, locate the **Scale** settings. Change the width and depth to **1.5**, and the height to **2**.

   [![Change the scale of the cube](https://dev.epicgames.com/community/api/documentation/image/3bdbdc1d-ba4a-4d55-9542-01bd0b05ea0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3bdbdc1d-ba4a-4d55-9542-01bd0b05ea0e?resizing_type=fit)

   Change the scale of the cube
6. In the **Materials** section, click the dropdown and type "stone" in the search field. Select **MI\_Coliseum\_Stone\_Bricks\_01**. This gives the block a stone brick appearance.

   [![Change the material of the cube](https://dev.epicgames.com/community/api/documentation/image/728b8bfd-5559-4357-9a39-39819fc1ab98?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/728b8bfd-5559-4357-9a39-39819fc1ab98?resizing_type=fit)

   Change the material of the cube
7. In the Details panel, click **Cube Dark Gray (Instance)**. Click the **+ Add** button, and type "physics" in the search bar. Select the **FortPhysics** component.

   [![Add the FortPhysics component to the cube](https://dev.epicgames.com/community/api/documentation/image/283abca2-ce2d-48d6-9e9c-95bbc806a7f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/283abca2-ce2d-48d6-9e9c-95bbc806a7f3?resizing_type=fit)

   Add the FortPhysics component to the cube
8. With the new FortPhysics component selected, change the following settings:

   | Option | Value |
   | --- | --- |
   | **Simulate Physics** | True (check the box) |
   | **Override Mass** | True (check the box) |
   | **Mass** | 75.0 |
   | **Enable Gravity** | True (check the box) |
   | **Start Awake** | True (check the box) |

9. In the Outliner, select the cube. Right-click and select **Edit > Rename**. Name this "Cube 1".
10. Once you have the first cube set up, copy the first cube and paste to create a second cube.
11. Follow steps 4 - 8 to make the second cube a physics-enabled object.
12. In the Outliner, select the second cube. Right-click and select Edit > Rename. Name this "Cube 2".

Objects placed in the editor are unique and can’t be spawned using devices. So once the cube is dropped, it can’t be reset to its original position unless the game restarts or a new round starts.

## Set Up the First Cube Platform

Next you will set up some environmental props that will hold the cube, then drop the cube when triggered.

**Devices used**:

- Prop Mover device x 1
- Switch device x 1

### Build the First Platform

Use a floor piece from the Underworld gallery for the platform. You can use other building pieces that look like rails or grooves, and attach them to the wall where the platform will move back and forth.

### Set Up the Cube 1 Switch Device

In this tutorial, a **Switch** device is used to trigger the Prop Mover device to move the platform and drop the cube.

While this tutorial uses a Switch, you can trigger the Prop Mover using a Trigger device, a Button device, a Volume device, or you can trigger the Prop Mover with an event from any other device.

Follow these steps to set up the Switch device.

1. In the Content Browser, select **Fortnite > Devices**. In the search bar, type "switch".
2. Drag the **Switch** device into your level.
3. In the Details panel, under the **Transform** section, change the **Scale** height, width and depth to **1.5**. This makes it more prominent and easier to see.

   [![Change the scale of the Switch device](https://dev.epicgames.com/community/api/documentation/image/5ea60a23-74e1-4471-965a-2a3cdd4afc3f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ea60a23-74e1-4471-965a-2a3cdd4afc3f?resizing_type=fit)

   Change the scale of the Switch device
4. Expand the **User Options** section. Set the **Device Model** option to **Ancient Lever**. This changes the appearance of the switch to something more appropriate to a dungeon. Leave the other options at their default values.

   [![Change the Device Model option](https://dev.epicgames.com/community/api/documentation/image/b6070b74-9573-4056-941d-a619b01e5c70?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6070b74-9573-4056-941d-a619b01e5c70?resizing_type=fit)

   Change the Device Model option
5. In the Outliner, right-click on the Switch device and select **Edit > Rename**. Name this "Cube 1 Switch".
6. In the Content Browser, locate the Underworld props again (as you did in Build the Room). Locate the **Brimstone Statue Pedestal A**. Drag the pedestal into your level. This is where you will place the switch. The pedestal lifts it off the ground, making it more prominent.

   [![Locate the Brimstone Statue Pedestal A prop](https://dev.epicgames.com/community/api/documentation/image/95bbbaa8-b328-4b09-bbef-72146c62d654?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95bbbaa8-b328-4b09-bbef-72146c62d654?resizing_type=fit)

   Locate the Brimstone Statue Pedestal A prop
7. With the pedestal selected, locate the Transform section in the Details panel. Change the **Scale** width and depth to **0.75**, and the height to **1.5**. This changes the size of the pedestal to better fit the size of the switch.

While this tutorial instructs you to set specific values in the Transform settings, you can also scale meshes and devices using the Transform widget in the Viewport.

### Set Up the Cube 1 Prop Mover

When you have the first cube's platform built, you can add a Prop Mover device to move the platform.

1. In the Content Browser, select the **Fortnite > Devices** folder. In the search bar, type "prop".
2. Drag the Prop Mover device into your level.
   You want to place the device so it penetrates the platform you want to move.

   [![Prop Mover intersecting with cube with directional arrow](https://dev.epicgames.com/community/api/documentation/image/4c807e69-5d4b-462c-a2c8-0080f34f7dcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c807e69-5d4b-462c-a2c8-0080f34f7dcd?resizing_type=fit)

   Prop Mover penetrating cube with directional arrow

   In Edit mode, there is a transparent arrow that indicates which direction the Prop Mover is facing (this is the direction the prop will move). Make sure the arrow is pointing in the direction you want the platform to move.
3. With the Prop Mover device selected, find the **User Options** in the Details panel. Adjust the following options.

   [![Cube 1 Prop Mover User Options](https://dev.epicgames.com/community/api/documentation/image/bb23c5d6-cf93-4217-906e-8d45d48a7c4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bb23c5d6-cf93-4217-906e-8d45d48a7c4e?resizing_type=fit)

   Cube 1 Prop Mover User Options

   | Option | Value |
   | --- | --- |
   | **Distance** | 20.0 |
   | **Speed** | 5.0 |
   | **Should Move From Start** | False (uncheck box) |

4. Expand the **Advanced Options** section. Adjust the following options. Any option not listed can be left at the default value.

   [![Cube 1 Prop Mover Advanced Options](https://dev.epicgames.com/community/api/documentation/image/fa4a2189-4ec2-420a-aadd-f55bdb4c2b6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa4a2189-4ec2-420a-aadd-f55bdb4c2b6e?resizing_type=fit)

   Cube 1 Prop Mover Advanced Options

   | Option | Value |
   | --- | --- |
   | **On AI Collision Behavior** | Continue |
   | **AI Damage on Collision** | 0.0 |
   | **On Player Collision Behavior** | Continue |
   | **Player Damage on Collision** | 0.0 |
   | **On Prop Collision Behavior** | Continue |
   | **Prop Damage on Collision** | 0.0 |

5. In the Outliner, select the Prop Mover. Right-click and select **Edit > Rename**. Name this "Cube 1 Prop Mover".

### Connect the Switch Device to the Prop Mover

Next you will connect the Switch Device to the Prop Mover device, so that turning the switch on will move the platform and drop the cube.

1. Select the Prop Mover device. In the Details panel, expand the **User Options - Functions** section.
2. Next to the **Start** function, click the **+ (plus)** sign to add an array element.
3. Click the first dropdown, which opens a list of objects in your level. Select the **Cube 1 Switch** from the list. If your list is very long, you can type "switch" in the search bar to find it more easily.
4. Click the second dropdown to select a function. Select **On Turned On**.

   If you select the Switch device in your level, and expand the **User Options - Events** section, you will see that the **On Turned On** event already has the Prop Mover's **Start** function bound to it.

This connection causes the platform to move when the switch is turned on, which drops the cube into the large open area. Then the player can jump down into that area, and use the cube to jump up to the other side.

Place one of the physics cubes on the moving platform.

## Set Up the Second Cube Platform

Now you will build the second cube platform, and add a Volume device that will trigger the platform to move and drop the second cube.

**Devices used**:

- Volume device x 1
- Switch device x 1
- Prop Mover device x 1

### Build the Second Platform

Across the room from the entrance, in the upper right corner of the room, build a second platform similar to the first cube's platform. This will also be a moving platform that will drop the second cube.

In the example screenshots, there are visual elements that guide the eye to a depression in the floor some distance from where the cube drops. The Volume device will sit in the depression, so you want the location to be distinguishable so the player will be able to figure out what action is needed. When the cube is pushed into the depression, it will enter the Volume and trigger a bridge prop to fall, giving the player a path to the room's exit.

### Set Up the Second Switch Device

This switch will move the platform to drop the second cube.

1. Select the Cube 1 Switch in your level.
2. Copy-paste to create a second Switch device.
3. In the Outliner, right-click on the Switch device and select Edit > Rename. Name this "Cube 2 Switch".
4. Resize this Switch and place it on a resized pedestal, like you did for the Cube 1 Switch. Put the pedestal and switch between the second platform location and the location for the Volume.

### Set Up the Second Prop Mover

When you have the cube's platform built, you can add the Prop Mover device to move the platform.

1. Select the Cube 1 Prop Mover, in the Outliner or in your level.
2. Copy-paste the device to create a second Prop Mover.
3. In the Outliner, right-click on the second Prop Mover and select **Edit > Rename**. Name this "Cube 2 Prop Mover".
4. With the Cube 2 Prop Mover selected, expand the **User Options** in the Details panel. Adjust the options to the same settings as Cube 1.

### Connect the Switch Device to the Prop Mover

Like the first switch and prop mover, you need to use event binding to connect the two devices.

1. Select the Prop Mover device. In the Details panel, expand the **User Options - Functions** section.
2. Next to the **Start** function, you should see an array element already added. If not, click the **+ (plus)** sign to add one.
3. Click the first dropdown, which opens a list of actors in your level. Select the **Cube 2 Switch** device.
4. Click the second dropdown to select a function. Select **On Turned On**.

Now that your cube platform is set up, with the devices configured, you need to add the Volume device. The Volume device defines a space, and can trigger event binding when an object or player enters or exits the space.

### Set Up the Volume Device

Next you will set up a Volume Device and place it on the depression in the floor, where the player needs to put the cube to trigger the bridge.

1. Locate the Volume device the same way you located the Prop Mover and Switch devices.
2. Drag the Volume device into your level, and place it on top of the depression in the floor.
3. With the Volume device selected, expand the **User Options** in the Details panel. Adjust the following options.

   [![User Options for Volume Device](https://dev.epicgames.com/community/api/documentation/image/ce9a7351-a35e-48a8-9d54-6ad5dd4f5eca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce9a7351-a35e-48a8-9d54-6ad5dd4f5eca?resizing_type=fit)

   User Options for Volume Device

   | Option | Value |
   | --- | --- |
   | **Visible in Game** | False (uncheck the box) |
   | **Player Events Enabled** | True (check the box) |
   | **Physics Events Enabled** | True (check the box) |

In the next step, you will set up the bridge prop that will drop when the second cube is put in the depression in the floor.

## Set Up the Bridge Prop

The final piece to set up for the puzzle room is the bridge prop, which drops down when Cube 2 is placed in the space defined by the Volume.

**Props needed**:

- Cube scaled to be tall and thin (for the bridge)
- A pillar (to push the bridge into place)

You can find pillars in the Underworld building and props–this example uses "Brimstone Pillar C A Mid". Use the illustration below as guidance for building and placing the pillar, along with any supporting pieces you want to use to make it look believable as a mechanism.

[![Example placement of bridge and pillar](https://dev.epicgames.com/community/api/documentation/image/b850cc63-99f5-4d85-9aa5-1b9abc7bc02b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b850cc63-99f5-4d85-9aa5-1b9abc7bc02b?resizing_type=fit)

Example placement of bridge and pillar

### Set Up the Bridge Prop

For this example, you will copy the physics cube and rescale it to be taller and thinner. This prop will be pushed by a horizontal moving pillar. It will fall across the large open area in the middle of the room. Then the player can use the bridge to access the room's exit. Follow these steps to set up the props.

1. In your level, select the first or second cube and copy-paste to create a third cube.
2. In the Outliner, select the third cube. Right-click and select **Edit > Rename**. Name this "Bridge".
3. In the Details panel, select the StaticMeshComponent. In the **Transform** section, locate the **Scale** settings. Change the depth to .25, and the height to 10. Leave the width the same.

   The material you used for the cubes will be stretched and distorted with these dimensions, so you might want to change it to a different material.
4. This prop already has the FortPhysics component, but it needs different settings than the cubes.
   Select the FortPhysics component on the bridge, then adjust the following settings.

   [![Bridge Physics User Options](https://dev.epicgames.com/community/api/documentation/image/eac0c7a2-0aa3-41a8-89e5-db0e818703cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eac0c7a2-0aa3-41a8-89e5-db0e818703cc?resizing_type=fit)

   Bridge Physics User Options

   | Option | Value |
   | --- | --- |
   | **Mass** | 500 |
   | **Linear Damping** | 0.5 |
   | **Angular Damping** | 0.5 |

   Depending on how you built your room, you may need to adjust these values to fit the measurements of the large open space.
5. Place the Bridge prop vertically at the edge of the open space, positioned so the pillar will hit it when it moves.

Next you will set up the pillar to move when triggered, pushing the bridge down.

### Set Up the Pillar and Prop Mover

Devices used:

- Switch device x 1
- Prop Mover device x 1

Follow these steps to add and configure a Prop Mover that moves the pillar.

1. Select the Cube 1 Prop Mover, in the Outliner or in your level.
2. Copy-paste the device to create a third Prop Mover.
3. In the Outliner, right-click on the third Prop Mover and select Edit > Rename. Name this "Pillar Prop Mover".
4. Position the prop mover on the pillar, remembering that the holographic arrow indicates which direction the prop will be moving. You want it to move toward the bridge prop.
5. With the Pillar Prop Mover device selected, find the **User Options** in the Details panel. Adjust the following options.

   [![Pillar Prop Mover User Options](https://dev.epicgames.com/community/api/documentation/image/e8d48e9e-5a54-403c-97de-92cf14a4918d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8d48e9e-5a54-403c-97de-92cf14a4918d?resizing_type=fit)

   Pillar Prop Mover User Options

   | Option | Value |
   | --- | --- |
   | **Distance** | 4.0 |
   | **Speed** | 1.0 |
   | **Should Move From Start** | False (uncheck the box) |
   | **Allow Reverse Past Start** | False (uncheck the box) |

6. Expand the **Advanced Options** section. Adjust the following options.

   [![Pillar Prop Mover Advanced Options](https://dev.epicgames.com/community/api/documentation/image/02e2c43e-ae09-44ca-b5c1-c0ea7b87bc08?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02e2c43e-ae09-44ca-b5c1-c0ea7b87bc08?resizing_type=fit)

   Pillar Prop Mover Advanced Options

   | Option | Value |
   | --- | --- |
   | **Enabled During Phase** | Gameplay Only |
   | **On AI Collision Behavior** | Stop |
   | **AI Damage on Collision** | 0.0 |
   | **On Player Collision Behavior** | Stop |
   | **Player Damage on Collision** | 0.0 |
   | **On Prop Collision Behavior** | Continue |
   | **Prop Damage on Collision** | 0.0 |

7. In the Details panel, expand the **User Options - Functions** section.

   [![Pillar Prop Mover Functions](https://dev.epicgames.com/community/api/documentation/image/a18b8414-df9c-461a-96be-1babef22d5f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a18b8414-df9c-461a-96be-1babef22d5f7?resizing_type=fit)

   Pillar Prop Mover Functions
8. Next to the **Start** function, you should see an array element already added. If not, click the **+ (plus)** sign to add one.
9. Click the first dropdown, which opens a list of actors in your level. Select the **Volume** device.
10. Click the second dropdown to select a function. Select **On Physics Enter**. This triggers the pillar to move when Cube 2 drops into the Volume's space.

Now, when the player moves the cube into the space defined by the Volume device, the pillar will move forward and push the bridge prop. The bridge prop will fall across the large open space, and the player will be able to reach the exit.

Now that you have the puzzles all set up, you can use more props and devices to decorate and add atmosphere to fit the theme.

![Final Shot](https://dev.epicgames.com/community/api/documentation/image/3bc9299a-f912-4d58-a2d4-16570eeb1cf8?resizing_type=fit)

Final Shot
