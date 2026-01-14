# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }

var PlayerInfoMap<public> : weak_map(player, player_info) = map{}

player_stats<public> := class<final><persistable>:
    # Affects Damage Dealt and Resources Gained
    Strength<public> : int = 1

    # Doubles Damage Dealt and Resources Generated for Each Strength
    Efficiency<public> : int = 1

    # Increases rewards for finishing a node by 150% per level
    Bonus<public> : int = 1

player_info<public> := class<final><persistable>:

    Version<public> : int = 0

    # Stores player resources data
    Resource<public> : [currency]int = map{}
    # Stores player stats
    PlayerStats<public> : player_stats = player_stats{}

    BaseAttack<public> :int = 1

    BaseBonus<public> : float = 1.5

# Creates a new player_info with the same values as the previous player_info.
MakePlayerInfo<public><constructor>(Src : player_info)<transacts> := player_info:
    Version := Src.Version
    Resource := Src.Resource
    PlayerStats := Src.PlayerStats

# Creates player information for the player if none exists. 
(Player:player).CheckPlayerInfo()<decides><transacts>:void=
    Player.IsActive[]
    if (not PlayerInfoMap[Player]):
        Player.ResetPlayerInfo[]

(Player:player).ResetPlayerInfo<public>()<decides><transacts>:void=
    Player.IsActive[]
     set PlayerInfoMap[Player] = MakePlayerInfo(
        player_info:
            Resource := map:
                currency.Circle => 0,
                currency.Cube => 0,
                currency.Pyramid => 0
        )

# Grant the amount of resource to the player.
(Player:player).GrantResource<public>(Amount:int, Currency:currency)<decides><transacts>:void=
    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    var TempResource : [currency]int = SourceInfo.Resource
    set TempResource[Currency] += Amount

    set PlayerInfoMap[Player] = player_info:
        Resource := TempResource
        MakePlayerInfo<constructor>(SourceInfo)

(Player:player).GrantResource<public>(Resource:resource)<decides><transacts>:void=
    Player.GrantResource[Resource.Amount.ToInt[], Resource.Currency]

# Spends the amount of resource. Fails if player doesn't have enough resource.
(Player:player).SpendResource<public>(Amount:int, Currency:currency)<decides><transacts>:void=
    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    var TempResource : [currency]int = SourceInfo.Resource

    TempResource[Currency] >= Amount

    set TempResource[Currency] -= Amount
    set PlayerInfoMap[Player] = player_info:
        Resource := TempResource
        MakePlayerInfo<constructor>(SourceInfo)

(Player:player).SpendResource<public>(Resource:resource)<decides><transacts>:void=
    Player.SpendResource[Resource.Amount.ToInt[], Resource.Currency]

# Gets the amount of resource the player has.
(Player:player).GetResource<public>(Currency:currency)<decides><transacts>:int=
    Player.CheckPlayerInfo[]
    PlayerInfoMap[Player].Resource[Currency]

# Checks if player has enough amount of resource. Fails if player doesn't have enough resource.
(Player:player).HasResource<public>(Amount:int, Currency:currency)<decides><transacts>:void=
    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    SourceInfo.Resource[Currency] >= Amount

(Player:player).HasResource<public>(Resource:resource)<decides><transacts>:void=
    Player.HasResource[Resource.Amount.ToInt[], Resource.Currency]

# Sets the amount of resource the player has.
(Player:player).SetResource<public>(Amount:int, Currency:currency)<decides><transacts>:void=
    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    var TempResource : [currency]int = SourceInfo.Resource

    set TempResource[Currency] = Amount
    set PlayerInfoMap[Player] = player_info:
        Resource := TempResource
        MakePlayerInfo<constructor>(SourceInfo)

(Player:player).SetResource<public>(Resource:resource)<decides><transacts>:void=
    Player.SetResource[Resource.Amount.ToInt[], Resource.Currency]

# Returns player persistent save data
(Player:player).GetPlayerInfo<public>()<decides><transacts>:player_info=
    PlayerInfoMap[Player]

# Increases selected player's stat
(Player:player).IncreaseStat<public>(Stat : storage_key)<decides><transacts>:void=
    Stat = storage_key.PlayerStrength or
    Stat = storage_key.PlayerEfficiency or
    Stat = storage_key.PlayerBonus

    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    PlayerStats := SourceInfo.PlayerStats

    Temp := case (Stat):
        storage_key.PlayerEfficiency => player_stats{
            Efficiency := PlayerStats.Efficiency + 1
            Strength := PlayerStats.Strength
            Bonus := PlayerStats.Bonus
        }
        storage_key.PlayerBonus => player_stats{
            Bonus := PlayerStats.Bonus + 1
            Efficiency := PlayerStats.Efficiency
            Strength := PlayerStats.Strength
        }
        storage_key.PlayerStrength => player_stats{
            Strength := PlayerStats.Strength + 1
            Efficiency := PlayerStats.Efficiency
            Bonus := PlayerStats.Bonus
        }
        _ => player_stats{}

    set PlayerInfoMap[Player] = player_info:
        PlayerStats := Temp
        MakePlayerInfo<constructor>(SourceInfo)

(Player:player).GetAttack<public>()<decides><transacts>:int=

    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    PlayerStats := SourceInfo.PlayerStats
    MakeLargeNumber(SourceInfo.BaseAttack + (PlayerStats.Strength * PlayerStats.Efficiency), magnitude.None).ToInt[] or 0

(Player:player).GetBonusPercentage<public>()<decides><transacts>:float=

    Player.CheckPlayerInfo[]
    SourceInfo := PlayerInfoMap[Player]
    PlayerStats := SourceInfo.PlayerStats

    SourceInfo.BaseBonus * PlayerStats.Bonus

(Player:player).GetBonusCalculation<public>()<decides><transacts>:int=

    Attack := Player.GetAttack[]
    Bonus := Player.GetBonusPercentage[]
    Attack + Floor[Attack * Bonus]

(PlayerStats:player_stats).GetValue<public>(Key : storage_key):int=
    case (Key):
        storage_key.PlayerEfficiency => PlayerStats.Efficiency
        storage_key.PlayerStrength => PlayerStats.Strength
        storage_key.PlayerBonus => PlayerStats.Bonus
        _ => 0