# Button Device Design Examples

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/button-device-design-examples-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:03:52.741399

---

A **button** is a device you can use to trigger other devices when a player pushes the button.

Here are a couple of examples of how to use Button devices to build gameplay.

- [Door Hack](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-device-design-examples-in-fortnite-creative)
- [Team Buttons](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-device-design-examples-in-fortnite-creative)

## Door Hack

Use a button to provide player interaction with a prop by increasing the radius of the prop and adding text for player instruction.

### Devices Used

- 1 x **Button**
- 1 x [Lock](https://dev.epicgames.com/documentation/en-us/fortnite/using-lock-devices-in-fortnite-creative)

### Build It Yourself

1. Place a Button device over the prop you want to use. In this example, it is a computer on a desk but you can use it with any prop.
2. Customize the button to the following settings:

   [![Door Hack Computer Button](https://dev.epicgames.com/community/api/documentation/image/cb39df26-031b-4a6f-a810-0abfb426d4b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cb39df26-031b-4a6f-a810-0abfb426d4b5?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Interact Time | 5.0 Seconds | Time needed to interact with the button before it activates. |
   | Trigger Sound | Disabled | No sound effects are played when the button is activated. |
   | Interaction Text | Hack Door... | The UI text displayed when the player looks at and interacts with the button. In this case, the text implies the computer is being used to hack. |
   | Visible During Game | No | The button is not visible during gameplay. |
   | Interaction Radius | 1.0 Meters | The distance from the button the player can be while still bringing up the interaction prompt. |
3. Place a door in another spot in the room, then place a **Lock** device adjacent to the door, making sure the light turns blue to indicate it is paired with the door.
4. Customize it to the following settings:

   [![Door Hack Lock](https://dev.epicgames.com/community/api/documentation/image/5a4cbbaf-73e4-4d81-a5ac-26f887a5927e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a4cbbaf-73e4-4d81-a5ac-26f887a5927e?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Visible During Game | Off | The lock is not visible during gameplay. |
5. Set the button's direct event bindings to the following:

   [![Door Hack Computer Events](https://dev.epicgames.com/community/api/documentation/image/36f0ad89-41a6-4272-b13c-8faed4f2e856?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36f0ad89-41a6-4272-b13c-8faed4f2e856?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Interact Send Event To | LockDevice | Open | When the player interacts with the button, the door that the lock is attached to will open. |

Here's an overview of how devices communicate in this Design Example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **LockDevice** | Open | **Button** | On Interact Send Event To | When the player interacts with the button, the door that the lock is attached to will open. |

You now have the basic functionality for players interacting with props using the button.

There are many ways to set up interactive props using the Button device. This device, when invisible, has a highly customizable area to expand interaction coverage, and can be used both narratively and for immersion, or for basic gameplay. [HUD Messages](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) can play in response to player interaction, [Teleporters](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative) can be activated, or [**Billboards**](using-billboard-devices-in-fortnite-creative) rendered visible, providing a lot of flexibility for your game design.

## Team Buttons

You can also place buttons that can only be activated by specific teams.

### Devices Used

- 2 x **Buttons**
- 2 x [Class Selectors](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative)
- 2 x [HUD Messages](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)

### Build It Yourself

1. Place a **Button** device for Team 1. Customize it to the following settings:

   [![Team Button 1](https://dev.epicgames.com/community/api/documentation/image/6276eefb-d29a-49e2-91dd-a8950059e97d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6276eefb-d29a-49e2-91dd-a8950059e97d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Interact Time | 3.0 Seconds | Time needed to interact with the button before it activates. |
   | Activating Team | Team 1 | Only members of Team 1 can interact with this button. |
   | Trigger Sound | Disabled | No sound effects play when the button is activated. |
2. Duplicate the button and place a second one adjacent. Change the **Activating Team** setting on the second button to **Team 2**.
3. Near the button, place a **Class Selector**. Customize it to the following settings:

   [![Class Selector 1](https://dev.epicgames.com/community/api/documentation/image/269abc09-f424-401e-807c-17cc3465b39d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/269abc09-f424-401e-807c-17cc3465b39d?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Team To Switch To | Team 1 | When activated, it will switch the player to this team. |
   | Time To Switch | Instant | Delay between entering the Class Selector and switching. |
4. Copy the Class Selector, and place it near the second button. Change the **Team to Switch To** setting on the second Class Selector to **Team 2**.
5. Anywhere on the level, place a **HUD Message**. Customize it to the following settings:

   [![HUD Device 1](https://dev.epicgames.com/community/api/documentation/image/872e5e0f-50e3-4cda-9c8a-5faadde85ba3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/872e5e0f-50e3-4cda-9c8a-5faadde85ba3?resizing_type=fit)

   | Option | Value | Description |
   | --- | --- | --- |
   | Message | Team 1 Button activated! | The message displayed when the Team 1 Button is activated successfully. |
   | Time From Round Start | Off | The message is not automatically played after the start of the round. |
   | Message Priority | Critical | The message will overwrite any other HUD Message that is already up. |
   | Placement | Top Center | The location on the HUD where the message shows up when the device is activated. |
6. Copy the HUD Message device, then place a second device adjacent to the first. Change the **Message** setting on the second HUD Device to **Team 2 Button Activated!**
7. Set the Team 1 Button direct event bindings to the following:

   [![Button Events](https://dev.epicgames.com/community/api/documentation/image/bbf03e60-4deb-4d1d-baab-777d7c068daf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbf03e60-4deb-4d1d-baab-777d7c068daf?resizing_type=fit)

   | Function | Device | Event | Description |
   | --- | --- | --- | --- |
   | On Interact Send Event To | Team1HUDMessage | Show | When the player interacts with the button, the corresponding HUD Message will appear. |
8. Repeat step 7 with the Team 2 Button and corresponding HUD device.

Here's an overview of how devices communicate in this design example:

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Team1 HUD Message** | Show | **Team1 Button** | On Interact Send Event To | When the player interacts with the button, the corresponding HUD Message will appear. |
| **Team2 HUD Message** | Show | **Team2 Button** | On Interact Send Event To | When the player interacts with the button, the corresponding HUD Message will appear. |

You now have the basic structure for using team-restricted buttons to communicate.

Restricting buttons to specific classes or teams is a way to create avenues that are gated behind specific individuals or teams. Doors can be locked except when a button is pressed by a team member, certain classes can cause active defenses to appear, such as hostile sentries, or cause temporary walls and other shifted geometry to change the dynamics of the map in response to gameplay. They can also be used for teleporting to new areas, or equipping new, location-optimized loadouts.
