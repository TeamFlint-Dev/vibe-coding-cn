# Copyright Epic Games, Inc. All Rights Reserved.

# Modules #
UI<public> := module:
    Verse<public> := module:
        MaterialBlock<public> := module:
            MaterialInstances<public>:=module{}
            Textures<public>:=module{}
        InputActions<public> := module:
            IADemoWidgets<public>:=module{}
            IADemoTextures<public>:=module{}
            IADemoMaterialInstances<public>:=module{}
        MaterialCollection<public> := module:
            MaterialInstances<public>:=module{}
            Widgets<public>:=module{}
        InIslandTransactions<public> := module:
            MaterialInstances<public>:=module{}
            Textures<public>:=module{}
            Widgets<public>:=module{}

ui_helper := class:
    #TODO: Add members and methods here
