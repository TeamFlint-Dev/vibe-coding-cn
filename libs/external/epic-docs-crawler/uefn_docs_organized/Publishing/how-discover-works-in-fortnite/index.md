# How Discover Works

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite
> **爬取时间**: 2025-12-26T22:52:55.623930

---

**Fortnite Discover** is where players can find and enjoy a wide variety of experiences. As a creator and developer in Fortnite, it’s important to understand how islands are surfaced in Discover. Focusing on key metrics, utilizing best practices, and understanding the Discover UI will help you attract, engage, and satisfy players, ultimately leading to greater success for your experiences.

This documentation provides a comprehensive overview for creators looking to maximize their island's visibility and success within Discover. For more context on Discover’s vision and goals, check out the **[Discover Vision Blog](https://create.fortnite.com/news/evolving-fortnite-discover-together)**.

As Epic improves Discover in support of this mission, changes will be updated here. Refer to this doc whenever you have questions on Discover.

Below, you can find a comprehensive overview of:

- The **[key metrics](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite#key-metrics)** used to identify successful islands and the Discover Score.
- How **[Sophistication Score](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite#island-prioritization-and-sophistication-score)** impacts testing of both new and updated islands.
- How these metrics influence [which islands appear in Discover](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite#reviewing-the-discover-rows).

## Key Metrics

Discover is driven by three key metrics: **Attraction**, **Engagement**, and **Satisfaction**.

1. **Attraction:** Converting impressions into sustained engagement.
2. **Engagement:** Keeping players engaging, and retaining within your island.
3. **Satisfaction:** Players reporting your island as fun and highly rated, by players favoriting and recommending your experience.

These all combine to form a single **Discover Score** for each island.

### Attraction

**Attraction** measures how you can capture a player's attention and convince them to play your island.

Attraction is measured by:

- **Clicks** per impression.
- **Minutes played** per impression.
- **Percentage of players who leave** in the first two, five, or ten minutes of a session.

To be counted as an **impression**, your island's thumbnail must be 100% visible on the screen and viewable for two seconds or more. If a player clicks your thumbnail, even if it's not fully visible or does not appear for the full two seconds, the impression will still count as an impression based on the click-through result.

**Click-through rate (CTR)** is the ratio of clicks over impressions, measured as a percentage for how many impressions resulted in a click. For example, if your island has 100 impressions and 5 clicks, that is a 5% CTR. CTR measures the effectiveness of your thumbnail and title at capturing player attention and getting players to click.

**Minutes played per impression** is the ratio between impressions and total minutes played. For example, if your experience has 1000 minutes played in the last 96 hours after receiving 100 impressions in the same period, your minutes per impression would be 10. This metric shows whether your impressions are converting to sustained engagement.

**Island details**, or how you describe your island, can also influence player clicks once a thumbnail has caught their attention. You can update the island name and description in [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-uefn-and-fortnite-creative). The information you put in Island Settings shows up in Discover on an island's details screen. You can also change this info in the [Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-from-the-creator-portal-in-fortnite-creative).

[![](https://dev.epicgames.com/community/api/documentation/image/104bb640-0191-4ecd-844a-621feff20511?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/104bb640-0191-4ecd-844a-621feff20511?resizing_type=fit)

**Island tags** are another way to help categorize your island in Discover. These tags are one of the inputs used to identify the genre of the game (see [Category / Genre Grouping Rows](https://dev.epicgames.com/documentation/en-us/fortnite/how-discover-works-in-fortnite#category-genre-grouping-rows)). See [Publishing from the Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-from-the-creator-portal-in-fortnite-creative) for how to add these tags. Also see [Games and Game Tags](https://dev.epicgames.com/documentation/en-us/fortnite-creative/games-and-game-tags-in-fortnite-creative) for more information on the tags themselves.

See [Publishing from the Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-from-the-creator-portal-in-fortnite-creative) for how to add these tags. Also see [Games and Game Tags](https://dev.epicgames.com/documentation/en-us/fortnite/games-and-game-tags-in-fortnite-creative) for more information on the tags themselves.

For more tips on how to increase attraction, see:

- [Creator Marketing Playbook](https://www.fortnite.com/create/creator-marketing-playbook?lang=en-US) for ways to create key marketing assets that will catch player interest and increase click-throughs.
- [Thumbnail Image Guidelines](https://dev.epicgames.com/documentation/en-us/fortnite/thumbnail-image-guidelines-for-discover) for best practices on images in Discover.
- [Project Analytics](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games) to analyze patterns for new and returning players.
- [A/B Thumbnail Testing](https://dev.epicgames.com/documentation/en-us/fortnite/ab-thumbnail-testing-in-fortnite-creative) to validate the effectiveness of different images.

### Engagement

Engagement focuses on keeping players invested and interested in your island once they've entered, and keeping them coming back.

Engagement metrics described here represent how Discover calculates engagement, it does not describe the Engagement Payout formula. To learn more, see [Engagement Payout](https://dev.epicgames.com/documentation/en-us/fortnite/engagement-payout-in-fortnite-creative).

Engagement is measured by:

- **Minutes per player** (typically a 7 day lookback)

  - Capped at 120 minutes per player per day
- **Retention**

  - New to Island D1 (Day 1) retention
  - New to Island D7 (Day 7) retention
  - All Players D1 retention
  - All Players D7 retention
- **Number of unique players** over the last 7 days
- **Minutes spent in a social party**
- **Successful party invites and joins** as a % of unique players

Discover does not count engagement while a player is **idle**. If a player hasn’t registered an input for sixty seconds, they are considered idle and these minutes will not count toward your island's engagement metrics.

To improve engagement:

- Use [Project Analytics](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games) with a focus on session engagement, retention, and minutes per player.
- Also use the [Insights Dashboard](https://dev.epicgames.com/documentation/en-us/fortnite/insights-dashboard-in-fortnite-creative) to learn more about player activity while on your island.
- Continually iterate on game design, features, and work with your community to generate player feedback.
- Find ways to generate social interactions between players and encourage players to invite their friends.

### Satisfaction

**Satisfaction** offers qualitative insights on player experience within your island. This includes factors like how much fun players had, how they rate your game out of 10, and if they favorite or recommend the island.

Satisfaction is measured by:

- **Endorsements:** Players who **Favorite** or **Recommend** your island. (Players have the option of clicking **Favorite** and/or **Recommend** when exiting a game.)
- **Post Match Surveys:** Players who rate your island on fun, satisfaction, quality, or difficulty after they've played.

  - Surveys have a 2% chance of displaying to a player after a game session (unless the player has opted out of surveys). A player cannot be surveyed more than once every 14 days.
  - There are many possible surveys a player might be served, and not all of them relate to Discover.

## New and Updated Content Testing

Discover makes an effort to test every new and updated island to determine their potential for success in Fortnite. A **test** is defined as receiving 50,000 impressions, ideally within a 20 to 60-minute period.

Discover algorithms analyze an island's Attraction, Engagement, and Satisfaction during the test window. Islands with particularly high **[Sophistication Scores](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sophistication-score)** may be tested multiple times in their first week post-launch.

We are also introducing personalized New and Updated content testing. This is designed to deliver and test new content with the most high-conviction audience on release.

We recommend iterating and updating your island post launch after receiving feedback from your community and reviewing analytics in Creator Portal.

### Island Prioritization and Sophistication Score

New islands are prioritized for testing based on their **Sophistication Score**. Updated islands are also prioritized based on theirSophistication Score along with a minimum requirement for development effort over the last 30 days.

The Sophistication Score focuses on the content within your island and the development effort spent building and updating your island. It includes metrics that focus on the usage of devices, animation, sequencers, Verse code, textures, and many other features. As new features are added to UEFN, they may be integrated into future calculations.

Re-using Verse code, devices, and systems from pre-existing islands is a standard and acceptable development practice, and will not trigger copycat detection

Epic uses a modified version of what is conventionally known as a z-score to calculate the Sophistication Score. A z-score shows how many standard deviations a data point is from the population average, letting us compare Sophistication Score metrics across different scales or distributions.

## Discover Filtering

For promotional content that looks **very similar** to another creator’s published content, you’ll get a warning and the opportunity to make changes before submitting your island for content review. Even if you don’t make any changes, you'll be able to proceed with publishing, but doing so could result in your island getting filtered out of certain rows in Discover.

Filtered islands will not appear in:

- Homebar-feeding rows (Trending, People Love, Fan Favorites)
- For You / Personalization
- New & Updated Content Testing rows
- Search via text, generic term, or strings

Filtered islands will still appear in search results via exact island code and all other rows, including Recently Played / Library / Favorites / Creator Pages.

If you or your team are the original creators of the content that matches or nearly matches an existing island, you will not receive a content pre-check warning. You won’t be blocked from publishing or filtered from Discover.

The original creator of a given title or thumbnail is determined using the following criteria:

- **Thumbnails:** The creator or team that first published the thumbnail in the Fortnite ecosystem.
- **Titles:** The creator or team who published an island that either had 100 unique users in the last 96 hours, or accumulated at least 150 minutes of editing time on the project in the last 30 days.

**Please note:**

- Discover Filtering only applies to new releases and island updates starting June 25. If we conduct a retroactive sweep of island titles and thumbnails in the future, we will provide advanced notice before we do so.

- This update will not impact creators who duplicate or iterate on their own original creations.

## How For You Works

The **Dis****cover recommender algorithm** balances **personalization** and **ecosystem health** by looking not only at what individual players enjoy, *but also at how new, **high sophistication score, or fast-rising content** can reach broader audiences.*

We’ve upgraded our **viral detection** and **social graph** systems to better recognize when an island is building momentum.

The **For You** row looks at a player's full play history and their most recently played islands to better understand their **current** discovery intentions and surface content that fits where they are on their player journey.

### Boosting Viral and Social Growth

When content starts trending and resonating with players and friends we react in real time to amplify that momentum. Islands that resonate with a community of players will be surfaced back to that community.

### Deeper Quality Metrics

We’re widening our measurement window (from 4-day to 7-day lookbacks) and incorporating new quality metrics to our content ranking calculations.

### Metrics Used in For You Personalization

| Metrics | How It's Defined |
| --- | --- |
| **Unique Players** (7-day) | Distinct Unique Players |
| **Minutes per Player** (7-day) | Total Minutes / Total Players (capped at 120 mins per player per day) |
| **Bounce Rate** (First 5 min) | % of players that leave before 5 mins |
| **D1 / D7 Retention** (for Players new to your island) | Players that return after 1 day / 7 days |
| **Successful Party Joins** (% of Unique Players) | Successful Joins / Unique Players |
| **Minutes in Social Party** (% of total minutes) | Party Minutes / Total Minutes |

### Personalized New Content Testing

Our aim is to match islands with its most relevant audiences sooner, helping your content reach players who are most likely to enjoy it and not just scroll past it.

### Rewarding Creative Risk

We’re prioritizing content that brings something new to the ecosystem. Islands algorithmically identified as innovative will see stronger visibility boosts compared to repetitive or derivative content.

### Rewarding Quick-to-Immerse

We’re highlighting islands that make it easy for players to jump in and stay engaged. Early retention and smooth onboarding now play a bigger role in exposure.

### Adaptive Content Rotation

We still aim to test every island in Discover, ensuring fair exposure during launch. Islands showing strong early engagement then earn additional promotions dynamically. Great starts are noticed and scaled faster.

### New Content Metrics that Discover Prioritizes

| Metrics — What We Look For | How It's Defined |
| --- | --- |
| **High Hours Per Impression (HPI)** | Total hours / Total impressions |
| **Low Bounce Rate** | % of players that leave before 5 mins |
| **High Novelty and Effort** | Content is innovative and polished (Sophistication score) |

## Reviewing the Discover Rows

The rows that players see in Discover and the order in which they are listed, can change based on the player's **cohort** (age rating, platform, region, personalization opt-in) and the Discover team is frequently experimenting with new rows and orderings to understand how it impacts overall player engagement.

The names on the rows may also vary. The tables below are intended to provide the basis for each row and the islands displayed.

### 🧩 Category / Genre Grouping Rows

These are categories that filter for islands based on template and genre.

|  |  |
| --- | --- |
| **Game Collections****(categories of games)** Games Built Using Popular Collaborations | This row showcases islands developed from brand templates, such as LEGO ® Templates and Fall Guys.  Islands in these rows are filtered by the island template used, and sorted by various engagement metrics. |
| **Featured Collections** | These rows showcase groupings of islands organized by category and genre. Discover identifies the genres of an island through an array of machine-learning models working together to assess island genre or category. These models all operate on various combinations of the same island metadata used in the Island Representation Framework:   - Title - Tags - Description - Devices - Gameplay telemetry (such as time spent playing)   This system also utilizes a **human-in-the-loop** workflow, allowing Discover operators to review and update categorizations as necessary. This acts as reinforcement learning for the models.  An island can be assigned a maximum of three different genres and two different categories, which allows an island to bridge multiple genres and appear in each relevant area of Discover. As an island is updated, and as more players engage with the island, the machine-learning categorizations are re-run to ensure islands continuously appear in the right place. |

### 🧑‍🎨 Editorial Rows

These rows showcase islands created by Epic and islands selected by Epic staff.

|  |  |
| --- | --- |
| **By Epic** | This row features islands developed or published by Epic Games. The content is editorially selected and not impacted by player metrics. No third-party content is included. |
| **Epic’s Picks** | This row features highly-polished, innovative islands selected by Epic’s editorial team. These selections highlight standout gameplay or creative use of mechanics. Islands in this row are manually curated and subject to quality reviews before being featured. |

### 🔥 Performance-Based Rows

Each of these rows are driven by overall metrics, as described for each category.

|  |  |
| --- | --- |
| **Top Rated** | This row prioritizes islands with the highest aggregated Satisfaction scores (Currently prioritizes Fun ratings).  Only islands with >= 25% D1 (Day 1) retention and >= 20 player survey responses can qualify. Sophistication Score filters aim to remove low-effort or misleading experiences.  Frequently, this row is regionalized and sorted by metrics per country. |
| **Most Engaging** | This row prioritizes islands with the highest minutes per player over the past 96 hours.  Islands must have >= 25% D1 (Day 1) retention and have an average of 100 concurrent users (CCU) in the past 96 hours to qualify for this row.  When this row places islands into the homebar, there is also a maximum 5M impressions limit. Sophistication Score filters aim to remove low-effort or misleading experiences.  Frequently, this row is regionalized and sorted by metrics per country. |
| **Popular** | This row prioritizes islands with the highest minutes per impression over the past 96 hours.  Islands must have an average CCU in the past 48 hours >= 2000, and minutes per player >= 15.  When this row places islands into the homebar, there is also a maximum 5M impressions limit. |
| **People Love** | This row prioritizes Variety islands in the top 10% of D1 (Day 1) retention, followed by minutes per player in the last 96 hours.  Islands must have reached at least 1000 CCU in the past 96 hours to qualify. Only islands categorized as Variety can qualify.   When this row places islands into the homebar, there is also a maximum limit of 5M impressions per 100 hours. |
| Fan Favorites | This row prioritizes Battle Royale and Combat islands in the top 10% of D1 retention (Day 1), followed by minutes per player in the last 96 hours.  Islands must have reached at least 1000 CCU in the past 96 hours to qualify. Only islands categorized as Battle Royale and Combat can qualify.  When this row places islands into the homebar, there is also a maximum limit of 5M impressions. |
| **Trending Variety** | This row prioritizes islands Variety genre islands that have high CCU growth or islands with high total search volume. |

### ⏱ Lifecycle Rows

Rows that display recently played or recently published islands.

|  |  |
| --- | --- |
| Recently Played | This row displays a player’s most recently played islands. It includes all  island types without ranking or filtering, unless the island has become private or delisted.  The list updates dynamically based on the player's session history. Islands in recently played last for 90 days before are no longer considered recent. |
| New and Updated | These rows display newly published or recently updated islands to allow them to reenter Discover.  Discover also applies filters to reduce spam or unchanged islands. |
| New Updates This Week / New Experiences | These rows are additional spaces to display new and updated content that may have been missed in the New and Updated testing flow.  Discover also applies filters to reduce spam or unchanged copies. |

### 🎮 Genre / Play Style Rows

All genre rows are sorted by concurrent users (CCU) descending with the largest number of concurrent players first. There are many game genres in the ecosystem, such as Variety, Combat, Horror, Tycoon, Fashion, Driving, Prop Hunt, and more! To see the full list of genres, check out [Games and Game Tags](https://dev.epicgames.com/documentation/en-us/fortnite-creative/games-and-game-tags-in-fortnite-creative).

## How Search Works

**Search** is an important way for players to find specific islands and genres within Fortnite. It uses a hybrid approach combining two algorithms: keyword matching and semantic search. **Keyword matching** returns islands that contain text that exactly matches the user’s query. **Semantic search** returns islands that are “semantically similar” to a user’s query.

This hybrid approach allows players to find content using generic terminology while also supporting very specific searches. For example:

| Search Algorithm Type | Search Term | Result |
| --- | --- | --- |
| **Semantic** | space | Islands set on the moon |
| **Semantic** | scary tycoons | Horror-themed tycoon islands, Zombie tycoons |
| **Keyword** | ffa | Free-for-all islands |
| **Keyword** | Reload | Reload |

Once results are compiled from a search, they are algorithmically sorted based on features like:

- Semantic similarity to the search term used
- Keyword match (if present)
- Concurrent users (CCU) at that moment, coupled with other variables
- Confirmed recent search count

When search results appear, they are sorted to show the most relevant results to the player’s query. This is based on what players are most likely to be looking for and current trends in the ecosystem.

The search algorithm is continuously improved by integrating more data and variables on island metadata, performance, and player preferences. By continuing to iterate on the algorithm, we will be able to develop a more pointed and dynamic search experience based on current player behavior. We are also A/B testing different search algorithms to make sure we’re delivering the best search experience possible.

[![](https://dev.epicgames.com/community/api/documentation/image/3a11f00f-50b8-48fa-8569-0ea252067a18?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3a11f00f-50b8-48fa-8569-0ea252067a18?resizing_type=fit)

The search page in Discover also allows players to browse by Featured and All Categories.

## Closing Tips for Improving Your Island's Visibility

In this guide, we walked through how Discover works by explaining the metrics that contribute to the Discover Score and how the Sophistication Score affects your island’s prioritization and testing.

With this knowledge you can increase your island’s visibility by:

- Focus on converting impressions into sustained play, and bringing players back.
- Leverage your Creator Analytics by understanding how players will see, click, and engage with your island.
- Iterate and update continuously to create a more engaging and fun experience for your players.

Epic is committed to providing the best experience for our creators. With a thorough understanding of how Discover works, combined with your island analytics, you can optimize your island for success.
