# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Fortnite.com/Devices }

ResourceGrowsTooltip<public><localizes>:message := "Audio to play when the resource grows or regrows"
ResourceDamagedTooltip<public><localizes>:message := "Audio to play when the resource is damaged"
ResourceDestroyedTooltip<public><localizes>:message := "Audio to play when the resource is destroyed"

resource_audio_component<public> := class<final_super>(component):
    @editable:
        Categories := array{AudioPlayerCategory}
        ToolTip := ResourceGrowsTooltip
    GrowsAudioPlayer : audio_player_device = audio_player_device{}

    @editable:
        Categories := array{AudioPlayerCategory}
        ToolTip := ResourceDamagedTooltip
    DamagedAudioPlayer : audio_player_device = audio_player_device{}

    @editable:
        Categories := array{AudioPlayerCategory}
        ToolTip := ResourceDamagedTooltip
    DestroyedAudioPlayer : audio_player_device = audio_player_device{}

    SendDown<override>(SceneEvent:scene_event):logic =
        if (AudioEvent := audio_damage_resource_event[SceneEvent]):
            if (AudioEvent.IsDestroyed?):
                DestroyedAudioPlayer.Play(AudioEvent.Player)
            else:
                DamagedAudioPlayer.Play(AudioEvent.Player)

        if (AudioEvent := audio_grow_resource_event[SceneEvent]):
            GrowsAudioPlayer.Play()
        true
