# Debugging and Troubleshooting

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/debugging-and-troubleshooting-in-verse>
> **爬取时间**: 2025-12-27T00:02:40.831383

---

When things don’t work as you expect in your Verse code, sometimes it's hard to understand what went wrong. For example, you can encounter:

- Runtime errors.
- Code executing in the wrong order.
- Processes taking longer than they should.

Any of these can cause your code to behave in unexpected ways and create problems in your experience. The act of diagnosing problems in your code is called [debugging](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#debugging), and there are several different solutions you can use to fix and optimize your code.

## Verse Runtime Errors

Your Verse code is analyzed both as you write it in the language server and when you compile it from the editor or Visual Studio Code. However, this semantic analysis alone can't catch all the possible problems you can encounter. When your code executes at runtime, you may trigger **runtime errors**. These will cause all further Verse code to stop executing, which may make your experience unplayable.

As an example, suppose you had some Verse code that did the following:

```verse
# Has the suspends specifier, so can be called in a loop expression.
SuspendsFunction()<suspends>:void={}

# Calls SuspendFunction forever without breaking or returning,
# causing a runtime error due to an infinite loop.
CausesInfiniteLoop()<suspends>:void=
    loop:
        SuspendsFunction()
```

The `CausesInfiniteLoop()` function wouldn't cause any errors in the Verse compiler, and your program would compile successfully. However, if you call `CausesInfiniteLoop()` at runtime, it will run an infinite loop, and thus trigger a runtime error.

To inspect runtime errors that have occurred in your experience, navigate to the [Content Service Portal](https://content-service.bfda.live.use1a.on.epicgames.com). There, you can see a list of all your projects, both published and unpublished. For each project, you have access to a **Verse** tab that lists the categories of runtime errors that have occurred in a project. You can also check the Verse call stack where that error was reported, which provides more details about what might have gone wrong. Error reports are stored for up to 30 days.

[![Content Portal Runtime Error](https://dev.epicgames.com/community/api/documentation/image/8b01080c-3467-4af9-9cd9-a0bc23f5034e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b01080c-3467-4af9-9cd9-a0bc23f5034e?resizing_type=fit)

Please note that this is a new feature that is early in development, and how this works may change in future versions of UEFN and Verse.

## Profiling Slow Code

If your code is running slower than you expect, you can test it using the [profile](https://dev.epicgames.com/documentation/en-us/fortnite/profile-in-verse) expression. The profile expression tells you how long a particular piece of code takes to run and can help you identify slow blocks of code and optimize them. For example, suppose you want to find whether an array contains a particular number and return the index where it appears. You could do this by iterating through the array and checking if the number matched the one you were searching for.

```verse
# An array of test numbers.
TestNumbers:[]int = array{1,2,3,4,5}

# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    # Find if the number exists in the TestNumbers array by iterating
    # through each element and checking if it matches.
    for:
        Index -> Number:TestNumbers
        Number = 4
    do:
        Print("Found the number at Index {Index}!")
```

However, this code is inefficient since it needs to check each number of the array for a match. This results in an inefficient [time complexity](https://dev.epicgames.com/documentation/en-us/fortnite/sorting-algorithms-in-verse), since even if it finds the element, it will continue checking the rest of the list. Instead, you can use the `Find[]` function to check if the array contains the number you’re looking for and return it. Since `Find[]` returns immediately when it finds the element, it will execute faster the earlier that the element is in the list. If you use a `profile` expression to test both pieces of code, you’ll see that in this case the code using the `Find[]` function results in lower execution time.

```verse
# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    # Find if the number exists in the TestNumbers array by iterating
    # through each element and checking if it matches.
    profile("Finding a number by checking each array element"):
        for:
            Index -> Number:TestNumbers
            Number = 4
        do:
            Print("Found the number at Index {Index}!")

    # Find if the number exists by using the Find[] function.
    profile("Finding a number using the Find[] function"):
        if:
            FoundIndex := TestNumbers.Find[4]
        then:
            Print("Found the number at Index {FoundIndex}!")
        else:
            Print("Failed to find the number!")
```

[![Profiling code with the Find expression](https://dev.epicgames.com/community/api/documentation/image/1d5cec3f-4b14-4738-90cc-a27d5bfc2309?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1d5cec3f-4b14-4738-90cc-a27d5bfc2309?resizing_type=fit)

These small differences in execution time are magnified the more elements you have to iterate through. Each expression you execute while iterating through a large list adds to the time complexity, especially as your arrays grow to hundreds or even thousands of elements. As you scale your experiences to more and more players, use the `profile` expression to find and tackle key areas of slowdown.

## Loggers and Logging Output

By default, when you call `Print()` in Verse code to print a message, that message writes to a dedicated `Print` log. Printed messages appear on the screen in-game, in the in-game log, and in the [**Output Log**](user-interface-reference-for-unreal-editor-for-fortnite#outputlog) in UEFN.

[![Logging output using print statements](https://dev.epicgames.com/community/api/documentation/image/563244dc-adef-4453-80d6-72207925cd3b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/563244dc-adef-4453-80d6-72207925cd3b?resizing_type=fit)

*When you print a message using the Print() function, that message writes to the Output Log, in-game Log tab, and the screen in-game.*

However, there are many times when you may not want messages to show up on the screen in-game. You may want to use messages for tracking when things happen, like when an event fires or a certain amount of time has passed, or for signaling when something goes wrong in your code. Multiple messages during gameplay can be distracting, especially if they don’t provide relevant information to the player.

To solve this, you can use a [logger](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log). A logger is a special class that lets you print messages directly to the **Output Log** and **Log** tab without displaying them on the screen.

### Loggers

To build a logger, you first need to create a [log channel](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api/unrealenginedotcom/temporary/diagnostics/log_channel). Every logger prints messages to the output log, but it can be hard to discern which message comes from which logger. Log channels add the name of the log channel to the start of the message, making it easy to see which logger sent the message. **Log channels** are declared at module scope, while loggers are declared inside classes or functions. The following is an example of declaring a log channel at module scope, then declaring and calling a logger inside a Verse device.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A log channel for the debugging_tester class.
# Log channels declared at module scope can be used by any class.
debugging_tester_log := class(log_channel){}

# A Verse-authored creative device that can be placed in a level
debugging_tester := class(creative_device):

    # A logger local to the debugging_tester class.
    Logger:log = log{Channel := debugging_tester_log}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        Print("This is the print channel speaking!")
        Logger.Print("And this is the debugging tester speaking!")
```

[![Logging output using log channels](https://dev.epicgames.com/community/api/documentation/image/2dea519d-5811-4855-bb2d-5eb1866a1852?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2dea519d-5811-4855-bb2d-5eb1866a1852?resizing_type=fit)

*When you print a message using a logger’s Print() function, that message gets written to the Output Log and the in-game Log tab.*

### Log Levels

In addition to channels, you can also specify a default **log level** that the logger prints to. There are five levels, each with their own properties:

| Log Level | Prints To | Special Properties |
| --- | --- | --- |
| Debug | In-game log | N/A |
| Verbose | In-game log | N/A |
| Normal | In-game log, **Output Log** | N/A |
| Warning | In-game log, **Output Log** | Text color is yellow |
| Error | In-game log, **Output Log** | Text color is red |

When you create a logger, it defaults to the `Normal` log level. You can change the level of a logger when you create the logger, or specify a log level to print to when calling `Print()`.

```verse
# A logger local to the debugging_tester class. By default, this prints
# to log_level.Normal.
Logger:log = log{Channel := debugging_tester_log}

# A logger with log_level.Debug as the default log channel.
DebugLogger:log = log{Channel := debugging_tester_log, DefaultLevel := log_level.Debug}

# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    # Logger will by default print to the Normal log channel, while DebugLogger
    # will by default print to the Debug log channel. Any logger can print to any level by
    # specifying the ?Level argument when calling Print()
    Logger.Print("This message prints to the Normal log channel!")
    DebugLogger.Print("And this message prints to the Debug log channel!")
    Logger.Print("This can also print to the Debug channel!", ?Level := log_level.Debug)
```

In the above example, `Logger` defaults to the `Normal` log channel, while `DebugLogger` defaults to the `Debug` log channel. Any logger can print to any log level by specifying the `log_level` when calling `Print()`.

[![Outputs at different log levels](https://dev.epicgames.com/community/api/documentation/image/e97d1cc0-edbc-4bc7-8141-b84360312660?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e97d1cc0-edbc-4bc7-8141-b84360312660?resizing_type=fit)

*Results of using a logger to print to different log levels. Note that log\_level.Debug and log\_level.Verbose do not print to the in-game log, only the UEFN Output Log.*

### Printing the Call Stack

The [call stack](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call-stack) tracks the list of function [calls](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#call) that have led to the current scope. It’s like a stacked set of instructions that your code uses to know where it should return to once the current routine finishes executing. You can print the call stack from any logger using the `PrintCallStack()` function. For example, take the following code:

```verse
# A logger local to the debugging_tester class. By default, this prints
# to log_level.Normal.
Logger:log = log{Channel := debugging_tester_log}

# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    # Move into the first function, and print the call stack after a few levels.
    LevelOne()

# Calls LevelTwo() to go one level deeper.
LevelOne():void=
    LevelTwo()

# Calls LevelThree() to go one level deeper.
LevelTwo():void=
    LevelThree()

# Print the call stack, which prints the sequence
# of function calls that led to this point.
LevelThree():void=
    Logger.PrintCallStack()
```

The code in `OnBegin()` above calls `LevelOne()` to move into the first function. Then `LevelOne()` calls `LevelTwo()`, which calls `LevelThree()`, which calls `Logger.PrintCallStack()` to print the current call stack. The most recent call will be at the top of the stack, so `LevelThree()` will be printed first. Then `LevelTwo()`, `LevelOne()`, and `OnBegin()`, in that order.

[![Printing the call stack](https://dev.epicgames.com/community/api/documentation/image/69cdf6f9-804e-477b-b1a1-4205e63f7c6b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69cdf6f9-804e-477b-b1a1-4205e63f7c6b?resizing_type=fit)

When something goes wrong in your code, printing the call stack is useful to know exactly what calls led to that point. This makes it easier to see the structure of your code as it runs and provides a way to isolate individual stack traces in code-dense projects.

## Visualizing Game Data with Debug Draw

Another way to debug different features of your experiences is by using the [Debug Draw API](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse). This API can build debug shapes to visualize game data. Some examples include::

- The line of sight of a guard.
- The distance a prop mover will move an object.
- The attenuation distance of an audio player.

You can use these debug shapes to fine-tune your experience without exposing this data in a published experience. For more information, check out [Debug Draw in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/debug-your-game-with-debug-draw-in-verse).

[![Debug Draw visualization](https://dev.epicgames.com/community/api/documentation/image/3e706f9a-6d6a-4ba9-863d-fac71a0a0c24?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3e706f9a-6d6a-4ba9-863d-fac71a0a0c24?resizing_type=fit)

## Optimization and Timing with Concurrency

[Concurrency](concurrency-in-verse) is at the heart of the Verse programming language and is a powerful tool to enhance your experiences. With concurrency, you can have one Verse device run multiple operations at once. This makes it possible to write more flexible, compact code, and save on the number of devices used in your level. Concurrency is a great tool for optimization, and finding ways to use asynchronous code to handle multiple tasks at once is a great way to speed up execution in your programs and tackle issues related to timing.

### Creating Async Contexts with Spawn

The [`spawn`](spawn-in-verse) expression starts an asynchronous expression from any context while allowing the following expressions to immediately execute. This provides a way to run multiple tasks at the same time, from the same device, without needing to create new Verse files for each. For example, consider a scenario where you have some code that monitors each player’s health every second. If a player’s health drops below a certain number, you want to heal them by a small amount. You then want to run some code after it that handles another task. A device that implements this code might look something like this:

```verse
# A Verse-authored creative device that can be placed in a level
healing_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=

        AllPlayers:[]agent = GetPlayspace().GetPlayers()

        # Every second, check each player. If the player has less than half health,
        # heal them by a small amount.
        loop:
            for:
                Player:Players
                Character := Player.GetFortCharacter[]
                PlayerHP := Character.GetHealth()
                PlayerHP <= HPThreshold
            do:
                Character.SetHealth(PlayerHP + SmallHeal)
            Sleep(1.0)
        Print("This is the rest of the code!")
```

However, because this loop runs forever and never breaks, any code that follows it will never run. This is a limiting design since this device is stuck only running the loop expression. To allow the device to do multiple things at once and run code concurrently, you can move the `loop` code into an asynchronous function and spawn it during `OnBegin()`.

```verse
# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    # Use the spawn expression to run HealMonitor() asynchronously.        
    spawn{HealMonitor()}

    # The code after this executes immediately.
    Print("This code keeps going while the spawned expression executes")

HealMonitor(Players:[]agent)<suspends>:void=
    # Every second, check each player. If the player has less than half health,
    # heal them by a small amount.
    loop:
        for:
            Player:Players
            Character := Player.GetFortCharacter[]
            PlayerHP := Character.GetHealth()
            PlayerHP <= HPThreshold
        do:
            Character.SetHealth(PlayerHP + SmallHeal)
        Sleep(1.0)
```

This is an improvement, as the device can now run other code while the `HealMonitor()` function runs. However, the function still has to loop through each player, and possible timing issues could occur the more players in the experience. For instance, what if you wanted to award each player score based on their HP, or check if they’re holding an item? Adding extra per-player logic in the `for` expression adds to the time complexity of this function, and with a sufficient number of players, one player might not get healed in time if they take damage due to timing issues.

Instead of looping through each player and checking them individually, you can further optimize this code by spawning an instance of the function per player. This means a single function can monitor a single player, ensuring your code doesn’t have to check each and every player before looping back to the one who needs healing. Using concurrency expressions like `spawn` to your advantage can make your code more efficient and flexible, and frees up the rest of your code base to handle other tasks.

```verse
# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    AllPlayers := GetPlayspace().GetPlayers()

    # Spawn an instance of the HealMonitor() function for each player.
    for:
        Player:AllPlayers
    do:
        # Use the spawn expression to run HealMonitorPerPlayer() asynchronously.        
        spawn{HealMonitorPerPlayer(Player)}

    # The code after this executes immediately.
    Print("This code keeps going while the spawned expression executes")

HealMonitorPerPlayer(Player:agent)<suspends>:void=
    if:
        Character := Player.GetFortCharacter[]
    then:
        # Every second, check the monitored player. If the player has less than half health,
        # heal them by a small amount.
        loop:
            PlayerHP := Character.GetHealth()
            if:
                PlayerHP <= HPThreshold
            then:
                Character.SetHealth(PlayerHP + SmallHeal)
            Sleep(1.0)
```

Using the `spawn` expression within a `loop` expression can cause undesired behavior if handled improperly. For example, because `HealMonitorPerPlayer()` never terminates, this code will continue to spawn an infinite amount of asynchronous functions until a runtime error occurs.

```verse
# Spawn an instance of the HealMonitor() function for each player, looping forever.
# This will cause a runtime error as the number of asynchronous functions infinitely increases.
loop:
    for:
        Player:AllPlayers
    do:
        spawn{HealMonitorPerPlayer(Player)}
    Sleep(0.0)
```

### Controlling Timing with Events

Getting every part of your code to sync up correctly can be difficult, especially in large multiplayer experiences with many scripts running at once. Different parts of your code may rely on other functions or scripts executing in a set order, and this can create timing issues between them without strict controls. For example, consider the following function which counts down for some amount of time, then awards the player passed to it some score if their HP is greater than the threshold.

```verse
CountdownScore(Player:agent)<suspends>:void=
    # Wait for some amount of time, then award each player whose HP is above the threshold some score.
    Sleep(CountdownTime)
    if:
        Character := Player.GetFortCharacter[]
        PlayerHP := Character.GetHealth()
        PlayerHP >= HPThreshold
    then:
        ScoreManager.Activate(Player)
```

Because this function has the `<suspends>` modifier, you can run an instance of it asynchronously per player using `spawn()`. However, you have to guarantee that any other code that relies on this function will always run after it completes. What if you want to print each player who scored after `CountdownScore()` finishes? You could do this in `OnBegin()` by calling `Sleep()` to wait the same amount of time as `CountdownScore()` takes to execute, but this could create timing issues when your game is running and introduces a new variable you have to constantly update if you ever want to make changes to your code. Instead, you can create custom events and call `Await()` on them to strictly control the order of events in your code.

```verse
# Custom event to signal when the countdown finishes.
CountdownCompleteEvent:event() = event(){}

# Runs when the device is started in a running game
OnBegin<override>()<suspends>:void=

    AllPlayers := GetPlayspace().GetPlayers()

    # Spawn a CountdownScore function for each player
    for:
        Player:AllPlayers
    do:
        spawn{CountdownScore(Player)}

    # Wait for the CountdownCompletedEvent to be signaled.
    CountdownCompleteEvent.Await()

    # If the player has any score, print it to the log.
    for:
        Player:AllPlayers
        CurrentScore := ScoreManager.GetCurrentScore(Player)
        CurrentScore > 0
    do:
        Print("This Player has score!")

CountdownScore(Player:agent)<suspends>:void=

    # Wait for some amount of time, then award each player whose HP is above the threshold some score.
    Sleep(CountdownTime)
    if:
        Character := Player.GetFortCharacter[]
        PlayerHP := Character.GetHealth()
        PlayerHP >= HPThreshold
    then:
        ScoreManager.Activate(Player)
    # Signal the event to let any code awaiting it proceed.
    CountdownCompleteEvent.Signal()
```

Because this code now waits for the `CountdownCompletedEvent()` to be signaled, it is guaranteed to check each player’s score only after `CountdownScore()` finishes executing. Many devices have built-in events you can call `Await()` on to control the timing of your code, and by leveraging these with your own custom events you can create complex game loops with several moving parts. As an example, the [Verse Starter Template](verse-starter-template-in-unreal-editor-for-fortnite) uses several custom events to control character movement, update the UI, and manage the overall game loop from board to board.

### Handling Multiple Expressions with Sync, Race, and Rush

The [sync](sync-in-verse), [race](race-in-verse), and [rush](rush-in-verse) all allow you to run multiple async expressions at once while performing different functions when those expressions finish executing. By leveraging each of these you can strictly control the lifetime of each of your async expressions, resulting in more dynamic code that can handle multiple different situations.

For example, take the `rush` expression. This expression runs multiple async expressions concurrently but only returns the value of the expression that finishes first. Suppose you have a minigame where teams have to complete some task, with the team who finishes first getting a powerup that lets them interfere with the other players while they finish. You could write complicated timing logic to track when each team completes the task, or you could use the `rush` expression. Since the expression returns the value of the first async expression to finish, it will return the winning team, while allowing the code that handles the other teams to continue running.

```verse
WinningTeam := rush:

    # All three async functions start at the same time.
    RushToFinish(TeamOne)
    RushToFinish(TeamTwo)  
    RushToFinish(TeamThree)

# The next expression is called immediately when any of the async functions complete. 
GrantPowerup(WinnerTeam)
```

The `race` expression follows the same rules, except that when an async expression completes, the other expressions are canceled. This lets you strictly control the lifetime of multiple async expressions at once, and you can even combine this with the `sleep()` expression to limit the amount of time you want the expression to run. Consider the `rush` example, except this time you want the minigame to end immediately when a team wins. You also want to add a timer so that the minigame doesn’t go on forever. The `race` expression allows you to do both of these, without needing to use events or other concurrency tools to know when to cancel the expressions that lose the race.

```verse
WinningTeam := race:

    # All four async functions start at the same time.
    RaceToFinish(TeamOne)
    RaceToFinish(TeamTwo)  
    RaceToFinish(TeamThree)
    Sleep(TimeLimit)

# The next expression is called immediately when any of the async functions complete. Any other async functions are canceled.
GrantPowerup(WinnerTeam)
```

Finally, the `sync` expression allows you to wait till multiple expressions finish executing, guaranteeing that each of them completes before proceeding. Since the `sync` expression returns a [tuple](tuple-in-verse) containing the results from each of the async expressions, you can finish running all of your expressions and evaluate the data from each of them individually. Back to the minigame example, let’s say instead you wanted to grant powerups to each team based on how they did in the minigame. This is where the `sync` expression comes in.

```verse
TeamResults := sync:

    # All three async functions start at the same time.
    WaitForFinish(TeamOne)
    WaitForFinish(TeamTwo)  
    WaitForFinish(TeamThree)

# The next expression is called only when all of the async expressions complete.
GrantPowerups(TeamResults)
```

If you want to run an async expression on multiple array elements you can use the handy [`ArraySync()`](https://dev.epicgames.com/community/snippets/oYRX/fortnite-generic-sync-and-race-across-elements-in-an-array) function to guarantee they all sync up.

Each of these concurrency expressions is a powerful tool by itself, and by learning how to combine and use them together you can write code to handle any situation. Consider this example from the [Speedway Race with Verse Persistence Template](speedway-race-with-verse-persistence-in-unreal-editor-for-fortnite#startinglinecinematicwithplayerstats), which combines multiple concurrency expressions to not only play an intro for each player before the race but also cancel it if the player leaves during the intro. This example highlights how you can use concurrency in multiple ways, and build resilient code that reacts dynamically to different events.

```verse
# Wait for the player's intro start and display their info.
# Cancel the wait if they leave.
WaitForPlayerIntro(Player:agent, StartOrder:int)<suspends>:void=

    var IntroCounter:int = 0

    race:
        # Waiting for this player to finish the race and then record the finish.
        loop:
            sync:
                block:
                    StartPlayerIntroEvent.TriggeredEvent.Await()
                    if (IntroCounter = StartOrder):
                        PlayerLeaderboard.UpdatePopupUI(Player, PopupDialog)
                EndPlayerIntroEvent.TriggeredEvent.Await()
            if (IntroCounter = StartOrder):
                break
            set IntroCounter += 1
        # Waiting for this player to leave the game.
        loop:
            LeavingPlayer := GetPlayspace().PlayerRemovedEvent().Await()
            if:
                LeavingPlayer = Player
            then:
                break
```
