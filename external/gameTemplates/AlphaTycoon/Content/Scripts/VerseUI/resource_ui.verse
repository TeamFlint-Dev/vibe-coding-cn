# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
using { /Verse.org/Colors }
using { /Verse.org/Simulation }
using { Utility }
using { Data }

# Contains all widgets relevant for showing, closing and updating the UI.
resource_ui_widgets := struct:
    Canvas<public>:canvas

    CircleTextWidget<public>:text_block
    CircleTextureWidget<public>:texture_block

    CubeTextWidget<public>:text_block
    CubeTextureWidget<public>:texture_block

    PyramidTextWidget<public>:text_block
    PyramidTextureWidget<public>:texture_block

    StopEvent<public>:event()

resource_ui<public> := class:

    # Stores each players created resource UI.
    var UIMap:[player]resource_ui_widgets = map{}
    # Store each logic case for weather or not the UI is shown for each player.
    var WidgetAddedMap:[player]logic = map{}
    # Stores each selected player whose resources are shown on the UI for each player.
    var SelectedPlayerMap:[player]player = map{}

    # Creates UI and stores data for the player
    PlayerAdded<public>(Player:player):void=
        UIResult := CreateUI()
        if:
            not UIMap[Player]
            set UIMap[Player] = UIResult

    # Removed UI data from the player
    PlayerRemoved<public>(Player:player):void=
        CloseUI(Player)
        NewUIMap := UIMap.RemoveKey(Player)
        NewSelectedPlayerMap := SelectedPlayerMap.RemoveKey(Player)
        
        set UIMap = NewUIMap
        set SelectedPlayerMap = NewSelectedPlayerMap
        
    # Creates a UI for the player
    CreateUI():resource_ui_widgets=
        CubeTextWidget := CreateResourceText()
        CubeTextureWidget := CreateResourceTexture(currency.Cube)
        CubeWidget := CreateResourceWidget(CubeTextWidget, CubeTextureWidget)

        PyramidTextWidget := CreateResourceText()
        PyramidTextureWidget := CreateResourceTexture(currency.Pyramid)
        PyramidWidget := CreateResourceWidget(PyramidTextWidget, PyramidTextureWidget)

        SphereTextWidget := CreateResourceText()
        SphereTextureWidget := CreateResourceTexture(currency.Circle)
        SphereWidget := CreateResourceWidget(SphereTextWidget, SphereTextureWidget)

        ResourceTable := stack_box:
            Orientation := orientation.Vertical
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Left
                    Widget := CubeWidget

        Canvas := canvas:
            Slots := array:
                canvas_slot:
                    Anchors := anchors{Minimum := vector2{X := 1.0, Y := 1.0}, Maximum := vector2{X := 1.0, Y := 1.0}}
                    Offsets := margin{Left := -120.0, Top := -100.0}
                    Alignment := vector2{X := 1.0, Y := 1.0}
                    SizeToContent := true
                    Widget := ResourceTable

        return resource_ui_widgets:
            Canvas := Canvas

            CircleTextWidget := SphereTextWidget
            CircleTextureWidget := SphereTextureWidget

            CubeTextWidget := CubeTextWidget
            CubeTextureWidget := CubeTextureWidget

            PyramidTextWidget := PyramidTextWidget
            PyramidTextureWidget := PyramidTextureWidget

            StopEvent := event(){}

    CreateResourceWidget(TextWidget : widget, TextureWidget : widget):stack_box=
        stack_box :
            Orientation := orientation.Horizontal
            Slots := array:
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Left
                    Widget := TextureWidget
                stack_box_slot:
                    HorizontalAlignment := horizontal_alignment.Left
                    Padding := margin{Left := 12.0}
                    Widget := TextWidget

    CreateResourceText():text_block=
        text_block:
            DefaultTextColor := NamedColors.White
            DefaultJustification := text_justification.InvariantLeft
            DefaultShadowOffset := option{vector2{X := 2.0, Y := 3.0}}
            DefaultShadowColor := NamedColors.Black
            DefaultShadowOpacity := 1.0
            DefaultText := PlainText("0")

    CreateResourceTexture(Currency : currency):texture_block=
        texture_block:
            DefaultImage := GetCurrencyTexture(Currency)
            DefaultDesiredSize:=vector2{X := 60.0, Y := 60.0}

    # Shows the UI to the player, only this player can see the UI.
    ShowUI<public>(Player:player, SelectedPlayer:player):void=
        if:
            set SelectedPlayerMap[Player] = SelectedPlayer
            ResourceUI := UIMap[Player]
            PlayerUI := GetPlayerUI[Player]
            not WidgetAddedMap[Player]?
        then:
            UpdateUI(Player)
            PlayerUI.AddWidget(ResourceUI.Canvas)
            if (set WidgetAddedMap[Player] = true):

    # Close the UI for the player.
    CloseUI<public>(Player:player):void=
        if:
            ResourceUI := UIMap[Player]
            PlayerUI := GetPlayerUI[Player]
        then:
            # Stop any count animations.
            ResourceUI.StopEvent.Signal()
            PlayerUI.RemoveWidget(ResourceUI.Canvas)
            if (set WidgetAddedMap[Player] = false):

    # Updates the UI for selected player.
    UpdateUI<public>(Player:player):void=
        if (ResourceUI := UIMap[Player]):
            # Stop any previous animations.
            ResourceUI.StopEvent.Signal()

            UpdateCount(Player, currency.Cube)
            UpdateCount(Player, currency.Circle)
            UpdateCount(Player, currency.Pyramid)

    # Updates the selected players display of obtained resources.
    UpdateCount(Player : player, Currency : currency):void=
        if:
            ResourceUI := UIMap[Player]
            PlayerAmount := Player.GetResource[Currency]
            PlayerAmountLargeNumber := ToLargeNumber[PlayerAmount]
        then:
            ResourceAmountTextWidget := GetTextWidget(ResourceUI, Currency)
            ResourceAmountTextWidget.SetText(PlainText("{PlayerAmountLargeNumber}"))
        
    # Returns UI text widget baseed on which resources is gained.
    GetTextWidget(ResourceUI : resource_ui_widgets, Currency : currency)<transacts>:text_block=
        case (Currency):
            currency.Cube => return ResourceUI.CubeTextWidget
            currency.Circle => return ResourceUI.CircleTextWidget
            currency.Pyramid => return ResourceUI.PyramidTextWidget
