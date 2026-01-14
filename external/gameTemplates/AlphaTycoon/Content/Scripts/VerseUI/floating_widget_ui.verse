# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /Fortnite.com/UI }
using { /Verse.org/Colors }
using { /Verse.org/Random }

using {Utility}

floating_ui_widgets := struct:
    Root<public> : widget
    ColorBlock<public> : color_block

floating_widget_ui<public> := class:

    CloseUIEvent<public> : event()

    Show<public>(Player : player, Text : string, Bonus : logic):void=
        Color : color = if (Bonus?) then NamedColors.Yellow else NamedColors.White
        spawn:
            MovingWidgetLoop(Player, Text, Color)

    AddWidget<private>(Player : player, Widget : widget):void=
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.AddWidget(Widget, player_ui_slot{ZOrder := 2147483647, InputMode := ui_input_mode.None})

    RemoveWidget<private>(Player : player, Widget : widget):void=
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(Widget)

    CloseUI<public>(Player : player):void=
        CloseUIEvent.Signal()

    CreateFloatingWidget<private>(Text : string, Color : color):floating_ui_widgets=
        ColorBlock := color_block:
            DefaultOpacity := 0.0

        Root := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Top
                    Widget := ColorBlock
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Bottom
                    Widget := 
                        stack_box:
                            Orientation := orientation.Horizontal
                            Slots := array:
                                stack_box_slot:
                                    Widget := texture_block:
                                        DefaultImage := Art.Textures.UI.T_Cube
                                        DefaultDesiredSize := vector2{X := 50.0, Y := 42.0}
                                stack_box_slot:
                                    Widget := text_block:
                                        DefaultTextColor := Color
                                        DefaultTextSize := 50.0
                                        DefaultJustification := text_justification.InvariantRight
                                        DefaultShadowOffset := option{vector2{X := 2.0, Y := 3.0}}
                                        DefaultShadowColor := NamedColors.Black
                                        DefaultShadowOpacity := 1.0
                                        DefaultText := PlainText("+ " +Text)
        floating_ui_widgets:
            ColorBlock := ColorBlock
            Root := Root

    CreateCanvas<private>(Right : float, Bottom : float, Widget : widget):canvas=
        Canvas := canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.5, Y := 0.5}, Maximum := vector2{X := 0.5, Y := 0.5}}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    SizeToContent := false
                    Offsets := margin{Left := 250.0, Right := Right, Top := 0.0, Bottom := Bottom}
                    Widget := Widget

    MovingWidgetLoop<private>(Player : player, Text : string, Color : color)<suspends>:void=
        FloatingWidget := CreateFloatingWidget(Text, Color)
        Column := GetRandomInt(0, 4)
        Row := GetRandomInt(0, 4)
        Right := 400.0 + Column * 250.0
        Bottom := -100.0 + Row * 150.0
        Canvas := CreateCanvas(Right, Bottom, FloatingWidget.Root)
        # Adding/removing widget makes hitch...
        AddWidget(Player, Canvas)
        
        Sleep(0.0)

        race:
            block:
                var YVal : float = 0.0
                loop:
                    set YVal += 1.0
                    FloatingWidget.ColorBlock.SetDesiredSize(vector2{X := 0.0, Y := YVal})
                    Sleep(0.0)
            Sleep(2.0)
            CloseUIEvent.Await()
        
        Canvas.SetVisibility(widget_visibility.Hidden)
        RemoveWidget(Player, Canvas)