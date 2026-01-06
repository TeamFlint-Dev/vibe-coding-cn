# Making a Sweater with Marvelous Designer

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/making-a-sweater-with-marvelous-designer-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:08:29.313984

---

This tutorial walks you through creating a custom garment for imported MetaHumans in Marvelous Designer.

You're going to create a crewneck sweatshirt from a sample garment provided in Marvelous. Then, you'll craft your sweatshirt by editing each pattern, such as the sleeves and collars.

At the end of this tutorial, you should have a customized crewneck sweatshirt file that you can import into Unreal Engine (UE) to create a cloth asset.

[![Marvelous Sweater](https://dev.epicgames.com/community/api/documentation/image/76f7f7a3-0f28-403c-b55b-b03686549f15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/76f7f7a3-0f28-403c-b55b-b03686549f15?resizing_type=fit)

## Add a Custom MetaHuman

To import a MetaHuman into Marvelous Designer, follow these steps:

1. Navigate to **File** > **Add** > **Avatar** to import a custom MetaHuman.

   [![Importing Avatar](https://dev.epicgames.com/community/api/documentation/image/ae766a20-35e4-4a1b-8ed9-251c7afda8b5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ae766a20-35e4-4a1b-8ed9-251c7afda8b5?resizing_type=fit)
2. Import and load a MetaHuman with the following settings.

   [![Import Settings](https://dev.epicgames.com/community/api/documentation/image/81e53bfc-c3ef-4d4c-b7f7-56130d123c4d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81e53bfc-c3ef-4d4c-b7f7-56130d123c4d?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | **Load Type** | Open |
   | **Object Type** | Avatar |
   | **Auto Create Fitting Suit** | True |
   | **Camera** | False |
   | **Joint Animation** | False |
   | **Cache Animation (MC)** | False |
   | **Automatically Add Arrangement Points** | True |
   | **Scale** | cm (DAZ Studio) |
   | **%** | 100.00% |
   | **Axis Conversion** | X, Y (Up), Z |
   | **Align Bottom to Ground** | False |
   | **Move Garment to Start Position** | False |
3. Click on any part of the MetaHuman. Then, in the **Property Editor**, navigate to **Smooth Avatar**, and check the box for the **Smooth** option.

   [![Smooth Avatar](https://dev.epicgames.com/community/api/documentation/image/9ca01427-fd58-44dc-8b6a-a19423949daa?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9ca01427-fd58-44dc-8b6a-a19423949daa?resizing_type=fit)

## Use a Garment as a Starting Point

To create a crewneck sweatshirt using a T-shirt as a starting point, follow these steps:

1. In the **Library**, select **Garment**, and drag "Tshirt.zpac" into the **3D** window.

   [![Library Garment](https://dev.epicgames.com/community/api/documentation/image/a84dad71-3a64-4fc6-bccf-ff4b756c9f13?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a84dad71-3a64-4fc6-bccf-ff4b756c9f13?resizing_type=fit)
2. Select the entire garment, then use the **Select/Move** tool to place the garment closely to the MetaHuman.

   [![Moving Garments](https://dev.epicgames.com/community/api/documentation/image/b7f6b1e4-333c-4407-a211-624130f0af94?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7f6b1e4-333c-4407-a211-624130f0af94?resizing_type=fit)
3. Click the **Simulation** button.

   [![Simulation Button](https://dev.epicgames.com/community/api/documentation/image/d04a2729-b059-4810-b352-09d278cfb339?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d04a2729-b059-4810-b352-09d278cfb339?resizing_type=fit)
4. The garment should now be simulated for you to unfold and sew your garment into patterns.

   [![Garment](https://dev.epicgames.com/community/api/documentation/image/7e1aff41-0105-4db4-8086-bd9709892110?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7e1aff41-0105-4db4-8086-bd9709892110?resizing_type=fit)

## Unfold Symmetric Editing

To unfold and then sew the garment patterns together to create your sweatshirt, follow these steps;

1. In the **2D Pattern** window, right-click on the body pattern, then select **Remove Linked Editing**.

   [![Remove Linked Editing](https://dev.epicgames.com/community/api/documentation/image/2f21b9a8-3c6d-4375-81a4-8bcd483daba9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f21b9a8-3c6d-4375-81a4-8bcd483daba9?resizing_type=fit)
2. Delete one side of both the front and back parts of the pattern.

   [![Pattern Sides](https://dev.epicgames.com/community/api/documentation/image/128071a3-c2da-4a0c-919f-a7421deef15d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/128071a3-c2da-4a0c-919f-a7421deef15d?resizing_type=fit)
3. In the **2D Pattern** window, navigate to the **Edit Pattern** icon, and select **Edit Pattern**.

   [![Edit Pattern](https://dev.epicgames.com/community/api/documentation/image/87e0cc16-8dc6-40da-8d53-e1298f3b0043?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87e0cc16-8dc6-40da-8d53-e1298f3b0043?resizing_type=fit)
4. Click the center segment of the body pattern, then right-click to select **Unfold Symmetric Editing**. Repeat this step for the back body pattern.

   [![Unfold Symmetric Editing](https://dev.epicgames.com/community/api/documentation/image/c73a7c96-fcdf-475e-b52a-8d77d3204634?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c73a7c96-fcdf-475e-b52a-8d77d3204634?resizing_type=fit)
5. Click the **Simulation** button.
6. In the **3D** window, click the **Sewing** icon, and select **Segment Sewing**.

   [![Segment Sewing](https://dev.epicgames.com/community/api/documentation/image/4e49a5fb-2021-4a15-be6c-28cbbad7db0e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e49a5fb-2021-4a15-be6c-28cbbad7db0e?resizing_type=fit)
7. Click on the pattern's segments to sew it together.

   [![Sew Pattern](https://dev.epicgames.com/community/api/documentation/image/9dcb335b-48c3-43c8-a82d-5f183459f01c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9dcb335b-48c3-43c8-a82d-5f183459f01c?resizing_type=fit)
8. Hover over a segment to ensure its sewing is not twisted. The blue lines on the segment should connect in a straight line.

   [![Connected Segments](https://dev.epicgames.com/community/api/documentation/image/ea20e617-a3fd-414c-9893-942acd449952?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ea20e617-a3fd-414c-9893-942acd449952?resizing_type=fit)
9. If your sewing is twisted like the photo below, navigate to **Edit Sewing**, then click on the sewing segment to delete it before reapplying the sewing.

   [![Twisted Segments](https://dev.epicgames.com/community/api/documentation/image/dd731a0b-3264-4fbd-ba93-8ba8feb3daf2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dd731a0b-3264-4fbd-ba93-8ba8feb3daf2?resizing_type=fit)
10. Click the **Simulation** button to apply your changes.

## Extend the Sleeves

To extend your pattern's sleeves:

1. In the **2D Pattern** window, click **Edit Pattern**. Then, select the segments on the end of the sleeves.

   [![Extend Sleeves](https://dev.epicgames.com/community/api/documentation/image/96ae30c7-0a79-461e-a4dc-af546213428c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96ae30c7-0a79-461e-a4dc-af546213428c?resizing_type=fit)
2. Drag the sleeves to a desired length. Then, click the **Simulation** button.

If you notice the garment incorrectly colliding with the avatar, use the **Select/Move** tool while simulating to adjust the pattern by clicking and dragging it.

[![Sleeve Adjustment](https://dev.epicgames.com/community/api/documentation/image/737c1d49-e07e-4807-a520-c044ba81b8d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/737c1d49-e07e-4807-a520-c044ba81b8d5?resizing_type=fit)

[![Finished Sleeve](https://dev.epicgames.com/community/api/documentation/image/d387d63e-6c62-4245-8618-135e467f2fac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d387d63e-6c62-4245-8618-135e467f2fac?resizing_type=fit)

Your garment's sleeve should now be at your desired length.

## Adjust the Garment's Shape

To edit the garment's shape, follow these steps:

1. Using the **Edit Pattern** tool, make the garment's neckline tighter by moving points along the neckline.

   ![Before](https://dev.epicgames.com/community/api/documentation/image/4bf37968-0cb6-42a3-bca5-cb15ea80fddf?resizing_type=fit&width=1920&height=1080)

   ![After](https://dev.epicgames.com/community/api/documentation/image/bf044c75-e517-444b-8d9a-95f1ceefd873?resizing_type=fit&width=1920&height=1080)

   Before

   After
2. In the **2D Pattern** window, click the **Sewing** icon. Then, select **Check Sewing Length**.

   [![Check Sewing Length](https://dev.epicgames.com/community/api/documentation/image/dbffedc2-b9cf-4d9e-acd9-2f9eec551058?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dbffedc2-b9cf-4d9e-acd9-2f9eec551058?resizing_type=fit)

   As you change the patterns, make sure the lengths of the two sewing segments are stitched together match.
3. Navigate to **Edit Pattern**, and select the **Edit Curvature** tool.

   [![Edit Curvature](https://dev.epicgames.com/community/api/documentation/image/5692e3f4-ec2d-41e5-b093-5c035cee0c3c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5692e3f4-ec2d-41e5-b093-5c035cee0c3c?resizing_type=fit)
4. Select and then drag a segment to make adjustments to the garment's curves.

   [![](https://dev.epicgames.com/community/api/documentation/image/adc0865a-e2c7-433d-bab1-1340287ec482?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/adc0865a-e2c7-433d-bab1-1340287ec482?resizing_type=fit)
5. Use the **Edit Pattern** tool to tighten the armholes. You can see the value of the armhole's angle near its point. The images below show the armhole's angles decreasing in size to create its shape.

   ![Before Size](https://dev.epicgames.com/community/api/documentation/image/c49b2efb-9062-4ad9-bdce-bdd0ab75c700?resizing_type=fit&width=1920&height=1080)

   ![After Size](https://dev.epicgames.com/community/api/documentation/image/5a3a4a98-3706-4171-aa47-69984f82fc05?resizing_type=fit&width=1920&height=1080)

   Before Size

   After Size
6. In the **2D Pattern** window, navigate to the Sewing Machine icon, and select the **Check Sewing Length** tool.
7. Click on the armhole's segment to check its length.

   [![Armhole Length After](https://dev.epicgames.com/community/api/documentation/image/bd5e33f3-6209-4a76-8525-23a1f23c2950?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bd5e33f3-6209-4a76-8525-23a1f23c2950?resizing_type=fit)
8. Select the segment's sleeve that's sewed to the armhole. Then right-click it and select **Change Length** to match the length of the armhole segment.

   [![Change Length](https://dev.epicgames.com/community/api/documentation/image/49780205-16f7-4323-bec0-17fc59f8e4dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/49780205-16f7-4323-bec0-17fc59f8e4dd?resizing_type=fit)
9. Repeat for the sleeve segment connected to the back pattern.
10. Use the **Edit Pattern** tool to taper the sleeves.

    ![Before](https://dev.epicgames.com/community/api/documentation/image/c0ba4eb1-8714-48df-9e39-221a72546b16?resizing_type=fit&width=1920&height=1080)

    ![After](https://dev.epicgames.com/community/api/documentation/image/b4b0644f-ab9d-48fb-8256-9a6d77ce3ae6?resizing_type=fit&width=1920&height=1080)

    Before

    After

Your garment should now be shaped to your preferences.

[![Simulated Garment](https://dev.epicgames.com/community/api/documentation/image/38af20af-ed8c-4d4a-8533-c4e1ede02e6c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38af20af-ed8c-4d4a-8533-c4e1ede02e6c?resizing_type=fit)

## Create the Sleeve and Waistbands

To create the sleeve and waist bands for your garment, follow these steps:

1. Use the **Edit Pattern** tool to select a segment line on the sleeve. Then, right-click on the segment, and select **Offset as Internal Line**.

   [![Offset as Internal Line](https://dev.epicgames.com/community/api/documentation/image/fb072b77-3c2c-498e-83e8-59789f2a307e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb072b77-3c2c-498e-83e8-59789f2a307e?resizing_type=fit)
2. Right-click the segment, then select **Cut and Sew** for the internal line you just created.

   [![Cut and Sew](https://dev.epicgames.com/community/api/documentation/image/f7b721ed-c38c-4055-8e1c-6746b80d96d8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7b721ed-c38c-4055-8e1c-6746b80d96d8?resizing_type=fit)
3. Use the **Edit Pattern** tool to adjust the points on the sleeve band.

   [![Sleeve Points](https://dev.epicgames.com/community/api/documentation/image/cf642715-250f-464c-90ab-9bc45c76cdcb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cf642715-250f-464c-90ab-9bc45c76cdcb?resizing_type=fit)
4. Use the **Transform Pattern** tool to adjust the size of the sleeve band.

   [![Transform Pattern](https://dev.epicgames.com/community/api/documentation/image/12d44b99-3ed0-49fb-8742-66a13eced2ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12d44b99-3ed0-49fb-8742-66a13eced2ac?resizing_type=fit)
5. Repeat steps 1 - 4 to the bottom body patterns for both the front and back of the garment to create the waistband.
6. Select **Simulate**, and use the **Move/Select** tool to adjust the garment to your desired position.

   [![Shaped Garment](https://dev.epicgames.com/community/api/documentation/image/30b0c74a-d04d-4f4f-b001-a830ecee8d21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30b0c74a-d04d-4f4f-b001-a830ecee8d21?resizing_type=fit)

Continue to adjust the pattern until you achieve your desired shape.

## Make the Collar

To create the collar for your garment:

1. Select the neckline segments from the front and back body patterns to determine the total length of one side.

   [![Neckline Segment](https://dev.epicgames.com/community/api/documentation/image/c513b7e9-874f-4cfe-98c5-5f8c2b3775ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c513b7e9-874f-4cfe-98c5-5f8c2b3775ef?resizing_type=fit)
2. Select the **Rectangle** tool to create a rectangular pattern from the measurements above.

   [![Rectangle Tool](https://dev.epicgames.com/community/api/documentation/image/36f4d8c4-d50e-40f7-990d-282aa2e0c5cb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36f4d8c4-d50e-40f7-990d-282aa2e0c5cb?resizing_type=fit)
3. Right-click on the segment of your new pattern, and select **Unfold Symmetric Editing (with Sewing)**.

   [![Unfold Symmetric Editing](https://dev.epicgames.com/community/api/documentation/image/92abc6e2-9f89-4f0c-a3ee-d8957ad35a04?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/92abc6e2-9f89-4f0c-a3ee-d8957ad35a04?resizing_type=fit)
4. Click the [**M:N Segment Sewing**](https://support.clo3d.com/hc/en-us/articles/115012380868-M-N-Segment-Sewing) tool to sew the collar and body together, making sure there are no twisting in the sewing.

   [![M:N Segment Tool](https://dev.epicgames.com/community/api/documentation/image/55ef2870-84a9-4d36-b9fb-725b5c9ff164?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/55ef2870-84a9-4d36-b9fb-725b5c9ff164?resizing_type=fit)
5. Click **Simulate** to attach the collar to the body in the **3D** window.

   [![Collar](https://dev.epicgames.com/community/api/documentation/image/d6e1bce4-fafb-40b7-83a2-e0e74d84d64a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d6e1bce4-fafb-40b7-83a2-e0e74d84d64a?resizing_type=fit)
6. Navigate to the **Segment Sewing** tool to sew the collar patterns together.

   [![Sewn Collar](https://dev.epicgames.com/community/api/documentation/image/80594679-c528-4805-ad92-7792baf1a2d5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/80594679-c528-4805-ad92-7792baf1a2d5?resizing_type=fit)
7. Click the **Fabric** tab to create a new Fabric and name it "Collar".

   [![Collar Fabric](https://dev.epicgames.com/community/api/documentation/image/a573013b-9d39-4e42-a177-7661597e0c92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a573013b-9d39-4e42-a177-7661597e0c92?resizing_type=fit)
8. Click the folder icon. Then, under the collar fabric's **Property Editor**, change its Physical Property option to **Trim\_Fusible\_Rigid**.

   [![Physical Property](https://dev.epicgames.com/community/api/documentation/image/635fc2e3-c49e-4a54-a9a0-203534fb4581?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/635fc2e3-c49e-4a54-a9a0-203534fb4581?resizing_type=fit)
9. Drag the collar fabric onto the collar patterns to assign it.
10. Select **Simulate**, then use the **Edit Pattern** tool to adjust the collar height as needed.

    [![Simulated Collar](https://dev.epicgames.com/community/api/documentation/image/4f49e219-9b54-470f-aa85-dbf4da78aa81?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4f49e219-9b54-470f-aa85-dbf4da78aa81?resizing_type=fit)
11. Using the **Edit Sewing** tool, select the sewing line that connects the collar from one end to the other.

    [![Edit Sewing](https://dev.epicgames.com/community/api/documentation/image/3ff90d1f-ab32-48a4-9e4f-3f6017f2f4ec?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ff90d1f-ab32-48a4-9e4f-3f6017f2f4ec?resizing_type=fit)
12. In the **Property Editor**, navigate to **3D Seamline**, and set its **Intensity** and **Thickness** options to **0** to remove the seamline in render.

    [![Property Editor](https://dev.epicgames.com/community/api/documentation/image/15d68d01-f41f-4bb8-983d-4e16f8401249?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/15d68d01-f41f-4bb8-983d-4e16f8401249?resizing_type=fit)

[![Finished Collar](https://dev.epicgames.com/community/api/documentation/image/0babe294-27e8-411b-a516-875f9bed0595?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0babe294-27e8-411b-a516-875f9bed0595?resizing_type=fit)

Your garment should now have a collar.

## Add Details

To add details to your garment, follow these steps:

1. Select the shoulder line segment then use the **Edit Pattern** tool and select **Offset as Internal Line**.

   [![Shoulder Offset](https://dev.epicgames.com/community/api/documentation/image/a58b3f71-2cf6-4048-96e4-c889b1a9a8fb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a58b3f71-2cf6-4048-96e4-c889b1a9a8fb?resizing_type=fit)
2. Repeat the step above for the back of the body pattern.

   [![Back Pattern](https://dev.epicgames.com/community/api/documentation/image/d3451fcc-5f23-4fcc-bce4-44d26d5606e5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d3451fcc-5f23-4fcc-bce4-44d26d5606e5?resizing_type=fit)
3. Right-click your segment, and select **Cut and Sew** to edit the internal lines.

   [![](https://dev.epicgames.com/community/api/documentation/image/d0c94308-0b32-4293-82e8-afc3e6a46663?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0c94308-0b32-4293-82e8-afc3e6a46663?resizing_type=fit)
4. In the **Edit Pattern** tool, use **Offset as Internal Line** to add internal lines to the top of the sleeves.

   [![Internal Lines](https://dev.epicgames.com/community/api/documentation/image/6ca0ef1a-ca96-466c-9d11-4816a0e4cc69?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ca0ef1a-ca96-466c-9d11-4816a0e4cc69?resizing_type=fit)
5. In the **Internal Line Options** window, select **Optimize Curve Points**. This reduces the number of curve points and makes transforming the line easier.

   [![Optimize Curve Points](https://dev.epicgames.com/community/api/documentation/image/ccc525e0-ed97-4d5c-8520-eabda53c8c2a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ccc525e0-ed97-4d5c-8520-eabda53c8c2a?resizing_type=fit)
6. Use both the **Edit Curve Point** and **Edit Curvature** tools to adjust the internal line. Then use **Cut and Sew**.

   [![](https://dev.epicgames.com/community/api/documentation/image/9886c078-56d3-4297-ba44-2c36db7c63d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9886c078-56d3-4297-ba44-2c36db7c63d6?resizing_type=fit)
7. Right-click on the internal line. Then, navigate to **Offset the Internal Line**, and offset the edge segment of the shoulder as panel as an internal line. Then, select **Cut and Sew**.

   [![](https://dev.epicgames.com/community/api/documentation/image/2d77d021-c028-472f-8746-a9f71b602cfb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d77d021-c028-472f-8746-a9f71b602cfb?resizing_type=fit)
8. Right-click the front of the body pattern, and select **Remove Linked Editing**.

   [![Remove Linked Editing](https://dev.epicgames.com/community/api/documentation/image/54e6694c-8368-4318-b441-b2683324e461?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54e6694c-8368-4318-b441-b2683324e461?resizing_type=fit)
9. Use the **Internal Polygon/Line** tool to draw the cutout shape that you want to make. You can then use the **Edit Pattern** tool to continue adjusting the internal shape.

   [![Internal Polygon/Line](https://dev.epicgames.com/community/api/documentation/image/32417847-8fa8-4f20-9d76-bf6420b28d92?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/32417847-8fa8-4f20-9d76-bf6420b28d92?resizing_type=fit)
10. Extend the internal shape so that it doesn't intersect with the pattern's edge.

    [![](https://dev.epicgames.com/community/api/documentation/image/d31bcd85-9daa-4a25-ae8a-b350c0dd6814?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d31bcd85-9daa-4a25-ae8a-b350c0dd6814?resizing_type=fit)
11. Use the **Transform Pattern** tool, and select the entire internal shape.

    [![](https://dev.epicgames.com/community/api/documentation/image/4c99f27c-81f5-4bc3-8fc3-2bfc10aa50cc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c99f27c-81f5-4bc3-8fc3-2bfc10aa50cc?resizing_type=fit)
12. Use **Cut and Sew** for your internal shape.

    [![](https://dev.epicgames.com/community/api/documentation/image/94a84b8d-5142-4799-a02c-74ae6513251e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/94a84b8d-5142-4799-a02c-74ae6513251e?resizing_type=fit)

[![Detailed Garment](https://dev.epicgames.com/community/api/documentation/image/1c478b39-4c54-4dec-9026-304e06866ca8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c478b39-4c54-4dec-9026-304e06866ca8?resizing_type=fit)

Every pattern that has its own fabric should now be in separate pieces.

## Assign Fabrics to Patterns and Adjust Properties

To assign fabrics and patterns to your garment, follow these steps:

1. Add a new fabric for each of your fabric styles, then adjust their properties in the **Property Editor**.

   [![](https://dev.epicgames.com/community/api/documentation/image/d63991e7-91a0-4411-92e4-12cb7d9c16dc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d63991e7-91a0-4411-92e4-12cb7d9c16dc?resizing_type=fit)
2. Drag each newly created fabric onto your patterns.
3. Add the provided texture maps provided in the default Marvelous Asset Library or import your own.

   [![](https://dev.epicgames.com/community/api/documentation/image/5f28548d-2abd-4e4f-b20f-79ac14fcd361?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f28548d-2abd-4e4f-b20f-79ac14fcd361?resizing_type=fit)

For example, the body panels fabric uses textures downloaded from Megascans and uses AO for the **Texture** setting and Normal for the **Normal Map** setting.

[![](https://dev.epicgames.com/community/api/documentation/image/f8e581d3-3d0a-48f9-b9d3-1f96314dc0c2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f8e581d3-3d0a-48f9-b9d3-1f96314dc0c2?resizing_type=fit)

Above is an example pattern used in this project.

## Add Buttons

To add buttons to your garment:

1. Navigate to the **Button** panel, then access the **Property Editor**. Choose your desired button style, and adjust it as needed.

   [![Button Panel](https://dev.epicgames.com/community/api/documentation/image/2caf401f-1b95-40f5-8a85-7a8505d876be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2caf401f-1b95-40f5-8a85-7a8505d876be?resizing_type=fit)
2. In the **3D** window, use the **Button** tool and place the button on the garment.

   [![Button Tool](https://dev.epicgames.com/community/api/documentation/image/eebcd077-f0af-4dc1-afbc-979a17df89ed?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eebcd077-f0af-4dc1-afbc-979a17df89ed?resizing_type=fit)
3. Use the **Select/Move** tool to adjust the button's placement.

   [![Button Placement](https://dev.epicgames.com/community/api/documentation/image/03b4c3a4-7a88-4e98-8b1d-29506d73de2b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/03b4c3a4-7a88-4e98-8b1d-29506d73de2b?resizing_type=fit)
4. Click the **Simulation** button, then click on the button.

   [![Simulated Button](https://dev.epicgames.com/community/api/documentation/image/2f04e842-7e30-4365-b0f8-f8a7b4b9439d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f04e842-7e30-4365-b0f8-f8a7b4b9439d?resizing_type=fit)
5. In the **Property Editor**, adjust the simulation settings so that the button sits correctly on the garment without colliding or floating on it.

   [![Property Editor](https://dev.epicgames.com/community/api/documentation/image/5f59efd8-6113-40c4-9cf6-b98a0c00ec41?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5f59efd8-6113-40c4-9cf6-b98a0c00ec41?resizing_type=fit)

[![Buttoned Garment](https://dev.epicgames.com/community/api/documentation/image/24e4ac56-4665-4457-9416-6f77486d82c0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/24e4ac56-4665-4457-9416-6f77486d82c0?resizing_type=fit)

Your finished sweater garment should look similar to the photo above.

## Export your Garment

To export your sweater, follow these steps:

1. In the **UV Editor**, navigate to the **UV Packing** icon.

   [![UV Editor](https://dev.epicgames.com/community/api/documentation/image/b130f31e-bba9-459e-b4be-8f558e03354a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b130f31e-bba9-459e-b4be-8f558e03354a?resizing_type=fit)
2. Check the box for **0-1 (Default)** to pack the UVs, and click **Apply**.

   [![UV Packing](https://dev.epicgames.com/community/api/documentation/image/1c29869c-5e60-4316-8e36-bf11db70ee0f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c29869c-5e60-4316-8e36-bf11db70ee0f?resizing_type=fit)

   The UV shells will be rearranged and scaled as you change the patterns. When there are no UV shells overlapping or going out of bounds, they should similar to the image below. Be sure to do this step before exporting if you have made changes to your pattern .
3. Navigate to **File** > **Export** > **USD** to export the .usda file.

   [![Export](https://dev.epicgames.com/community/api/documentation/image/bc2c348b-d8df-48b7-8cec-37fda019ae4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bc2c348b-d8df-48b7-8cec-37fda019ae4e?resizing_type=fit)
4. Use the following settings in the **Export USD** window.

   [![Export Settings](https://dev.epicgames.com/community/api/documentation/image/461cf64b-7a23-45cf-aab5-475cbfe968b2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/461cf64b-7a23-45cf-aab5-475cbfe968b2?resizing_type=fit)

   | Option | Value |
   | --- | --- |
   | **Mesh** | Prim Path: /Mesh |
   | **Material** | Prim Path: /Material |
   | **Select All Patterns** | True |
   | **Select All Avatars** | False |
   | **Select All Graphics and Trims** | True - Thick |
   | **Unified UV Coordinates** | True |
   | **Image Size** | 2048 pixels |
   | **Fill Texture Seams** | 5 pixels |
   | **Diffuse Map** | True |
   | **Metalness Map** | False |
   | **Normal Map** | True |
   | **Roughness Map** | False |
   | **Opacity Map** | False |
   | **Displacement Map** | Map |
   | **Include Garment Simulation Data** | True |
5. Select **OK** to export your sweater as a .usd file.

You can then import this .usd file into UE to [convert it to a cloth asset](https://dev.epicgames.com/documentation/en-us/fortnite/create-your-clothing-asset-in-unreal-engine-in-unreal-editor-for-fortnite).

## Downloadable Learning Assets

[![](https://dev.epicgames.com/community/api/documentation/image/7233b0bb-a315-4315-8d93-4b37792785b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7233b0bb-a315-4315-8d93-4b37792785b8?resizing_type=fit)

As part of the Talisman: MetaHuman template, you can access several downloadable assets including the Marvelous Designer garment files and an Unreal Engine project with the Captain Elli MetaHuman wearing the sweater from this tutorial. To learn how to access the downloadable files, see the [Talisman MetaHuman Template tutorial](talisman-metahuman-template-in-unreal-editor-for-fortnite).

[![](https://dev.epicgames.com/community/api/documentation/image/71f1c0c1-cfb7-44c3-92f5-c6387b8cd090?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71f1c0c1-cfb7-44c3-92f5-c6387b8cd090?resizing_type=fit)

You can view these assets set up within the Talisman template by navigating to **Content Browser** > **Characters** > **Cloth** > **Captain** > **Sample** and opening "CA\_Cap\_Sweatshirt".
