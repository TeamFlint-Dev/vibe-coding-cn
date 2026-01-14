# Copyright Epic Games, Inc. All Rights Reserved.

using { /Verse.org/Simulation }

<#>
    Struct representing large numbers. It's meant to be used whenever nice number format is needed.
    Representation uses short scale naming system 10^(3x+3)
    Example use case: 
    Designer wants to tweak boss health value. Instead of typing 300000000 they may pick 300 Million.
    Creator wants to show boss health on HUD. Instead of displaying 300000000 which might take a lot of space, 300M will be displayed

large_number<public> := class:

    @editable_slider(int):
        MinValue := option{0}
        MaxValue := option{999}
    var Value<public> : int = 0

    @editable
    var Magnitude<public> : magnitude = magnitude.None

    ToInt<public>()<transacts><decides>:int=
        Value * Floor[Pow(10.0, MagnitudeToExponent[Magnitude] * 1.0)]

MakeLargeNumber<public><constructor>(InValue : int, InMagnitude : magnitude)<transacts> := large_number :
    Value := InValue
    Magnitude := InMagnitude

ToLargeNumber<public>(Value : int)<transacts><decides>:large_number=
    RealExponent := Log(10.0, Value * 1.0) + 0.000001
    Magnitude := ExponentToMagnitude(RealExponent)
    RoundedExponent := MagnitudeToExponent[Magnitude]
    Base := Floor[Pow(10.0, RoundedExponent * 1.0)]
    DisplayValue := Floor[(Value * 1.0) / (Base * 1.0)]
    MakeLargeNumber(DisplayValue, Magnitude)

ToString<public>(Number : large_number)<transacts>:string=
    "{Number.Value}{Number.Magnitude}"

magnitude<public> := enum:
    None,
    Thousand,
    Million,
    Billion,
    Trillion

ToString<public>(Magnitude : magnitude)<transacts>:string=
    case (Magnitude):
        magnitude.None => "",
        magnitude.Thousand => "K",
        magnitude.Million => "M",
        magnitude.Billion => "B",
        magnitude.Trillion => "T"

MagnitudeToExponent : [magnitude]int = map{
    magnitude.None => 0,
    magnitude.Thousand => 3,
    magnitude.Million => 6,
    magnitude.Billion => 9,
    magnitude.Trillion => 12
}

ExponentToMagnitude(Exponent : float)<transacts>:magnitude=
    if (Exponent >= 12.0):
        return magnitude.Trillion
    else if (Exponent >= 9.0):
        return magnitude.Billion
    else if (Exponent >= 6.0):
        return magnitude.Million
    else if (Exponent >= 3.0):
        return magnitude.Thousand

    magnitude.None
