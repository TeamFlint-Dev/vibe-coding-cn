# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { Data }
using { /Verse.org/SceneGraph }
using { UIData }
using { Utility }

harvester_ui_widget := struct:
    Canvas<public>:canvas

    Background_Texture_Widget<public>:texture_block

    Harvester_Icon_Texture_Widget<public>:texture_block
    Upgraded_Harvester_Icon_Texture_Widget<public>:texture_block
    Resource_Icon_Texture_Widget<public>:texture_block

    Harvester_Level_Text<public>:text_block
    Current_Rate_Text<public>:text_block
    Current_Storage_Text<public>:text_block

    Upgraded_Harvester_Level_Text<public>:text_block
    Upgraded_Rate_Text<public>:text_block
    Upgraded_Storage_Text<public>:text_block
    Cost_Text<public>:text_block
    Second_Resource_Icon_Texture_Widget<public>:texture_block

    Resources_Banked_Text<public>:text_block

    Close_Button<public>:button
    Collect_Button<public>:button_regular
    Upgrade_Button<public>:button_regular

harvester_upgrade_ui<public> := class():

    SimEntity <public> : entity

    # Stores the created harvester UI for each player.
    var UIMap:[player]harvester_ui_widget = map{}

    # Stores the created harvester ID for each player.
    var CurrentHarvesterIDForPlayer:[player]int = map{}

    # More than one users can be viewing this popup at the same time
    # store all the viewers to update the passive upgrade information.
    var CurrentViewers: []player = array{}

    # Creates UI and stores data for the player.
    PlayerAdded<public>(Player:player):void=
        UIResult := CreateUI()

        if:
            set UIMap[Player] = UIResult

    # Removed UI data from the Harvester.
    PlayerRemoved(Player:player):void=
        NewUIMap := UIMap.RemoveKey(Player)
        set UIMap = NewUIMap
        CloseUI(Player)

    CreateTextBlock(String:string, TextSize:float):text_block=
        NewText := text_block:
            DefaultTextColor:= NamedColors.White
            DefaultTextSize := TextSize
            DefaultJustification:= text_justification.InvariantRight
            DefaultShadowOffset:= option{vector2{X := 2.0, Y := 3.0}}
            DefaultShadowColor:= NamedColors.Black
            DefaultShadowOpacity := 1.0
            DefaultText := PlainText(String)

    CreateButton(?String:string):button_regular=
        button_regular{DefaultText := PlainText(String)}

    # Creates a UI for the player.
    CreateUI():harvester_ui_widget=
        Background_Texture_Widget := texture_block:
            DefaultImage := Art.Textures.UI.T_background_01
            DefaultDesiredSize := vector2{X := 1024.0, Y := 1024.0}

        Harvester_Icon_Texture_Widget := texture_block:
            DefaultImage := Art.Textures.UI.T_harvester
            DefaultDesiredSize := vector2{X := 375.0, Y := 375.0}

        Upgraded_Harvester_Icon_Texture_Widget := texture_block:
            DefaultImage := Art.Textures.UI.T_upgrade_icon
            DefaultDesiredSize := vector2{X := 200.0, Y := 200.0}

        Resource_Icon_Texture_Widget := texture_block:
            DefaultImage := Art.Textures.UI.T_Cube
            DefaultDesiredSize := vector2{X := 50.0, Y := 42.0}

        Second_Resource_Icon_Texture_Widget := texture_block:
            DefaultImage := Art.Textures.UI.T_Cube
            DefaultDesiredSize := vector2{X := 50.0, Y := 42.0}

        Harvester_Level_Text := CreateTextBlock("Level 0 Harvester", 50.0)

        Current_Rate_Text := CreateTextBlock("Cubes per Cycle: ", 26.0)

        Current_Storage_Text := CreateTextBlock("Max Storage: ", 26.0)

        Upgraded_Harvester_Level_Text := CreateTextBlock("Level 0 Harvester", 35.0)

        Upgraded_Rate_Text := CreateTextBlock("Cubes per Cycle: ", 26.0)

        Upgraded_Storage_Text := CreateTextBlock("Max Storage: ", 26.0)

        Cost_Text := CreateTextBlock("Cost: ", 28.0)

        Resources_Banked_Text := CreateTextBlock("0/Cap", 28.0)

        Collect_Button_Icon := texture_block:
            DefaultImage := Art.Textures.UI.T_button_01
            DefaultDesiredSize := vector2{X := 243.0, Y := 89.0}

        Upgrade_Button_Icon := texture_block:
            DefaultImage := Art.Textures.UI.T_button_01
            DefaultDesiredSize := vector2{X := 243.0, Y := 89.0}

        Collect_Button := button_regular{DefaultText := PlainText("Collect")}

        Upgrade_Button := button_regular{DefaultText := PlainText("Upgrade")}

        Close_Button:button = button{
            Slot := button_slot:
                Widget := texture_block:
                    DefaultImage := Art.Textures.UI.T_close_01
                    DefaultDesiredSize := vector2{X := 92.0, Y := 93.0}
        }

        Stack_Box_Current := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Fill
                    Widget := Current_Rate_Text
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Fill
                    Widget := Current_Storage_Text

        Stack_Box_Upgrade := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Fill
                    Widget := Upgraded_Rate_Text
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Fill
                    Widget := Upgraded_Storage_Text

        Stack_Box_Banked := stack_box:
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Center
                    VerticalAlignment := vertical_alignment.Center
                    Widget := Resources_Banked_Text
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Center
                    VerticalAlignment := vertical_alignment.Center
                    Widget := Resource_Icon_Texture_Widget

        Stack_Box_Cost := stack_box:
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Center
                    VerticalAlignment := vertical_alignment.Center
                    Widget := Cost_Text
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Center
                    VerticalAlignment := vertical_alignment.Center
                    Widget := Second_Resource_Icon_Texture_Widget

        Canvas := canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := 0.0, Left := 250.0, Right := 880.0, Bottom := 880.0}
                    Alignment := vector2{X := 0.5, Y := 0.5}
                    ZOrder := 0
                    SizeToContent := true
                    Widget := Background_Texture_Widget

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := -400.0, Left := 90.0, Right := 100.0, Bottom := 30.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Harvester_Level_Text

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := -300.0, Left := -80.0, Right := 100.0, Bottom := 100.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Harvester_Icon_Texture_Widget

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := 84.0, Left := -20.0, Right := 100.0, Bottom := 100.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Upgraded_Harvester_Icon_Texture_Widget

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := -215.0, Left := 320.0, Right := 100.0, Bottom := 30.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Stack_Box_Current

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := -125.0, Left := 340.0, Right := 195.0, Bottom := 90.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    ZOrder := 2
                    SizeToContent := true
                    Widget := Collect_Button

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := -25.0, Left := 365.0, Right := 100.0, Bottom := 30.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Stack_Box_Banked

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := 70.0, Left := 290.0, Right := 100.0, Bottom := 30.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Upgraded_Harvester_Level_Text

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := 130.0, Left := 320.0, Right := 100.0, Bottom := 30.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Stack_Box_Upgrade

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := 225.0, Left := 340.0, Right := 195.0, Bottom := 90.0}
                    ZOrder := 2
                    SizeToContent := true
                    Widget := Upgrade_Button

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := 325.0, Left := 365.0, Right := 100.0, Bottom := 30.0}
                    ZOrder := 1
                    SizeToContent := true
                    Widget := Stack_Box_Cost

                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.50}, Maximum := vector2{X := 0.50, Y := 0.50}}
                    Offsets := margin{Top := -460.0, Left := 520.0, Right := 100.0, Bottom := 30.0}
                    Alignment := vector2{X := 0.0, Y := 0.0}
                    ZOrder := 2
                    SizeToContent := true
                    Widget := Close_Button

        # Subscribes get notified when the player clicks on the buttons.
        Collect_Button.OnClick().Subscribe(OnCollectResource)
        Upgrade_Button.OnClick().Subscribe(OnUpgradeButton)
        Close_Button.OnClick().Subscribe(OnCloseButton)

        return harvester_ui_widget:

            Canvas := Canvas

            Background_Texture_Widget := Background_Texture_Widget

            Harvester_Icon_Texture_Widget := Harvester_Icon_Texture_Widget
            Upgraded_Harvester_Icon_Texture_Widget := Upgraded_Harvester_Icon_Texture_Widget
            Resource_Icon_Texture_Widget := Resource_Icon_Texture_Widget

            Harvester_Level_Text := Harvester_Level_Text
            Current_Rate_Text := Current_Rate_Text
            Current_Storage_Text := Current_Storage_Text

            Upgraded_Harvester_Level_Text  := Upgraded_Harvester_Level_Text
            Upgraded_Rate_Text := Upgraded_Rate_Text
            Upgraded_Storage_Text := Upgraded_Storage_Text
            Cost_Text := Cost_Text
            Second_Resource_Icon_Texture_Widget := Second_Resource_Icon_Texture_Widget

            Resources_Banked_Text := Resources_Banked_Text

            Close_Button := Close_Button
            Collect_Button := Collect_Button
            Upgrade_Button := Upgrade_Button

    # Shows the UI to the player, only this player can see the UI.
    ShowUI<public>(UI_Data:harvester_ui_data, Player:player):void=
        if:
            HarvesterUI := UIMap[Player]
            PlayerUI := GetPlayerUI[Player]
            set CurrentHarvesterIDForPlayer[Player] = UI_Data.HarvesterId
            set CurrentViewers += array{Player}
        then:
            # Updates the UI prior to showing the UI to the player.
            UpdateUI(UI_Data, Player)
            PlayerUI.AddWidget(HarvesterUI.Canvas,  player_ui_slot{ZOrder:= 0, InputMode := ui_input_mode.All})

    # Update the UI for the player.
    UpdateUI<public>(UI_Data:harvester_ui_data, Player :player):void=
        UpdateCurrentHarvesterInfo(UI_Data, Player)
        UpdateNextHarvesterInfo(UI_Data, Player)

    # Close the UI for the player.
    CloseUI<public>(Player:player):void=
        if:
            HarvesterUI := UIMap[Player]
            PlayerUI := GetPlayerUI[Player]
            HarvesterID := CurrentHarvesterIDForPlayer[Player]
        then:
            PlayerUI.RemoveWidget(HarvesterUI.Canvas)

        if (IndexToRemove := CurrentViewers.Find[Player], TempArray := CurrentViewers.RemoveElement[IndexToRemove]):
            set CurrentViewers = TempArray

    # When the player clicks the upgrade button,
    # sends a event to the harvester with the corresponding ID and attemps to upgrades the harvester.
    OnUpgradeButton(Message:widget_message):void=
        if (HarvesterId := CurrentHarvesterIDForPlayer[Message.Player]):
            SimEntity.SendDown(Components.upgrade_event{Id := HarvesterId, Player := Message.Player})

    # When the player clicks the collect button,
    # sends a event to the harvester with the corresponding ID and attemps to collect the resources banked.
    OnCollectResource(Message:widget_message):void=
        if (HarvesterId := CurrentHarvesterIDForPlayer[Message.Player]):
            SimEntity.SendDown(Components.collect_resource_event{Id := HarvesterId, Player := Message.Player})

    # When the player clicks the close button, close the UI.
    OnCloseButton(Message:widget_message):void=
        CloseUI(Message.Player)
    
    # Update the info of the current harvester stats.
    UpdateCurrentHarvesterInfo<public>(UI_Data:harvester_ui_data, Player:player):void=
        if:
            HarvesterUI := UIMap[Player]
        then:
            HarvesterUI.Harvester_Level_Text.SetText(PlainText("Level {UI_Data.Harvester_Level} Harvester"))
            HarvesterUI.Current_Rate_Text.SetText(PlainText("Cubes per Cycle: {UI_Data.Current_Rate}"))
            HarvesterUI.Current_Storage_Text.SetText(PlainText("Max Storage: {UI_Data.Current_Storage}"))
            HarvesterUI.Resources_Banked_Text.SetText(PlainText("{UI_Data.Resources_Banked}/{UI_Data.Current_Storage}"))

    # Update the info for thext potential upgrade for the harvester if possible.
    UpdateNextHarvesterInfo<public>(UI_Data:harvester_ui_data, Player:player):void=
        if:
            HarvesterUI := UIMap[Player]
            UpgradeCost := ToLargeNumber[UI_Data.Cost]
        then:

            # Determines if there is another available upgrade, if not hide the upgrade display.
            if (UI_Data.Next_Level >= 4):
                HideNextHarvesterInfoVisibility(HarvesterUI, true)
            else:
                HarvesterUI.Upgraded_Harvester_Level_Text.SetText(PlainText("Level {UI_Data.Next_Level} Harvester"))
                HarvesterUI.Upgraded_Rate_Text.SetText(PlainText("Cubes per Cycle: {UI_Data.Next_Rate}"))
                HarvesterUI.Upgraded_Storage_Text.SetText(PlainText("Max Storage: {UI_Data.Next_Storage}"))
                HarvesterUI.Cost_Text.SetText(PlainText("Cost: {UpgradeCost}"))
                HideNextHarvesterInfoVisibility(HarvesterUI, false)

    # Hids or displays the next available upgrade for the harvester.
    HideNextHarvesterInfoVisibility(HarvesterUI:harvester_ui_widget, Hide:logic):void=

        Visibility := if (Hide?){widget_visibility.Hidden} else{widget_visibility.Visible}

        HarvesterUI.Upgraded_Harvester_Level_Text.SetVisibility(Visibility)
        HarvesterUI.Upgraded_Rate_Text.SetVisibility(Visibility)
        HarvesterUI.Upgraded_Storage_Text.SetVisibility(Visibility)
        HarvesterUI.Cost_Text.SetVisibility(Visibility)
        HarvesterUI.Upgrade_Button.SetVisibility(Visibility)
        HarvesterUI.Second_Resource_Icon_Texture_Widget.SetVisibility(Visibility)

    # Determines which player is currently interacting with the harvester and updates the displayed about of resources banked.
    UpdatePassiveIncomeUI<public>(UI_Data:harvester_ui_data):void=

        for (Player : CurrentViewers, UI_Data.HarvesterId = CurrentHarvesterIDForPlayer[Player], HarvesterUI := UIMap[Player]):
            HarvesterUI.Resources_Banked_Text.SetText(PlainText("{UI_Data.Resources_Banked}/{UI_Data.Current_Storage}"))