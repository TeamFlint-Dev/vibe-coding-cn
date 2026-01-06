# Getting Started with Direct Event Binding

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/getting-started-with-direct-event-binding-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:13:28.008338

---

## Why Device Communication is Changing

Direct event binding will expand the possibilities for what you can accomplish in Creative. With direct event binding, devices can communicate directly. It makes your workflow more intuitive, giving you the freedom to really pursue your design ideas. Switching to this system is the next step in creating game mechanics that are more complex and diverse.

The direct event binding system eliminates limitations inherent in the channel communication system. You no longer have to worry about reaching the maximum channel limit. Because the devices communicate directly with event binding, you don't have to preplan your channel allocation when designing an island. When you copy-paste devices, you no longer need to edit them to change the channel assignments — the events and functions set in the original carry over to the copies.

## Introducing Events and Functions

Instead of transmitting and receiving signals, devices use **events** and **functions**. When a device activates, or a player performs an action, that's an example of an **event**. Events trigger other devices to do a particular thing or set a particular condition, and that action or condition is a **function**. You bind an event in one device to a function in another device. For the most part, former transmitter options are now events, and former receiver options are now functions.

## How Direct Event Binding Works

Instead of assigning channels, direct event binding uses device names to specify events and functions that occur between multiple devices. Devices are automatically assigned a unique identifier, but these are just a string of letters and numbers. It will be important to rename your devices with meaningful and descriptive names.

Below is an illustration comparing the channel system to the direct event binding system, which can help you see how they are similar and how they are different.

[![Comparison of channel system to direct event binding](https://dev.epicgames.com/community/api/documentation/image/0165cedf-1d2b-4b01-bf87-85f021bc800e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0165cedf-1d2b-4b01-bf87-85f021bc800e?resizing_type=fit)

## Converting Your Existing Islands

Direct event binding is currently an opt-in system, although eventually it will be the default. When you want to convert an existing island to the new system, you should make a copy of the island and test the conversion on that copy first.

Once you have converted an island from the channel system to the direct event binding system, it cannot be switched back to the channel system! Resetting the island will not switch it back to the channel system.

To switch an existing island to the new system, open **My Island** and click the **Tools** tab. Locate the **Event System** setting and click **Convert**.

[![Converting existing islands](https://dev.epicgames.com/community/api/documentation/image/20acf6f7-8c40-4920-a1d7-d210a693c2b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/20acf6f7-8c40-4920-a1d7-d210a693c2b5?resizing_type=fit)

This automatic conversion will assign unique IDs (a random string of letters and numbers) to any unnamed devices. Devices that were connected in the channel system will automatically be connected with events and functions in the conversion process.

When you open a device's **Customize** panel to view the options, you will see an **Events** tab and a **Functions** tab instead of the **Channels** tab. This is where you will find the connections between devices on your island.

## Additional Advantages of Direct Event Binding

The direct event binding system dramatically speeds up your workflow for building islands, and helps you make important changes all at once.

As an example, let's say you have set up a Button device to turn on a Customizable Light when a player interacts with the button. On the Events tab, you have selected the event **On Interact Send Event To**. Under the event, you have selected the **Customizable Light** device, and next to the device you have selected **Turn On** as the function.

[![Direct Event Binding UI in Customize panel](https://dev.epicgames.com/community/api/documentation/image/f9aa95bf-98ed-4f75-a13b-8b23dd05af3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f9aa95bf-98ed-4f75-a13b-8b23dd05af3c?resizing_type=fit)

If you want to add another Button to turn off the light, you can just copy and paste the first Button device, then go to the **Events** tab and click **Turn On** to open the menu. Select **Turn Off** from the list, and you're done! You can then rename the two Button devices to **Light On** and **Light Off** to make it clear which is which.

With the channel system, you can copy-paste devices — but you'll have to edit each one to different channel pairings. If you have highly complex game mechanics that involve multiple devices, this can take enormous amounts of time. And if you get things mixed up, it takes even more time to fix whatever is broken.

But with direct event binding, you have fewer things to change, meaning your work goes faster. And it's a lot easier to create large interconnected groups of devices, meaning your games can make use of more sophisticated game mechanics. And with no channels, there's no maximum number of channels to keep in mind and work around. You can copy and paste one device or a whole group without concerns for channel limitations.

## What's Next

Check out the [official Fortnite blog](https://www.epicgames.com/fortnite/en-US/news/introducing-direct-event-binding-for-creating-fortnite-islands) for a Direct Event Binding FAQ. Share your creations with us on Twitter by tagging us [@FNCreate](https://twitter.com/FNCreate)!
