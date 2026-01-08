# Using the Conversation Device

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/conversation-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T07:11:01.731689

---

Want to create engaging dialogue where players make choices that have in-game consequences, purchase items, or receive rewards for completing NPC tasks with the Conversation device? These conversations can be immersive, informative, and entertaining, driving the game’s story forward by providing players with much needed resources and knowledge.

[![Conversation device icon](https://dev.epicgames.com/community/api/documentation/image/785b61c4-0b74-4f3f-a0c1-c1ee79ec0d33?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/785b61c4-0b74-4f3f-a0c1-c1ee79ec0d33?resizing_type=fit)

The [Pop-Up Dialog](https://dev.epicgames.com/documentation/fortnite-creative/using-popup-dialog-devices-in-fortnite-creative) device shares core functionality with the Conversation device. You can use both devices to:

- Display messages or instructions for the player.
- Display background information for objectives (when used with a Tracker device).
- Connect to invisible Class Selector devices and allow players to choose their class.
- Create dialogues between the player and NPCs.

With the **Conversation** device, you can add layers to conversations, where players make choices that trigger events and change the outcomes of their game.

n Unreal Editor for Fortnite (UEFN), use the Conversation device to:

- Create a conversation tree.
- Make branching dialogues.
- Trigger other devices using events in conversation trees.

## Finding and Using the Device

The Conversation device can be found in the **Fortnite > Devices > UI** folder. Drag the device out of the Content Browser and place it in the viewport beside either an [NPC Spawner](using-npc-spawner-devices-in-unreal-editor-for-fortnite) or [Character](https://dev.epicgames.com/documentation/fortnite-creative/using-character-devices-in-fortnite-creative) device.

The general workflow for this device is as follows:

1. Place the Conversation device in the level and set up the assets needed to use the device.
2. Use the **Initiate Conversation** function with event binding, or use Verse to call **InitiateConversation,** from another device (such as a [Trigger](https://dev.epicgames.com/documentation/fortnite-creative/using-trigger-devices-in-fortnite-creative) device).
3. Start the game and interact with the device to initiate a conversation.
4. If you have set up your device correctly, a conversation will start.

## Setting Up the Device

1. To create a **Conversation Graph** asset, right-click inside the **Content Browser** and select **Gameplay > Conversation Bank**.

   Alternatively, you can create a new Conversation Graph asset inside the Conversation field of the **Conversation** device.

   [![Conversation Graph asset](https://dev.epicgames.com/community/api/documentation/image/cec48663-d262-43cc-b561-f4be8c9bc424?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cec48663-d262-43cc-b561-f4be8c9bc424?resizing_type=fit)
2. Double-click the newly-created asset to open the Conversation Graph.
3. Create the conversation by adding **nodes**. Start by placing a **Default Entry Point** node. This is where all conversations start.

   [![Conversation nodes](https://dev.epicgames.com/community/api/documentation/image/2db46c97-6345-44ac-8ea0-5d88ed31aef8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2db46c97-6345-44ac-8ea0-5d88ed31aef8?resizing_type=fit)

   For more information on creating conversations, see the [Custom Conversation UI](https://dev.epicgames.com/documentation/en-us/fortnite/custom-conversation-ui-in-unreal-editor-for-fortnite) page.
4. Drag a **Conversation** device into your level.
5. Add the conversation you created into the **Conversation** field.

   [![Conversation add](https://dev.epicgames.com/community/api/documentation/image/da3b81bb-bc9c-4697-ba3f-73b233e7258a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da3b81bb-bc9c-4697-ba3f-73b233e7258a?resizing_type=fit)

## Device Basics

Once the Conversation device is in the viewport, you can begin building a conversation graph and designing the conversation’s basic user interface (UI) with the tools native to the device.

The main options in the device provide a way to create a basic conversation using three basic conversation options:

- **Conversation Type** - Determines the style of the UI displayed when the conversation is active. See [Conversation Types](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-conversation-device-in-unreal-editor-for-fortnite) for more information.
- **Conversation Graph** - The device uses this asset to run the conversation.
- **Speaker Name** - Displays the speaker’s name during conversations. If this is left blank, then no name will appear on the screen.

### Basic UI Style

When the **Conversation Type** is set to **Box**, the basic UI design out of the box uses the following design options:

- **Title Text Color** - The color of the title in the box.
- **Title Border** - The border color of the title.
- **Title Background Color** - The color of the title background.
- **Body Text Color** - The color of the body text in the box.
- **Body Background Color** - The color of the background of the text.
- **Button Background Color** - The color of the button’s background in the box.
- **Button Hover Color** - The color of the button when hovered over.

### Basic Conversation Functions

There are five conversation functions:

- **Initiate Conversation** - Forces the associated conversation to start for the player triggering this event.
- **Exit Conversation** - Forces the current conversation to end for the player triggering this event.
- **Exit All Conversations** - Leaves all conversation on receiving a signal from the selected channel.
- **Enable** - Enables the device on receiving a signal from the selected channel.
- **Disable** - Disables the device on receiving a signal from the selected channel.
- **Hide Conversation** - Hides the conversation on receiving a signal from the selected channel. Responses cannot be selected when a conversation is hidden.
- **Show Conversation** - Shows the conversation upon receiving a signal from the selected channel is itis hidden.

### Basic Conversation Events

The following are Conversation device events:

- **On Conversation Started** - Broadcasts a message when a new conversation is started.
- **On Conversation Ended** - Broadcasts this event for the player when the conversation ends.
- **On Conversation Cancelled** - Broadcasts this event for a player when forced to exit a conversation early by Exit Conversation or Exit All Conversations being called.
- **On Any Conversation Event** - Broadcasts a message when any numbered Event from the associated Conversation Graph is triggered during a conversation.
- **On Conversation Event One** - Broadcasts a message when an Event from the associated Conversation Graph is triggered for Event One.
- **On Conversation Event Two** - See On Conversation Event One.
- **On Conversation Event Three** - See On Conversation Event One.
- **On Conversation Event Four** - See On Conversation Event One.
- **On Conversation Event Five** - See On Conversation Event One.
- **On Conversation Event Six** - See On Conversation Event One.
- **On Conversation Event Seven** - See On Conversation Event One.
- **On Conversation Event Eight** - See On Conversation Event One.
- **On Conversation Event Nine** - See On Conversation Event One.
- **On Conversation Event Ten** - See On Conversation Event One.

For more information, see:

- [Creating Conversations](https://dev.epicgames.com/documentation/en-us/fortnite/creating-conversations-in-unreal-editor-for-fortnite)
- [Custom Conversation UI](https://dev.epicgames.com/documentation/en-us/fortnite/custom-conversation-ui-in-unreal-editor-for-fortnite)

## Conversation Types

There are three types of conversation modals: **radial**, **box**, and **custom**. All modals display choices and trigger events.

Keep conversation modals consistent in your game. If you select radial for one, all conversation modals should also be radial throughout the project.

### Radial

The **radial** modal displays the conversation UI and choices on a wheel. This style is used in Fortnite Battle Royale NPC interactions.

If your game doesn’t involve complex conversations or a complicated backstory, the radial modal is a great way to offer items and make in-game transactions.

[![Conversation radial](https://dev.epicgames.com/community/api/documentation/image/53049274-b51e-4ea7-ae40-915294881632?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53049274-b51e-4ea7-ae40-915294881632?resizing_type=fit)

### Box

The box modal provides ample space for more involved and complicated storylines. Think about what players will be reading and make the reading experience as pleasant as possible. Role playing games, visual novels, and many more game genres use box UI for interactions.

The **box** modal has three different **Conversation Type Box** styles:

- **Standard** - The default Box type.
- **Single Speaker** - A customizable box that shows an icon of the speaker.
- **Two Speakers** - A customizable box that shows an icon of the speaker.

#### Standard

The **Standard Box Type** displays NPC conversations in a box with the player’s choice list next to the Speech box.

[![Conversation box](https://dev.epicgames.com/community/api/documentation/image/d607953f-b962-484c-89fb-fad745714fbc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d607953f-b962-484c-89fb-fad745714fbc?resizing_type=fit)

#### Single Speaker

The **Single Speaker Box Type** displays the speaker's name and text in a box with response buttons to the right of the  speech box. Unlike the default Standard option, you can use the ****Conversation Material******option******to use a UI material to represent the speaker above the speech box.

[![Single Speaker Conversation type provides a way to add an icon to identify the speaker.](https://dev.epicgames.com/community/api/documentation/image/b4e07f06-f7ef-4745-988d-9e69f73ae751?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b4e07f06-f7ef-4745-988d-9e69f73ae751?resizing_type=fit)

Click image to enlarge.

To learn how to set a custom speaker icon, see the [Custom Conversation UI](https://dev.epicgames.com/documentation/en-us/fortnite/custom-conversation-ui-in-unreal-editor-for-fortnite) document.

#### Two Speakers

The **Two Speakers Box Type** displays the current speaker's name and text in a box with response buttons to the right of the  speech box. UI Materials can also be used with this box type to identify the current speaker. To learn how to set up two speakers in a Conversation Graph, see the [Creating Conversations](https://dev.epicgames.com/documentation/en-us/fortnite/creating-conversations-in-unreal-editor-for-fortnite#making-a-basic-conversation-graph) document.

![First Speaker](https://dev.epicgames.com/community/api/documentation/image/459021a8-330e-4e0b-b840-5ef57c5a85f6?resizing_type=fit&width=1920&height=1080)

![Second Speaker](https://dev.epicgames.com/community/api/documentation/image/cfd5eec5-5479-4220-b3ae-a7a4141f1dd1?resizing_type=fit&width=1920&height=1080)

First Speaker

Second Speaker

### Custom

You can use the **custom** modal to create a completely custom look for all parts of the conversation UI. A customized UI can establish a tone and style for your in-game conversations.

Custom conversation modals are created with the [Widget Editor](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite). See [Custom Conversation UI](https://dev.epicgames.com/documentation/en-us/fortnite/custom-conversation-ui-in-unreal-editor-for-fortnite) for how to create a custom conversation UI.

The custom modal needs to be assigned a conversation device. The device must be set to use custom UI to successfully initiate conversations.

[![Custom widget assigned](https://dev.epicgames.com/community/api/documentation/image/98030453-ca8c-4acd-93da-a5375313d50f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/98030453-ca8c-4acd-93da-a5375313d50f?resizing_type=fit)

Here is a simple example of what a custom widget can look like in-game:

[![Conversation custom](https://dev.epicgames.com/community/api/documentation/image/d6b4ea37-f9c3-4931-b3ed-6c41761ab9a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6b4ea37-f9c3-4931-b3ed-6c41761ab9a4?resizing_type=fit)

## Conversation Editor

All dialogue is built inside the **Conversation Editor** using nodes to fill out the conversation hierarchy.

The Conversation editor is the only way you can create a Conversation Graph. A Conversation Graph can be simple or complex. While there is no upper limit on responses in the conversation graph, there is a limit on the number of responses certain modals can handle at once.

Conversation graphs are built inside the Conversation editor. Double-clicking the Conversation Bank opens the Conversation editor. To use the editor you right-click in the graph area and select the nodes from the right-click **Node Selection** menu.

There are four important parts to the Conversation Editor:

[![The Conversation Editor and its parts: 1. Node Graph 2. Right-click Node Selection menu 3. Details Panel 4. Conversation Tree](https://dev.epicgames.com/community/api/documentation/image/28473e27-d04e-4391-9f41-8959376c31ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28473e27-d04e-4391-9f41-8959376c31ca?resizing_type=fit)

1. Node Graph 2. Right-click Node Selection menu 3. Details panel 4. Conversation Tree

*Click image to enlarge.*

1. **Node Graph**: Conversation hierarchy is built by stacking and linking conversation nodes.
2. Right-click the **Node Selection** menu: Contains all Conversation nodes. Selecting a node adds it to the graph.
3. **Details panel**: Editable text and event area of the node.
4. **Conversation Tree**: Shows the hierarchy of the nodes and the text assigned to the Response nodes.

## Conversation Graph

Conversation graphs are created by linking a series of conversation nodes together. The nodes use the graph hierarchy to determine where in the conversation the player is and when a graph is completed. It resembles a flowchart.

A typical design for a conversation looks something like this:

[![A diagram example of a typical conversation tree.](https://dev.epicgames.com/community/api/documentation/image/6dfb7afb-6ecd-4282-8f8a-3730be19a575?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6dfb7afb-6ecd-4282-8f8a-3730be19a575?resizing_type=fit)

1. Conversation Graphs start with the Default Entry Point. This node points to the first Speech node, which begins the conversation.
2. The Speech node has some sort of introductory text that leads the player into the conversation tree.
3. The nodes in this section lead back to the beginning of the conversation tree.
4. The nodes in this section prompt the player to make a decision.
5. The nodes in this section lead back to the beginning of the conversation tree.
6. The nodes in this section lead back to the beginning of the conversation tree.

Node hierarchy tracks how deep into the conversation the player can go based on the player’s choices in the conversation tree. Hierarchy is created by adding events, responses, and more conversation nodes to the graph.

### Conversation Nodes

Conversation nodes are the base of an action in the conversation. For example, kick off a conversation or offer a selection of choices represented by buttons the player selects from.

Nodes have an editable field in the Details panel. This is where you enter text. The table below describes the different Conversation nodes.

| Node Name | Description |
| --- | --- |
| **Default Entry Point** | The Default Entry Point node begins the Conversation graph. |
| **Speech** | This is the main node type that most conversations will use. This node creates a text selection that appears on the primary UI during playback by the NPC or Conversation target. This field uses the Message area to enter text. |
| **Response** | The node used to create choices in a conversation. Having multiple Response nodes branching off a single Speech node will stop the Conversation and allow users to select between multiple options. In the node, creators can enter the text that will appear as the Choices when the Conversation is played during the game. **Note**: Radial only allows up to **5** choices to be shown at a time, Custom allows up to **6** to be shown, and Box has no limit. |
| **Repeat** | This node returns to the previous connected node in the graph. If there is no Speech node, players will have to manually back out of the conversation.  You can set Number Of Times To Repeat, and whether it should only repeat the value set in Number Of Times To Repeat. If Number Of Times To Repeat is set to **0**, it will repeat an infinite number of times. |
| **Event** | The Event node triggers a device event associated with the Conversation device through the Conversation Graph. |
| **Restart Conversation** | Restart Conversation takes the player back to the start of the conversation tree. |
| **Reroute** | The Reroute node makes Conversation Graphs easier to read visually. Only one outgoing execution line can come off a reroute node, but it can receive from numerous sources in the graph. |
| **Set Conversation Material** | This node adds a custom material to the attached Conversation Bank when the conversation device uses one of the following **Conversation Types**:   - **Custom** - **Box** > **Single Speaker** - **Box** > **Two Speakers**   In a UI widget, this is achieved by using the Make Image Brush from Material function from the CreativeModalDialogVariant Viewmodel.  This only applies to the the current conversation that the associated user is in and the value set in the device will be used when a new conversation is started. |
| **Set Conversation Speaker Name** | The Set Conversation Speaker Name node sets the device's **Speaker Name**. This only applies to the current conversation and the value set in the device will be used when a new conversation is started. |
| **Hide Conversation** | This node hides the conversation UI. This only applies to the the current conversation that the user is in and the value set in the device will be used when a new conversation is started. |
| **Play Conversation Animation** | This node provides a way to play an animation when the Conversation Type is set to Box or Custom. A Custom UI requires the appropriate **Viewmodel** setup.  Box Animation is an animation that plays if the conversation uses a Box UI. This uses the following animation styles to appear in the conversation UI:   - **Slidein Left** - **Slidein Right** - **Slideout Left** - **Slideout Right**   The Progress value used in the viewmodel can be used to pause and play animations, alongside whatever else is set up in a viewmodel. |
| **Set Conversation Text Speed** | This node sets the device's **CharactersPerSecond** value.  This only applies to the the current conversation that the associated user is in and the value set in the device will be used when a new conversation is started. |

## Node Activation Order

Nodes are activated in the order that they are connected. Take a look at the example below:

[![Node activation order](https://dev.epicgames.com/community/api/documentation/image/654b1a84-7ae8-4a06-9714-a9da83c90eb5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/654b1a84-7ae8-4a06-9714-a9da83c90eb5?resizing_type=fit)

In this example:

1. The Speech node will activate, since it was connected to the Default Entry Point node before the Conversation Event node. The Conversation Event node is ignored.
2. The Response node that contains the Continue message will activate once it is selected by the player, because it is connected to the Speech node.
3. The Speech node activates after the response.
4. The two Response nodes are gathered together before prompting the user with selectable options.

Observe the way arrows are pointing for the flow of the conversation.
