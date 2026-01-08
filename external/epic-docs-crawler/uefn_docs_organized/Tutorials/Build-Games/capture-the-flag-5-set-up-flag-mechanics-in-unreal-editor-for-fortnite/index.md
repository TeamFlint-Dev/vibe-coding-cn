# 5. Set Up Flag Mechanics

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-5-set-up-flag-mechanics-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:16:51.398127

---

**Devices used:**

- 2 x [Capture Item Spawner](https://www.fortnite.com/en-US/creative/docs/using-capture-item-spawner-devices-in-fortnite-creative)
- 2 x [Capture Area](https://www.fortnite.com/en-US/creative/docs/using-capture-area-devices-in-fortnite-creative)
- 1 x [HUD Message](https://www.fortnite.com/en-US/creative/docs/using-hud-message-devices-in-fortnite-creative)
- 1 x [HUD Controller](https://www.fortnite.com/en-US/creative/docs/using-hud-controller-devices-in-fortnite-creative)

[![Flag Capture Area](https://dev.epicgames.com/community/api/documentation/image/0d3907ea-61d2-4adb-b4dc-7809d4e70aa8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d3907ea-61d2-4adb-b4dc-7809d4e70aa8?resizing_type=fit)

The Capture the Flag-specific game mechanics used on this island include:

- One flag and one capture area for each team.
- Flags for each team are on the top floor of the two identical bases.
- The capture area is in the center of each base and can be seen very easily from the courtyard.
- When a team takes the enemy flag, they need to return it to the capture area in their base to get a point.
- The team that gets three points first wins the match.
- If Team 1 has the Team 2 flag, the capture point in the Team 2 base turns off until their flag is recovered. If both team flags are taken, then nobody can get a point for capturing a flag until one of the flags is returned.

The following sections show you how to set up devices to make these mechanics work.

## Capture Item Spawner

Each team's flag is created by using the Capture Item Spawner and a flag.

Place the Capture Item Spawner devices where you want the flag to display (the top balcony on the castle base is a good location, easily visible from the courtyard). To add the flag to each Capture Item Spawner, follow these steps:

1. Under **User Options**, locate **Item List**.
2. Press **+**, then expand **Index**.
3. Search for “flag”, then select it.

[![Flag Selected](https://dev.epicgames.com/community/api/documentation/image/27f420d2-b356-47d0-a93a-4bdbdb8ba1c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/27f420d2-b356-47d0-a93a-4bdbdb8ba1c7?resizing_type=fit)

Once you have the Capture Item Spawner devices placed and the flags added, customize the options for each one as shown below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Friendly Team** | Team Index: 1 or 2 | Each Capture Item Spawner is assigned to one team. |
| **Captured By** | Hostile Teams | Only enemy team players can take the flag from the Capture Item Spawner. |
| **Accent Color** | Team Color | The Flag color matches the team color. |
| **Return Dropped Items** | 10 seconds | If a player drops the flag and no one picks it up, after 10 seconds the flag will return to the spawner. |

## Capture Area Device

Each team's base will have a Capture Area device that creates the place where players drop the captured enemy flag. The Capture Area device should be placed somewhere inside the team's base. You need to add a Flag to the Capture Area device. Equip another Flag just like you did for the Capture Item Spawner in the previous section.

Once you have the Capture Area devices placed, customize the options for each as shown below.

| Option | Value | Explanation |
| --- | --- | --- |
| **Starting Team** | Team Index: 1 or 2 | The team that will use this area to register a captured enemy flag. |
| **Accent Color** | Team Relationship | Displays in the team’s designated color. |
| **Consume Item When Dropped** | False | When the player drops the enemy flag on the device, the item is not consumed. |
| **HUD Elements** | Beacon | Players will see the beacons in their HUDs. |
| **Beacon** | Flare | This is the type of beacon displayed by the Capture Area device. |
| **Beacon Size** | 2: Medium | This determines the size of the beacon displayed. |
| **Beacon Color** | Custom: Blue | The beacon’s color matches the owning team’s color. |

## Direct Event Binding

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Blue Capture Area**  [capture area device](https://dev.epicgames.com/community/api/documentation/image/551227c3-4bfa-454c-9de0-5c9142ee1e6c?resizing_type=fit) | Enable | **Blue Capture Item Spawner**  [Capture Item Spawner](https://dev.epicgames.com/community/api/documentation/image/ee7609cb-d331-49f7-8a7e-e94df4cf835c?resizing_type=fit) | When Picked Up | When a player from this team picks up the enemy team’s flag, this capture area is enabled. |
| **Blue Capture Area**  [capture area device](https://dev.epicgames.com/community/api/documentation/image/ca74c30e-f9ee-4ca0-a5c4-6ace30e2f52b?resizing_type=fit) | Disable | **Blue Capture Item Spawner**  [Capture Item Spawner](https://dev.epicgames.com/community/api/documentation/image/3f2eace3-8571-4c35-9464-2bffc0938eef?resizing_type=fit) | When Returned | When this team’s flag is returned to the enemy team, this team’s capture area is disabled. |
| **Blue Capture Area**  [capture area device](https://dev.epicgames.com/community/api/documentation/image/875b0981-c3a0-4860-9268-d224eb2019cf?resizing_type=fit) | Disable | **Blue Capture Item Spawner**  [Capture Item Spawner](https://dev.epicgames.com/community/api/documentation/image/931f6461-a1c7-4d64-b4a3-734449a21974?resizing_type=fit) | When Captured | When this team’s flag is captured by the enemy team, this team’s capture area is disabled. |
| **Red Capture Area**  [capture area device](https://dev.epicgames.com/community/api/documentation/image/1cda01dc-2736-409a-aee1-6c5858df5549?resizing_type=fit) | Enable | **Red Capture Item Spawner**  [Capture Item Spawner](https://dev.epicgames.com/community/api/documentation/image/64c0927e-e7e4-412d-b477-5db178a91cf0?resizing_type=fit) | When Picked Up | When a player from this team picks up the enemy team’s flag, this capture area is enabled. |
| **Red Capture Area**  [capture area device](https://dev.epicgames.com/community/api/documentation/image/bfafecca-8965-4052-af51-e0e41b6b6403?resizing_type=fit) | Disable | **Red Capture Item Spawner**  [Capture Item Spawner](https://dev.epicgames.com/community/api/documentation/image/372899ae-5728-4f35-82fa-5446f0ce8ce5?resizing_type=fit) | When Returned | When this team’s flag is returned to the enemy team, this team’s capture area is disabled. |
| **Red Capture Area**  [capture area device](https://dev.epicgames.com/community/api/documentation/image/6b968970-7d53-4f65-ac11-e21b94bb47c0?resizing_type=fit) | Disable | **Red Capture Item Spawner**  [Capture Item Spawner](https://dev.epicgames.com/community/api/documentation/image/c4691a85-46ed-486d-a81b-cefa4c0b79a4?resizing_type=fit) | When Captured | When this team’s flag is captured by the enemy team, this team’s capture area is disabled. |

## Set Up the HUD Controller Device

The HUD Controller device turns the HUD UI elements on or off. You can place this anywhere, since it will be invisible to the players. Customize the HUD Controller’s User Options as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Show HUD** | Do Not Override | Important messages are shown on the HUD, so it needs to be visible to players. |
| **Show Mini Map** | No | This particular CTF game has a relatively simple map, which is easy to memorize. Therefore, the mini map isn’t needed. |
| **Show Build Menu** | No | Player building is not part of the gameplay in this CTF game. |
| **Show Wood Resources** | No | Player building is not part of the gameplay in this CTF game. |
| **Show Stone Resources** | No | Player building is not part of the gameplay in this CTF game. |
| **Show Metal Resources** | No | Player building is not part of the gameplay in this CTF game. |
| **Show Gold Resources** | No | Classes are automatically granted certain items and equipment, and gold is not used in the game. |

[Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/b40a79f2-9ab6-4fe5-8190-d8c98e9815e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b40a79f2-9ab6-4fe5-8190-d8c98e9815e0?resizing_type=fit)

## Next Section

[![6. Make the Pre-Game Lobby](https://dev.epicgames.com/community/api/documentation/image/2a79b24e-41c1-4d6b-9799-0b6550acf325?resizing_type=fit&width=640&height=640)

1. Make the Pre-Game Lobby

Create a pre-game lobby where players will spawn before the start of the match.](<https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-6-make-the-pregame-lobby-in-unreal-editor-for-fortnite>)
