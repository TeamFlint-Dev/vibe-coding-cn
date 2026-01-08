# Functions in Fortnite Creative

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/functions-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:09:51.394405

---

[Lesson Plan PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/cf7b512e-569b-46bd-b184-6ef602fa0c9e/fortnite-creative-functions-lesson-plan.pdf)[Student Guide PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/613a1f0f-203e-4fa3-a0c7-ad72274905a4/fortnite-creative-functions-student-guide.pdf)[Teacher Guide PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/6d339af6-f502-463c-8638-3d07a5b81977/fortnite-creative-functions-teacher-guide.pdf)[Lesson Rubric PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/688b7de5-0467-487a-9d71-ef9ca656a10b/functions-lesson-plan-rubric.pdf)

## Class Information

- **Grades:** 8–12 (students must be 13 or older to participate in this class)
- **Lesson timeframe:** One hour
- **Featured tool:** Fortnite Creative
- **Class / learning environment:** A Fortnite-capable device with a one-to-one device-to-student ratio, and with internet connectivity. A computer lab or mobile laptop cart should provide the ideal environment.

## Author Contact

Authors: Steven Isaacs and Brian Dickman

Email: <stevei2071@gmail.com> | <brian@cleverlike.com>

Twitter: @mr\_isaacs | @cleverlike

LinkedIn: <https://www.linkedin.com/in/steve-isaacs/> | <https://www.linkedin.com/in/cleverlike>

## DESCRIPTION OF CLASS/LEARNING ENVIRONMENT

This lesson is designed for **Hour of Code** during Computer Science Education Week.

This can serve as a stand-alone lesson, or be used in conjunction with the other activities to complete a larger project.

Author Steve Isaacs teaches Game Design and Development as a quest- or choice-based learning environment that provides students with opportunities to take different approaches to meeting the learning outcomes based on their own interests, in terms of content as well as project options.

Author Brian Dickman studied computer science and operates a full-time game development studio that produces entertaining and educational content inside popular video games.

## Lesson Overview

Do you have what it takes to escape the trivia tower? Better yet, do you have what it takes to create a trivia tower escape game?

This activity will demonstrate the use of functions in Fortnite Creative as you are tasked with creating a game that requires the player to answer a number of trivia questions in order to escape. Each correct answer will trigger the function to allow the player to advance along with a rewarding tune and visual effect. Incorrect answers will trigger not-so-pleasant sound and visual effect and require the player to try again.

By completing this activity, students will understand the basics of functions as they relate to coding through the use of the sequencer and a series of devices.

## Desired Results

What are the learning outcomes for students?

### ESSENTIAL QUESTIONS/BIG IDEAS

Can students learn computer science concepts as part of a meaningful activity rather than simply learning syntax as an isolated skill?

Will learning computer science concepts like functions through an activity in Fortnite Creative generalize to understanding the concept in a coding environment?

Can students learn computer science concepts through game mechanics?

Will students show more motivation to learn computer science when the concepts are introduced in a game environment?

## Learning Activities

### Introduction to Functions

A **function** is a unit of code that is often defined by its role within a greater code structure. Specifically, a function contains a unit of code that works on various inputs, many of which are variables, and produces concrete results involving changes to variable values or actual operations based on the inputs.

– from [Techopedia.com](https://www.techopedia.com/definition/25615/function)

Or more simply put:

A **function** is a piece of code that you can easily call over and over again.

– from [code.org](https://curriculum.code.org/csd-1718/unit3/19/)

For example, the activity in this lesson will have students set up a number of functions to be used to run a trivia game show in Fortnite Creative. Essentially, each function (represented by the sequencer) will run a series of commands (using devices) in the game.

**Pseudocode** is the act of simulating writing code to illustrate the idea that the code would represent. Pseudocode would
show the general structure but does not necessarily follow proper syntax. In these lessons we will periodically use
pseudocode to demonstrate the concepts.

In terms of pseudocode, this could look like

**Function 1 (askQuestion): starting the round/asking the player a question**
**Function 2 (startTimer): the countdown timer**

myFunction(askQuestion)
Do the following
Reset answer buttons
Play sound
Choose random number for trivia question
Present the Question
myFunction(startTimer)
Start countdown timer
If countdown gets to 0 Then
Time is up
Play sound
Show message (“Sorry, you did not answer in time”)
Activate next question
End function
End function

**Function 3: (correctAnswer)**
myFunction(correctAnswer)
Do the following
Play happy sound
Show message (“Correct! Great job!!”)
Add point to score
Activate next question
EndFunction
EndFunction

**Function 4: (wrongAnswer)**
myFunction(wrongAnswer)
Do the following
Play bad sound
Show message (“Sorry, Try again!”)
Activate next question
EndFunction

In the example above, when the function (askQuestion) is initiated, a number of things happen:

1. Reset answer buttons.
2. Play a sound to indicate the question will be coming up.
3. Choose a random number to determine which trivia question to ask.
4. Present the question to the player.

Then we introduce another function (startTimer) which initiates:

1. Start countdown timer.
2. Play a sound if the timer reaches 0 to conclude the opportunity to answer this question.

We add two additional functions (correctAnswer) and (wrongAnswer). These initiate the following:

1. Play a sound.
2. Adjust score if appropriate.
3. Display a message.
4. Activate the next question.

Here is a video that explains functions:

[CS Principles: Defining and Calling Functions](https://youtu.be/yPWQfa4CHbw)

Functions can be used in any coding language, and also in environments like Fortnite Creative.

In Fortnite, we will use the [Sequencer](https://www.epicgames.com/fortnite/en-US/creative/docs/using-pulse-trigger-devices-in-fortnite-creative) and place our events/actions within the Sequencer so that when the Sequencer is activated, the actions inside will be executed.

## Activities

Refer to the Student Guide and Teacher Notes for the step-by-step directions for the activity.

Students should access and work from the Student Guide.

Use the downloadable rubric to assess student work.

## EXTERNAL RESOURCES

[Code.org](http://www.code.org)

[Hour of Code](https://hourofcode.com/us)

[Makecode Arcade: Functions](https://arcade.makecode.com/courses/csintro2/functions)

[CS Principles: Intro to Variables Part 1](https://youtu.be/G41G_PEWFjE)
[CS Principles: Intro to Variables Part 2](https://youtu.be/ijjVDBPwA1o)
[Definition of variables](https://whatis.techtarget.com/definition/variable)

## Standards Mapping

[Common Core Standards](http://www.corestandards.org/)

[ISTE Standards for Students](https://www.iste.org/standards/iste-standards-for-students)

[NCSS Standards](https://www.socialstudies.org/standards/national-curriculum-standards-social-studies-introduction)

[NGSS Standards](https://www.nextgenscience.org/)

[CSTA Standards for Students](https://csteachers.org/Page/standards)

**1A-AP-09**
Model the way programs store and manipulate data by using numbers or other symbols to represent information.

**1B-AP-10**
Create programs that include sequences, events, loops, and conditionals.

**1B-AP-12**
Modify, remix, or incorporate portions of an existing program into one’s own work, to develop something new or add more advanced features.

**1B-AP-15**
Test and debug (identify and fix errors) a program or algorithm to ensure it runs as intended.

**2-AP-10**
Use flowcharts and/or pseudocode to address complex problems as algorithms.

**2-AP-13**
Decompose problems and subproblems into parts to facilitate the design, implementation, and review of programs.

**2-AP-14**
Create procedures with parameters to organize code and make it easier to reuse.

**2-AP-17**
Systematically test and refine programs using a range of test cases.

**3A-AP-13**
Create prototypes that use algorithms to solve computational problems by leveraging prior student knowledge and personal interests.

**3A-AP-16**
Design and iteratively develop computational artifacts for practical intent, personal expression, or to address a societal issue by using events to initiate instructions.

**3A-AP-17**
Decompose problems into smaller components through systematic analysis, using constructs such as procedures, modules, and/or objects.

**3A-AP-18**
Create artifacts by using procedures within a program, combinations of data and procedures, or independent but interrelated programs.

**3A-AP-22**
Design and develop computational artifacts working in team roles using collaborative tools.

### INTERDISCIPLINARY AND 21ST CENTURY CONNECTIONS

This lesson covers areas related to coding/Computer Science.

21st Century Connections:

- Critical thinking
- Creativity
- Collaboration
- Communication
- Technology literacy
- Flexibility
- Leadership
- Initiative
- Social skills

## MODIFICATIONS AND ACCOMMODATIONS

Provide modifications and accommodations as appropriate based on student needs, IEP, 504, etc.

Students can work in teams to integrate a paired programming approach.

Sample map can be provided for students to deconstruct / modify.

Provide adaptive controller / game controller if necessary.
