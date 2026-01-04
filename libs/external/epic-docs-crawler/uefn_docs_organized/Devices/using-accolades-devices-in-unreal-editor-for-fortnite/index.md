# Using Accolades

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/using-accolades-devices-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:30:08.359788

---

Want to grant players Battle Pass XP while they play your UEFN experience? This tutorial shows you how to use the Accolade device to grant XP to players through UEFN and Verse.

For more information on how this device grants players XP, see [Accolade Devices](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-accolades-devices-in-fortnite-creative) for Fortnite Creative.

## Awarding XP for Zombie Eliminations

1. Launch UEFN from the Epic Game Store.

   [![UEFN](https://dev.epicgames.com/community/api/documentation/image/f973e560-7a26-45ca-b0d0-b39db2ccaa9e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f973e560-7a26-45ca-b0d0-b39db2ccaa9e?resizing_type=fit)
2. Create a new island or load an existing island.
3. In the Content Browser, navigate to **All** > **Fortnite** > **Devices** and search for "accolade".

   [![accolades search](https://dev.epicgames.com/community/api/documentation/image/a678f68a-1874-4ce0-b82d-b3abe155a25a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a678f68a-1874-4ce0-b82d-b3abe155a25a?resizing_type=fit)
4. Drag the Accolade device into your level.

   [![Drag accolade](https://dev.epicgames.com/community/api/documentation/image/acc6f198-f96b-4db5-b58b-5f4b027abdcd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/acc6f198-f96b-4db5-b58b-5f4b027abdcd?resizing_type=fit)
5. Make sure the Accolade device is selected.
6. In the Details panel, modify the following User Options:

   [![Details panel](https://dev.epicgames.com/community/api/documentation/image/231a35e4-2138-472f-96a0-cc99b2446590?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/231a35e4-2138-472f-96a0-cc99b2446590?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Name** | "Zombie Elimination" | A brief message to explain the type of award. |
   | **XP Award** | Very Small | Since this is an easy to achieve goal, the award should be small. |
   | **Splash Size** | Small | The message on the player’s screen will take up a small amount of space. |
7. In the Content Browser, navigate to **All** > **Fortnite** > **Devices** and search for "creature spawn".

   [![creature spawner](https://dev.epicgames.com/community/api/documentation/image/5c4d127f-49ab-4dc1-9102-baf467fe0924?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c4d127f-49ab-4dc1-9102-baf467fe0924?resizing_type=fit)
8. Drag a **Creature Spawner** into your level.
9. Find and drag a **Mounted Turret** device into your level, within range of the creature spawner. This will allow players to eliminate the zombies.

   [![turret-range](https://dev.epicgames.com/community/api/documentation/image/041290bf-77fa-4efc-9a03-810c996f87ee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/041290bf-77fa-4efc-9a03-810c996f87ee?resizing_type=fit)

### Direct Event Binding

You can use direct event binding to trigger the Accolade device whenever a zombie is eliminated. This workflow is performed in the editor only. To see how this is done in Verse, go to [Awarding XP Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-accolades-devices-in-unreal-editor-for-fortnite).

1. Select the Accolade device created earlier.
2. From the Details panel, scroll to the **User Options - Functions** section.
3. Click the **+** button next to "Award".
4. Click the dropdown, search for the creature spawner and select it.
5. Click the second dropdown and select "On A Creature Is Eliminated".

## Awarding XP for Time Spent In-Game

1. Repeat steps 1 through 5 listed in the [zombie eliminations](https://dev.epicgames.com/documentation/en-us/fortnite/using-accolades-devices-in-unreal-editor-for-fortnite) example.
2. In the Details panel, modify the following settings:

   [![time XP award](https://dev.epicgames.com/community/api/documentation/image/ffd4c1ec-1a88-4680-983d-287d2d6611d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ffd4c1ec-1a88-4680-983d-287d2d6611d8?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Name** | "Thanks for Playing!" | Write a brief message to explain the type of award. |
   | **Description** | "A thank you for spending time on the island." | Write a short message to explain why the player is getting an XP award. |
   | **XP Award** | Large | 15 minutes of playtime could warrant a large award. |
   | **Limit Award Count** | True, "1" | This XP award can only be granted once. |
   | **Icon** | Choose two | Search for "Star", then set the small icon to the “\_64” version and the large icon to the “\_128” version. |
3. Find the **Timer** device in the Content Browser and drag into your level.
4. In the Details panel for the Timer device, modify the following settings:

   [![timer settings](https://dev.epicgames.com/community/api/documentation/image/fd248fe6-e79c-4069-b27f-70b177b10b9f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd248fe6-e79c-4069-b27f-70b177b10b9f?resizing_type=fit)

   | Option | Value | Explanation |
   | --- | --- | --- |
   | **Duration** | 900 | The award will be granted after 15 minutes of gameplay. |
   | **Start at Game Start** | True | The timer will commence automatically when the game begins. |
   | **Completion Behavior** | Restart | The timer will restart and grant more XP at the end of the next 15-minute segment. |
   | **Visible During Game** | Hidden | You cannot see or interact with this timer. |

### Direct Event Binding

Use direct event binding to trigger the Accolade device whenever the timer completes.

1. Select the Accolade device created earlier.
2. From the Details panel, scroll to the **User Options - Functions** section.
3. Click the **+** button next to "Award".
4. Click the dropdown, search for the Timer device and select it.
5. Click the second dropdown and select "On Success".

[![timer success](https://dev.epicgames.com/community/api/documentation/image/c44dc5bb-d52c-4c3a-8d89-36adc6eb2bfa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c44dc5bb-d52c-4c3a-8d89-36adc6eb2bfa?resizing_type=fit)

## Awarding XP Using Verse

This example builds on the [zombie elimination](https://dev.epicgames.com/documentation/en-us/fortnite/using-accolades-devices-in-unreal-editor-for-fortnite) example above. Zombies drop bones that can be picked up. The following section shows how to award a large amount of XP whenever a player submits 5 bones.

1. From the Content Browser, navigate to **All** > **Fortnite** > **Devices** and search for "elimination".
2. Drag an **Elimination Manager** device into your scene.
3. From the **Details** panel, under **User Options:**

   1. Click **Add Element** to **Item List**.
   2. Open **Index 0**. In **Pickup to Spawn**, click the object picker dropdown.
   3. Search for "Animal Bones". Now the enemies that are eliminated will drop animal bones.

      [![Pickup to spawn](https://dev.epicgames.com/community/api/documentation/image/2844146b-e124-47a5-9184-b7897a835ac2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2844146b-e124-47a5-9184-b7897a835ac2?resizing_type=fit)
4. Drag another Accolade device into your scene.
5. From the **Details** panel of the new Accolade device:

   1. Set the **Name** to "Zombie Bounty".
   2. Set the **XP Award** to **Very Large**.
   3. Set the **Splash Size** to **Large.**
6. Search for "conditional" in the Content Browser.
7. Drag a **Conditional Button** device into your scene.
8. From the Details panel of the new Conditional Button device:

   1. Enable **Key Item Required** and set the number to **5** on the same line.
   2. Find **Key Item 1** and expand the options.
   3. On the **Item Definition** property, click the dropdown.
   4. Search for "Animal Bones".
   5. Select the "Animal Bone" object.

      [![Conditional button options](https://dev.epicgames.com/community/api/documentation/image/9a1d81bd-208c-4d2e-9f11-0182faf562a6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9a1d81bd-208c-4d2e-9f11-0182faf562a6?resizing_type=fit)

### Creating the Verse Script

1. Create a new Verse device named **accolade\_example** using [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), and drag the device into the level. To learn how to create a new device in Verse, see [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).
2. Open [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite) and double-click **accolade\_example.verse** to open the script in Visual Studio Code.
3. In the `accolade_example` class definition, add the following fields.

   1. An editable accolades device named `Accolades`, which references your accolades device in the level.
   2. An editable conditional button named `ConditionalButton`. You’ll use this to award points to the player when they submit the required number of bones.

      ```verse
       accolade_example := class(creative_device):
      		
          @editable
          Accolades:accolades_device = accolades_device{}
      		
          @editable
          ConditionalButton:conditional_button_device = conditional_button_device{}
      ```
4. In `OnBegin()`, subscribe the `ConditionalButton` `ActivatedEvent` to a new function named `BountyComplete`.

   ```verse
        OnBegin<override>()<suspends>:void=
            ConditionalButton.ActivatedEvent.Subscribe(BountyComplete)
   ```
5. Add the new method `BountyComplete()` to the `accolade` class. This method awards the player who activated the `ConditionalButton` with the `Accolades` score.

   ```verse
        # Awards score to the player who activated
        # the ConditionalButton
        BountyComplete(Agent:agent):void=
            Accolades.Award(Agent)
   ```
6. Your `accolade_example` code should now look like:

   ```verse
        using { /Fortnite.com/Devices }
        using { /Verse.org/Simulation }
        using { /UnrealEngine.com/Temporary/Diagnostics }

        accolade_example := class(creative_device):

            @editable
            Accolades:accolades_device = accolades_device{}

            @editable
            ConditionalButton:conditional_button_device = conditional_button_device{}

            OnBegin<override>()<suspends>:void=
                ConditionalButton.ActivatedEvent.Subscribe(BountyComplete)

            # Awards score to the player who activated
            # the ConditionalButton
            BountyComplete(Agent:agent):void=
                Accolades.Award(Agent)
   ```
7. Save the script in Visual Studio Code, and in the Main Menu, under Verse, click **Build Verse Code** to compile your code. If errors are discovered, you can find them in the Message Log panel under the **Verse Build** section.

   [![build verse code](https://dev.epicgames.com/community/api/documentation/image/6e850b7f-52bf-411f-99f5-d09309ef5810?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e850b7f-52bf-411f-99f5-d09309ef5810?resizing_type=fit)
8. Navigate to **<ProjectName> Content** > **Creative Devices**, find your Verse device, and drag it into your scene.
9. With the Verse device selected, in the **Details** panel, assign the object reference for the Accolade device and the Conditional Button device. You can use the eyedropper to pick the object in the viewport, or use the dropdown and search for the device.

   [![Verse Devices Details](https://dev.epicgames.com/community/api/documentation/image/acc8bed5-12c0-4886-88a6-8fc21f8f5efe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/acc8bed5-12c0-4886-88a6-8fc21f8f5efe?resizing_type=fit)

## Playtesting Your Island

Once everything is set up and ready to go, [playtest your island](https://dev.epicgames.com/documentation/en-us/uefn/playtesting-your-island-unreal-editor-for-fortnite) to make sure that it runs as expected in Fortnite.

When playing your level, you should see boilerplate debug text on the screen that tells you when the accolade device is activated and awarding XP.

This is what happens when you eliminate zombies.

This is what happens when you cash in 5 bone parts.

## Publishing Your Island

To **Publish** your island, see [Publishing Projects](https://dev.epicgames.com/documentation/en-us/uefn/publishing-projects-in-unreal-editor-for-fortnite).

After your island’s [calibration](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#calibration) period completes, you should be able to play your game and see XP awards.
