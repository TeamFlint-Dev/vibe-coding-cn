# Lesson 8: Practice Time

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-8-practice-time-in-verse>
> **爬取时间**: 2025-12-26T23:08:52.290940

---

In the [previous exercise](https://dev.epicgames.com/documentation/en-us/uefn/basics-of-writing-code-7-practice-time-in-verse), you created a good starting point for `CalculateDamage()`, but the function body contains constants and variables that would work better as parameters. As a reminder, here’s how the function looks now:

```verse
CalculateDamage() : float = 
    MinHealth : float = 1.0
    PotionDamageAmount : float = 80.0
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
```

Your updated version of the function will take three parameters:

- `PlayerHealth`: The player’s current health
- `DesiredDamageAmount`: The maximum amount of damage that could be done to the player
- `MinHealth`: The health the player should have if `DesiredDamageAmount` would reduce their health to `0.0` or less.

Update the function to match the following:

```verse
CalculateDamage(PlayerHealth : float, DesiredDamageAmount : float, MinHealth : float) : float = 
    # If the damage amount would not eliminate the player, do that amount of damage
    if (PlayerHealth > DesiredDamageAmount):
        return DesiredDamageAmount
    else if (PlayerHealth > MinHealth):
        # Give player one more chance if their health is low
        return PlayerHealth - MinHealth
    else:
        # Eliminate player
        return PlayerHealth
```

Great! Your function now calculates the damage your player should take when given three parameters, instead of using variables and constants declared within the function.

At this point, you may be seeing a **red squiggle** under the `()` in your call to `CalculateDamage()` in `HurtPlayer()`. This is because you have updated the declaration of `CalculateDamage()` to require 3 parameters, but you are not passing any arguments in your call to `CalculateDamage()`. You’ll fix that in the next few steps.

1. Before you can pass an argument for `PlayerHealth` to `CalculateDamage()`, you have to know what the character’s health is. For that you will use the `GetHealth()` method. You will call it the same way as `Damage()` and `Heal()` but it will return a value that you need to save within your `HurtPlayer()` function.

   ```verse
        HurtPlayer() : void =
               Playspace : fort_playspace = GetPlayspace()
               AllPlayers : []player = Playspace.GetPlayers()
               if (FirstPlayer : player = AllPlayers[0]):
                   if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                       MyCharacterHealth : float = FortniteCharacter.GetHealth()
                       DamageToDo: float = CalculateDamage()
                       Print("DamageToDo: {DamageToDo}")
                       FortniteCharacter.Damage(DamageToDo)
   ```

2. For the second parameter in `CalculateDamage()`, you’re going to need a parameter from `HurtPlayer()`. You will create that parameter now. Add a `float` parameter called `DamageAmount`. `HurtPlayer()` should now look like this:

   ```verse
        HurtPlayer(DamageAmount : float) : void =
            Playspace: fort_playspace = GetPlayspace()
            AllPlayers: []player = Playspace.GetPlayers()
            if (FirstPlayer : player = AllPlayers[0]):
                if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                    MyCharacterHealth : float = FortniteCharacter.GetHealth()
                    DamageToDo : float = CalculateDamage()
                    Print("DamageToDo: {DamageToDo}")
                    FortniteCharacter.Damage(DamageToDo)
   ```

3. You now have all three arguments ready to add to `CalculateDamage()`.

   - `MyCharacterHealth` for the parameter `PlayerHealth`
   - `DamageAmount` for the parameter `DesiredDamageAmount`
   - `1.0` for the parameter `MinHealth`

`HurtPlayer()` should look like the following, and you shouldn’t have any more errors:

```verse
HurtPlayer(DamageAmount : float) : void =
    Playspace: fort_playspace = GetPlayspace()
    AllPlayers: []player = Playspace.GetPlayers()
    if (FirstPlayer : player = AllPlayers[0]):
        if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
            MyCharacterHealth : float = FortniteCharacter.GetHealth()
            DamageToDo : float = CalculateDamage(MyCharacterHealth, DamageAmount, 1.0)
            Print("Damage To Do: {DamageToDo}")
            FortniteCharacter.Damage(DamageToDo)
```

Call `HurtPlayer()` a few times to see the different effects it has, depending on the player’s health.

What about the `HealPlayer()` function? Can you think of ways to update it now that you know how to use parameters?

There’s one more method that might be useful. It’s named `SetMaxHealth()`, and it’s called the same way as `Damage()`, `Heal()`, and `GetHealth()`. See if you can use `SetMaxHealth()` and everything else you know about parameters and functions to update the `HealPlayer()` function. Think about what might be interesting or fun for the player.

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

        HurtPlayer(80.0)
        Print("Player Hurt")

    CalculateDamage(PlayerHealth : float, DesiredDamageAmount : float, MinHealth : float) : float = 
        # If the damage amount would not eliminate the player, do that amount of damage
        if (PlayerHealth > DesiredDamageAmount):
            return DesiredDamageAmount
        else if (PlayerHealth > MinHealth):
            # Give player one more chance if their health is low
            return PlayerHealth - MinHealth
        else:
            # Eliminate player
            return PlayerHealth

    HurtPlayer(DamageAmount : float) : void =
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                MyCharacterHealth : float = FortniteCharacter.GetHealth()
                DamageToDo : float = CalculateDamage(MyCharacterHealth, DamageAmount, 1.0)
                FortniteCharacter.Damage(DamageToDo)
                Print("{DamageToDo} damage dealt to player")

    HealPlayer(HealAmount : float) : void =
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                FortniteCharacter.Heal(HealAmount)
```

## Next Lesson

[![Lesson 9: Failure and Control Flow](https://dev.epicgames.com/community/api/documentation/image/b9bb8d1e-d308-4314-b86b-1dad8cf5da68?resizing_type=fit&width=640&height=640)

Lesson 9: Failure and Control Flow

Learn how failure is used to control your program's flow.](<https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-9-failure-and-control-flow-in-verse>)
