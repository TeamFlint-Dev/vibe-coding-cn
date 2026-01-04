# Create Temporary Teams Through Emotes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-create-temporary-teams-through-emotes-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:12:30.177732

---

Create opportunities for players to temporarily join or leave teams in your island with the **Dynamic Team Emotes** settings. These settings activate unique [emotes](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#emote) for players to build teams. The [Social Deduction](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-social-deduction-template-in-unreal-editor-for-fortnite) template demonstrates how to enable the feature and explores the idea of creating interesting social dynamics.

The forming of a team link by choice can create a space for players to interact more and build tension. You can use positive interactions (like creating bonds or getting a bonus) and negative interactions (like betrayal) to expand your gameplay.

[![](https://dev.epicgames.com/community/api/documentation/image/38535ccd-0c41-4ad1-b9ed-85eec0320054?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38535ccd-0c41-4ad1-b9ed-85eec0320054?resizing_type=fit)

Invite to Team Emote

## Dynamic Team Emotes

With Dynamic Team Emotes, you can build games where players form teams with other players in real-time through emotes, actively creating connections.

The feature is available in Fortnite Creative and Unreal Editor for Fortnite (UEFN). For Squid Game islands, the Dynamic Team Emotes feature includes unique emotes. These emotes are designed to fit the aesthetic of the Squid Game brand. To learn more about the Squid Game feature set, see [Working with Squid Game Islands](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-squid-game-islands-in-unreal-editor-for-fortnite).

|  |  |
| --- | --- |
| [Dynamic Team Emotes](https://dev.epicgames.com/community/api/documentation/image/1e7fc9e7-6cc8-4e19-b23e-ded7c7ce42d0?resizing_type=fit) | [Squid Game Dynamic Team Emotes](https://dev.epicgames.com/community/api/documentation/image/f60bdc51-dc79-4080-9c17-5db0cbce28db?resizing_type=fit) |
| Default Fortnite Emotes | Squid Game Emotes |

The feature includes two user options: **Dynamic Team Emotes** and **Dynamic Team Leave**. You can access the settings in either the [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-uefn-and-fortnite-creative) or the [Team Settings & Inventory](https://dev.epicgames.com/documentation/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative) device.

[![squid game emotes in UEFN](https://dev.epicgames.com/community/api/documentation/image/0e21d916-eb6a-4b22-aa55-69b9b876e30f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e21d916-eb6a-4b22-aa55-69b9b876e30f?resizing_type=fit)

User Options

To enable the feature, you must set the following options in the Island Settings:

- The **Team Size** option to **Dynamic**.
- The **Teams** option to either **Team Index**, **Free for All**, or **Custom**.

Use the **Dynamic Team Emotes** option for players to join another player's team, and the **Leave Team Emote** option to dynamically leave a team during a session. These options activate the **Invite to Team** and **Leave Team** emotes for players. Players can access the emotes through the emote wheel, located under the **Manage Team** category.

![Squid Game Emotes in Fortnite and UEFN](https://dev.epicgames.com/community/api/documentation/image/fbf5e487-8ee9-4a5d-8ce4-b1f5033ec994?resizing_type=fit)

The following table lists out the behaviors for each emote.

| Emote | Functionality |
| --- | --- |
| **Invite to Team** | An emote performed by two players: the inviter (the player initiating the emote) and invitee (the player responding to the emote).  After the interaction, the invitee joins the inviter's team. Any feature in the island assigned to that specific team is now available to the new member. |
| **Leave Team** | An emote performed by one player.  A player invited to join a team can use the emote to leave the team. If a player initiated the invitation, they can use the emote to remove all invited players.  You can choose not to enable the Leave Team emote, depending on the needs of your gameplay. |

## Gameplay Setup

The **Dynamic Team Emotes** room in the template showcases the setup for enabling the feature along with a test area for creating teams. In the island settings, **Dynamic Team Emotes** is enabled, **Team** is set to **Custom**, and **Team Size** is set to **Dynamic**.

Devices Used:

- [Class Selector](https://dev.epicgames.com/documentation/en-us/fortnite/using-class-selector-devices-in-fortnite-creative) x 2
- [Team Settings and Inventory](https://dev.epicgames.com/documentation/en-us/fortnite/using-team-settings-and-inventory-devices-in-fortnite-creative) x 2

Use the room setup to test out setting teams through the **Class Selector** device, and then changing teams through the emotes.

[![Squid Game in UEFN Gameplay Setup](https://dev.epicgames.com/community/api/documentation/image/fdf2799c-994a-40cb-9d36-b7303db41db8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdf2799c-994a-40cb-9d36-b7303db41db8?resizing_type=fit)

Gameplay Setup

The **Team Settings and Inventory** devices have **Dynamic Team Leave** enabled for players to switch teams. The **Dynamic Team Emotes** option is enabled in the **Island Settings**. Through the devices, each team is provided a specific weapon and different movement mechanics are applied.

Both level assets include the same setup. There is no Verse example.

## Design Tips

Below are additional design considerations:

- Include introductory instructions to indicate Dynamic Team Emotes is enabled in your island.
- Use incentives like shared bonuses or team-specific benefits to give players a reason to form up.
- Consider the original Fortnite Impossible Escape limited-time mode to think about how it could turn potential opponents into allies and the tension that comes with such a choice.
- Use the leave team mechanic to create betrayal situations. For example, players leaving their team, negating the friendly fire protections, and then targeting their former teammate.
