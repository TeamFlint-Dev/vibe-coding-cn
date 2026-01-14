# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { Utility }
using { Data }
using { Components }

player_upgrade_ui_widgets := struct:
    Canvas<public>:canvas

    UpgradeEntries<public> : []upgrade_entry_widgets
    UpgradeDescriptionText<public> : text_block
    UpgradeCostText<public> : text_block

    StopEvent<public>:event()

cost_widget := struct:
    Root<public> : widget
    Text<public> : text_block

info_text_widget := struct:
    Root<public> : widget
    Text<public> : text_block

upgrade_entry_widgets := struct:
    Root<public> : widget
    Button<public> : button_regular
    InfoText<public> : text_block

player_upgrade_ui<public> := class:

    SimEntity <public> : entity

    # Stores each players created upgrade UI
    var UIMap:[player]player_upgrade_ui_widgets = map{}
    var PlayerDataMap:[player]player_info = map{}
    var WidgetAddedMap:[player]logic = map{}

    var LastSelectedTab : storage_key = storage_key.PlayerStrength
    var MaybeTycoonDataStorageComponent<public> : ?Components.tycoon_data_storage_component = false

    UpgradeDescriptions : [storage_key]string = map{
        storage_key.PlayerEfficiency => "Efficiency:\nEnhance your gathering system\n(+ Collection per Hit)"
        storage_key.PlayerStrength => "Strength:\nSharpen up your pickaxe\n(+ Damage)"
        storage_key.PlayerBonus => "Bonus:\nGet better resource nodes\n(+ Resource per destroyed node)"
    }

    # Creates UI and stores data for the player
    PlayerAdded<public>(Player:player):void=
        if (not MaybeTycoonDataStorageComponent?):
            set MaybeTycoonDataStorageComponent = option{ for (Child : SimEntity.FindDescendantComponents(tycoon_data_storage_component)){Child}[0] }

        UIResult := CreateUI()

        if:
            not UIMap[Player]
            set UIMap[Player] = UIResult

    # Removed UI data from the player
    PlayerRemoved<public>(Player:player):void=
        NewUIMap := UIMap.RemoveKey(Player)
        NewPlayerDataMap := PlayerDataMap.RemoveKey(Player)

        set UIMap = NewUIMap
        set PlayerDataMap = NewPlayerDataMap

    CreateDefaultTextWidget(Text : string, Size : float):text_block=
        text_block:
            DefaultTextColor := NamedColors.White
            DefaultJustification := text_justification.Center
            DefaultShadowOffset := option{vector2{X := 2.0, Y := 3.0}}
            DefaultShadowColor := NamedColors.Black
            DefaultShadowOpacity := 1.0
            DefaultText := PlainText(Text)
            DefaultTextSize := Size
    
    CreateUpgradeEntry(Text : string):upgrade_entry_widgets=
        InfoText := CreateInfoText()
        StatButton := CreateRegularButton(Text)

        Root := stack_box:
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    Widget := StatButton
                    Distribution := option{1.0}
                    HorizontalAlignment := horizontal_alignment.Fill
                    VerticalAlignment := vertical_alignment.Fill
                stack_box_slot:
                    Widget := InfoText.Root
                    HorizontalAlignment := horizontal_alignment.Right
                    VerticalAlignment := vertical_alignment.Fill
                    Padding := margin{Left := 24.0}

        upgrade_entry_widgets:
            Root := Root
            InfoText := InfoText.Text
            Button := StatButton

    CreateRegularButton(Text : string):button_regular=
        button_regular{DefaultText := PlainText(Text)}

    CreateInfoText():info_text_widget=
        Text := CreateDefaultTextWidget("#/#", 36.0)
        Root :=
            overlay:
                Slots := array:
                    overlay_slot:
                        Widget := texture_block:
                            DefaultImage := Art.Textures.UI.T_button_04
                            DefaultDesiredSize := vector2{X := 211.0, Y := 80.0}
                    overlay_slot:
                        Widget := Text

        info_text_widget:
            Root := Root
            Text := Text
    
    CreateCostWidget():cost_widget=
        Text := Widget := CreateDefaultTextWidget("###", 38.0)

        Root := stack_box:
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    Widget := Text
                    VerticalAlignment := vertical_alignment.Center
                    HorizontalAlignment := horizontal_alignment.Left
                stack_box_slot:
                    Widget := texture_block:
                        DefaultImage := GetCurrencyTexture(currency.Cube)
                        DefaultDesiredSize := vector2{ X := 64.0, Y := 64.0 }
                    VerticalAlignment := vertical_alignment.Center
                    HorizontalAlignment := horizontal_alignment.Right

        cost_widget :
            Root := Root
            Text := Text

    CreateUI():player_upgrade_ui_widgets=
        # Main window
        BackgroundTextureWidget := texture_block:
            DefaultImage := Art.Textures.UI.T_background_03
            DefaultDesiredSize := vector2{X := 1067.0, Y := 795.0}

        WindowTitleTextWidget := CreateDefaultTextWidget("Upgrade Shop", 48.0)

        ExitButton := button:
            Slot := button_slot:
                Widget := texture_block:
                    DefaultImage := Art.Textures.UI.T_close_01
                    DefaultDesiredSize := vector2{X := 96.0, Y := 96.0}
                HorizontalAlignment := horizontal_alignment.Fill
                VerticalAlignment := vertical_alignment.Fill
        # Details panel
        DescriptionTextWidget := CreateDefaultTextWidget("Upgrade description here", 32.0)

        UpgradeButton := button_loud{DefaultText := PlainText("Upgrade")}
        CostWidget := CreateCostWidget()
        CurrencyTexture := GetCurrencyTexture(currency.Cube)
        
        UpgradePanel := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    Widget := texture_block:
                        DefaultImage := CurrencyTexture
                        DefaultDesiredSize := vector2{ X := 225.0, Y := 225.0 }
                    VerticalAlignment := vertical_alignment.Top
                    HorizontalAlignment := horizontal_alignment.Center
                stack_box_slot:
                    Widget := CostWidget.Root
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Center
                stack_box_slot:
                    Widget := UpgradeButton
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Center

        # Upgrade panel
        PlayerUpgradesTextWidget := CreateDefaultTextWidget("Player Upgrades", 38.0)
        StrengthEntry := CreateUpgradeEntry("Strength")
        EfficiencyEntry := CreateUpgradeEntry("Efficiency")
        BonusEntry := CreateUpgradeEntry("Bonus")

        StatsList := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin{Top := 12.0, Bottom := 12.0}
                    Widget := StrengthEntry.Root
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin{Top := 12.0, Bottom := 12.0}
                    Widget := EfficiencyEntry.Root
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin{Top := 12.0, Bottom := 12.0}
                    Widget := BonusEntry.Root

        StatsPanel := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Top
                    HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin{Top := 12.0}
                    Widget := PlayerUpgradesTextWidget
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Bottom
                    HorizontalAlignment := horizontal_alignment.Fill
                    Distribution := option{1.0}
                    Widget := StatsList

        UpgradeLayout := stack_box:
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Distribution := option{0.6}
                    Widget := StatsPanel
                stack_box_slot:
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Distribution := option{0.4}
                    Widget := UpgradePanel

        WindowLayout := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    Widget := WindowTitleTextWidget
                    VerticalAlignment := vertical_alignment.Center
                    HorizontalAlignment := horizontal_alignment.Fill
                    Distribution := option{0.32}
                stack_box_slot:
                    Widget := UpgradeLayout
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin{Top := 12.0, Bottom := 12.0}
                    Distribution := option{1.0}
                stack_box_slot:
                    Widget := DescriptionTextWidget
                    VerticalAlignment := vertical_alignment.Fill
                    HorizontalAlignment := horizontal_alignment.Fill
                    Padding := margin{Top := 12.0}
                    Distribution := option{0.34}

        Canvas := canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 0.50, Y := 0.1}, Maximum := vector2{X := 0.50, Y := 0.1}}
                    Alignment := vector2{X := 0.20, Y := 0.0}
                    SizeToContent := true
                    Widget := overlay:
                        Slots := array:
                            overlay_slot:
                                HorizontalAlignment := horizontal_alignment.Fill
                                VerticalAlignment := vertical_alignment.Fill
                                Widget := BackgroundTextureWidget
                            overlay_slot:
                                HorizontalAlignment := horizontal_alignment.Fill
                                VerticalAlignment := vertical_alignment.Fill
                                Padding := margin{Top := 48.0, Bottom := 72.0, Left := 72.0, Right := 72.0}
                                Widget := WindowLayout
                            overlay_slot:
                                HorizontalAlignment := horizontal_alignment.Right
                                VerticalAlignment := vertical_alignment.Top
                                Padding := margin{Top := 40.0, Right := 64.0}
                                Widget := ExitButton

        StrengthEntry.Button.OnClick().Subscribe(OnChangeCategoryButton)
        EfficiencyEntry.Button.OnClick().Subscribe(OnChangeCategoryButton)
        BonusEntry.Button.OnClick().Subscribe(OnChangeCategoryButton)

        UpgradeButton.OnClick().Subscribe(OnUpgradeButton)
        ExitButton.OnClick().Subscribe(OnExitButton)

        return player_upgrade_ui_widgets:
            Canvas := Canvas
            UpgradeDescriptionText := DescriptionTextWidget
            UpgradeCostText := CostWidget.Text
            UpgradeEntries := array{ StrengthEntry, EfficiencyEntry, BonusEntry }
            StopEvent := event(){}

    # Shows the UI to the player, only this player can see the UI
    ShowUI<public>(Player:player):void=
        if:
            PlayerInfo:= Player.GetPlayerInfo[]
            set PlayerDataMap[Player] = PlayerInfo
            PlayerUpgradeUI := UIMap[Player]
            PlayerUI := GetPlayerUI[Player]
            not WidgetAddedMap[Player]?
        then:
            UpdateUI(Player)
            PlayerUI.AddWidget(PlayerUpgradeUI.Canvas, player_ui_slot{ZOrder := 0, InputMode := ui_input_mode.All})
            if (set WidgetAddedMap[Player] = true):

    # Close the UI for the player
    CloseUI<public>(Player:player):void=
        if:
            PlayerUpgradeUI := UIMap[Player]
            PlayerUI := GetPlayerUI[Player]
        then:
            PlayerUpgradeUI.StopEvent.Signal()
            PlayerUI.RemoveWidget(PlayerUpgradeUI.Canvas)
            if (set WidgetAddedMap[Player] = false):

    OnUpgradeButton(Message:widget_message):void=
        Player := Message.Player
        PlayerStats := Player.GetPlayerInfo[].PlayerStats or player_stats{}
        StatValue := PlayerStats.GetValue(LastSelectedTab)

        if:
            TycoonDataStorageComponent := MaybeTycoonDataStorageComponent?
            Cost := TycoonDataStorageComponent.GetCost[LastSelectedTab, StatValue-1]
        then:
            if (not Player.HasResource[Cost]):
                SendDown(TycoonDataStorageComponent.Entity, Components.show_not_enough_currency_ui_event{Player := Player})
                return

            if:
                Player.SpendResource[Cost]
                Player.IncreaseStat[LastSelectedTab]
                PlayerUpgradeUI := UIMap[Player]
            then:
                FillStatData(Player, PlayerUpgradeUI)
                var UpgradeCostText : string = ""

                if (NextCost := TycoonDataStorageComponent.GetCost[LastSelectedTab, StatValue]):
                    set UpgradeCostText = "{NextCost.Amount}"
                else:
                    set UpgradeCostText = "Fully upgraded"

                PlayerUpgradeUI.UpgradeCostText.SetText(PlainText("{UpgradeCostText}"))
                SendDown(TycoonDataStorageComponent.Entity, Components.update_resource_ui_event{Player := Player})

    OnChangeCategoryButton(Message:widget_message):void=
        var StorageKey : storage_key = storage_key.Invalid
        if (Button := button_regular[Message.Source]):
            set StorageKey = ToStorageKey(Button.GetText())

        var PlayerStats : player_stats = player_stats{}
        if (PlayerInfo := Message.Player.GetPlayerInfo[]):
            set PlayerStats = PlayerInfo.PlayerStats

        StatValue := PlayerStats.GetValue(StorageKey)
        if (PlayerUpgradeUI := UIMap[Message.Player]):
            FillDescriptionData(Message.Player, PlayerUpgradeUI, StorageKey, StatValue)
    
    FillDescriptionData(Player : player, PlayerUpgradeUI : player_upgrade_ui_widgets, Category : storage_key, Value : int):void=
        if:
            Cost := MaybeTycoonDataStorageComponent?.GetCost[Category, Value-1]
            Description := UpgradeDescriptions[Category]
        then:
            PlayerUpgradeUI.UpgradeDescriptionText.SetText(PlainText(Description))
            PlayerUpgradeUI.UpgradeCostText.SetText(PlainText("{Cost.Amount}"))

        set LastSelectedTab = Category

    FillStatData(Player : player, PlayerUpgradeUI : player_upgrade_ui_widgets):void=
        var Index : int = 1
        var PlayerStats : player_stats = player_stats{}

        if (PlayerInfo := Player.GetPlayerInfo[]):
            set PlayerStats = PlayerInfo.PlayerStats

        if (Entry := PlayerUpgradeUI.UpgradeEntries[0]):
            Entry.InfoText.SetText(PlainText("{PlayerStats.Strength-1} / {5}"))

        if (Entry := PlayerUpgradeUI.UpgradeEntries[1]):
            Entry.InfoText.SetText(PlainText("{PlayerStats.Efficiency-1} / {5}"))

        if (Entry := PlayerUpgradeUI.UpgradeEntries[2]):
            Entry.InfoText.SetText(PlainText("{PlayerStats.Bonus-1} / {5}"))

    OnExitButton(Message:widget_message):void=
        CloseUI(Message.Player)

    # Updates the UI for selected player
    UpdateUI(Player:player):void=
        if:
            PlayerUpgradeUI := UIMap[Player]
            PlayerStats := Player.GetPlayerInfo[].PlayerStats
        then:
            FillStatData(Player, PlayerUpgradeUI)
            StatValue := PlayerStats.GetValue(LastSelectedTab)
            FillDescriptionData(Player, PlayerUpgradeUI, LastSelectedTab, StatValue)
