# Lesson 3: Practice Time!

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-3-practice-time-in-verse
> **爬取时间**: 2025-12-26T23:08:58.748754

---

Let’s say you’re making a game with magic potions. Potions have different effects — they can heal players or hurt them. You would want to declare and initialize some constants and variables to store player health, and the amount of damage or healing caused by a potion.

But which should be constants, and which should be variables?

```verse
var PlayerHealth: float = 100.0
PotionDamageAmount: float = 20.0
PotionHealAmount: float = 10.0
```

The variables and constants you're changing here won’t affect your Fortnite character's health, but you will learn how to do exactly that in a later lesson!

The player’s health will change during the game depending on what potions they use. When you think **change**, think **variable**.

On the other hand, it doesn’t make much sense to change the amount of damage or healing the potions do during the game, so those should be declared as **constants**.

1. If you write code to change the `PlayerHealth` variable now, you won’t be able to tell if it worked unless you print something to the log. To help with that, declare and initialize the string constant and string variable below. Remember to add the space between the end of the text and the last `"`.

   ```verse
        PlayerStatusText: string = "Player health now "
        var EffectOnPlayerText: string = "damaged "
   ```
2. Now you’re ready to change the player’s health. To change a variable’s value, you have to use the `set` keyword at the beginning of the expression. The `PotionDamageAmount` should be subtracted from `PlayerHealth`, so use the `-` operator.

   ```verse
        set PlayerHealth = PlayerHealth - PotionDamageAmount
   ```
3. After `PlayerHealth` changes, you want to see the proof! To do that, make the calls to `Print()` shown below.

   ```verse
        Print("The Player was {EffectOnPlayerText + ToString(PotionDamageAmount)}")
        Print("{PlayerStatusText + ToString(PlayerHealth)}")
   ```

   It may seem like you are trying to do math with your strings but you are actually **combining** with the `+` operator. This is called **concatenation**. The `ToString()` function creates a `string` version of your `float` variable and constant so they can be used by `Print()`.
4. Run this code now and you should see two new lines printed:

   - `The Player was damaged 20.0`
   - `Player health now 80.00`

Now on your own, try to do the same thing for `PotionHealAmount`.

1. Change `PlayerHealth` using the correct **keyword** and **operator**.
2. You’ll also need to change the `EffectOnPlayerText` variable so that it makes sense when printed.
3. Finally, you’ll need to print out how the player’s health was affected, and their current health. Try this by yourself first, but if you need help, look at the code below.

   ```verse
        set PlayerHealth = PlayerHealth + PotionHealAmount
        set EffectOnPlayerText = "healed "
        Print("The Player was {EffectOnPlayerText + ToString(PotionHealAmount)}")
        Print("{PlayerStatusText + ToString(PlayerHealth)}")
   ```

## Complete Script

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

hello_world_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =

        PotionDamageAmount : float = 20.0
        PotionHealAmount : float = 10.0
        var  PlayerHealth : float = 100.0

        PlayerStatusText : string = "Player health now "
        var EffectOnPlayerText: string = "damaged "

        set PlayerHealth = PlayerHealth - PotionDamageAmount
        Print("The Player was {EffectOnPlayerText + ToString(PotionDamageAmount)}")
        Print("{PlayerStatusText + ToString(PlayerHealth)}")

        set PlayerHealth = PlayerHealth + PotionHealAmount
        set EffectOnPlayerText = "healed "
        Print("The Player was {EffectOnPlayerText + ToString(PotionHealAmount)}")
        Print("{PlayerStatusText + ToString(PlayerHealth)}")
```

## Next Lesson

[![Lesson 4: Writing Simple Code](https://dev.epicgames.com/community/api/documentation/image/155dc33b-175b-4710-a8a5-419b70ee11e7?resizing_type=fit&width=640&height=640)

Lesson 4: Writing Simple Code

Practice is the key to competence. Practice writing more code!](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-4-writing-simple-code-in-verse)
