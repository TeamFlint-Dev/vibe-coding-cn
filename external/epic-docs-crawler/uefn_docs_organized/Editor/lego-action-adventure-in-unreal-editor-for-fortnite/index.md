# LEGO® Action Adventure Template

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/lego-action-adventure-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:37:22.026296

---

The LEGO® Action Adventure Template provides the building blocks for a classic action-adventure gameplay complete with quests, combat, and puzzles. Most of all, this template showcases the [LEGO® Assembly Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-lego-assembly-devices-in-fortnite-creative) device so you can prove to the world that you're a certified LEGO professional builder. Lock into this experience while enjoying its relaxing vibes and soothing sounds.

In this gameplay, there is one universe - but many worlds to save and many hats to wear. Become a Warrior, Blaster, or Thief, and unlock quests that utilize unique tools as you change your play style for each class persona. With each class, carry out your heroic duty to save the universe as you combat pesky enemies.

In the land of LEGO, it pays to be a hero. Your actions can award studs which you can use to assemble props that unlock new areas, fulfill quest requirements, and unlock in-game trophies. As you progress through each class, you will encounter rewarding trials that keep you on your toes as you navigate through obstacles.

[![](https://dev.epicgames.com/community/api/documentation/image/63133af1-886a-4e48-aa5e-c85342aebaf5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63133af1-886a-4e48-aa5e-c85342aebaf5?resizing_type=fit)

At the end of each class quest, you will find that the banana has gone bad! It's up to you to boss battle the rogue Peely Bone NPC in a Verse-based attack system. You will encounter this battle with each class as you change your fighting style to match your weapon.

When it's all over, finish the gameplay with a tutorial alongside the following walkthrough, and save your universe by learning the mechanics to recreate this experience. Good luck on your adventure, hero!

## Access the LEGO Action Adventure Template

Follow the steps below to access this template within UEFN.

1. Within the **Project Browser**, navigate to **Brand Templates**, then use the **All Brands** dropdown to select **LEGO® Island**.
2. Select **LEGO Action Adventure Template**. Then under **Project Name**, type your project's name.
3. Under **Project Defaults**, set if your project will be under **Unreal Revision Control** and set the **Team Selection**.
4. Click **Create** to load your project.

## Create a Custom Quest

The Action Adventure template offers many quests that give players a sense of purpose throughout the gameplay. These quests are tracked individually through persistent data.

Launch a session so that you can test your quest as you create it.

You can create a Verse device to set up quests within your game and grant items such as **[LEGO® Collectible](https://dev.epicgames.com/documentation/en-us/fortnite/using-lego-collectible-devices-in-fortnite-creative)** studs as rewards for players. You can also use this quest system to progress the story of your gameplay.

Through events such as **Quest Started**, **Quest Aborted**, and **Quest Completed**, you can make items appear when the quests start.

To create a quest system, follow the steps below.

1. In the Viewport toolbar, [create a Verse device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite) named **LEGO\_quest\_giver**, and drag it into your project.
2. Then, drag two Button devices into your project.

   1. Name one as **button\_quest\_giver** and the other as **button\_quest**.
3. Add the following Verse code to your project.

   ```verse
   using { /Fortnite.com/Characters }
   using { /Fortnite.com/Devices }
   using { /Verse.org/Simulation }
   using { /UnrealEngine.com/Temporary/Diagnostics }

   # ====================================================================================================================================
   # LEGO quest giver device that manages a linear quest system
   # ====================================================================================================================================
   lego_quest_giver_device_log<public> := class(log_channel) {}

   lego_quest_giver_device := class(creative_device):

       @editable:
           ToolTip := Tooltip_QuestGiver_Name
       QuestGiverName<public> : string = "Quest Giver"

       @editable:
           ToolTip := Tooltip_Button_Interact
       Button_Interact : button_device = button_device{}

       @editable:
           Categories := array{Category_FinishedGuidance}
           ToolTip := Tooltip_QuestGiver_Tracker
       TrackerDevice<public> : tracker_device = tracker_device{}

       @editable:
           Categories := array{Category_FinishedGuidance}
           ToolTip := Tooltip_BeaconReturn
       ReturnBeacon<public> : beacon_device = beacon_device{}

       @editable:
           ToolTip := Tooltip_AutoProgressDialog
           Categories := array{Category_Settings}
       AutoProgressDialog<public> : logic = true

       @editable:
           ToolTip := Tooltip_ResetProgress
           Categories := array{Category_Settings}
       Trigger_ResetProgress : ?trigger_device = false

       @editable:
           ToolTip := Tooltip_Quests
       Quests : []lego_quest = array{}

       Logger<protected>: log = log{Channel := lego_quest_giver_device_log, DefaultLevel:= log_level.Normal}

       OnBegin<override>()<suspends>:void=
           # Bind to button interaction event
           Button_Interact.InteractedWithEvent.Subscribe(OnRequestInteraction)
           Button_Interact.SetInteractionText(ToMessage("Talk to {QuestGiverName}"))

           # Bind to Reset request trigger
           if (ValidTrigger := Trigger_ResetProgress?):
               ValidTrigger.TriggeredEvent.Subscribe(OnResetProgress)
           
           # Setup Tracker Device (Return to QuestGiver message)
           TrackerDevice.SetTitleText(ToMessage("Completed Quest"))
           TrackerDevice.SetDescriptionText(ToMessage("Return to {QuestGiverName}"))

           # Setup Event subscribes for all quests
           for (Quest : Quests):
               Quest.Setup(Self, TrackerDevice, ReturnBeacon)

       # ---------------------------------------------------------------------------------------------------------------------------------
       # Player Interaction with QuestGiver
       # 1) Show Dialog UI
       # 2) Wait for player interaction that closes the UI
       # 3) Process and apply Response from Dialog UI (Start / Complete / Abort quest / Close)
       # ---------------------------------------------------------------------------------------------------------------------------------
       OnRequestInteraction<public>(InAgent : agent): void=
           if (Quests.Length = 0):
               Logger.Print("OnRequestInteraction failed - no quests found.", ?Level := log_level.Error)
               return

           TrackerDevice.Complete(InAgent)
           spawn{InteractWithQuestGiver(InAgent)}

       InteractWithQuestGiver<private>(InAgent : agent)<suspends>: void=
           TrackerDevice.Complete(InAgent)
           QuestProgressData := GetQuestLineProgression(InAgent)

           # Create UI to be shown to the player
           DialogUI := lego_quest_dialog{}

           # Configure UI based on QuestLine progression 
           # iE. what button text to display and what Dialog option to show
           Title := if(ValidQuest := QuestProgressData(1)?) {ToMessage(ValidQuest.Name)} else {ToMessage("")}
           Dialog_Start := if(ValidQuest := QuestProgressData(1)?) {ToMessage(ValidQuest.DisplayText.DialogText_Start)} else {ToMessage("I don`t have any quests for you right now.")}
           Dialog_Complete := if(ValidQuest := QuestProgressData(1)?) {ToMessage(ValidQuest.DisplayText.DialogText_Complete)} else {ToMessage("")}

           var Text : ?message = false
           var Button_1_Text : string = ""
           var Button_2_Text : string = ""

           case (QuestProgressData(0)):
               en_lego_quest_progress.NotStarted =>
                   set Button_1_Text = "Accept Quest "
                   set Button_2_Text = "Decline Quest"
                   set Text = option{Dialog_Start}
               en_lego_quest_progress.IsActive =>
                   set Button_2_Text = "Abort Quest"
                   set Text = option{Dialog_Start}
               en_lego_quest_progress.CanBeCompleted =>
                   set Button_1_Text = "Finish Quest"
                   set Button_2_Text = "Abort Quest"
                   set Text = option{Dialog_Complete}
               en_lego_quest_progress.None =>
                   set Text = option{Dialog_Start}
               _=>

           Button_1_Message : message = ToMessage(Button_1_Text)
           Button_2_Message : message = ToMessage(Button_2_Text)

           # Data to be passed to the UI class, the LEGO_quest_dialog will then process and display it
           DialogConfig := lego_dialog_config:
               Title := option{Title},
               Text := Text, 
               Button_1_Text := if(Button_1_Text.Length > 0) {option{Button_1_Message}} else {false},
               Button_2_Text := if(Button_2_Text.Length > 0) {option{Button_2_Message}} else {false}

           # 1) Show UI
           DialogUI.ShowDialog(InAgent, DialogConfig)

           # 2) Wait for player interaction
           DialogResponse := DialogUI.OnDialogCompleted.Await()

           # 3) Process Response from the UI
           #    Which Button did the player press? Start / Complete / Abort / Close
           if (DialogResponse = en_lego_quest_dialog_response.Close) {return}

           # Process Response based on the players progress through the questline
           if (ValidQuest := QuestProgressData(1)?):
               case (QuestProgressData(0)):
                   # Start new quest
                   en_lego_quest_progress.NotStarted =>
                       if (DialogResponse = en_lego_quest_dialog_response.Accept):
                           ValidQuest.StartQuest(InAgent)

                   # Complete active quest
                   en_lego_quest_progress.CanBeCompleted =>
                       if (DialogResponse = en_lego_quest_dialog_response.Accept):
                           ValidQuest.CompleteQuest(InAgent)
                           
                           # Open next quest Dialog (if auto Dialog progression is enabled)
                           if (AutoProgressDialog?) {spawn{InteractWithQuestGiver(InAgent)}}

                   # Abort quest
                       if (DialogResponse = en_lego_quest_dialog_response.Decline):
                           ValidQuest.AbortQuest(InAgent)

                   # Abort quest
                   en_lego_quest_progress.IsActive =>
                       if (DialogResponse = en_lego_quest_dialog_response.Decline):
                           ValidQuest.AbortQuest(InAgent)

                   _=>
                       # No Response to process
           else:
               Logger.Print("InteractWithQuestGiver failed - no valid quest found.", ?Level := log_level.Error)

       # ---------------------------------------------------------------------------------------------------------------------------------

       # ---------------------------------------------------------------------------------------------------------------------------------
       # QuestLine Progression
       # Loop over all the quests and return the first quest that can either be started, completed or is active
       # ---------------------------------------------------------------------------------------------------------------------------------
       GetQuestLineProgression<public>(InAgent : agent)<transacts>: tuple(en_lego_quest_progress, ?lego_quest)=
           if (Quests.Length = 0):
               Logger.Print("GetQuestLineProgression: QuestGiver has no quests.", ?Level := log_level.Warning)

           for (Quest : Quests):
               # Quest can be started
               if (Quest.CanBeStarted[InAgent]):
                   return (en_lego_quest_progress.NotStarted, option{Quest})

               # Quest is active and can be completed or aborted
               if (Quest.IsActive[InAgent]):
                   if (Quest.CanBeCompleted[InAgent]):
                       return (en_lego_quest_progress.CanBeCompleted, option{Quest})
                   return (en_lego_quest_progress.IsActive, option{Quest})

           # No available quests
           return (en_lego_quest_progress.None, false)
       # ---------------------------------------------------------------------------------------------------------------------------------

       # This function is called when the Trigger_ResetProgress is activated and resets all quest progress for the activating player
       OnResetProgress<public>(InAgent : ?agent): void=
           if:
               ValidAgent := InAgent?
               ValidQuestLog := ValidAgent.LoadLegoQuestLog[]
           then:
               UpdatedQuestLog := LEGO_persistent_quest_log:
                   ActiveQuests := array{},
                   CompletedQuests := array{}
               if (ValidAgent.SaveLegoQuestLog[UpdatedQuestLog]) {}
           else:
               Logger.Print("ResetPersistentData failed - no quest log found.", ?Level := log_level.Error)

   Tooltip_QuestGiver_Name<public><localizes>:message = "The name of the quest giver as it will appear in the tracker UI and button interaction text."
   Tooltip_Button_Interact<public><localizes>:message = "The button that the player must press to interact with the quest giver."
   Tooltip_QuestGiver_Tracker<public><localizes>:message = "The tracker_device used to display the return to questgiver message."
   Tooltip_BeaconReturn<public><localizes>:message = "This beacon can be used to guide the player back to the quest giver once a quest is completed."
   Tooltip_AutoProgressDialog<public><localizes>:message = "If true, the quest giver will automatically show the next quest Dialog after the player has completed a quest."
   Tooltip_ResetProgress<public><localizes>:message = "Trigger device that will reset the progress in all quests for the activating player."
   Tooltip_Quests<public><localizes>:message = "The quests that the quest giver can give to the player."

   Category_Settings<public><localizes>:message = "Settings"
   Category_FinishedGuidance<public><localizes>:message = "Quest finished guidance"
   ```
4. From the **Content Browser**, navigate to **Fortnite** > **Devices**> **Logic**, and drag two **Tracker**devices into your project.

   1. Name one as **tracker\_main\_quest**and the other as **tracker\_quest\_giver**.
5. Place the button\_quest button device in a visible location near your NPC so players can activate the quest.
6. Place the button\_quest\_giver button device inside the hologram of the NPC so that it is hidden.
7. From the **Content Browser**, navigate to **Fortnite**> **Devices**> **!Beta**, and drag an [NPC Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-spawner-devices-in-unreal-editor-for-fortnite) device into your project.

### Configure the Quest Device

Next, configure the LEGO\_quest\_giver device, and link your devices to set up your first quest system. To do so, follow the steps below.

1. In your project or in the **Outliner** panel, select the LEGO\_quest\_giver device.
2. In the **Details** panel of the device, navigate to **QuestGiverName**, and set the quest-giving name of the NPC.
3. Next, navigate to **Button\_Interact**, and set the option to **button\_quest\_giver**.
4. Navigate to **TrackerDevice**, and set the option to **tracker\_quest\_giver**.

The quest system is set up as an array of either **lego\_quest** or **lego\_quest\_repeatable**. A LEGO quest is a single quest system that players can progress through in any order.

### Create Repeatable Quests

For repeatable quests, you can even create a mechanic that requires constant stud pickups or set enemies that can be defeated multiple times.

1. In the **Details** panel of the LEGO\_quest\_giver device, select the **+** icon for **Quests** to add an array element to the quest.
2. Make sure the array is set to **LEGO\_quest**, then navigate to **Name**, and type the name of the quest.
3. Expand the **Display Text** array, and set the text for dialogue.
4. Under the **Quest** array, navigate to **TrackerDevice**, and set the option to **tracker\_main\_quest**.

Your players will not be able to accept new quests unless you set your quest to be repeatable. You can also configure a **[Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative)** device to reset the progression of the quest.

### Reset Quests

To set your quests to reset, follow the steps below.

1. From the **Content**Browser, navigate to **Fortnite** > **Devices** > **Logic**, and drag a Trigger device into the project.
2. In the **Outliner** panel, select the LEGO\_quest\_giver device.
3. Then, in the **Details** panel, click the **Trigger\_ResetProgress** dropdown, then select the Trigger device.

In the **Outliner** panel, navigate to **Demo Area** > **DemoDisplay\_Quest** to view the preconfigured demo quest.

### Configure the Trackers

You can use the Tracker device to increment, decrement, and complete your LEGO quests. Each quest should have its own Tracker device assigned to manage its progression.

To create a basic, non-repeatable quest, follow the steps below.

1. In the **Outliner** panel, select the tracker\_main\_quest Tracker device.
2. In the **Details** panel, set **Stat to Track** to **Events**.
3. Set **TargetValue** to **1** to make sure the starting value is zero. This value is incremented every time a quest step is completed. For more quest steps, increase the value so the completion events continue to increment the tracker.
4. Set **Amount to Change** to **1**.
5. Navigate to **IncrementProgress**, then set the array to **ButtonQuest** and the event to **OnInteract**. You can set multiple events as quest requirements to increment this, similar to the quests created in the Action Adventure Template. For example, you can set quest requirements such as entering the world, opening a secret door, or defeating a boss.
6. In the **Outliner** panel, select the tracker\_quest\_giver Tracker device. Then, in the **Details** panel, set **Assign on Start** to **False**.

### Configure the NPC Spawners

You can use the NPC Spawner device to spawn a **Guard** character type, which has the behavior of patrolling and engaging players in combat.

To use a custom Verse NPC character definition with the NPC Spawner device, follow the steps below.

1. From the content folder of your project, create a [Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) blueprint named **NPCDef\_QuestGiver**.
2. In the **Details** panel of the Character Definition, change the settings to match the table below.

   |  |  |  |
   | --- | --- | --- |
   | **Option** | **Value** | **Explanation** |
   | **Type** | Guard | Defines what type of AI character will be spawned by this SpawnDefinition. |
   | **Selected AI** | NanaSplit | Chooses an AI character to spawn from this preset. |
   | **Behavior** | Verse Behavior | Defines how the spawned AI character will behave once spawned. |
   | **NPCBehaviorScript** | npc\_behavior\_quest\_giver | Select a Verse script of the type npc\_behavior to control the spawned NPC |
   | **Accuracy** | Moderate | Determines how accurate Guards are at shooting. |
   | **Can be Down But Not Out** | False | The NPC will not enter the Down But Not Out state. |
   | **Modifiers - Index [0]** | Team Modifier | Sets the modifier to apply. |
   | **Team Option** | Index | Sets the team type. |
   | **Team Index** | 1 | Sets the team type's number. |
3. In the **Outliner** panel, select the NPC Spawner device.
4. In the **Details** panel, set the NPC Character Definition to **NPCDef\_QuestGiver**.

## Award LEGO® Studs

Reward players throughout their gameplay by awarding LEGO® Collectible studs for their actions and by defeating enemies. You can either manually place studs or use Verse to set them to randomly spawn throughout your environment so users can get them by eliminating NPCs, destroying props, and completing assembly minigames.

In the Action Adventure template, players are awarded studs that players can use to proceed through the story and purchase in-game trophies. Use the Collectible device to create studs for players to collect.

You can use an object pool to efficiently grant studs throughout your gameplay. Object pools are useful for spawning large amounts of objects.

Instead of constantly creating and destroying studs, you can pre-create them before the game begins and then spawn them as needed. With pre-created objects, you can activate them in their set positions to be released. Pre-initializing resources like studs can help reduce performance costs tied to memory reallocation.

This template uses **[Item Spawner](https://dev.epicgames.com/documentation/en-us/fortnite/using-item-spawner-devices-in-fortnite-creative)** devices alongside the **LEGO\_stud\_spawner\_pool** Verse device to specify a location and number of studs to spawn with the SpawnStudsAtLocation() function. This teleports the required number of Item Spawner devices to the location that spawns studs. Once the Item Spawner device has spawned studs at that location, it’s re-added to the pool and can be reused.

You can add Item Spawner devices to the level, and then give them an associated pool tag, so they will be aggregated and spawned when and where you want them to.

### Create an Object Pool

To create an object pool to spawn studs, follow the steps below.

1. In the **Verse Explorer** panel, create a Verse device named **LEGO\_stud\_pool** and drag it into your project.
2. Add the following Verse code to your project.

   ```verse
   using { /Fortnite.com/Devices }
   using { /Verse.org/Colors }
   using { /Verse.org/Simulation }
   using { /Verse.org/Simulation/Tags }
   using { /UnrealEngine.com/Assets }
   using { /UnrealEngine.com/Temporary/Diagnostics }
   using { /UnrealEngine.com/Temporary/SpatialMath }

   # ============================================================================================================================================
   # Distributes Items by using a pool of ItemSpawners and teleporting them to the desired location
   # ============================================================================================================================================
   lego_stud_system_log<public> := class(log_channel) {}
   lego_stud_system_tag<public> := class(tag) {}
   lego_stud_pool_tag := class(lego_stud_system_tag) {} # The device MUST have this tag to be recognized as a Stud Pool

   lego_stud_pool<public> := class(creative_device):
      var ObjectPool_ItemSpawners_Gravity : []pool_object_pickup = array{}
      var ObjectPool_ItemSpawners_Toss : []pool_object_pickup = array{}

      Logger<protected>: log = log{Channel := lego_stud_system_log, DefaultLevel:= log_level.Normal}

      OnBegin<override>()<suspends>:void=
         Sleep(0.5)
         
         # Find Pre-spawned ItemSpawners via a gameplay tag and add them to the pool
         var PoolSize : int = 0

         for (FoundObject : Self.FindCreativeObjectsWithTag(lego_stud_itemspawner_toss_tag{})):
            if (ValidItemSpawner := item_spawner_device[FoundObject]):
               set PoolSize += 1
               set ObjectPool_ItemSpawners_Toss += array{pool_object_pickup{ItemSpawner := option{ValidItemSpawner}}}

         for (FoundObject : Self.FindCreativeObjectsWithTag(lego_stud_itemspawner_gravity_tag{})):
            if (ValidItemSpawner := item_spawner_device[FoundObject]):
               set PoolSize += 1
               set ObjectPool_ItemSpawners_Gravity += array{pool_object_pickup{ItemSpawner := option{ValidItemSpawner}}}

         Logger.Print("Initialized {PoolSize} Item Spawners")

      # Spawn a number of studs at a location using the available pool objects
      SpawnStudsAtLocation<public>(InLocation : vector3, ?InAmount : int = 1, ?InSpawnType : EN_ItemSpawnerConfig = EN_ItemSpawnerConfig.Toss): void=
         for (Index := 1..InAmount):
            if (ValidPoolObject := GetAvailablePoolObject[InSpawnType]):
               spawn{ValidPoolObject.SpawnStudsAtLocation(InLocation)}

      # Retrieve an available pool object from the pool if possible
      GetAvailablePoolObject<private>(InSpawnType : EN_ItemSpawnerConfig)<transacts><decides> : pool_object_pickup=
         var OutObject : ?pool_object_pickup = false

         case (InSpawnType):

            EN_ItemSpawnerConfig.Toss =>
               for (Object : ObjectPool_ItemSpawners_Toss):
                  if (Object.IsAvailable?):
                     set OutObject = option{Object}

            EN_ItemSpawnerConfig.Gravity =>
               for (Object : ObjectPool_ItemSpawners_Gravity):
                  if (Object.IsAvailable?):
                     set OutObject = option{Object}
         OutObject?

   # Public function to retrieve the Stud Pool via the assigned Tag
   # NOTE: lego_stud_pool is expected to be used as a singleton!
   (InCreativeDevice : creative_device).GetLegoStudPool<public>()<transacts><decides>: lego_stud_pool=
      var OutResult : ?lego_stud_pool = false

      for (FoundObject : InCreativeDevice.FindCreativeObjectsWithTag(lego_stud_pool_tag{})):

         if (ValidItemSpawner := lego_stud_pool[FoundObject]):
            set OutResult = option{ValidItemSpawner}
      OutResult?

   # --------------------------------------------------------------------------------------------------------------------------------------------
   # A single pool object constructed and maintained by the Stud Pool device
   # --------------------------------------------------------------------------------------------------------------------------------------------
   lego_stud_itemspawner_tag := class(lego_stud_system_tag) {}
   lego_stud_itemspawner_toss_tag := class(lego_stud_itemspawner_tag) {}
   lego_stud_itemspawner_gravity_tag := class(lego_stud_itemspawner_tag) {}
   EN_ItemSpawnerConfig<public> := enum{ Toss, Gravity }

   pool_object_pickup := class():
      var ItemSpawner<public> : ?item_spawner_device = false
      var IsAvailable<public> : logic = true
      var Location : vector3 = vector3{}

      SpawnStudsAtLocation(InLocation : vector3)<suspends>: void=
         if (not IsAvailable?):
            return

         set IsAvailable = false
         set Location = InLocation

         if (ValidDevice := ItemSpawner?):
            # Offset the spawning height of the item_spanwer_device to avoid spawning studs in the ceiling
            if (ValidDevice.TeleportTo[InLocation + vector3{Z := - 125.0}, IdentityRotation()]) {}
            Sleep(0.25)
            ValidDevice.SpawnItem()
            Sleep(0.25)
            Release()

      Release<public>(): void=
         if (IsAvailable?):
            return
            
         if {ItemSpawner?.TeleportTo[vector3{}, IdentityRotation()]}
         set IsAvailable = true
   ```
3. In the **Details**panel, click **+Add**, and select **Verse Tag Markup**.
4. In the **Tags**dropdown, expand the array, and select **LEGO\_stud\_pool\_tag**.

### Add the Item Spawners

Each Item Spawner device can only spawn a single stud collectible. Therefore, you must have as many Item Spawner devices in the pool as the amount of studs you’d like to spawn. Follow the steps below to set up Item Spawner devices.

1. From the **Content** Browser, navigate to **Fortnite** > **Devices** > **Items**, and drag an Item Spawner device into your project.
2. In the **Details** panel, add an array to **Item List** and set it toto **CP\_Ingredient\_GoldStu****d**.
3. Navigate to **Initial Movement of Item**, and set the option to **Toss** for the bounce effect when collected.
4. Add a **Verse Tag Markup**, and set it to **lego\_stud\_itemspawner\_tag**.
5. Copy and paste this device as many times as needed to have your desired number of Item Spawners in your pool.

### Use the Pool to Spawn Studs

You can use the Item Spawners from above to spawn studs in your gameplay. This means you can respond to multiple gameplay events only using regular devices.

For example, you can spawn studs when an NPC is eliminated, an Assembly device requirement is met, or even when a quest has been completed.

To spawn pools of studs in your gameplay as a reward when the quest is completed, follow the steps below.

1. In the **Outliner** panel, select the **LEGO Quest Giver** device you created earlier.
2. Navigate to and expand your **Quests** array, and find the **Reward** section. Then, check to see if it is set to **lego\_stud\_spawner**.
3. Under Amount, set the amount of studs you would like to award players. Since the Item Spawner device can only spawn one item, you'll need an Item Spawner device for each award amount. So if your reward is 15, you’ll need 15 Item Spawners devices to spawn these simultaneously.
4. Set the **SpawnType**to **Toss** to match the **Verse Markup Tag** on your Item Spawner devices.
5. You can launch a session to test if spawning works.

## Create a Verse-based Attack System

No adventure is complete without a boss battle! Challenge your players with tough NPC enemies that players must use strategy to defeat.

In this template, NPCs use area-of-effect (AOE) attacks that teleport an **[Explosive](https://dev.epicgames.com/documentation/en-us/fortnite/using-explosive-devices-in-fortnite-creative)** device to players and stun attacks that put players into temporary stasis.

Within the battle arena, players can expect class-based fight enhancements and various powerups to aid them in battle.

You can alter the **npc attack controller** Verse device to control how often and what attacks the NPCs use.

Insert the code below into your own projects to create your own variation of the NPC boss battle.

```verse
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Verse.org }
using { /Verse.org/Assets }
using { /Verse.org/Colors }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Assets }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# ============================================================================================================================================
# Attack controller
# -> periodically interrupts the guard and does a random attack
# ============================================================================================================================================
LEGO_npc_attack_controller_log := class(log_channel){}
npc_attack_controller := class(creative_device):
    @editable:
        ToolTip := Tooltip_NPCSpawner
    NPCSpawner : npc_spawner_device = npc_spawner_device{}

    @editable:
        ToolTip := Tooltip_Cinematic
    AwaitCinematicSequence : ?cinematic_sequence_device = false

    @editable_number(float):
        MinValue := option{0.0}
        ToolTip := Tooltip_TimeBetweenAttacksMin
    TimeBetweenAttacks_Min : float = 2.5

    @editable_number(float):
        MinValue := option{0.0}
        ToolTip := Tooltip_TimeBetweenAttacksMax
    TimeBetweenAttacks_Max : float = 5.0

    @editable:
        ToolTip := Tooltip_Attacks
    Attacks : []npc_attack = array{}

    Logger<protected>: log = log{Channel := LEGO_npc_attack_controller_log, DefaultLevel:= log_level.Normal}

    OnBegin<override>()<suspends>: void=
        NPCSpawner.SpawnedEvent.Subscribe(OnNPCSpawned)
        NPCSpawner.EliminatedEvent.Subscribe(OnEliminatedBehavior)

    # When an NPC is spawned, run the behavior on it
    OnNPCSpawned(InAgent : agent): void=
        if (FortChar := InAgent.GetFortCharacter[]):
            spawn{RunBehavior(InAgent, FortChar)}

        else:
            Logger.Print("boss_attack_controller - OnNPCSpawned failed: no valid FortChar on Agent", ?Level:= log_level.Warning)

    # When an NPC is eliminated, stop the behavior on it
    OnNPCEliminated : event() = event(){}
    OnEliminatedBehavior(InResult : device_ai_interaction_result): void=
        OnNPCEliminated.Signal()

    # Periodically interrupt the guard to determine and start an attack on the nearest player
    RunBehavior(InNPCAgent : agent, InNPCCharacter : fort_character)<suspends>: void=
        if (Cinematic := AwaitCinematicSequence?):
            Cinematic.StoppedEvent.Await()

        race:   
            OnNPCEliminated.Await()

            loop:
                Sleep(GetRandomFloat(TimeBetweenAttacks_Min, TimeBetweenAttacks_Max))
                if:
                    TargetPlayerCharacter := GetNearestPlayerCharacter[InNPCCharacter]
                    Attack := GetRandomAttack[]
                then:
                    Attack.StartAttack(InNPCAgent, InNPCCharacter, TargetPlayerCharacter)

        for (Attack : Attacks; TargetPlayerCharacter := GetNearestPlayerCharacter[InNPCCharacter]):
            Attack.EndAttack(InNPCAgent, InNPCCharacter, TargetPlayerCharacter)

    # --------------------------------------------------------------------------------------------------------------------------------------------
    # Helpers
    # --------------------------------------------------------------------------------------------------------------------------------------------
    GetNearestPlayerCharacter<public>(InNPCCharacter : fort_character)<decides><transacts>: fort_character=
        var Result : ?fort_character = false
        var MinDistance : float = 1000000.0

        for (Player : GetPlayspace().GetPlayers(); PlayerCharacter := Player.GetFortCharacter[]):
            Dist := DistanceSquared(InNPCCharacter.GetTransform().Translation, PlayerCharacter.GetTransform().Translation)
            if (Dist < MinDistance):
                set MinDistance = Dist
                set Result = option{PlayerCharacter}

        Result?

    GetRandomAttack()<decides><transacts>: npc_attack=
        if (OutAttack := Attacks[GetRandomInt(0, Attacks.Length - 1)]) then:
            OutAttack
        else:
            Logger.Print("boss_attack_controller - GetRandomAttack failed: no valid attack", ?Level:= log_level.Warning)
            Attacks[0]

Tooltip_NPCSpawner<public><localizes>:message = "The npc_spawner_device that will spawn the NPCs that will use the attacks."
Tooltip_Cinematic<public><localizes>:message = "The cinematic_sequence_device that will be awaited before starting the behavior."
Tooltip_TimeBetweenAttacksMin<public><localizes>:message = "The minimum time between attacks in seconds."
Tooltip_TimeBetweenAttacksMax<public><localizes>:message = "The maximum time between attacks in seconds."
Tooltip_Attacks<public><localizes>:message = "The attacks that the NPCs will use. Define a custom npc_attack to add a new attack."
```

## Design your Island

Below are a few tips to snap the bricks of your amazing gameplay experience together.

1. Go the extra mile in your project by creating a custom UI to keep your players entertained. This template uses player portraits and heart health bars to deviate from the normal UI design.

   [![](https://dev.epicgames.com/community/api/documentation/image/3ac63edf-fc37-4a46-8602-e801478a2fce?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ac63edf-fc37-4a46-8602-e801478a2fce?resizing_type=fit)
2. Don't let your players get lost! Strategically place LEGO ® Collectible studs to guide players along a desired path.
3. As your puzzles increase in difficulty, be sure to offer HUD hints and text suggestions to lead your players the right way.

   [![](https://dev.epicgames.com/community/api/documentation/image/1507dd58-585b-48d1-b8a0-0c3294251afb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1507dd58-585b-48d1-b8a0-0c3294251afb?resizing_type=fit)
4. Use the Assembly device to unblock hidden areas. You can also combine the device with cinematic sequences and even the **[Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative)** device to bring assembly builds to life.
5. Be sure to check out the entire Verse code used to make this gameplay by clicking **Verse** in the UEFN toolbar.
