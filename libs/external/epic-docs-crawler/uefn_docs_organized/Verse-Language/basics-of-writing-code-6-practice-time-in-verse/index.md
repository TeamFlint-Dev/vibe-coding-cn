# Lesson 6: Practice Time!

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-6-practice-time-in-verse
> **爬取时间**: 2025-12-26T23:10:52.344663

---

Now that you know the structure of a function, it’s time to build your own — two of your own, in fact!

In the last exercise, you learned the lines of code needed to damage a player character in Fortnite. It would be better if you didn’t have to type those same lines every time you needed that code.

1. Declare a function named `HurtPlayer()`. It will have a return type of `void`, which means it won’t return a value. Put the function declaration at the very end of your Verse file. The body of the function is the same code from [Lesson 5: Practice Time](learn-code-basics-5-practice-time-in-verse), so check there if you need a refresher.

   ```verse
        HurtPlayer() : void =
            Playspace: fort_playspace = GetPlayspace()
            AllPlayers: []player = Playspace.GetPlayers()
            if (FirstPlayer : player = AllPlayers[0]):
                if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                    FortniteCharacter.Damage(50.0)
   ```

   You can't define a function within another function, so make sure all your functions are indented to the same level as `OnBegin()`.
2. You now have a function you can use any time you want to do damage to a character. But declaring a function does not run the code in the function body. To do that, you need to **call** the function. Be sure to call these functions within `OnBegin()`.

   ```verse
        HurtPlayer()
        Print("Player Hurt")
   ```
3. By now you may have guessed that there is also a method that heals a character. It's named `Heal()`, and you can call it exactly the same way that you call `Damage()`. Create your `HealPlayer()` function at the end of your Verse file using this code.

   ```verse
        HealPlayer() : void =
            Playspace: fort_playspace = GetPlayspace()
            AllPlayers: []player = Playspace.GetPlayers()
            if (FirstPlayer : player = AllPlayers[0]):
                if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                    FortniteCharacter.Heal(20.0)
   ```
4. Now add the `HealPlayer()` call to the function calls in the body of `OnBegin()`.

   ```verse
        HurtPlayer()
        Print("Player Hurt")
        Sleep(5.0)
        HealPlayer()
        Print("Player Healed")
   ```

You may notice that there's a new call to the `Sleep()` function. Basically, `Sleep()` makes the program wait before continuing to run the code that comes after. The wait time is determined by the parameter you pass to `Sleep()`, represented in seconds. (You’ll learn more about parameters in a later lesson.) Without `Sleep()` here, `HealPlayer()` would run immediately after `HurtPlayer()`, and you wouldn’t notice the effect of both function calls.

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
        Sleep(5.0)
        HealPlayer()
        Print("Player Healed")  

    HurtPlayer() : void =
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                FortniteCharacter.Damage(50.0)

    HealPlayer() : void =
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                FortniteCharacter.Heal(20.0)
```

## Next Lesson

[![Lesson 7: Specifying the Result of a Function](https://dev.epicgames.com/community/api/documentation/image/dba80a79-9b1b-406a-be74-adbf8596795e?resizing_type=fit&width=640&height=640)

Lesson 7: Specifying the Result of a Function

Sometimes you want a result; sometimes you don't.](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-7-specifying-the-result-of-a-function-in-verse)
