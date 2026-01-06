# A/B Thumbnail Testing

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/ab-thumbnail-testing-in-fortnite-creative
> **爬取时间**: 2025-12-26T22:59:45.993373

---

The publishing and development process offers creators the opportunity to run an A/B test on island thumbnails to compare two different images to see which one drives more clicks and a higher click-through rate (CTR) — all backed by real player data to help you optimize engagement, reduce guesswork, and iterate faster.

Only a team member with publishing permission has the ability to create an A/B test and select which thumbnail to use after testing is complete.

## Start A/B Testing

A/B testing is part of the publishing process but it is not mandatory. To learn more about submitting a single thumbnail, see the **Cancel Testing** section below.

Under the **Promotional Materials** tab, submit your two thumbnails. To begin A/B testing:

1. Ensure the two thumbnails are different.
2. Add any other media assets.
3. Click **Next** to continue.

   [![Upload two thumbnail images to see which one gets higher engagement for your island.](https://dev.epicgames.com/community/api/documentation/image/17bd5ff0-4d9c-4f4d-a32a-dc5cc3d2f560?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17bd5ff0-4d9c-4f4d-a32a-dc5cc3d2f560?resizing_type=fit)

   Promotional Media - A/B Thumbnail Testing.

The additional thumbnail will not get flagged as a duplicate.

### Thumbnail Moderation

If one thumbnail image fails moderation, the whole island will fail as well, and will need to go through the publishing and review process again after you correct the failed image.

### New Release

While the island is in mid-A/B testing, you cannot create a new release, but must wait until the A/B testing is complete and you've selected an image. Once you've done this, the **Create new release** button becomes available.

[![If you try to move forward before selecting an image, you'll be prompted to go back.](https://dev.epicgames.com/community/api/documentation/image/0c5cf247-9a96-46de-b264-635246ab8968?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0c5cf247-9a96-46de-b264-635246ab8968?resizing_type=fit)

If you try to move forward before selecting an image, you'll be prompted to go back.

### Cancel Testing

You can cancel testing at any time by selecting either image being tested.

If you’re in the middle of creating a new release and don’t want to do A/B testing, you have the option to use a single thumbnail to continue moving forward.

1. Select **Cancel A/B test**.
2. Click **Next**. You’ll receive a prompt.

   [![Click Cancel A/B Test to publish with one thumbnail image.](https://dev.epicgames.com/community/api/documentation/image/ee8400fc-2567-4c84-a61b-eef0340a5a44?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee8400fc-2567-4c84-a61b-eef0340a5a44?resizing_type=fit)

   Cancel A/B Test
3. Select **Use single thumbnail**.

   [![Confirm that you're continuing with a single thumbnail.](https://dev.epicgames.com/community/api/documentation/image/c1167d7d-c678-42e8-ab1c-bef6a7f571a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c1167d7d-c678-42e8-ab1c-bef6a7f571a8?resizing_type=fit)

   Confirm that you're continuing with a single thumbnail.

Continue through the publishing process with a single thumbnail.

## Thumbnail Testing Metrics

Each thumbnail collects data after the island is published. An equal distribution of each thumbnail is sent to potential players. A/B-tested thumbnails are applied to the in-game **Discover** page, **browse** and **search**. Once a player sees a particular thumbnail for an island, they will only see that thumbnail moving forward.

Testing runs for a maximum of **90 days**. Results are found on the island's **Publishing** page under the **Release module**. The following A/B testing data will be available:

- **Impressions**
- **Clicks**
- **Click-Through Rate (CTR)**

[![Analytics collected during testing include: Impressions, Clicks, and Click-Through Rate.](https://dev.epicgames.com/community/api/documentation/image/ba4d64d2-a18a-452e-895b-d08b2f23c294?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba4d64d2-a18a-452e-895b-d08b2f23c294?resizing_type=fit)

Analytics collected during testing.

## Testing Results

You can end the test by selecting a thumbnail anytime after the test starts. After 90 days, if you don’t end the test yourself, the system will select a default thumbnail on your behalf based on best results.

To select a thumbnail:

1. Click the image selection prompt in the thumbnail row. A pop-up window opens.

   [![Select an image to continue with.](https://dev.epicgames.com/community/api/documentation/image/fdb9369d-032b-47be-8c2a-95d11c9ee0b4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdb9369d-032b-47be-8c2a-95d11c9ee0b4?resizing_type=fit)

   Select an image.
2. Click **Select**.

   [![Click Select to continue using the selected image.](https://dev.epicgames.com/community/api/documentation/image/b11b2970-537e-4363-acad-cf23e6f6b37a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b11b2970-537e-4363-acad-cf23e6f6b37a?resizing_type=fit)

   Click Select.

The selected thumbnail is marked as Selected and remains highlighted in the Release tab, while the thumbnail not chosen becomes unselectable. Collapse the A/B testing view to see a dated Completed test status under the release. This marks the date the selected thumbnail will appear as the image for the island for all players

[![Collapsed view of the A/B Testing on the project.](https://dev.epicgames.com/community/api/documentation/image/a72d6282-1240-42b6-841c-1cff1d4d29a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a72d6282-1240-42b6-841c-1cff1d4d29a5?resizing_type=fit)

Collapsed view of the A/B Testing on the project.

If you do not choose a thumbnail after the 90-day testing period, the system automatically chooses the thumbnail. If a significant result is reached, it will assign the image with higher CTR as the chosen thumbnail. If no significant result is reached, it will assign thumbnail A — the first thumbnail uploaded.

### Insufficient Results

It’s possible that there will be no clear winner after the testing period is over. In this case, your A/B test result is flagged **Insufficient Results**.

[![If there is no clear winner, the A/B Test is labeled Insufficient Results.](https://dev.epicgames.com/community/api/documentation/image/92302895-29f2-43b6-8c15-6817ea4bff36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92302895-29f2-43b6-8c15-6817ea4bff36?resizing_type=fit)

Insufficient Results

You can still select a thumbnail at this point. Doing so opens a pop-up message informing you that there was no clear winner.

To conclude A/B testing:

1. Click **Select Image** to continue using the selected thumbnail. A pop-up opens.
2. Click **Select** to complete the testing phase.

[![](https://dev.epicgames.com/community/api/documentation/image/1bc34b17-6cc9-483f-b283-3cc50d5607bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1bc34b17-6cc9-483f-b283-3cc50d5607bb?resizing_type=fit)

Should you decide to create a new A/B test, you must go through the publish and moderation process again.

## A/B Testing FAQs

The following is a general overview of questions about the A/B testing process.

### What is A/B thumbnail testing?

A/B thumbnail testing provides a way to compare different thumbnails to determine which one performs best in terms of **Click-through rates (CTR)**. The feature provides data-driven insights to help you optimize your island’s engagement by using the most effective thumbnail.

### Who is this feature for?

It is designed for you to refine your thumbnails to improve **click-through rates**.

#### How does the A/B test work?

When you upload **two** thumbnail variants, the system distributes each variant evenly among viewers (a 50/50 split). The best-performing thumbnail is recommended based on the click-through rate (CTR) metric.

### How can I set up an A/B thumbnail test during publishing?

During the **Upload Promotional Media** step in the publishing flow, you can add an additional thumbnail for testing.

**Important:**

- The A/B test is only successfully created after the island passes moderation.
- If either thumbnail variant fails moderation, the entire submission (including the island) will be rejected.

  - In the rejection email, a clear explanation is provided about which thumbnail variant is rejected, or if both are rejected.
  - If one image variant is reported, both images are removed.

[![](https://dev.epicgames.com/community/api/documentation/image/67cc5ffb-9d97-433e-b4b9-5c6db5b1278d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/67cc5ffb-9d97-433e-b4b9-5c6db5b1278d?resizing_type=fit)

### How many thumbnails can I test at once?

You can upload **two** thumbnail variants per test. One test per release is allowed.

### Can Irun multiple A/B tests simultaneously?

At launch, you can only run one active test per release at a time. You’re asked to end the test if you want to create a new release.

### How long does an A/B test run?

The duration of the test depends on data collection speed, usually ranging from a few days to a couple of weeks, based on audience size and engagement levels. The maximum duration for an A/B test is 90 days. If you don’t intentionally select a thumbnail, a default thumbnail is selected on your behalf after 90 days. Prior to that, you will need to end the test manually.

### What metrics determine the winning thumbnail?

The system considers click-through rate (CTR) to determine the best-performing thumbnail.

### How does the system recommend a winning thumbnail?

The system analyzes the click-through rate (CTR) and impressions metrics to determine the top-performing variant. While we don’t visually declare a winner, we visually show youthat significant confidence is reached. You can then select the thumbnail based on your own judgement.

### Can I manually select a winning thumbnail?

Yes, you can override the system’s recommendation and select a thumbnail manually.

### What is significant confidence in A/B testing?

In A/B testing, significant confidence means there is a statistical certainty (set at 90% confidence) that the difference in performance (CTR) between two thumbnails isn’t due to random chance.

- Measured with a "p-value" (for example, p < 0.1 for 90% confidence).
- Requires enough data (impressions/clicks) to rule out flukes.
- If reached, the winning thumbnail is declared reliably better.
- If not reached, the test is inconclusive (no clear winner).

Example:

If thumbnail B’s CTR is 5% higher than A, with 90% confidence, you can trust that B genuinely performs better. This prevents you from making decisions based on misleading or noisy data.

### How is a default thumbnail selected for me after 90 days?

After 90 days, if you don’t select a thumbnail yourself, the system determines which thumbnail to default to based on the rules below:

- If a significant result is reached, assign the outperforming image to be the island thumbnail.
- If no significant result is reached, assign thumbnail A (the first thumbnail uploaded) to be the island thumbnail.

### Where can I view test results?

Results are displayed inside the release module on the Creator Portal Project Release page, showing Impressions, Clicks and CTR on each variant’s performance. You are also shown whether the test has reached sufficient results — in other words , whether the result shown is statistically trustworthy.

[![](https://dev.epicgames.com/community/api/documentation/image/b6c5430c-0d15-4d25-b10f-d1ae4e8f056a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b6c5430c-0d15-4d25-b10f-d1ae4e8f056a?resizing_type=fit)

### Will players notice that thumbnails are changing?

No, players will be assigned a variant the first time they view the island’s thumbnail in Fortnite. This assignment happens on their player account level. Players will only see one thumbnail version, preventing any confusion.
