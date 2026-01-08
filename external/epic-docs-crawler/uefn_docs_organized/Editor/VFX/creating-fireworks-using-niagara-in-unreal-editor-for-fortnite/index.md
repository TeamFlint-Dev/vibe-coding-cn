# Basic Tutorial: Create a Firework Using Niagara

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-using-niagara-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:19:42.019105

---

This tutorial teaches you to build a basic firework. Through this process, you’ll be introduced to Niagara workflows, modules, and the [Niagara Editor](https://docs.unrealengine.com/editor-ui-reference-for-niagara-effects-in-unreal-engine/).

The following sections take you through the necessary steps for generating a new effect. You will create a custom material, then use an empty emitter to add and edit multiple Emitter Nodes. You will tailor these emitters in each section to create the perfect looking firework.

You cannot skip a section to complete this tutorial, as each step is essential to the final product! Skipping a section will mean that your firework will not behave as expected.

## Overview

Following is an overview of the steps you'll need to recreate this firework effect, and their ideal sequence:

1. Create the firework material and Niagara emitter.
2. Build the firework head.
3. Build the firework trail.
4. Create the firework explosion.
5. Build on the explosion.

## Sections

These sections take you through how to create a firework effect:

[![1. Create the Firework Material and Niagara Emitter](https://dev.epicgames.com/community/api/documentation/image/5af4374f-9f67-46d9-a669-e9d21c86da8f?resizing_type=fit&width=640&height=640)

1. Create the Firework Material and Niagara Emitter

Create a firework material and add Niagara emitters to make your own firework.](<https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-1-create-the-firework-material-and-niagara-emitter-in-unreal-editor-for-fortnite)[![2>. Building the Firework Head](<https://dev.epicgames.com/community/api/documentation/image/ffc0305c-de8d-473d-b69d-5a2c6d0e7f2a?resizing_type=fit&width=640&height=640>)

1. Building the Firework Head

Build the firework head that drives all the parts of the entire firework.](<https://dev.epicgames.com/documentation/en-us/fortnite/2-building-the-firework-head-in-unreal-editor-for-fortnite)[![3>. Building the Firework Trail](<https://dev.epicgames.com/community/api/documentation/image/cd44f663-3786-422d-a36e-847dbe620672?resizing_type=fit&width=640&height=640>)

1. Building the Firework Trail

Learn to create the trail effect on your firework.](<https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-3-building-the-firework-trail-in-unreal-editor-for-fortnite)[![4>. Making the First Firework Explosion](<https://dev.epicgames.com/community/api/documentation/image/0306adcb-495f-4d23-869a-048397b783a5?resizing_type=fit&width=640&height=640>)

1. Making the First Firework Explosion

Make the first part of the firework explosion that creates small sprite particles and colors them.](<https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-4-making-the-first-firework-explosion-in-unreal-editor-for-fortnite)[![5>. Making the Second Firework Explosion](<https://dev.epicgames.com/community/api/documentation/image/d3fb6458-bf9c-4abe-81c9-edab97564b48?resizing_type=fit&width=640&height=640>)

1. Making the Second Firework Explosion

Make the second part of the firework explosion that creates ribbon particles that follow the particles of the first explosion.](<https://dev.epicgames.com/documentation/en-us/fortnite/creating-fireworks-5-making-the-second-firework-explosion-in-unreal-editor-for-fortnite>)
