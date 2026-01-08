# Modify a Clothing Asset in UEFN

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/modify-a-clothing-asset-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T02:18:23.855084

---

In this guide, you will learn how to modify your clothing material to add additional color variety to the same asset. In addition, we will explain how to modify the material textures outside of UEFN to achieve a similar effect.

Import your MetaHuman into UEFN and set up a clothing asset by following the steps outlined in the [**Import your Clothing Assets to UEFN**](import-your-clothing-asset-to-unreal-editor-for-fortnite) guide.

## Modify the Clothing Material

Follow these steps to modify the material associated with your clothing asset:

1. Open your **MetaHuman Blueprint** and select the **ChaosCloth component** in the **Components** window.

   [![Open your MetaHuman Blueprint and select the ChaosCloth component](https://dev.epicgames.com/community/api/documentation/image/31273017-0d8f-4cd6-925e-654bab81fa58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/31273017-0d8f-4cd6-925e-654bab81fa58?resizing_type=fit)
2. Go to the **Details** panel and scroll down to the **Materials** section.

   1. Locate the material you want to modify. In this example, we want to change the material in Element 0.
   2. Click the **Browse** button to navigate to the material in the **Content Browser**.

      [![Locate the material you want to modify and click the Browse button](https://dev.epicgames.com/community/api/documentation/image/6b8856a0-c266-4714-bacf-5f65f389d7a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b8856a0-c266-4714-bacf-5f65f389d7a7?resizing_type=fit)

      [![You will see the material in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/8419b0ca-6f32-4709-bfa6-5044ea339c4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8419b0ca-6f32-4709-bfa6-5044ea339c4b?resizing_type=fit)
3. Double click the material to open it. This will open the **Material Editor** where you can edit the node graph that creates the final material applied to your clothing asset. To learn more about materials, please see the [Materials](https://dev.epicgames.com/documentation/en-us/fortnite/materials-in-unreal-editor-for-fortnite) documentation for UEFN.

   [![Double click the material to open it](https://dev.epicgames.com/community/api/documentation/image/7cddf809-993d-4e42-96ce-bc9effe20143?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7cddf809-993d-4e42-96ce-bc9effe20143?resizing_type=fit)
4. Move the **Texture Sample** node to make space, right click in the **Material Graph**, and search for then select **Constant3Vector**.

   [![Right click in the Material Graph, and search for then select Constant 3 Vector](https://dev.epicgames.com/community/api/documentation/image/93e9aed8-a0bb-4515-b9a4-8d164f9ba95f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93e9aed8-a0bb-4515-b9a4-8d164f9ba95f?resizing_type=fit)
5. With the node selected, go to the **Details** panel and click the **Constant** to open the **Color Picker.** Set the color to white and click **OK.**

   [![Click the Constant to open the Color Picker, set the color to white and click OK](https://dev.epicgames.com/community/api/documentation/image/0cf0fc79-e4b5-44dd-8bec-545741a21212?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0cf0fc79-e4b5-44dd-8bec-545741a21212?resizing_type=fit)
6. Right click in the **Node Graph** and search for then select **Multiply.**

   [![Right click in the Node Graph and search for then select Multiply](https://dev.epicgames.com/community/api/documentation/image/47b40c83-d931-4122-8ad9-60b03fa99705?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47b40c83-d931-4122-8ad9-60b03fa99705?resizing_type=fit)
7. Connect the **Texture Sample** node and the **Constant3** node to the **A** and **B** pins of the **Multiply** node. Connect the **Multiply** node to the **Base Color** pin of the **Material** node.

   [![Connect the Texture Sample and Constant 3 nodes to the Multiply node. Connect the Multiply node to the Material node](https://dev.epicgames.com/community/api/documentation/image/75305c27-e7c3-4aa4-8a52-0302dfe9bf6b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/75305c27-e7c3-4aa4-8a52-0302dfe9bf6b?resizing_type=fit)
8. Right click on the **Constant3** node and select **Convert to Parameter**. Enter **Tint** as the name and click **Save**.

   [![Right click on the Constant 3 node and select Convert to Parameter](https://dev.epicgames.com/community/api/documentation/image/d7a0b794-da69-46da-be9f-a887c9c947a0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7a0b794-da69-46da-be9f-a887c9c947a0?resizing_type=fit)

   [![Enter Tint as the name of the node](https://dev.epicgames.com/community/api/documentation/image/3194870b-bb7f-4c93-b012-98053c0688c5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3194870b-bb7f-4c93-b012-98053c0688c5?resizing_type=fit)

   [![Click Save](https://dev.epicgames.com/community/api/documentation/image/a7b6df07-1e36-4de3-92e2-a54861882941?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7b6df07-1e36-4de3-92e2-a54861882941?resizing_type=fit)
9. Go back to the **Content Browser**, right click on the material and select **Create Material Instance.** Name the asset. In this example, we named it **MI\_Cap\_Jacket.**

   [![Right click on the material and select Create material instance](https://dev.epicgames.com/community/api/documentation/image/06011eb8-eb1c-4904-b745-a640c168d994?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/06011eb8-eb1c-4904-b745-a640c168d994?resizing_type=fit)

   [![Name the asset MI_Cap_Jacket.](https://dev.epicgames.com/community/api/documentation/image/e665c9d8-d811-438e-b531-1bd4f4f1ef1b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e665c9d8-d811-438e-b531-1bd4f4f1ef1b?resizing_type=fit)
10. Go back to the **MetaHuman Blueprint**, select the **ChaosCloth component** and go to the **Materials** section in the **Details** panel.

    1. Replace the original material with the new **material instance** you just created.
    2. **Compile** and **Save** the Blueprint.

       [![Replace the original material with the new material instance you just created](https://dev.epicgames.com/community/api/documentation/image/0ab64707-bfea-4bcb-b2b1-b34ea5cca6e6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0ab64707-bfea-4bcb-b2b1-b34ea5cca6e6?resizing_type=fit)
11. Open the **material instance**, expand the **Global Vector Parameters** section and **enable** the **Tint** checkbox.

    [![Open the material instance, expand the Global Vector Parameters section and enable the Tint checkbox](https://dev.epicgames.com/community/api/documentation/image/48d1275c-b60a-42ae-ac3b-83cf449a0c5a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/48d1275c-b60a-42ae-ac3b-83cf449a0c5a?resizing_type=fit)
12. Click the **Tint** color to open the **Color Picker**. You can now select the color you want and see the changes update instantly. Pick a color and click **OK**.

    [![Click the Tint color to open the Color Picker. Pick a color and click OK](https://dev.epicgames.com/community/api/documentation/image/3074f77f-edea-4fd5-a803-f8d24caa7c21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3074f77f-edea-4fd5-a803-f8d24caa7c21?resizing_type=fit)
13. You can right click on the **material instance** and select **Duplicate** to create multiple versions of the clothing material instance. In the example below, we created 3 versions of the jacket by duplicating the material instance and selecting a different tint.

    [![Duplicate the material instances to create different versions of the jacket](https://dev.epicgames.com/community/api/documentation/image/99bd545d-a3b9-423b-bdec-28015bd0b4a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99bd545d-a3b9-423b-bdec-28015bd0b4a2?resizing_type=fit)

## Modify the Textures Outside of UEFN

You can also add variety to your clothing asset by modifying the material's textures directly. You can export the desired textures and modify them in an external image editing software, like Photoshop. This method is more elaborate, but offers you more control over the final result.

Follow these steps to locate and export a texture from the material:

1. Open the material and click the **Texture Sample** node that references the texture you want to export.

   [![Click the Texture Sample node that references the texture you want to export](https://dev.epicgames.com/community/api/documentation/image/b196505c-e48e-48b0-a5cc-e24094d64058?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b196505c-e48e-48b0-a5cc-e24094d64058?resizing_type=fit)
2. Go to the **Details** panel and scroll down to the **Material Expression Texture Base** section. Click the **Navigate** button for the **Texture** to go to the texture asset in the **Content Browser**.

   [![Click the Navigate button for the Texture to go to the texture asset in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/b0a8b1dd-541d-4356-be7c-2e79e441fd65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0a8b1dd-541d-4356-be7c-2e79e441fd65?resizing_type=fit)
3. Right click on the **texture** and click **Asset Actions > Export**. Select the target location and click **Save**.

   [![Right click on the texture and click Asset Actions - Export](https://dev.epicgames.com/community/api/documentation/image/bbf65d8a-9a0f-4bc2-a3a7-a8e78ff9a46f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bbf65d8a-9a0f-4bc2-a3a7-a8e78ff9a46f?resizing_type=fit)

   [![Select the target location and click Save](https://dev.epicgames.com/community/api/documentation/image/9c11cbfd-bbf7-49df-9615-13e13225b660?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9c11cbfd-bbf7-49df-9615-13e13225b660?resizing_type=fit)
4. Import the texture into an image editing program and select the parts of the texture you want to modify.

   If using Photoshop or a similar program, you can use a new Adjustment layer to select a specific color and change it.
5. Once you are done making your changes, import the texture to UEFN by clicking the **Import** button in the **Content Browser**.

   [![Import the texture to UEFN by clicking the Import button in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/8596a63a-4a90-47d4-82ef-8aa39c805cc8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8596a63a-4a90-47d4-82ef-8aa39c805cc8?resizing_type=fit)
6. Alternatively, if you want to reimport the same texture to apply your changes, you can right click on the texture and select **Reimport**. This will overwrite the texture with your changes.

   [![Right click on the texture and select Reimport](https://dev.epicgames.com/community/api/documentation/image/f8b464d2-0dff-4463-b85b-5c4dfa193ec4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8b464d2-0dff-4463-b85b-5c4dfa193ec4?resizing_type=fit)

If you imported a new texture file, go back to the material and select the **Texture Sample** node. Go to the **Details** panel and scroll down to the **Material Expression Texture Base** section and replace the **Texture** with your new one.

[![Scroll down to the Material Expression Texture Base section and replace the Texture with your new one](https://dev.epicgames.com/community/api/documentation/image/f7781dc0-a667-4aec-9f67-ef359acf4b43?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7781dc0-a667-4aec-9f67-ef359acf4b43?resizing_type=fit)

For your convenience, the **Cloth Learning Assets** available from the link in UEFN include the base texture and a Photoshop file with a Selective Color layer so you can quickly modify the texture for this example. To learn how to access the downloadable files, see the [Talisman MetaHuman Template tutorial](talisman-metahuman-template-in-unreal-editor-for-fortnite).

[![Download the Cloth Learning Assets and open the Cap_Jacket_Textures folder](https://dev.epicgames.com/community/api/documentation/image/cbb26084-a7ea-415b-b45b-99a4733a3a03?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cbb26084-a7ea-415b-b45b-99a4733a3a03?resizing_type=fit)
