# Creating Gameplay with Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-gameplay-with-devices-in-fortnite
> **爬取时间**: 2025-12-26T23:29:47.694490

---

For any game, gameplay is controlled by [game mechanics](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#game-mechanics). Each mechanic covers a specific aspect of the game's functionality. These can range from general rules that define the what a player has to do to win the game ([win conditions](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#win-condition)) to specific things like where a player spawns on the island, how players can move, and what items can be granted to a player and when.

A device is a set of pre-programmed game mechanics in a single package that you can place on an island. Most devices have a visual representation — either as a mesh [asset](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#asset) or as an icon. Some are visible in-game, some are visible only when editing the island, and for some, you can set the visibility on or off for gameplay.

[![](https://dev.epicgames.com/community/api/documentation/image/24a6a9d4-8877-46ca-8b2b-9c64c5cbc8a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24a6a9d4-8877-46ca-8b2b-9c64c5cbc8a8?resizing_type=fit)

The device on the left is the Down But Not Out device, and is represented by an icon. The one on the right is the Character device and has a mesh.

## Out of the Box, and Then Some!

Devices add interactivity by detecting player actions, triggering events, managing game states, and creating simple-to-complex interactions within the island.

You can use the default Fortnite devices as they are, or you can expand their functionality by customizing them, either through device options or with Verse.

## The History of Fortnite Devices

Devices were originally designed specifically for making games and other experiences in Fortnite Creative, which launched in December of 2018.

FN Creative provided a [sandbox environment](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#sandbox-game) where creators create and save their own games and share them with friends.

Many of the device mechanics were pulled directly from **Fortnite Battle Royale**, and early creator-made games were simple modes like racing and shooter games.

The number of devices has expanded exponentially since that first launch, along with the sophistication of the devices themselves and the experiences developers can create with them.

## Learn What Different Devices Do

With devices, you can prototype gameplay and modify them to suit your needs. It's worth taking a minute to [see what devices are available](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite) before trying to use pure code to reinvent a functionality that already exists. Using and customizing an existing device can streamline your development workflow and save you hours of programming and testing since the available devices have already been proven to work. And if the device doesn't do everything you want, check the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api) to see what functionality you can add with Verse!

Some devices are only available in UEFN. For a list of these and the pages that describe them, see [UEFN-Only Devices](https://dev.epicgames.com/documentation/en-us/fortnite/uefnonly-devices-in-fortnite). UEFN-only devices cannot be placed on your island from Creative, but once you have placed them in UEFN, options for most of the devices can be modified in Creative during a [Live Edit](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#live-edit) session.

## Using Device Functions and Events

One of the great features of Fortnite devices is that you can set them up to perform specific functions when they are triggered by [events](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#event) from other devices.

When one device is [bound](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#binding) to another device, it can send a signal to the other device. The transmission of this signal is called an **event**. An event triggers one or more devices to do a particular thing or set a particular condition, and that action or condition is called a **function**.

For example, you could set up a **Button** device to trigger a **Customizable Light** to **On** when a player interacts with the button. Once this device is set up, you can copy-paste it to create a duplicate, then change the copied device to turn the light **Off**. You might even be able to customize one device to do both actions as an **On-Off** toggle.

**So much faster than coding from scratch — these built-in functions and events can dramatically speed up your design productivity!**

## Ready for More?

For more on how to find and modify devices in UEFN or Creative, and how to set up event triggers:

[![Getting Started with Devices](images/static/document_list/empty_thumbnail.svg)

Getting Started with Devices

Learn how to add and modify devices in Fortnite, and how to use Verse to expand device functionality!](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-devices-in-fortnite)

, see **[Getting Started with Devices](https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-devices-in-fortnite)**.

If you're looking for some cool inspiration, check out [Device Design Examples](https://dev.epicgames.com/documentation/en-us/fortnite/device-design-examples-in-fortnite-creative) for some great ideas on how you can use devices to create fun and unusual game mechanics!
