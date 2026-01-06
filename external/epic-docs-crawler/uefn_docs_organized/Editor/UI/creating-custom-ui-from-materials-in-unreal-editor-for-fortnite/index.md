# Creating Custom UI with Material Instances

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-ui-from-materials-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:16:50.877775

---

Create custom UI with the base **M\_UI\_Shape\_Rectangle** material by making material instances from the base material to be used in UMG widgets. The shape material also provides a way for you to make flat shapes that can be used to create unique UI designs. The M\_UI\_Shape\_Rectangle material is located in the **Content Browser** under the Fortnite folder in **UI** > **Materials**.

Material instances can be used to fill a widget like paint. Materials are preferable to adding textures to widgets because materials use less memory than imported textures. Materials are also a better way to design UI in UEFN and UE, especially for a flat UI design because it's easier to render, not to mention you can get fancy with 3D and dynamic materials.

[![](https://dev.epicgames.com/community/api/documentation/image/8834f1dd-3fe3-478e-96aa-e36ec926e2a5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8834f1dd-3fe3-478e-96aa-e36ec926e2a5?resizing_type=fit)

UMG widgets are referenced in special UI settings on a few devices in Unreal Editor for Fortnite (UEFN). The UMG widgets replace the default Fortnite UI in the heads-up display (HUD).

For more tutorials on using materials to create UI, refer to the following:

- [Setting Material Parameters in UMG](https://dev.epicgames.com/documentation/en-us/fortnite/conversion-function-setting-material-parameters-in-umg-in-unreal-editor-for-fortnite)
- [Making Custom Backplates](https://dev.epicgames.com/documentation/en-us/fortnite/making-custom-backplates-in-unreal-editor-for-fortnite)
- [Making Custom Health and Shields Bars](https://dev.epicgames.com/documentation/en-us/fortnite/making-custom-health-and-shield-bars-in-unreal-editor-for-fortnite)

## Creating Custom UI Shapes

Before creating a custom UI shape, decide how you want the UI to look, then use the **M\_UI\_Shape\_Rectangle** material to design the look of your UI widget. This could be something as simple as a customized square or something more intricate like a flower shape. Designs may require multiple shapes that can then be positioned together when you create your widget.

To create shapes, you must first create a **[material instance](https://dev.epicgames.com/documentation/en-us/unreal-engine/BlueprintAPI/Interchange/Node/MaterialInstance?application_version=5.6)** of the original **M\_UI\_Shape\_Rectangle** material.

1. Right-click the material thumbnail and select **Create Material Instance**.
2. In the **Save Asset As** window, name your material instance which will be saved to your project's content folder. Name your assets in a way that groups them together. For example, stock material instances in UEFN start with "**M\_UGC\_**" and end with "**\_Inst**". Your material instance name should look something like **M\_UGC\_Circus\_Inst**.
3. Double-click your new material instance to bring up the **M****aterial Instance Editor**. You can also access the editor by right-clicking the asset and selecting **Edit**.

[![Material Editor](https://dev.epicgames.com/community/api/documentation/image/ecd65cd2-a35e-4241-892f-e63fc6e720a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecd65cd2-a35e-4241-892f-e63fc6e720a2?resizing_type=fit)

The **Details** panel of the Material Instance Editor has the tools you'll need to fully customize material instances. These tools are found in the sections:

- **[1]** **Fill**
- **[2]** **Stroke**
- **[3]** **Colors**
- **[4]** **State** (Hovered/Focused/Pressed/Disabled)

### Fill

[![Fill Settings](https://dev.epicgames.com/community/api/documentation/image/f1346956-d05f-465e-855d-3a83d6cdd384?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f1346956-d05f-465e-855d-3a83d6cdd384?resizing_type=fit)

Options in the **Fill** section affect the shape of your material. For many options like **Fill Transparency**, a **0.0** value will deactivate the setting while a **1.0** value will activate it. Always remember to activate the Fill Transparency option so your shape will show in the **Viewport**.

In the image above, you’ll see the adjusted settings that were used to create a shape.

### Stroke

[![Stroke Settings](https://dev.epicgames.com/community/api/documentation/image/295e04d1-7b2e-424a-8544-a500c58b6c31?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/295e04d1-7b2e-424a-8544-a500c58b6c31?resizing_type=fit)

Options in the **Stroke** section can be adjusted to create a customizable border. Due to the preset blue border color, you'll be able to see your design as you adjust the Stroke's option values.

The image above shows the **Stroke Transparency** option set to 1.0 to display a blue border.

### Colors

[![Color Settings](https://dev.epicgames.com/community/api/documentation/image/ad4867b7-bd3a-49f6-9cba-c1766af0f60d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ad4867b7-bd3a-49f6-9cba-c1766af0f60d?resizing_type=fit)

Options in the **Color** tab can be altered to further customize the shapes you create. These options can only be adjusted once you set the option to "On" by clicking its corresponding boolean box.

You can even create gradients for both shapes and borders. You can preview gradients as they are altered in the Viewport.

In the image above colors are applied in gradients. This option is activated by adjusting the **Gradient on/off** value above **0.0**.

### State

This option is located in the **Color** section and can modified to set the shape's colors through various states. You can set custom colors for different player actions, such as hover, focus, press, or disable your UI shape.

Unless you set a material for the **Phys Material** option, your shape will have a transparent boundary when imported into the widget you create. To avoid this, set your physical material as **Wood** so it can be rendered as an actual material.

After you’re done customizing your UI shape, remember to save by clicking the floppy disk icon in the top right corner. Your customized material instance will save to your project's content folder.

[![Materials for Example](https://dev.epicgames.com/community/api/documentation/image/fdca6cbf-ed94-4ad2-9f57-2dd26bb4b00c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fdca6cbf-ed94-4ad2-9f57-2dd26bb4b00c?resizing_type=fit)

This tutorial's example uses shapes that combine to make up a sunflower along with a button background.

## Creating UI Widgets

[![Custom Widget](https://dev.epicgames.com/community/api/documentation/image/c8d902cd-961c-4c2b-aa24-d13449b9cefd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c8d902cd-961c-4c2b-aa24-d13449b9cefd?resizing_type=fit)

Now you’ll need to create widgets for players to interact with. Read the **[UI Widget Editor](https://dev.epicgames.com/documentation/en-us/fortnite/ui-widget-editor-in-unreal-editor-for-fortnite)** doc to learn more about creating widgets and organizing the Hierarchy tab.

At this point, you should have created material instances for every element of your design.

[![Material Instances](https://dev.epicgames.com/community/api/documentation/image/4606f490-4aa0-4ec0-87c2-5100e6ca485e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4606f490-4aa0-4ec0-87c2-5100e6ca485e?resizing_type=fit)

This tutorial's example consists of multiple instances of a flower petal and a flower disk. The button consists of a base and two images that are used as button icons.

These material instances will be arranged in widget blueprints to create a custom design. The widget blueprint is what will be imported into the [Pop-Up Dialog device](https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative) to override the pre-stock UI.

Create a new widget blueprint that will hold both the material instances and the button widgets that make up your custom UI. This will be the widget blueprint that is added to the device's settings.

In this widget, combine all of your custom material instances to create your design. As you create your UI widget, drag assets from **Common**, **Common UI**, **Panel**, **UIKIT**, and **User Created** underneath your widget name.

[![Custom UI Widget](https://dev.epicgames.com/community/api/documentation/image/1e27d3b4-24b4-4af7-aa74-7c4ab889dc58?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e27d3b4-24b4-4af7-aa74-7c4ab889dc58?resizing_type=fit)

In the photo above, assets are organized in the **Hierarchy** tab and repositioned in the viewport to make a flower shape for the custom UI.

After you are satisfied with your design, save your blueprint and navigate back to your Content Browser. This blueprint will now be imported into a Pop-Up Dialog device that will display the custom UI.

## Adding Widgets to Devices

[![Pop-Up Dialog device](https://dev.epicgames.com/community/api/documentation/image/d41e76b8-676d-4757-9406-596093fb469c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d41e76b8-676d-4757-9406-596093fb469c?resizing_type=fit)

Once your design is ready, place a Pop-Up Dialog device to display your widget.

[![Pop-Up Dialog options](https://dev.epicgames.com/community/api/documentation/image/eeee56eb-d8ce-4dea-b7e4-558b0876d8c7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eeee56eb-d8ce-4dea-b7e4-558b0876d8c7?resizing_type=fit)

Drag your widget into the **Details > Modal Widget > Template Override Class**.

You can view and test your creation through a [launched session](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite).
