# Widget Types

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/widget-types-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:06:25.515805

---

Widgets are UI elements that you can [add or remove](https://dev.epicgames.com/documentation/en-us/fortnite/creating-and-removing-widgets-in-unreal-editor-for-fortnite) in the UI.

The following sections describe all the widgets you can use to create your custom UI in Verse.

## Canvas

A **canvas** is a container widget. You can position other widgets within the canvas using **canvas slots** to design your UI. When a canvas widget is at the top of the UI hierarchy, it represents the whole screen.

You can nest a canvas widget within another canvas widget, but the root canvas widget is the only one that will encompass the entire screen.

For examples on how to create a canvas widget and how to position widgets on the screen, see [Positioning Widgets on the Screen](https://dev.epicgames.com/documentation/en-us/fortnite/positioning-widgets-on-the-screen-in-unreal-editor-for-fortnite).

## Button

There are three kinds of button widgets you can add to your UI. The difference between each button is only cosmetic.

| UI | Verse Code |
| --- | --- |
| [Button_Loud Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/d4172d94-6d0b-45b0-92d7-21133d6b0753?resizing_type=fit) | ```verse TextForUI<localizes> : message = "Option" Widget := button_loud{DefaultText := TextForUI}``` |
| [Button_Regular Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/d95a3cea-c244-45a6-89a1-21767270155e?resizing_type=fit) | ```verse TextForUI<localizes> : message = "Option" Widget := button_regular{DefaultText := TextForUI}``` |
| [Button_Quiet Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/543f6336-8733-4e43-a2d8-4b53bc2a98e3?resizing_type=fit) | ```verse TextForUI<localizes> : message = "Option" Widget := button_quiet{DefaultText := TextForUI}``` |

See [Making Widgets Interactable](https://dev.epicgames.com/documentation/en-us/fortnite/making-widgets-interactable-in-unreal-editor-for-fortnite) for how to make button interactions.

## Color Block

You can create a widget where you define its color and opacity using the **color\_block** widget.

[![Color Block Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/351287ee-9c80-436a-bdee-b6273ee4bb93?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/351287ee-9c80-436a-bdee-b6273ee4bb93?resizing_type=fit)

```verse
Widget := color_block:
    DefaultColor := NamedColors.CornflowerBlue
    DefaultOpacity := 1.0
    DefaultDesiredSize := vector2{X := 128.0, Y := 128.0}
```

## Image

You can add images to your UI using a [texture](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite#textures) assigned to the **texture\_block** widget.

[![Texture Block Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/b8f48f5e-5d56-42ac-a351-0f0e4cc372a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b8f48f5e-5d56-42ac-a351-0f0e4cc372a7?resizing_type=fit)

```verse
Widget := texture_block:
    DefaultImage := MyTexture
    DefaultDesiredSize := vector2{X := 128.0, Y := 128.0}
```

For how to expose your textures in UEFN to your Verse code, see [Exposing Assets in UEFN to Verse](https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite).

## Slider

You can add sliders so a player can set values in a predefined range. The step size property is how much the value is changed on a controller or keyboard, but it doesn’t affect the step size for a player using a mouse to change the value.

[![Slider Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/0b6fbf0c-f200-4b53-b7ef-d4ad4bf8eef5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0b6fbf0c-f200-4b53-b7ef-d4ad4bf8eef5?resizing_type=fit)

```verse
Widget := slider_regular:
    DefaultValue := 5.0
    DefaultMinValue := 0.0
    DefaultMaxValue := 10.0
    DefaultStepSize := 0.5
```

See [Making Widgets Interactable](https://dev.epicgames.com/documentation/en-us/fortnite/making-widgets-interactable-in-unreal-editor-for-fortnite) for how to make slider interactions.

## Text

To display text in your UI, use the **Text Block**.

[![Text Block Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/a8a3a6dc-1a2e-4d20-900f-96e2dc7261cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a8a3a6dc-1a2e-4d20-900f-96e2dc7261cd?resizing_type=fit)

```verse
TextForUI<localizes> : message = "This is my text!"
Widget := text_block{DefaultText := TextForUI}
```

## Overlay

You can stack widgets on top of each other using an **overlay** widget. The widgets are rendered in the order you specify the overlay slots

[![Overlay Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/41e17688-664f-45d4-ae00-bb9752eb1343?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/41e17688-664f-45d4-ae00-bb9752eb1343?resizing_type=fit)

In the example below, the color block is rendered first, and then the text block is rendered on top of the color block. If you swapped the order of the overlay slots (where the text block is first), the color block would render over the text block, hiding the text.

```verse
TextForUI<localizes>(InText : string) : message = "{InText}"

Widget := overlay:
    Slots := array:
        overlay_slot:
            Widget := color_block:
                DefaultColor := NamedColors.MintCream
                DefaultOpacity := 1.0
                DefaultDesiredSize := vector2{X := 1024.0, Y := 128.0}
        overlay_slot:
            Widget := text_block:
                DefaultText := TextForUI("This is my text block overlaying a color block.")
```

## Stack Box

You can stack widgets vertically or horizontally using a **stack box** widget.

| Vertical Orientation | Horizontal Orientation |
| --- | --- |
| [Vertical Stack Box Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/1be23bcf-9faa-46bf-af07-a03832ed721d?resizing_type=fit) | [Horizontal Stack Box Verse UI Element](https://dev.epicgames.com/community/api/documentation/image/0133a783-580f-4fba-b700-bf643675c424?resizing_type=fit) |
| ```verse MoveText<localizes> : message = "Move" AttackText<localizes> : message = "Attack" CancelText<localizes> : message = "Cancel"  Widget := stack_box:     Orientation := orientation.Vertical     Slots := array:         stack_box_slot:             Widget := button_loud{DefaultText := MoveText}         stack_box_slot:``` | ```verse MoveText<localizes> : message = "Move" AttackText<localizes> : message = "Attack" CancelText<localizes> : message = "Cancel"  Widget := stack_box:     Orientation := orientation.Horizontal     Slots := array:         stack_box_slot:             Widget := button_loud{DefaultText := MoveText}         stack_box_slot:``` |
