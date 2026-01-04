# Create your own NPC Medic

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-npc-medic-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:19:07.512123

---

Medics are a common character archetype in many games. A medic's job is to heal nearby characters, and they help their teammates recover after sustaining damage. Medics serve different roles depending on the game, for instance, doctors that serve patients in a hospital, combat medics that help their team fight as well as heal, or neutral stations that heal anyone.

The medic character you'll create in this example follows a set of logic rules.

- **Idle:**
- **Begin Healing Agents**
- **Healing Loop**
- **Navigate to Agent**

The medic begins idle, and patrols until an agent enters the healing zone. That agent gets added to the medic's healing queue. The medic needs to track the agent it needs to heal next, and a queue provides a useful data structure for this purpose since queues are a first-in, first-out data structure. This means the character that enters the healing zone first will be the first to get healed.

Once the medic gets the agent it needs to heal next, it first checks if the agent's health is below the healing threshold. If so, it begins healing them at a specific rate until the agent's health reaches the threshold, or the agent exits the healing zone. While healing, the medic will attempt to stay close to the agent by continuously navigating to them. Once the agent's health is back up to the threshold, the medic gets the next agent to heal and starts the process over again. If there are no agents to heal, the medic goes back to being idle.

You can visualize the logic of the medic NPC using the Finite-State Machine below. For more information on finite-state machines, check out [Understanding NPC Behaviors](https://dev.epicgames.com/documentation/en-us/fortnite/understanding-npc-behavior-in-unreal-editor-for-fortnite).

[![Medic FSM](https://dev.epicgames.com/community/api/documentation/image/ada7f626-2ddc-4d58-a39f-d22af1e594e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ada7f626-2ddc-4d58-a39f-d22af1e594e7?resizing_type=fit)

By completing this guide, you'll learn how to create a custom medic character using the NPC Behavior Script that heals other nearby characters when their health is under a certain threshold. The complete script is included at the end of this guide for reference.

## Creating a new NPC Behavior Script

To start creating your own NPC Medic Character, create a new NPC Behavior script named **medic\_example**. For more information on creating your own NPC Behavior script, see [Create Your Own NPC Behavior](https://dev.epicgames.com/documentation/en-us/fortnite/create-custom-npc-behavior-in-unreal-editor-for-fortnite). Open the Verse file in Visual Studio Code.

Follow these steps to create an NPC Behavior Script in UEFN that spawns a medic character that heals nearby players.

## Implementing the Healing Queue

The NPC Behavior Script starts with several values used for character movement and debug visualization. You won't need all of them in this script, so you'll remove the unnecessary code now.

1. At the top of the `medic_example` class definition, remove the values before `OnBegin()`. Your medic character will not wait to move to characters, and will instead follow them around when healing. You don't need the debug values for this example, and you'll use other objects to visualize when your medic heals characters.
2. In `OnBegin()`, after getting the character's interfaces in the first `if` statement, remove the code inside the `then` statement. Your medic character does not need to loop between points after spawning, and will instead patrol around their spawn point waiting for characters to heal.
3. Remove the `DrawDebugLocation()` and `DrawDebugLookAt()` functions. You won't use the debug values in this example, so you don't need the associated functions that use them either.

After removing the unneeded code, you can start to build your medic character.

1. At the top of the `medic_example` class definition, add the following values:

   1. editable float `HealingThreshold`. This is the threshold of health characters must be under to receive healing.

      ```verse
       # The HP threshold a character must be at before healing them.
       @editable
       HealingThreshold:float = 50.0
      ```
   2. Add an editable float `HealingDelay`. This is the amount of time to wait between each instance of healing while healing characters. Change this depending on whether you want your medic to heal slower or faster.

      ```verse
       # The HP threshold a character must be at before healing them.
       @editable
       HealingThreshold:float = 50.0
          
       # How long to wait before healing characters
       @editable
       HealingDelay:float = 1.5
      ```
   3. An editable float `HealingAmount`. This is the amount of health to heal characters per healing instance. When your medic NPC heals a character, they will heal the character by a `HealingAmount` every `HealingDelay` seconds.

      ```verse
       # How long to wait before healing characters
       @editable
       HealingDelay:float = 1.5
          
       # How much to heal characters per healing instance
       @editable
       HealingAmount:float = 5.0
      ```
   4. An editable mutator zone `HealVolume`. This is the volume characters enter to receive healing. You'll use a mutator zone in this example because the mutator zone has an `AgentEntersEvent` which your medic can subscribe to and check for characters that might need healing.

      ```verse
       # How much to heal characters per healing instance
       @editable
       HealingAmount:float = 5.0
          
       # The volume characters enter to receive healing.
       @editable
       HealVolume:mutator_zone_device = mutator_zone_device{}
      ```
   5. An editable VFX spawner `VFXSpawner`. Visual feedback is important to know your code is working, so you'll use a VFX spawner to spawn effects when a character is being healed.

      ```verse
       # The volume characters enter to receive healing.
       @editable
       HealVolume:mutator_zone_device = mutator_zone_device{}
          
       # The VFX spawner to play VFX as characters are being healed.
       @editable
       VFXSpawner:vfx_spawner_device = vfx_spawner_device {}
      ```
   6. A variable optional `agent` named `AgentToFollow`. This stores a reference to the character the medic should follow while healing them.

      ```verse
       # The VFX spawner to play VFX as characters are being healed.
       @editable
       VFXSpawner:vfx_spawner_device = vfx_spawner_device {}
          
       # The agent to follow while they're being healed
       var AgentToFollow:?agent = false
      ```
   7. A variable queue of agents named `AgentsToHeal`. If multiple characters need healing, your medic will heal characters based on the order they entered the `HealVolume`. You'll set up the queue code in the next step. For more information on the queue data structure, see [stacks and queues in verse](stacks-and-queues-in-verse).

      ```verse
       # The agent to follow while they're being healed
       var AgentToFollow:?agent = false

       # The queue of agents to heal in the case of multiple agents entering the heal volume.
       var AgentsToHeal<public>:queue(agent) = queue(agent){}
      ```
   8. A variable float `UpdateRateSeconds`. This is the amount of time to wait between updating the position of the `HealVolume` and `VFXSpawner`.

      ```verse
       # The queue of agents to heal in the case of multiple agents entering the heal volume.
       var AgentsToHeal<public>:queue(agent) = queue(agent){}

       # Used to specify how quickly to update the position of the HealVolume and VFXSpawner
       UpdateRateSeconds<private>:float = 0.1
      ```
2. To implement the `AgentsToHeal` queue, you'll use the code provided at the end of this step.

   1. Back In [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), right-click on your project name and choose **Add new Verse file to project** to open the **Create Verse Script** window.

   [![Add New Verse File To Project](https://dev.epicgames.com/community/api/documentation/image/3585c1f0-c418-4218-8f6c-6d40e94beab8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3585c1f0-c418-4218-8f6c-6d40e94beab8?resizing_type=fit)

   1. In the Create Verse Script window, click **Verse Class** to select it as your script.
   2. Name your Verse class by changing the text in the **Class Name** field to `queue`.
   3. Click **Create** to create the Verse file.
   4. In Verse Explorer, double-click the name of your Verse file to open it in Visual Studio Code.
   5. Replace the code in your `queue` file with the following code. This code implements a generic queue of type `type` using a list data structure. This is an example of a [parametric type](https://dev.epicgames.com/documentation/en-us/fortnite/parametric-types-in-verse) since the queue implementation will work regardless of the type you create it from. In your example, you'll be using a queue of characters, so your queue definition in `medic_example` will be `queue(agent)`.

      ```verse
       list(t:type) := class:
           Data:t
           Next:?list(t)

       queue<public>(t:type) := class<internal>:
           Elements<internal>:?list(t) = false
           Size<public>:int = 0

           Enqueue<public>(NewElement:t):queue(t) =
               queue(t):
                   Elements := option:
                       list(t):
                           Data := NewElement
                           Next := Elements
                   Size := Size + 1

           Dequeue<public>()<decides><transacts>:tuple(queue(t), t) =
               List := Elements?
               (queue(t){Elements := List.Next, Size := Size - 1}, List.Data)

           Front<public>()<decides><transacts>:t = Elements?.Data

       CreateQueue<public><constructor>(InData:t where t:type) := queue(t):
           Elements := option:
               list(t):
                   Data := InData
                   Next := false
           Size := 1
      ```
   6. Organizing your Verse scripts into distinct folders can help with organization, as well as provide ways to easily reference commonly used files. As an example of this, you'll create a folder to store your NPC behaviors in this project. In Visual Studio Code, hit the **New Folder** button to create a new folder in your UEFN Project. Name the folder `npc_behaviors`. Then drag your `medic_example` Verse file into the new folder.

Your code in `medic_example` should now compile correctly.

## Healing Characters Inside a Volume

When an injured character enters the `HealVolume`, your medic character should begin healing them if their health is less than the `HealingThreshold`. Once the character's health is above the `HealingThreshold`, your medic should stop healing that character, and move to the next character that needs healing. In the case of multiple characters, your medic should heal characters in the order they entered the `HealVolume`. Follow these steps to heal characters when they enter the `HealVolume`.

1. Back in your `medic_example` file, in `OnBegin()` after the `then` statement, start a `loop`. Inside the `loop`, get the result of the `Dequeue()` function from the `AgentsToHeal` queue and save it in a variable `DequeueResult`.

   ```verse
        then:
            loop:
                # Get the next agent in the queue to heal. If there is an agent to heal, heal them by calling AgentToHeal.
                # If there are no agents to heal, wait until an agent enters the HealVolume
                if:
                    DequeueResult := AgentsToHeal.Dequeue[]
   ```
2. The `DequeueResult` variable is a `tuple` that returns both a copy of the `AgentsToHeal` queue with the first element removed and the agent at the front of the queue. Update `AgentsToHeal` by setting it to the first value in the tuple, and save the second value as the `AgentToHeal`.

   ```verse
        if:
            DequeueResult := AgentsToHeal.Dequeue[]
            set AgentsToHeal = DequeueResult(0)
            AgentToHeal := DequeueResult(1)
   ```
3. Once you have the agent to heal, you need to start healing them while they're in the `HealVolume`. You'll define a new function named `HealCharacter()` to handle this. Add a new function named `HealCharacter()` to the `medic_example` class definition. This function takes the `AgentToHeal` both the `Navigatable` and `Focusable` interfaces of the medic characters as function arguments. Add the `<suspends>` modifier to this function, since it needs to perform several asynchronous tasks when healing a character.

   ```verse
        # Heal the character, then wait a HealingDelayAmount of time.
        # Ends when the character's health reaches the HealingThreshold
        # or the character leaves the HealVolume.
        HealCharacter(AgentToHeal:agent, Navigatable:navigatable, Focusable:focus_interface)<suspends>:void=
   ```
4. In `HealCharacter`, check if the `AgentToHeal` is in the volume by calling `IsInVolume[]`, and passing `AgentToHeal` as an argument. If the agent is in the volume, you can begin healing them. All healable agents implement the `healthful` interface, which is part of the agent's `fort_character`. Get the agent's `fort_character` and save it in a value `CharacterToHeal`.

   ```verse
        HealCharacter(AgentToHeal:agent, Navigatable:navigatable, Focusable:focus_interface)<suspends>:void=
            # Only heal the character if they are inside the HealVolume
            if:
                HealVolume.IsInVolume[AgentToHeal]
                CharacterToHeal := AgentToHeal.GetFortCharacter[]
   ```
5. With the character ready to heal, you need to make sure your medic stays close to the character being healed. Create a `navigation_target` from `AgentToHeal` using `MakeNavigationTarget` and save it in a variable `NavigationTarget`. Then in a `branch` statement, call the `NavigateTo()` function using the NPC's `navigatable` interface to have your medic navigate to the `AgentToHeal`. Also in the `branch` function, call the `MaintainFocus()` function to make sure your medic focuses on the `AgentToHeal`. Using a `branch` statement in this context lets you run both `NavigateTo()` and `MaintainFocus()` asynchronously at the same time, and lets you run any code after your `branch` immediately. For more information on branch expressions, see the [branch in Verse page](https://dev.epicgames.com/documentation/en-us/fortnite/branch-in-verse).

   ```verse
        # Only heal the character if they are inside the HealVolume
        if:
            HealVolume.IsInVolume[AgentToHeal]
            CharacterToHeal := AgentToHeal.GetFortCharacter[]
        then:      
            Print("Character is in volume, starting healing")
            NavigationTarget := MakeNavigationTarget(AgentToHeal)
            branch:
                Navigatable.NavigateTo(NavigationTarget)
                Focusable.MaintainFocus(AgentToHeal)
   ```
6. Enable the `VFXSpawner` to play VFX as your medic heals a character. Then in a `defer` expression, disable the `VFXSpawner`. Because the code for disabling the `VFXSpawner` is in a `defer` expression, it won't run until the current scope exits. In this situation, it means that the code will only run when the function ends, so it is guaranteed to be the last thing that happens in the function. For more information on defer expressions, see the [defer page](https://dev.epicgames.com/documentation/en-us/fortnite/defer-in-verse).

   ```verse
        branch:
            Navigatable.NavigateTo(NavigationTarget)
            Focusable.MaintainFocus(AgentToHeal)
   		    
        VFXSpawner.Enable()
   		    
        defer:
            VFXSpawner.Disable()
   ```
7. When healing the `CharacterToHeal`, healing should stop when one of two conditions happens. Either the character's health is healed past the `HealingThreshold`, or the character exits the `HealVolume`. To accomplish this, you'll use a `race` expression. Set up a `race` expression between a `loop` and an `Await()` on the `HealVolume.AgentExitsEvent.`

   ```verse
        branch:
            Navigatable.NavigateTo(NavigationTarget)
            Focusable.MaintainFocus(AgentToHeal)
        VFXSpawner.Enable()
        defer:
            VFXSpawner.Disable()
        race:
            loop:
            HealVolume.AgentExitsEvent.Await()
   ```
8. Inside the `loop`, get the current health of the character using `GetHealth()` and save it in a value `CurrentHealth`. Then in an `if` statement, check if the `CurrentHealth` plus the `HealingAmount` is greater than the `HealingThreshold`. If so, your medic should stop healing and `break` out of the loop. However, if the character's current health is just a little less than the healing threshold, you want to heal them up to the healing threshold. Add a second `if` statement inside the first one that checks if `CurrentHealth` is less than the `HealingThreshold`. If so, set the character's health to the `HealingThreshold`.

   ```verse
        race:
            loop:
                CurrentHealth := CharacterToHeal.GetHealth()
                if(CurrentHealth + HealingAmount > HealingThreshold):
                    if (CurrentHealth < HealingThreshold):
                        CharacterToHeal.SetHealth(HealingThreshold)
                    PrintNPCB("Character has reached HealingThreshold, stopping healing")
                    break
            HealVolume.AgentExitsEvent.Await()
   ```
9. Otherwise if the `CurrentHealth` plus the `HealingAmount` is not greater than the `HealingThreshold`, set the character's health to the `Current Health` plus the `HealingAmount`.

   ```verse
        if(CurrentHealth + HealingAmount > HealingThreshold):
            if (CurrentHealth < HealingThreshold):
                CharacterToHeal.SetHealth(HealingThreshold)
            PrintNPCB("Character has reached HealingThreshold, stopping healing")
            break
        else:
            CharacterToHeal.SetHealth(CurrentHealth + HealingAmount)
   ```
10. At the end of the `loop`, sleep for a `HealingDelay` amount of time. Without this sleep, characters will be healed every simulation update, so the `HealingDelay` will prevent them from being healed instantly. Your completed `HealCharacter()` code should look like the following.

    ```verse
         # Heal the character, then wait a HealingDelayAmount of time.
         # Ends when the character's health reaches the HealingThreshold
         # or the character leaves the HealVolume.
         HealCharacter(AgentToHeal:agent, Navigatable:navigatable, Focusable:focus_interface)<suspends>:void=
             # Only heal the character if they are inside the HealVolume
             if:
                 HealVolume.IsInVolume[AgentToHeal]
                 CharacterToHeal := AgentToHeal.GetFortCharacter[]
             then:
                 Print("Character is in volume, starting healing")
                 NavigationTarget := MakeNavigationTarget(AgentToHeal)
                 branch:
                     Navigatable.NavigateTo(NavigationTarget)
                     Focusable.MaintainFocus(AgentToHeal)
                 VFXSpawner.Enable()
                 defer:
                     VFXSpawner.Disable()
                 race:
                     loop:
                         CurrentHealth := CharacterToHeal.GetHealth()
                         if(CurrentHealth + HealingAmount > HealingThreshold):
                             if (CurrentHealth < HealingThreshold):
                                 CharacterToHeal.SetHealth(HealingThreshold)
                             PrintNPCB("Character has reached HealingThreshold, stopping healing")
                             break
                         else:
                             CharacterToHeal.SetHealth(CurrentHealth + HealingAmount)
                         Sleep(HealingDelay)
                         HealVolume.AgentExitsEvent.Await()
    ```
11. Back in `OnBegin()`, in the `then` expression inside of your `loop`, call `HealCharacter()` by passing the `AgentToHeal`, the `Navigable` interface, and the `Focusable` interface.

    ```verse
         if:
             DequeueResult := AgentsToHeal.Dequeue[]
             set AgentsToHeal = DequeueResult(0)
             AgentToHeal := DequeueResult(1)
         then:
             Print("Dequeued the next agent to heal")
             HealCharacter(AgentToHeal, Navigatable, Focusable)
    ```
12. Your medic will not always have a character to heal near them, and the `Dequeue[]` function will fail if there are no agents in the `AgentsToHeal` queue. To handle this, add an `else` statement to the end of the `loop`. Inside this `if` statement, call `Sleep()` for a `HealingDelay` amount of time, then `Await()` the `HealVolume.AgentEntersEvent`. This way your medic character will not endlessly call `Dequeue[]` on the `AgentsToHeal` queue, and will instead wait for a new character to enter the `HealVolume before restarting the loop. Your completed loop should look like the following.

    ```verse
         loop:
             # Get the next agent in the queue to heal. If there is an agent to heal, heal them by calling AgentToHeal.
             # If there are no agents to heal, wait until an agent enters the HealVolume
             if:
                 DequeueResult := AgentsToHeal.Dequeue[]
                 set AgentsToHeal = DequeueResult(0)
                 AgentToHeal := DequeueResult(1)
             then:
                 Print("Dequeued the next agent to heal")
                 HealCharacter(AgentToHeal, Navigatable, Focusable)
             else:
                 Print("AgentsToHeal is empty!")
                 Sleep(HealingDelay)
                 HealVolume.AgentEntersEvent.Await()
    ```

## Tracking when Characters are in the Heal Volume

To know when characters enter or exit the `HealVolume`, you'll subscribe both the `HealVolume`'s `AgentEntersEvent` and `AgentExitsEvent` to new functions.

1. Add a new function named `OnAgentEnters()` to the `medic_example` class definition. This function takes the agent who just entered the `HealVolume`, and enqueues them in the `AgentsToHeal` queue.

   ```verse
        OnAgentEnters(EnteredAgent:agent):void=
                Print("Agent entered the heal volume")
   ```
2. In `OnAgentEnters()`, check that the agent in the volume is not the medic character. If so, set the `AgentsToHeal` queue to the result of calling `Enqueue[]` with the `EnteredAgent`. Your completed `OnAgentEnters()` function should look like the following:

   ```verse
       OnAgentEnters(EnteredAgent:agent):void=
           Print("Agent entered the heal volume")
           if (EnteredAgent <> GetAgent[]):
               set AgentsToHeal = AgentsToHeal.Enqueue(EnteredAgent)
   ```
3. When an agent exits the `HealVolume`, you don't need to remove them from the `AgentsToHeal` queue. This is because the loop in `OnBegin()` already calls `Dequeue[]` in a loop. However, you may want to run code when an agent exits the volume in your examples, so you'll set up a function for this now. Add a new function named `OnAgentExits()` to the `medic_example` class definition.

   ```verse
        OnAgentExits(ExitAgent:agent):void=
            Print("Agent exited the heal volume")
   ```
4. In `OnBegin()`, subscribe the `HealVolume`'s `AgentEntersEvent` and `AgentExitsEvent` to `OnAgentEnters` and `OnAgentExits` respectively. Since it should start disabled, this is a good place to call `Disable()` on the character spawner.

   ```verse
        OnBegin<override>()<suspends>:void=
            Print("Hello, AI!")
            VFXSpawner.Disable()
            HealVolume.AgentEntersEvent.Subscribe(OnAgentEnters)
            HealVolume.AgentExitsEvent.Subscribe(OnAgentExits)
   ```

## Moving the Heal Volume with the Medic

When the medic character moves, the `HealVolume` needs to move with them to match their current position. The same is true for the `VFXSpawner`. To do this you'll use a new function `DeviceFollowCharacter()`.

1. Add a new function named `DeviceFollowCharacter()` to the `medic_example` class definition. This function needs to run asynchronously to continuously update the device positions, so add the `<suspends>` modifier to it.

   ```verse
        DeviceFollowCharacter()<suspends>:void=
   ```
2. Inside the `DeviceFollowCharacter()` function, get the `fort_character` of the medic by first getting the agent using `GetAgent[]`, then calling `GetFortCharater[]`.

   ```verse
        DeviceFollowCharacter()<suspends>:void=
            if:
                # Get the agent (AI Character) this behavior is associated with.
                Agent := GetAgent[]
                # Get the fort_character interface of the agent to access Fortnite character-specific behaviors, events, functions, and interfaces.
                Character := Agent.GetFortCharacter[]
   ```
3. Now you need to continuously move the `HealVolume` and `VFXSpawner` to the `Character`'s position. You'll do this by looping a `MoveTo()` on both devices. Start a `loop` and get the `Character`'s transform and save it in a variable `CharacterTransform`.

   ```verse
        if:
            # Get the agent (AI Character) this behavior is associated with.
            Agent := GetAgent[]
            # Get the fort_character interface of the agent to access Fortnite character-specific behaviors, events, functions, and interfaces.
            Character := Agent.GetFortCharacter[]
        then:
            loop:
                CharacterTransform := Character.GetTransform()
   ```
4. Call `MoveTo()` on both the `VFXSpawner` and the `HealVolume`, moving them to the `CharacterTransform.Translation` and `CharacterTransform.Rotation`. Set the duration to `UpdateRateSeconds` seconds. Finally, call `Sleep()` for an `UpdateRateSeconds` amount of time to prevent the devices from updating their position every simulation update. Updating the device position every simulation update can cause jittery movement on your devices. Your completed `DeviceFollowCharacter()` code should look like the following.

   ```verse
        DeviceFollowCharacter()<suspends>:void=
            if:
                # Get the agent (AI Character) this behavior is associated with.
                Agent := GetAgent[]
                # Get the fort_character interface of the agent to access Fortnite character-specific behaviors, events, functions, and interfaces.
                Character := Agent.GetFortCharacter[]
                then:
                    loop:
                        CharacterTransform := Character.GetTransform()
                        VFXSpawner.MoveTo(CharacterTransform.Translation, CharacterTransform.Rotation, UpdateRateSeconds)
                        HealVolume.MoveTo(CharacterTransform.Translation, CharacterTransform.Rotation, UpdateRateSeconds)
                        Sleep(UpdateRateSeconds)
   ```
5. In `OnBegin()`, after the `if` statement where you save your character interfaces but before the loop, spawn an instance of `DeviceFollowCharacter()`.

## Adding your Character to the Level

1. Create a new NPC Character Definition named **Medic**. Click your new NPC character definition to open the **NPC Character Definition** screen.
2. In the **NPC Character Definition** screen, modify the following properties:

   1. Under **NPC Character Type**, set **Type** to **Guard**. The guard interface lets you access guard-specific character functionality, such as events for when the guard is alerted or suspicious, and lets you hire guards to use as allies. Guards may also equip weapons, while Custom and Wildlife-type characters currently cannot. You can also change the name of your character under the **Name** tab.
   2. Under **NPC Character Behavior**, set **Behavior** to **Verse Behavior**. Then set the **NPC Behavior Script** to `medic_example`. Your character will still have access to functionality from the guard interface, but will use your Verse script to decide what to do during `OnBegin` and `OnEnd`.
   3. In the **Modifiers** tab, under **Guard Spawn Modifier**, click the **Cosmetic** tab to change your character's cosmetic appearance. You can choose from a preexisting cosmetic, or enable **Character Cosmetic Retargeting** to use a custom model. Note that only guards and Custom-type characters can use character cosmetic retargeting, while wildlife cannot. For more information on character modifiers and which ones apply to different character types, see the [Character Definition](https://dev.epicgames.com/documentation/en-us/fortnite/using-npc-character-definitions-in-unreal-editor-for-fortnite) page.
3. Save your NPC character definition. In the **Content Browser**, drag your NPC character definition into the level. This will automatically create a new character spawner and assign your NPC character definition to it.

1. Drag one mutator zone and one VFX spawner device into the level.
2. Select your character spawner. In the **Outliner**, under **User Options**:

   1. Set **AIBehavior Script override** to your `medic_example` script. Overriding the `AIBehavior Script in the outliner allows you to reference devices in the level, and you'll need this functionality to assign your **HealVolume** and **VFXSpawner**.
   2. Set **HealVolume** to the mutator zone, and **VFXSpawner** to the VFX spawner you placed in the level.

[![Character Spawner Settings](https://dev.epicgames.com/community/api/documentation/image/befb0782-e2eb-49ba-8f49-60566aa14b02?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/befb0782-e2eb-49ba-8f49-60566aa14b02?resizing_type=fit)

1. Select your mutator zone. In the **Outliner**, under **User Options**, set **Zone Visible During Game** to **True**. This will help you visualize where the `HealVolume` is, and how it moves with the medic character.
2. Select your VFX Spawner. In the **Outliner**, under **User Options**, set **Visual Effect** to an effect of your choice. This example uses the **Bubbles** effect to convey healing, but you might want to use something different, such as fireworks or sparks. Change the visual effect to suit the needs of your character.
3. Click **Launch Session** in the UEFN toolbar to playtest your level. When you playtest, your character should heal injured characters who enter the mutator zone. When healing a character, VFX should play and the medic should follow and focus on the character being healed.

## Complete Script

The following is a complete script for an NPC Character that heals characters whose HP is under a certain threshold.

### medic\_example.verse

```verse
using { /Fortnite.com/AI }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Devices }
using { /Verse.org/Colors }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# A Verse-authored NPC Behavior that can be used within an NPC Definition or a Character Spawner device's Behavior Script Override.
medic_example<public> := class(npc_behavior):
    # The HP threshold a character must be at before healing them.
    @editable
    HealingThreshold:float = 50.0

    # How long to wait before healing characters
    @editable
    HealingDelay:float = 1.5

    # How much to heal characters per healing instance
    @editable
    HealingAmount:float = 5.0

    # The volume characters enter to receive healing.
    @editable
    HealVolume:mutator_zone_device = mutator_zone_device{}

    # The VFX spawner to play VFX as characters are being healed.
    @editable
    VFXSpawner:vfx_spawner_device = vfx_spawner_device {}

    # The agent to follow while they're being healed
    var AgentToFollow:?agent = false

    # The queue of agents to heal in the case of multiple agents entering the heal volume.
    var AgentsToHeal<public>:queue(agent) = queue(agent){}

    # Used to specify how quickly to update the position of the HealVolume and VFXSpawner
    UpdateRateSeconds<private>:float = 0.1

    OnBegin<override>()<suspends>:void=
        VFXSpawner.Disable()
        HealVolume.AgentEntersEvent.Subscribe(OnAgentEnters)
        HealVolume.AgentExitsEvent.Subscribe(OnAgentExits)

        if:

            # Get the agent (AI Character) this behavior is associated with.
            Agent := GetAgent[]

            # Get the fort_character interface of the agent to access Fortnite character-specific behaviors, events, functions, and interfaces.
            Character := Agent.GetFortCharacter[]

            # Get the navigatable interface of the character to set specific targets for the character to travel to.
            Navigatable := Character.GetNavigatable[]

            # Get the focus_interface of the character to set specific targets to focus on after traveling to them.
            Focusable := Character.GetFocusInterface[]

        then:
            # Set the HealVolume and VFXSpawner to continuously follow the NPC Character
            spawn{DeviceFollowCharacter()}
            loop:
                # Get the next agent in the queue to heal. If there is an agent to heal, heal them by calling AgentToHeal.
                # If there are no agents to heal, wait until an agent enters the HealVolume
                if:
                    DequeueResult := AgentsToHeal.Dequeue[]
                    set AgentsToHeal = DequeueResult(0)
                    AgentToHeal := DequeueResult(1)
                then:
                    PrintNPCB("Dequeued the next agent to heal")
                    HealCharacter(AgentToHeal, Navigatable, Focusable)
                else:
                    PrintNPCB("AgentsToHeal is empty!")
                    Sleep(HealingDelay)
                    HealVolume.AgentEntersEvent.Await()
        else:
            # If code falls here something failed when gathering the agent and its interfaces
            PrintNPCB( "Error in NPC Behavior Script on NPC Setup",
                ?Duration := 6.0,
                ?TextColor := NamedColors.Red )

    # Heal the character, then wait a HealingDelayAmount of time.
    # Ends when the character's health reaches the HealingThreshold
    # or the character leaves the HealVolume.
    HealCharacter(AgentToHeal:agent, Navigatable:navigatable, Focusable:focus_interface)<suspends>:void=

        # Only heal the character if they are inside the HealVolume
        if:
            HealVolume.IsInVolume[AgentToHeal]
            CharacterToHeal := AgentToHeal.GetFortCharacter[]
        then:
            PrintNPCB("Character is in volume, starting healing")
            NavigationTarget := MakeNavigationTarget(AgentToHeal)
            branch:
                Navigatable.NavigateTo(NavigationTarget)
                Focusable.MaintainFocus(AgentToHeal)
            VFXSpawner.Enable()
            defer:
                VFXSpawner.Disable()
            race:
                loop:
                    CurrentHealth := CharacterToHeal.GetHealth()
                    if(CurrentHealth + HealingAmount > HealingThreshold):
                        if (CurrentHealth < HealingThreshold):
                            CharacterToHeal.SetHealth(HealingThreshold)
                        PrintNPCB("Character has reached HealingThreshold, stopping healing")
                        break
                    else:
                        CharacterToHeal.SetHealth(CurrentHealth + HealingAmount)
                    Sleep(HealingDelay)
                HealVolume.AgentExitsEvent.Await()

    # Sets the HealVolume and VFXSpawner to continuously follow the character by looping
    # MoveTo onto the character's position.
    DeviceFollowCharacter()<suspends>:void=
        if:
            # Get the agent (AI Character) this behavior is associated with.
            Agent := GetAgent[]

            # Get the fort_character interface of the agent to access Fortnite character-specific behaviors, events, functions, and interfaces.
            Character := Agent.GetFortCharacter[]
        then:
            # Loop MoveTo on the HealVolume and VFXSpawner to match their position to the
            # NPC Character
            loop:
                CharacterTransform := Character.GetTransform()
                VFXSpawner.MoveTo(CharacterTransform.Translation, CharacterTransform.Rotation, UpdateRateSeconds)
                HealVolume.MoveTo(CharacterTransform.Translation, CharacterTransform.Rotation, UpdateRateSeconds)
                Sleep(UpdateRateSeconds)

    # When an agent enters the HealVolume, add them to the
    # AgentsToHeal queue if they are not the NPC Character.
    OnAgentEnters(EnteredAgent:agent):void=
        PrintNPCB("Agent entered the heal volume")
        if (EnteredAgent <> GetAgent[]):
            set AgentsToHeal = AgentsToHeal.Enqueue(EnteredAgent)

    # When an agent exits the HealVolume, PrintNPCB to the log
    OnAgentExits(ExitAgent:agent):void=
        PrintNPCB("Agent exited the heal volume")

    # Custom wrapper that provides a default duration and color.
    PrintNPCB(Msg:string,?Duration:float = 3.0, ?TextColor:color = NamedColors.Green):void =
        Print("[new_npc_behavior] {Msg}", ?Color := TextColor, ?Duration := Duration)

    # This function runs when the NPC is despawned or eliminated from the world.
    OnEnd<override>():void =
        if(Agent := GetAgent[]):
            Print(medic_example_message_module.OnEndMessage(Agent))
        else:
            PrintNPCB("OnEnd")
```

### queue.verse

```verse
list(t:type) := class:
    Data:t
    Next:?list(t)

queue<public>(t:type) := class<internal>:
    Elements<internal>:?list(t) = false
    Size<public>:int = 0

    Enqueue<public>(NewElement:t):queue(t) =
        queue(t):
            Elements := option:
                list(t):
                    Data := NewElement
                    Next := Elements
            Size := Size + 1

    Dequeue<public>()<decides><transacts>:tuple(queue(t), t) =
        List := Elements?
        (queue(t){Elements := List.Next, Size := Size - 1}, List.Data)

    Front<public>()<decides><transacts>:t = Elements?.Data

CreateQueue<public><constructor>(InData:t where t:type) := queue(t):
    Elements := option:
        list(t):
            Data := InData
            Next := false
    Size := 1
```

## On Your Own

By completing this guide, you've learned how to create a medic character that automatically heals characters under a certain threshold. Using what you've learned, try to create your own medic character with their own special behaviors.

- Can you create a medic who swaps between damaging and healing volumes based on whether an enemy is in the volume?
- How about a medic who uses a depletable resource to heal characters? How would the medic restore this resource? Could they restore it over time, or could they restore it by attacking enemies?
