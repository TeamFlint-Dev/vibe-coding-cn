# Create Voting Opportunities

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-create-voting-opportunities-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:12:37.596377

---

As seen in **Squid Game**, opportunities to vote for a chance of freedom or an advantage often heighten the tension between players. The opportunity to vote in your island can further push social interactions and  interplay between players.

[![Squid Game Social Deduction Voting Gameplay in UEFN](https://dev.epicgames.com/community/api/documentation/image/617ca02b-d3fd-42d0-a089-be4f7082f6c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/617ca02b-d3fd-42d0-a089-be4f7082f6c7?resizing_type=fit)

Social Deduction Voting Gameplay

The [Social Deduction](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-social-deduction-template-in-unreal-editor-for-fortnite) template explores the use of voting devices, where players must choose the correct answer to stay in the game. You can use the devices to set up opportunities for players to make quick decisions that can completely alter the game and stakes.

## Voting Devices

To create voting opportunities in your island, you can use the **Voting Group** and **Voting Options** devices. You must use the devices together to create your poll. These devices are available for all Fortnite islands in Creative and UEFN, but are especially useful for Squid Game islands.

In the template, you can find the devices in the **Content Drawer**, under **All > Fortnite > Devices > Logic**.

Both devices are connected through the Voting Group option. This option in both devices must have the same ID string. For example, **3** is used in the template.

|  |  |
| --- | --- |
|  |  |
| **Voting Group Device** | **Voting Options Device** |

Rename both devices with unique but connected names. This organization helps with finding the devices when connecting them together.

You can connect multiple Voting Options devices to a single Voting Group device as shown in the tutorial zone.

To get started, decide what to call a vote on. To start the vote you can use buttons, triggers, Verse, and other conditional means. Use timers or other devices to signal the end of the vote. You can set up a vote to lead to another event.

Add user interface (UI) elements to the voting devices for a visual aid. The template uses [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative) devices to show the question and options. You can use the [Pop-Up Dialog](https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative) device to create a heads up display (HUD) version.

To learn more about the device and settings, see [Using Voting Group and Voting Options Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite).

[![Squid Game Voting Device Examples in UEFN](https://dev.epicgames.com/community/api/documentation/image/d760a0df-19a3-4c5d-8c2d-744ee805d3a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d760a0df-19a3-4c5d-8c2d-744ee805d3a7?resizing_type=fit)

Voting Device Examples

## Gameplay Setup

The voting minigame in this template sets players up for a bit of mistrust of both their own mind and other players. Is a player really sure that they are confident in their own knowledge, if all the other players are visibly voting for something different?

[![Squid Game Voting Arena in UEFN](https://dev.epicgames.com/community/api/documentation/image/8c3c0221-f5ce-4169-8ad1-c04f2169f560?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8c3c0221-f5ce-4169-8ad1-c04f2169f560?resizing_type=fit)

Voting Arena

Similar doubts and second guessing is visible in the Squid Game show with the infamous X vs O voting scenes. In the template the consequences are a bit different.

The template includes two levels for different room setups. One uses only devices, and the other incorporates Verse. The level with **\_Verse** appended to the end of the level name includes the Verse example. To see how the two levels compare, see the [Verse Level](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-create-voting-opportunities-in-unreal-editor-for-fortnite#verse-level) section on this page.

### Device-Only Level

Devices Used

- [Voting Group](https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite) x 1
- [Voting Options](https://dev.epicgames.com/documentation/en-us/fortnite/using-voting-group-and-voting-options-devices-in-fortnite) x 4
- [Billboard](https://dev.epicgames.com/documentation/en-us/fortnite/using-billboard-devices-in-fortnite-creative)   x 18
- [Button](https://dev.epicgames.com/documentation/en-us/fortnite/using-button-devices-in-fortnite-creative) x 5
- [Damage Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-damage-volume-devices-in-fortnite-creative)  x 1
- [HUD Message](https://dev.epicgames.com/documentation/en-us/fortnite/using-hud-message-devices-in-fortnite-creative)  x 1
- [Prop Manipulator](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-manipulator-devices-in-fortnite-creative) x 3
- [Switch](https://dev.epicgames.com/documentation/en-us/fortnite/using-switch-devices-in-fortnite-creative) x 4
- [Teleporter](https://dev.epicgames.com/documentation/en-us/fortnite/using-teleporter-devices-in-fortnite-creative)  x 6
- [Timer](https://dev.epicgames.com/documentation/en-us/fortnite/using-timer-devices-in-fortnite-creative) x 1
- [Trigger](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative) x 2
- [Volume](https://dev.epicgames.com/documentation/en-us/fortnite/using-volume-devices-in-fortnite-creative) x 1

To start the experience, a player must press the **Button** device presented in the center of the options. Pressing the button triggers the following:

- The question, multiple choice options, and options on the clear boxes are displayed with the **Billboard** devices.
- Starts the vote from the **Voting Group** device.
- A **Timer** device starts the countdown for selecting a question.

[![Squid Game Voting Arena Setup in UEFN](https://dev.epicgames.com/community/api/documentation/image/fb787b8e-554e-468b-9b13-820f1ccdeff6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb787b8e-554e-468b-9b13-820f1ccdeff6?resizing_type=fit)

Voting Arena Setup

Voting is set up with 4 **Button** devices to signal your answer, which are connected to corresponding **Voting Option** devices.  Pressing a button triggers the **Teleporter** device to spawn players inside the clear box, made from the **Glass Gallery**.

If a player chooses the wrong answer, the **Prop Manipulator** device removes the bottom of the box, and they fall into the lava. A **Damage Volume** device is placed over the lava to eliminate the falling players. The winner is presented with a **Teleporter** device to get back to the voting zone.

### Verse Level

The Verse level for the room has the same gameplay but different setup for producing questions and answers. Added to the device list is the custom `voting_device` Verse device.

[![](https://dev.epicgames.com/community/api/documentation/image/f88afe54-9307-41c4-a9b9-746731aa3c5b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f88afe54-9307-41c4-a9b9-746731aa3c5b?resizing_type=fit)

Verse Voting Device User Options

In the device-only level, there is only one question, and only answer C can be correct.

Adding additional questions in the manual setup would require several **Billboard** devices for each question, which then must be toggled. Converting the question into a general version would add complexity. Handling winners and losers based on any answer would require numerous event bindings between multiple devices, teleporters, and prop manipulators.

With Verse, more flexibility is added to the quiz. With the device, you can do the following:

- Make a list of questions in the Verse device settings.
- For each round, have the device pick a new question.
- Automatically update billboards with questions and available answers.
- Set any answer to be correct. Verse properly handles winners and losers.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Verse.org/Random }
using { /UnrealEngine.com/Temporary/Diagnostics }

PlainText<public><localizes>(Text:string):message = "{Text}"

AnswersCategory<public><localizes>:message := "Answers"

answer := enum<open>:
    A
    B
    C
    D

AnswerToIndex(Answer : answer)<transacts>:int=
    case (Answer):
        answer.A => 0
        answer.B => 1
        answer.C => 2
        answer.D => 3
        _ => -1

question := class:

    @editable_text_box:
        MultiLine := true
    Description : string = ""

    @editable:
        Categories := array{AnswersCategory}
    A : string = ""

    @editable:
        Categories := array{AnswersCategory}
    B : string = ""

    @editable:
        Categories := array{AnswersCategory}
    C : string = ""

    @editable:
        Categories := array{AnswersCategory}
    D : string = ""

    @editable
    CorrectAnswer : answer = answer.A

BillboardsCategory<public><localizes>:message := "Billboards"
VotingCategory<public><localizes>:message := "Voting"
ResultCategory<public><localizes>:message := "Result"

QuestionsTooltip<public><localizes>:message := "List of questions and answers presented to the player."
AnswerCubeTooltip<public><localizes>:message := "Billboard that is displayed in front of cube."
AnswerBoardTooltip<public><localizes>:message := "Billboard that is displayed on big board above lava pit."
AnswerButtonTooltip<public><localizes>:message := "Buttons used to vote for each answer."
EndMessageTooltip<public><localizes>:message := "Message device that is used to display results to the players."
TeleporterTooltip<public><localizes>:message := "Teleporters that are used to teleport winners out of the cube."
PropTooltip<public><localizes>:message := "Prop manipulators used to hide floor in loser's cubes."
VotingStartTooltip<public><localizes>:message := "Button that begins next voting session."
VotingEndTooltip<public><localizes>:message := "Sends trigger when voting ends."
VotingTimerTooltip<public><localizes>:message := "Timer that tracks voting countdown."

voting_device := class(creative_device):

    @editable:
        ToolTip := QuestionsTooltip
    Questions : []question = array{}

    @editable:
        Categories := array{BillboardsCategory}
    QuestionLeftBillboard : billboard_device = billboard_device{}

    @editable:
        Categories := array{BillboardsCategory}
    QuestionRightBillboard : billboard_device = billboard_device{}

    @editable:
        Categories := array{BillboardsCategory}
        ToolTip := AnswerCubeTooltip
    AnswerCubeBillboards : []billboard_device = array{}

    @editable:
        Categories := array{BillboardsCategory}
        ToolTip := AnswerBoardTooltip
    AnswerBoardBillboards : []billboard_device = array{}

    @editable:
        Categories := array{VotingCategory}
        ToolTip := AnswerButtonTooltip
    AnswerButtons : []button_device = array{}

    @editable:
        Categories := array{ResultCategory}
        ToolTip := EndMessageTooltip
    EndMessage : hud_message_device = hud_message_device{}

    @editable:
        Categories := array{ResultCategory}
        ToolTip := PropTooltip
    CubePropManipulators : []prop_manipulator_device = array{}

    @editable:
        Categories := array{ResultCategory}
        ToolTip := TeleporterTooltip
    WinnerTeleporters : []teleporter_device = array{}

    @editable:
        Categories := array{VotingCategory}
        ToolTip := VotingStartTooltip
    VoteStartButton : button_device = button_device{}

    @editable:
        Categories := array{VotingCategory}
        ToolTip := VotingEndTooltip
    VoteEndTrigger : trigger_device = trigger_device{}

    @editable:
        Categories := array{VotingCategory}
        ToolTip := VotingTimerTooltip
    VoteTimer : timer_device = timer_device{}

    var CurrentQuestion : question = question{}
    var QuestionID : int = 0
    var Winners : []agent = array{}
    var Losers : []agent = array{}

    OnBegin<override>()<suspends>:void=
        VoteStartButton.InteractedWithEvent.Subscribe(StartVoting)
        VoteEndTrigger.TriggeredEvent.Subscribe(EndVoting)
        SubscribeVotes()
        HideText()

    # Resets voting area state, displays next question and starts voting timer.
    StartVoting(Agent : agent):void=
        DisableTeleporters()
        ShowCubes()
        set Winners = array{}
        set Losers = array{}
        VoteTimer.Start()
        if (Question := GetNextQuestion[]):
            set CurrentQuestion = Question
            UpdateDescription(Question.Description)
            UpdateAnswer(answer.A, Question.A)
            UpdateAnswer(answer.B, Question.B)
            UpdateAnswer(answer.C, Question.C)
            UpdateAnswer(answer.D, Question.D)

    # Handles win/lose condition
    EndVoting(Agent : ?agent):void=
        CorrectAnswerIndex := AnswerToIndex(CurrentQuestion.CorrectAnswer)
        Answers := array{CurrentQuestion.A, CurrentQuestion.B, CurrentQuestion.C, CurrentQuestion.D}

        if (CorrectAnswer := Answers[CorrectAnswerIndex]):
            for (Loser : Losers):
                EndMessage.SetText(PlainText("You were wrong! Correct answer: {CorrectAnswer}"))
                EndMessage.Show(Loser)
       
        for (Winner : Winners):
            EndMessage.SetText(PlainText("You were right! Get ready for the next round!"))
            EndMessage.Show(Winner)

        # Teleport winner
        if:
            WinnerTeleporter := WinnerTeleporters[CorrectAnswerIndex]
        then:
            WinnerTeleporter.Enable()

        # Throw losers into lava
        for (PropIndex->PropManipulator : CubePropManipulators, PropIndex <> CorrectAnswerIndex):
                PropManipulator.HideProps()

    # Adds player to winners or losers list according to their answer
    OnVote(Agent : agent, Answer : answer)<transacts>:void=
        if (CurrentQuestion.CorrectAnswer = Answer):
            set Winners += array{Agent}
        else:
            set Losers += array{Agent}

    # Updates question displayed to players on billboard
    UpdateDescription(Text : string):void=
        QuestionLeftBillboard.SetText(PlainText(Text))
        QuestionRightBillboard.SetText(PlainText(Text))
        QuestionLeftBillboard.ShowText()
        QuestionRightBillboard.ShowText()

    # Updates answer displayed to players on billboard
    UpdateAnswer(Answer : answer, Text : string):void=
        if:
            Cube := AnswerCubeBillboards[AnswerToIndex(Answer)]
            Board := AnswerBoardBillboards[AnswerToIndex(Answer)]
        then:
            Cube.SetText(PlainText(Text))
            Board.SetText(PlainText(Text))
            Cube.ShowText()
            Board.ShowText()

    # Hides all text related to question
    HideText():void=
        QuestionLeftBillboard.HideText()
        QuestionRightBillboard.HideText()
        for (Billboard : AnswerCubeBillboards):
            Billboard.HideText()
        for (Billboard : AnswerBoardBillboards):
            Billboard.HideText()

    # Binds button interaction to corresponding answer
    SubscribeVote(Answer : answer):void=
        if (Button := AnswerButtons[AnswerToIndex(Answer)]):
            Button.InteractedWithEvent.SubscribeAgent(OnVote, Answer)

    # Bind every answer to button
    SubscribeVotes():void=
        SubscribeVote(answer.A)
        SubscribeVote(answer.B)
        SubscribeVote(answer.C)
        SubscribeVote(answer.D)

    # Disables all winner teleporters
    DisableTeleporters():void=
        for (Teleporter : WinnerTeleporters):
            Teleporter.Disable()

    # Enables floor in every cube
    ShowCubes():void=
        for (CubeManipulator : CubePropManipulators):
            CubeManipulator.ShowProps()

    # Fails if questions array is empty
    GetNextQuestion()<transacts><decides>:question=
        Question := Questions[QuestionID]
        set QuestionID += 1
        if (QuestionID >= Questions.Length):
            set QuestionID = 0
        Question
```

## Design Tips

Below are additional design considerations:

- Similar to the gameplay example, build out consequences for a vote.
- Decide if players should be made aware of one another's votes. An unexpected result can raise doubt amongst players.
- Adjust the timer speed to provide players an opportunity to backtrack.
- Provide visual indications for players to know what they are voting on.
- Use the Squid Game console props to design your voting areas.
- Providing information through voting can add a layer of intrigue to your island. Players can start to think the information leads to a clue.

## Next

Hop into the next room to learn about the **Giftbox** device.

[![Giftbox Device for Hiding and Teleportation](https://dev.epicgames.com/community/api/documentation/image/76ea203d-c1ff-4ce0-a314-fa6e6afdb41f?resizing_type=fit&width=640&height=640)

Giftbox Device for Hiding and Teleportation

Learn to use the Giftbox Device for hiding and teleporting players in your Squid Game island.](https://dev.epicgames.com/documentation/en-us/fortnite/squid-game-giftbox-device-for-hiding-and-teleportation-in-unreal-editor-for-fortnite)
