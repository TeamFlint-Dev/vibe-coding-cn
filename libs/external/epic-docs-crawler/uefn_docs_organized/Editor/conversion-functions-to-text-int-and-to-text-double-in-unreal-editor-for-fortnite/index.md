# Conversion Functions: To Text (Int) and To Text (Double)

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/conversion-functions-to-text-int-and-to-text-double-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T02:17:49.815153

---

Pass Integer or Float variables to a widget using the **ToText(Int)** and **ToText(Double)** Conversion Functions. The "ToText" conversion functions convert a variable of type [Integer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) or [Float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) to a **Text** type you can display on your widget. A variable will not display on your widget if they remain as a non-Text type.

The conversion function is actually called To Text (Double) in the Editor instead of To Text (Double), but they serve the same purpose.

Below are two examples that illustrate the use of both conversion functions.

- **To Text (Int)** example: A custom Tracker widget tracks a player’sr progress when they pick up a number of bacon.
- **To Text (Double)** example: A custom Popup Dialog widget opens a pop-up with possible answers to a trivia question. A countdown timer is used to close the timer if an answer hasn’t been selected before the time is up.

## To Text (Int)

In this example, a custom **Tracker widget** is created to track how many bacon the player has collected. Use the steps in the [UI Pop-Ups document](https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite) to create a **User Widget** and name it **Tracker\_Widget**.

[![In this example, a custom **Tracker widget** is created to track how many bacon the player has collected.](https://dev.epicgames.com/community/api/documentation/image/3528bab0-e62d-4750-a743-72379c987854?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3528bab0-e62d-4750-a743-72379c987854?resizing_type=fit)

### Widget Setup

To set up the Tracker\_Widget, add the following widgets in the order presented below to the Hierarchy panel:

- **Overlay**
- **Image** (Nest under the Overlay and rename to Background.)
- **Stack Box** (Nest under the Overlay)
- **Text Block** (Nest under the first Stack Box and rename to Title, this is your Tracker Title "{Tracker Title}")
- **Stack Box** (Nest under the first Stack Box.)
- **2 X Text Block** (Nest under the second Stack Box. Rename the first text bloxk to CurrentValue "{Current}" and the second text block to Flavor Text "Bacon Collected".)

You need a text block that takes in the current number of Bacon the palyer collects. The Tracker\_Widget is set up to include a **TrackerTitle text block** so the **Name** property can pass from the viewmodel into the **Current** text block:

[![The Tracker_Widget is set up to include a TrackerTitle text block so the Name property can pass from the viewmodel into the Current text block](https://dev.epicgames.com/community/api/documentation/image/98f8b948-fb99-4190-a33d-954d4d202494?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/98f8b948-fb99-4190-a33d-954d4d202494?resizing_type=fit)

Set up your widget using the same

This is what the player sees in game when they collect bacon:

[![](https://dev.epicgames.com/community/api/documentation/image/42d2650e-4204-43fe-a614-df8c5a1f0e35?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42d2650e-4204-43fe-a614-df8c5a1f0e35?resizing_type=fit)

### Conversion Function Setup

The **To Text (Int)** conversion function is used to pass the current amount of bacon onto the Tracker device through the **CurrentValue** text block.

To set up the To Text (Int) conversion functions, create View Bindings and bind the values you set in the widget to the [Tracker device](https://dev.epicgames.com/documentation/en-us/fortnite/using-tracker-devices-in-fortnite-creative).

1. Open **Window** > **View Bindings**.

   [![Open Window > View Bindings.](https://dev.epicgames.com/community/api/documentation/image/a4f93d30-531e-41b3-87ec-0e2c299194ef?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4f93d30-531e-41b3-87ec-0e2c299194ef?resizing_type=fit)
2. Select the **CurrentValue** text block in your widget, and click **+Add Widget** in the **View Bindings** window.

   [![Select the CurrentValue text block in your widget, and click +Add Widget in the View Bindings window.](https://dev.epicgames.com/community/api/documentation/image/5c27bb78-8e14-4650-bd4a-80492811a38d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c27bb78-8e14-4650-bd4a-80492811a38d?resizing_type=fit)
3. In the left box of the view binding, select **CurrentValue** > **Text**. This means that Text will pass into the Text property of the CurrentValue text block.

   [![In the left box of the view binding, select CurrentValue > Text.](https://dev.epicgames.com/community/api/documentation/image/0a064657-ab63-4e76-a3ee-ac9fb5ca9833?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a064657-ab63-4e76-a3ee-ac9fb5ca9833?resizing_type=fit)
4. In the right box, click in the field and select **Conversion Functions** > **To Text (Integer)**. A number of fields appear in the binding for the CurrentValue text block.

   To learn more about what each field does, refer to the **To Text (Int/Double) Properties** section.

   This runs a conversion function called **To Text (Integer)** that takes in a value and returns a variable of Text type to pass into the **Text property** of the **CurrentValue text block**.

   [![In the right box, click in the field and select Conversion Functions > To Text (Integer).](https://dev.epicgames.com/community/api/documentation/image/627bc44b-e565-47df-9673-5a4fe05f2d7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/627bc44b-e565-47df-9673-5a4fe05f2d7a?resizing_type=fit)
5. Select the **chain icon** next to **Value** and select **MVVM\_UEFN\_Tracker** > **Value**.

   [![Select the chain icon next to Value and select MVVM_UEFN_Tracker > Value.](https://dev.epicgames.com/community/api/documentation/image/4328cfc4-0db8-446c-ac38-9c176be0c7c8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4328cfc4-0db8-446c-ac38-9c176be0c7c8?resizing_type=fit)

The **Value** variable from the **Tracker viewmodel** passes into the **To Text (Integer)** conversion function. This outputs the Value variable as a Text property which is then passed into the Text property of the CurrentValue text block.

### Final Result

To use your new widget, drag a **Tracker** device into your project, then do the following:

1. In the Details panel for the Tracker device, set the **HUD Widget field** to your **Track\_Widget**.

   The Tracker can be used to track the Score stat, and use Collectible Objects in your level to test this functionality.

Whenever the player collects Bacon in-game, the tracker automatically increments by the score value set for each bacon.

[![Whenever the player collects Bacon in-game, the tracker automatically increments by the score value set for each bacon.](https://dev.epicgames.com/community/api/documentation/image/646bc82f-7255-4500-aedd-a72b475677e0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/646bc82f-7255-4500-aedd-a72b475677e0?resizing_type=fit)

## To Text (Double)

In this example, use the **Modal Dialogue Variant** workflow from the [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/fortnite/ui-popups-in-unreal-editor-for-fortnite) document to create a custom Popup Dialog widget called **Trivia\_Widget**. The Trivia\_Widget displays trivia questions from Fortnite which have to be answered before the time limit runs out.

[![The Trivia_Widget displays trivia questions from Fortnite which have to be answered before the time limit runs out.](https://dev.epicgames.com/community/api/documentation/image/b826ea41-0e9e-474a-920e-93ece0aebefd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b826ea41-0e9e-474a-920e-93ece0aebefd?resizing_type=fit)

### Widget Setup

1. Right click in the **Content Browser** to bring up the Context Menu.

   [![Right click in the Content Browser to bring up the Context Menu](https://dev.epicgames.com/community/api/documentation/image/fea0e226-d025-4817-b05c-7afaf29baff6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fea0e226-d025-4817-b05c-7afaf29baff6?resizing_type=fit)
2. From the Context Menu select **User Interface** > **Widget Blueprint** > **Modal Dialog Variant**.

   [![From the Context Menu select User Interface > Widget Blueprint > Modal Dialog Variant.](https://dev.epicgames.com/community/api/documentation/image/c51f1c85-323d-4a4c-912f-3b9a3585fdea?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c51f1c85-323d-4a4c-912f-3b9a3585fdea?resizing_type=fit)
3. Open your widget and add the following containers to the Hierarchy panel in the order shown in the image:

   1. **Overlay**
   2. **Image**
   3. **3 X Stack Box**

   An Overlay houses the entire widget as the parent container. Next, use an Image widget for the background, and lastly multiple nested Stack Boxes to contain all the content such as your texts and buttons.

   [![An Overlay houses the entire widget as the parent container.](https://dev.epicgames.com/community/api/documentation/image/0113e89e-7119-48df-bd34-74b9ac0f38a4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0113e89e-7119-48df-bd34-74b9ac0f38a4?resizing_type=fit)
4. Add **text blocks** and **buttons** to your **stack boxes** as pictured below.

   [![Add text blocks and buttons to your stack boxes as pictured below.](https://dev.epicgames.com/community/api/documentation/image/b7c0197d-3a94-4bb2-9f86-3087d1326e2c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b7c0197d-3a94-4bb2-9f86-3087d1326e2c?resizing_type=fit)

   Wrap the **TimeLeft** and **TimeFlavorText** text blocks in a **Stack Box** so the TimeLeft is dynamically updated through a view binding to the Remaining Time for Timeout variable in the Popup Dialog viewmodel.

   [![Wrap the TimeLeft and TimeFlavorText text blocks in a Stack Box so the TimeLeft is dynamically updated.](https://dev.epicgames.com/community/api/documentation/image/dff584ba-07fd-44cf-abfa-3265b94112f0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dff584ba-07fd-44cf-abfa-3265b94112f0?resizing_type=fit)

   If you find that you need to wrap a widget with a container in an existing structure, you don’t have to re-do the entire widget. Right click on the widget, and select **Wrap With…** or **Replace With…** to easily add a new panel within a container.

   [![Use the options Wrap With… and Reopkace With… to easily edit your Hierarchy panel and introduce new widgets into the hierarchy stack.](https://dev.epicgames.com/community/api/documentation/image/5d4ccedb-c98f-466c-bcda-16ed3b4d5341?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5d4ccedb-c98f-466c-bcda-16ed3b4d5341?resizing_type=fit)
5. Add the buttons as a **2x2 grid**. Since the buttons are in a 2x2 grid, use a **Uniform Grid Panel** instead of a Stack Box. Right-click on **Container\_Buttons** > **Replace With…** > **Uniform Grid Panel**.

   The Uniform Grid Panel allows you to easily organize its child widgets in a grid pattern. You can also easily set the slot padding for each child.

   [![Add the buttons as a 2x2 grid.](https://dev.epicgames.com/community/api/documentation/image/5c56239c-8d38-48c3-b804-104327e85502?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5c56239c-8d38-48c3-b804-104327e85502?resizing_type=fit)
6. Select **each button** individually in the Hierarchy to highlight the button in the Main Designer View.
7. From the Main Designer View, click on the **arrows** surrounding the Button to move the button into a specific row or column where you want the button to be.

   In the example below, the buttons are arranged in a left-to-right, and top-to-bottom layout. The buttons were renamed to **Button1**, **Button2**, **Button3**, and **Button4**.

   [![](https://dev.epicgames.com/community/api/documentation/image/2d7bf184-0f06-4767-9a44-5c9a5ad01f21?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d7bf184-0f06-4767-9a44-5c9a5ad01f21?resizing_type=fit)
8. In the Details Panel, set the **Child Layout** > **Slot Padding** to **16px** for the Container\_Buttons.

   Tweak this value however you see fit for your own design.

   [![In the Details Panel, set the Child Layout > Slot Padding to 16px for the Container_Buttons.](https://dev.epicgames.com/community/api/documentation/image/9d9ff4a4-fe52-4b87-9149-0b5a4db7032e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d9ff4a4-fe52-4b87-9149-0b5a4db7032e?resizing_type=fit)
9. In the **Content Stack Box**, add a **Quiet Button** to use as a Close button later.

   [![In the Content Stack Box, add a Quiet Button to use as a Close button later.](https://dev.epicgames.com/community/api/documentation/image/eff495e8-9998-4047-a741-2b7da5c0f3dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eff495e8-9998-4047-a741-2b7da5c0f3dd?resizing_type=fit)
10. Add some spacers between the containers to make the content more readable. You can do this by adding an Image widget to where you want spaces to be, then in the Details panel use th efollowing options:

    1. **Brush** > **Draw As** = **None**
    2. **Image Size** (X and Y values) = **35** (Can be more or less depending on yoru design.)

    This is an easily manageable way of handling spacing between your UI elements without relying on padding.

    [![Add space between the containers using Image widgets.](https://dev.epicgames.com/community/api/documentation/image/f6939705-14e7-489a-9713-46a5bbdd416a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f6939705-14e7-489a-9713-46a5bbdd416a?resizing_type=fit)

    ![Draw as Image](https://dev.epicgames.com/community/api/documentation/image/401ff6a5-47d2-47a7-a54c-93c9db71d08b?resizing_type=fit&width=1920&height=1080)

    ![Draw as None](https://dev.epicgames.com/community/api/documentation/image/e98b10c6-1ce6-49ed-a323-02a61a1bad62?resizing_type=fit&width=1920&height=1080)

    Draw as Image

    Draw as None
11. Edit the Button text to easily identify each button.

    [![Edit the Button text to easily identify each button.](https://dev.epicgames.com/community/api/documentation/image/e8f04649-1c53-4e71-8e5b-c18ea58100ab?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8f04649-1c53-4e71-8e5b-c18ea58100ab?resizing_type=fit)
12. Open the **Fortnite** > **UI** folders and [create a Material Instance](https://dev.epicgames.com/documentation/en-us/fortnite/creating-custom-ui-with-material-instances-in-unreal-editor-for-fortnite) of the **M\_UI\_Rectangle** to make a background material for your trivia pop-up.

    [![Create a material instance copy from the M_UI_Rectangle material.](https://dev.epicgames.com/community/api/documentation/image/d5499bf5-8fcd-415b-912d-aad6663f9db6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d5499bf5-8fcd-415b-912d-aad6663f9db6?resizing_type=fit)
13. From UMG, open your user widget and select the **Background image** widget, and in the **Brush** > **Image** field, select the material instance you just made.

    [![Select the Background image widget, and in the Brush > Image field, select the material instance you just made.](https://dev.epicgames.com/community/api/documentation/image/8f9044ca-e8f2-4a48-806d-dabd13f0a577?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8f9044ca-e8f2-4a48-806d-dabd13f0a577?resizing_type=fit)
14. Add **32px** of padding in the Content Stack Box to make the pop-up more readable.

    [![Add 32px of padding in the Content Stack Box to make the pop-up more readable.](https://dev.epicgames.com/community/api/documentation/image/33fae4a4-9ea0-44c8-9dc8-d636e536094a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/33fae4a4-9ea0-44c8-9dc8-d636e536094a?resizing_type=fit)

### Conversion Function Setup

Binding button responses won’t be covered in this documentation. Instead the tutorial is concerned with binding the **TimeLeft** text to the **Float** variable for **Remaining Time** for Timeout.

1. Open **Window** > **View Bindings**.

   [![Open Window > View Bindings.](https://dev.epicgames.com/community/api/documentation/image/de7c7139-6363-405c-a1f8-88d8d3dae14f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de7c7139-6363-405c-a1f8-88d8d3dae14f?resizing_type=fit)
2. From the Hierarchy panel, select the **TimeLeft** text block widget. In the **View Bindings** window, click **+Add Widget**.

   [![From the Hierarchy panel, select the TimeLeft text block widget. In the View Bindings window, click +Add Widget.](https://dev.epicgames.com/community/api/documentation/image/96a947df-74fa-497a-9c23-ba0b98464548?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/96a947df-74fa-497a-9c23-ba0b98464548?resizing_type=fit)
3. In the left box, select **TimeLeft** > **Text**. This passes some form of value into the Text property of TimeLeft.

   [![In the left box, select TimeLeft > Text. This passes some form of value into the Text property of TimeLeft.](https://dev.epicgames.com/community/api/documentation/image/2df0abad-0bd1-4c1b-9ba4-e1a08aa74a37?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2df0abad-0bd1-4c1b-9ba4-e1a08aa74a37?resizing_type=fit)
4. In the right box, select **CreativeModalDialogViewmodel** > **Remaining Time for Timeout**. Then select **Conversion Functions** > **To Text (Double)**.

   Hovering over the variable reveals that this value is a Float value. The conversion function **To Text (Double)** provides a way for you to convert a **Double/ Float value** to a **Text variable**, and displays them in your UI.

   [![In the right box, select CreativeModalDialogViewmodel > Remaining Time for Timeout. Then select Conversion Functions > To Text (Double).](https://dev.epicgames.com/community/api/documentation/image/6cade89f-c4aa-4012-8f6e-226918b6a9dd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6cade89f-c4aa-4012-8f6e-226918b6a9dd?resizing_type=fit)

   A number of fields appear in the View Binding window.

   For more information about these fields, refer to the **To Text (Int / Double) Properties** section of the document.
5. Click the **chain icon** next to **Value**, and select **CreativeModalDialogViewmodel** > **Remaining Time for Timeout** > **Select**.

   [![Click the chain icon next to Value, and select CreativeModalDialogViewmodel > Remaining Time for Timeout.](https://dev.epicgames.com/community/api/documentation/image/2323f00d-1c73-4f21-9a75-8f1265a3dff6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2323f00d-1c73-4f21-9a75-8f1265a3dff6?resizing_type=fit)

The Remaining Time for Timeout variable is passed into the To Text (Double) conversion function that outputs the Float value into a Text format that is readable by your UI. Your UI accurately displays the time left before the Popup Dialog widget closes.

### Final Result

Drag a [Pop-up Dialog device](https://dev.epicgames.com/documentation/en-us/fortnite/using-popup-dialog-devices-in-fortnite-creative) into your project and do the following:

1. In a Popup Dialog device, set the **Template Override Class** to the **Trivia\_Widget** you created.
2. Check Use Dialog Timeout.
3. Set Timeout Duration to 6 seconds or whatever time you think would give players enough time to see the pop-up and read it.

Now when your Pop-up Dialog widget shows up, you can see the Timer tick down every second inside the pop-up window.

[![When your Pop-up Dialog widget shows up, you can see the Timer tick down every second inside the pop-up window.](https://dev.epicgames.com/community/api/documentation/image/179f049b-4e4a-4e98-b817-8a4cdd538f3d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/179f049b-4e4a-4e98-b817-8a4cdd538f3d?resizing_type=fit)

## To Text (Int/Double) Properties

There are a number of fields available in the To Text (Int) conversion function. To Text (Double) shares the same fields unless specified otherwise:

- **Value -** The Integer variable to pass into the conversion function.
- **Always Sign -** Adds a positive or negative sign to the prefix for the Text output indicating whether the value is a positive or negative value. If the value is positive, it outputs the text as +{Value}. If it’s negative, it outputs the text as -{Value}.
- **Use Grouping -** Determines whether the values are grouped together but separated by when the value is above 1000. It will use the cultural-sensitive setting on your computer for the grouping indicator. If turned on, it outputs the text as 1,000. If turned off, it outputs the text as 1000.
- **Minimum Integral Digits -** The minimum number of integer digits to show on the text. The default value is 1. If setting minimum to above 1, it will display 0’s for integers with a number of digits less than the minimum integral digits. For example, if minimum integral digits is set to 3 and the Value is currently 5, the text outputs as 005.
- **Maximum Integral Digits -** The maximum number of integer digits to show in the text. The default value is 354. This restricts your text to only show a maximum number of digits.
- **Minimum Fractional Digits (only for** ***To Text (Double)*****) -** The minimum number of digits to show after the decimal point. The default value is 0.
- **Maximum Fractional Digits (only for** ***To Text (Double)*****) -** The maximum number of digits to show after the decimal point. The default value is 3.
- **Rounding Mode (only for** ***To Text (Double)*****) -** Determines how the Float/Double value rounds up to the nearest number.

| Type | Description | Example |
| --- | --- | --- |
| **Half to Even** | Rounds to the nearest place, equidistant ties go to the value which is closest to an even value | 1.5 becomes 2, 0.5 becomes 0 |
| **Half from Zero** | Rounds to nearest place, equidistant ties go to the value which is further from zero | -0.5 becomes -1.0, 0.5 becomes 1.0 |
| **Half to Zero** | Rounds to nearest place, equidistant ties go to the value which is closer to zero | -0.5 becomes 0, 0.5 becomes 0. |
| **From Zero** | Rounds to the value which is further from zero, "larger" in absolute value | 0.1 becomes 1, -0.1 becomes -1 |
| **To Zero** | Rounds to the value which is closer to zero, “smaller” in absolute value | 0.1 becomes 0, -0.1 becomes 0 |
| **To Negative Infinity** | Rounds to the value which is more negative | 0.1 becomes 0, -0.1 becomes -1 |
| **To Positive Infinity** | Rounds to the value which is more positive | 0.1 becomes 1, -0.1 becomes 0 |
