# Campaign Bidding and Auction Mechanics

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/campaign-bidding-and-auction-mechanics-in-fortnite>
> **爬取时间**: 2025-12-27T00:01:33.119322

---

[Sponsored Row](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sponsored-row) uses a **bidding and [auction](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#auction) model** to determine which islands appear in the Sponsored Row in Discover. The goal of Sponsored Row is to help creators generate visibility based on **[impressions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#impression)** that translate into **[clicks](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#clicks) and plays**, growing your island’s audience directly in Discover.

## Bids and the Auction Model

Sponsored Row pricing is determined by an **auction model**.

- All bids are expressed as **[Cost Per Mille](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#cost-per-mille) ([CPM](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#cpm))**.
- Bid prices must be between a **$0.10–$20 CPM**.
- Daily budgets must be between **$5–$25,000**.
- Campaign duration can last **1–30 days**.
- The Sponsored Row uses a **[second-price auction model](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#secondprice-auction-model)** to determine the winner.
- Once your daily budget is reached, your campaign stops delivering impressions for that day.

Below are in-depth explanations of the Sponsored Row campaign bids and auction model.

## Bid Mechanics

During the campaign creation process, you’re asked to determine a **Duration,** **Daily Budget**, and **Max Bid**.

- **Max Bid (CPM)**: The most you’re willing to pay per 1,000 impressions.
- **Max Daily Budget**: The most you’ll spend per day.
- **Campaign Duration**: The number of days your campaign will run.

These inputs are controlled by you. However, once a campaign has launched, if you want to change any of these parameters, you will need to cancel the current campaign and create a new one with new Duration, Daily Budget, and Max Bid amounts.

### Budget and Duration Strategy

Having a bid and duration strategy can help you maximize the effectiveness of your campaign. Important considerations include:

- **Budget to signal**: Aim for at least **greater than 5,000 impressions** a day to get a reliable read on [click-through rate (CTR)](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#clickthrough-rate) and [playtime analytics](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games#players-tab).
- **Scale thoughtfully**: Increase your daily budget **after** you see the [player engagement](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games#players-tab) increase.

  If player engagement remains consistently low, or engagement goes down after your campaign is live, make adjustments to your island thumbnail image, game description, and island title before raising your spending.

- **Duration**: Short bursts (1–3 days) are great for testing or events you create around your island. A longer run helps to sustain momentum and give the auction more opportunity to generate impressions for visibility.

### Impressions

You should aim to receive a certain number of [impressions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#impression) of your island tile. Below are estimations to help you determine how many impressions to target.

**[Estimated Impressions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#estimated-impressions):**

- The Max Daily Budget is divided by the CPM, then multiplied by 1,000 impressions. That total becomes the number of impressions you are targeting with your Max Daily Budget.

  `(Max Daily Budget ÷ Bid CPM) × 1,000`

  For example, if you spend $50 a day with a Max Bid of $1.50, divide what you spend a day by your Max Bid amount, then multiply that total by 1,000. That equals 33,333 impressions a day.

  `(50 ÷ 1.50) × 1,000 ≈ 33,333`

**Why delivered impressions can be higher:**

- In a second‑price auction
  , if you’re the highest bidder, you pay **$0.01 more** than the next-highest bid. This helps stretch your budget and get more impressions.

  For example, if you spend $50 a day with a Max Bid of $1.50 and a CPM of $1.00, then the number of impressions could be 50,000 impressions a day.

  `(50 ÷ 1.00) × 1,000 ≈ 50,000`

### Max Bid Price (CPM)

To determine the Max Bid Price after your campaign, begin by understanding the **[market history](https://dev.epicgames.com/documentation/en-us/fortnite/creating-and-editing-campaigns-in-fortnite#market-history-nbsp)**.  The **Market History** chart shows the average winning bid (CPMs) for the past 7 days, 1 month, and 3 months.

1. **Use practical starting points.**

   - If you’re primarily testing your creative inputs (tile/title/thumbnail), choose a **moderate bid** and a **modest budget** to get data quickly on your campaign.
   - If you’re launching a major update or event, consider a higher bid and a meaningful budget to ensure visible delivery.

2. **Establish your guardrails.** If your CPM is **too low** relative to other developers, you may win zero impressions on that day. For more information, see **[Auction Mechanics](https://dev.epicgames.com/documentation/en-us/fortnite/campaign-bidding-and-auction-mechanics-in-fortnite#auction-mechanics)** below.

## Second-Price Auctions

Sponsored Row campaigns use a **second-price auction** model. This means that the winning bid is the highest bid in the auction, but the winner pays the **price submitted by the second-highest bidder** plus $0.01.

[![An example of the second price auction model where multiple developers are bidding on a spot on Sponsored Row.](https://dev.epicgames.com/community/api/documentation/image/1c53ad8d-6b06-4ce8-96e6-36385ccef5d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c53ad8d-6b06-4ce8-96e6-36385ccef5d4?resizing_type=fit)

Click image to enlarge.

For example, during an auction, creators bid the following amounts:

- Creator A bids **$5**.
- Creator B bids **$4**.
- Creator C bids **$3**.

**Developer****A** wins the auction because they bid $5, but Developer A only pays **$4.01** (the bid of Der B plus one cent).

See **[Campaign Payments](https://dev.epicgames.com/documentation/en-us/fortnite/campaign-payments-in-fortnite)** to learn more about paying for delivered impressions daily.

During a second-price auction you can expect:

- The highest bidder wins.
- The winner pays **$0.01** **higher** than the second-highest bid, not their full maximum.
- You are never charged above your set daily maximum budget, even if the system overdelivers impressions.

The advantage of the second-price auction model is that it rewards honest bidding. You’re encouraged to bid what promoting your island is truly worth to you, based on how valuable that exposure is during your selected date. Even if you win, you’ll only pay slightly more than the next highest bid.

Once your daily budget is reached, your campaign stops delivering impressions for the day.

**What this means for you**

- The bid price sets your **priority**; the budget sets your **scale**.
- You often pay **less than your bid** (second‑price), so your budget can go farther than expected. See **[Impression Estimates](https://dev.epicgames.com/documentation/en-us/fortnite/campaign-bidding-and-auction-mechanics-in-fortnite#impression-estimates)** below for more details and calculating impressions.
- Campaign delivery is **intentionally clustered** to help you capture meaningful concurrent player activity.

### Auction Mechanics

The Sponsored Row auction works through:

- **Daily competition**: Each day at 00:00 coordinated universal time (UTC), all eligible, approved campaigns for that date are evaluated.
- **Second‑price auction**: Higher bids win delivery earlier and higher in the row. The auction winner pays just above the next highest bid (not their full bid).
  If there’s no next bid, the auction winner pays the minimum price of $0.10.
- **Ties and rotation**:
  If multiple campaigns have the same max bid, they pay that bid amount, and their placement rotates regularly to ensure fair exposure during delivery.
- **Delivery and budget**: Once your island tile is in the Sponsored Row rotation, it continues to deliver until your daily budget is met, or until the day ends.
- **Automated protectio**n:
  If the performance of an island's click-through-rate ([CTR](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#ctr)), [bounce rate](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#bounce-rate), or session length is low, your island may be removed from the sponsored row, and your campaign canceled. This is done to keep you from using your budget without meaningful results.

[![An example of checking the Market History to see how successful the campaign is.](https://dev.epicgames.com/community/api/documentation/image/e092a545-1d6e-4d68-87f1-af4d7bd3629b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e092a545-1d6e-4d68-87f1-af4d7bd3629b?resizing_type=fit)

Click image to enlarge.
