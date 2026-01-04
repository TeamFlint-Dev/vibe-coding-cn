# Pacific Break Galleries

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/pacific-break-galleries-in-fortnite
> **爬取时间**: 2025-12-26T23:13:38.265458

---

Pacific Break theme galleries bring the West Coast vibes for you to create your own sun-soaked paradise in Fortnite Creative and Unreal Editor for Fortnite (UEFN).

The galleries include building pieces to make unique structures, along with environmental and prop pieces. Some props include gameplay functionality.

The assets are available in the following locations:

- **Creative:** From the **Content Menu** > **Galleries**category.
- **UEFN:** From the **Content Browser** > **All** > **Fortnite** > **Galleries** folder.

In UEFN, you can access specific foliage, decals, and landscape textures that are used throughout the Pacific Break theme map in Chapter Seven. Create a beautiful landscape with textures and foliage, and leave a mark on the map with unique graffiti decals.

This page is a visual guide to help you find the theme assets you need to design your island. 

**Known Issue:**In UEFN, you can see glass on some gallery assets, like windows, in the editor. However, the glass does not render in-game; that is, players will not see it.

## Wonkeeland

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Wonkyland Wall | Wonkeeland Floor | Wonkeeland Roof |
|  |  |  |
| Wonkeeland Prop | Wonkeeland Foundation |  |

In the Wonkeeland Prop gallery, the following props include logic for dynamic interactions with players:

- Ferris Wheel
- Water Slide
- Water Jet Impusler
- Lazy River Tube

You must use the Water Jet Impusler and Lazy River Tube props with a water volume to activate the unique gameplay. To learn more, see [Water Devices](https://dev.epicgames.com/documentation/en-us/fortnite/using-water-devices-in-fortnite-creative).

## Tiptop Terrace

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Tiptop Terrace Floor | Tiptop Terrace Wall | Tiptop Terrace Roof |
|  |  |  |
| Tiptop Terrace Prop | Tiptop Terrace Nature |  |

## Bumpy Bay

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Bumpy Bay Floor | Bumpy Bay Wall | Bumpy Bay Roof |
|  |  |  |
| Bumpy Bay Prop | Bumpy Bay Foundation | Bumpy Bay Nature |

## Battlewood Boulevard

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Battlewood Boulevard Floor | Battlewood Boulevard Wall | Battlewood Boulevard Roof |
|  |  |  |
| Battlewood Boulevard Prop | Battlewood Boulevard Foundation | Battlewood Boulevard Nature |

## Classified Canyon

|  |  |  |  |
| --- | --- | --- | --- |
|  |  |  |  |
| Classified Canyon Wall | Classified Canyon Floor | Classified Canyon Prop | Classified Canyon Particle Collider |
|  |  |  |  |
| Classified Canyon Foundation | Classified Canyon Secret Facility | Classified Canyon Nature |  |

## Ripped Tides

|  |  |  |
| --- | --- | --- |
|  |  |  |
| Ripped Tides Wall | Ripped Tides Floor | Ripped Tides Roof |
|  |  |  |
| Ripped Tides Prop | Ripped Tides Skateboard Park |  |

## UEFN Environment Assets

In UEFN, you can find additional Chapter Seven theme content like foliage, landscape textures, and decals, to add to your gallery builds.

### Decals

There are over 20 graffiti styles shown in the galleries, available as decal textures for you to create additional variation on your island. Decals are designs you can apply to a surface.

The textures are located in the **Content Browser** under **All** > **Fortnite** > **Textures** > **Decals**.

You can add decals to your island:

- With the [Decal device](https://dev.epicgames.com/documentation/en-us/fortnite/decal-device-in-unreal-editor-for-fortnite), and adding the texture to the **Decal Mask** option in the **Details** panel.
- With a **deferred decal material**, and placing it within the **decal actor**.

#### Making Materials from Decal Textures

To create a material from the decal texture:

1. Right-click the texture and choose **Create Material**.
2. Save the material, then open it to see the connected texture.
3. In the Details panel, set the **Material Domain** option to **Deferred Decal** and the **Blend Mode** option to **Translucent**.
4. Connect the texture's **Alpha** pin to the **Opacity** channel.

To learn more about creating this type of actor, see the [Decal Materials](https://dev.epicgames.com/documentation/en-us/unreal-engine/decal-materials-in-unreal-engine?application_version=5.5) Unreal Engine page.

### Landscape Textures

Themed landscape textures are exposed in UEFN for you to create landscape materials. The textures are available in the **Content Browser** under **All** > **Fortnite** > **Textures** > **Landscape**.

You add the textures to existing or new material instances created from the landscape materials located in **All** > **Fortnite** > **Materials** > **Landscape**. To learn more, see [Editing Landscape Material](https://dev.epicgames.com/documentation/en-us/fortnite/editing-landscape-material-in-unreal-editor-for-fortnite).

For in-depth information on the material type, check out the [Landscape Materials](https://dev.epicgames.com/documentation/en-us/unreal-engine/landscape-materials-in-unreal-engine?application_version=5.5) Unreal Engine page.

### Foliage

Fill your landscape with foliage from the Chapter Seven biomes. UEFN includes a Foliage Mode for placing these dynamic assets. To learn more, see [Foliage Mode](https://dev.epicgames.com/documentation/en-us/fortnite/foliage-mode-in-unreal-editor-for-fortnite).

The foliage assets are available in the **Content Browser** under **All** > **Fortnite** > **Environment** > **Foliage**.
