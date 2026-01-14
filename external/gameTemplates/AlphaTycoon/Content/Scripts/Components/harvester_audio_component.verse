# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }
using { /Verse.org/SceneGraph }
using { /Fortnite.com/Devices }

AudioPlayerCategory<public><localizes>:message := "Audio Players"
AudioParametersCategory<public><localizes>:message := "Audio Parameters"

audio_grow_resource_event<public> := class(scene_event):
audio_damage_resource_event<public> := class(scene_event):
    IsDestroyed<public>:logic
    Player<public>:player

# Event to indicate when the harvester is being activted.
audio_activate_harvester_event<public> := class(scene_event):
    Player<public>:player

harvester_audio_component<public> := class<final_super>(component):

    # Audio to play when the harvester is activated
    @editable:
        Categories := array{AudioPlayerCategory}
    ActivationAudioPlayer:audio_player_device = audio_player_device{}

    # Looping audio to play when the harvester is activated (delayed #1)
    @editable:
        Categories := array{AudioPlayerCategory}
    ActivationAudioPlayer2:audio_player_device = audio_player_device{}

    # Additional looping audio to play when the harvester is activated (delayed #2)
    @editable:
        Categories := array{AudioPlayerCategory}
    ActivationAudioPlayer3:audio_player_device = audio_player_device{}

    # Audio to play when the harvester is activated
    @editable:
        Categories := array{AudioPlayerCategory}
    IdleAudio:audio_player_device = audio_player_device{}

    # Delay times
    @editable:
        Categories := array{AudioParametersCategory}
    ActivationStage2Delay:float = 4.3

    # Delay times
    @editable:
        Categories := array{AudioParametersCategory}
    ActivationStage3Delay:float = 4.0

    PlayAudio(Player : player, AudioPlayer : audio_player_device, ?Delay : float = 0.0)<suspends>:void=
        Sleep(Delay)
        AudioPlayer.Play(Player)

    PlayAudioSequence(Player : player)<suspends>:void=
        sync:
            PlayAudio(Player, ActivationAudioPlayer)
            PlayAudio(Player, ActivationAudioPlayer2, ?Delay := ActivationStage2Delay)
            PlayAudio(Player, ActivationAudioPlayer3, ?Delay := ActivationStage3Delay)

    # Receive scene events.
    SendDown<override>(SceneEvent:scene_event):logic =
        if (AudioEvent := audio_activate_harvester_event[SceneEvent]):
            spawn{ PlayAudioSequence(AudioEvent.Player) }
            IdleAudio.Play()
        true