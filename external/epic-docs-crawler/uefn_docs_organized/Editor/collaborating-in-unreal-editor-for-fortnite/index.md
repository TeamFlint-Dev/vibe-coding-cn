# Collaborating in Unreal Editor for Fortnite

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/collaborating-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T22:58:38.236215

---

Multiple people can collaborate on a single Unreal Editor for Fortnite (UEFN) [project](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#project) by using the UEFN [revision-control system](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#revision-control). To edit a UEFN project you do not own, you must belong to the team the project belongs to.

To create a team in UEFN, click **Project** > **Share with Team**. The **Creator Portal** opens.

You cannot collaborate on UEFN projects with anyone under the age of 18.

To learn more about managing teams and team projects, refer to [Creating Teams in Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/creating-teams-in-creator-portal-in-unreal-editor-for-fortnite).

Edits can be made from both UEFN and (to some degree) the corresponding Creative island, and changes made during a live edit session can be seen immediately in both UEFN and Creative.

When you open an [asset](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset) within a project, you must check it out before editing. If someone else currently has it checked out, UEFN will not let you access it. But you can access any assets not checked out by a collaborating team member.

The project is saved within UEFN when you submit your changes. UEFN will not let you exit without saving and submitting any assets you've opened during the session, even if you haven't edited them.

Edits made in Creative during a collaborative session can only be saved from UEFN.

Revision-controlled group projects in UEFN are accessible to all team members assigned to the project. Team members can open group projects by selecting their team from the project dropdown menu in the **Project Browser**. Group projects are assigned to team members from the Creator Portal, and in UEFN when the project is assigned to a team.

Always [sync a group project](https://dev.epicgames.com/documentation/en-us/fortnite/collaborating-in-unreal-editor-for-fortnite) before opening and editing it in UEFN.

Start by [creating and naming a new project](https://dev.epicgames.com/documentation/en-us/uefn/project-organization-in-unreal-editor-for-fortnite) then adding [Revision Control](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-revision-control-in-unreal-editor-for-fortnite). Once the project opens, you can add devices and props to the viewport and save them.

[![Tick the Source Control box to add source control to your projects](https://dev.epicgames.com/community/api/documentation/image/bf15d91f-de19-44a6-bf9c-a393ef4d2c97?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bf15d91f-de19-44a6-bf9c-a393ef4d2c97?resizing_type=fit)

Press **Launch Session** > **Start Game** in the [level editor toolbar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite#level-editor-toolbar) to [playtest](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite) your island in the Fortnite Creative client.

[![The Launch Session button.](https://dev.epicgames.com/community/api/documentation/image/7666550d-5993-4c01-bb28-0de4df0338f8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7666550d-5993-4c01-bb28-0de4df0338f8?resizing_type=fit)

When the connection is established, friends or colleagues can join the playtesting session from the Fortnite lobby by selecting your name from the social panel on the left, then clicking **Join Party** > **Join**. They automatically connect to the live edit session and can make edits to the project from their instance of Fortnite Creative.

[![Joining the party of a colleague in UEFN through Fortnite.](https://dev.epicgames.com/community/api/documentation/image/7a0f1114-035a-42d8-9bec-1439d080abb1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a0f1114-035a-42d8-9bec-1439d080abb1?resizing_type=fit)

To save, from inside UEFN, click **Enable Source Control** in the bottom right corner and select **Submit Content** to check in all changes made during the live edit session.

### Sync Team Changes

To sync all changes:

1. Open UEFN and select **Team Projects** from the **Project Browser** screen.
2. Select the team project you want to sync. You’ll receive a warning about the version of your local copy being out of date.

   [![Warning your project is out of date.](https://dev.epicgames.com/community/api/documentation/image/2622d4a5-1c9b-47ca-a1b1-52e8c0ad7940?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2622d4a5-1c9b-47ca-a1b1-52e8c0ad7940?resizing_type=fit)

   Team projects that need to be synced will have a **Cloud** icon in the corner.
3. Open the project and choose where you want to sync the project changes.

   Depending on the amount of changes and their file size, syncing a project may take anywhere from a few seconds to a few minutes.

When the file successfully syncs, you are free to begin working on the project.

Once the team project is complete and you’re ready to publish, click **Project menu** > **Upload to Private Version**, then confirm the changes and save the project. UEFN uploads your project to the Creator Portal where you can publish your island.

Refer to [Publishing Projects](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-projects-in-unreal-editor-for-fortnite) for more information.

### Disconnected During an Edit Session

At some point, your network might disconnect during a live edit session. Should this happen, the UI in the client and inside UEFN will reflect your disconnected state. If you continue to work inside UEFN, the client will remain disabled until you reconnect to the session, but you can still make edits.

After you’ve completed your edits in UEFN, click the Play button again to save your project and reconnect to the client. Your project will be refreshed in the client and reflect the progress you made in UEFN.

Refer to [Publishing Projects](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-projects-in-unreal-editor-for-fortnite) for information on publishing team projects.

## Granting Edit and Copy Permissions on Your Island

You can grant permission to friends and colleagues to access and interact with the UEFN island experiences you have created. Note that they will only have access to the downloaded content while they are in that session. Once they leave, the island will no longer be available to them.

Select the person you want to invite and choose **Invite to Party**.

[![invite friend](https://dev.epicgames.com/community/api/documentation/image/af1d0e82-586e-4119-9857-f17de5d6fde6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/af1d0e82-586e-4119-9857-f17de5d6fde6?resizing_type=fit)

Press the **Tab** key and select **My Island**, then select the **Permissions** tab. Your friend's [gamertag](https://www.fortnite.com/creative/docs/fortnite-creative-glossary#gamertag) will appear on this page once they have joined your party.

[![permissions tab](https://dev.epicgames.com/community/api/documentation/image/eea521b2-e0c0-4469-824c-00338ead7a51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eea521b2-e0c0-4469-824c-00338ead7a51?resizing_type=fit)

Change their permissions from **Play** to **Edit and Copy**.

From their own Creative hub, your friend can now walk through your golden rift and spawn onto your island. They will be able to move the custom assets available on your island while the session is active, but cannot change materials or apply effects available in UEFN.

[![friend](https://dev.epicgames.com/community/api/documentation/image/06aae3b3-6891-4fcc-8ee6-be428c9a89f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06aae3b3-6891-4fcc-8ee6-be428c9a89f3?resizing_type=fit)

## Obtaining Edit and Copy Permissions on Another Island

Follow these steps if you are joining a friend who has created a new experience.

Launch the Fortnite client and join your friend's [party](https://www.fortnite.com/en-US/creative/docs/fortnite-creative-glossary#party). Set the destination to **Creative**. Once all players have [readied up](https://www.epicgames.com/fortnite/en-US/creative/docs/fortnite-creative-glossary#ready-up), press **Play**.

[![Party](https://dev.epicgames.com/community/api/documentation/image/6f11a4b3-b14a-4fb1-9f8d-ad662c68b452?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6f11a4b3-b14a-4fb1-9f8d-ad662c68b452?resizing_type=fit)

Once you spawn into the Creative hub, you will see two golden rifts: your own and your friend's. Your friend's player name will display above the name of the island their portal is set to.

[![Golden Rift](https://dev.epicgames.com/community/api/documentation/image/3c6376ab-e0c3-48a9-a0f1-ff44eb7153f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c6376ab-e0c3-48a9-a0f1-ff44eb7153f7?resizing_type=fit)

When you walk up to the portal, you'll see the content being cooked for that portal in preparation for download.

Jump into the portal after the downloads are complete.

On the island, the host must grant you permission to fly around, edit, and copy the same way you did for them in the previous section.

[![Permissions](https://dev.epicgames.com/community/api/documentation/image/eba256be-73c6-4c87-b741-7c1773ffd54e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eba256be-73c6-4c87-b741-7c1773ffd54e?resizing_type=fit)
