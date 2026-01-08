# Building a Treasure Hunt Race in Fortnite Creative

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/treasure-hunt-race-lesson-plan-in-fortnite-creative>
> **爬取时间**: 2025-12-27T02:09:56.637684

---

[Lesson Plan PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/9ac2c473-9725-4958-9cec-5c828b4d74f0/fortnite-creative-treasure-hunt-lesson-plan.pdf)[Student Guide PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/e640a100-6982-42e0-a088-7443afca8532/fortnite-creative-treasure-hunt-student-guide.pdf)[Teacher Guide PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/e9b6244b-b6c6-4599-97ec-625381a4f170/fortnite-creative-treasure-hunt-teacher-guide.pdf)[Lesson Rubric PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/bb7cc99a-5714-4e73-861f-f69988db465c/treasure-hunt-lesson-plan-rubric.pdf)

## Class Information

- **Grades:** 8–12 (students must be 13 or older to participate in this class)
- **Lesson timeframe:** One hour
- **Featured tool:** Fortnite Creative
- **Class / learning environment:** A Fortnite-capable device with a one-to-one device-to-student ratio, and with internet connectivity. A computer lab or mobile laptop cart should provide the ideal environment.

## Author Contact

Authors: Steven Isaacs and Brian Dickman

Email: <steven.isaacs@epicgames.com> | <brian@cleverlike.com>

Twitter: @mr\_isaacs | @cleverlike

LinkedIn: [www.linkedin.com/in/steve-isaacs](https://www.linkedin.com/in/steve-isaacs/) | [www.linkedin.com/in/cleverlike](https://www.linkedin.com/in/cleverlike)

## DESCRIPTION OF CLASS/LEARNING ENVIRONMENT

This lesson is designed for **Hour of Code** during Computer Science Education Week.

This can serve as a stand-alone lesson, or be used in conjunction with the other activities to complete a larger project.

Author Steve Isaacs is the Education Program Manager at Epic Games. In his role, he supports secondary educators and students in bringing tools, including Unreal Engine, Fortnite Creative, and Twinmotion, into the classroom. Prior to his role at Epic, Steve taught Game Design and Development in a choice-based learning environment that provides students with opportunities to take different approaches to meeting the learning outcomes based on their own interests, in terms of content as well as project options.

Author Brian Dickman studied computer science and operates a full-time game development studio that produces entertaining and educational content inside popular video games.

## Lesson Overview

Have you ever thought about how score is handled in video games?

If you’ve ever played Pac-Man, you have certainly tried to get a high score. As you collect dots you get points and bonus points for fruit. When the monsters turn blue, you try to get as many as you can as the score for each one increases and you eat your way through them. Many games have a scoring mechanism that is an integral part of the game.

Scores in games are handled with variables. A variable is set at the beginning of the game and changes throughout the game, based on actions that impact the score.

In this activity, students will set up a scoring system using variables. This is just one of many ways variables are used in programming.

## Desired Results

What are the learning outcomes for students?

### ESSENTIAL QUESTIONS/BIG IDEAS

Can students learn computer science concepts as part of a meaningful activity rather than simply learning syntax as an isolated skill?

Will learning computer science concepts like functions through an activity in Fortnite Creative generalize to understanding the concept in a coding environment?

Can students learn computer science concepts through game mechanics?

Will students show more motivation to learn computer science when the concepts are introduced in a game environment?

## Learning Activities

### Introduction to Variables

In programming, a **variable** is a value that can change, depending on conditions or on information passed to the program. Typically, a program consists of instructions that tell the computer what to do and data that the program uses when it is running. The data consists of **constants (fixed values)** that never change, and **variable values** (which are usually initialized to 0 or some default value because the actual values will be supplied by a program’s user). Usually, both constants and variables are defined as certain data types. Each data type prescribes and limits the form of the data. Examples of data types include an integer expressed as a decimal number, or a string of text characters, usually limited in length.

– from [WhatIs.com](https://www.techtarget.com/whatis/definition/variable)

For example, in terms of a scoring system, you could set the value at the start for the score to equal 0. Each time a coin is collected, the score could increase by 10. If the player has 100 points or more, they win and the game ends. If not, the game continues until the player has at least 100 points.

Pseudocode is the act of simulating writing code to illustrate the idea that the code would represent. Pseudocode would show the general structure but does not necessarily follow proper syntax. In these lessons we will periodically use pseudocode to demonstrate the concepts.
In terms of pseudocode, this could look like:

Declare / set variable
var score=0
Award 10 Points for a Gold Coin
Begin Loop
Check Player for Coin
Does player have a gold coin?
If YES, score = score +10
Loop Again
Loop Until the Player has 100 points
Begin Loop
Check Player for Coin
Does player have a gold coin?
If YES, add 10 points to player score and remove the coin
Does player have at least 100 points
If YES, indicate that the player wins
End Game
Loop Again IF the Score is less than 100
Continue running the rest of the program until the player has at least 100 points

Here are several videos that explains variables in the context of coding:

- [CS Principles: Intro to Variables Part 1](https://youtu.be/G41G_PEWFjE)
- [CS Principles: Intro to Variables Part 2](https://youtu.be/ijjVDBPwA1o)

Variables can be used in any coding language, and also environments like Fortnite Creative where you can set up a scenario where a value can change throughout the game.

## Activities

Students will build a treasure hunt in Fortnite Creative. The players will search the island for treasure (coins). The game will end when the player collects a certain number of coins, or when the time runs out. The treasure hunt should incorporate **variables** and **score** to track the value/score based on the number of coins collected.

Refer to the **Teacher Guide** for the step-by-step directions for the activity.

Students should access and work from the **Student Guide**.

### Extension Activities

If time permits, students should attempt the following challenges:

- Add new items that have a different score value.
- Increase the player sprint speed using a Teams & Inventory Device.
- Adjust the game so a single player can complete the goal before time runs out.
- Use a Score Manager device to reset the player score to 0 when collecting a special item.

Refer to the Teacher Guide for the step-by-step directions for the activity.

## EXTERNAL RESOURCES

[Code.org](http://www.code.org)

[Hour of Code](https://hourofcode.com/us)

[CS Principles: Intro to Variables Part 1](https://youtu.be/G41G_PEWFjE)

[CS Principles: Intro to Variables Part 2](https://youtu.be/ijjVDBPwA1o)

[Definition of variables](https://whatis.techtarget.com/definition/variable)

## Standards Mapping

[CSTA Standards for Students](https://csteachers.org/Page/standards)

**1A-AP-09**
Model the way programs store and manipulate data by using numbers or other symbols to represent information.

**1B-AP-09**
Create programs that use variables to store and modify data.

**1B-AP-10**
Create programs that include sequences, events, loops, and conditionals.

**1B-AP-12**
Modify, remix, or incorporate portions of an existing program into one’s own work, to develop something new or add more advanced features.

**1B-AP-15**
Test and debug (identify and fix errors) a program or algorithm to ensure it runs as intended.

**2-AP-1**
Create clearly named variables that represent different data types and perform operations on their values.

**2-AP-10**
Use flowcharts and/or pseudocode to address complex problems as algorithms.

**2-AP-13**
Decompose problems and subproblems into parts to facilitate the design, implementation, and review of programs.

**2-AP-17**
Systematically test and refine programs using a range of test cases.

**3A-AP-13**
Create prototypes that use algorithms to solve computational problems by leveraging prior student knowledge and personal interests.

**3A-AP-16**
Design and iteratively develop computational artifacts for practical intent, personal expression, or to address a societal issue by using events to initiate instructions.

**3A-AP-17**
Decompose problems into smaller components through systematic analysis, using constructs such as procedures, modules, and/or objects.

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
