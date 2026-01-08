# Reports

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/reports-in-fortnite>
> **爬取时间**: 2025-12-27T00:13:55.066926

---

Export and analyze island insights at scale. Use the **Reports** tab to download analytics data across all your islands at once in CSV format.

The **Reports** tab provides a centralized way to export analytics data for any islands where you are an **Owner** or **Administrator**. Instead of opening each island’s analytics individually, you can download data from multiple islands in one place.

Reports are exported as a **ZIP file** with folders for each island you select. Inside each folder is a CSV for each metric you selected under **Data Source**. You can use these CSVs for deeper analysis, external reporting, or visualization in the tools of your choice.

The Reports feature is currently in BETA and more functionality will be added over time.

You must have the [Owner or Admin role](https://dev.epicgames.com/documentation/en-us/fortnite/creating-teams-in-creator-portal-in-unreal-editor-for-fortnite) to use this feature.

## Bulk Download

Select **Reports** from the [project navigation menu](https://dev.epicgames.com/documentation/en-us/fortnite/project-navigation-menu-in-fortnite).

[![An example of opening the Reports screen from the project navigation menu.](https://dev.epicgames.com/community/api/documentation/image/a00d6ede-9c40-4d48-9336-4105e70a4a14?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a00d6ede-9c40-4d48-9336-4105e70a4a14?resizing_type=fit)

Reports

Once you’ve opened the **Reports** page you can select data points across multiple islands and download bulk reports for those islands. The bulk download tool allows you to export island analytics data by selecting:

- A time range
- One or more islands
- One or more data sources (metrics)

All selections must be completed before you can generate your reports.

To begin a bulk download, follow these steps:

1. Click the **time field** to open the **Time range** dropdown menu.

   [![An example of the time range dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/0146fab2-7e72-410b-a9c3-b1a5802d0961?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0146fab2-7e72-410b-a9c3-b1a5802d0961?resizing_type=fit)

   Time range
2. Select a range of time from the dropdown menu or select **Custom** to choose a custom date range from the calendar.

   [![An example of selecting a custom time range.](https://dev.epicgames.com/community/api/documentation/image/c452ed78-7aec-490a-93cb-2e33346815a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c452ed78-7aec-490a-93cb-2e33346815a5?resizing_type=fit)

   Custom range
3. Click **Apply**.
4. Click **Select Island** to open the **Island** dropdown menu and select the islands you want data from.

   [![An example of selecting islands from the island dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/f8de3b96-61ee-4e7d-8720-10dccf17aa9c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8de3b96-61ee-4e7d-8720-10dccf17aa9c?resizing_type=fit)

   Select islands

   You have additional options:

   - **All** - Selects all islands in the list.
   - **Last Published** - Only selects data from the last published islands.
   - **My Islands** - Only selects islands created by you.
5. Click **Apply**.
6. Select the data points you want to appear on the reports from the **Data Source** list.

   [![An example of selecting data points from the Data source section.](https://dev.epicgames.com/community/api/documentation/image/da7ac0a1-d178-4b4d-b49a-43ffb444a128?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da7ac0a1-d178-4b4d-b49a-43ffb444a128?resizing_type=fit)

   Data source
7. Click **Generate** to begin downloading the report.

While the report is generating, a progress bar appears at the bottom of the Reports page.

[![An example of the Reports download progress bar.](https://dev.epicgames.com/community/api/documentation/image/ecee6789-7443-4278-87ab-11d6889f3938?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecee6789-7443-4278-87ab-11d6889f3938?resizing_type=fit)

Reports download progress bar

Once you see the success notification you can safely leave the Reports page.

[![An example of the success message that displays when a report has successfully downloaded.](https://dev.epicgames.com/community/api/documentation/image/c3b26e15-6516-4a1a-af51-ff99374b306b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c3b26e15-6516-4a1a-af51-ff99374b306b?resizing_type=fit)

Success message

### Data Categories

Data sources correspond to the same analytics categories found in the Analytics page for the individual projects. Each category can be expanded to choose specific metrics, or you can select everything at once.

Available categories:

- **Audience** - Impressions, clicks, plays, CTR, and related metrics
- **Gameplay** - Session information, gameplay interactions, XP devices, and more.
- **Engagement** - Minutes played, active players, returning players, and more.
- **Satisfaction** - Player ratings and satisfaction signals
- **Retention** - Return behavior across days

### Download and File Format

The time required to prepare your download depends on:

- Number of islands selected
- Number of metrics selected
- Length of the time range

Large exports (many islands + long time ranges + all metrics) may take several minutes. A warning message will appear if your export is expected to take longer than usual.

You must stay on the Reports page until generation completes.

Reports are downloaded and exported as a ZIP file containing one or more CSV files. Each CSV corresponds to a unique combination of metric and island.

You can open CSVs with most spreadsheet and analysis tools, including Excel, Google Sheets, and data tools such as Tableau, Looker, or Python notebooks.

## Report Issues

There are a few reasons a report cannot generate or does not fully gather all data:

- [Missing information](https://dev.epicgames.com/documentation/en-us/fortnite/reports-in-fortnite#missing-information)
- [Download error](https://dev.epicgames.com/documentation/en-us/fortnite/reports-in-fortnite#download-error)
- [An issue with the data](https://dev.epicgames.com/documentation/en-us/fortnite/reports-in-fortnite#data-issues)

### Missing Information

If you forget to fill in one or more of the report fields, the field appears red and a prompt appears on the form. The **Generate** button will not be selectable at this time.

[![An example of the missing fields turning red.](https://dev.epicgames.com/community/api/documentation/image/a8a53d1c-2793-42dc-9ed9-9016763da3ce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8a53d1c-2793-42dc-9ed9-9016763da3ce?resizing_type=fit)

Missing information

### Download Error

If an issue occurs while the download is in process, the report won’t generate. The progress bar goes into a failed state and stops downloading the report. A **download failed** message appears in the top-right corner of the screen.

[![An example of the download progress bar in a failed state.](https://dev.epicgames.com/community/api/documentation/image/517f2b55-d0ac-4057-9fc6-aeac902db124?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/517f2b55-d0ac-4057-9fc6-aeac902db124?resizing_type=fit)

Fail download

[![An example of the download failed messaging.](https://dev.epicgames.com/community/api/documentation/image/3f0fb495-4dd3-4b78-9fbf-99c2e776c06f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f0fb495-4dd3-4b78-9fbf-99c2e776c06f?resizing_type=fit)

Download fail message

### Data Issues

If there’s an issue with any of the data selected, the report will continue generating.

[![An example of a download experiencing data issues.](https://dev.epicgames.com/community/api/documentation/image/1a1fe709-f275-466d-bc04-c3020908c846?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1a1fe709-f275-466d-bc04-c3020908c846?resizing_type=fit)

Data issues

However, once the report is generated a warning message appears to inform you that not all information could be pulled into the report.

[![An example of the data issue messaging.](https://dev.epicgames.com/community/api/documentation/image/87b04b91-9973-4c2b-b9e2-5fc5b29c5beb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87b04b91-9973-4c2b-b9e2-5fc5b29c5beb?resizing_type=fit)

Data issue message

## Cancel Report

At any time while the report is generating you can cancel the bulk download. To cancel the report, follow these steps.

1. Click **Cancel** on the progress bar.  A confirmation pop-up message appears.

   [![Click the Cancel button to cancel the report download.](https://dev.epicgames.com/community/api/documentation/image/584c872e-451b-4e2c-9951-e641ba80dd42?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/584c872e-451b-4e2c-9951-e641ba80dd42?resizing_type=fit)

   Cancel report
2. Click **Cancel report** on the pop-up. The report is canceled.

   [![An example of the cancel confirmation pop-up message.](https://dev.epicgames.com/community/api/documentation/image/9e9c878b-0b9d-4641-98bc-5d0dc002fa49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e9c878b-0b9d-4641-98bc-5d0dc002fa49?resizing_type=fit)

   Cancel download confirmation

## Best Practices

- **Start with a narrow time range**. To speed the report generation, try 7 or 30 days before exporting larger files.
- **Focus on key islands**. To speed up report generation and keep analysis efficient, select only the specific islands that you want to analyze.
- **Export only the metrics you need**. Selecting fewer metrics reduces processing time.
- **Group similar islands**. If you’re a creator with a large portfolio, grouping islands by theme or season makes report analytics more insightful and reduces download times.
