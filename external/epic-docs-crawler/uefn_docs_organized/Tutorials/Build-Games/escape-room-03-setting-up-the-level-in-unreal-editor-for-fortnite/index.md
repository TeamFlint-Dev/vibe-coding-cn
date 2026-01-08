# 3. Setting Up the Level

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-03-setting-up-the-level-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:17:20.068259

---

Once you’re done preparing the terrain and area you’re going to place the cabin, you need to create a hole in the landscape where you’ll build your basement and sub-basement underneath the cabin prefab.

Before you start adding props and prefabs to your project, create a series of folders in the Outliner to keep your escape room props and devices organized so you can easily find any set of devices or props you need when you’re tweaking your project later.

[![Organize your project with named folders in the Outliner.](https://dev.epicgames.com/community/api/documentation/image/83f082d8-efe9-4684-86ff-e742d4759bdf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83f082d8-efe9-4684-86ff-e742d4759bdf?resizing_type=fit)

## Creating the Cabin Basement

You will need the following prefabs and galleries to build your base:

- **Cozy Cabin**: Navigate to **All** > **Fortnite** > **Prefabs** > **Lonely Lodge** for this prefab. This building will be the creepy cabin in the woods.
- **Brick Simple AAA Solid Wall**: Navigate to **All** > **Fortnite** > **Galleries** > **Building** for the next items. These architectural assets will be used to build the walls, floors, and ceiling of the basement. There are a number of styles for Brick Simple AAA, the ones used in this project use the walls with the **Concrete** and **House Interior** materials.
- **Business Floor A**: This floor separates the sub basement from the basement.
- **Concrete Solid**: This floor is used as the sub basement flooring.
- **Vent Wall NoDoor Bottom**: This wall piece will lead to the secret room in the sub basement.
- **Catwalk Stairs R**: These stairs lead out of the sub basement.
- **Asteria HarvestHome Railing**: Block in the catwalk stairs so players don’t fall off the stairs.
- **Agency Flat SideDoorway**: Place this door at the top of the catwalk stairs.
- **Agency DoorFrame Cntr**: Place this door leading to the basement entrance.
- **Boardwalk Archway**: Place this under the cabin to raise it up off the ground so players can easily exit the hidden basement.
- **Hexylvania** **Castle Gothic D Stairs**: Place these in front of the deck on the front of the cabin.
- **Durr Burger**: This is where you will film the first cut scene.
- **CobbleStone Solid**: Place this in front of the Durr Burger restaurant to create a path to the entrance of the restaurant.
- **PowerPlant Parking Arrows**: To create the in and out arrows for the restaurant parking lot.
- **PowerPlant Stripe**: To create the parking spaces in the parking lot.

To create the hole in the terrain, do the following.

1. Select **Cozy Cabin** from the **Prefabs** folder and drag it into the viewport.
2. Select **Landscape Mode** from the Selection dropdown menu.
3. Select the **Visibility** tool from the **Sculpt tools** and use the following settings:

   1. **Brush Type**: Simple Circular Brush
   2. **Brush Falloff**: Sharp Linear Falloff
   3. **Brush Size**: 600
   4. **Brush Falloff**: 0.3
4. Left-click the terrain underneath the cabin to make the terrain disappear, making sure not to click on terrain outside the perimeter of the cabin.

   [![Use the Visibility tool to create the basement hole.](https://dev.epicgames.com/community/api/documentation/image/b9c8b0a6-985c-4c3f-834f-0880107c8154?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b9c8b0a6-985c-4c3f-834f-0880107c8154?resizing_type=fit)

   [Hide](https://dev.epicgames.com/documentation/en-us/uefn/outliner-tips-and-tricks-in-unreal-editor-for-fortnite) the floor of the cabin in the **Outliner** and use the visibility tool inside the cabin to make sure you’re not taking away terrain from outside the cabin perimeter.
5. Select the **Brick Simple AAA Solid Wall** and place it just below the bottom of the hole continuing to add another wall beneath the one you just placed.
6. Continue adding wall pieces until you have the basement roughed out.

   If grid snapping is on, use **Transform** > **Location** in the **Details** panel to place your architectural pieces exactly where you want them.
7. Select the **Business Floor A** floor pieces and place them at the bottom of the basement wall pieces.
8. Select the **Concrete Solid** floor and place the pieces at the bottom of the sub basement walls.
9. Place the catwalk stairs in the corner of the sub basement.
10. Place the **Asteria HarvestHome Railing** on the open side of the stairs.
11. Place the **Agency** door in front of the catwalk stairs.
12. Place a wall on the other side of the stairs to create a stairwell.

    [![Create a stairwell with the catwalk stairs, door, railing and wall pieces.](https://dev.epicgames.com/community/api/documentation/image/144f2b3a-1a68-419d-ab7f-dd50609075ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/144f2b3a-1a68-419d-ab7f-dd50609075ab?resizing_type=fit)
13. Place the **Vent Wall NoDoor Bottom** behind and underneath the stairs to begin creating the secret room.
14. Create a small secret room behind the **Vent Wall NoDoor Bottom** wall with the **Brick Simple AAA Solid Wall** pieces and the **Concrete Solid** floor.

    [![Create a secret room behind the stairs](https://dev.epicgames.com/community/api/documentation/image/ab7a025f-dcf1-4f07-8876-391d0d9acb0b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ab7a025f-dcf1-4f07-8876-391d0d9acb0b?resizing_type=fit)
15. Click on the **Place Actors** dropdown menu and select **Volume** > **FortUnderground Volume**. This stops players from falling out of your level because there’s no terrain underneath the sub basement.

    [![Create a Fortunderground Volume.](https://dev.epicgames.com/community/api/documentation/image/e60ee243-8b64-4694-add1-f68e49226f10?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e60ee243-8b64-4694-add1-f68e49226f10?resizing_type=fit)
16. Place the **Fortunderground Volume** into the hole and change the **Scale** of the volume to make it fit around the sub basement.

    [![Place the volume in the hole and around the basement architectural meshes.](https://dev.epicgames.com/community/api/documentation/image/5b5cfc74-c578-458e-aa28-309a7409019e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5b5cfc74-c578-458e-aa28-309a7409019e?resizing_type=fit)

The basement and sub basement are complete, now to raise the cabin so players escaping the basement have room to exit the basement underneath the cabin.

1. Transform the cabin so it is above the basement, and not resting directly on top of the hole.
2. Select the **Boardwalk Archway** architectural mesh and place it around the basement hole.
3. Transform the cabin on top of the **Boardwalk Archway** meshes.
4. Select the **Hexylvania Castle Gothic D Stairs** and attach them to the front of the deck.

   [![Move the cabin up and place boardwalk archway meshes underneath and Hexylvania castle gothic stairs in front of the deck.](https://dev.epicgames.com/community/api/documentation/image/d75aed96-a027-4c7d-90f7-bbf38261c5f5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d75aed96-a027-4c7d-90f7-bbf38261c5f5?resizing_type=fit)

Next you’ll create the Durr Burger restaurant area where you’re going to film the cut scene for the beginning of the game.

## Designing the Durr Burger Parking Lot

You’ll need to add a parking lot next to the Durr Burger prefab to make the scene look more realistic. Think about roadside diners that you’ve seen and incorporate the elements that make a roadside diner to this area.

1. Select the **Durr Burger** prefab and place it on the terrain facing the wooded area across the street.

   [![Create the restaurant and parking lot across from the woods.](https://dev.epicgames.com/community/api/documentation/image/669d0d7d-3d11-4a2a-9120-026942fe5540?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/669d0d7d-3d11-4a2a-9120-026942fe5540?resizing_type=fit)
2. Select the **Concrete Solid** floor mesh and add it next to the Durr Burger to create the parking lot.
3. Use the **PowerPlant** arrows and lines to create a parking lot.
4. Add the **Cobblestone Solid** floor in front of the Durr Burger to create a cobble stone path leading to the restaurant door.
5. Place a **Player Spawner** in the parking lot.

   [![Create a realistic looking parking lot for the Durr Burger.](https://dev.epicgames.com/community/api/documentation/image/b0543f28-07fb-4e2e-972e-f9675756ac49?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0543f28-07fb-4e2e-972e-f9675756ac49?resizing_type=fit)

Don’t worry if dirt patches show around the edges of the parking lot, or if flowers or grass poke up in the parking lot, this adds to the realistic look and feeling of the restaurant being in a remote location.

## Adding Props

An assortment of props were used to add detail to each of the basement rooms and Cozy Cabin. Spatial presence in the basement informs the player about the type of place they’re in and how they can move about the sub basement and basement.

Props used to decorate the basement areas need to be rustic and support the impression that the player is in danger. A quick internet search for **abandoned cabin images** will provide you with examples of how to style your escape room.

Add lights to the rooms in the basement in the cabin kitchen to add light to the space. Next you’re going to change the color of the lights to red.

To add trees, bushes, and any other vegetation, use [Foliage Mode](https://dev.epicgames.com/documentation/en-us/fortnite/foliage-mode-in-unreal-editor-for-fortnite) to quickly dress your scene.

[![Use various trees and other vegetation to create a thick wooded area.](https://dev.epicgames.com/community/api/documentation/image/00f94034-6b47-495d-90fd-01c94df9e391?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/00f94034-6b47-495d-90fd-01c94df9e391?resizing_type=fit)

## Next Section

Once you've got the basic game structure and cabin designed, you'll need to start adding the game mechanics to the escape room, going room-by-room to make sure the gameplay is interesting and challenging.

[![4. Holding Area](https://dev.epicgames.com/community/api/documentation/image/da766a5a-071a-4bf6-996a-469de13faa2b?resizing_type=fit&width=640&height=640)

1. Holding Area

Create the first room where players spawn and escape.](<https://dev.epicgames.com/documentation/en-us/fortnite/escape-room-04-holding-area-in-unreal-editor-for-fortnite>)
