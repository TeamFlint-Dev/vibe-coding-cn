# 1. Overview of Coordinate Spaces

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/overview-of-coordinate-spaces
> **爬取时间**: 2025-12-27T00:24:10.000381

---

Coordinate Battle uses three different coordinate spaces during gameplay:

- **World space:** Coordinate space used to place objects in the game world through Verse API functions.
- **Board spac******e**:** Coordinate space used to position objects on the player game boards.
- **Miniboard space:** Coordinate space used to show players a view of their own board.

[![](https://dev.epicgames.com/community/api/documentation/image/e9f585a1-b8a5-4f85-85b9-e68c1f93111a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e9f585a1-b8a5-4f85-85b9-e68c1f93111a?resizing_type=fit)

These coordinate spaces combine to give a player an accurate view of the current game state and gameplay performance.

It takes planning and thought to design comprehensive coordinate space management. Most of the work is to convert between coordinate spaces so that you can reliably map vectors in world space to coordinates on the game board and to coordinates on the miniboard and back again.

You can see board space represented as the game board in the center of the image above **(1)** and miniboard space represented by the miniboard in the upper left corner of the image above **(2)**.

World space is the persistent coordinate system underlying UEFN and the Verse API functions. UEFN uses the **Left-Up-Forward (LUF)** three-dimensional coordinate system.

For more information about this coordinate system, see the [Left-Up-Forward Coordinate System](https://dev.epicgames.com/documentation/en-us/fortnite/leftupforward-coordinate-system-in-unreal-editor-for-fortnite) documentation.

## Coordinate Spaces

Each of the coordinate spaces in this experience requires converting locations onto different surfaces and different types to properly place game objects in the world. Below are descriptions of each of these spaces. These are discussed at greater depth later in this tutorial.

### World Space

World space is the default space that UEFN and Verse use to position objects in the game world. This game example primarily uses `creative_device` objects. As a result, the Verse class used to represent locations in the game world for devices is `transform` in the module `/UnrealEngine.com/Temporary/SpatialMath` with the definition:

```verse
transform<public> := struct<concrete><computes>:
	Scale<public>:vector3
	Rotation<public>:rotation
	Translation<public>:vector3
```

where `vector3` is defined as:

```verse
vector3<public> := struct<concrete><computes><persistable>:
	X<public>:float
	Y<public>:float
	Z<public>:float
```

The `transform` defines where an object is located (`Translation`), which direction it faces (`Rotation`), and how big it is (`Scale`).

Any object that derives from the class `creative_object` has access to Verse API functions to:

- `GetTransform`: Obtains the current transform data of an object.
- `TeleportTo`: Moves an object to the input destination with no animation.
- `MoveTo`: Animates movement to the input destination.

The definition of `transform` along with these API functions provide everything you need to define where an object lives in the game world and place it there.

### Board Space

Board space is the space used for the main game board in Coordinate Battle identified by callout **(1)** in the image above. This space is used to designate spaces or tiles on the board relative to the center of the game board.

### Miniboard Space

The miniboard shows players a view of their own board. **Hit markers** indicate that a board tile has been attacked and the enemy successfully destroyed a pawn at that tile. **Miss markers** indicate that a board tile has been attacked and the enemy did not hit anything. The miniboard itself is a static mesh placed with respect to the gameplay camera so it appears as part of the game user interface.

## Steps to Build

To use these three coordinate spaces together to create effective gameplay, you must:

1. Define a representation of a tile in board space.
2. Define the limits of the board space.
3. Define where the board space is located within the world space.
4. Convert between board space and world space.
5. Place a pawn on the board in a specific location.
6. Get a pawn from the board.
7. Remove a pawn from the board.
8. Randomly place all pawns on the board.
9. Define a representation of a tile in the miniboard space.
10. Define the limits of the miniboard space.
11. Define where the miniboard space is located in world space.
12. Place a marker on the miniboard.
13. Convert between miniboard space, board space, and world space.
14. Define the game moves.
15. Construct the game loop.
16. Determine when a win condition is met.
