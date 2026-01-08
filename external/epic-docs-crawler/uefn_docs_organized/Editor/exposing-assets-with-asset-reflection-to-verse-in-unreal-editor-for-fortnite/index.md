# Exposing Assets with Asset Reflection to Verse

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/exposing-assets-with-asset-reflection-to-verse-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:03:01.543923

---

You can expose your assets in UEFN to Verse so that you can use them from your Verse code. This is called **asset reflection**, and you can use it to insert images in your custom UI or use meshes for your custom props.

When you expose an asset to Verse, the name of the asset becomes the [identifier](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#identifier), a compiler symbol, that you can then use in your Verse code, and you can access your asset from its [Verse Path](modules-and-paths-in-verse). Naming of assets should follow the [naming conventions and rules](https://dev.epicgames.com/documentation/en-us/fortnite/verse-code-style-guide-in-unreal-editor-for-fortnite) for identifiers. You can see all of your assets that are exposed to Verse in your project's **Assets.digest.verse** file.

For the Assets.digest.verse file to be generated, you must have at least one Verse file in your project before building Verse code.

For example, if your texture has the name MyTexture, it'll appear in your **Assets.digest.verse** file as `MyTexture<scoped {MyProject}>:texture_2d = external {}`.

When you place your assets in subfolders in the project **Content** folder, the subfolder name becomes the name of the Verse module. For example, when you create a custom mesh named **MySphere** and it's in the subfolder **Meshes** of the project **Content** folder, you must qualify the name of the mesh with the module (subfolder) name in code, such as `Meshes.MySphere`.

Currently, you can expose the following types of assets to Verse:

- Meshes
- Textures
- Materials
- Niagara VFX Particle Systems

The following sections describe how to set up each kind of asset to be available in your Verse code.

## Meshes

To be able to reference your meshes in your Verse code, you must:

1. [Model](modeling-mode-in-unreal-editor-for-fortnite) your mesh in UEFN, or import a mesh into your project.

   Assets that you [import from Fab](import-from-fab-in-unreal-editor-for-fortnite) must be added as a modifiable Unreal Engine asset for them to show in the **Assets.digest.verse** file. You currently cannot use referenced assets from Fab in your Verse code.
2. Save the mesh by choosing **File > Save All**.
3. Verify that the name of your mesh appears in your project **Assets.digest.verse** file.

You can then use your mesh with Verse APIs, such as setting the mesh on a Creative prop.

The following example is a [Verse-authored device](create-your-own-device-in-verse) that spawns a prop when the game starts. The example uses a mesh named **MySphere** that was in the subfolder **Meshes** of the project **Content** folder.

[![MySphere in Meshes subfolder of project's content folder](https://dev.epicgames.com/community/api/documentation/image/ccf878e1-97ef-49a4-9610-ea870db93395?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ccf878e1-97ef-49a4-9610-ea870db93395?resizing_type=fit)

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }

# A Verse-authored creative device that spawns a prop and sets its mesh.
my_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends> : void =
        SpawnLocation := transform:
            Translation := vector3{X := 0.0, Y := 0.0, Z := 0.0}
            Rotation := IdentityRotation()
            Scale := vector3{X := 1.0, Y := 1.0, Z := 1.0}

        SpawnPropResult := SpawnProp(DefaultCreativePropAsset, SpawnLocation)

        # The result of SpawnProp() is a tuple, where the first element is an optional creative prop
        if (SpawnedProp := SpawnPropResult(0)?):
            SpawnedProp.SetMesh(Meshes.MySphere)
```

[![Set static mesh on custom spawned prop in Verse](https://dev.epicgames.com/community/api/documentation/image/d9955bae-6db6-40c2-ad22-e696f207ada8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d9955bae-6db6-40c2-ad22-e696f207ada8?resizing_type=fit)

## Textures

To be able to reference your texture in your Verse code, you must:

1. Import your texture into UEFN.

   Assets that you [import from Fab](import-from-fab-in-unreal-editor-for-fortnite) must be added as a modifiable Unreal Engine asset for them to show in the **Assets.digest.verse** file. You currently cannot use referenced assets from Fab in your Verse code.
2. Save the texture by choosing **File > Save All**.
3. Verify that the name of your texture appears in your project's **Assets.digest.verse** file.

You can then use your texture with Verse APIs, such as [Verse UI](creating-in-game-ui-in-verse).

## Materials

To be able to reference your material in your Verse code, you must:

1. Create your material in UEFN.
2. Verify that the name of your material appears in your project’s **Assets.digest.verse** file.

You can then use your material with Verse APIs, such as [Verse UI](creating-in-game-ui-in-verse) and setting the material on creative props.

[![Material location in the content browser for the set material example](https://dev.epicgames.com/community/api/documentation/image/e5b7a55f-38c4-4635-bf7d-9633d601862b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5b7a55f-38c4-4635-bf7d-9633d601862b?resizing_type=fit)

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }
 
my_device := class(creative_device):
 
    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        SpawnLocation := transform:
            Translation := vector3{X := 0.0, Y := 0.0, Z := 0.0}
            Rotation := IdentityRotation()
            Scale := vector3{X := 1.0, Y := 1.0, Z := 1.0}
 
        SpawnPropResult := SpawnProp(DefaultCreativePropAsset, SpawnLocation)
 
        # The result of SpawnProp() is a tuple, where the first element is an optional creative prop
        if (SpawnedProp := SpawnPropResult(0)?):
            SpawnedProp.SetMaterial(Materials.MyMaterial)
```

[![Material set on the spawned prop](https://dev.epicgames.com/community/api/documentation/image/fe3a45ef-7047-4c4a-8adb-d25b4113b523?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe3a45ef-7047-4c4a-8adb-d25b4113b523?resizing_type=fit)

### Material Parameters

When you create a material and add parameters to it, those parameters appear as fields on the material class in the **Assets.digest.verse** file. When you set your material on a mesh, you can then modify the parameters on the material in Verse at runtime.

The following parameter types from your material can be exposed in Verse:

| Material Parameters | Verse Type | Description |
| --- | --- | --- |
| [scalar](https://dev.epicgames.com/documentation/en-us/unreal-engine/material-parameter-expressions-in-unreal-engine#scalarparameter) | [`float`](float-in-verse) | A single floating point value. |
| [texture](https://dev.epicgames.com/documentation/en-us/unreal-engine/material-parameter-expressions-in-unreal-engine#textureobjectparameter) | [`texture`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/assets/texture) | A parameter for accessing and setting the texture on a material. |
| [vector4](https://dev.epicgames.com/documentation/en-us/unreal-engine/material-parameter-expressions-in-unreal-engine#vectorparameter) | [`color`](https://dev.epicgames.com/documentation/en-us/uefn/verse-api/versedotorg/colors/color) | The `color` struct in Verse only contains three elements, RGB. If you need a fourth element, or to represent the alpha for a color, you'll need to use an additional scalar parameter. |

The following example uses a material named **ConcreteMaterial** with a vector4 parameter named **MyRandomColor**.

[![ConcreteMaterial setup and definition](https://dev.epicgames.com/community/api/documentation/image/f4390da9-d2da-4c8c-bf04-25b28af06298?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4390da9-d2da-4c8c-bf04-25b28af06298?resizing_type=fit)

This is what appears in the **Assets.digest.verse** file for this material:

```verse
ConcreteMaterial_material<scoped {ParameterizedMaterialsTest}> := class<final><public>(material):
    var Specular:float = external {}

    var WorldPositionOffset:color = external {}

    var BaseTexture:texture = external {}

ConcreteMaterial<scoped {ParameterizedMaterialsTest}>:material = external {}
```

To be able to access and update the parameters on this material, you must instantiate your material in your Verse code first. In the following example, the material is instantiated and then set on a mesh before the parameters are modified.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Colors }
using { /Verse.org/Random }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# A Verse-authored creative device that spawns three props and randomly changes their color
material_color_test_device := class(creative_device):

    # Reference to the parameterized material in the Assets.digest.verse file.
    MyParameterizedMaterial:ConcreteMaterial_material = ConcreteMaterial_material{}

    OnBegin<override>()<suspends>:void=

        Offset:vector3 = vector3:
            X := 200.0
            Y := 0.0
            Z := 0.0

        # Spawn several props to apply the material to.
        SpawnResult1 := SpawnProp(DefaultCreativePropAsset,GetTransform().Translation,          GetTransform().Rotation)
        SpawnResult2 := SpawnProp(DefaultCreativePropAsset,GetTransform().Translation + Offset, GetTransform().Rotation)
        SpawnResult3 := SpawnProp(DefaultCreativePropAsset,GetTransform().Translation - Offset, GetTransform().Rotation)

        # Set the material on each of the props.
        if:
            Prop1 := SpawnResult1(0)?
            Prop2 := SpawnResult2(0)?
            Prop3 := SpawnResult3(0)?
        then:
            Prop1.SetMaterial(MyParameterizedMaterial)
            Prop2.SetMaterial(MyParameterizedMaterial)
            Prop3.SetMaterial(MyParameterizedMaterial)

            # Randomize the color on the parameterized material.
            loop:
                set MyParameterizedMaterial.MyRandomColor = color:
                    R := GetRandomFloat(0.0, 1.0)
                    G := GetRandomFloat(0.0, 1.0)
                    B := GetRandomFloat(0.0, 1.0)
                Sleep(0.20)
```

## VFX Assets and Particle Systems

To be able to reference your Niagara VFX particle system in your Verse code, you must:

1. Create your particle system in UEFN.
2. Verify that the name of your particle system appears in your project’s **Assets.digest.verse** file.

You can then spawn the particle system using the `SpawnParticleSystem()` function. The following example uses a particle system named **MyParticleSystem** that was in the subfolder **VFX** of the project's **Content** folder.

[![MyParticleSystem in VFX subfolder of project's content folder](https://dev.epicgames.com/community/api/documentation/image/3f74c26a-1657-4d2f-b239-b88ed326cf87?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f74c26a-1657-4d2f-b239-b88ed326cf87?resizing_type=fit)

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Assets }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that spawns a VFX particle system
vfx_test_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        loop:
            # Spawns a VFX particle system at the given Translation
            MyVFX:cancelable = SpawnParticleSystem(MyParticleSystem, GetTransform().Translation)

            # Let the VFX play for 3 seconds
            Sleep(3.0)

            # Stop the VFX
            MyVFX.Cancel()
```

## Known Limitations

The following lists current limitations with asset reflection:

- When you use `SetMesh` on a prop, the material of the new mesh might not show up in the prop because some props in the Creative toolset have an override material defined. If the prop has no override material, when you change the mesh, the material of the new mesh is used.
- Giving an asset the same name as another identifier in your project will result in compilation errors. For example, a project with the structure shown below will not compile because there is an asset called `MyMesh` and a folder called `MyMesh`. The folder or the asset would have to be renamed for the code to compile.

  - MyFolder /

    - MyMesh.uasset
    - MyMesh /

      - MyOtherMesh.uasset

### Troubleshooting

If you’re encountering issues with updating your **Assets.digest.verse** file or compiling your asset reflection code, try the fixes below.

- Do not use Verse [keywords](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#keyword) such as `set` or `block` as the name of any assets or folders. The **Assets.digest.verse** file creates Verse identifiers from these names. Using a keyword as a Verse identifier will cause compilation errors. See the [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-language-quick-reference) for a list of Verse keywords.
- Do not use the names of Verse APIs or API members as the name of assets or folders. See the [Verse API Reference](https://dev.epicgames.com/documentation/en-us/fortnite/verse-api).
- Follow the Verse [naming conventions](https://dev.epicgames.com/documentation/en-us/fortnite/verse-code-style-guide-in-unreal-editor-for-fortnite) when naming your assets and folders, or they may be skipped in the digest file generation.
- If you are trying to reference an asset outside of its module, you could receive an access error. This is because modules have the `<internal>` [access specifier](specifiers-and-attributes-in-verse) by default. To fix the error, you need to add the `<public>` access specifier to the module declaration. If the module was specified by creating a folder in your project, you need to change the module accessibility in your code. For example, in the following project structure, `Materials`, `Meshes`, and `Textures` are submodules of the `Watermelon` module.

  - MyProject /

    - MiniGame /

      - MiniGameAssets /

        - Watermelon /

          - Materials /
          - Meshes /

            - Watermelon.uasset
          - Textures /
    - hello\_world\_device.verse

The following code in `hello_world_device.verse` changes the `Meshes` module's accessibility to public.

```verse
MiniGame := module:
    MiniGameAssets<public> := module:
        Watermelon<public> := module:
            Meshes<public> := module {}
```

Now the project's `hello_world_device.verse` file can reference the `Watermelon.uasset` in code using the path `MiniGame.MiniGameAssets.Watermelon.Meshes.Watermelon`.

If an identifier causes an error in your Verse code, it will likely cause an error as the name of an asset or folder. Check potential asset and folder names by typing them as identifiers in code first.

## Enable Asset Reflection

With the release of 26.00, the ability to expose assets from UEFN to Verse is enabled by default for all newly created UEFN projects. For any of your projects created before 26.00, you will need to enable this feature by following these steps:

1. Close your project in UEFN.
2. Locate the **.uplugin** file in the project directory.
3. Open the **.uplugin** file in a text editor.
4. Find the property **EnableVerseAssetReflection** and set it to **true**.
5. If no such property is present, add the following line under **VersePath**:
   `"EnableVerseAssetReflection" : true,`
6. Save the **.uplugin** file.
7. Re-open your project in UEFN.
