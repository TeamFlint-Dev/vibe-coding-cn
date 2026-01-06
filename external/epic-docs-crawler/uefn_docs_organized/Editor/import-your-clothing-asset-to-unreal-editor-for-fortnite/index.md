# Import your Clothing Asset into UEFN

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/import-your-clothing-asset-to-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T07:11:06.514906

---

You can import your finalized clothing asset into your Unreal Editor for Fortnite project by following these steps:

1. Open your UEFN project and click **Window > MetaHuman Importer** to open the **MetaHuman Importer** window.

   [![Open the MetaHuman Importer](https://dev.epicgames.com/community/api/documentation/image/ee96318e-3e82-4dc6-9bca-1a7245e6ddd5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ee96318e-3e82-4dc6-9bca-1a7245e6ddd5?resizing_type=fit)
2. Download your MetaHuman and add it to your UEFN project.

   1. Click the **MetaHuman** category (1) on the left and select your desired MetaHuman from the list.
   2. Click **Download** (2) to download the MetaHuman to your local machine.
   3. Click **Add** (3) to import the MetaHuman to your UEFN project.

   [![Click the MetaHuman category, download and add your desired MetaHuman to your project](https://dev.epicgames.com/community/api/documentation/image/3428f7f2-beef-4d56-ac64-d6ac7f86ff05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3428f7f2-beef-4d56-ac64-d6ac7f86ff05?resizing_type=fit)
3. Go to your Unreal Engine project where the cloth asset was created and right click the **CA\_Cap\_Jacket** asset and select **Asset Actions > Migrate**.

   1. Click **OK** in the **Asset Report** window.
   2. Navigate to your UEFN project directory and go to the **Plugins > [Project Name]** folder. Select the **Content folder** and click **Select Folder**.
   3. If your UEFN project already has a MetaHuman, you may get a warning message asking if you want to overwrite existing assets. Enable the **Apply to All** checkbox and click **No**.

   [![Right click the CA_Cap_Jacket asset and select Asset Actions - Migrate](https://dev.epicgames.com/community/api/documentation/image/e3813efc-c66e-4c27-84ea-a59933861f61?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e3813efc-c66e-4c27-84ea-a59933861f61?resizing_type=fit)

   [![Click OK in the Asset Report window.](https://dev.epicgames.com/community/api/documentation/image/f8291ccf-e5ea-4a3e-b1b4-c752eaf7e158?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8291ccf-e5ea-4a3e-b1b4-c752eaf7e158?resizing_type=fit)

   [![Go to the Plugins - Project Name folder. Select the Content folder and click Select Folder](https://dev.epicgames.com/community/api/documentation/image/9d7d0378-b0d0-4e25-97ec-068501ae2867?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d7d0378-b0d0-4e25-97ec-068501ae2867?resizing_type=fit)

   [![Enable the Apply to All checkbox and click No](https://dev.epicgames.com/community/api/documentation/image/b570e0fb-0e8a-4307-aa67-00248c15fedd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b570e0fb-0e8a-4307-aa67-00248c15fedd?resizing_type=fit)
4. Go to your UEFN project after migration and open your MetaHuman Blueprint. In this example, we imported the Ada preset.

   [![Open your MetaHuman Blueprint](https://dev.epicgames.com/community/api/documentation/image/42c11192-715e-4caf-94ff-e8ceabd062cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42c11192-715e-4caf-94ff-e8ceabd062cb?resizing_type=fit)
5. Click **Add** in the **Components** window and add the **ChaosCloth** component.

   1. Go to the **Details** panel and scroll down to the **Cloth Component** section.
   2. Click the **Cloth Asset** dropdown and select **CA\_Cap\_Jacket** from the list.
   3. Click **Save** and **Compile** to apply your changes to the Blueprint.

   [![Add the Chaos Cloth component](https://dev.epicgames.com/community/api/documentation/image/731f889e-1054-4827-9020-8e866cb8224b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/731f889e-1054-4827-9020-8e866cb8224b?resizing_type=fit)

   [![Click the Cloth Asset dropdown and select CA_Cap_Jacket from the list](https://dev.epicgames.com/community/api/documentation/image/63a3b434-04c4-4dcb-9122-321de5529467?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/63a3b434-04c4-4dcb-9122-321de5529467?resizing_type=fit)

   [![The clothing asset is now added to the MetaHuman](https://dev.epicgames.com/community/api/documentation/image/8834b7dc-a36e-40e9-945f-60cdad326bf6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8834b7dc-a36e-40e9-945f-60cdad326bf6?resizing_type=fit)

   [![Click Save and Compile to apply your changes to the Blueprint](https://dev.epicgames.com/community/api/documentation/image/8f7254e2-af56-4c00-9363-ba0dc6ffe318?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f7254e2-af56-4c00-9363-ba0dc6ffe318?resizing_type=fit)
6. Drag the MetaHuman Blueprint to your level.

   1. Select the MetaHuman and go to the **Details** panel.
   2. Select the **Body** component and scroll down to the Animation section.
   3. Click the **Anim to Play** dropdown and select a preview animation from the list.

   [![Drag the MetaHuman Blueprint to your level](https://dev.epicgames.com/community/api/documentation/image/1ce44b02-bc42-433b-bf0d-afdddb0b072e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1ce44b02-bc42-433b-bf0d-afdddb0b072e?resizing_type=fit)

   [![The MetaHuman is now in the level](https://dev.epicgames.com/community/api/documentation/image/f7604f1c-08ce-4095-ae75-b3f10ed7d240?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7604f1c-08ce-4095-ae75-b3f10ed7d240?resizing_type=fit)

   [![Select the Body component](https://dev.epicgames.com/community/api/documentation/image/92a29826-8864-4fe8-87dd-0e3ec2196ae8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92a29826-8864-4fe8-87dd-0e3ec2196ae8?resizing_type=fit)

   [![Scroll down to the Animation section and select a preview animation from the list](https://dev.epicgames.com/community/api/documentation/image/7be4a884-a56e-4cb5-b2a1-7e22efb1b910?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7be4a884-a56e-4cb5-b2a1-7e22efb1b910?resizing_type=fit)
7. Your MetaHuman will play your selected animation on a loop. You can see how the Cloth Asset simulates with the moving MetaHuman.

   [![Your MetaHuman will play your selected animation on a loop](https://dev.epicgames.com/community/api/documentation/image/b561aa6d-ab37-4a64-b303-1cc71335a713?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b561aa6d-ab37-4a64-b303-1cc71335a713?resizing_type=fit)

## Next Steps

[![Modify a Clothing Asset in UEFN](https://dev.epicgames.com/community/api/documentation/image/c4cff677-6749-4278-b577-7e7c77db0cde?resizing_type=fit&width=640&height=640)

Modify a Clothing Asset in UEFN

A guide on modifying a clothing asset inside Unreal Editor for Fortnite.](https://dev.epicgames.com/documentation/en-us/fortnite/modify-a-clothing-asset-in-unreal-editor-for-fortnite)
