# 5. Define the Miniboard

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/5-define-the-miniboard>
> **爬取时间**: 2025-12-27T00:24:04.604560

---

The miniboard shows a player a view of their own board. **Hit markers** indicate that a board tile has been attacked and the enemy successfully destroyed a pawn at that tile. **Miss markers** indicate that a board tile has been attacked and the enemy did not hit anything.

The miniboard itself is a static mesh placed with respect to the gameplay camera so it appears as part of the game user interface. To place the miniboard, a few things must be known:

- The gameplay camera transform.
- How far to offset the miniboard from the camera.
- The board grid size.
- The static mesh to use for the miniboard.

The camera transform can be accessed from the gameplay camera, so add a reference to the gameplay camera. The second can be done by trial and error through UEFN, so it can be an editable vector. The third can be accessed through a reference to the player's game board. The last can be stored through a reference to the asset generated through the Verse `Assets.digest.verse`.

The miniboard was created in UEFN Modeling mode to model a simple static mesh. It is named **SM\_Miniboard**.

[![](https://dev.epicgames.com/community/api/documentation/image/09ae6af9-b33c-4e7c-ab8a-9d97dc98c2c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/09ae6af9-b33c-4e7c-ab8a-9d97dc98c2c2?resizing_type=fit)

The gameplay camera is a fixed point camera looking down toward the game board.

[![](https://dev.epicgames.com/community/api/documentation/image/48e91fc8-540e-4d62-968a-ef99da64b9c8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48e91fc8-540e-4d62-968a-ef99da64b9c8?resizing_type=fit)

## Structure the Miniboard Class

To define the miniboard class, create a new Verse file named `miniboard.verse` and add a new Verse device named `miniboard`.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):
```

Add the variables previously discussed to the class:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):

    @editable
    CameraDevice:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

    @editable
    StaticMesh:mesh = Meshes.SM_Miniboard

    @editable
    Dimensions:vector3 = vector3{}

    @editable
    HitMarkerStaticMesh:mesh = Meshes.SM_Hit

    @editable
    MissMarkerStaticMesh:mesh = Meshes.SM_Miss

    @editable
    BoardOffsetFromCameraDevice:vector3 = vector3{}

    @editable
    GameBoard:board = board{}

    var<private> MiniboardProp:?creative_prop = false
```

## Place the Miniboard

To place the miniboard, construct a new function called `Position`. This function needs no information other than the transform of the `CameraDevice`, `StaticMesh`, and `BoardOffsetFromCameraDevice`.

The position function places the miniboard with respect to the gameplay camera to make it appear as if it is part of the game user interface.

This function performs the following steps:

1. Obtains the transform of the gameplay camera.
2. Predefines a rotation correction for the miniboard mesh.

   - The miniboard mesh is oriented so that it faces toward the **Up** or **Z** axis.
   - This rotation rotates the mesh so it faces toward the **Forward** or **X** axis.
3. Constructs the miniboard transform.

   - The translation of the miniboard starts at the camera, then adds the offset from the camera device, rotated to face the camera.
   - The rotation is made to face the camera and correct for the primary axis of the miniboard.
4. The miniboard prop is spawned and the static mesh is set.

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):

 ...

 Position<public>():void =
  CameraTransform := CameraDevice.GetTransform()
  StaticMeshRotationCorrection := MakeRotation(vector3{Y := 1.0}, -PiFloat/2.0)
  MiniboardTransform:transform = transform:
   Translation := CameraTransform.Translation + CameraTransform.Rotation.RotateVector(BoardOffsetFromCameraDevice)
   Rotation := CameraTransform.Rotation.RotateBy(StaticMeshRotationCorrection)
  MiniboardSpawnResult := SpawnProp(DefaultCreativePropAsset, MiniboardTransform)
  if (MiniboardPropTemp := MiniboardSpawnResult(0)?, MiniboardStaticMesh := StaticMesh?):
   MiniboardPropTemp.SetMesh(MiniboardStaticMesh)
   set MiniboardProp = MiniboardPropTemp
```

To place the miniboard once play begins, override the miniboard `OnBegin` function:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):
  
 ...

 OnBegin<override>()<suspends>:void =
  Position()
```

## Summary

To summarize, this page has taken you through the following steps:

1. Define a representation of a tile in miniboard space.
2. Define the limits of miniboard space.
3. Define where miniboard space is located in world space.

## Files

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Verse.org/Assets }
using { /UnrealEngine.com/Temporary/SpatialMath }
using { DataTypes }

miniboard<public> := class(creative_device):

     @editable
     CameraDevice:gameplay_camera_fixed_point_device = gameplay_camera_fixed_point_device{}

     @editable
     StaticMesh:mesh = Meshes.SM_Miniboard

     @editable
     Dimensions:vector3 = vector3{}

     @editable
     HitMarkerStaticMesh:mesh = Meshes.SM_Hit

     @editable
    MissMarkerStaticMesh:mesh = Meshes.SM_Miss

     @editable
     BoardOffsetFromCameraDevice:vector3 = vector3{}

     @editable
     GameBoard:board = board{}

     var<private> MiniboardProp:?creative_prop = false

 Position<public>():void =
  CameraTransform := CameraDevice.GetTransform()
  StaticMeshRotationCorrection := MakeRotation(vector3{Y := 1.0}, -PiFloat/2.0)
  MiniboardTransform:transform = transform:
   Translation := CameraTransform.Translation + CameraTransform.Rotation.RotateVector(BoardOffsetFromCameraDevice)
   Rotation := CameraTransform.Rotation.RotateBy(StaticMeshRotationCorrection)
  MiniboardSpawnResult := SpawnProp(DefaultCreativePropAsset, MiniboardTransform)
  if (MiniboardPropTemp := MiniboardSpawnResult(0)?, MiniboardStaticMesh := StaticMesh?):
   MiniboardPropTemp.SetMesh(MiniboardStaticMesh)
   set MiniboardProp = MiniboardPropTemp

 OnBegin<override>()<suspends>:void =
  Position()
```
