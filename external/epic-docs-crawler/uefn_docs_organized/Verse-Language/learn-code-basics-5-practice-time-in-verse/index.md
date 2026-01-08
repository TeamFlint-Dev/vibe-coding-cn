# Lesson 5: Practice Time

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/learn-code-basics-5-practice-time-in-verse>
> **爬取时间**: 2025-12-27T00:31:54.592874

---

Still got your Verse code open? Good!

For this exercise, you’re going to call functions that will actually damage your Fortnite character, as promised all the way back in [Lesson 3: Practice Time](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-3-practice-time-in-verse#complete-script)!

Before you start coding, you will need to add a [device](unreal-editor-for-fortnite-glossary#device) to your UEFN island. It's called the [Player Spawner](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-player-spawn-pad-devices-in-fortnite-creative) and it causes your player character to spawn at the location of the device instead of in the air, which is the default spawn location for Fortnite. In order for the code in this exercise to work, the Player Spawner is required.

To learn how to place the Player Spawner device, see Object Placement in [UEFN Controls for Creative Users](https://dev.epicgames.com/documentation/en-us/fortnite/guide-to-uefn-controls-for-creative-users-in-unreal-editor-for-fortnite). Feel free to place it anywhere on your island.

Some of the code you'll use in this exercise will be new to you, but you'll have a chance to review what each line is doing. Don’t worry if you don’t understand it all right now. This practice is just about calling functions.

Make sure you have all of the following lines at the very top of your Verse file. These tell the Verse compiler which parts of **built-in** Verse and Fortnite code you’ll be **using** in your Verse-authored device.

```verse
using { /Fortnite.com/Devices }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /Verse.org/Simulation }
using { /Verse.org/Verse }
```

Next, you'll write the lines of code that damage your Fortnite character. Let’s go through this line by line.

1. Call a function named `GetPlayspace()`. It returns a value of type `fort_playspace`, which you save to a constant named `Playspace`. You need this to get the players.
2. Call a method named `GetPlayers()` on the constant `Playspace`. The method returns an [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) of type `player`. An **array** is a container that can hold multiple variables of the same type in Verse. In this case, the `AllPlayers` array is holding all the players in your level.
3. You already learned that you can use `if` to ask yes or no questions in your code. In this example, you use `if` to ask if there is a variable at the first position of the `AllPlayers` array. The expression `AllPlayers[0]` will return the value of the variable at that position if it exists, and the constant `FirstPlayer` will get initialized to the return value.
4. A second `if` nested within the first asks if the `FirstPlayer` constant has a Fortnite character by calling its method `GetFortCharacter[]`. Notice the **square brackets** used to make the call. These are used to call a function that can fail. That’s why `if` is used to call this function. If `GetFortCharacter[]` succeeds in returning a value of type `fort_character`, the constant FortniteCharacter is initialized to that value.
5. Finally, now that you have a constant of type `fort_character` you can call its method `Damage()`. This method takes one parameter of the type `float`. That’s the amount of damage the character will receive. You’ll learn more about parameters in the next lesson.

   ```verse
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                FortniteCharacter.Damage(50.0)
   ```

If you run this code, you should see your Fortnite character take `50.0` damage when your game starts!

Pretty cool, right?

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
 
        Playspace: fort_playspace = GetPlayspace()
        AllPlayers: []player = Playspace.GetPlayers()
        if (FirstPlayer : player = AllPlayers[0]):
            if (FortniteCharacter : fort_character = FirstPlayer.GetFortCharacter[]):
                FortniteCharacter.Damage(50.0)
```

## Next Lesson

[![Lesson 6: Defining a Function](https://dev.epicgames.com/community/api/documentation/image/31548e28-112d-4a9e-b291-9fa7cc6486bd?resizing_type=fit&width=640&height=640)

Lesson 6: Defining a Function

Learn about what goes into a function to make it work, and how to put the parts together.](<https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-6-defining-a-function-in-verse>)
