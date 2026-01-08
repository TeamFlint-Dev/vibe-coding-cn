# Unpublishing Islands

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/unpublishing-islands-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:14:23.761105

---

Unpublishing islands provides you with flexibility and allows you to remove access and visibility from non-team members and players.

Submitting a release to an unpublished state means you get the island code and can determine when to change the island to a Listed state. Removing island visibility for non-team members and players means the island code can’t be used and the island won’t show up on your Creator page or in Discovery.

Unpublishing your island is not permanent, and you can republish the island with the same island code at any time.

When an island has been unpublished:

- It is removed from Engagement Payout eligibility.
- The island is no longer accessible by players.
- The public island page returns a 404 error when players attempt to play an unpublished island from in-game or from fortnite.com.

You'll receive engagement payouts only for the period of time an island is in an active published state. You can still see the island analytics prior to the unpublish date, but the analytics of unpublished islands are no longer included in relevant charts and analytics pages once the island is unpublished because no data is gathered.

## Unpublishing an Island

To unpublish an island you must have one of the following active roles on the project:

- Project Owner
- Administrator
- Publisher

To unpublish an island, follow the steps below:

1. Click the project tile to open the island's **Publishing** page.

   [![Open the island’s Publishing page.](https://dev.epicgames.com/community/api/documentation/image/9207134f-9274-4a83-a3c2-f41f5afd3280?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9207134f-9274-4a83-a3c2-f41f5afd3280?resizing_type=fit)

   An Island's Publishing page
2. In the upper part of the left navigation panel, click the Status dropdown to expand it.

   [![Expand the Status dropdown menu](https://dev.epicgames.com/community/api/documentation/image/15a90b59-ac4a-4f4d-827d-63ea81b3b2e4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15a90b59-ac4a-4f4d-827d-63ea81b3b2e4?resizing_type=fit)

   Expand the Status dropdown menu
3. Select **Unpublish**. A warning popup window opens.

   [![When you select Unpublish, a warning dialog displays.](https://dev.epicgames.com/community/api/documentation/image/696eda1c-34e0-47b5-a9f4-9f3e5a8b945b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/696eda1c-34e0-47b5-a9f4-9f3e5a8b945b?resizing_type=fit)

   Unpublish warning dialog
4. Click Unpublish to confirm.  A green message will appear at the top of the Publishing page saying **Island Unpublished**.

   [![After confirming by clicking Unpublish, the Publishing page displays an Island Unpublished message.](https://dev.epicgames.com/community/api/documentation/image/9228b5a5-000e-47d9-bf5a-7c895c47595b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9228b5a5-000e-47d9-bf5a-7c895c47595b?resizing_type=fit)

   Island Unpublished message

You’ll see a notification that your island has been unpublished, and the island’s visibility state  will update to **Unpublished**.

### Submitting a Release to an Unpublished State

Sometimes you may want to have an island automatically set to an unpublished state once it passes content review. To do this, you can set the visibility for the new release during the release submission flow. In the final Visibility section of the submission process, simply select the **Manually publish later** option.

[![Choose Manually publish later during the publishing process.](https://dev.epicgames.com/community/api/documentation/image/ff0e09e7-4d92-4b7b-952b-91a7f16c0e25?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ff0e09e7-4d92-4b7b-952b-91a7f16c0e25?resizing_type=fit)

Manually publish later option

Once the release has been approved, the island visibility will automatically be set to Unpublished.

[![Once the release is approved, the island displays as Unpublished.](https://dev.epicgames.com/community/api/documentation/image/c1841457-f7f6-4e7e-9d6b-e2a206d1fe03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1841457-f7f6-4e7e-9d6b-e2a206d1fe03?resizing_type=fit)

Island visibility set to Unpublished

When you’re ready to publish, click the three dot menu next to the approved release and select the **Publish now** option.

[![Click the three dot menu, and select Publish now.](https://dev.epicgames.com/community/api/documentation/image/407293e2-e978-487f-b539-170958882ac2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/407293e2-e978-487f-b539-170958882ac2?resizing_type=fit)

Three dot menu options - Publish now

In the popup window that opens, select your desired visibility and click **Publish**.

[![The Publish release now dialog displays, select the visibility and click Publish.](https://dev.epicgames.com/community/api/documentation/image/08de71ae-3d90-4e86-8806-3c46d1a69785?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/08de71ae-3d90-4e86-8806-3c46d1a69785?resizing_type=fit)

Publish release now dialog

## Working on Unpublished Islands

You can still access an island that is unpublished in Fortnite Creative and UEFN. When an island is unpublished, you can update the gameplay to add new features and functionality to your island.

All past private versions of the island code are still accessible by team members. This includes any playtest versions of the island code.

If you make any changes to an island while it's unpublished, you will need to create a new release and submit it for moderation before you can republish it.

## Republishing Islands

You can republish an unpublished island only if the island has an existing approved release. If it does, there’s no need to go through the full release submission and moderation process to republish an unpublished island.

To republish an island:

1. Go to the island's Publishing page in Creator Portal and select the **Releases** tab.

   [![For an approved release, you can republish from the island's Publishing page.](https://dev.epicgames.com/community/api/documentation/image/4d0cabf4-83d1-47e7-9cfe-7bdf295f9e71?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d0cabf4-83d1-47e7-9cfe-7bdf295f9e71?resizing_type=fit)

   Republish an approved release
2. Click the three dot menu next to the approved release you want to republish and select the **Publish now** option.

   [![Click the three-dot menu and select Publish now.](https://dev.epicgames.com/community/api/documentation/image/1e49f106-19bd-4e40-8f92-ac20f7451559?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e49f106-19bd-4e40-8f92-ac20f7451559?resizing_type=fit)

   Publish Now option
3. In the popup window that opens, select your desired visibility and click **Publish**.

   [![Select visibility and click Publish.](https://dev.epicgames.com/community/api/documentation/image/34cbde10-1c22-4d43-8fd0-a1c46ce0f24c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34cbde10-1c22-4d43-8fd0-a1c46ce0f24c?resizing_type=fit)

   Publish release now confirmation dialog

Your island is now republished, and the island’s visibility state under the thumbnail will update to the option you selected.

Creators cannot republish island codes that were previously unpublished by Epic internal staff due to T&S violations.

Republishing an island means that:

- Players are able to access the island again using the same public island code as before.
- The island now appears on the public island page, and is eligible to appear in Discover. If you set the island to Listed, it will also appear in your Creator page.
- The island is again eligible for Engagement Payouts and Analytics.
