# Creating Conversations

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/creating-conversations-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:16:25.623194

---

The narrative choices you make for your project don’t have to be sophisticated to be immersive and leave an impression on players. Even simple interactions can have a meaningful impact on gameplay.

This page will give you a crash course on writing for conversations, then dive into how you can structure different types of conversations. You will also get some tips on using the Conversation graph as featured in the **Conversation Template** in UEFN.

For an in-depth dive on the device itself, see the [Conversation device](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-conversation-device-in-unreal-editor-for-fortnite) page.

## Writing for Conversations

Before you connect your narrative to gameplay with the Conversation device, make sure that your conversation flows, makes sense, and fits the kind of experience you’re building. If you’ve never done any creative writing before you should:

- **Play games that use narration and conversation**. Having an example of what good (or possibly bad) conversational writing looks like can help your creative process.
- **Think about the NPCs with speaking roles**. Having an idea about where the characters are from, what kind of life they lead, and who they are will help you write better dialog for them and stop them from all sounding the same.
- **Think about how the people in your life talk**. This can help you find vocal cadences or ways of speaking for different characters.
- **Think about what is happening during the conversation.** Life doesn’t stand still when you’re talking with someone. Think about where the conversation is taking place and if anything should be happening in the background.

### Game Dialogue

Video game dialogue is a lot like a movie, except that players can alter a storyline just by interacting with the NPCs. Games use dialogue to perform a number of functions:

- Provide background information.
- Explain gameplay or give clues.
- Exchange goods and services in the game.
- Set the player on a certain path or alter the player’s path based on choices the player makes.

Introductions are important, and meeting NPCs is an integral part of gameplay that helps immerse players in the overall experience. Players need an introduction to NPCs in your game to:

- Understand who an NPC is and their role in the game.
- Receive basic information they can act on.
- Orient themselves in the game.

Dialogue should resemble normal conversation as much as possible, and yes, that includes using slang and shorthand to make the dialogue feel more natural.

### Quests

You can use a certain character to impart information that only they would know, or clarify something technical to the player. An NPC might also hold a clue or know a secret they can share with the player.

Below is a table that outlines what a simple exchange with an NPC could look like. The NPC is giving the player a choice of whether to participate in their quest.

Each response has an event that triggers when the player chooses whether to accept or reject the quest. If the player accepts the quest, they get paid and can use that NPC in a future quest. If they refuse the quest, a new storyline is created and the NPC won’t help the player on a future quest, thereby altering the gameplay and outcome of the narrative.

| Player | Speech | Response | Outcome | NPC |
| --- | --- | --- | --- | --- |
| [Character 1](https://dev.epicgames.com/community/api/documentation/image/5b6195c8-4e9f-44bb-80ef-e1b98d7c5e25?resizing_type=fit) | **NPC:** "Hey! I have to hand in this essay, but I’d rather go out and play hackysack. Would you hand in my essay for me?" | -- | -- | [Character 2](https://dev.epicgames.com/community/api/documentation/image/6587dcf2-aa4d-432b-bf9f-76129efa6451?resizing_type=fit) |
| -- | -- | **YOU**: “Yes - for 5 gold.” | **Yes:** NPC pays you 5 gold and walks off in the direction of the quad. | -- |
| -- | -- | **YOU:**“No - Why would I?” | **No:** NPC will remember this and not help you in another quest. | -- |
| -- | **NPC:** “Jeez, good help is hard to find!” | -- | -- | -- |

## Making a Basic Conversation Graph

Depending on what you’re trying to achieve through dialogue, the conversation tree could be large or small. Create a Conversation Bank and open the Conversation Editor to begin creating a graph:

1. Right-click in the graph area and select a **Default Entry Point** node from the Node Selection menu.
2. Left-click the bottom bar of the **Default Entry Point** node and drag the arrow to a new location. Letting go of the mouse button will give you the option to choose a new node. Choose **Speech** node from the Node Selection menu. The Speech node options open in the **Details** panel.

You can also right-click in the graph and create the desired node before linking two nodes using an arrow. To connect the nodes, hover over the bottom of the node until it turns yellow, then drag. Stop dragging when the top bar of the receiving node turns yellow.

1. Add introductory text to the **Message** field.

   If an NPC plays a vital role in your game, this is a good place to have the NPC explain what their role is in your game.
2. Right-click in the graph area and select a **Response** node. In the **Details** panel, write the desired response a player would give to the NPC.
3. You can create multiple response nodes and connect them to the same introductory Speech node, which will result in multiple conversation paths.

   [![A speech node with multiple response nodes](https://dev.epicgames.com/community/api/documentation/image/28dfdd73-5c7b-4c61-a586-4abe31bb2b3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28dfdd73-5c7b-4c61-a586-4abe31bb2b3c?resizing_type=fit)

   Speech nodes are always what the NPC says to the player. The first Speech node should be an introduction between the NPC and the player. Additional Speech nodes act as anchors for responses and events.
4. Use **Reroute nodes** to better organize your conversations. To do this, create an arrow between two nodes you would like to connect, then **double-click** on the arrow where you want the reroute node to appear. Left-clicking the node will show a border around it that you can drag around the graph.

Create as many Speech nodes as you need. Players can walk away from the NPC to end an interaction mid-conversation.

Nodes of the same type cannot be connected by an arrow. The operation won't complete if you attempt this.

Here is a list of allowed node connections. The cells preceded by a **NO** indicate invalid connections:

| -- | Default Entry Point | Conversation Event | Repeat | Response | Restart Conversation | Speech | Random |
| --- | --- | --- | --- | --- | --- | --- | --- |
| Default Entry Point |  | Entry Point > Event | **NO** Entry Point > Repeat | **NO** Entry Point > Response | **NO** Entry Point > Restart | Entry Point > Speech | Entry Point > Random |
| Conversation Event | N/A |  | Event > Repeat | Event > Response | Event > Restart | Event > Speech | Event > Random |
| Repeat | N/A | Repeat > Event |  | Repeat > Response | Repeat > Restart | Repeat > Speech | Repeat > Random |
| Response | N/A | Response > Event | Response > Repeat |  | Response > Restart | Response > Speech | Response > Random |
| Restart Conversation | N/A | **NO** Restart > Event | **NO** Restart > Repeat | **NO** Restart > Response |  | **NO** Restart > Speech | **NO** Restart > Random |
| Speech | N/A | Speech > Event | Speech > Repeat | Speech > Response | Speech > Restart |  | Speech > Random |
| Random | N/A | Random > Event | Random > Repeat | NO Random > Response | NO Random > Restart | Random > Speech |  |

### Create a Conversation with Two Speakers

Creating a conversation with two speakers in one Conversation Graph is possible with the [Set Conversation Material node](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-conversation-device-in-unreal-editor-for-fortnite#conversation-nodes). Under the **Default Entry Point** add your first **Set Conversation Material** node then customize the node to the first speaker in the Details panel.

[![Set the first Set Conversation Material to the first character speaker.](https://dev.epicgames.com/community/api/documentation/image/bd6ffd8b-8224-47d3-9d1b-ca1493b6d61e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd6ffd8b-8224-47d3-9d1b-ca1493b6d61e?resizing_type=fit)

Click image to enlarge.

Continue to build your conversation to the point that a second speaker is introduced. At this point set a second **Set Conversation Material** node and customize the node in the **Details** panel to the second speaker.

[![Add a second Set Conversation Material node and set this node to the second character speaker.](https://dev.epicgames.com/community/api/documentation/image/88ad75be-d0f3-494a-8a97-e262f6cde784?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88ad75be-d0f3-494a-8a97-e262f6cde784?resizing_type=fit)

Click image to enlarge.

Creating your own conversation UI provides greater control over the material size.

### Add Events

Event Nodes can trigger events or offer a selection of choices to the player. An event could be basic, like the NPC reacting to the choice the player makes using a [Cinematic Sequence device](cinematic-sequence-device-in-unreal-editor-for-fortnite) or cause a boss fight to break out.

[![Conversation event example](https://dev.epicgames.com/community/api/documentation/image/87aaae41-b0b1-4c7c-a3be-8a66bfb72f8b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87aaae41-b0b1-4c7c-a3be-8a66bfb72f8b?resizing_type=fit)

Click image to enlarge.

Create an event node by left-clicking and dragging from the bottom of an existing node, then selecting **Conversation Event** from the dropdown menu. You can connect a single conversation to up to **10 events**. For more information, see the [Conversation device](conversation-devices-in-unreal-editor-for-fortnite) page.

### Add UI Materials

Create a UI material and add it to your Conversation device under the **Conversation Material** option. Click the **Array icon** (+) to add your material to the **Index** list.

[![Add your custom UI material to the Conversation Material option in the Conversation device.](https://dev.epicgames.com/community/api/documentation/image/8435fed9-dec0-40ef-b2e7-70f54f258105?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8435fed9-dec0-40ef-b2e7-70f54f258105?resizing_type=fit)

Click image to enlarge.

Add the **Set Conversation Material** node under the **Default Entry Point** node. This tells the Conversation device to set the conversation UI material with the Conversation Material option and this Conversation Bank.

[![The Set Conversation Material uses your custom UI material in the conversation box.](https://dev.epicgames.com/community/api/documentation/image/937cce02-83e5-46af-8e3e-88a34113cea5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/937cce02-83e5-46af-8e3e-88a34113cea5?resizing_type=fit)

Click image to enlarge.

## Hiding and Showing Conversations

Temporarily hide and reveal conversations for cinematic effect. This is done with the **[Hide Conversation](https://dev.epicgames.com/documentation/en-us/fortnite/using-the-conversation-device-in-unreal-editor-for-fortnite#conversation-nodes)** node alongside the **Hide Conversation** and **Show Conversation** functions in the Conversation device.

The **Hide Conversation** function hides the character's conversation UI from the player and prevents them from selecting an option until the UI is shown again. When using the Hide Conversation node and function, the player's conversation Ui becomes invisible, this means:

- Players are not able to select, view, or navigate any responses while the conversation is hidden.
- Either Verse code or a device must trigger the Show Conversation function to reveal the conversation to the player again and continue the conversation.

The **Show Conversation** function reveals the conversation UI to the player. Once the conversation is revealed again, the player can continue through the conversation and select options again.

## Staying Organized

This section will cover best practices for creating more complex conversations. All of these tips can be found in the **Conversation Template** in UEFN under **Feature Examples**.

[![Conversation Template](https://dev.epicgames.com/community/api/documentation/image/36440661-619f-4fa8-b8cc-cd8d2c2a4bda?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36440661-619f-4fa8-b8cc-cd8d2c2a4bda?resizing_type=fit)

### Comments

**Comments** are a way to easily keep track of complex conversation graphs. A comment can be as short as one letter to help you distinguish various branching paths, or it can be a more detailed account of what happens in a particular section of the conversation.

[![Example Comment](https://dev.epicgames.com/community/api/documentation/image/202c6808-e01e-4437-a16e-8da0b9cb277f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/202c6808-e01e-4437-a16e-8da0b9cb277f?resizing_type=fit)

To create a new comment, select any node(s) on the graph and press **C**. This will generate a text box with a title.

In the Details panel for the comment, you can select the color of the region, whether to show a bubble when zoomed out, what color that bubble appears, and whether the comment will move with or without the nodes contained within.

[![Comment details](https://dev.epicgames.com/community/api/documentation/image/95b3ad7d-baa6-4885-970d-da266eebe80f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/95b3ad7d-baa6-4885-970d-da266eebe80f?resizing_type=fit)

### Reroute Nodes

**Reroute nodes** do exactly what their title suggests — reroute. When a conversation branches off in multiple directions, it’s possible to use reroute nodes to keep your logical flow organized. Without them, arrows between nodes may end up criss-crossing the screen and creating a lot of visual pollution in your graph.

Using reroute nodes to stay organized will allow you to be intentional about the flow of your conversations, and will let you stay flexible about making changes to existing paths.

Take the complex conversation below. It uses reroute nodes to declutter the various paths a player could take based on their choices. Now move the slider to the left and see the same conversation without reroute nodes. It comes down to personal preference, but the more complex a conversation, the more likely you are to confuse yourself!

![using reroute nodes](https://dev.epicgames.com/community/api/documentation/image/fbca099d-35f9-47a7-a996-1f783ac5fd9a?resizing_type=fit&width=1920&height=1080)

![not using reroute nodes](https://dev.epicgames.com/community/api/documentation/image/fb7cb242-8ef1-4f7b-bc24-aca0d5f65a7e?resizing_type=fit&width=1920&height=1080)

using reroute nodes

not using reroute nodes
