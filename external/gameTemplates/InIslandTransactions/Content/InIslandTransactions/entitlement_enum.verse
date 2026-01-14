# Copyright Epic Games, Inc. All Rights Reserved.

using { /Fortnite.com/Marketplace }

using {Definitions}

entitlement_enum := enum:
    CornSeed
    PrimoShovel
    CornSeedPack

(EntitlementEnum :entitlement_enum).ConvertToEntitlement() : concrete_subtype(entitlement)=
    case (EntitlementEnum):
        entitlement_enum.CornSeed => return Entitlements.corn_seed
        entitlement_enum.PrimoShovel => return Entitlements.primo_shovel
        entitlement_enum.CornSeedPack => return Entitlements.corn_seed_pack

