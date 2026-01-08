# Working with Rocket Racing Islands

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/working-with-rocket-racing-islands-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:16:00.221955

---

Use the **Rocket Racing** templates in Unreal Engine for Fortnite (UEFN)to create your own island similar to the **Fortnite** **Rocket Racing** experience. Any project created from these templates is considered to be a Rocket Racing island.

Specific devices are available to use with these templates to ensure that a project stays within the scope of a Rocket Racing experience. Many of these devices are only accessible in Rocket Racing projects.

Islands published from these templates can be found in the **Discover Browser**, and have a rating up to **Fortnite**.

Rocket Racing islands do not support [in-island transactions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-in-fortnite).

## Rocket Racing Templates and Devices

You can get started building from the project browser in UEFN using either the island or brand templates. The **Brand Templates** tab includes a **Competitive Race Track** or a **Speed Run Track** project.

Use the **Competitive Race Track** template to create a multi-lap circuit track where players must race from start to finish. Use the **Speed Run Track** template to create a single-lap race where players compete for the lowest completion time. You can only access these devices within a Rocket Racing template. To learn more about accessing Rocket Racing assets, see [Accessing Brand Content](https://dev.epicgames.com/documentation/en-us/fortnite/accessing-brand-content-in-fortnite)

The following devices are available to use in Rocket Racing projects:

- [RR Competitive Race Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-competitive-race-manager-devices-in-unreal-editor-for-fortnite)
- [RR Speed Run Manager](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-speed-run-manager-devices-in-unreal-editor-for-fortnite)
- [RR Track](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-track-devices-in-unreal-editor-for-fortnite)
- [RR Checkpoint](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-checkpoint-devices-in-unreal-editor-for-fortnite)
- [RR Player Start Position](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-player-start-position-devices-in-unreal-editor-for-fortnite)
- [RR EMP Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-emp-volume-devices-in-unreal-editor-for-fortnite)
- [RR Boost Pad](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-boost-pad-devices-in-unreal-editor-for-fortnite)
- [RR Active Track Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-active-track-volume-devices-in-unreal-editor-for-fortnite)
- [RR Elimination Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-rocket-racing-elimination-volume-devices-in-unreal-editor-for-fortnite)

### Adding Fortnite Devices

In addition to Rocket Racing-specific devices, you can also use the following devices in these projects:

- [Decal](https://dev.epicgames.com/documentation/en-us/fortnite/decal-device-in-unreal-editor-for-fortnite)
- [HUD Controller](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-controller-devices-in-fortnite-creative)
- [Hover Platform](https://dev.epicgames.com/documentation/en-us/fortnite/using-hover-platform-devices-in-fortnite-creative)
- [VFX Creator](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-creator-devices-in-fortnite-creative)
- [VFX Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-vfx-spawner-devices-in-fortnite-creative)
- [Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/island-settings-in-unreal-editor-for-fortnite)

To keep projects within the scope of a Rocket Racing experience, there are many island settings, such as **Max Player Count** and **Team Settings**, that will be overridden when the game launches. You can adjust any setting that does not change the core functionality of a Rocket Racing experience.

## Working on a Rocket Racing Project

Your project launches with a preset selection of assets available to create your gameplay and you'll have a few devices already set up for you. The race manager available for your project will depend on the template you select.

[![Rocket Racing Outliner](https://dev.epicgames.com/community/api/documentation/image/777f16c3-0ea4-4818-acd5-d6339ead4b8c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/777f16c3-0ea4-4818-acd5-d6339ead4b8c?resizing_type=fit)

For example, the **Speed Run Track** project will be launched with devices like the **Speed Run Race Manager** and **IslandSettings**. The assets your project starts with can be found in organized folders in the **Outliner** tab.

Check out the [Rocket Racing track walkthrough](https://dev.epicgames.com/documentation/en-us/fortnite/creating-rocket-racing-islands-in-unreal-editor-for-fortnite) for a guide on creating a competitive track.

## Validating and Rocket Racing Islands

When you launch a session in UEFN, your Rocket Racking island will go through validation to make sure your island is set up for a Rocket Racing experience. Any check that fails will report an error message in the Output Log.

The following devices have specific checks and error messages, so check out the device documentation for more details on how to avoid these errors to using the devices in a Rocket Racing island.

- RR Checkpoint devices
- RR Competitive Race Manager devices
- RR Player Start Position devices
- RR Speed Run Manager devices
- RR Track devices

## IARC Audience Restrictions

Rocket Racing islands can have a maximum rating of **Teen-Equivalent**, and the core Rocket Racing experience is rated **Everyone-Equivalent**. Create your gameplay with these ratings in mind.

Use the chart below as a guideline on [rating restrictions across regions](https://dev.epicgames.com/documentation/en-us/fortnite-creative/iarc-overview-and-faqs-in-fortnite-creative).

| Rating Authority | Everyone-Equivalent | E10-Equivalent | Teen-Equivalent |
| --- | --- | --- | --- |
| [ESRB](https://www.esrb.org/ratings-guide/) | E | E 10 | T |
| [PEGI](https://pegi.info/what-do-the-labels-mean) | 3 | 7 | 12 |
| [ACB](https://www.classification.gov.au/classification-ratings/what-do-ratings-mean) | G | PG | M |
| [Classlnd](https://www.gov.br/mj/pt-br/assuntos/seus-direitos/classificacao-1) | LIVRE | 10 | 12 |
| [USK](https://usk.de/die-usk-alterskennzeichen/) | 0 | 6 | 16 |
| [GRAC](https://www.grac.or.kr/english/) | ALL | ALL | 12 |
| Russia | 0 | 6 | 12 |
| IARC (Generic) | 3 | 7 | 12 |

## Publishing Rocket Racing Islands

Publishing a Rocket Racing Island follows the same process as publishing any other UEFN island through the Creator Portal. To learn more about the publishing process, see [**Using Creator Portal**](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-creator-portal-in-fortnite-creative).

## Your Island in Discover

In the Creator Portal, Rocket Racing islands are automatically tagged with “Rocket Racing” and, depending on your racing mode, “Competitive” or “Speed Run” during the publishing process. These special tags will appear on the product details page.

Creator-made Rocket Racing islands will show up in Discover and are searchable, like any other Fortnite island.
