# Lights and Bridges Puzzle

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-puzzle-in-fortnite>
> **爬取时间**: 2025-12-27T00:43:15.516875

---

Puzzles make up a core [gameplay](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#gameplay) mechanic that challenges players, guides them along prescribed paths, and encourages interaction on a deeper level.

**Scene Graph** provides an ideal foundation for building modular puzzles with entities, components, and the composition of both of these, prefabs. You will create new Scene Graph components in Verse to construct the building blocks for [modular](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#modularity) puzzles built with Scene Graph, put these building blocks together into reusable composite [prefabs](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#prefab), then build out different puzzles with these prefabs.

This tutorial guides you from start to finish, through designing the structure of your Verse code, implementing the behavior of objects through custom Scene Graph components in Verse, constructing reusable [entity](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#entity) and [component](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#component) [hierarchies](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#hierarchical) with Scene Graph prefabs, then building out custom interactable gameplay in UEFN.

This tutorial starts with several built-in pieces from Scene Graph, including:

- Scene Graph entities
- Scene Graph components

  - `mesh_component`
  - `sphere_light_component`
  - `keyframed_movement_component`
- Scene events

Expanding upon these building blocks, you will build:

- New Scene Graph components:

  - `triggerable_mesh_component`: Toggle mesh visibility based on an external action.
  - `triggerable_light_component`: Toggle light based on an external action.
  - `triggerable_movement_component`: Move an entity based on an external action.
  - `puzzle_component`: Puzzle manager component for puzzle built with Scene Graph entities and components.
  - `trigger_component`: Scene Graph component that triggers `triggerable` components.
- New Scene Graph scene events:

  - `puzzle_solved_event`: Notify other components that a puzzle is solved.
  - `triggered_event`: Notify other components that a triggerable component is triggered.
- Scene Graph prefabs based on built-in and custom components.

The following videos represent examples of what you can build with building blocks in this tutorial — a puzzle with triggerable lights, and a bridge that transforms to allow the player to traverse a vast chasm.

It's a puzzle of triggerable platforms, some of which are solid, while others are treacherously not solid. Choose your steps wisely!

## Get Started

To begin, open **Unreal Editor for Fortnite (UEFN)** and create a new project using the **Caldera Island template**. This template comes with a volcanic island and some design elements for s.

[![Select the Caldera Island template from the Project Browser.](https://dev.epicgames.com/community/api/documentation/image/17c50088-2326-48b0-9b7a-6355fe93a0de?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/17c50088-2326-48b0-9b7a-6355fe93a0de?resizing_type=fit)

## Overview

This project builds upon Scene Graph and various Verse concepts. For introductory information about Scene Graph Entities and Components, see the following before you get started:

- [Working with Entities and Components](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-entities-and-components-in-unreal-editor-for-fortnite)
- [Creating Your Own Component Using Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-your-own-component-using-verse-in-unreal-editor-for-fortnite)

After creating your project, follow these steps to create the Lights and Bridges Puzzle island:

[![Triggerable Interface and Scene Events](https://dev.epicgames.com/community/api/documentation/image/11f93677-fe29-4e5f-bbd2-958130931e68?resizing_type=fit&width=640&height=640)

Triggerable Interface and Scene Events

Create a common interface for triggerable puzzle components to use and scene events to signal them.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-01-triggerable-interface-and-scene-events-in-fortnite)[![Puzzle> Component](<https://dev.epicgames.com/community/api/documentation/image/61901627-bfdb-4c36-8fb8-58b699704a05?resizing_type=fit&width=640&height=640>)

Puzzle Component

Create a puzzle manager component to determine whether a puzzle is solved.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-02-puzzle-component-in-fortnite)[![Trigger> Component and Triggerable Child Classes](<https://dev.epicgames.com/community/api/documentation/image/5a4a1239-b1b0-4070-9bec-ba18edcee333?resizing_type=fit&width=640&height=640>)

Trigger Component and Triggerable Child Classes

Create a component that triggers triggerable Scene Graph entities.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-03-trigger-component-and-triggerable-child-classes-in-fortnite)[![Construct> Prefabs](<https://dev.epicgames.com/community/api/documentation/image/cd954b45-6d15-46ef-aa02-89147073df3c?resizing_type=fit&width=640&height=640>)

Construct Prefabs

Use the previously defined components to construct prefabs and create a puzzle.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-04-construct-prefabs-in-fortnite)[![Create> a Puzzle with Prefabs](<https://dev.epicgames.com/community/api/documentation/image/e63ed803-be82-4bdf-836a-a024b334a2ee?resizing_type=fit&width=640&height=640>)

Create a Puzzle with Prefabs

Use prefabs to construct a puzzle experience.](<https://dev.epicgames.com/documentation/en-us/fortnite/lights-and-bridges-05-create-a-puzzle-with-prefabs-in-fortnite>)
