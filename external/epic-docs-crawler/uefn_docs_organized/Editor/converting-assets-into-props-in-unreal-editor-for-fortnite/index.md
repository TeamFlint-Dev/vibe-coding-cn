# Converting Assets into Props

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/converting-assets-into-props-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:55:43.188931

---

Converting your [imported asset](https://dev.epicgames.com/documentation/en-us/fortnite/importing-assets-in-unreal-editor-for-fortnite) into a Fortnite [prop](unreal-editor-for-fortnite-glossary#prop) determines how your [asset](unreal-editor-for-fortnite-glossary#asset) interacts with player characters, [devices](unreal-editor-for-fortnite-glossary#device), other props, and the phone tool in Fortnite Creative. You can decide how your asset handles damage and destruction, and which resource type is dropped when the asset is destroyed.

The easiest way to turn a [static mesh](unreal-editor-for-fortnite-glossary#static-mesh) into a prop consists of three main steps:

1. Configure the resource type.
2. Set damage and destruction.
3. Change settings in the **Island Settings** device.

A [legacy process](https://dev.epicgames.com/documentation/en-us/fortnite/converting-assets-into-props-in-unreal-editor-for-fortnite) also exists, but takes a bit longer.

## Configuring Resource Types

There are three types of resources that can be dropped by a destroyed prop: wood, stone, and metal. To set the resource type for your prop, right-click on the static mesh thumbnail in the [Content Browser](unreal-editor-for-fortnite-glossary#content-browser) to open the **Static Mesh** menu.

Select **Scripted Asset Actions** > **Convert to Prop** > **Resource Type**.

[![Select the resource type from the dropdown menu.](https://dev.epicgames.com/community/api/documentation/image/fa5b407c-3635-4ea3-b2cf-5e7025b9008e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fa5b407c-3635-4ea3-b2cf-5e7025b9008e?resizing_type=fit)

This creates a **Custom Props** folder that contains the **prop** [**Blueprint**](unreal-editor-for-fortnite-glossary#blueprint) **asset** based on the static mesh. The prop Blueprint asset references the static mesh, but is a different class of asset with a different set of properties. When dragged into the viewport, the asset is treated like an [actor](unreal-editor-for-fortnite-glossary#actor).

[![The prop blueprint asset is automatically placed in the Custom Props folder.](https://dev.epicgames.com/community/api/documentation/image/2a463041-5f0d-4dfd-a648-4580f32f78ad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a463041-5f0d-4dfd-a648-4580f32f78ad?resizing_type=fit)

An alternative method involves selecting the imported Static Mesh from the [viewport](unreal-editor-for-fortnite-glossary#viewport) and right-clicking to create a **prop actor**. This process also creates a prop asset in the Content Browser.

[![Convert a Static Mesh into a prop from the viewport.](https://dev.epicgames.com/community/api/documentation/image/4b3944bd-c13b-45ed-a69c-330724bfc7bb?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4b3944bd-c13b-45ed-a69c-330724bfc7bb?resizing_type=fit)

Different resource types cause the asset to reveal damage in different ways when taking environmental damage from fire, weapons, and more. Wood is the most pliable resource that easily shows damage, while metal is the least pliable resource and doesn't show damage easily. This is something to consider as you decide the Break Effect, Death Particles and Sound, as well as Hit Sounds.

### Changing Resource Type

Reusing an imported asset in more than one place is common in game design. In this case you'd likely want the asset to drop a different type of resource in the secondary area. You can change the resource type for the second asset, but you can't change the resource type on the original blueprint.

Changing the resource type on the original asset results in all copies of the original changing the resource type they drop as well. To change the resource for the original Blueprint Class Actor you must duplicate it.

1. Duplicate the **Blueprint Class Actor** in the Content Browser.

   [![](https://dev.epicgames.com/community/api/documentation/image/6059ec01-4d78-4379-9e99-95247484561e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6059ec01-4d78-4379-9e99-95247484561e?resizing_type=fit)
2. Rename the new thumbnail adding the name of the new resource type to the end of the name.

   [![](https://dev.epicgames.com/community/api/documentation/image/651a9763-2493-4fd1-bd39-58fc1bf1ecb7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/651a9763-2493-4fd1-bd39-58fc1bf1ecb7?resizing_type=fit)
3. Right-click the new thumbnail and select **Scripted Asset Actions** > **New Resource Type**.

Now you have a new actor that drops a new resource.

## Setting Damage and Destruction

Enable damage on the blueprint asset from the **Blueprint Class** dropdown menu.

Right-click the **Blueprint Class** thumbnail and select **Scripted Asset Actions** > **Can Be Damaged** > **Enable**.

[![Enable damage on the prop Blueprint asset.](https://dev.epicgames.com/community/api/documentation/image/316fc2c6-b789-428b-a815-b2647236d405?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/316fc2c6-b789-428b-a815-b2647236d405?resizing_type=fit)

Add destruction parameters such as sound and visual effects to the actor to match the resource type.

If you don't set the Blueprint Class option to **Actor** > **Can Be Damaged** > **Yes**, the prop will not destruct. Without this option set to Yes, the prop will remian intact.

[![Setting the option Can Be Damaged to Yes, means a prop will destruct when hit 2-3 times. Without this setting, the prop will remian intact.](https://dev.epicgames.com/community/api/documentation/image/dcddfcb6-0173-46b6-9e57-2cfe121bcf58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dcddfcb6-0173-46b6-9e57-2cfe121bcf58?resizing_type=fit)

Double-click the **Blueprint Class** thumbnail to open the **Blueprint Class Editor**. Search for **effects** in the search bar. Select a sound from the **Death Sound** dropdown menu to match your resource type, then select a visual effect from the **Death Particles** dropdown menu.

[![Select the sound and visual effects for the prop.](https://dev.epicgames.com/community/api/documentation/image/84088c32-2c1c-4a59-8347-731832c03472?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/84088c32-2c1c-4a59-8347-731832c03472?resizing_type=fit)

Search for the following parameters in the searchbar and change their status to the following:

- **Can be Damaged** - True
- **Allow Resource Drop** - True

## Changing Island Settings

There are [Island Settings](island-settings-in-unreal-editor-for-fortnite) that have to be changed to make the actor behave like a Fortnite prop. In the [Outliner](unreal-editor-for-fortnite-glossary#outliner), search for the **Island Settings** device, and select the device to make its options available from the [Details panel](unreal-editor-for-fortnite-glossary#details-panel).

From the Details panel change the **PickaxeDestruction** option to one of the following:

- **None** - Destruction to props is turned off by default.
- **Default** - Uses the Fortnite Battle Royale destruction for props (2-3 hits).
- **Instant** - Instantly destroys the prop and drops resources.

  [![Set the type of Pickaxe Destruction for your island.](https://dev.epicgames.com/community/api/documentation/image/2ae641e2-5c30-438d-a1fe-0afc77a9c1ae?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ae641e2-5c30-438d-a1fe-0afc77a9c1ae?resizing_type=fit)

This setting only changes damage done with a pickaxe. Props can still be damaged by explosions, weapons, and fire.

Playtest your prop to make sure the Island Settings produce the result you’re looking to achieve with the Blueprint asset. You can copy the Blueprint asset as many times as you want without creating additional Blueprint thumbnails. The additional props will use the data from the original Blueprint asset to determine their properties.

## Using the Legacy Process

The legacy process produces the same result, but involves a different method for creating the prop Blueprint asset.

### Create the Blueprint Class

Right-click in the Content Browser and select **Blueprint** > **Blueprint Class**. This creates a Blueprint Class thumbnail. Name the new Blueprint asset.

[![Create a Blueprint asset.](https://dev.epicgames.com/community/api/documentation/image/fffb0186-78c4-4cda-bfcd-6fed797c871a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fffb0186-78c4-4cda-bfcd-6fed797c871a?resizing_type=fit)

### Assign Damage and Resources

Create a prop that can be damaged by opening the Blueprint Class dropdown menu and selecting to make the asset damageable. Right-click the thumbnail and select **Scripted Asset Actions** > **Can Be Damaged** > **Enable**. Set the resource type next, right-click on the thumbnail and select **Scripted Asset Actions** > **Set Resource To** > **Select Resource Type**. Now when the asset is destroyed it will drop the selected resource.

[![Enable damage and select a resource type.](https://dev.epicgames.com/community/api/documentation/image/c5179236-5e69-4928-b037-085417c42e36?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c5179236-5e69-4928-b037-085417c42e36?resizing_type=fit)

### Add Destruction Properties

Add destruction properties to your prop from the [Property Matrix](https://dev.epicgames.com/documentation/en-us/fortnite/editing-components-in-unreal-editor-for-fortnite). Double-click the Blueprint Class thumbnail to open the Property Matrix or right-click on the Blueprint Class thumbnail and select **Asset Actions** > **Edit Select in Property Matrix**. The Property Matrix opens.

Type **Static Mesh** into the Property Matrix searchbar and select your **Static Mesh** from the context menu, the Static Mesh you choose appears in the viewport of the Property Matrix. Then type **Effects** into the Property Matrix searchbar and set the **Death Sound** and **Death Particles** from the dropdown menus. Your prop will make the sound you select when it’s destroyed and show the death particles as it’s being destroyed.

[![Set the Property Effects in the Property matrix.](https://dev.epicgames.com/community/api/documentation/image/88cc47e5-c60a-460d-a10d-ac78717a11a8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/88cc47e5-c60a-460d-a10d-ac78717a11a8?resizing_type=fit)

For the prop to break and provide resources, you must follow the instructions above for [Changing Island Settings](https://dev.epicgames.com/documentation/en-us/fortnite/converting-assets-into-props-in-unreal-editor-for-fortnite). Once the Island Settings properties are set, your prop can be destroyed.

If you don’t want your asset to drop resources and be destroyed, set the **Can Be Destroyed** option to **Disable**.

[Penguin](https://sketchfab.com/3d-models/penguin-5d5ddab9a9bf4933a7615bb2d5ed0f9d) by [patrakeevasveta](https://sketchfab.com/patrakeevasveta) licensed under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
