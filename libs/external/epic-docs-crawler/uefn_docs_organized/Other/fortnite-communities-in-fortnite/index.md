# Fortnite Communities

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-communities-in-fortnite
> **爬取时间**: 2025-12-26T23:56:09.851871

---

Fortnite Communities is a platform for you to communicate with your players. You can organize a community into channels, create posts, and publish announcements directly in Fortnite!

If users are under 13 (or the age of digital consent in their region), they will not be able to post or reply until they reach the age of digital consent in their region.

[![Example of a community front page](https://dev.epicgames.com/community/api/documentation/image/14c87a27-f553-4fc6-a709-11f656ff68d9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14c87a27-f553-4fc6-a709-11f656ff68d9?resizing_type=fit)

Example of a community front page

Only Fortnite Developers are able to create a community.

## Fortnite Communities

When you create a community, you are considered the **Community Owner**. To set up your community you’ll add high-level community details such as name, description, icon, and image.

[![The Create community wizard](https://dev.epicgames.com/community/api/documentation/image/0c6ef569-60b3-4d6e-a876-bd6a9cf315d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c6ef569-60b3-4d6e-a876-bd6a9cf315d4?resizing_type=fit)

The Create community wizard

Your community details must respect the **[Fortnite Communities Guidelines](https://communities.epicgames.com/fortnite-communities-guidelines)**.

If you created a brand island, you’re not allowed to use that brand’s name and logo in your community details or brand imagery and logos in your community details. However, once you can create the community, you can create channels and posts with content from your brand island.

### Linking Channels to an Island

You must be the Community Owner in order to link an island to a channel. During the set up of your channel, you can link that channel to an island. Each channel can link to only one island. But, one island can be linked to multiple channels.

Linking your channel to an island does a few things:

- The island linked to the channel shows up at the top of the channel page with a link to the Island page on Fortnite.com.

  [![Island link card at the top of a channel](https://dev.epicgames.com/community/api/documentation/image/34ecd8a3-9f40-4cbd-850d-38d01895c43c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34ecd8a3-9f40-4cbd-850d-38d01895c43c?resizing_type=fit)

  Island link card at the top of a channel
- You can select any post you create in an island channel to publish as an Announcement in Fortnite. The announcement shows up in the following places:

  - The Fortnite Lobby of your island.
  - The Community Highlights section:

    - On your Developer page.
    - On the Island Details page of that island.
    - On the new Following tab in Discover for users that are following you or have favorited your island.

You’ll cultivate your community by writing and publishing posts in Fortnite Communities, then making them into announcements for your islands to engage your players within Fortnite.

## Creating Your Community

Follow these steps to set up your community:

1. Navigate to **[communities.epicgames.com](http://communities.epicgames.com/)**.
2. Click **Create Community** to launch the community setup window.

   [![Explore Communities page](https://dev.epicgames.com/community/api/documentation/image/c694a73d-7401-4eaf-bf40-f1d437ded9e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c694a73d-7401-4eaf-bf40-f1d437ded9e8?resizing_type=fit)

   Explore Communities page
3. Style your community by completing the following:

   1. **Community name**: The community name creates a unique identifier and Community Tag, that is a combination of your community name and a unique hash ID.
   2. **Short description**: This shows at the top of your community page.
   3. **Icon**: This icon represents your community across the platform.
   4. **Art banner**: This shows up at the top of your community page.

   [![Create Community wizard step 1 - Style Your Community](https://dev.epicgames.com/community/api/documentation/image/5b264722-52a8-45e8-9099-1884c5821d5e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b264722-52a8-45e8-9099-1884c5821d5e?resizing_type=fit)

   Create Community wizard step 1 - Style Your Community
4. Create your first channel by giving it a name. At this point you can select an island to link your channel to.

   [![Create Community wizard step 2 - Create An Initial Channel](https://dev.epicgames.com/community/api/documentation/image/a57d4668-acb8-4698-a70e-5dad1429787a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a57d4668-acb8-4698-a70e-5dad1429787a?resizing_type=fit)

   Create Community wizard step 2 - Create An Initial Channel
5. Click **Save** to complete the process.

## Managing Your Community

### Editing Community Details

You can manage the community’s details at any time after creating your community. As a Community Owner you have the following management options when you navigate to the community’s main landing page:

- **Edit Community Details**
- **Add more channels**

Edit your community details by clicking the **gear icon** next to the name of your community.

### Creating Channels

Create a new channel for your community page by selecting one of the following:

- **Add more channels**
- **+ Create new >  Channel**

[![Community front page](https://dev.epicgames.com/community/api/documentation/image/cf635a81-dddc-4d2b-b22a-d7e827c9f0a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf635a81-dddc-4d2b-b22a-d7e827c9f0a4?resizing_type=fit)

Community front page

#### Channel Settings

[![An example of the New Channel form. Add the new channel's name, and decide whether to link the channel to an island or add it to a group. You can also make the channel read only.](https://dev.epicgames.com/community/api/documentation/image/6e88be5a-869a-4f7b-87b5-9aca967d5236?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e88be5a-869a-4f7b-87b5-9aca967d5236?resizing_type=fit)

New Channel form

| Number | Setting | Description |
| --- | --- | --- |
| 1 | **Channel name** | Give your channel a name. You can change your channel name at any time. |
| 2 | **Link channel to an island** | To link an island to a channel, you must be the owner of that island.  Select an island from the dropdown list. A channel can only be linked to one island at a time. You can have multiple channels per island. |
| 3 | **Add to group** | Add your new channel to a pre-existing group from the dropdown list. |
| 4 | **Make this channel read-only** | Enabling read-only on this channel means only the community owner and their team can post in this channel.  Users can still reply to posts you create. |

### Editing Existing Channels

To edit the details of an existing channel, navigate to the channel page. Click the **gear icon** next to the channel name. This opens the details menu for the channel.

[![An example of a Channel Page.](https://dev.epicgames.com/community/api/documentation/image/fda2d370-0092-43cd-b8e4-298fffe072f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fda2d370-0092-43cd-b8e4-298fffe072f3?resizing_type=fit)

Channel Page

### Grouping and Reordering Channels

From your main community landing page, click **Create New** to add a new channel or a new group.

We recommend you create your channels first. Then, if needed, group those channels.

[![The Channels section on the Community front page.](https://dev.epicgames.com/community/api/documentation/image/c0cea1a1-81c1-4c42-bc2f-77ee87b37ec3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c0cea1a1-81c1-4c42-bc2f-77ee87b37ec3?resizing_type=fit)

Channels section on the Community front page

If you create a new group, you can add channels to the group and then reorder them from this window. Drag the ellipsis to the left of the channel name to reorder.

[![The Create group dialog.](https://dev.epicgames.com/community/api/documentation/image/68be3c6d-9eef-4507-95b5-e89eeee5951d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68be3c6d-9eef-4507-95b5-e89eeee5951d?resizing_type=fit)

Create group dialog

If you click on the trash can to the right of a channel in the Edit Group dialog, this will remove the channel from this group. The channel will not be deleted, it will be moved up into the area where ungrouped channels are organized.

Similarly, when you delete a group, all channels currently in that group are placed at the top of your community where ungrouped channels are organized.

### Deleting Posts and Replies

Users can delete their own posts or replies. Users can also report content from other users that violates the [Fortnite Communities Guidelines](https://communities.epicgames.com/fortnite-communities-guidelines). Refer to **[Reporting Content on Fortnite Communities](https://dev.epicgames.com/documentation/en-us/fortnite/reporting-content-on-fortnite-communities-in-fortnite)** for more information.

You may want to have your own rules above and beyond Epic’s that govern how people should engage in your community. This provides you with the option of deleting content from your community that might not violate Epic’s Terms of Service, but that might be off topic or inappropriate in that context.

For example, a channel dedicated to bug reporting might include a rule about posts being specific to bugs and hitches. That way if someone makes posts not related to bugs and fixes, you can delete the post without reporting the user, because their post is off topic to your channel, but doesn’t break the Fortnite Communities Guidelines.

#### Deleting a Post

1. Click the **vertical****ellipsis menu** next to the post title and select **Delete**.

   [![Ellipsis menu on a post for a community moderator](https://dev.epicgames.com/community/api/documentation/image/81734c4f-e71f-4bb3-8d19-063a3ce60992?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81734c4f-e71f-4bb3-8d19-063a3ce60992?resizing_type=fit)

   Ellipsis menu on a post for a community moderator
2. When you delete content you also have the opportunity to report content that breaks the [Fortnite Communities Guidelines](https://communities.epicgames.com/fortnite-communities-guidelines).

   [![Delete content dialog](https://dev.epicgames.com/community/api/documentation/image/b32472f3-2d03-4ccc-a98b-2444b8be4730?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b32472f3-2d03-4ccc-a98b-2444b8be4730?resizing_type=fit)

   Delete content dialog

It’s important that you **report violative content to Epic** so that violations to the terms of service go through the proper escalation process.

Posts that you delete from your community no longer show up in channels. However, users who still have a direct link to that content are able to navigate there. Users can continue to reply to the post.

[![Deleted post shows a placeholder image.](https://dev.epicgames.com/community/api/documentation/image/568c3c90-7c2c-470f-aa83-d11bacd89228?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/568c3c90-7c2c-470f-aa83-d11bacd89228?resizing_type=fit)

Deleted post shows a placeholder image

#### Deleting a Reply

Similar to deleting a post, replies have a Delete option available from the ellipsis menu.

[![Delete option in the ellipsis menu next to a reply](https://dev.epicgames.com/community/api/documentation/image/f6b33b09-2761-4090-bba1-e704ce070aa6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6b33b09-2761-4090-bba1-e704ce070aa6?resizing_type=fit)

Click image to enlarge.

When you delete a reply, that reply can no longer be viewed. Unlike with a post, there is no direct link to view a reply, so no one will be able to see this reply after it’s deleted.

Deleted replies use placeholder text so readers still have the context of the deleted message when reading other users’ responses.

[![An example of the Reply placeholder.](https://dev.epicgames.com/community/api/documentation/image/8cb11a7f-afc9-4126-b429-d4e469437e92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8cb11a7f-afc9-4126-b429-d4e469437e92?resizing_type=fit)

Click image to enlarge.

## Making Announcements in Fortnite

You can select a post and make it into an Announcement in Fortnite. You can only select posts made by the developer, you can’t select community members’ posts to promote into Fortnite.

To turn a post into an Announcement, the post needs to be in a channel linked to an island.

[![An example of setting up an announcement.](https://dev.epicgames.com/community/api/documentation/image/091f8141-e19c-4de3-beb8-cf139493c802?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/091f8141-e19c-4de3-beb8-cf139493c802?resizing_type=fit)

Click image to enlarge.

You can set up the Announcement details at the time that you post the announcement, or click on the ellipsis menu of a post that’s already live and select to edit the post’s  Announcement details.

All announcements must be appropriate for a general audience and abide by **[Fortnite Developer Rules](https://legal.epicgames.com/en-US/fortnite/developer-rules)**.

### Setting a New Post as an Announcement

When you are drafting a post in the post editor, there’s a section labeled **Reach more players with your post**, click the **chevron** to open the Announcement detail.

[![Post editor with the announcement section at the bottom.](https://dev.epicgames.com/community/api/documentation/image/c7dc9225-5272-461a-8ff5-779a92692ba9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7dc9225-5272-461a-8ff5-779a92692ba9?resizing_type=fit)

Post editor with the announcement section at the bottom

|  |  |  |
| --- | --- | --- |
| **Number** | **Option** | **Details** |
| 1 | **Reach more players with your post** | Click the chevron in this section to open the Announcement details form. |
| 2 | **Fortnite Island Lobby** | Clicking this option will show your announcement in the Lobby of the island this channel is linked to. When you publish a new announcement, your latest 2 announcements will be shown in the lobby tiles. |
| 3 | **Community Highlights** | Community Highlights show up in many places across the ecosystem.   - Feeds of users in the platform who are following your community. - The Discover section in Fortnite for users that have:    - Followed you as a developer.   - Favorited your island. - Your Developer page in Fortnite and on [Fortnite.com](http://fortnite.com/). - Your Island Details page in Fortnite and on [Fortnite.com](http://fortnite.com/). |
| 4 | **Short title** | Give your post a short title. There’s limited real estate on the lobby tile, so the maximum character count is 50 characters.No emojis are permitted in the short title. |
| 5 | **Image** | Select the image to show on the Fortnite and Community Highlight tiles. It must be exactly 1920 x 1080 pixels. |
| 6 | **Description** | When a user clicks on your announcement within Fortnite, it will pop a full view in-game. The description that you set here is what will show in that full view.Your description can only contain plain text and emojis. |

Announcements are not available until full launch of the product on **December 11**.

#### Previewing Your Announcement

Click **Preview full view** to preview what the announcement will look like in-game. Note that Fortnite has a more limited emoji library than the web, and some emojis may be removed.

[![Fortnite full view preview.](https://dev.epicgames.com/community/api/documentation/image/753f5979-0851-4fae-988a-96861afd0c0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/753f5979-0851-4fae-988a-96861afd0c0a?resizing_type=fit)

Fortnite full view preview

When you are satisfied with your post, click **Post**. Your post immediately shows up on Fortnite Communities web, and goes through moderation prior to showing up in Fortnite.

### Setting an Existing Post as an Announcement

You can edit an existing post at any time to set it as an Announcement. Open the post in your community, then click the **vertical** **ellipsis menu** and select **Edit**.

[![Click the ellipsis menu on a post to select Edit.](https://dev.epicgames.com/community/api/documentation/image/33bc8a5c-ea81-494c-8cd4-a12d9da2b44b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/33bc8a5c-ea81-494c-8cd4-a12d9da2b44b?resizing_type=fit)

Click the ellipsis menu on a post to select Edit

This opens the **Edit Post** modal with the same options available when creating a new post as an announcement.

[![Edit post modal showing the Announcement section.](https://dev.epicgames.com/community/api/documentation/image/7313a687-46be-46af-be24-097e3f3a6cbc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7313a687-46be-46af-be24-097e3f3a6cbc?resizing_type=fit)

Edit post modal showing the Announcement section

If you make any changes to a post that is set as an Announcement, it re-sends the post through moderation after selecting **Save changes**.

### Moderation of Announcements

While the post is waiting for moderation, it loads with a banner at the top of the page informing you that the post is **In Review**.

[![An example of the the In Review banner.](https://dev.epicgames.com/community/api/documentation/image/291393d3-895e-4eb8-978a-613b8cf2a7c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/291393d3-895e-4eb8-978a-613b8cf2a7c4?resizing_type=fit)

Click image to enalrge.

If your post passes moderation, you’ll see an **Approved** banner, and the content shows up right away in Fortnite as soon as it’s approved.

[![An example of the Approved banner.](https://dev.epicgames.com/community/api/documentation/image/2edfd368-728c-4922-8a72-e8e315abb1fa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2edfd368-728c-4922-8a72-e8e315abb1fa?resizing_type=fit)

Click image to enalrge.

If your post fails moderation, you’ll see a **Failed** banner on the post.

[![An example of the Failed banner.](https://dev.epicgames.com/community/api/documentation/image/a52ab4d4-1215-493b-b076-e6d9a387ff56?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a52ab4d4-1215-493b-b076-e6d9a387ff56?resizing_type=fit)

Click image to enlarge.

To understand why your post failed moderation, click **More Info**.

[![The window showing information about why your post failed moderation.](https://dev.epicgames.com/community/api/documentation/image/b06c6df4-9d67-4bf9-82d2-22ba96458c8f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b06c6df4-9d67-4bf9-82d2-22ba96458c8f?resizing_type=fit)

The window showing information about why your post failed moderation

If your post fails moderation, you will also receive detailed information by email.

You have two choices to resolve a failed post:

1. **Appeal**: If you believe the moderator made a mistake, you can appeal to re-send the post back through moderation without making changes.
2. **Edit post**: To edit your post, click **Edit post** to open the post editor.

   [![The Edit Post dialog.](https://dev.epicgames.com/community/api/documentation/image/8facb4ac-adf0-4f3b-9f99-efa0ec0b99c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8facb4ac-adf0-4f3b-9f99-efa0ec0b99c5?resizing_type=fit)

   The Edit Post dialog

   Make changes to modify your post to be compliant. When you’re ready, click Save Changes to resubmit your post back into moderation.

For any reason if you decide to make changes to an existing, live post, the post is taken down from Fortnite until it passes moderation again.

## Changing Island Ownership

When you transfer ownership of your island to another person, you are no longer able to link that island to your channels.

If the island is already linked to one or more of your channels, then the channels will still exist but that island no longer shows as linked on the Channel page.

Delete a channel if it’s no longer relevant for your community.

[![An example of a channel whose owner has changed.](https://dev.epicgames.com/community/api/documentation/image/f34071e2-e9e5-4d1b-9caa-46320799956c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f34071e2-e9e5-4d1b-9caa-46320799956c?resizing_type=fit)

Click image to enlarge.

The new island owner can create new channels and link one or more of those channels to the island.

## Fortnite Communities Guidelines

There are some basic community guidelines all Fortnite Communities:

- Only logged in users above the age of digital consent can read, write posts, reply to posts, and react to posts or replies.
- Only logged in users can follow developers and favorite islands.
- All content created on Fortnite Communities must be suitable for a general audience.

Find the full list of community guidelines at **[Fortnite Communities Guidelines](https://communities.epicgames.com/fortnite-communities-guidelines)**.

## Frequently Asked Questions

### Who is allowed to create a community?

Fortnite Developers with one or more published islands are able to create a new community.

### Can I have more than one community?

You can have more than one community, but only **your first community** will be directly **linked to your developer profile**. If someone clicks Follow on your developer page, they will also follow your first community. Similarly, if they Unfollow your developer profile, they will unfollow that same community.

### Who can link an island to a channel?

Only the owner of the island will be able to link that island to a channel.

### Can I draft and schedule a post in advance?

Not at this time. You can only publish your post immediately. If a post is set as an Announcement in Fortnite, then it will show live in Fortnite as soon as it passes moderation.

### What are the call to action rules for Announcements in Fortnite?

You must abide by the **[Fortnite Developer Rules](https://legal.epicgames.com/en-US/fortnite/developer-rules)**.
