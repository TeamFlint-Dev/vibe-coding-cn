# Copyright Epic Games, Inc. All Rights Reserved.

# Storage key used to define tycoon data
storage_key<public> := enum<open>:
    Invalid,
    PlayerEfficiency,
    PlayerStrength,
    PlayerBonus,
    Harvester

ToString<public>(Key : storage_key)<transacts>:string=
    case (Key):
        storage_key.Invalid => "Invalid"
        storage_key.PlayerEfficiency => "Player efficiency"
        storage_key.PlayerStrength => "Player strength"
        storage_key.PlayerBonus => "Player bonus"
        storage_key.Harvester => "Harvester"
        _ => "N/A"

# Helper function that converts string to one of player stats
ToStorageKey<public>(Key : string)<transacts>:storage_key=
    case (Key):
        "Efficiency" => storage_key.PlayerEfficiency
        "Strength" => storage_key.PlayerStrength
        "Bonus" => storage_key.PlayerBonus
        _ => storage_key.Invalid