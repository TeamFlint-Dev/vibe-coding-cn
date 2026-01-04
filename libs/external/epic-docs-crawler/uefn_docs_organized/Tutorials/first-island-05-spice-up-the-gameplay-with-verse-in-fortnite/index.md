# 5. Spice Up the Gameplay with Verse

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/first-island-05-spice-up-the-gameplay-with-verse-in-fortnite
> **爬取时间**: 2025-12-26T23:53:27.656130

---

**Verse** is a programming language that works with UEFN. This page covers the basics for quickly adding Verse into your projects, providing a foundation for programmers both new and experienced to get a feel for what can be done with the language.

The target devices you created earlier in this tutorial cannot be knocked down with a single hit, so you're going to learn how to use Verse to make them do exactly that!

## Create a New Verse Device

You're going to create a Verse device and place it on your island.

Think of this as a device that will tell other devices what to do based on your instructions. Another way of putting it is that you're going to make a Verse program that reprograms an existing device in UEFN!

1. On the **menu bar**, select **Verse** > **Verse Explorer**.

   [![](https://dev.epicgames.com/community/api/documentation/image/04eaea1e-71f7-45ef-bae5-188d7718c5ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04eaea1e-71f7-45ef-bae5-188d7718c5ec?resizing_type=fit)

   Open the Verse Explorer.
2. In the **Verse Explorer**, right-click on your project and select **Add new Verse file to project**.

   [![](https://dev.epicgames.com/community/api/documentation/image/1f36c33c-4997-44e5-acea-be0b3bde09f1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1f36c33c-4997-44e5-acea-be0b3bde09f1?resizing_type=fit)

   Add a new Verse file to your project.

   This opens the **Create Verse Script** window.

   [![](https://dev.epicgames.com/community/api/documentation/image/9bc1b5c2-2c52-4fb7-9bff-2ba3355c90c6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9bc1b5c2-2c52-4fb7-9bff-2ba3355c90c6?resizing_type=fit)

   Create a Verse project.
3. In the **Create Verse Script** window, select the **Verse Device** template.
4. Rename the device as **shooting\_range\_manager\_device** at the bottom of the window, then click **Create**.

   You will find the **shooting\_range\_manager\_device** in the **Content Browser** under the project name, or use the search box to find the device.
5. On the **menu bar**, select **Verse** > **Build Verse Code**.

   [![](https://dev.epicgames.com/community/api/documentation/image/0e66e56e-9735-4ee6-9135-9e9d359c9af6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0e66e56e-9735-4ee6-9135-9e9d359c9af6?resizing_type=fit)

   Click Build Verse Code to add your changes to your project.

   When working with code for a Verse device, you have to **build** (also called **compiling**) the device before you can use it. This means letting Verse put it into a format that you can run as a game or a part of a game. The Verse device will not show up in your Content Browser or the Outliner until it has been built.
6. You will find the shooting\_range\_manager\_device in the Content Browser under the project name, or use the search box to find the device.

   [![](https://dev.epicgames.com/community/api/documentation/image/33f543dd-1ab0-4885-b2e7-be9911796fc7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/33f543dd-1ab0-4885-b2e7-be9911796fc7?resizing_type=fit)

   Your Verse Device appears in the Content Browser.
7. Drag the device into the viewport.
8. In the **Details** panel under **User Options**, uncheck **Visible in Game** to hide the device while the game is running.

## Set Up the Good Targets

Remember the **good targets** from [3. Build a Shooting Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/first-island-03-build-a-shooting-gallery-in-fortnite)?

You're going to set up the good targets using your Verse device so that they pop down on a single hit.

1. In the **Verse Explorer**, double-click the `shooting_range_manager_device.verse` to open the Verse file.
2. Delete all of the code in the file then copy the code below and paste it where the old code was.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }

   # A device that manages shooting range gameplay.
   shooting_range_manager_device := class(creative_device):

       @editable
       GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}
   ```

   In Verse, a **variable** is information in the program that can change while the program is running.

   When a variable is **editable**, this means that the code is **exposed** in UEFN, which in turn means that it can be changed from within UEFN without needing to rebuild your Verse code every time.

   The code you just added to the Verse device makes three variables (GoodTarget1, GoodTarget2, and GoodTarget3) that are of the type `shooting_range_track_device`. These will represent the targets the player will score points by hitting. By making these `@editable`, you can now set their values in the **Details** panel however you like without having to keep changing your Verse code. This code will still need to be compiled, because it's the first time you're adding it.
3. With the Details panel of your **shooting\_range\_manager\_device** open, from the viewport, select the **shooting\_range\_manager\_device**.
4. Compile your code.
5. In the **Details** panel, set the value for each good target to a different Target Dummy Track device.

   [![](https://dev.epicgames.com/community/api/documentation/image/e2807d11-1ed2-4da7-9977-5a4d7f013f04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e2807d11-1ed2-4da7-9977-5a4d7f013f04?resizing_type=fit)

   The Verse device's User Options.
6. Starting at `<# --- New Code Start --- #>` in the code block below, copy and paste the next chunk of code into the Verse file.
7. Compile your code after pasting.
8. Add the following code to make a good target pop down when hit.

   The event subscriptions link the target's **HitEvent** and the callback defined for that target.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }

   # A device that manages shooting range gameplay.
   shooting_range_manager_device := class(creative_device):

       @editable
       GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}

   <# --- New Code Start --- #>

       # Runs when the device is started in a running game.
       OnBegin<override>()<suspends>:void=
           # Subscribing to the GoodTarget HitEvents.
           GoodTarget1.HitEvent.Subscribe(OnGoodTarget1Hit)
           GoodTarget2.HitEvent.Subscribe(OnGoodTarget2Hit)
           GoodTarget3.HitEvent.Subscribe(OnGoodTarget3Hit)

       # A hit callback that pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           GoodTarget1.PopDown()
       
       # A hit callback that pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           GoodTarget2.PopDown()

       # A hit callback that pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           GoodTarget3.PopDown()

   <# --- New Code End--- #>
   ```

Whenever you see a line in a code block that starts with **`#` or** `<# and ends with #>`, these are called **code comments**.

Code Comments are not part of the program. They are comments written by the programmer to provide information to other programmers, or to remind themselves why they did something the way they did.

For more information about code comments, see the [Code Comments](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-quick-reference#:~:text=4%20lines%20long)-,Code%20Comments,-A%20code%20comment) section of the [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference).

## Set Up the Bad Targets

Your bad targets are the **Target Dummy** devices, customized as **Teddy Bears**. This time, you'll add them to your Verse device so that they'll pop down with a single hit, but make it so that the player loses points with each hit instead of gaining points.

1. Add the following code to create three `shooting_range_target_device` variables to store references to the bad targets.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }

   # A device that manages shooting range gameplay.
   shooting_range_manager_device := class(creative_device):

       @editable
       GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}

   <# --- New Code Start --- #>

       @editable
       BadTarget1:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget2:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget3:shooting_range_target_device = shooting_range_target_device{}

   <# --- New Code End --- #>

       # Runs when the device is started in a running game.
       OnBegin<override>()<suspends>:void=
           # Subscribing to the GoodTarget HitEvents.
           GoodTarget1.HitEvent.Subscribe(OnGoodTarget1Hit)
           GoodTarget2.HitEvent.Subscribe(OnGoodTarget2Hit)
           GoodTarget3.HitEvent.Subscribe(OnGoodTarget3Hit)

       # A hit callback that pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           GoodTarget1.PopDown()
       
       # A hit callback that pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           GoodTarget2.PopDown()

       # A hit callback that pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           GoodTarget3.PopDown()
   ```
2. Compile your code.
3. Select the **shooting\_range\_manager\_device** in the viewport.
4. In the **Details** panel, set the value for each bad target to a different Target Dummy device.
5. Add the following code to pop down the bad targets when hit.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }

   # A device that manages shooting range gameplay.
   shooting_range_manager_device := class(creative_device):

       @editable
       GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       BadTarget1:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget2:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget3:shooting_range_target_device = shooting_range_target_device{}

       # Runs when the device is started in a running game.
       OnBegin<override>()<suspends>:void=
           # Subscribing to the GoodTarget HitEvents.
           GoodTarget1.HitEvent.Subscribe(OnGoodTarget1Hit)
           GoodTarget2.HitEvent.Subscribe(OnGoodTarget2Hit)
           GoodTarget3.HitEvent.Subscribe(OnGoodTarget3Hit)

   <# --- New Code Start --- #>

           # Subscribing to the BadTarget HitEvents.
           BadTarget1.HitEvent.Subscribe(OnBadTarget1Hit)
           BadTarget2.HitEvent.Subscribe(OnBadTarget2Hit)
           BadTarget3.HitEvent.Subscribe(OnBadTarget3Hit)

   <# --- New Code End --- #>

       # A hit callback that pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           GoodTarget1.PopDown()
       
       # A hit callback that pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           GoodTarget2.PopDown()

       # A hit callback that pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           GoodTarget3.PopDown()

   <# --- New Code Start --- #>

       # A hit callback that pops down the first BadTarget.
       OnBadTarget1Hit():void=
           BadTarget1.PopDown()

       # A hit callback that pops down the second BadTarget.
       OnBadTarget2Hit():void=
           BadTarget2.PopDown()

       # A hit callback that pops down the third BadTarget.
       OnBadTarget3Hit():void=
           BadTarget3.PopDown()

   <# --- New Code End --- #>
   ```

## Set Up Scoring

Before you can use Verse to customize a device, you have to add the device you want to customize.

You can set up scoring using only Fortnite devices, but it is easier to do this in Verse, and you can do it with fewer devices.

### Add a Scoring Device

Even though you will be setting up two types of scoring (adding points and subtracting points), by using Verse, you only need one scoring device to do it all.

1. From the **Content Browser**, type **Score Manager** in the search bar to find the Score Manager device.

   [![Search for the Score Manager in the search bar.](https://dev.epicgames.com/community/api/documentation/image/0b9021d1-a8c4-49f4-bbc9-d77eac0f392f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b9021d1-a8c4-49f4-bbc9-d77eac0f392f?resizing_type=fit)

   Search for the Score Manager in the search bar.
2. Drag the **Score Manager** device into the viewport. The Score Manager user options should be open in the **Details** panel.
3. From the **Details** panel, modify the following options:

   | Option and Value |
   | --- |
   | Enable During Phase = **Gameplay Only**  Display Score Update on HUD = **Check** |

### Customize the Scoring Device with Verse

Now you can add the Score Manager to your Verse device and adjust the player's score based on the targets hit.

1. Add the following code to create variables for a storing reference to the score manager and score values. You can change default score values by changing the assigned values or override the default by changing the values in the **Details** panel.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }

   # A device that manages shooting range gameplay.
   shooting_range_manager_device := class(creative_device):

   <# --- New Code Start --- #>

       @editable
       ScoreManager:score_manager_device = score_manager_device{}

   <# --- New Code End--- #>

       @editable
       GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}

   <# --- New Code Start --- #>

       @editable
       var GoodTargetScore:int = 100

   <# --- New Code End --- #>

       @editable
       BadTarget1:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget2:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget3:shooting_range_target_device = shooting_range_target_device{}

   <# --- New Code Start --- #>

       @editable
       var BadTargetScore:int = -100

   <# --- New Code End --- #>

       # Runs when the device is started in a running game.
       OnBegin<override>()<suspends>:void=
           # Subscribing to the GoodTarget HitEvents.
           GoodTarget1.HitEvent.Subscribe(OnGoodTarget1Hit)
           GoodTarget2.HitEvent.Subscribe(OnGoodTarget2Hit)
           GoodTarget3.HitEvent.Subscribe(OnGoodTarget3Hit)

           # Subscribing to the BadTarget HitEvents.
           BadTarget1.HitEvent.Subscribe(OnBadTarget1Hit)
           BadTarget2.HitEvent.Subscribe(OnBadTarget2Hit)
           BadTarget3.HitEvent.Subscribe(OnBadTarget3Hit)

       # A hit callback that pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           GoodTarget1.PopDown()
       
       # A hit callback that pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           GoodTarget2.PopDown()

       # A hit callback that pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           GoodTarget3.PopDown()

       # A hit callback that pops down the first BadTarget.
       OnBadTarget1Hit():void=
           BadTarget1.PopDown()

       # A hit callback that pops down the second BadTarget.
       OnBadTarget2Hit():void=
           BadTarget2.PopDown()

       # A hit callback that pops down the third BadTarget.
       OnBadTarget3Hit():void=
           BadTarget3.PopDown()
   ```
2. Compile your code.
3. Select the **shooting\_range\_manager\_device** in the viewport.
4. In the **Details** panel of the **shooting\_range\_manager\_device**, set **ScoreManager** to the Score Manager device.

   [![All targets are found in the Verse device.](https://dev.epicgames.com/community/api/documentation/image/4db1752d-19d1-4aa5-93dc-57fcdc419bd5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4db1752d-19d1-4aa5-93dc-57fcdc419bd5?resizing_type=fit)

   All targets are found in the Verse device.
5. Add the following code to update the player's score when hitting good and bad targets.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }

   # A device that manages shooting range gameplay.
   shooting_range_manager_device := class(creative_device):

       @editable
       ScoreManager:score_manager_device = score_manager_device{}

       @editable
       GoodTarget1:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget2:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       GoodTarget3:shooting_range_target_track_device = shooting_range_target_track_device{}

       @editable
       var GoodTargetScore:int = 100

       @editable
       BadTarget1:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget2:shooting_range_target_device = shooting_range_target_device{}

       @editable
       BadTarget3:shooting_range_target_device = shooting_range_target_device{}

       @editable
       var BadTargetScore:int = -100

       # Runs when the device is started in a running game.
       OnBegin<override>()<suspends>:void=
           # Subscribing to the GoodTarget HitEvents.
           GoodTarget1.HitEvent.Subscribe(OnGoodTarget1Hit)
           GoodTarget2.HitEvent.Subscribe(OnGoodTarget2Hit)
           GoodTarget3.HitEvent.Subscribe(OnGoodTarget3Hit)

           # Subscribing to the BadTarget HitEvents.
           BadTarget1.HitEvent.Subscribe(OnBadTarget1Hit)
           BadTarget2.HitEvent.Subscribe(OnBadTarget2Hit)
           BadTarget3.HitEvent.Subscribe(OnBadTarget3Hit)

   <# --- New Code Start --- #>

       # A hit callback that scores and pops down the first GoodTarget.
       OnGoodTarget1Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget1.PopDown()
       
       # A hit callback that scores and pops down the second GoodTarget.
       OnGoodTarget2Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget2.PopDown()

       # A hit callback that scores and pops down the third GoodTarget.
       OnGoodTarget3Hit():void=
           AdjustScore(GoodTargetScore)
           GoodTarget3.PopDown()

       # A hit callback that scores and pops down the first BadTarget.
       OnBadTarget1Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget1.PopDown()

       # A hit callback that scores and pops down the second BadTarget.
       OnBadTarget2Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget2.PopDown()

       # A hit callback that scores and pops down the third BadTarget.
       OnBadTarget3Hit():void=
           AdjustScore(BadTargetScore)
           BadTarget3.PopDown()

       # Adjusts the player's score by the provided value.
       AdjustScore(Value:int):void=
           ScoreManager.SetScoreAward(Value)

         # Gets the first player in the playspace.
           if (Player:player = GetPlayspace().GetPlayers()[0]):
               # Awards the points to the player.
               ScoreManager.Activate(Player)

   <# --- New Code End --- #>
   ```
6. Compile your code.
7. Select **Verse** > **Build Verse Code** from the **Menu Bar**.

   If you keep your Fortnite session open, click Push Changes to the live edit so it receives the updates you made with Verse. You may also have to end and restart a game to see the changes come through properly.
8. Playtest your changes in your Fortnite session to make sure that:

   1. Your score increases when hitting a good target. (Open the scoreboard while playing by pressing the **M** key.)
   2. Your score decreases when you hit a bad target.
   3. You can knock targets down with one hit.

## Next Up

[![6. Use Props to Set a Theme](https://dev.epicgames.com/community/api/documentation/image/3a929ba4-66c4-48be-bda0-6cacdc690579?resizing_type=fit&width=640&height=640)

6. Use Props to Set a Theme

Set the appearance of your game using props and galleries from Fortnite Creative!](https://dev.epicgames.com/documentation/en-us/fortnite/first-island-06-use-props-to-set-a-theme-in-fortnite)
