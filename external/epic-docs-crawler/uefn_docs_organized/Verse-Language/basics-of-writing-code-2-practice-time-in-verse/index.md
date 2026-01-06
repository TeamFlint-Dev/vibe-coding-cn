# Lesson 2: Practice Time!

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-2-practice-time-in-verse
> **爬取时间**: 2025-12-26T23:09:40.537395

---

Ready to write some code?

1. Open your **hello\_world\_device.verse** file from [Modify and Run Your First Verse Program](https://dev.epicgames.com/documentation/en-us/fortnite/modify-and-run-your-first-verse-program-in-unreal-editor-for-fortnite). You can see a couple of examples of the `Print()` function in the file already.
2. Use `Print()` to see the effect of combining different operators and literal values. Enter the first line of code below. Work out what will print to the screen before you run the line, then run it to see if you were right.

   ```verse
        Print("5 + -2 = {5 + -2}")
        Print("15.0 / 7.0 = {15.0 / 7.0}")
        Print("I + Love + Verse = {"I" + "Love" + "Verse"}")
   ```
3. Repeat this step for the second line (including working out what should print), then again for the third line.
4. Now copy and paste this line to see what happens!
    `Print("🐈💗🐟 = {"🐈💗🐟"}")`

## Complete Script

This is all of the code covered in this exercise. If you get stuck, you can see what the complete script looks like and even copy and paste it into your own Verse file to see the correct end result.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }

hello_world_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =

        Print("5 + -2 = {5 + -2}")
        Print("15.0 / 7.0 = {15.0 / 7.0}")
        Print("I + Love + Verse = {"I" + "Love" + "Verse"}")
        Print("🐈💗🐟 = {"🐈💗🐟"}")
```

## Next Lesson

[![Lesson 3: Storing and Using Information](https://dev.epicgames.com/community/api/documentation/image/ff5f9340-018e-450f-b962-023e0dae6321?resizing_type=fit&width=640&height=640)

Lesson 3: Storing and Using Information

Programs need information to know what to do. Learn different ways to store information in your program.](https://dev.epicgames.com/documentation/en-us/fortnite/basics-of-writing-code-3-storing-and-using-information-in-verse)
