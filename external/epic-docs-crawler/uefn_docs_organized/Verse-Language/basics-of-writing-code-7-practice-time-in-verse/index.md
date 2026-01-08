# Lesson 7: Practice Time

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-7-practice-time-in-verse>
> **爬取时间**: 2025-12-26T23:10:32.642402

---

Your `HurtPlayer()` function is working, but since you’re passing a literal value to the `Damage()` method, that value can only change when you manually change the code. In this exercise, you’re going to make your `HurtPlayer()` function more flexible with the return value from another function that you will create.

In [Lesson 4: Practice Time](https://dev.epicgames.com/documentation/en-us/uefn/basics-of-writing-code-4-practice-time-in-verse), you used conditionals to calculate how much damage or healing should be done by potions, depending on the player’s health. You're going to bring some of that code back in a function called `CalculateDamage()`. It will return a value of type `float`. You will store that value in a constant that you will then pass to the `Damage()` method.

1. Create a function named `CalculateDamage()`. Within the function, declare two constants of type `float`: `MinHealth`, and `PotionDamageAmount`. Declare one variable of type `float` called `PlayerHealth`.

   ```verse
        CalculateDamage() : float = 
               MinHealth : float = 1.0
               PotionDamageAmount: float = 80.0
               var PlayerHealth : float = 100.0
   ```

2. Create an `if` … `else if` … `else` expression that returns one of three values:

   - `PotionDamageAmount`, if `PlayerHealth` is greater than `PotionDamageAmount`
   - `PlayerHealth` - `MinHealth`, if `PlayerHealth` is less than `PotionDamageAmount` but greater than `MinHealth`
   - `PlayerHealth`, if `PlayerHealth` is less than or equal to `MinHealth`

     ```verse
                               # If the damage amount would not eliminate the player, do that amount of damage
                                  if (PlayerHealth &gt; PotionDamageAmount):
                                      return PotionDamageAmount
                                  else if (PlayerHealth &gt; MinHealth):
                                      # Give player one more chance if their health is low
                                      return PlayerHealth - MinHealth
                                  else:
                                      # Eliminate player
                                      return PlayerHealth
     ```

   The effect of this code is that it will give the player a second chance if they drink a potion that would normally eliminate them.
3. Now that you have made a function that returns a useful result, you need to store that result. Declare a constant `float` called `DamageToDo`, and initialize it with the return value of `CalculateDamage()`. Add this to your `HurtPlayer()` function.

   ```verse
        HurtPlayer() : void =
            Playspace : fort_playspace = GetPlayspace()
            AllPlayers : []player = Playspace.GetPlayers()
            if (FirstPlayer : player = AllPlayers[0]):
                if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                    DamageToDo: float = CalculateDamage()
                    FortniteCharacter.Damage(50.0)
   ```

4. Finally, time to use the result! Pass `DamageToDo` as an argument to `Damage()`. Add a `Print()` so you can see exactly what `CalculateDamage()` is returning.

   ```verse
        HurtPlayer() : void =
               Playspace : fort_playspace = GetPlayspace()
               AllPlayers : []player = Playspace.GetPlayers()
               if (FirstPlayer : player = AllPlayers[0]):
                   if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                       DamageToDo: float = CalculateDamage()
                       Print("DamageToDo: {DamageToDo}")
                       FortniteCharacter.Damage(DamageToDo)
   ```

Now instead of your call to the `Damage()` method using a literal value, it uses the value returned from `CalculateDamage()`. You should have already written the call to `HurtPlayer()` from a previous exercise, but don’t forget to check.

## Complete Script

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /Verse.org/Simulation }
using { /Verse.org/Verse }

hello_world_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=

        HurtPlayer()
        Print("Player Hurt")

    CalculateDamage() : float = 
        MaxHealth : float = 100.0
        MinHealth : float = 1.0
        PotionDamageAmount: float = 80.0
        var PlayerHealth : float = 100.0

        # If the damage amount would not eliminate the player, do that amount of damage
        if (PlayerHealth > PotionDamageAmount):
            return PotionDamageAmount
        else if (PlayerHealth > MinHealth):
            # Give player one more chance if their health is low
            return PlayerHealth - MinHealth
        else:
            # Eliminate player
            return PlayerHealth

    HurtPlayer() : void =
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                DamageToDo: float = CalculateDamage()
                Print("DamageToDo: {DamageToDo}")
                FortniteCharacter.Damage(DamageToDo)
```

On your own, try to create a function similar to `CalculateDamage()` that returns a result that would be useful for `HealPlayer()`. If you get stuck, check the [Lesson 4 Practice Time](learn-code-basics-4-practice-time-in-verse) for some ideas.

## Next Lesson

[![Lesson 8: How Input, Parameters, and Arguments Work](https://dev.epicgames.com/community/api/documentation/image/53a7f95c-a5bd-4eb1-b7be-94b89836ef54?resizing_type=fit&width=640&height=640)

Lesson 8: How Input, Parameters, and Arguments Work

Learn how to define parameters in a function to get the result you need.](<https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-8-how-input-parameters-and-arguments-work-in-verse>)
