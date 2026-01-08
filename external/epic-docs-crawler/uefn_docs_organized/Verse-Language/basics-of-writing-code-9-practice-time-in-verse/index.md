# Lesson 9: Practice Time

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-9-practice-time-in-verse>
> **爬取时间**: 2025-12-26T23:10:44.199173

---

For this exercise, your goal is to damage the player if they do not move a certain distance from their spawn pad within a defined time. You will use failure expressions and failure contexts to get location information about the player, and to figure out how far they have moved 10 seconds after spawning.

First, make sure you still have the `HurtPlayer()` and `CalculateDamage()` functions in your Verse file. You will be calling `HurtPlayer()` if the player has not moved far enough. As a reminder, here is the code for those functions.

```verse
HurtPlayer(DamageAmount:float):void=
    Playspace:fort_playspace = GetPlayspace()
    AllPlayers:[]player = Playspace.GetPlayers()
    if (Player:player = AllPlayers[0]):
        if (FortniteCharacter:fort_character = Player.GetFortCharacter[]):
                MyCharacterHealth:float = FortniteCharacter.GetHealth()
                DamageToDo:float = CalculateDamage(MyCharacterHealth, DamageAmount, 1.0)
                Print("Damage To Do: {DamageToDo}")
                FortniteCharacter.Damage(DamageToDo)

CalculateDamage(PlayerHealth:float, DesiredDamageAmount:float, MinHealth:float):float=
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

Now, you'll need to get all the `player` objects in the level (in this case just one, you!). You'll also create two variables to store the `transform` of the player at different times. A **transform** holds data about an object's location, rotation, and scale. For this exercise, you only need the location, but it's stored in the `transform` object.

```verse
Playspace:fort_playspace = GetPlayspace()
AllPlayers:[]player = Playspace.GetPlayers()

var FirstPosition:transform = transform{}
var SecondPosition:transform = transform{}
```

It's time to create a couple of failure contexts using `if`. The first two lines below get the `fort_character` object from the `player` object. If this code looks familiar, that's because it's nearly the same as some of the code from the `HurtPlayer()` function. You have to write it again here because you also need it to get the `transform` of a ‘fort\_character'. It can also fail, as indicated by the `[]`, so it has to be in a failure context.

Set the `FirstPosition` variable you created earlier to the value returned by `FortniteCharacter.GetTransform()`. This expression is not failable, but if either of the two previous expressions fail, you don't want to run this expression, so it's in the same failure context.

```verse
if:
    Player:player = AllPlayers[0]
    FortniteCharacter:fort_character = Player.GetFortCharacter[]
    set FirstPosition = FortniteCharacter.GetTransform()
```

Since all your failable expressions are in the `if` code block, you need a new code block for the code that you want to run if they succeed. That's where `then` comes in. When you write the form of `if` without the `()`, use `then` for code that should run if all the code in the `if` code block succeeds.

Your first `then` block should look like this.

```verse
then:
    Print("Move or prepare to take damage!")
    Sleep(10.0)
```

You've seen both of these functions before. `Print()` is used here to warn the player that they need to move. `Sleep()` gives the player 10 seconds to move away from the spawn point before the next block of code runs.

After a 10-second wait, it's time to run the code that will check if the player is a certain distance from their spawn point, and if not, damage them.

```verse
if:
    Player:player = AllPlayers[0]
    FortniteCharacter:fort_character = Player.GetFortCharacter[]
    set SecondPosition = FortniteCharacter.GetTransform()
    DistanceBetweenPositions:float = DistanceXY(FirstPosition.Translation, SecondPosition.Translation)
    DistanceBetweenPositions < 10000.0
```

The first three lines are almost the same as the first `if` code block, except that now you're setting `SecondPosition` instead of `FirstPosition`. Now you have two locations to compare.

Next, declare and initialize `DistanceBetweenPositions`. To get this, you'll use a built-in Verse function called `DistanceXY()`. It takes two arguments, both coordinates in 3D space called vectors. It only uses the X and Y coordinates to measure distance, and returns that distance as a `float`. Remember to only use the `Translation` property of the two `transform` variables.

Finally, compare the `DistanceBetweenPositions` to a literal `float` value. It's a good idea to start with a large number to make sure your code is working. Decrease it as you figure out a reasonable distance to move within the given time.

Your next `then` block will run if players **do not** move the required distance within the time limit. So you want this to be the code that damages the player.

```verse
then:
    Print("Distance Moved: {DistanceBetweenPositions}")
    Print("Applying Damage")
    HurtPlayer(50.0)
```

This will print the actual distance the player moved, a notification that the damage is about to be applied, and a call to the `HurtPlayer()` function that you wrote earlier. By calling the `HurtPlayer()` function, you don't have to think about how it's implemented. You know it will follow the rules you set earlier for damaging the player.

## Complete Script

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /UnrealEngine.com/Temporary/SpatialMath }

hello_world_device := class(creative_device):

# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    Playspace:fort_playspace = GetPlayspace()
    AllPlayers:[]player = Playspace.GetPlayers()

    var FirstPosition:transform = transform{}
    var SecondPosition:transform = transform{}

    if:
        Player:player = AllPlayers[0]
        FortniteCharacter:fort_character = Player.GetFortCharacter[]
        set FirstPosition = FortniteCharacter.GetTransform()
    then:
        Print("Move or prepare to take damage!")
        Sleep(10.0)

    if:
        Player : player = AllPlayers[0]
        FortniteCharacter : fort_character = Player.GetFortCharacter[]
        set SecondPosition = FortniteCharacter.GetTransform()
        DistanceBetweenPositions: float = DistanceXY(FirstPosition.Translation, SecondPosition.Translation)
        DistanceBetweenPositions < 10000.0
    then:
        Print("Distance Moved: {DistanceBetweenPositions}")
        Print("Applying Damage")
        HurtPlayer(50.0)

# Functions From Previous Lessons
#################################

HurtPlayer(DamageAmount : float):void=
    Playspace: fort_playspace = GetPlayspace()
    AllPlayers: []player = Playspace.GetPlayers()
    if (Player : player = AllPlayers[0]):
        if (FortniteCharacter : fort_character = Player.GetFortCharacter[]):
            MyCharacterHealth : float = FortniteCharacter.GetHealth()
            DamageToDo : float = CalculateDamage(MyCharacterHealth, DamageAmount, 1.0)
            Print("Damage To Do: {DamageToDo}")
            FortniteCharacter.Damage(DamageToDo)

CalculateDamage(PlayerHealth:float, DesiredDamageAmount:float, MinHealth:float):float =
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

## Next Steps

Now that you know the basics, you're ready to use Verse to create your own device in Unreal Editor for Fortnite! Check out the following guide to learn how.

[![Create Your Own Device Using Verse](https://dev.epicgames.com/community/api/documentation/image/78acf6e2-82a8-4f3d-b0da-6e5eb05f353a?resizing_type=fit&width=640&height=640)

Create Your Own Device Using Verse

Make your own device and rules using Verse!](<https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite>)
