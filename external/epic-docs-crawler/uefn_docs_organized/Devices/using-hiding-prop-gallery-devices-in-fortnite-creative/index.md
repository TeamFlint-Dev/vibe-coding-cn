# Hiding Prop Gallery Devices

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-hiding-prop-gallery-devices-in-fortnite-creative
> **爬取时间**: 2025-12-26T23:42:03.913052

---

The **Hiding Prop Gallery** provides you with several different [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop) that players can hide in and teleport through:

- **Port-a-Potty**
- **Haystack**
- **Garbage Dumpster**
- **Scarecrow**

You can use these to create a [hide-and-seek](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#hide-and-seek) game that is different from a [prop hunt](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop-hunt). You can customize the props so that more than one player can hide in one, and determine whether the prop has sound effects and a wobbling animation when it is occupied.

For help on how to find the **Hiding Prop Gallery**, see **[Using Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-devices-in-fortnite)**.

If you're using multiple copies of a device on an island, it can be useful to [rename](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#rename-a-device) them. Choosing names that relate to a device's purpose makes it easier to remember what each one does, and easier to find a specific device when using the **[Event Browser](https://dev.epicgames.com/documentation/en-us/fortnite/event-browser-in-fortnite-creative)**.

## Device Options

This device has some basic functionality, like choosing which teams and classes can use the hiding prop. Additionally, there are some advanced options, like how many players can hide in a hiding prop and whether they are ejected after a period of time.

You can configure this device with the following options.

Default values are **bold**.

| Option | Value | Description |
| --- | --- | --- |
| **Enabled at Game Start** | **Enabled**, Disabled | Determines whether the Hiding Prop is enabled when the game starts. |
| **Usable by Team** | **Any**, Pick a team | Determines which team is able to use this prop to hide. Players on other teams will not see the **Hide** prompt. |
| **Usable by Class** | **Any**, Pick a class | Determines which class is able to use this prop to hide. If you choose **Any**, any player with an assigned class can use the prop to hide. If you choose **No Class**, only players without an assigned class can use the prop to hide. |
| **Invert Team Selection** | **Off**, On | If you choose **On**, all teams except the one selected in the **Usable by Team** option can use the prop to hide. |
| **Invert Class Selection** | **Off**, On | If you choose **On**, all classes except the one selected in the **Usable by Class** option can use the prop to hide. |
| **Invulnerable** | **Off**, On | Determines whether the prop can be damaged, or if it is immune to damage. |
| **Eject When Failing Requirements** | **Off**, On | If you choose **On**, a player is ejected from their hiding place if their team or class changes to one that is different from the requirement set in the **Usable by Team** or **Usable by Class** options. |
| **Interact Time** | **Instant**, Pick or enter a number of seconds | Determines the amount of time the player must hold down the Interact control before they are hidden or stop hiding. |
| **Hide Text** | Enter text | Use this to customize the text displayed for the **Hide** prompt. If this is left blank, the default text is used. |
| **Stop Hiding Text** | Enter text | Use this to customize the text displayed for the **Stop Hiding** prompt. If this is left blank, the default text is used. |
| **Occupied Text** | Enter text | You can customize text that will be displayed when the prop has someone hiding in it. If this is left blank, the interaction prompt will not display when someone is hiding in the prop. |
| **Max Number of Occupants** | **1**, Pick or enter a number | Determines how many players can hide in this prop at one time. |
| **Should Wobble While Hiding** | **On**, Off | By default, the prop alerts other players with sound and animation that a player is hiding in the prop. Set this to **Off** to disable these effects. |
| **Max Hiding Time** | **Don't Override**, Pick a number | Sets a maximum amount of time a player can hide in the prop before being ejected. |
| **Block Hide Time** | **No Delay**, Pick or enter a number | When a player leaves the prop, this determines the amount of time another player must wait before they can hide in the prop. |
| **Hidden Travel Group** | **Don't Override**, Pick or enter a group number | To make use of the hiddent travel feature, you must assign this hiding prop to a Hidden Travel Group. |
| **Hidden Travel Target Group** | **Don't Override**, Pick or enter a group number | Determines which group of hiding props can be targeted as a hidden travel destination. You can set this to the same value as the **Hidden Travel Group** option, or if you have multiple groups of hiding props you can target a different group. |
| **Attempt No Repeats** | **On**, Off | If this is set to **On**, the prop will avoid sending a player to the previous hiding prop twice in a row, unless there is no other hiding prop available. |

### Scarecrow-only Options

The scarecrow hiding prop has two options the other hiding props don't have, listed below.

| Option | Value | Description |
| --- | --- | --- |
| **Has Pumpkin Head** | On, **Off** | Determines whether the scarecrow has a pumpkin for a head or not. |
| **Clothes Color** | **Default**, Purple, Yellow | Determines the color of the clothing on the scarecrow. |

## Direct Event Binding

Following are the [direct event binding](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#direct-event-binding) options for this device.

### Functions

A [function](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary) listens for an event on a device then performs an action.

1. For any function, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. click **Select Event** to bind the device to an event that will trigger the function.
3. If more than one device or event triggers a function, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **Enable When Receiving From** | This function enables the device when an event occurs. |
| **Disable When Receiving From** | This function disables the device when an event occurs. |
| **Toggle Invulnerability When Receiving From** | This function toggles invulnerability on and off for this device when an event occurs. |
| **Eject All Hiding Players When Receiving From** | This function ejects all hiding players when an event occurs. |
| **Eject Hiding Player When Receiving From** | This function ejects the player hiding in this prop when an event occurs. |
| **Hide Nearby Players When Receiving From** | This function pulls any player within 10 meters into this hiding prop when an event occurs. |
| **Enable Hidden Travel When Receiving From** | This function enables hidden travel when an event occurs. |
| **Disable Hidden Travel When Receiving From** | This function disables hidden travel when an event occurs. |
| **Destroy** | This function destroys vulnerable hiding props. |

### Events

An [event](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#event) tells another device when to perform a function.

1. For any event, click the **option**, then **Select Device** to access and select from the **Device** dropdown menu.
2. Once you've selected a device, click **Select Function** to bind this event to a function for that device.
3. If more than one function is triggered by the event, click the **Add** button to add a line and repeat these steps.

| Option | Description |
| --- | --- |
| **On Hide Send Event To** | When a player hides in this hiding prop, it sends an event to the selected device, which triggers the selected function. |
| **On Stop Hiding Send Event To** | When a player leaves or is ejected from this hiding prop, it send an event to the selected device, which triggers the selected function. |
| **On Prop Destroyed Send Event To** | When this hiding prop is destroyed, it sends an event to the selected device, which triggers the selected function. |
| **On Hidden Travel Complete** | Sends an event when a player unhides. |

## Using Hiding Prop Gallery in Verse

You can use the code below to control a Hiding Props Gallery device in Verse. This code uses features of the [hiding\_prop\_device class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/fortnitedotcom/devices/hiding_prop_device) API to enable travel between hiding props, hide players at a set distance, and eject hiding players. You can modify it to fit the needs of your experience.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
hiding_prop_example_device := class(creative_device):

    # References to the hiding prop devices in the level 
    # In the Details panel for this Verse device, 
    # set these properties to your Hiding Props Gallery devices. 

    @editable
    HidingPropNoTravel : hiding_prop_device = hiding_prop_device{}
    @editable
    HidingPropTravel01 : hiding_prop_device = hiding_prop_device{}
    @editable
    HidingPropTravel02 : hiding_prop_device = hiding_prop_device{}
    @editable
    HidingPropTravel03 : hiding_prop_device = hiding_prop_device{}

    # Button devices for activating functions
    # In the Details panel for this Verse device, 
    # set these properties to your Button devices. 
    @editable
    EnableHidingButton : button_device = button_device{}
    @editable
    EnableWobbleButton : button_device = button_device{}
    @editable
    EjectPlayerButton : button_device = button_device{}
    @editable
    EjectAllPlayersButton : button_device = button_device{}
    @editable
    HidePlayersButton : button_device = button_device{}

    # Logic variables for the Enable and Disable toggle functions
    var IsHidingPropEnabled:logic = true
    var IsWobbleEnabled:logic = true
    
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=  

        # Button event subscriptions  
        EnableHidingButton.InteractedWithEvent.Subscribe(OnEnableHidingButton)
        EnableWobbleButton.InteractedWithEvent.Subscribe(OnEnableWobbleButton)
        EjectPlayerButton.InteractedWithEvent.Subscribe(OnEjectPlayerButton)
        EjectAllPlayersButton.InteractedWithEvent.Subscribe(OnEjectAllPlayersButton)
        HidePlayersButton.InteractedWithEvent.Subscribe(OnHidePlayersButton)

        # Sets the Hidden Travel Groups options for hiding prop devices
        # With this setup, HidingPropTravel01 connects to HidingPropTravel02,
        # HidingPropTravel02 connects to HidingPropTravel03, 
        # HidingPropTravel01 connects to HidingPropTravel01
        set HidingPropNoTravel.HiddenTravelGroup = option{1}
        set HidingPropNoTravel.HiddenTravelTargetGroup = option{1}
        set HidingPropTravel01.HiddenTravelGroup = option{1}
        set HidingPropTravel01.HiddenTravelTargetGroup = option{2}
        set HidingPropTravel02.HiddenTravelGroup = option{2}
        set HidingPropTravel02.HiddenTravelTargetGroup = option{3}
        set HidingPropTravel03.HiddenTravelGroup = option{3}
        set HidingPropTravel03.HiddenTravelTargetGroup = option{1}

        # Setting Hidden Travel options
        set HidingPropNoTravel.EnableHiddenTravel = false
        set HidingPropTravel01.EnableHiddenTravel = true
        set HidingPropTravel02.EnableHiddenTravel = true
        set HidingPropTravel03.EnableHiddenTravel = true
        set HidingPropNoTravel.AttemptNoRepeatDestinations = true

        # Sets hiding options
        set HidingPropNoTravel.MaxHideTime = option{1.0}
        set HidingPropNoTravel.MaxNumberOfOccupants = 2
        
        # A test print to ensure travel group is registering 
        if (TravelGroup := HidingPropNoTravel.HiddenTravelGroup?):
            Print("Travel Group is {TravelGroup}")
        else:
            Print("Failed to get Travel Group")
        
    # Function that toggles Enable and Disable of the non-travel hiding prop
    OnEnableHidingButton(Agent:agent):void=
        if (IsHidingPropEnabled?):
            HidingPropNoTravel.Disable()
            set IsHidingPropEnabled = false
            Print("HidingProp Disabled")
        else:
            HidingPropNoTravel.Enable()
            set IsHidingPropEnabled = true
            Print("HidingProp Enabled")

    # Function that toggles WobbleWhileHiding on and off,
    # as long as the hiding prop is enabled
    OnEnableWobbleButton(Agent:agent):void=
        if (HidingPropNoTravel.IsEnabled[]):
            if (IsWobbleEnabled?):
                set HidingPropNoTravel.ShouldWobbleWhileHiding = false
                set IsWobbleEnabled = false
                Print("Disabled Wobble While Hiding")
            else:
                set HidingPropNoTravel.ShouldWobbleWhileHiding = true
                set IsWobbleEnabled = true
                Print("Enabled Wobble While Hiding")
        else:
            Print("HidingProp is disabled, please enable it")

    # Functions to eject a player currently hiding
    OnEjectPlayerButton(Agent:agent):void=
        for (Player : GetPlayspace().GetPlayers()):
            if (not Player = Agent):
                EjectPlayer(Player)

    EjectPlayer(Player:player):void=
        if:
            HidingPropNoTravel.EjectHiddenPlayer[Player]

    # Functions to eject all players
    OnEjectAllPlayersButton(Agent:agent):void=
        if (Player := player[Agent]):
            EjectAllHiddenPlayers()

    EjectAllHiddenPlayers():void=
        EjectedPlayers := HidingPropNoTravel.EjectAllHiddenPlayers()
        for (EjectedPlayer : EjectedPlayers):
            Print("Ejecting Players")

    # Functions to hide players in a set range
    OnHidePlayersButton(Agent:agent):void=
        if (Player := player[Agent]):
            HidePlayers()

    HidePlayers():void=
        HidingPlayers := HidingPropNoTravel.HideNearbyPlayers(50000.0)
        for (HidPlayer : HidingPlayers):
            Print("Hiding Players")
```

To use this code in your island, follow these steps:

1. In your UEFN project, drag a **Hiding Props Gallery** device onto your island.
2. Choose four hiding props to use.

   You can duplicate a prop using **Alt + Drag** with the translate tool active.
3. Create a new Verse device named `hiding_prop_example_device`. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).
4. In the Verse Explorer, double-click `hiding_prop_example_device.verse` to open the script in Visual Studio Code.
5. Copy and paste in the code above, compile, and drag the device onto your island.
6. In the **Content Drawer**, search and add 5 Button devices to your island. You can rename the devices to align with the editable property names.
7. Select your Verse device in the **Outliner**.
8. In the Verse device's **Details** panel, assign the object references for the hiding props and buttons on your island. You can use the eyedropper to pick the device in the viewport, or use the dropdown and search for the device.
9. Save your project, and click **Launch Session**.

This example uses print statements to test the functionality of the gameplay setup. This workflow can help ensure your island functions as intended.
