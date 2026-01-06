# 4. Link Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/box-fight-4-link-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:19:38.028475

---

With all the devices in place, it's time to set up how they interact.

Direct event binding allows devices to talk to one another directly by using **[events](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary)** and [**functions**](unreal-editor-for-fortnite-glossary#function). Learn more about it [here](https://dev.epicgames.com/documentation/en-us/fortnite/direct-event-binding-in-unreal-editor-for-fortnite).

| Device A | Function | Device B | Event | Explanation |
| --- | --- | --- | --- | --- |
| **Hollow Barrier 1 & 2**  [barrier](https://dev.epicgames.com/community/api/documentation/image/003f7e2f-5543-4c88-bf91-f31be59a56ef?resizing_type=fit) | Disable | **Timer**  [timer](https://dev.epicgames.com/community/api/documentation/image/169b7479-b672-4cdd-9368-0a80a3cfbfa0?resizing_type=fit) | On Success | When the timer runs out, the barriers will disappear. |
| **Opaque Barrier**  [barrier](https://dev.epicgames.com/community/api/documentation/image/f2581671-7dd7-465d-9307-bcea9dddfcac?resizing_type=fit) | Disable | **Timer**  [timer](https://dev.epicgames.com/community/api/documentation/image/7b32c47c-f60f-4333-822f-7a9453cb1d25?resizing_type=fit) | On Success | When the timer runs out, the barrier will disappear. |

Here is a screenshot of what this will look like once the binding is set:

[![direct event binding example](https://dev.epicgames.com/community/api/documentation/image/54db5207-ef30-4ab0-806d-42c1fd66b7a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54db5207-ef30-4ab0-806d-42c1fd66b7a2?resizing_type=fit)

## Direct Event Binding with Verse

Alternatively, you can use Verse to program device logic.

The first step is to [create your own device using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite). For more information, you can follow the [Learn the Basics of Writing Code in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/learn-the-basics-of-writing-code-in-verse) guide, then come back here to apply those concepts.

Now you will need [to reference the devices](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse) you'll control with Verse in your script.

You will need 3 `barrier_device` and 1 `timer_device`:

```verse
box_fight_manager := class<concrete>(creative_device):
    Logger:log = log{Channel:=box_fight_log}
    @editable
    Barrier1:barrier_device = barrier_device{}
    @editable
    Barrier2:barrier_device = barrier_device{}
    @editable
    MidBarrier:barrier_device = barrier_device{}
    @editable
    Timer:timer_device = timer_device{}
```

[Compile](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#compile) your code and drag the `box_fight_manager` into the level, then select the corresponding devices:

[![Box Fight Manager devices](https://dev.epicgames.com/community/api/documentation/image/da2ea5cb-dff6-4c2c-b712-843119f29b03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/da2ea5cb-dff6-4c2c-b712-843119f29b03?resizing_type=fit)

For this example, the `Timer` should start on its own when the game begins. After the set amount of time elapses, the `Timer` succeeds, and the barriers are disabled.

Let’s [Subscribe](https://dev.epicgames.com/documentation/en-us/fortnite/coding-device-interactions-in-verse) to the `Timer`’s `SuccessEvent` when the game begins:

```verse
OnBegin<override>()<suspends>:void=
        Timer.SuccessEvent.Subscribe(DropBarriers)
```

`DropBarriers` will be called, disabling the three barriers:

```verse
DropBarriers(Player:?agent):void=
        Barrier1.Disable()
        Barrier2.Disable()
        MidBarrier.Disable()
```

Note that the `SuccessEvent` expects to [call](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call) a function which takes in an `agent` argument.

Compile your code, and that's it! You're ready to playtest your island.

Here is the complete script, for reference:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Native }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

box_fight_log:=class(log_channel){}

box_fight_manager := class<concrete>(creative_device):
    Logger:log = log{Channel:=box_fight_log}
    @editable
    Barrier1:barrier_device = barrier_device{}
    @editable
    Barrier2:barrier_device = barrier_device{}
    @editable
    MidBarrier:barrier_device = barrier_device{}
    @editable
    Timer:timer_device = timer_device{}

    OnBegin<override>()<suspends>:void=
        Timer.SuccessEvent.Subscribe(DropBarriers)

    DropBarriers(Player:?agent):void=
        Barrier1.Disable()
        Barrier2.Disable()
        MidBarrier.Disable()
```

## Playtesting your Island

You did it!

Once everything is set up and ready to go, [playtest your island](playtesting-your-island-unreal-editor-for-fortnite) to make sure that it runs as expected in Fortnite.

To **Publish** your project, see the [Publishing Projects](publishing-projects-in-unreal-editor-for-fortnite) page.
