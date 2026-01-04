# Creating Clothing Assets for UEFN using Unreal Engine

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-clothing-assets-for-unreal-editor-for-fortnite-using-unreal-engine
> **爬取时间**: 2025-12-27T00:08:03.196650

---

The Unreal Editor for Fortnite supports Unreal Engine's [Chaos Cloth Simulation](https://dev.epicgames.com/documentation/unreal-engine/cloth-simulation-in-unreal-engine). This system provides accurate and performant cloth simulation for any real-time experience.

You can author your **clothing meshes** on any **Digital Content Creation (DCC) package** and import it to **Unreal Engine** to convert them to **clothing assets**. You can then import these assets into UEFN and use them in-game with the Chaos Cloth component.

As part of the Talisman: MetaHuman template, you can access several downloadable assets including an Unreal Engine project with the MetaHuman wearing Captain Roux's jacket from the Talisman GDC demo. To learn how to access the downloadable files, see the [Talisman MetaHuman Template tutorial](talisman-metahuman-template-in-unreal-editor-for-fortnite).

[![The process of creating and Cloth Asset and importing it to UEFN](https://dev.epicgames.com/community/api/documentation/image/fffad446-a4fc-432b-bd04-86f1657d4600?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fffad446-a4fc-432b-bd04-86f1657d4600?resizing_type=fit)

This document will guide you through the process of creating a clothing asset in Unreal Engine and importing it into your UEFN experience.

We will not cover the creation process for the clothing meshes, as they can vary depending on your DCC package of choice.

## Design your Clothing Meshes

The first step when creating clothing assets is to create your cloth meshes in an external Digital Content Creation (DCC) package, such as Maya, Blender, or Marvelous Designer.

1. Import your skeletal mesh into your DCC and use it to create the cloth meshes. In the example below, we imported our MetaHuman skeletal mesh into Marvelous Designer to create our clothing meshes.

   [![Cloth meshes inside Marvelous Designer](https://dev.epicgames.com/community/api/documentation/image/3f627919-33d4-4295-ba9d-63743c50743d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3f627919-33d4-4295-ba9d-63743c50743d?resizing_type=fit)
2. Once your cloth meshes are ready for export, select the **USD Export** option, and enable the following settings:

   - Mesh
   - Materials
   - Select All Patterns
   - Multiple Objects
   - Thick
   - Unified UV Coordinates
   - Diffuse Map
   - Normal Map
3. Then click **OK**.

   [![USD Export dialog in Marvelous Designer](https://dev.epicgames.com/community/api/documentation/image/64ed1164-3d8d-4e82-ba89-69de65eb390e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/64ed1164-3d8d-4e82-ba89-69de65eb390e?resizing_type=fit)
4. You will see a **Texture** folder as well as a **.usd file** in your target directory. To learn more about creating your asset in Marvelous Designer, take a look at [Making a Sweater with Marvelous Designer](making-a-sweater-with-marvelous-designer-in-unreal-editor-for-fortnite).

   [![Exported files in your target directory](https://dev.epicgames.com/community/api/documentation/image/791ea5e5-0c5c-49ff-92e9-fec42113e749?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/791ea5e5-0c5c-49ff-92e9-fec42113e749?resizing_type=fit)

Now that you have exported your cloth meshes from your DCC package, you will learn how to import them to Unreal Engine and create the cloth assets that will be used in UEFN. Proceed to the [Create your Clothing Asset in Unreal Engine](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-clothing-asset-in-unreal-engine-in-unreal-editor-for-fortnite) documentation.

Below you can see the documentation that will guide you through the entire cloth creation process:

[![Create your Clothing Asset in Unreal Engine](https://dev.epicgames.com/community/api/documentation/image/75959c1a-041b-4fc1-81f4-d4cda612cda9?resizing_type=fit&width=640&height=640)

Create your Clothing Asset in Unreal Engine

Create a new Unreal Engine project and generate a new cloth asset.](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-clothing-asset-in-unreal-engine-in-unreal-editor-for-fortnite)[![Configure the Clothing Asset Parameters](https://dev.epicgames.com/community/api/documentation/image/580b2e0e-f4cd-4de9-891f-bb1646f13ae4?resizing_type=fit&width=640&height=640)

Configure the Clothing Asset Parameters

Configure the parameters of the cloth asset to ensure proper functionality.](https://dev.epicgames.com/documentation/en-us/fortnite/configure-the-clothing-asset-parameters-in-unreal-editor-for-fortnite)[![Configure the Simulation Settings](https://dev.epicgames.com/community/api/documentation/image/7f4f8e3b-e04e-4f84-89ec-9ccbcd1e5ab3?resizing_type=fit&width=640&height=640)

Configure the Simulation Settings

Configure the simulation settings of the cloth asset to ensure expected behavior.](https://dev.epicgames.com/documentation/en-us/fortnite/configure-the-simulation-settings-in-unreal-editor-for-fortnite)[![Import your Clothing Asset into UEFN](https://dev.epicgames.com/community/api/documentation/image/bf4e04b8-ace3-4f62-871c-45b43af044ca?resizing_type=fit&width=640&height=640)

Import your Clothing Asset into UEFN

A guide on migrating the clothing asset from Unreal Engine to Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/import-your-clothing-asset-into-unreal-editor-for-fortnite)[![Modify a Clothing Asset in UEFN](https://dev.epicgames.com/community/api/documentation/image/c4cff677-6749-4278-b577-7e7c77db0cde?resizing_type=fit&width=640&height=640)

Modify a Clothing Asset in UEFN

A guide on modifying a clothing asset inside Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/modify-a-clothing-asset-in-unreal-editor-for-fortnite)
