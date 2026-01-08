# Making an Animated Timer

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/making-an-animated-timer-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-27T00:07:57.789969

---

Create a custom animated timer for time sensitive games. With UI animations, you can make the timer pulse and disappear, or even add a custom countdown material that surrounds the clock.

This tutorial shows you how to:

- Set up a material.
- Animate a clockface.
- Change the clock color.

Create a User Widget in the Content Browser by following the instructions in the [UI Pop-Ups](https://dev.epicgames.com/documentation/en-us/uefn/ui-popups-in-unreal-editor-for-fortnite) tutorial.

## Step 1: Set Up the Widgets

Once you’ve created the User Widget, double-click the User Widget thumbnail to open the [Widget Editor](https://dev.epicgames.com/documentation/en-us/uefn/ui-widget-editor-in-unreal-editor-for-fortnite).

1. Drag an **Overlay** widget into the widget graph and resize it to **1920 x 1080** by dragging the bottom right-corner. This widget acts as the screen where the UI will display.
2. Right-click on the **Overlay** widget in the Hierarchy panel to rename the widget to **Root**. This name also reminds you that it is the widget acting as a model of the screen.

   [![](https://dev.epicgames.com/community/api/documentation/image/02f0113b-dac8-489a-ab5e-40622047c74d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/02f0113b-dac8-489a-ab5e-40622047c74d?resizing_type=fit)
3. Drag a second **Overlay** widget into the **Root** widget. This widget will contain all the widgets that make up the design and function of the animated timer.
4. Rename the second **Overlay** widget to **ParentContainer** in the **Hierarchy** panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/93ddcc5e-2f43-4de5-89b3-b8568a708286?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93ddcc5e-2f43-4de5-89b3-b8568a708286?resizing_type=fit)
5. In the Details panel, set the following properties:

   1. Padding = **25.0**
   2. Horizontal Alignment = **Center Alignment Horizontally**

   [![](https://dev.epicgames.com/community/api/documentation/image/ce2c6698-e385-4ac3-bbef-3b67b0a63481?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ce2c6698-e385-4ac3-bbef-3b67b0a63481?resizing_type=fit)
6. Drag a **Size Box** widget into the **ParentContainer** widget. This will determine and enforce the size of its child widgets. The child widgets of the Size Box will become the clock face.

   [![](https://dev.epicgames.com/community/api/documentation/image/0cee6a1e-c2d7-4a75-add4-8a31935e3d79?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0cee6a1e-c2d7-4a75-add4-8a31935e3d79?resizing_type=fit)
7. Rename the **Size Box** widget to **BGSizeBox** in the Hierarchy panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/4255137d-49a4-419d-adfb-35335fb78ba8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4255137d-49a4-419d-adfb-35335fb78ba8?resizing_type=fit)
8. In the **Details** panel, set the **Horizontal Alignment** and **Vertical Alignment** to **Center Alignment**.

   [![](https://dev.epicgames.com/community/api/documentation/image/42a6a7bc-96c1-4946-bc31-a86cf4b4e2b8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42a6a7bc-96c1-4946-bc31-a86cf4b4e2b8?resizing_type=fit)
9. Check to select the **Minimum Desired** **Width** and **Maximum Desired Height** to toggle this option on, then set the properties to **130.0**.

   [![](https://dev.epicgames.com/community/api/documentation/image/72e1235d-eb2a-4585-9d41-e2a7d5cb034b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/72e1235d-eb2a-4585-9d41-e2a7d5cb034b?resizing_type=fit)

     The container should sit in the Root widget as shown below

   [![](https://dev.epicgames.com/community/api/documentation/image/f2c4c1e0-9d9c-4a80-9b2e-6dd6e8fce04b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2c4c1e0-9d9c-4a80-9b2e-6dd6e8fce04b?resizing_type=fit)
10. Drag an **Image** widget into the **BGSizeBox** widget.

    [![](https://dev.epicgames.com/community/api/documentation/image/79fb9134-d465-4025-a5ee-cbdd4d0bc74d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79fb9134-d465-4025-a5ee-cbdd4d0bc74d?resizing_type=fit)
11. Rename the **Image** widget **Timer** in the **Hierarchy** panel.

    [![](https://dev.epicgames.com/community/api/documentation/image/18afcaea-f4cd-4e51-a4a4-63e865a421d6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/18afcaea-f4cd-4e51-a4a4-63e865a421d6?resizing_type=fit)
12. In the **Details** panel, set the **Horizontal Alignment** and **Vertical Alignment** to **Center Alignment**.

    [![](https://dev.epicgames.com/community/api/documentation/image/16142807-1101-4c13-acd8-d620b3cddbcf?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/16142807-1101-4c13-acd8-d620b3cddbcf?resizing_type=fit)
13. Add a material instance to the **Brush** > **Image** property. This could be a material that counts down the time.

    [![](https://dev.epicgames.com/community/api/documentation/image/3ca5717d-0e0b-46db-b2e2-aa6deb9aaa0c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3ca5717d-0e0b-46db-b2e2-aa6deb9aaa0c?resizing_type=fit)

    The material fills the space inside the Parent Container widget.

    ![](https://dev.epicgames.com/community/api/documentation/image/a42be841-3818-4a44-ae96-dfe55adee7d6?resizing_type=fit)
14. Drag a **Text Box** widget into the **Parent Container** widget.

    [![](https://dev.epicgames.com/community/api/documentation/image/3b2ee0d3-2376-48ee-b84a-1966604c1df5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3b2ee0d3-2376-48ee-b84a-1966604c1df5?resizing_type=fit)
15. Rename the **Text Box** widget to **TimerText** in the **Hierarchy** panel.

    [![](https://dev.epicgames.com/community/api/documentation/image/f06828a1-0f3b-4e35-b6ab-912cd665b91d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f06828a1-0f3b-4e35-b6ab-912cd665b91d?resizing_type=fit)
16. In the **Details** panel, set the **Text** property to **00:00**.

    [![](https://dev.epicgames.com/community/api/documentation/image/51ea06d8-8794-47e1-8d93-465f70b2beca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/51ea06d8-8794-47e1-8d93-465f70b2beca?resizing_type=fit)

    The Timer Text widget sits directly in the middle of the User Widget.

    [![](https://dev.epicgames.com/community/api/documentation/image/65139125-3652-40d1-b5d0-08f4f85caa4d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/65139125-3652-40d1-b5d0-08f4f85caa4d?resizing_type=fit)

Next, you’ll animate the Timer Text widget to make the time more dynamic during the Urgency state.

## Step 2: Animate the Timer Text

To create a feeling of imminent danger to the urgency state during the last few seconds of your timer, animate the clock time.

In the animation created below, the timer text will enlarge, turn red, then fade away. This animation will repeat for the duration of the Urgency mode set in the [Timer device](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-timer-devices-in-fortnite-creative).

1. Click **Animations** at the bottom of the **Widget Editor** screen. This opens a Sequencer panel where you can create animations and add widgets to the animation sequence.

   [![](https://dev.epicgames.com/community/api/documentation/image/1e02f8cb-95c1-4bd8-96d3-e514f0f4a244?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1e02f8cb-95c1-4bd8-96d3-e514f0f4a244?resizing_type=fit)
2. Click **+Animation** to create an animation file in your User Widget.

   [![](https://dev.epicgames.com/community/api/documentation/image/5234f3b4-a9e8-41f1-8567-2588b8c48362?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5234f3b4-a9e8-41f1-8567-2588b8c48362?resizing_type=fit)
3. Name the animation **Urgency**. This animation will be set later when you add bindings to the User Widget.

   [![](https://dev.epicgames.com/community/api/documentation/image/47eac4bb-bbd3-4f8f-90cc-e35fb3b267a3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/47eac4bb-bbd3-4f8f-90cc-e35fb3b267a3?resizing_type=fit)

     A blue **SELECTED** square surrounds the Widget Graph.

   [![](https://dev.epicgames.com/community/api/documentation/image/f4644a64-d3cf-4646-a32c-f6929cacdabd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4644a64-d3cf-4646-a32c-f6929cacdabd?resizing_type=fit)
4. Click **+Add** to open the list of objects that can be added to the animation in the User Widget.

   [![](https://dev.epicgames.com/community/api/documentation/image/e5a8e2de-f931-4044-a97c-7659a58ccce0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e5a8e2de-f931-4044-a97c-7659a58ccce0?resizing_type=fit)
5. In the **Hierarchy** panel, select the **TimerText** widget.
6. Select **TimerText** from the list to add TimerText to the Sequencer panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/6ad1eacc-74fa-4a64-a02d-d803eb718bc0?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6ad1eacc-74fa-4a64-a02d-d803eb718bc0?resizing_type=fit)
7. Next to **TimerText**, select the **+ icon** to open the list of properties that can be animated.

   [![](https://dev.epicgames.com/community/api/documentation/image/23166269-533c-4e2a-ad2d-04fd36444cb6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23166269-533c-4e2a-ad2d-04fd36444cb6?resizing_type=fit)
8. Select **Transform** from the list. This adds all the ways you can transform the text:  Translation, Rotation, Scale, and Shear.

   [![](https://dev.epicgames.com/community/api/documentation/image/d901907b-3b61-48b9-82c2-8794b9854a09?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d901907b-3b61-48b9-82c2-8794b9854a09?resizing_type=fit)
9. Open the **Scale** options and select the **+ Keyframe** **icon** to add keyframes to the timeline. The **X-axis** and **Y-axis** options increase and decrease the size of the text when you input new values.

   [![](https://dev.epicgames.com/community/api/documentation/image/4c2df026-da37-4e09-b208-b1ce573cbf7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4c2df026-da37-4e09-b208-b1ce573cbf7d?resizing_type=fit)
10. Move the **playhead** in the timeline to **0.25** seconds, change the **X-axis** and **Y-axis** values to **1.5**, then press the **+Keyframe** **icon** next to the **X-axis** and **Y-axis** options. Keyframes appear in the timeline showing a progression on the TimerText.

    [![](https://dev.epicgames.com/community/api/documentation/image/f4222cff-2fe4-40eb-8620-58c129fc3001?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4222cff-2fe4-40eb-8620-58c129fc3001?resizing_type=fit)
11. Move the **playhead** in the timeline to **0.5** seconds, change the **X-axis** and **Y-axis** values to **2.0**, then press the **+Keyframe icon** next to the **X-axis** and **Y-axis** options. Additional keyframes appear in the timeline showing a progression of the text.

    [![](https://dev.epicgames.com/community/api/documentation/image/8824f25d-6a10-4a98-b516-2e9e47626bb2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8824f25d-6a10-4a98-b516-2e9e47626bb2?resizing_type=fit)
12. Select the **+ icon** next to **TimerText** and select **Color & Opacity** from the list. This adds Red, Green, Blue, and Alpha properties to Sequencer.

    [![](https://dev.epicgames.com/community/api/documentation/image/1af07e94-6e3d-4e26-b482-1fbdaa341a3d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1af07e94-6e3d-4e26-b482-1fbdaa341a3d?resizing_type=fit)
13. Reset the **playhead** in the timeline and select the **+ Keyframe** **icon** next to **Color & Opacity**. This sets the first keyframe for each of the Color & Opacity properties in the timeline.
14. Expand **Color & Opacity**, change the **Red** value to **1.0**, the **Green** value to **0.0**, and **Blue** values to **0.0.** This creates a red color.

    [![](https://dev.epicgames.com/community/api/documentation/image/42922a1d-8523-4b7e-bc38-548b60140576?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/42922a1d-8523-4b7e-bc38-548b60140576?resizing_type=fit)
15. Move the **playhead** to **0.25** seconds, then select the **+ Keyframe** **icon** next to each of the Properties under Color & Opacity. This adds keyframes to the timeline.

    [![](https://dev.epicgames.com/community/api/documentation/image/cec9e225-eaff-47e2-afb0-a9b147b0ff6e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cec9e225-eaff-47e2-afb0-a9b147b0ff6e?resizing_type=fit)
16. Move the **playhead** to **0.5** seconds, change the **Alpha** value to **0.0**, and select the **+ Keyframe ico**n. When the animation reaches the last keyframes in the timeline the text disappears.

    [![](https://dev.epicgames.com/community/api/documentation/image/e53b101c-1473-418d-9bf9-79acf1bfb179?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e53b101c-1473-418d-9bf9-79acf1bfb179?resizing_type=fit)

    If you move the playhead back and forth across the timeline, you’ll see the animation you created play in the Widget Graph.

 Next, you’ll add a View Model and add View Bindings to replace the Timer device with the User Widget.

## Step 3: Add the View Bindings

To replace the default Timer device UI, you’ll bind the Text Box widget (TimerText) to the Timer device’s settings.

1. From the **Windows** menu, select **Viewmodel**. The Viewmodel window opens.

   [![](https://dev.epicgames.com/community/api/documentation/image/0d3da990-9c7b-48d8-bc1f-3510b921d3f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0d3da990-9c7b-48d8-bc1f-3510b921d3f3?resizing_type=fit)
2. Click **+Viewmodel**, then select **Device - Timer View Model** > **Select**. All the Timer device viewmodels are now available to be bound to your User Widget.

   [![](https://dev.epicgames.com/community/api/documentation/image/3c863a30-2a55-4493-bd9c-99f6205635b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3c863a30-2a55-4493-bd9c-99f6205635b6?resizing_type=fit)
3. In the **Hierarchy** panel, select the **TimerText** widget.

   [![](https://dev.epicgames.com/community/api/documentation/image/1c38103d-a9b9-40da-a307-71fbc6eafd1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1c38103d-a9b9-40da-a307-71fbc6eafd1c?resizing_type=fit)
4. Click **View Bindings** on the bottom toolbar to open the View Bindings panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/cd63ba8e-4832-4c23-a525-2cb0af26ec6a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cd63ba8e-4832-4c23-a525-2cb0af26ec6a?resizing_type=fit)
5. Click **+TimerText Widget** to add the TimerText widget to the View Bindings panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/cffd047f-4981-4820-9968-d1a4c25f7280?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cffd047f-4981-4820-9968-d1a4c25f7280?resizing_type=fit)
6. Select the **TimerText field** to open the widget properties dropdown menu.d

   [![](https://dev.epicgames.com/community/api/documentation/image/a1312c56-4c3e-452a-8355-6165ab3dc2a7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a1312c56-4c3e-452a-8355-6165ab3dc2a7?resizing_type=fit)
7. In the dropdown menu, select **TimerText** > **Text** > **Select**. This identifies the TimerText widget’s Text as the property being bound.

   [![](https://dev.epicgames.com/community/api/documentation/image/04467d07-3ec3-498c-9906-2c06b445fdc1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/04467d07-3ec3-498c-9906-2c06b445fdc1?resizing_type=fit)
8. Select the blank right field to open the bindings dropdown menu.

   [![](https://dev.epicgames.com/community/api/documentation/image/38e8d4a3-3bd4-432a-9142-ee51802d5bc7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38e8d4a3-3bd4-432a-9142-ee51802d5bc7?resizing_type=fit)
9. From the bindings dropdown menu, select **TimerText ViewModel** > **Current Time** > **Select**. This binds the TimerText widget to the current time for the Timer device, and displays the current time on screen.

   [![](https://dev.epicgames.com/community/api/documentation/image/23e64f61-c1b6-4e9a-a847-c0f514c0eddd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23e64f61-c1b6-4e9a-a847-c0f514c0eddd?resizing_type=fit)

Next, you’ll add the animation to the viewmodel so it plays on screen during Urgency mode.

## Step 4: Add the Animation

You’ll add the animation similarly to how you added the bindings for TimerText in the View Bindings panel.

1. Select **+Add Condition** at the top of the View Bindings panel. This adds a conditional row to the View Bindings panel.

   [![](https://dev.epicgames.com/community/api/documentation/image/a7b12d57-00c5-4521-b7c1-37a2965ace5f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a7b12d57-00c5-4521-b7c1-37a2965ace5f?resizing_type=fit)
2. Open the viewmodel dropdown menu and select the **User Widget** > **Select**. This adds the User Widget to the Condition.

   [![](https://dev.epicgames.com/community/api/documentation/image/eba7d2df-5281-407d-bde3-d90aab13f607?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eba7d2df-5281-407d-bde3-d90aab13f607?resizing_type=fit)
3. Select the **left field** to open the viewmodel binding dropdown.
4. Select the Creative Timer **ViewModel** > **Is Urgency** > **Select**. This uses IsUrgency as a comparison property to see if it equals a specific value, then, based on the value that was returned (true/false), it triggers the animation.

   [![](https://dev.epicgames.com/community/api/documentation/image/fd869334-fed4-4c73-8803-ffb6201aef86?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fd869334-fed4-4c73-8803-ffb6201aef86?resizing_type=fit)
5. Change the time field to **1.0**. This means that if Is Urgency is equal to 1.0, then the value is true and the animation plays.

   [![](https://dev.epicgames.com/community/api/documentation/image/f2f193da-6aec-43c0-8bb6-a453273e0f8d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f2f193da-6aec-43c0-8bb6-a453273e0f8d?resizing_type=fit)
6. Select the **right field** to open the queue dropdown menu and select the **User Widget** > **Queue Play Animation** > **Select**. Now the animation you created will queue to play when the Is Urgency mode equals **1.0**.

   [![](https://dev.epicgames.com/community/api/documentation/image/79a78f9a-1da9-4f55-83b6-bf7c76b4a344?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/79a78f9a-1da9-4f55-83b6-bf7c76b4a344?resizing_type=fit)
7. Next to **In Animation**, select the binding icon so it turns into a blue **Link icon**.

   [![](https://dev.epicgames.com/community/api/documentation/image/de71fe6d-d182-4afe-b354-332bbe19d0c4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/de71fe6d-d182-4afe-b354-332bbe19d0c4?resizing_type=fit)
8. Select the **In Animation** field, then select **User Widget** > **Animation name** > **Select**. The selected animation plays when queued.

   [![](https://dev.epicgames.com/community/api/documentation/image/d50c15d1-78b4-4ea3-a22f-12183426e58c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d50c15d1-78b4-4ea3-a22f-12183426e58c?resizing_type=fit)
9. Customize the **Start at Time** value to **10.0**. This value is the second/frame when the animation should start playing. If set to **0.0**, this means it'll play the animation starting at the animation **0.0** seconds/frame.

   [![](https://dev.epicgames.com/community/api/documentation/image/a4ba490d-20e9-4116-966a-ba028b39f45b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a4ba490d-20e9-4116-966a-ba028b39f45b?resizing_type=fit)
10. Set **Playback Speed** to **0.5**. This causes the animation to play at half the set speed in Sequencer.

    [![](https://dev.epicgames.com/community/api/documentation/image/3edfbe95-4962-4e45-a4f1-42b8aafefec1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/3edfbe95-4962-4e45-a4f1-42b8aafefec1?resizing_type=fit)
11. Click **Compile** to save your User Widget.

    [![](https://dev.epicgames.com/community/api/documentation/image/aac04c61-0776-4a92-8ff9-3ecb146669e9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/aac04c61-0776-4a92-8ff9-3ecb146669e9?resizing_type=fit)

## Step 5: Add the Timer Device

The last step is to add a Timer device to the viewport and customize its settings.

1. From the **Content Browser**, select the **Fortnite** > **Devices** folder to open all the device folders.

   [![](https://dev.epicgames.com/community/api/documentation/image/39b7748f-636d-4e18-9f17-12aa5eb8cdad?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/39b7748f-636d-4e18-9f17-12aa5eb8cdad?resizing_type=fit)
2. Type **Timer** in the Asset View search bar to surface the Timer device.

   [![](https://dev.epicgames.com/community/api/documentation/image/a9728533-9365-425c-b5f8-a554ebfbccac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a9728533-9365-425c-b5f8-a554ebfbccac?resizing_type=fit)
3. Drag the **Timer** device into the viewport.
4. From the **Details** panel, set the **Duration** to **30.0** seconds.

   [![](https://dev.epicgames.com/community/api/documentation/image/23827b6a-9827-4015-a71a-94395a8572e8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23827b6a-9827-4015-a71a-94395a8572e8?resizing_type=fit)
5. Expand the **Advanced** option to reveal Custom Widget Class.
6. Select your **User Widge**t from the Custom Widget Class dropdown menu.

   [![](https://dev.epicgames.com/community/api/documentation/image/23b0fbde-8d4f-4383-93e3-fdee927a1da7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/23b0fbde-8d4f-4383-93e3-fdee927a1da7?resizing_type=fit)
7. Under the second **Advanced** option set, use the following settings:

   1. Can Interact = **No**
   2. Completion Behavior = **Reset**
   3. Visible During Game = **Hidden**
   4. Enable Urgency Mode = **Check**
   5. Urgency Mode Time = **10.0 seconds**

   [![](https://dev.epicgames.com/community/api/documentation/image/1fe05ddf-2246-4070-8ad1-80fc6f228698?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/1fe05ddf-2246-4070-8ad1-80fc6f228698?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/0499d8ef-2608-4b90-81ce-ea2b7fe3a630?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0499d8ef-2608-4b90-81ce-ea2b7fe3a630?resizing_type=fit)

   [![](https://dev.epicgames.com/community/api/documentation/image/bccbcb25-dc8d-487a-af1a-45b80cb41244?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/bccbcb25-dc8d-487a-af1a-45b80cb41244?resizing_type=fit)

   Now players can’t interact with the device, and when the Timer runs through its set Duration time, it will reset. With Urgency Mode enabled, your custom animation will now queue and play for the time set under Urgency Mode Time.
8. Save your changes, then playtest your project to see the User Widget working in the HUD.

Your playtest should result in the custom time replacing the default Timer device and playing the animation during the specified time.

## On Your Own

There are a few ways you can make the timer unique to your own project.

- Add a material around the TimerText that slowly disappears as the timer runs down.
- Add a texture to surround the TimerText that looks like a clock.
- Move the timer to the corner rather than in the center of the screen.
