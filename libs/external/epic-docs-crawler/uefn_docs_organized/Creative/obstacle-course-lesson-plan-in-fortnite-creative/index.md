# Build an Obstacle Course in Fortnite Creative

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/obstacle-course-lesson-plan-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:09:40.625101

---

[Lesson Plan PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/573fba90-de0a-45ac-855b-75403ac03905/fortnite-creative-obstacle-course-lesson-plan.pdf)[Student Guide PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/26db5c3c-ada1-45d1-8f52-b098c1e2da46/fortnite-creative-obstacle-course-student-guide.pdf)[Teacher Guide PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/e315e982-2208-4ce9-b5a3-6124cb5ebcdd/fortnite-creative-obstacle-course-teacher-guide.pdf)[Lesson Rubric PDF](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/bf1d923a-f0b5-4276-a782-401697a2f9bf/obstacle-course-lesson-plan-rubric.pdf)

## Class Information

- **Grades:** 8–12 (students must be 13 or older to participate in this class)
- **Lesson timeframe:** One hour
- **Featured tool:** Fortnite Creative
- **Class / learning environment:** A Fortnite-capable device with a one-to-one device-to-student ratio, and with internet connectivity. A computer lab or mobile laptop cart should provide the ideal environment.

## Author Contact

Authors: Steven Isaacs and Brian Dickman

Email: steven.isaacs@epicgames.com | brian@cleverlike.com

Twitter: @mr\_isaacs | @cleverlike

LinkedIn: https://www.linkedin.com/in/steve-isaacs/ | https://www.linkedin.com/in/cleverlike

## DESCRIPTION OF CLASS/LEARNING ENVIRONMENT

This lesson is designed for **Hour of Code** during Computer Science Education Week.

This can serve as a stand-alone lesson, or be used in conjunction with the other activities to complete a larger project.

Author Steve Isaacs is the Education Program Manager at Epic Games. In his role he supports secondary educators and students in bringing tools, including Unreal Engine, Fortnite Creative, and Twinmotion, into the classroom. Prior to his role at Epic, Steve taught Game Design and Development in a choice-based learning environment that provided students with opportunities to take different approaches to meeting the learning outcomes based on their interests, in terms of content as well as project options.

Author [Brian Dickman](https://www.linkedin.com/in/cleverlike) studied computer science and operates a full-time game development studio that produces entertaining and educational content inside popular video games.

## Lesson Overview

Obstacle courses have been a great source of entertainment as well as a test of ability since the 1800s. Generally speaking, an obstacle course is a timed competition where the player has to complete a course that has many challenges along the way. The player needs to demonstrate speed, strength, agility, and sometimes a cunning mind to outsmart certain challenges.

Have you ever made your own obstacle course at home, outside, or in school or camp? Have you ever seen any programs or videos of people or animals trying to complete an obstacle course?

You are going to use **Fortnite Creative** to create an entertaining and challenging obstacle course. While creating our course, we will be leveraging the computer programming concepts of collision detection and event-driven design.

READY, SET, BUILD!

## Desired Results

What are the learning outcomes for students?

### ESSENTIAL QUESTIONS/BIG IDEAS

Can students learn computer science concepts as part of a meaningful activity rather than simply learning syntax as an isolated skill?

Will learning computer science concepts like functions through an activity in Fortnite Creative generalize to understanding the concept in a coding environment?

Can students learn computer science concepts through game mechanics?

Will students show more motivation to learn computer science when the concepts are introduced in a game environment?

### Learning Outcomes/Objectives

The student will be able to:

- Demonstrate an understanding of collision detection and events as computer science concepts.
- Apply the understanding of collision, triggers, and events in the context of a game.
- Create an obstacle course with challenges that incorporate the use of collision detection, events, and triggers.

## Learning Activities

### Introduction to Collisions and Events

In computer science, especially games, we are often interested in **collisions** taking place among objects. When an object collides with another action, an event often takes place. Take Pac-Man, for instance. If Pac-Man collides with a dot, the player receives points. If Pac-Man collides with one of the ghosts, the player loses a life. If the ghost is blue because of a power-up, then you earn points by eating the ghost. You get the idea.

In programming, an **event** is an action that occurs as a result of the user or another source, such as a mouse click (or a collision). An event handler is a routine that deals with the event, allowing a programmer to write code that will be executed when the event occurs.

– from [Computer Hope: Event](https://www.computerhope.com/jargon/e/event.htm)

Here is an example showing block-based coding in **MakeCode Arcade**. This game has a player and an ice cream cone. The player moves around the screen trying to eat the ice cream.

[![icecream game from Microsoft MakeCode arcade](https://dev.epicgames.com/community/api/documentation/image/35947f4f-6341-4cdc-970d-2bd59a37c136?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35947f4f-6341-4cdc-970d-2bd59a37c136?resizing_type=fit)

The code (below) indicates that if the Player overlaps (**collides**) with the ice cream (Food), then a series of **events** are **triggered**. In this case, the player receives a point (score changes by 1), the Ice Cream moves to a random position on the game board, and the countdown goes back to 10 seconds, allowing the player to try to get the next ice cream cone.

[![sample code for the icecream game](https://dev.epicgames.com/community/api/documentation/image/8fc89170-1a11-4116-a088-2e2b4009c54d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8fc89170-1a11-4116-a088-2e2b4009c54d?resizing_type=fit)

See the example in action in [CollisionEvent](https://makecode.com/_FhWTvmbzy7Lt), from [Arcade MakeCode](http://arcade.makecode.com).

### Connection: Math and Computer Science

While collision detection may seem like a simple or obvious process, consider this:

[![the physics of collision detection.](https://dev.epicgames.com/community/api/documentation/image/c03a7e2d-f1d4-4a6b-8eff-72e798c59091?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c03a7e2d-f1d4-4a6b-8eff-72e798c59091?resizing_type=fit)

All computer images are rectangle-shaped. If the visible contents of the image do not occupy that entire rectangle, how do we detect collisions? Notice that for the collision in Example A, the images collide, but not the character and obstacle. The desired result shown in Example B is a more challenging concept to implement. Collision detection creates a unique opportunity to explore the applications of geometry and trigonometry.

## Activities

Students will build an obstacle course in Fortnite Creative. The obstacle course should incorporate **collision events** that trigger events in the game.

Refer to the **Teacher Guide** for the step-by-step directions for the activity.

Students should access and work from the **Student Guide** to create their own obstacle course.

## EXTERNAL RESOURCES

[Code.org](http://www.code.org)

[Hour of Code](https://hourofcode.com/us)

[Computer Hope: Event definition](https://www.computerhope.com/jargon/e/event.htm)

[MakeCode Arcade](http://arcade.makecode.com)

[Collision / Event Sample Game](https://makecode.com/_FhWTvmbzy7Lt)

## Standards Mapping

[CSTA Standards for Students](https://csteachers.org/Page/standards)

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
