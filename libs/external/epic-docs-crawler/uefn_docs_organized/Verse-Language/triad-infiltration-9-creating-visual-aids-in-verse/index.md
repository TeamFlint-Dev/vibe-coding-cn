# 9. Creating Visual Aids

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-9-creating-visual-aids-in-verse
> **爬取时间**: 2025-12-27T02:21:02.036998

---

When a player joins a game, it might not be immediately obvious what they're supposed to do. Many games use visual aids or explanations to quickly get info across so that players spend more time playing and less time figuring out where they're supposed to go.

Follow the steps below to create messages and visual aids to quickly onboard players.

## Creating Visual Aids for Players

1. In the editor, drag one **HUD Message** device into the level, somewhere the player can't see. This will flash a message on the Defender's screen when the round starts to tell their objective.
2. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Message** | A short message | Write a message that briefly explains what a Defender's objective is. The **Message** field has limited room, so keep your message concise. |
   | **Show on Round Start** | True | You want to display the message to players when the game starts. |
   | **Time From Round Start** | 1.0 | Delaying the message for a second gives players a chance to adjust to the game world before reading the message. |
   | **Team Index** | 3 | This is the message for the Defenders, so make sure Team Index matches the index for the Defenders. |
   | **Display Time** | 8.0 | You want the message to last long enough to be readable, but not long enough to annoy the player. |
   | **Placement** | Top Center | Putting the message in the Top Center places it directly in a player's view, without disrupting too much of their screen. |

   [![HUD Message](https://dev.epicgames.com/community/api/documentation/image/832eb032-3180-427d-8c0e-5aa2d3965957?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/832eb032-3180-427d-8c0e-5aa2d3965957?resizing_type=fit)
3. Duplicate the HUD message device twice. Change the **Message** in one to a message for the Attackers, and the **Message** in the other to a message for the Infiltrators. Make sure to change the **Team Index** to the index for each team as well. Now each team should be quickly notified of what their goal is.
4. Players who join the match in progress won't see this message. Players may also miss the message, or forget what their objective is if they get lost during the match. It's helpful for players to have a permanent place to check their objective, and you can accomplish this with a **Billboard** device.
5. Drag a **Billboard** device into the Defender's spawn area. Place it somewhere the Defenders will see immediately when they spawn in.
6. In the **Details** panel, under **User Options**:

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Text** | A short, but slightly longer message. | Like you did with the HUD Message device, write a message that quickly explains the Defenders objective in the **Text** field. The **Text** field allows you to input a longer message than the HUD Message device, so include important details. |
   | **Show Border** | True | Toggle this depending on whether you want your billboard border to be visible or just floating text. |

   [![Billboard Message](https://dev.epicgames.com/community/api/documentation/image/08c01cf9-282e-4ce1-a6dd-e4760f9f5a61?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08c01cf9-282e-4ce1-a6dd-e4760f9f5a61?resizing_type=fit)
7. Duplicate the billboard both for the Attackers and for the Infiltrators. Place each billboard in their respective spawn areas, and change the message for each to suit the team and objective. Use as many billboards as you need to communicate objectives to players, but keep your message short so players can get into the match quickly.

## Next Step

In the [final step](https://dev.epicgames.com/documentation/en-us/fortnite/triad-infiltration-10-final-result-in-verse) of this tutorial, you can see the entire script for this game. You'll also see suggestions on customizations you can try on your own.
