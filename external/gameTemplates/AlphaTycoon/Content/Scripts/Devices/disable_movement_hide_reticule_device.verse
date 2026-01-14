# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /Fortnite.com/Characters }

NoReticleHUDTooltip<public><localizes>:message := "HUD Controller Device with disabled reticle."
ReticleHUDTooltip<public><localizes>:message := "HUD Controller Device with enabled reticle."

<#>
    Device used to transition player between gameplay and cutscene.
    Controls player stasis and switches between two HUD Controller Devices.
    One HUD device has disabled reticle. Usually active during cutscenes to hide the mining reticle.
    Second HUD device has enabled reticle. Usually used during the gameplay.
disable_movement_hide_reticule_device<public> := class(creative_device):

    @editable
    ActivateTrigger : trigger_device = trigger_device{}

    @editable
    DeactivateTrigger : trigger_device = trigger_device{}

    @editable:
        ToolTip := NoReticleHUDTooltip
    NoReticleHud : hud_controller_device = hud_controller_device{}

    @editable:
        ToolTip := ReticleHUDTooltip
    ReticleHud : hud_controller_device = hud_controller_device{}

    StasisArgs : stasis_args = stasis_args {
        AllowEmotes:= false,
        AllowFalling := false,
        AllowTurning := false
    }

    OnBegin<override>()<suspends>:void=
        ActivateTrigger.TriggeredEvent.Subscribe(HideReticle)
        DeactivateTrigger.TriggeredEvent.Subscribe(ShowReticle)

    HideReticle(Agent:?agent):void=
        if (Player := player[Agent?], FortCharacter := Player.GetFortCharacter[]):
            FortCharacter.PutInStasis(StasisArgs)
        else:
            for (Player :GetPlayspace().GetPlayers(), FortCharacter := Player.GetFortCharacter[]):
                FortCharacter.PutInStasis(StasisArgs)

        ReticleHud.Disable()
        NoReticleHud.Enable()
        
    ShowReticle(Agent:?agent):void=
        if (Player := player[Agent?], FortCharacter := Player.GetFortCharacter[]):
            FortCharacter.ReleaseFromStasis()
        else:
            for (Player :GetPlayspace().GetPlayers(), FortCharacter := Player.GetFortCharacter[]):
                FortCharacter.ReleaseFromStasis()
        
        ReticleHud.Enable()
        NoReticleHud.Disable()