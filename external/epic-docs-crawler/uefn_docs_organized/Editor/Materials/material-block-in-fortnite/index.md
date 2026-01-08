# Material Block

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/material-block-in-fortnite>
> **爬取时间**: 2025-12-27T00:33:03.976091

---

Materials have a lot of functionality in UEFN due to editable material parameters exposed in Verse.  Parameterized [materials](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material) are key to creating a high quality looking [user interface (UI](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#ui)) with a `material_block`.

A `material_block` uses a UI material’s or material instances’ parameters to modify and control the parameter values through Verse code to create a dynamic looking UI. For example, the parameters of a UI meter material can be manipulated in Verse to program material behavior when the player takes damage, or damages an enemy.

Before writing a line of code, consider how you want to use materials in your UI. Create wireframes to determine how you want your UI to look and what you want the materials to do.

## UI Materials and Textures

Coding a `material_block` slot starts with the creation of your UI material. You can use the [material functions](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#material-function) and materials available from the [User Interfaces Feature Template](https://dev.epicgames.com/documentation/en-us/fortnite/user-interfaces-feature-template-in-unreal-editor-for-fortnite), or you can create your own custom material from scratch.

See the **[UI Materials](https://dev.epicgames.com/documentation/en-us/fortnite/ui-materials-in-unreal-editor-for-fortnite)** section to learn more about making your own custom UI materials.

### Materials

Creating a new, custom material sets your UI apart from others who modify existing and widely available UI materials. Set up your UI materials first. Use the following essential setup steps and best practices for creating UI materials:

- Set the **Material Domain** to **User Interface** in the **Main Material Node (MMN)**.
- Modify your root material to be simple.
- The more parameters you have, the more freedom you’ll have with your material.
- Turn your material into a material instance when the material is complete.

Material instances are used as a type of [class](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#classes) in Verse code. In Verse you can set default values on your material properties and parameters.

When naming your material instances, use the following Fortnite naming convention:

- **MI\_UI\_MaterialName**

### Textures

Textures add a flourish to a UI design that can’t be achieved through materials alone. UEFN provides a folder of textures you can use in your UI under **Project folder** > **Fortnite** > **Textures**. Any textures you [import](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) must obey the **[Power of Two](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#power-of-two)** rule.

The material nodes use parameters from the material and expose them in the Verse code. Using Verse you can use the material parameters to target the values of the texture's pixels (called texels) within the material to create a type of mask or for other calculations to edit and change how the textures look and behave.

To make sure your textures are optimized for use in UI, open the thumbnail and use the following settings in the Details panel:

- Set Mip Gen Settings to No MipMaps.
- Set Texture Group to UI.
- Set Compression Settings to User Interface 2C (RGBA8).

[![](https://dev.epicgames.com/community/api/documentation/image/811a2476-ad16-41f4-adb8-b8ae2e4e7101?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/811a2476-ad16-41f4-adb8-b8ae2e4e7101?resizing_type=fit)

Imported textures that do not adhere to the Power of Two rule can be edited to fit the proper texture scale. To edit a texture, follow the directions in **[Resizing Textures](https://dev.epicgames.com/documentation/en-us/fortnite/resizing-textures-in-unreal-editor-for-fortnite)**.

## Material Block Example 1

A `material_block` is used as one of the slots inside a custom widget created with Verse code. During gameplay, the `material_block` provides a way for you to manipulate the material parameters through Verse to change how the UI material/material instance looks and behaves on the HUD. This is similar to how an `image_block` lets you use a texture in Verse.

The custom material widget is used in a number of ways in the Verse code:

- It provides a way to use material parameters to determine the size, behavior, and look of the material in the UI.
- Passes data in Verse to parameters, allowing parameters to be driven by dynamic gameplay data only available from Verse.

The following code demonstrates how material\_block is used to display a block of dissolving material in the HUD. The entire code block can be found under the **Complete Code** section below.

Verse code should always use best practices to place and display UI elements.

### Modules for UI and Materials

The following modules contain the functions used to control the material\_block as a UI widget and determine the material’s colors, placement, and more.

```verse
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }
```

### Targeting UMG Widgets and UI Materials in the Device Class

Under the Verse device class, a stackbox widget `variable` named **MyUI** is declared. with an **Orientation** setting of `orientation.Vertical`. This causes the StackBox to display its contents vertically.

Next, a `UI.MaterialBlock.MI_UI_Dissolve_material` parameter named **DissolveMaterial** is declared with a **Dissolve parameter** and assigning a default value of **0.2** to it.

```verse
materialblock_test_device := class(creative_device):

    var MyUI:stack_box = stack_box{Orientation := orientation.Vertical}

    DissolveMaterial:UI.MaterialBlock.MI_UI_Dissolve_material = UI.MaterialBlock.MI_UI_Dissolve_material {Dissolve := 0.2}
```

### Controlling UI and Materials with the On Begin Function

In the `OnBegin function`, a square on the HUD is created that dissolves when the game starts.

The `DissolveMaterialBlock` variable is of type  `material_block` and references the UI material by setting the  `DefaultImage` to the UI material (DissolveMaterial), while the `DefaultDesiredSize` sets the default size of the material\_block when it renders in a widget using X and Y coordinates.

A `for expression` is used to display the UI on the screen for each player in the playspace. The `GetPlayspace(). GetPlayers() function` gets an array of all players in the game, and then adds the widget holding the `material_block` to their HUD based on the following instructions in the `do expression`:

- Creates a stack box called **MyStackBox**.
- Sets its orientation to **vertical**.
- Inserts the **DissolveMaterialBlock** into the first slot of **MyStackBox**.
- Sets **MyUI** to **MyStackBox** so it can be added to the player HUD outside of this loop.

```verse
    OnBegin<override>()<suspends>:void=
        DissolveMaterialBlock := material_block:
            DefaultImage := DissolveMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            MyStackBox:stack_box = stack_box:
                Orientation := orientation.Vertical
                Slots := array:
                    stack_box_slot:
                          Widget := DissolveMaterialBlock
                          Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
            set MyUI = MyStackBox
```

### Complete Code

Copy and paste the complete code block below to see the dissolving material block in the HUD.

You must have a dissolving material in your project for this code block to work.

See **[Create Your Own Verse Device](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-own-device-using-verse-in-unreal-editor-for-fortnite)** for steps on creating your own verse device.

```verse
using { /Fortnite.com/Devices }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }

materialblock_test_device := class(creative_device):

    var MyUI:stack_box = stack_box{Orientation := orientation.Vertical}

    DissolveMaterial:UI.MaterialBlock.MI_UI_Dissolve_material = UI.MaterialBlock.MI_UI_Dissolve_material {Dissolve := 0.2}

    OnBegin<override>()<suspends>:void=
        DissolveMaterialBlock := material_block:
            DefaultImage := DissolveMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            MyStackBox:stack_box = stack_box:
                Orientation := orientation.Vertical
                Slots := array:
                    stack_box_slot:
                          Widget := DissolveMaterialBlock
                          Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
            set MyUI = MyStackBox
```

## Material Block Example 2

This example builds on the example above by introducing two additional UI materials, a [Trigger device](https://dev.epicgames.com/documentation/en-us/fortnite/using-trigger-devices-in-fortnite-creative), and [Input Trigger devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-input-trigger-devices-in-fortnite-creative). The triggers are used to show and change the material displayed on the HUD.

The Verse code begins with the same modules as the code block above to control the `material_block` and determine the UI material’s parameters. One additional module is required for the editable properties of this code to work:

`using { /Verse.org/Simulation }`

### Setting up the Verse Device Class

This Verse device class has more functionality than the previous device class. A `message expression` named **Text** is used to display the message, “This is a Text Block”. This expression is called in the OnBegin function by a `text_block`.

```verse
# A Verse-authored creative device that can be placed in a level
materialblock_test_device := class(creative_device):

    Text<localizes><public> : message = "This is a Text Block."
```

Three `editable` Trigger and two `editable` Input Triggers devices are added to the device class to control the `material_block` and StackBox. Each trigger is renamed after the function it performs, for example:

- **TriggerShow**
- **TriggerChange**
- **TriggerHide**
- **InputTriggerInc** (Increases a value)
- **InputTriggerDec** (Decreases a value)

```verse
   @editable
    TriggerShow:trigger_device = trigger_device{}
    @editable
    TriggerChange:trigger_device = trigger_device{}
    @editable
    TriggerHide:trigger_device = trigger_device{}
    @editable
    InputTriggerInc:input_trigger_device = input_trigger_device{}
    @editable
    InputTriggerDec:input_trigger_device = input_trigger_device{}
```

A  StackBox widget `variable` called **MyUI** is declared , same as the **MyUI** variable in the code above.

```verse
    var MyUI:stack_box = stack_box{Orientation := orientation.Vertical}
```

The three UI materials (RadialMaterial, Stripe Material, and DissolveMaterial) are added to the device class and assigned default values to their material effects.

```verse
    RadialMaterial:UI.MaterialBlock.MI_UI_MaterialBlock_Radial_material = UI.MaterialBlock.MI_UI_MaterialBlock_Radial_material {Progress := 1.0}
    StripeMaterial:UI.MaterialBlock.MI_UI_Stripe_material = UI.MaterialBlock.MI_UI_Stripe_material {Speed := 0.5}
    DissolveMaterial:UI.MaterialBlock.MI_UI_Dissolve_material = UI.MaterialBlock.MI_UI_Dissolve_material {Dissolve := 0.2}
```

### Controlling the UI, Materials, and Triggers with the On Begin Function

The `OnBegin function` sets up controls for the different Trigger devices by subscribing different functions to their **`TriggeredEvents`** and controls the Input Trigger devices by subscribing functions to their **`PressedEvents`**. When the default value increases or decreases, the UI materials are affected by Verse using the `material_block` to do the following:

- `OnShow` - Shows the **UI material** on the player’s HUD.
- `OnChange` - Changes the **Progress parameter** of the UI material to show a change in the fill material.
- `OnHide` - Hides the **UI material** from the player.
- `IncreasesValue` - Increases the progress and speed at which the material is dissolving and the amount of dissolve in the material.
- `DecreasesValue` - Decreases the progress and speed at which the material is dissolving, and the amount of dissolve in the material.

```verse
    OnBegin<override>()<suspends>:void=
        Print ("Init")

        TriggerShow.TriggeredEvent.Subscribe(OnShow)
        TriggerChange.TriggeredEvent.Subscribe(OnChange)
        TriggerHide.TriggeredEvent.Subscribe(OnHide)
        InputTriggerInc.PressedEvent.Subscribe(IncreaseValue)
        InputTriggerDec.PressedEvent.Subscribe(DecreaseValue)
```

A `text_block variable` named **Label** is used to add a `text_block` to the Verse device. The `text_block` is used to render a string of text on a player's HUD. A `text_block` displays the message encoded to the Default Text variable  and controls the look and placement of the text using the following text block settings:

- `DefaultTextColor`
- `DefaultShadowColor`
- `DefaultShadowOffset`

```verse
        var Label:text_block = text_block:
            DefaultText := Text,
            DefaultTextColor := NamedColors.White,
            DefaultShadowColor:= color{R:=0.0, G:=0.0, B:=0.0},
            DefaultShadowOffset := option{vector2{X:=5.0, Y:=2.0}}
```

The three UI materials are added to `expressions` and controlled using `material_block`.

```verse
        RadialMaterialBlock := material_block:
            DefaultImage := RadialMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        StripeMaterialBlock := material_block:
            DefaultImage := StripeMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        DissolveMaterialBlock := material_block:
            DefaultImage := DissolveMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}
```

A `for expression` is used to determine when the UI appears on the screen and which UI to display on screen.

The UI appears on screen by finding each player in the playspace using `GetPlayspace().GetPlayers()`, then calls `GetPlayerUI[Player]` to return the player’s  `player_ui` class.  This is essential for adding a widget to a player's HUD/UI.

```verse
        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
```

Then in the `do expression`, a new `stack_box` named  **MyStackBox** is created  by using the StackBox UMG widget settings. Once the widget values are assigned to **MyStackBox**, a new variable named **MyUI** is assigned all the `MyStackBox` values at runtime.

This enables **MyUI** to use the StackBox widget properties and reference the material\_block to do the following:

- Use the StackBox’s `Orientation` property.
- Assign a `stack_box_slot` to each `material_block` , `text_block` , and `Label variable` within an array using `Slots:array expression` to organize the array objects.

```verse
        do:
            MyStackBox:stack_box = stack_box:
                Orientation := orientation.Vertical
                Slots := array:
                    stack_box_slot:
                        Widget := stack_box:
                            Orientation := orientation.Horizontal
                            Slots := array:
                                stack_box_slot:
                                    Widget := RadialMaterialBlock
                                    Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
                                stack_box_slot:
                                    Widget := StripeMaterialBlock
                                    Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
                                stack_box_slot:
                                    Widget := DissolveMaterialBlock
                                    Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
                    stack_box_slot:
                        Widget := texture_block:
                            DefaultImage := T_UI_MyTexture
                            DefaultDesiredSize := vector2{X := 256.0, Y := 256.0}
                    stack_box_slot:
                        Widget := Label
            set MyUI = MyStackBox
```

### Creating OnShow Functionality

Once the `TriggerShow.TriggeredEvent` is called, the `OnShow function` grabs all players in the playspace and their player UI, then adds the widget to their player UI using the MyUI value.

Lastly, the `RadialMaterial’s Progress` value is set to **1.0** at runtime, meaning the health or shield bar is full when the game begins.

```verse
    OnShow(InAgent: ?agent):void=
        Print ("Show")
        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            PlayerUI.AddWidget(MyUI)

        set RadialMaterial.Progress = 1.0
```

### Creating OnHide Functionality

To hide the UI material from the HUD  when the health or shield bar takes damage, the `OnHide function` uses a `for expression` to grab players in the playspace and the player UI, then update the player UI using `PlayerUI.RemoveWidget (MyUI)`.

```verse
    OnHide(InAgent: ?agent):void=
        Print ("Hide")
        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            PlayerUI.RemoveWidget(MyUI)
```

### Creating OnChange Functionality

The UI material changes its appearance based on values passed through the **`Progress` parameter**.  When the `TriggerChange.TriggeredEvent` occurs, the  `OnChange function` is called and updates the **Progress parameter** of  the `RadialMaterial` UI material based on `IncreaseValue` and `DecreaseValue`.

```verse
    OnChange(InAgent: ?agent):void=
        Print ("Change Material Parameter")
        set RadialMaterial.Progress =  RadialMaterial.Progress - 0.25
```

### Creating the IncreaseValue Functionality

The `IncreaseValue function` increases the **Progress parameter** values on the material by the predefined amounts for **Progress**, **Speed**, and **Dissolve**:

- Progress = **+1.0**
- Speed = **+0.1**
- Dissolve = **+0.025**

This change happens when players receive health or shield, they’ll see these increases reflected on their health and shield material on the HUD.

This code also works when applied to an enemy AI’s health and shield when a new AI spanws into the game.

```verse
    IncreaseValue(InAgent: agent):void=
        Print ("Increase Value of Material Parameter")
        set RadialMaterial.Progress +=  1.0
        set StripeMaterial.Speed +=  0.1
        set DissolveMaterial.Dissolve +=  0.025
```

### Creating the DecreaseValue Functionality

The `DecreaseValue function` decreases the **Progress parameter** values on the material by the predefined amounts for **Progress**, **Speed**, and **Dissolve**:

- Progress = **-1.0**
- Speed = **-0.1**
- Dissolve = **-0.025**

This change happens when players take damage to their health or shield, they’ll see these decreases reflected on their health and shield material on the HUD.

This code also works when applied to an enemy AI when the AI takes damage to their health or shields during the game.

```verse
    DecreaseValue(InAgent: agent):void=
        Print ("Decrease Value of Material Parameter")
        set RadialMaterial.Progress -=  1.0
        set StripeMaterial.Speed -=  0.1
        set DissolveMaterial.Dissolve -=  0.025
```

### On Your Own

If you have a radial material, striped material, or dissolve material you can copy and paste the following code into your own project to see how the `material_block` works on each material in the Verse code.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { /UnrealEngine.com/Temporary/UI }

# A Verse-authored creative device that can be placed in a level
materialblock_test_device := class(creative_device):

    Text<localizes><public> : message = "This is a Text Block."

    @editable
    TriggerShow:trigger_device = trigger_device{}
    @editable
    TriggerChange:trigger_device = trigger_device{}
    @editable
    TriggerHide:trigger_device = trigger_device{}
    @editable
    InputTriggerInc:input_trigger_device = input_trigger_device{}
    @editable
    InputTriggerDec:input_trigger_device = input_trigger_device{}        

    var MyUI:stack_box = stack_box{Orientation := orientation.Vertical}

    RadialMaterial:UI.MaterialBlock.MI_UI_MaterialBlock_Radial_material = UI.MaterialBlock.MI_UI_MaterialBlock_Radial_material {Progress := 1.0}
    StripeMaterial:UI.MaterialBlock.MI_UI_Stripe_material = UI.MaterialBlock.MI_UI_Stripe_material {Speed := 0.5}
    DissolveMaterial:UI.MaterialBlock.MI_UI_Dissolve_material = UI.MaterialBlock.MI_UI_Dissolve_material {Dissolve := 0.2}

    OnBegin<override>()<suspends>:void=
        Print ("Init")

        TriggerShow.TriggeredEvent.Subscribe(OnShow)
        TriggerChange.TriggeredEvent.Subscribe(OnChange)
        TriggerHide.TriggeredEvent.Subscribe(OnHide)
        InputTriggerInc.PressedEvent.Subscribe(IncreaseValue)
        InputTriggerDec.PressedEvent.Subscribe(DecreaseValue)

        var Label:text_block = text_block:
            DefaultText := Text,
            DefaultTextColor := NamedColors.White,
            DefaultShadowColor:= color{R:=0.0, G:=0.0, B:=0.0},
            DefaultShadowOffset := option{vector2{X:=5.0, Y:=2.0}}

        RadialMaterialBlock := material_block:
            DefaultImage := RadialMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        StripeMaterialBlock := material_block:
            DefaultImage := StripeMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        DissolveMaterialBlock := material_block:
            DefaultImage := DissolveMaterial
            DefaultDesiredSize := vector2{X:=400.0, Y:=400.0}

        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            MyStackBox:stack_box = stack_box:
                Orientation := orientation.Vertical
                Slots := array:
                    stack_box_slot:
                        Widget := stack_box:
                            Orientation := orientation.Horizontal
                            Slots := array:
                                stack_box_slot:
                                    Widget := RadialMaterialBlock
                                    Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
                                stack_box_slot:
                                    Widget := StripeMaterialBlock
                                    Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
                                stack_box_slot:
                                    Widget := DissolveMaterialBlock
                                    Padding := margin{Left:=0.0, Top:=100.0, Right:=0.0, Bottom:=32.0}
                    stack_box_slot:
                        Widget := texture_block:
                            DefaultImage := T_UI_MyTexture
                            DefaultDesiredSize := vector2{X := 256.0, Y := 256.0}
                    stack_box_slot:
                        Widget := Label
            set MyUI = MyStackBox

    
    OnShow(InAgent: ?agent):void=
        Print ("Show")
        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            PlayerUI.AddWidget(MyUI)

        set RadialMaterial.Progress = 1.0      

    OnHide(InAgent: ?agent):void=
        Print ("Hide")
        for:
            Player:GetPlayspace().GetPlayers()
            PlayerUI := GetPlayerUI[Player]
        do:
            PlayerUI.RemoveWidget(MyUI)

    OnChange(InAgent: ?agent):void=
        Print ("Change Material Parameter")
        set RadialMaterial.Progress =  RadialMaterial.Progress - 0.25

    IncreaseValue(InAgent: agent):void=
        Print ("Increase Value of Material Parameter")
        set RadialMaterial.Progress +=  1.0
        set StripeMaterial.Speed +=  0.1
        set DissolveMaterial.Dissolve +=  0.025

    DecreaseValue(InAgent: agent):void=
        Print ("Decrease Value of Material Parameter")
        set RadialMaterial.Progress -=  1.0
        set StripeMaterial.Speed -=  0.1
        set DissolveMaterial.Dissolve -=  0.025
```
