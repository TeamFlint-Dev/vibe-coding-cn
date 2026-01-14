# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/UI }

timed_widget_ui<public> := class:

    WidgetToShow <public>: widget

    Show<public>(Player:player, ?ShowLength:float = 5.0):void=
        spawn:
            ShowWidget(Player, ShowLength)

    ShowWidget<private>(Player:player, ShowLength:float)<suspends>:void=

        AddWidget(Player)

        Sleep(ShowLength)

        RemoveWidget(Player)

    AddWidget<private>(Player:player):void=
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.AddWidget(WidgetToShow,  player_ui_slot{ZOrder:= 2147483647, InputMode := ui_input_mode.None})

    RemoveWidget<private>(Player:player):void=
        if (PlayerUI := GetPlayerUI[Player]):
            PlayerUI.RemoveWidget(WidgetToShow)