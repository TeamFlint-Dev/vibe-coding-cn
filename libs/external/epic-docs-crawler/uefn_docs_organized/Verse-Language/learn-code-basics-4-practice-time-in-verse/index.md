# Lesson 4: Practice Time!

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/learn-code-basics-4-practice-time-in-verse
> **爬取时间**: 2025-12-27T00:31:41.354174

---

Return to your magic potion code from the last exercise. You will want to run the healing code when the player drinks a healing potion, and the damage code when they drink a damaging potion.

### First You Write Some Code ...

1. Sounds like you'll have to answer a question about the type of potion, so you can create a new variable to keep track of that, a string called `PotionType`.

   ```verse
        var PotionType: string = "heal"
   ```
2. Now you can ask if the variable `PotionType` is equal to another string. When you ask if `PotionType` is equal to `"heal"`, the answer will be yes. The healing code would then run.

   ```verse
        if (PotionType = "heal"):
            set PlayerHealth = PlayerHealth + PotionHealAmount
   ```
3. Now write a similar if expression for the damage code.

   ```verse
        if (PotionType = "damage"):
            set PlayerHealth = PlayerHealth - PotionDamageAmount
   ```

   But wait! There’s a problem with the healing code!

   Nothing here stops a player from continuing to raise their health with potions. It’s a good idea to limit this, and now you can with `if`!
4. First, declare a new constant of type `float`. Call it `MaxHealth` and set it to `100.0`.

   ```verse
        MaxHealth: float = 100.0
   ```

   If the value of `PlayerHealth` would go over the value of `MaxHealth` when a player drinks the healing potion, you'll need to set `PlayerHealth` to `MaxHealth`.

   ```verse
    # Code to run if player drinks a healing potion
    # If the player's health would not exceed MaxHealth if they were healed,
    # heal them the full amount
    if (PotionType = "heal" and (PlayerHealth + PotionHealAmount) < MaxHealth):
        set PlayerHealth = PlayerHealth + PotionHealAmount
    else:
        set PlayerHealth = MaxHealth
   ```

   Notice that the code above has an `and` to ask if the `PotionType` is equal to `"heal"` and if the `PlayerHealth + PotionAmount` is less than `MaxHealth`. Both of these conditions need to succeed for the PlayerHealth to be increased by the PotionHealAmount.

   It may not be clear to someone reading this code that it’s meant to prevent PlayerHealth from exceeding MaxHealth. That’s where code comments come in. Note the three lines of comments above the actual code.
5. The damage code works, but it can be improved with the use of `if` … `else if` … `else`. If a player drinks a damage potion that would make PlayerHealth `0.0` or less, we want to set PlayerHealth to `1.0` instead. If PlayerHealth is already `1.0`, then we set it to `0.0`. This teaches the player the potion is harmful without being too punishing.

   ```verse
        # Code to run if player drinks a damaging potion
        # Don't eliminate the player if their health is above MinHealth but below PotionDamageAmount
        # If they are already equal to or below MinHealth, eliminate them
        if (PotionType = "damage" and PlayerHealth &gt; PotionDamageAmount):
            set PlayerHealth = PlayerHealth - PotionDamageAmount
        else if (PlayerHealth &gt; MinHealth):
            # Give player one more chance if their health is low
            set PlayerHealth = 1.0
        else:
            set PlayerHealth = 0.0
   ```

### ... Then You Find the Bug

Below you’ll find all of the code from this exercise, with some `Print()` function calls added for testing. Try running this code. Feel free to change the `Print()` calls to whatever you like. With the `PotionType` variable initialized to `“heal”`, you can expect that only the healing code will run.

But wait, there’s a bug!

Run the code below and see if you can find it.

```verse
MaxHealth: float = 100.0
MinHealth: float = 1.0
var PotionType: string = "heal"

# Code to run if player drinks a healing potion
# If the player's health would not exceed MaxHealth if they were healed,
# heal them the full amount
if (PotionType = "heal" and (PlayerHealth + PotionHealAmount) < MaxHealth):
    set PlayerHealth = PlayerHealth + PotionHealAmount
    Print ("Full heal")
else:
    # else, set PlayerHealth the MaxHealth
    set PlayerHealth = MaxHealth
    Print("PlayerHealth too high for full heal")

# Code to run if player drinks a damaging potion
# Don't eliminate the player if their health is above MinHealth but below PotionDamageAmount
# If they are already equal to or below MinHealth, eliminate them
if (PotionType = "damage" and PlayerHealth > PotionDamageAmount):
    set PlayerHealth = PlayerHealth - PotionDamageAmount
    Print("Full damage")
else if (PlayerHealth > MinHealth):
    # Give player one more chance if their health is low
    set PlayerHealth = 1.0
    Print("PlayerHealth set to 1.0")
else:
    # Eliminate player
    set PlayerHealth = 0.0
    Print("Player eliminated!")
```

If `PotionType` is set to heal, only the healing code should run. However, the `if` … `else if` … `if` expressions in the damage code are still being executed. This means that if `PlayerHealth` is greater than `MinHealth`, the `PlayerHealth` will get set to `1.0`. This is not what you want, but you can fix it by nesting the other checks within `if` expressions that only check `PotionType`.

```verse
# Code to run if player drinks a healing potion
# If the player's health would not exceed MaxHealth if they were healed,
# heal them the full amount
if (PotionType = "heal"):
    if ((PlayerHealth + PotionHealAmount) < MaxHealth):
        set PlayerHealth = PlayerHealth + PotionHealAmount
        Print ("Full heal")
    else:
        # set PlayerHealth the MaxHealth
        set PlayerHealth = MaxHealth
        Print("PlayerHealth too high for full heal")

# Code to run if player drinks a damaging potion
# Don't eliminate the player if their health is above MinHealth but below PotionDamageAmount
# If they are already equal to or below MinHealth, eliminate them
if (PotionType = "damage"):
    if ((PlayerHealth > PotionDamageAmount)):
        set PlayerHealth = PlayerHealth - PotionDamageAmount
        Print("Full damage")
    else if (PlayerHealth > MinHealth):
        # Give player one more chance if their health is low
        set PlayerHealth = 1.0
        Print("PlayerHealth set to 1.0")
    else:
        # Eliminate player
        set PlayerHealth = 0.0
        Print("Player eliminated!")
```

Now, only the block of code indented under one of the `if` expressions that check `PotionType` will run. Try this code with `PotionType` set to `"damage"` as well.

Whew! That’s a lot of code changes, but you did it!

Take a break, drink some po- er… water, and come back when you’re ready for the next lesson.

## Complete Script

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

hello_world_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =

        MaxHealth : float = 100.0
        MinHealth : float = 1.0
        var PotionType: string = "heal"

        set PlayerHealth = 80.0

        # Code to run if player drinks a healing potion
        # If the player's health would not exceed MaxHealth if they were healed,
        # heal them the full amount
        if (PotionType = "heal"):
            if ((PlayerHealth + PotionHealAmount) < MaxHealth):
                set PlayerHealth = PlayerHealth + PotionHealAmount
                Print ("Full heal")
            else:
                # else, set PlayerHealth the MaxHealth
                set PlayerHealth = MaxHealth
                Print("PlayerHealth too high for full heal")

        # Code to run if player drinks a damaging potion
        # Don't eliminate the player if their health is above MinHealth but below PotionDamageAmount
        # If they are already equal to or below MinHealth, eliminate them
        if (PotionType = "damage"):
            if ((PlayerHealth > PotionDamageAmount)):
                set PlayerHealth = PlayerHealth - PotionDamageAmount
                Print("Full damage")
            else if (PlayerHealth > MinHealth):
                # Give player one more chance if their health is low
                set PlayerHealth = 1.0
                Print("PlayerHealth set to 1.0")
            else:
                set PlayerHealth = 0.0
                Print("Player eliminated!")

        Print("PlayerHealth now {PlayerHealth}")
```

## Next Lesson

[![Lesson 5: Calling Functions](https://dev.epicgames.com/community/api/documentation/image/fb435323-fda5-405c-be3f-151636660ca9?resizing_type=fit&width=640&height=640)

Lesson 5: Calling Functions

Why do the same work twice if you don't have to?](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-5-calling-functions-in-verse)
