# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }
using { /Verse.org/Assets }
using { Art.Textures.UI }

<#>
    List of available currencies in game.
    If you need to add another one, just extend this enum.
    Remember to add new case in ToString() and GetCurrencyTexture() functions.
currency<public> := enum<persistable>:
    Circle
    Cube
    Pyramid

# Returns string that resembles given Currency shape.
ToString<public>(Currency : currency)<transacts>:string=
    case (Currency):
        currency.Circle => "()"
        currency.Cube => "[]"
        currency.Pyramid => "/\\"

# Returns texture that represents given Currency.
GetCurrencyTexture<public>(Currency : currency):texture=
    case (Currency):
        currency.Circle => T_Sphere
        currency.Cube => T_Cube
        currency.Pyramid => T_Pyramid

<#>
    Class that specifies Amount of Currency.
    Useful whenever you need to define cost of item or upgrade.
resource<public> := class:

    @editable
    Currency<public> : currency = currency.Cube

    @editable
    Amount<public> : large_number = large_number{}

MakeResource<public><constructor>(InCurrency : currency, InAmount : large_number)<transacts> := resource :
    Currency := InCurrency
    Amount := InAmount

ToString<public>(Resource : resource)<transacts>:string=
    "{Resource.Amount} {Resource.Currency}"
    