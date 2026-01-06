# Fortnite Data API Overview

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-fortnite-data-api-in-fortnite
> **爬取时间**: 2025-12-27T02:24:45.994316

---

The **Fortnite Data API** is a new publicly-available API that provides access for creators to key performance metrics from all Epic-made game modes, and eventually for all islands, both Epic-made and creator-made.

We're providing access to this data so that you can make data-driven decisions as you build, improve, and expand your creations across Fortnite.

This API gives you accurate, reliable, and timely access to data you need to be successful. Initially, the data available through the API covers the following intervals, with basic rate-limiting in place to ensure stability and fairness:

- Ten-minute intervals
- One-hour intervals
- Twenty-four hour intervals

You can also query for data that goes back for seven days.

The Fortnite Data API makes the following island performance data available:

- **Minutes Played**: Total minutes played by all players
- **Minutes per Player:** Average total minutes per unique player
- **Plays:** Number of game sessions played
- **Favorites:** Number of times players favorited the island
- **Recommends:** Number of times players recommended the island (previously "Likes")
- **Peak CCU**: Peak concurrent player count
- **Unique Players:** Number of distinct players
- **Retention D1:** Day-over-day retention
- **Retention D7:** Week-over-week retention

Anyone can explore the data available now for all islands, and see the full API documentation for direct access and detailed guidance. Keep an eye out for your favorite third-party analytics websites too, who may integrate this API directly.

You can access the API at the [Fortnite Data API Swagger page](https://api.fortnite.com/ecosystem/v1/docs).

### Frequently Asked Questions

### What islands can I access data for?

Data is only available for islands that are public and discoverable in Fortnite.

### What time period does the data cover?

The Data API initially provides data covering the last ten minutes, the last hour, and the last twenty-four-hour period. 
You can query for data that goes back seven days from the present date. We plan to expand the API to include more granular data in the future.

### How do I access the data?

The Data API is publicly accessible and doesn't require authentication. You can access it directly with the instructions provided in our detailed API documentation, or through third-party analytics sites that might integrate this data directly.

### Why does the data from the API not match what I see in Creator Portal?

There might be some data discrepancies between what you see through the API and what you see in Creator Portal, due to how frequently the data is calculated.

### Are there limits on how often I can access the API?

Yes, some rate-limiting will be in place to make sure the API remains stable and accessible for all creators. Specific details on these limits are available in our API documentation.

### Can I integrate this API with my own analytics tools or dashboards?

Absolutely. The API is designed for flexibility, so you can integrate it with your custom analytics tools or third-party platforms. This allows you to visualize and interpret the data however you need to.

### Are there any privacy concerns with the data provided?

No personal player information is shared through the API. All metrics focus strictly on aggregated engagement data for islands, which maintains player privacy and confidentiality.

### When creator-made island data becomes public, can I opt out of having my island’s data included?

No, opting out isn't possible. Data transparency applies equally to all islands published within the Fortnite ecosystem, which is why we’re sharing data from Epic-made islands as well.
