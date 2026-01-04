# Configure the Clothing Asset Parameters

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/configure-the-clothing-asset-parameters-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:18:18.201705

---

After creating your clothing asset, you next need to transfer skin weights and set various configurations for animations and physics.

## Transfer Skin Weights and Set Max Simulation Distance

In this section, you will transfer the skin weights from your skeletal mesh to the cloth collection. The skin weights tell the cloth mesh how to deform to conform to the skeletal mesh.

You will also add a **Max Distance Configuration**. The Max Distance value informs how far the simulated cloth can move away from its animated skinned position during simulation.

1. Drag from the **Collection** pin and search for then select **TransferSkinWeights**.

   1. Go to the **Node Details** panel and click the **Skeletal Mesh** dropdown. Select the skeletal mesh for your character. This is the same skeletal mesh you used in your DCC package to create the cloth meshes.

   [![Add a TransferSkinWeights node and set the Skeletal Mesh](https://dev.epicgames.com/community/api/documentation/image/f4f1ca91-fd17-4045-8a35-4542ce025ca6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4f1ca91-fd17-4045-8a35-4542ce025ca6?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **AddWeightMap**.

   1. Name the node **AddWeightMap\_MaxDistance**.
   2. Go to the **Node Details** panel and enter the Name **MaxDistance**.
   3. This weight map tells the solver how far from its origin each vertex in the cloth mesh can travel.

   [![Add a AddWeightMap node and set the Name to MaxDistance](https://dev.epicgames.com/community/api/documentation/image/52fb4eb6-d500-40cc-80c1-cfe2da26e66c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/52fb4eb6-d500-40cc-80c1-cfe2da26e66c?resizing_type=fit)
3. With the node selected, you will see a 2D representation of your cloth mesh in the **Cloth Panel,** and the **Weight Map** tools and parameters in the **Cloth Mode Toolbar**.

   [![The Weight Map interface](https://dev.epicgames.com/community/api/documentation/image/d0cf957a-3d22-4376-b6ec-de31d66ee722?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d0cf957a-3d22-4376-b6ec-de31d66ee722?resizing_type=fit)

   The Weight Map interface contains the following sections:

   | Field | Description |
   | --- | --- |
   | **1. Display mode** | You can select a Black and White or White and Red color map to represent the painted values. |
   | **2. Action Type** | Select between various tools, such as **Brush**, **Fill**, and **Gradient**. You can also select **Paint** or **Smooth** Brush Modes. |
   | **3. Brush** | Enter the **Brush Size**, **Attribute Value,** and **Strength** of the tool. |
   | **4. Filters** | Adjust the regions affected by your selected Action Tool when painting. |
   | **5. Query** | Displays the value (0 - 1) painted at the cursor location. |
   | **6. Operations** | Includes options to clear and invert your selection, as well as a flood fill and multiply. |
   | **7. Mesh Elements Visualization, Triangle Visibility** | Includes various settings to control which parts of the mesh are visible in the panel. |
   | **8. View** | Toggle between **2D Sim**, **3D Sim**, and **Render** inside the panel. |
   | **9. Cursor** | Represents the **cursor location** where you are painting values on the mesh. |
   | **10. Paint Weight Maps** | You can **Accept** or **Cancel** the Weight Map changes you applied to the mesh. |
4. With the **Brush** tool selected and an **Attribute Value** of **1**, paint over your cloth mesh where you want your cloth to have complete movement freedom. Recall that 0 means no movement (kinematic) and 1 represents full movement within the maximum distance.

   [![With the Brush tool selected and an Attribute Value of 1, paint over your cloth mesh where you want your cloth to have complete movement freedom](https://dev.epicgames.com/community/api/documentation/image/9fc741de-67e7-4d25-8fdc-57d4aedf6bac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9fc741de-67e7-4d25-8fdc-57d4aedf6bac?resizing_type=fit)
5. Continue to paint the mesh by adding different **Attribute Values**. In the example below, we added values from **1** to **0.2** to create a gradient.

   [![Continue to paint the mesh by adding different Attribute Values](https://dev.epicgames.com/community/api/documentation/image/aa3a3f04-0f3b-45bb-9f52-53a199ab3904?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aa3a3f04-0f3b-45bb-9f52-53a199ab3904?resizing_type=fit)
6. Use the **Smooth Brush Mode** and paint over the gradient to smooth the values.

   [![Use the Smooth Brush Mode and paint over the gradient to smooth the values](https://dev.epicgames.com/community/api/documentation/image/71a54fe5-e6af-4f83-8228-7b6d76a3fabe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71a54fe5-e6af-4f83-8228-7b6d76a3fabe?resizing_type=fit)
7. Paint the rest of the cloth meshes as you want and click **Accept**.

   [![Paint the rest of the cloth meshes as desired and click Accept](https://dev.epicgames.com/community/api/documentation/image/c6630bc1-50f6-466c-8c2c-d226acb55020?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c6630bc1-50f6-466c-8c2c-d226acb55020?resizing_type=fit)
8. Drag from the **Collection** pin and search for then select **SimulationMaxDistanceConfig**.

   1. Go to the **Node Details** panel and enter **70** for the High value of **Max Distance**. This will map all values of the weight map between 0 and 70.

   [![Add a Simulation Max Distance Config node and set the Max Distance to 70](https://dev.epicgames.com/community/api/documentation/image/40aa1191-c3ac-4609-9d0d-eecfe1684a3a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/40aa1191-c3ac-4609-9d0d-eecfe1684a3a?resizing_type=fit)

## Set the Animation Drive, Bending and Stretch Configurations

In this section you will set the animation drive, which controls the stiffness and damping of the cloth asset. You will also add bending and stretch configurations for the collection.

1. Drag from the **Collection** pin and search for then select **SimulationAnimDriveConfig**. Go to the **Node Details** panel and enter **low** and **high values** of **0** and **0.75** for **Stiffness** and **0** and **1** for **Damping.**

   [![Add a Simulation Anim Drive Config node and set the low and high values of 0 and 0.75 for Stiffness and 0 and 1 for Damping](https://dev.epicgames.com/community/api/documentation/image/4e95e381-a150-437b-aea7-36d0c4cae990?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4e95e381-a150-437b-aea7-36d0c4cae990?resizing_type=fit)

   You can also add separate weight maps to further drive those values by adding a Weight Map node to each input pin, as shown below.

   [![You can also add separate weight maps to further drive those values by adding a Weight Map node to each input pin](https://dev.epicgames.com/community/api/documentation/image/d1f1f390-924c-4d76-9a0c-c1a50f06125b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d1f1f390-924c-4d76-9a0c-c1a50f06125b?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **SimulationBendingConfig**.

   1. Select **Flatness Ratio** for the **Rest Angle Type**.
   2. Select **XPBD** as the **Solver Type**.
   3. Select **Anisotropic** for the **Distribution Type**.
   4. Enter the following **Bending Properties** values:

   | Setting | Low | High |
   | --- | --- | --- |
   | **Flatness Ratio** | 0.0 | 1.0 |
   | **Bending Stiffness Warp** | 0.109266 | 28.274334 |
   | **Bending Stiffness Weft** | 0.005363 | 28.274334 |
   | **Bending Stiffness Bias** | 0.006022 | 28.274334 |
   | **Bending Anisso Damping** | 5.0 | 10.0 |
   | **Buckling Stiffness Warp** | 0.061127 | 27.99159 |
   | **Buckling Stiffness Weft** | 0.00194 | 27.99159 |
   | **Buckling Stiffness Bias** | 0.001506 | 27.99159 |
   | **Buckling Ratio** | 0.3 |  |

   [![Set the Bending Types and Bending Properties values](https://dev.epicgames.com/community/api/documentation/image/99ceee30-f4d9-41c1-a544-38f0a5d375b7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99ceee30-f4d9-41c1-a544-38f0a5d375b7?resizing_type=fit)

   You can also add separate weight maps to further drive those values by adding Weight Map nodes to the input pins, as shown below.

   [![Add separate weight maps to further drive those values](https://dev.epicgames.com/community/api/documentation/image/301f7120-5b1e-4e30-b57d-3854efa3c2f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/301f7120-5b1e-4e30-b57d-3854efa3c2f7?resizing_type=fit)
3. Drag from the **Collection** pin and search for then select **SimulationStretchConfig**.

   1. Select **XPBD** as the **Solver Type**.
   2. Select **Anisotropic** for the **Distribution Type**.
   3. Enter the following **Stretch Properties** values:

   | Setting | Low | High |
   | --- | --- | --- |
   | **Stretch Stiffness Warp** | 1.0 | 482.6263 |
   | **Stretch Stiffness Weft** | 1.0 | 1000.0 |
   | **Stretch Stiffness Bias** | 10.0 | 500.0 |
   | **Stretch Aniso Damping** | 0.0001 | 0.0001 |
   | **Stretch Warp Scale** | 0.99 | 1.0 |
   | **Stretch Weft Scale** | 0.9 | 1.0 |

   [![Set the Stretch Types and Stretch Properties values](https://dev.epicgames.com/community/api/documentation/image/e836129d-48fc-4439-9302-0f3236ee4ec2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e836129d-48fc-4439-9302-0f3236ee4ec2?resizing_type=fit)

   You can also input separate weight maps to further drive those values by adding Weight Map nodes to the input pins, as shown below.

   [![Add separate weight maps to further drive those values](https://dev.epicgames.com/community/api/documentation/image/27ffec88-4b2d-4a69-8f47-2dad670faf05?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/27ffec88-4b2d-4a69-8f47-2dad670faf05?resizing_type=fit)

## Set the Mass, Aerodynamic, Damping, and Gravity Configurations

In this section you will set the **Mass** settings where you specify the **density** of the cloth material. You will also set the **Aerodynamic** settings to specify **fluid density**, **drag,** and **lift**. In addition, you will also specify the damping and gravity scale applied to the collection.

1. Drag from the **Collection** pin and search for then select **SimulationMassConfig**. Go to the **Node Details** panel and enter the **Mass Mode** and **Min Per Particle Mass** settings. For this example, we selected the **Density Mass Mode** and a **Min Per Particle Mass** of **0.001**.

   [![Add a SimulationMassConfig node. Set the Mass Mode to Density and the Min Per Particle Mass of 0.001](https://dev.epicgames.com/community/api/documentation/image/c5329843-0a41-41ad-b66d-cf1b04b1e446?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5329843-0a41-41ad-b66d-cf1b04b1e446?resizing_type=fit)

   You can also add separate weight maps to drive the Uniform Mass and Density values, as seen below.

   [![Add separate weight maps to further drive Uniform Mass and Density](https://dev.epicgames.com/community/api/documentation/image/638032e7-fb3c-4fe2-a84f-e8afbb0b309e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/638032e7-fb3c-4fe2-a84f-e8afbb0b309e?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **SimulationAerodynamicsConfig**.

   1. Go to the **Node Details** panel and enter **1.225** for **Fluid Density**.
   2. Enter **Drag** and **Lift** Low and High values of **0.035** and **1**, respectively.

   [![Add the Simulation Aerodynamics Config node and set Fluid Density to 1.225. Enter Drag and Lift Low and High values of 0.035 and 1](https://dev.epicgames.com/community/api/documentation/image/c9e8f9f5-6632-42b2-8ca8-aef343bb4e7b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c9e8f9f5-6632-42b2-8ca8-aef343bb4e7b?resizing_type=fit)
3. Drag from the **Collection** pin and search for then select **SimulationDampingConfig**.

   1. Go to the **Node Details** panel and enter **Damping Coefficient Weighted** Low and High values of **0.02** and **0.5**, respectively.
   2. Enter a **Local Damping Coefficient** of **0.0085**.

   [![Add a Simulation Damping Config node** **and enter Damping Coefficient Weighted Low and High values of 0.02 and 0.5. Enter a Local Damping Coefficient of 0.0085](https://dev.epicgames.com/community/api/documentation/image/043df610-5ebd-431a-afd4-d3c960e4bef3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/043df610-5ebd-431a-afd4-d3c960e4bef3?resizing_type=fit)

   You can also input a separate weight map to drive the Damping Coefficient Weighted values, as seen below.

   [![You can add a separate weight map to drive the Damping Coefficient Weighted](https://dev.epicgames.com/community/api/documentation/image/584cdc27-b24c-4080-b6ee-305ff2ad3244?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/584cdc27-b24c-4080-b6ee-305ff2ad3244?resizing_type=fit)
4. Drag from the **Collection** pin and search for then select **SimulationGravityConfig**. Go to the **Node Details** panel and enter **Gravity Scale** Low and High values of **1** and **1**, respectively.

   [![Add a Simulation Gravity Config node and set the Gravity Scale Low and High values of 1 and 1](https://dev.epicgames.com/community/api/documentation/image/8982e306-bcf6-43a1-b1a0-464f61cbf705?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8982e306-bcf6-43a1-b1a0-464f61cbf705?resizing_type=fit)

## Set the Physics Asset, Collision, and Velocity Scale Configurations

In this section you will set up the **Physics Asset**, which will drive collision against the skeletal mesh. You will also set the **collision thickness**, **friction coefficient,** **proximity stiffness** and **simulation velocity scale**.

1. Drag from the **Collection** pin and search for then select **SetPhysicsAsset**. Go to the **Node Details** panel and click the **Physics Asset** dropdown. Select the Physics Asset for your Skeletal Mesh.

   [![Add a SetPhysicsAsset node and set the Physics Asset](https://dev.epicgames.com/community/api/documentation/image/5bd21ba5-e0cd-4f73-928d-ecf9dbb203f7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5bd21ba5-e0cd-4f73-928d-ecf9dbb203f7?resizing_type=fit)
2. Drag from the **Collection** pin and search for then select **SimulationCollisionConfig**. Go to the **Node Details** panel and enter a **Collision Thickness** of **0.3**.

   1. Enter a **Friction Coefficient** of **0.2**.
   2. Enter a **Proximity Stiffness** of **100**.

   [![Add a Simulation Collision Config node and set the Collision Thickness to 0.3, Friction Coefficient to 0.2 and Proximity Stiffness to 100](https://dev.epicgames.com/community/api/documentation/image/4cd4dba5-0149-4a8b-b9cc-1f2dc944a329?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4cd4dba5-0149-4a8b-b9cc-1f2dc944a329?resizing_type=fit)
3. Drag from the **Collection** pin and search for then select **SimulationVelocityScaleConfig**. Go to the **Node Details** panel and a **Linear Velocity Scale** of **0.3**, **0.7**, and **0.7**.

   1. Enter an **Angular Velocity Scale** of **0.5**.
   2. Enter a **Max Velocity Scale** of **1.0**.
   3. Enter a **Fictitious Angular Scale** of **1.1**.

   [![Add a Simulation Velocity Scale Config node and set Linear Velocity Scale to 0.3, 0.7, 0.7, Angular Velocity Scale to 0.5, Max Velocity Scale to 1, and Fictitious Angular Scale to 1.1](https://dev.epicgames.com/community/api/documentation/image/a848f883-f84c-4bac-88db-910c5decbb4b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a848f883-f84c-4bac-88db-910c5decbb4b?resizing_type=fit)

## Next step

[![Configure the Simulation Settings](https://dev.epicgames.com/community/api/documentation/image/7f4f8e3b-e04e-4f84-89ec-9ccbcd1e5ab3?resizing_type=fit&width=640&height=640)

Configure the Simulation Settings

Configure the simulation settings of the cloth asset to ensure expected behavior.](https://dev.epicgames.com/documentation/en-us/fortnite/configure-the-simulation-settings-in-unreal-editor-for-fortnite)
