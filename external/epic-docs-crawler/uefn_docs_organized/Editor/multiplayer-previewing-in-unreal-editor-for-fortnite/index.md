# Multiplayer Previewing

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/multiplayer-previewing-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:01:40.926429

---

Unreal Editor for Fortnite (UEFN) and Fortnite Creative allow you to test your multiplayer experiences by spawning up to 98 test players into your level. You no longer need to manage multiple accounts and devices when testing alone, or assemble other Fortnite users to test incremental design changes—you can simply launch a session with the number of test players required for your multiplayer experience!

Test players behave exactly like idle players: they can be damaged, assigned to a team, spawn on Player Spawners and be instigators for devices. You can set the number of test players to be as high as the max player limit in your project's Island Settings.

## Adding Test Players to Your Level in UEFN

Adding test players to your experience is simple:

1. Launch UEFN and open a new or existing project.
2. In the **Outliner**, find and select **IslandSettings**.
3. In the **Details** panel, search for "debug" or scroll to the **Debug** section.

   [![](https://dev.epicgames.com/community/api/documentation/image/684e9bfb-063f-47cb-97dd-1e9df8bce174?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/684e9bfb-063f-47cb-97dd-1e9df8bce174?resizing_type=fit)
4. Check the box next to **Debug**. Notice that **Test Players on Start** option becomes available to edit.
5. Choose between the following:

   1. **Fill** spawns test players up to the Max Players value in your settings.
   2. **Custom** enables the **Number of Test Players** field and allows you to set the desired amount, up to the Max Players island setting.
   3. **None**spawns no test players.

## Adding Test Players to Your Level in Fortnite Creative

To spawn test players in Fortnite Creative:

1. Launch your session and load into your island.
2. Open the main menu and choose**Island Settings**.
3. In the left panel, select **Debug** to enable it.

   [![](https://dev.epicgames.com/community/api/documentation/image/8803e87c-730e-42ee-aadb-9db26f58c03d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8803e87c-730e-42ee-aadb-9db26f58c03d?resizing_type=fit)
4. Expand the **Test Players added at Game Start** and modify the **Test Players on Start** field.

## Using Test Players in Verse

An `agent` is a Verse type that can potentially move around and interact with the environment, like a player, a guard, a raptor, etc. If you want to use test players to test player functionality, you can use the `GetParticipants()` function, which will return a list of all the players and test players.

If your code uses `GetPlayers()` instead of `GetParticipants()`, you will not be able to test functionality using test players, because `GetPlayers()` will only return a list of players.

### Example: Granting Items to Test Players with Verse

The following code demonstrates the use of `GetParticipants()` in Verse, using a Trigger device and an Item Granter device to grant test players an item when the trigger is activated.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

teleporter_test := class(creative_device):
    @editable
    Trigger:trigger_device = trigger_device{}

    @editable
    ItemGranter:item_granter_device = item_granter_device{}

    OnBegin<override>()<suspends>:void=
        Trigger.TriggeredEvent.Subscribe(GiftToEveryone)
        ItemGranter.ItemGrantedEvent.Subscribe(ItemReceivedEvent)

    GiftToEveryone(Instigator:?agent):void=
        Print("Incoming gifting.")
        Participants := GetPlayspace().GetParticipants()
        for (Participant : Participants):
            Print("Attempting grant item...")
            ItemGranter.GrantItem(Participant)

    ItemReceivedEvent(Agent:agent):void=
        Print("Item granted!")
```

When you run this Verse code, you can see that `GetParticipants()` is fully compatible with Creative devices and should be used whenever you test functionality with test players.
