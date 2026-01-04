# 2. Create the Island

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-2-create-the-island-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:16:45.625999

---

**Devices used:**

- 4 x [Barrier](https://www.fortnite.com/en-US/creative/docs/using-barrier-devices-in-fortnite-creative)

You will need the following prefabs and galleries to build your base:

- **Castle Keep Prefab**: Navigate to **All > Fortnite > Prefabs > Castle** for this prefab. These are the buildings that will be the team bases. You'll need two.
- **Castle Gallery B**: Navigate to **All > Fortnite > Galleries** for the next items. These pieces have no snow, so they are useful for using indoors if you want to change how the inside of the castle prefab looks.
- **Castle Gallery C**: This gallery has some outdoor building pieces that have snow on them, but it also has walls and doors.
- **Castle Gallery D**: This gallery has castle building pieces that have snow on them, including ramps and stairs.
- **Military Gallery B Red, Military Gallery B Blue**: These have colored plaques to place on walls of bases to further identify the team each base belongs to.
- **Castle Prop Gallery**: Found in **All > Fortnite > Props > Castle**, this gallery contains props for the inside of the castle, such as furniture, torches, banners, and other decorations.
- **Ice House Gallery**: Found in **All > Fortnite > Props > Ice House**, this has the ice walls you need for the underground part of the map.

When using the [**Content Browser**](unreal-editor-for-fortnite-glossary#content-browser), hold down **Ctrl** and select multiple folders to display their contents at the same time.

Each base will have a basement and an underground path that connects the two bases. You will need to make a space for the underground part before placing the bases.

1. Locate a wall piece in one of your galleries. Place the wall piece a few tiles away from the center of the island.
2. Stack two more wall pieces on top of the first, so you have a wall that is three tiles high.
3. Locate a floor piece in one of your galleries. Place it at the top of the wall you built in the previous step. Add more floor pieces to set the desired distance between the bases.
4. Place the two castles facing each other and connected to the line of floor pieces.

   [![Build Up From the Grid](https://dev.epicgames.com/community/api/documentation/image/fe63de94-ffd9-4b33-8629-86ef3c7c1b2a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fe63de94-ffd9-4b33-8629-86ef3c7c1b2a?resizing_type=fit)
5. Use the ice walls from the **Ice House Gallery** and the ice floors from the **Ice and Snow Floor Gallery** to build out a basement area that connects the bases underground. Include plenty of places for players to hide or gain cover, and place props and torches.

   [![Basement](https://dev.epicgames.com/community/api/documentation/image/f145d19e-25c6-4926-8351-61844d52e075?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f145d19e-25c6-4926-8351-61844d52e075?resizing_type=fit)
6. Expand the line of floor tiles to create the courtyard area between the castles. There are lots of ways to do that, but see the image below for an example.

   [![Finished Bases](https://dev.epicgames.com/community/api/documentation/image/98287b49-bc4f-483c-a534-c41722f9a576?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/98287b49-bc4f-483c-a534-c41722f9a576?resizing_type=fit)

Remember to save your progress!

[![savegame](https://dev.epicgames.com/community/api/documentation/image/19f1a407-adc5-4f78-a08c-61d81b973203?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19f1a407-adc5-4f78-a08c-61d81b973203?resizing_type=fit)

## Add Colored Elements to Each Base

Next, add colored props and decorations that let the players know which base belongs to which team. The example uses red and blue, but you can choose any two colors. To follow this tutorial more easily, use red and blue.

[![Blue Base](https://dev.epicgames.com/community/api/documentation/image/8f934822-6bd4-43ba-9e7e-eb20db44b071?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f934822-6bd4-43ba-9e7e-eb20db44b071?resizing_type=fit)

The torches are customizable lights, so you can change the color of a light to red or blue depending on where you place it, then copy and paste the customized torch.

Use the elements in the blue and red Military Galleries to further identify each team’s base.

## Create Island Boundaries

Once your base is built out and you've added red and blue props to identify each side, you can place **Barrier devices** around the area. The play area includes the two bases and the courtyard area between them. The underground area has the same dimensions as the above-ground play area.

Place the Barrier devices against the outer walls of the play area so players can’t accidentally leave the play area or get stuck.

Configure the **User Options** for the first barrier as follows:

| Option | Value | Explanation |
| --- | --- | --- |
| **Barrier Material** | Choose one | The material you select is a matter of personal preference. |
| **Base Visible During Game** | False | The barrier device shouldn't be visible to players. |
| **Block Weapon Fire** | True | Weapon fire can't go through the barrier. |
| **Zone Shape** | Hollow Box | Players will spawn inside the barrier this way. |

[Playtest your island](playtesting-your-island-unreal-editor-for-fortnite) at any time by clicking the "Launch Session" button.

[![Launch Session](https://dev.epicgames.com/community/api/documentation/image/f72bd67a-e472-4dac-aeff-859616eb5abb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f72bd67a-e472-4dac-aeff-859616eb5abb?resizing_type=fit)

## Next Section

[![3. Set Up Classes and Teams](https://dev.epicgames.com/community/api/documentation/image/5793afeb-2869-4a2b-9d1e-34a0ceac499b?resizing_type=fit&width=640&height=640)

3. Set Up Classes and Teams

Use Class Designer devices to set up classes and the Team Settings device to configure the teams.](https://dev.epicgames.com/documentation/en-us/fortnite/capture-the-flag-3-set-up-the-classes-and-teams-in-unreal-editor-for-fortnite)
