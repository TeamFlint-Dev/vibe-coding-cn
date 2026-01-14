using { /Fortnite.com/Devices }
using { /Fortnite.com/UI }
using { /Verse.org/Simulation }
using { /Verse.org/Colors }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/ControlInput }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Input }
using {UI.Verse.InputActions}
using {UI.Verse.InputActions.IADemoWidgets}
using {UI.Verse.InputActions.IADemoTextures}
using {UI.Verse.InputActions.IADemoMaterialInstances}

            

# A Verse-authored creative device that can be placed in a level
hud_keybind_demo_device := class(creative_device):

    @editable
    ShowTrigger:volume_device = volume_device{}    
    @editable
    RemoveTriggers:[]volume_device = array{}
    @editable
    RemoveTeleporters:[]teleporter_device = array{}

    # Verse UI for the demo
    var StanceHud : overlay = overlay {}

    # Materials used
    StanceMaterial:MI_UI_Stance = MI_UI_Stance{Texture :=  T_UI_Stand}

    OnBegin<override>()<suspends>:void=

        for (RemoveTrigger : RemoveTriggers):
            RemoveTrigger.AgentEntersEvent.Subscribe(OnHide)
        for (Teleporter : RemoveTeleporters):
            Teleporter.TeleportedEvent.Subscribe(OnHide)

        # Setup our input on each player in the playspace, and get notified for when another player joins.
        Playspace := GetPlayspace()
        for (Player : Playspace.GetPlayers()):
            OnPlayerAdded(Player)
        # Handle any new players joining or leaving
        Playspace.PlayerAddedEvent().Subscribe(OnPlayerAdded)
        Playspace.PlayerRemovedEvent().Subscribe(OnPlayerRemoved)
        # Entering/exiting the volume device shows/hides the UI
        ShowTrigger.AgentEntersEvent.Subscribe(OnPlayerInitialize)

    OnPlayerInitialize(InAgent : agent):void=
        if (FortCharacter:= InAgent.GetFortCharacter[]):
            FortCharacter.CrouchedEvent().Subscribe(OnCrouchedEvent)      
        
        # Material block used for stance UI
        StanceMaterialBlock := material_block:
            DefaultImage := StanceMaterial
            DefaultDesiredSize := vector2{X:=100.0, Y:=100.0}
        set StanceMaterial.Texture = T_UI_Stand
            
        # UI overlay for stance
        StanceOverlay := overlay:
            Slots := array:
                overlay_slot:
                    Widget := StanceMaterialBlock
                    Padding := margin{Left:=0.0, Top:=0.0, Right:=50.0, Bottom:=80.0}
                    HorizontalAlignment := horizontal_alignment.Right
                    VerticalAlignment := vertical_alignment.Bottom
        set StanceHud = StanceOverlay

        # Show the stance UI
        for:
            Player : GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            PlayerUI.AddWidget(StanceHud)              
            
    # When a player is added to the playspace, add mapping contexts.
    OnPlayerAdded(Player:player):void=
        if (PlayerInput := GetPlayerInput[Player]):
            Print("Player added")
            # Adds the input mapping itself, which is what will actually
            PlayerInput.AddInputMapping(Character.TraversalMapping)
            PlayerInput.AddInputMapping(Character.RangedWeaponMapping)

    # When a player is removed, remove mapping contexts.
    OnPlayerRemoved(Player:player):void=
        if (PlayerInput := GetPlayerInput[Player]):
            Print("Player removed")
            # Adds the input mapping itself, which is what will actually
            PlayerInput.RemoveInputMapping(Character.TraversalMapping)
            PlayerInput.RemoveInputMapping(Character.RangedWeaponMapping)

    # Event to change the crouch UI indicator on HUD
    OnCrouchedEvent(FortCharacter:fort_character,isCrouch:logic):void=
        if (isCrouch = true):
            Print("Player crouched")
            set StanceMaterial.Texture = T_UI_Crouch
        else:
            Print("Player standing")
            set StanceMaterial.Texture = T_UI_Stand

    # Hide the UI
    OnHide(InAgent:agent):void=
        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            PlayerUI.RemoveWidget(StanceHud)