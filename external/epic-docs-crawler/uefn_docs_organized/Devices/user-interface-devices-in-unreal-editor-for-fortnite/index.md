# User Interface Devices

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-devices-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:35:37.386578

---

There are a few devices that support using widgets to display a custom UI. The devices featured in the template display UIs in different and specific ways. Each room in the template has information about the devices featured there and how they display a custom UI.

[Playtest](http://playtesting-your-island-in-unreal-editor-for-fortnite) the template to view the UI samples.

[![Room 1 focuses on the HUD Message device and the Pop-Up Dialog device.](https://dev.epicgames.com/community/api/documentation/image/113f0c57-dbec-4979-9082-dc70012a12ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/113f0c57-dbec-4979-9082-dc70012a12ef?resizing_type=fit)

Room 1 focuses on the HUD Message device and the Pop-Up Dialog device.

Below is a table outlining the devices displayed in the template, links to their device pages, and the room numbers where a device can be found:

| Device | Room Number | Device Image |
| --- | --- | --- |
| [HUD Message Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-message-devices-in-fortnite-creative) | 1 | [HUD Message device](https://dev.epicgames.com/community/api/documentation/image/23a60615-1084-4b5e-bfda-dc824b80166d?resizing_type=fit)  HUD Message device |
| [Pop-Up Dialog Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-pop-up-dialog-devices-in-fortnite-creative) | 1 | [Pop-Up Dialog device](https://dev.epicgames.com/community/api/documentation/image/b60b3209-dc10-4dfe-8a8a-e65a785e710b?resizing_type=fit)  Pop-Up Dialog device |
| [HUD Controller Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-hud-controller-devices-in-fortnite-creative) | 2 | [HUD Controller device](https://dev.epicgames.com/community/api/documentation/image/32281108-2b20-4b0f-b16c-6e5b480fd754?resizing_type=fit)  HUD Controller device |
| HUD Controller Device (Quickbar) | 2 | Quickbar description in the UI template. |
| [Stat Creator Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-stat-creator-devices-in-fortnite-creative) | 3 | [Stat Creator device](https://dev.epicgames.com/community/api/documentation/image/c9524ba5-acf1-491b-a15d-6adcad3aabae?resizing_type=fit)  Stat Creator device |
| [Skilled Interaction Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-skilled-interaction-devices-in-fortnite-creative) | 3 | [Skilled Interaction device](https://dev.epicgames.com/community/api/documentation/image/73d7fdd1-aaa7-45c1-8d3d-c480c85b4e9f?resizing_type=fit)  Skilled Interaction device |
| [Timer Device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-timer-devices-in-fortnite-creative) | 3 | Timer device |
| Conversation Device | 4 |  |

## User Widget Types

Almost all devices in the feature template use User Widgets to control the HUD and display a custom UI.

During gameplay, User Widgets display a custom player UI in the HUD when a device is triggered. Devices are bound to UMG Widgets. This means that when a player interacts with a device, the UI updates and displays the updated player information.

There are two different types of User Widgets,  **User Widget** and **Modal Dialog Variant**. Both widget types can use any of the UMG Widgets to create a custom UI.

- A User Widget is the default widget to use when creating a custom UI.
- The Modal Dialog Variant can only be used with the Pop-Up Dialog device.

![UI made with a User Widget and basic UI material.](https://dev.epicgames.com/community/api/documentation/image/a7a45ebd-8e6c-4bf2-9817-12f723d17a4e?resizing_type=fit&width=1920&height=1080)

![UI made with a Modal Dialog Variant widget and textures.](https://dev.epicgames.com/community/api/documentation/image/75e6c342-3799-4a89-8232-741dcbb4278c?resizing_type=fit&width=1920&height=1080)

UI made with a User Widget and basic UI material.

UI made with a Modal Dialog Variant widget and textures.

For example, the **Conversation device** uses a Conversation Bank to build the conversation UI, but you can create a custom look for your conversation UI with a **Modal Dialogue Variant**.

## Verse UI Utilites

Verse UI utilities are a collection of Verse driven user interface (UI) utilities. These utilities control and create a number of different UMG widgets in Verse and use a Verse device to display the UI in the HUD.

In Verse you create a layout using containers such as **Overlays** or **Stack Boxes**, much like you would in the [UMG Editor](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite). Inside these containers, widgets such as `text_block`, `material_block` and `image_block` are used to insert text, materials, or images. These Verse widgets can respond to events in-game, and you can use them with other [Verse widgets](https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite).

The Verse widgets are featured in the back of the second hall, in the second room alongside examples of each widget. The `material_block` widget controls UI materials,  the `text_size` widget controls the UI text size in the `text_block` in the HUD,
and the `player_input` widget maps custom UI elements to the HUD based on keybinds.

| Material Block | Text Size | Player Input |
| --- | --- | --- |
| [A description of the material_block.](https://dev.epicgames.com/community/api/documentation/image/6132c962-0c4c-421b-bd9d-faa19453c5b1?resizing_type=fit)  Click to enlarge image. | [A description of text_size.](https://dev.epicgames.com/community/api/documentation/image/8fc09863-5c6b-4623-86ae-700cd6ea0c1b?resizing_type=fit)  Click to enlarge image. |  |

For more information on using Verse to control widgets, see **[Widget Types](https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite)** and the documents under **[Creating UI with Verse](https://dev.epicgames.com/documentation/en-us/fortnite/creating-ui-with-verse-in-unreal-editor-for-fortnite)**.

All Verse scripts are available in the **User Interfaces Template** project. In **[Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite)**, you can find the following Verse scripted UI files:

- **materialblock\_basic\_device.verse**
- **materialblock\_gameplay\_device.verse**
- **textsize\_device.verse**
- **hud\_keybind\_demo\_device.verse**

### Material Block

A `material_block` is used as one of the slots inside a custom widget created with Verse code. During gameplay, the **material\_block** provides a way for you to manipulate the material parameters through Verse. You can use this to change how the UI material/material instance looks and behaves in the HUD. This is similar to how an `image_block` lets you use a texture in Verse.

A `material_block` is used in a number of ways in the Verse code:

- It provides a way to use material parameters to determine the size, behavior, and look of the material to create more dynamic UI.
- It can pass values from Verse to material parameters, so your materials can update dynamically based on gameplay.

To learn more about using `material_block` in your projects, see the **[Material Block](https://dev.epicgames.com/documentation/en-us/fortnite/material-block-in-fortnite)** document.

### Text Size

The `text_size` property is part of the `text_block` widget provides a way for you to customize the size of text rendered on a player's UI using a `text_block` widget.

In Verse, `text_block` is a type of widget, and is inserted inside a Verse-created widget, and renders a string of text.

The custom `text_size` propety uses Verse code to control the following text attributes:

- Size
- Placement
- Color

### Player Input

Player input is used to listen for player data that informs the code where and when to map UI controls to the HUD based on buttons pressed. In UMG this works when an **Action Widget** is used in a User Widget, the **Enhanced Input Action Field** is linked to an **Input Action** through a keybind.

In the widget, the keybinds are mapped to **Reload**, **Shoot**, **Crouch**, and **Stand**.

[![](https://dev.epicgames.com/community/api/documentation/image/f4b41516-0806-47e1-b368-77e375177588?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4b41516-0806-47e1-b368-77e375177588?resizing_type=fit)

In the template when the widget is added to the player, `Input Mapping` is added in Verse. This automatically ties `Input Actions` to that player so the UMG widget is updated with the correct keybinds for that `Input Action`.

In order to map the UI elements to players, the players are first detected by the Verse code, then `PlayerInput` is used to map the custom UI to the HUD based on the keybinds mapped to:

- **Traversal Mapping**
- **Ranged Weapon Mapping**

[![](https://dev.epicgames.com/community/api/documentation/image/e3999a2a-719c-4f36-9621-22196961be35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3999a2a-719c-4f36-9621-22196961be35?resizing_type=fit)

Next, `PlayerInput.AddInputMapping` is used to map the UMG widget UI to the player’s keybinds for crouching and standing. The UI is mapped to the player through the subscribed event `OnPlayerAdded`. Similarly, the mapping is removed through the subscribed event, `OnPlayerRemoved`.

## UI Samples

Each device has three categories of UI samples:

1. Made with materials.
2. Made with textures.
3. Made with materials and textures.

Walking into the volumes next to the device booth triggers the custom UI to display. The three samples not only showcase what’s possible with UMG, but also the level of detail and design you can put into your own UI. Some volumes cause damage and provide health power-ups. This way, you can see the UI changes in real time.

All of the UI samples can be recreated using the tutorials from the [In-Game User Interfaces section](https://dev.epicgames.com/documentation/en-us/uefn/in-game-user-interfaces-in-unreal-editor-for-fortnite). Below is a list of the sample UI designs, the type of User Widget used to create the UI, and the tutorials that teach how to create a similar UI.

| UI Sample | Widget Type | Tutorial |
| --- | --- | --- |
| **HUD Message** |  |  |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/9cb6ba9b-96ce-4e4a-9580-96c588d44810?resizing_type=fit)  Made with a User Widget. | User Widget | [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/7ec71ed0-406b-4689-9ac6-71ba25f36011?resizing_type=fit)  Made with a User Widget. | User Widget | [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/7af3abf2-5313-4d25-8287-d95f2c80af52?resizing_type=fit)  Made with a User Widget. | User Widget | [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) |
| **Pop-Up Dialog** |  |  |
| [Made with a Modal Dialog Variant.](https://dev.epicgames.com/community/api/documentation/image/9812dfaf-c969-4f73-bc5b-212479e68186?resizing_type=fit)  Made with a Modal Dialog Variant. | Modal Dialog Variant | [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) |
| [Made with a Modal Dialog Variant.](https://dev.epicgames.com/community/api/documentation/image/d946216e-87de-444f-adee-9d0cc39ec2ff?resizing_type=fit)  Made with a Modal Dialog Variant. | Modal Dialog Variant | [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) |
| [Made with a Modal Dialog Variant.](https://dev.epicgames.com/community/api/documentation/image/0884f4b0-1c1f-40dd-af24-b25fc77a7a3f?resizing_type=fit)  Made with a Modal Dialog Variant. | Modal Dialog Variant | [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-pop-ups-in-unreal-editor-for-fortnite) |
| **HUD Controller** |  |  |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/a372f8dd-080f-4450-8f44-af4754deb587?resizing_type=fit)  Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/74d5108b-2f6e-43ff-ba22-cd369e78e757?resizing_type=fit)  Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/e438d875-9566-494e-bcb9-41692e423da1?resizing_type=fit)  Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| Made with a User Widget. | User Widget | [Making a Custom HUD](https://dev.epicgames.com/documentation/en-us/uefn/making-a-custom-hud-in-unreal-editor-for-fortnite) |
| **HUD Controller - Quickbar** |  |  |
| Made with a User Widget. | User Widget |  |
| Made with a User Widget. | User Widget |  |
| Made with a User Widget. | User Widget |  |
| Made with a User Widget. | User Widget |  |
| **Stat Creator** |  |  |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/df79c357-89da-4545-a8c9-5fe1ee18aa78?resizing_type=fit)  Made with a User Widget. | User Widget |  |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/61e0a6cb-6a7d-4074-810d-3351aa6cc296?resizing_type=fit)  Made with a User Widget. | User Widget |  |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/e173d2f5-aaec-4da3-b49f-552228d05f2d?resizing_type=fit)  Made with a User Widget. | User Widget |  |
| **Skilled Interaction** |  |  |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/bec0a61e-936e-4e7d-9a8c-35c03c7e88e5?resizing_type=fit)  Made with a User Widget. | User Widget | [Creating Custom Skilled Interactions](https://dev.epicgames.com/documentation/en-us/uefn/creating-custom-skilled-interactions-in-unreal-editor-for-fortnite) |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/c473a440-ee7b-4a7c-91a4-6be1c02d5b75?resizing_type=fit)  Made with a User Widget. | User Widget | [Creating Custom Skilled Interactions](https://dev.epicgames.com/documentation/en-us/uefn/creating-custom-skilled-interactions-in-unreal-editor-for-fortnite) |
| [Made with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/081739ba-2603-4791-bc7f-b68c5e591dfd?resizing_type=fit)  Made with a User Widget. | User Widget | [Creating Custom Skilled Interactions](https://dev.epicgames.com/documentation/en-us/uefn/creating-custom-skilled-interactions-in-unreal-editor-for-fortnite) |
| **Conversation Device** |  |  |
| [Conversations are created with a COnversation bank, but the style can be altered with a User Widget.](https://dev.epicgames.com/community/api/documentation/image/209c47bb-c332-49bb-ac27-1218c54e20f4?resizing_type=fit)  Made with a Conversation Bank. | Conversation Bank | [Creating Conversations](https://dev.epicgames.com/documentation/en-us/uefn/creating-conversations-in-unreal-editor-for-fortnite) |
| **Timer Device** |  |  |
| Made with a User Widget. | User Widget | [Making an Animated Timer](https://dev.epicgames.com/documentation/en-us/uefn/making-an-animated-timer-in-unreal-editor-for-fortnite) |
| Made with a User Widget. | User Widget | [Making an Animated Timer](https://dev.epicgames.com/documentation/en-us/uefn/making-an-animated-timer-in-unreal-editor-for-fortnite) |
| Made with a User Widget. | User Widget | [Making an Animated Timer](https://dev.epicgames.com/documentation/en-us/uefn/making-an-animated-timer-in-unreal-editor-for-fortnite) |
