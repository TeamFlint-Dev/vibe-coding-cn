# Voting Group and Voting Options Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite>
> **爬取时间**: 2025-12-26T23:46:38.221771

---

Use the **Voting Group** and **Voting Options** devices to create a voting system for players in your game. These two devices work together, and you cannot use them individually. You need one Voting Options device for each available option a player can choose.

Some ways you can use this:

- Create polls to get direct player feedback.
- In games where players must identify an infiltrator, set up a vote for players to decide who the spy or traitor is.
- Create an adversarial game where players periodically vote for who should stay in and who should be eliminated.

For help on how to find the Voting Group and Voting Options devices, see [Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite).

If you're using multiple copies of a device on an island, it can be useful to rename them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the [Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative).

## Using the Device

1. Decide what you want your players to vote on.
2. Place one **Voting Group** device for each vote you want players to participate in.
3. Name each Voting Group with a unique name or phrase in the Voting Group option. You can use the same name for that device.

   For example, if the vote is for who is on what team, you could use **Vote for Teams** as the Voting Group option value; then rename that Voting Group device with **Vote for Teams**.
4. Place a Voting Options device for each choice players have in a single vote (a minimum of two), and link the Voting Options devices to their specific Voting Group device.
5. Use [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative) devices or [Billboards](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) to give players instructions or more information about the vote.
6. Use the **Time Limit** option on the Voting Group device to limit the amount of time players have to make their decision and place their vote.

   If you are using the **Time Limit** option on the Voting Group device, the vote will end automatically when the time you set has passed. But you can also end the voting period using event binding or Verse.
7. Alternatively, use other devices to trigger the start of the voting period. Some examples of how you can do this include:

   - Place a **Trigger** device where a player will walk over to start the vote.
   - Define a space with a **Volume** device so that the voting period starts when a player enters that space.
   - Use a **Button** device to give players agency in when to start the vote.
8. Decide if you want gameplay events occur based on the results of the vote, and set up devices or write Verse code for that if needed.

## Voting Group Device Options

This section details the Voting Group **device options** (in Creative) or **user options** (in UEFN).

- To customize options in Creative, approach a device and press **E** to open the **Customize** panel.
- To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel, in the **User Options > Advanced** section.

Default values are **bold**.

You can configure the Voting Group device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Voting Group** | **Default**, Enter text | Enter a name to identify the voting group. The **Voting Options** devices for this group need to have this name in their **Voting Group** device option. |
| **Max Votes Per Player** | **1**, Pick or enter a number | Determines the number of times one player can vote. If this is set to a number greater than **1**, a player can vote for multiple options (but cannot switch a vote once cast). If the **Allow Vote Switching** option is set to **On** and this option is set to **1**, a player **can** change their vote after they have cast it. |
| **Time Limit** | **0**, Pick or enter an amount | Sets a time limit for the voting period. The voting period ends when the set amount of time passes. Ending the voting period with event binding or Verse will override this option's value.  Setting the value to **0** means that to end the vote, you must use event binding or Verse to end the voting period. |
| **Allow Vote Switching** | - **Creative**: On, **Off** - **UEFN**: True (checked), **False (unchecked)** | Determines whether a player can change their vote. |
| **Custom Widget** | Select **class of User Widget** to display | The (optional) widget to display. You can bind your widget to **Device - Voting Group ViewModel** and include sub-widgets bound to **Device - Voting Option ViewModel** to update the widget  automatically from this device. |

## Voting Options Device Options

This section details the Voting Options device options (in Creative) or user options (in UEFN).

- To customize options in Creative,  approach a device and press **E** to open the **Customize** panel.
- To customize options in UEFN, select the device in your viewport or in the Outliner. Options for this device are found in the **Details** panel, in the **User Options > Advanced** section.

Default values are **bold**.

You can configure the Voting Group device with the following options.

| Option | Values | Description |
| --- | --- | --- |
| **Voting Group** | **Default**, Enter text | This links this Voting Options device to its corresponding **Voting Group** device.  The text in this field **must** match the text used in the **Voting Group** option in the associated **Voting Group** device. |
| **Voting Option Text** | Enter text | Enter a name for this voting option. It should be clear to the player what choice this option represents. |

## Event Binding

Following are the functions and events for this device.

- In **Creative**, the **functions** and **events** are customized in the **Customize** panel (like other device options).
- In **UEFN**, you can find them in the **Details** panel under **User Options - Functions** and **User Options - Events**.

While you can set both functions and events in Creative (or in a Live Edit session in UEFN), you **can only set functions in UEFN**, and **events are read-only**.

## Functions

A function listens for an event on a device, then performs an action.

**In Creative**, use the following steps to set a function.

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Click **Select Event** to bind the device to an event that will trigger the function for the device.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

**In UEFN**, use the following steps to set a function.

1. With a device selected, locate the **User Options - Functions** section in the **Details** panel, and expand it.
2. For any function, click the **+ (plus)** icon to add an array element.
3. Click the first dropdown, and select a device. If you have a lot of devices, you can use the search bar to find a device more easily.
4. Click the second dropdown, and select the event you want to bind to this function.

### Voting Group Device Functions

| Option | Description |
| --- | --- |
| **Begin Vote When Receiving From** | Begins the voting period when an event occurs. |
| **End Vote When Receiving From** | Ends the voting period when an event occurs. |

### Voting Options Device Functions

|  |  |
| --- | --- |
| **Enable When Receiving From** | Enables this device when an event occurs. When the device is enabled, this option can be selected if the associated **Voting Group** device is active and the player is able to vote. |
| **Disable When Receiving From** | Disables this device when an event occurs. When the device is disabled, this option cannot receive any votes. |
| **Cast Vote When Receiving From** | Adds a vote for this option when an event occurs. |
| **Rescind Vote When Receiving From** | When an event occurs, subtracts a vote for this option if the instigating player voted for this option. |

## Events

An event tells another device when to perform a function.

Events in UEFN are **read-only**. They will be set automatically when you set a function on a device that binds to an event on this device.

**In Creative, follow these steps to set an event:**

1. For any function, click the option, then **Select Device** to access and select from the **Device** dropdown menu.
2. Click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

### Voting Group Device Events

| Option | Description |
| --- | --- |
| **On Vote Begin Send Event To** | When the voting period starts, an event is sent to the bound device. |
| **On Vote End Send Event To** | When the voting period ends, an event is sent to the bound device. |
| **On Vote Tied Send Event To** | When the vote is tied, an event is sent to the bound device. |

### Voting Options Device Events

| Option | Description |
| --- | --- |
| **On Voting Option Selected Send Event To** | When a voting option is chosen by a player, an event is sent to the bound device. |
| **On Vote Completed Winner Send Event To** | When the voting period ends, if this option wins the vote an event is sent to the bound device. |
| **On Voting Option Rescinded Send Event To** | When a player rescinds their vote for this option, an event is sent to the bound device. This event is also triggered if a player switches their vote to another option. |
| **On Failed to Vote Send Event To** | When a player tries to vote, but the vote fails for any reason, an event is sent to the bound device. |
