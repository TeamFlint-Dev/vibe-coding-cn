# Visibility Screen

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/visibility-screen-in-fortnite>
> **爬取时间**: 2025-12-27T00:14:51.819845

---

At this point, you have built at least one island and signed up for the Fortnite Island Creator Program. The last step in creating a release is setting the island’s visibility for after it is published.

## Private Version Code

If you’re publishing from UEFN, you’ll have created a private version of your island and received a private version code. Private version codes can be used to playtest your island on different platforms and consoles. These versions are unmoderated, so only you can use the private version code to access your island.

## Set Visibility

You can set your island to publish automatically once it passes content review by selecting either the **Listed** or **Unlisted** option. If you don’t want your island to publish automatically after it passes content review, you have two choices:

- Select the **[Manually publish later](https://dev.epicgames.com/documentation/en-us/fortnite/schedule-publishing-in-fortnite#manually-publish-later)** option.
- [Schedule your publication](https://dev.epicgames.com/documentation/en-us/fortnite/schedule-publishing-in-fortnite) for a specific date and time.

### Listed

When an island is listed, it will appear on your **[Creator Page](https://dev.epicgames.com/documentation/en-us/fortnite/manage-your-creator-page-in-fortnite-creative)** and will be eligible to appear in the Discover section. Your island can also be found in search, by its island code, and on its island page.

### Unlisted

Unlisted islands can only be found by their island code. Unlisted islands do not appear in Discover and do not surface in search.

## Publishing Prerequisites

Before an island can go through review and publishing, there are a couple of things you need to do:

- **Memory calculation**
- **Persistence backward compatibility check**

### Memory Calculation

Submission for publishing is only permitted for private versions that have passed a memory check. If you see an orange warning on a private version, you'll need to run a memory calculation in UEFN while you have your project open and connected to a session.

### Persistence Backward Compatibility Check

Published islands that use Verse to store a player’s persistent data go through a backward compatibility check that verifies persistent data still works with an updated island version for Verse persistence.

This check happens before publishing an updated island to public release. Once an island is made public, you can only add new fields to persistable classes as a backward-compatible change.

See **[Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)** more information on the backward compatibility check.

When you initiate publishing a release of your island in the Creator Portal, the release will be checked for Verse persistable-data backward compatibility, ensuring that the release you are  is backward-compatible with the current published release of your island.

You will not be able to publish your release if the compatibility check fails. Any incompatible updates will cause your island to break.

This automatic check occurs when:

- You publish a release of your island that is newer than the current published release.
- You publish an unpublished release that was previously approved and is newer than the current published release.

This check may take several minutes to complete, depending on the amount of Verse code in your project.

When you initiate the publishing flow in Creator Portal, you’ll see an indicator at the top of the publishing modal that the check is in progress.

Once the check has started, you won’t be able to finish publishing until the check is complete.

If the check fails, you’ll get an error message that says  your Verse persistable data is incompatible between releases. If you compile your Verse code in UEFN, you need to launch a play session or select Push Changes to find the error and fix it. For more details, see **[Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse)**.

## Published Islands

Once your island has passed review and is published, it appears on the project’s [publishing page](https://dev.epicgames.com/documentation/en-us/fortnite/publishing-page-features-in-fortnite-creative). Each island you publish will have its own publishing page. From these pages, you can push new releases or unpublish an island.

Published islands gather **[analytics](https://dev.epicgames.com/documentation/en-us/fortnite/project-analytics-for-fortnite-games)** based on different criteria. You can use the data collected in the analytics to tweak your island.

Don’t be afraid to innovate and refine an island you publish. This is part of the development process. Iteration helps older islands reach new audiences, and invigorates players who already know about your island!

## Failed Review

If your release fails content review, you’ll receive an email with a link that opens the Creator Portal.

All releases that fail review can be found on the Releases screen. Clicking the information icon opens a moderation report that details why the release failed moderation. When a release fails moderation, it will not update your currently live island. Your last approved release remains the published version of your island.

Address the issues with your island, then generate a new private version and submit the new iteration of your island for review by creating a new release.
