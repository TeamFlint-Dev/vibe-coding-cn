# 1. The Patchwork Adaptive Soundtrack

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-1-the-patchwork-adaptive-soundtrack-in-fortnite-creative
> **爬取时间**: 2025-12-27T02:15:21.046868

---

This section focuses on the [Value Setter](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-value-setter-devices-in-fortnite-creative) devices, as they communicate with the other creative devices on the island. For more information on how to create tracks using Patchwork, see [Getting Started with Patchwork](getting-started-with-patchwork-in-fortnite-creative).

Players on this island will not have access to the **Patchwork tool** since the soundtrack is meant to be an integral part of the game.

Yacht Heist contains three main tracks:

- The **Sneak Base** track is a drum track that plays during the first part of the game, while guards are unaware of your presence.
- When guards are alerted to your presence, the **Sneak Alert** track plays. It adds drums, bass, and a synth to the base track.
- The **Escape** track plays from the moment you secure the jewel, until you jump onto the getaway boat.

The Value Setters are connected to the volume knobs on the individual instruments for each track instead of the Speaker. This allows the music to gently fade out instead of cutting.

## Sneak Base Track

The Sneak Base Track is a simple drum track meant to give the player the sense of stealthily sneaking past guards. This track plays throughout the Sneak phase, stopping when the vault is blown open.

**Devices used:**

- 1 x [Drum Sequencer](using-patchwork-drum-sequencer-devices-in-fortnite-creative)
- 1 x [Drum Player](using-patchwork-drum-player-devices-in-fortnite-creative)
- 1 x [Speaker](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative)
- 1 x [LFO](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-lfo-modulator-devices-in-fortnite-creative)
- 2 x [Value Setter](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-value-setter-devices-in-fortnite-creative)

### OFF Value Setter

This turns off the Sneak Base track. It connects to the Drum Player Volume knob and sets the volume to 0.

[![Value Setter OFF](https://dev.epicgames.com/community/api/documentation/image/68b730da-538d-4fcb-9925-7725a61090f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68b730da-538d-4fcb-9925-7725a61090f7?resizing_type=fit)

*These Value Setters are used to turn on the track's Drum Sequencer at the beginning of the game and turn it off when the Escape phase begins.*

### ON Value Setter

This turns on the Sneak Base track. It connects to the Drum Player’s Volume knob.

[![Value Setter ON](https://dev.epicgames.com/community/api/documentation/image/9cd2aa2e-b91f-4242-a4bc-4ff5c9ef3cd5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9cd2aa2e-b91f-4242-a4bc-4ff5c9ef3cd5?resizing_type=fit)

*These Value Setters are used to turn on the track's Drum Sequencer at the beginning of the game and turn it off when the Escape phase begins.*

## Sneak Alert Track

The Sneak Alert track consists of additional drums, bass, and a synthesizer. It adds energy to the Sneak Base track, underscoring high-tension moments that the player will experience, like combat or chasing. The track is turned on when guards are alerted to the player’s presence during the Sneak phase, and otherwise turned off. The track is turned off at the end of the Sneak phase once the vault is blown open.

**Devices used:**

- 2 x [Note Sequencer](using-patchwork-note-sequencer-devices-in-fortnite-creative)
- 2 x [Omega Synth](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-omega-synthesizer-devices-in-fortnite-creative)
- 1 x [Drum Sequencer](using-patchwork-drum-sequencer-devices-in-fortnite-creative)
- 1 x [Drum Player](using-patchwork-drum-player-devices-in-fortnite-creative)
- 1 x [Echo](using-patchwork-echo-effect-devices-in-fortnite-creative)
- 1 x [Speaker](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-speaker-devices-in-fortnite-creative)
- 6 x [Value Setter](https://dev.epicgames.com/documentation/en-us/fortnite/using-patchwork-value-setter-devices-in-fortnite-creative)

### OFF Value Setters

These turn off the Sneak Alert track.

[![Value Setters Alert Off](https://dev.epicgames.com/community/api/documentation/image/e02431c1-0134-41f6-87cc-eecbd49a6bc1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e02431c1-0134-41f6-87cc-eecbd49a6bc1?resizing_type=fit)

### ON Value Setters

These turn on the Sneak Alert track.

[![Value Setters Alert On](https://dev.epicgames.com/community/api/documentation/image/b3e2b0ab-e5ab-4ce2-ab85-59aa617ff472?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b3e2b0ab-e5ab-4ce2-ab85-59aa617ff472?resizing_type=fit)

## Escape Track

The Escape track is a much faster, drum- and bass-inspired track consisting of drums, bass, and synth. It is made for the Escape phase of the game in which the player blows their way through large groups of guards with a minigun, a shotgun, and grenades. The track begins playing when the player picks up the jewel to begin the Escape phase and stops playing when the player gets on the escape boat.

**Devices used:**

- 2 x Note Sequencer
- 2 x Omega Synth
- 1 x Drum Sequencer
- 1 x Drum Player
- 2 x Echo
- 1 x [Distortion](using-patchwork-distortion-effect-devices-in-fortnite-creative)
- 1 x Speaker
- 1 x [Music Manager](using-patchwork-music-manager-devices-in-fortnite-creative)
- 8 x Value Setter

### Tempo Slow Value Setter

This sets the tempo of the music to be relatively slow (108 bpm). This is the tempo used for the Sneak phase.

[![Value Setter Tempo Slow](https://dev.epicgames.com/community/api/documentation/image/ba8abe4e-78e7-472e-bb87-f1d20f86ef61?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ba8abe4e-78e7-472e-bb87-f1d20f86ef61?resizing_type=fit)

### Tempo Fast Value Setter

This sets the tempo of the music to be fast (160 bpm). This is the tempo used for the Escape phase.

[![Value Setter Tempo Fast](https://dev.epicgames.com/community/api/documentation/image/993805b3-21b2-4392-b20f-e393d7a4dc26?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/993805b3-21b2-4392-b20f-e393d7a4dc26?resizing_type=fit)

### Escape Track OFF Value Setters

These turn off the Escape track.

[![Value Setters Escape Off](https://dev.epicgames.com/community/api/documentation/image/8eec6c9f-730e-4105-a75f-eabee8102a51?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8eec6c9f-730e-4105-a75f-eabee8102a51?resizing_type=fit)

### Escape Track OFF Value Setters

These turn on the Escape track.

[![Value Setters Escape On](https://dev.epicgames.com/community/api/documentation/image/4724c8de-de38-4249-badf-db26e0fafeef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4724c8de-de38-4249-badf-db26e0fafeef?resizing_type=fit)

## Next Section

[![2. The Guard Alert System](https://dev.epicgames.com/community/api/documentation/image/7d6cd150-d8d1-4166-870e-1532f5a737e1?resizing_type=fit&width=640&height=640)

2. The Guard Alert System

Find out how guards are alerted and how their state changes the Patchwork adaptive soundtrack.](https://dev.epicgames.com/documentation/en-us/fortnite/yacht-heist-2-the-guard-alert-system-in-fortnite-creative)
