# Links

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/links-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:13:38.963614

---

**Direct Links** allow you to create custom URLs that send players directly into your Fortnite island, no extra steps needed. These links can be shared with your community or used in your social media or marketing campaigns to make it easier for players to jump right in.

When players use a Direct Link, any subsequent plays or active players on your island will be attributed to the link created. Direct links are also one factor used in attribution for User Acquisition Rewards which contribute to **[Engagement Payouts (EP)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary)**, and reward developers for bringing in new players and reengaging lapsed players in Fortnite. Learn more about how [Engagement Payout](https://dev.epicgames.com/documentation/en-us/fortnite/engagement-payout-in-fortnite-creative) is calculated and how attribution for [User Acquisition Rewards](https://dev.epicgames.com/documentation/en-us/fortnite/engagement-payout-in-fortnite-creative#monetization) from Direct links works.

Direct Links are managed in the **Creator Portal** on a per-island basis for all published islands.

## Accessing Links

You can access the **Links** tab from your [project navigation menu](https://dev.epicgames.com/documentation/en-us/fortnite/project-navigation-menu-in-fortnite):

1. Log in to the Creator Portal.
2. Select your **project**.
3. Click the **Links** tab.

   [![Click Link from the project navigation menu, then click Create link.](https://dev.epicgames.com/community/api/documentation/image/02994641-8fa4-4c7c-a088-4ee19f1e4d03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02994641-8fa4-4c7c-a088-4ee19f1e4d03?resizing_type=fit)

   Click image to enlarge.

   Or click the **Share** button on your **Project** page and select **Create Link**.

   [![Click the Share button on your Project page and select Create Link.](https://dev.epicgames.com/community/api/documentation/image/c99b5f54-f5fe-47a2-afe0-8ba1fad5b2a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c99b5f54-f5fe-47a2-afe0-8ba1fad5b2a7?resizing_type=fit)

   Click image to enlarge.

Here you’ll find options to **create**, **view**, and **manage** your links.

## Creating a Link

The **Create Link** page allows you to generate a unique, trackable link for your island. This link sends players directly into Fortnite to start playing.

To create a direct link, follow the steps below:

1. Select **Create Link**.

   [![An example of the Create Link pop-up window.](https://dev.epicgames.com/community/api/documentation/image/f164e3c1-508d-46c7-b2a0-8f3de39d482e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f164e3c1-508d-46c7-b2a0-8f3de39d482e?resizing_type=fit)

   Click image to enlarge.
2. Name your link. This name helps you track link performance (for example, “TikTokCampaign\_November”).
3. Select **Get Link**.
4. Click **Done** to copy your Link and close the pop-up.

   [![An example of a completed Create a link pop-up window.](https://dev.epicgames.com/community/api/documentation/image/3ab1954e-d904-4c01-9365-6676251bc16f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ab1954e-d904-4c01-9365-6676251bc16f?resizing_type=fit)

   Click image to enlarge.

Your direct link will appear on your **Links** page.

Use meaningful link names to easily measure campaign success across multiple sources.

## Managing Links

The **Links** page provides an overview of all links created for your island.

### Links Features

|  |  |
| --- | --- |
| **Column** | **Description** |
| **Link Name** | The custom name you gave your link. |
| **URL** | The generated Direct Link players can use to join your island. |
| **Created By** | The developer who generated the link. |
| **Created Date** | When the link was created. |
| **Metrics** | Key data about link performance (Plays, Active Players). |

### Editing Links

Links are editable from the Creator Portal. To edit a link, follow these steps:

1. Open the Links page and select the link you wish to edit.

   [![Click the ellipsis menu and select Edit link name to edit the link's name.](https://dev.epicgames.com/community/api/documentation/image/57d09b69-8ef2-4a1f-9bb0-54ca8f08b380?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/57d09b69-8ef2-4a1f-9bb0-54ca8f08b380?resizing_type=fit)

   Click image to enlarge.
2. Add a new link name and click **Save**.

   [![Rename the link then click Done to finish changing the name of your link.](https://dev.epicgames.com/community/api/documentation/image/d20f0846-048d-42b0-be21-b72159ac854f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d20f0846-048d-42b0-be21-b72159ac854f?resizing_type=fit)

   Click image to enlarge.

The link is updated to the new link name.

## Understanding Link Metrics

You can find metrics for your links on the **Engagement** tab of the [Project Analytics](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games) page. When you examine the performance of your links, two key metrics will be shown side by side:

- **Plays**
- **Active Players**

[![An example of the list of links.](https://dev.epicgames.com/community/api/documentation/image/906a99db-3b34-44fb-949f-91381ecf528b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/906a99db-3b34-44fb-949f-91381ecf528b?resizing_type=fit)

Click image to enlarge.

To draw meaningful insights, it’s important to understand how the key metrics differ, how they’re calculated, and how to use them to gauge [click-through-rates (CTR)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#clickthrough-rate).

### Plays

- A **Play** is counted **each time** a session is started on your island via the Direct Link.
- This count is **not unique**; the same player may generate multiple Plays if they launch the island multiple times.
- For example, if Player A clicks your Direct Link and plays, then later returns and clicks again, that counts as 2 Plays.
- Plays help you understand **session volume**, or how often people are using your link to start sessions.

Because Plays can accumulate rapidly (especially from repeated users), they are useful in measuring total usage, campaign traction, or spikes in activity. But they **do not** tell you how many **distinct** individuals used the link.

### Active Players

- **Active Players** represents the total number of **unique players** who have used your direct link.
- Each player is only counted **once**, regardless of how many times they use the link.
- This metric gives you a clearer sense of your **reach** and **audience** driven by a direct link,

In Fortnite’s project analytics, **[Active Players](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games)** is used in the Engagement tab to show the number of unique users daily within the time frame you specify.

## Best Practices

To get the best out of your direct links, follow these best practices:

- Use direct links across your **social media**, **Influencer campaigns**, or **community events**.
- Name links consistently for easier analytics.
- Check performance regularly in **Creator Portal**.
