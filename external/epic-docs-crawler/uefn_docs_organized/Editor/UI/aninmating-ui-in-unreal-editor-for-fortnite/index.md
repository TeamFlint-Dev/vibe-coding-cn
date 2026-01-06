# Animating UI

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/aninmating-ui-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:06:49.143417

---

Currently, there is a bug where you will not see a UI Animation Condition field in View Bindings when there are no regular view bindings created. You must first create a regular view binding to be able to see the Condition binding fields. This bug is fixed in 33.00.

Use [Sequencer](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#sequencer) in UMG to animate widgets. Widgets animate based on values entered into a [material parameter](https://dev.epicgames.com/documentation/en-us/fortnite/conversion-function-setting-material-parameters-in-umg-in-unreal-editor-for-fortnite).

Currently, animating UI only works with [float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) and [int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) type [variables](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary). More functionality will be added to animating UI in the future.

## Setting Up the Widget

The widget is using the **Tracker widget** from the example in [Setting Material Parameters in UMG](https://dev.epicgames.com/documentation/en-us/fortnite/conversion-function-setting-material-parameters-in-umg-in-unreal-editor-for-fortnite).

Create a Tracker widget if you don’t have one ready to use. Then do the following:

1. Add a **Text Block** that shows a **+1** on top of the existing **Tracker widget**. This indicates that the elimination tracker is incrementing based on the number of eliminated zombies.

   [![](https://dev.epicgames.com/community/api/documentation/image/5a60d2ea-e525-4150-9741-633b64c89b3e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5a60d2ea-e525-4150-9741-633b64c89b3e?resizing_type=fit)
2. Under **Rendering** > **Render Opacity**, set the **Render Opacity** to **0.0** for this Text Block.

   [![](https://dev.epicgames.com/community/api/documentation/image/2a991801-9a0c-4a64-be4d-ea0a45328d0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2a991801-9a0c-4a64-be4d-ea0a45328d0a?resizing_type=fit)
3. The widget is ready to be animated.

## Setting Up the Animation

To add animation to your UI, you’ll open **Sequencer** under the **Event Graph** to animate the icon and "+1". Then you’ll set up the animation in Sequencer.

For this example, the icon pops and the "+1" text appears when the player’s Tracker progresses like in the gif below.

[![For this example, the icon pops and the "+1" text appears when the player’s Tracker progresses.](https://dev.epicgames.com/community/api/documentation/image/30d604ba-fb96-41e3-be95-2858985fa948?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/30d604ba-fb96-41e3-be95-2858985fa948?resizing_type=fit)

For information on how to use the Sequencer refer to the [**Sequencer and Control Rig**](sequencer-and-control-rig-in-unreal-editor-for-fortnite) document.

1. Open the Animation window in **Window** > **Animations**.

   [![Open the Animation window in Window > Animations.](https://dev.epicgames.com/community/api/documentation/image/e8c25e66-d8ff-4b2a-a4ed-4768bb7f4ce1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e8c25e66-d8ff-4b2a-a4ed-4768bb7f4ce1?resizing_type=fit)
2. Click **+Animation**, and name the animation **OnIncrement**.

   [![Click +Animation, and name the animation OnIncrement.](https://dev.epicgames.com/community/api/documentation/image/cfc10e6f-53f0-4474-b604-182ac73a5253?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/cfc10e6f-53f0-4474-b604-182ac73a5253?resizing_type=fit)

## Animating a Widget’s Visibility

To animate the UI, you’ll identify the widget to animate, then animate the material or texture associated with that widget in Sequencer in the Animation Window. Start the animation by selecting the **IncrementText (+1)**.

1. Select **OnIncrement**, then select the **+1 Text**, then select **+Add** > **Increment Text**.

   [![Select OnIncrement, then select the +1 Text, then select +Add > Increment Text.](https://dev.epicgames.com/community/api/documentation/image/9cf26def-9b33-4631-aa90-81cf748b1c0a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9cf26def-9b33-4631-aa90-81cf748b1c0a?resizing_type=fit)
2. Select the **+plus icon** in the **IncrementText track** and select **Render Opacity**. This allows you to track the Opacity on the animation timeline.

   [![Select the +plus icon in the IncrementText track and select Render Opacity.](https://dev.epicgames.com/community/api/documentation/image/28bd60db-dbeb-4a99-b216-63c7dff4a478?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/28bd60db-dbeb-4a99-b216-63c7dff4a478?resizing_type=fit)
3. Set a **key** for the beginning of the animation. This determines where the Text begins to fade in and out.

   [![Set a key for the beginning of the animation.](https://dev.epicgames.com/community/api/documentation/image/2be139a6-fc0e-4d61-adf9-3874fe419157?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2be139a6-fc0e-4d61-adf9-3874fe419157?resizing_type=fit)
4. Set the **Render Opacity** to:

   1. **1.0** at **0.25** seconds
   2. **0.0** at **0.50** seconds

   [![Set the Render Opacity levels into seconds the animation should last.](https://dev.epicgames.com/community/api/documentation/image/93c115e4-9565-4168-82c2-a1eba0d78714?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/93c115e4-9565-4168-82c2-a1eba0d78714?resizing_type=fit)
5. Now you have an animation that fades the text in and out everytime the player gets an elimination.

   [![Now you have an animation that fades the text in and out everytime the player gets an elimination.](https://dev.epicgames.com/community/api/documentation/image/01ac8ea9-388c-4201-8936-a5b44e675ab5?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/01ac8ea9-388c-4201-8936-a5b44e675ab5?resizing_type=fit)

## Animating a Widget’s Position

Add an animation to the text widget’s position so that the text moves up when it’s visible before it fades away.

1. Click the **+plus icon** on **IncrementText** and select **Transform**.

   [![Click the +plus icon on IncrementText and select Transform.](https://dev.epicgames.com/community/api/documentation/image/5ff5222d-3989-4401-ba63-b26a66bf172b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5ff5222d-3989-4401-ba63-b26a66bf172b?resizing_type=fit)
2. Expand **Transform** > **Translation** and set the **Y** to the amount you want the **+1 text** to move up while it's visible. In this example, the Y Translation keyframes on the text is set to:

   1. **0.0** at **0.0s**
   2. **-20.0** at **0.25s**
   3. **-20.0** at **0.50s**

   [![Expand Transform > Translation and set the Y to the amount you want the +1 text to move up while it's visible.](https://dev.epicgames.com/community/api/documentation/image/b0134c68-8c4f-428f-8447-89aa6111bd56?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b0134c68-8c4f-428f-8447-89aa6111bd56?resizing_type=fit)

   Remember to set [keyframes](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#keyframe) for each movement of the text.

Now the text moves upwards when it appears.

[![Now the text moves upwards when it appears.](https://dev.epicgames.com/community/api/documentation/image/d7510547-474a-42b8-8fa9-6fd279b0437c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d7510547-474a-42b8-8fa9-6fd279b0437c?resizing_type=fit)

## Animating a Widget’s Scale

Increase the size of the animated +1 text as it moves to draw attention to the eliminations by animating the widget’s scale settings. This animation gives the illusion of the text "popping" on the screen.

1. Expand **IncrementText** > **Transform** > **Scale**. The **X** and **Y** values appear under **Scale**.

   [![Expand IncrementText > Transform > Scale.](https://dev.epicgames.com/community/api/documentation/image/2d72d87b-949f-4322-a14b-ca78eb511d88?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2d72d87b-949f-4322-a14b-ca78eb511d88?resizing_type=fit)
2. Set the **Scale X** and **Y** as **keyframes** on your **OnIncrement timeline**. In this example the Scale keyframes were set to:

   1. **0.0** at **0.0s**
   2. **2.0** at **0.10s**
   3. **0.0** at **0.50s**

Now the +1 text pops in a dramatic effect when the animation plays.

[![Set the Scale X and Y as keyframes on your OnIncrement timeline.](https://dev.epicgames.com/community/api/documentation/image/34ee14e7-78ad-4c51-9e18-9e73144fd8f3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/34ee14e7-78ad-4c51-9e18-9e73144fd8f3?resizing_type=fit)

## Animating an Image Brush’s Material Parameter

To make the Icon in the material expand with the Tracker progress, access the Material through Sequencer.

1. Select the **TrackerMaterial Image**, then click **+Add** > **TrackerMaterial** in the **OnIncrement** animation.

   [![Select the TrackerMaterial Image, then click +Add > TrackerMaterial in the OnIncrement animation.](https://dev.epicgames.com/community/api/documentation/image/c7dc5625-607e-45cf-b430-5e64863965d4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c7dc5625-607e-45cf-b430-5e64863965d4?resizing_type=fit)
2. Click the **+plus icon** in your **TrackerMaterial** track and select **Brush.Brush Material**.This adds a material track to the Brush.Brush Material property.

   [![Click the +plus icon in your TrackerMaterial track and select Brush.Brush.Material.](https://dev.epicgames.com/community/api/documentation/image/a3d2350d-4bf8-44a9-a524-e29096d2126c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a3d2350d-4bf8-44a9-a524-e29096d2126c?resizing_type=fit)
3. Click the **+plus icon** in the new **Brush.Brush.Material Track** and select **IconScaleX** and **IconScaleY**.

   [![Click the +plus icon in the new Brush.Brush.Material Track and select IconScaleX and IconScaleY.](https://dev.epicgames.com/community/api/documentation/image/e0d206db-3b4b-45cc-9479-1519bd9c1fc2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e0d206db-3b4b-45cc-9479-1519bd9c1fc2?resizing_type=fit)

   Expand **IconScaleX** and **IconScaleY**. You can easily manipulate these parameters in Sequencer when the OnIncrement animation plays. By using these settings you can animate the icon scaling up and back down.
4. Set both **IconScaleX** and **IconScaleY** to:

   1. **0.7** at **0.00**
   2. **1.0** at **0.25**
   3. **0.7** at **0.00**

   [![Set scale parameters for both IconScaleX and IconScaleY.](https://dev.epicgames.com/community/api/documentation/image/7b808b75-cf8c-4874-afa1-e2d49a7aac1c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7b808b75-cf8c-4874-afa1-e2d49a7aac1c?resizing_type=fit)

Now the animation uses the material parameters from TrackerMaterial to animate the icon like in the gif below.

[![Now the animation uses the material parameters from TrackerMaterial.](https://dev.epicgames.com/community/api/documentation/image/ed5378d0-5df3-4e84-aa48-926dab4f4edc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ed5378d0-5df3-4e84-aa48-926dab4f4edc?resizing_type=fit)

## Adding an Animation Condition

Now that your animation is ready to go, tie it to a gameplay value so that it plays an animation when a gameplay value changes.

1. Open the **View Bindings** window by selecting **Window** > **View Bindings**.

   [![Open the View Bindings window by selecting Window > View Bindings.](https://dev.epicgames.com/community/api/documentation/image/a30773d4-1ddf-44de-8328-ed0a69d0326e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a30773d4-1ddf-44de-8328-ed0a69d0326e?resizing_type=fit)
2. In the **View Bindings** window, select **+Add Condition**.

   [![In the View Bindings window, select +Add Condition.](https://dev.epicgames.com/community/api/documentation/image/9e006351-f582-4be9-b21f-b3a7c70b3c15?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9e006351-f582-4be9-b21f-b3a7c70b3c15?resizing_type=fit)

   The left box is for the gameplay value that you want tracked for changes so that it will play the animation on the right. Right now, +Add Condition only accepts [Float](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) or [Int](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary) values.

   [![Right now, +Add Condition only accepts Float or Int values.](https://dev.epicgames.com/community/api/documentation/image/2e758517-e421-4007-9946-bc88d704f79b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2e758517-e421-4007-9946-bc88d704f79b?resizing_type=fit)
3. Select the left box, then select **MVVM\_UEFN\_Tracker** > **Value**. This tracks the **Tracker progress** by playing an animation whenever the Tracker value increments.

   [![Select the left box, then select MVVM_UEFN_Tracker > Value.](https://dev.epicgames.com/community/api/documentation/image/7f93dcf2-090b-4b7e-ba45-77fb40f5f8ca?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7f93dcf2-090b-4b7e-ba45-77fb40f5f8ca?resizing_type=fit)
4. Click the **middle dropdown** and select **More Than (>)**.

   The 2 boxes in the middle are the conditions that you want fulfilled to play the animation. Whenever the value changes, it checks if it’s within that condition and if it is, it will play the animation.

   By setting it to More Than **(>) 0.0**, the UI will play the animation whenever this value changes.

   [![Click the middle dropdown and select More Than (>).](https://dev.epicgames.com/community/api/documentation/image/0a3a5e46-1018-4233-aa27-076ec3c1256b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/0a3a5e46-1018-4233-aa27-076ec3c1256b?resizing_type=fit)
5. Select the right box, then select **WBP\_{YourWidgetName}** > **Queue Play Animation**. The right box is the action to take when this value fulfills the condition. In this case, to play the **OnIncrement animation** created above.

   [![Select the right box, then select WBP_{YourWidgetName} > Queue Play Animation.](https://dev.epicgames.com/community/api/documentation/image/167b49c9-5deb-4dfe-8b8b-0ed6a1ac20e7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/167b49c9-5deb-4dfe-8b8b-0ed6a1ac20e7?resizing_type=fit)

   A list of options pertaining to the animation you want to play appear in View Bindings.

   - **In Animation** = Play
   - **Start at Time** = Select a time
   - **Num Loops to Play** = Number of times the animation loops
   - **Play Mode** = **Forward**, Reverse, or Ping Pong
   - **Playback Speed** = Speed up or slow the animation down
   - **Restore State** = Restores the animation to its default state

   [![A list of options pertaining to the animation you want to play appear in View Bindings.](https://dev.epicgames.com/community/api/documentation/image/2ed1bb4d-c0ac-4232-929f-a475b8e0e758?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2ed1bb4d-c0ac-4232-929f-a475b8e0e758?resizing_type=fit)
6. Click the **link icon** next to **InAnimation**, then select **WBP\_{YourWidgetName}** > **OnIncrement** > **Select**.

   [![Click the link icon next to InAnimation, then select WBP_{YourWidgetName} > OnIncrement > Select.](https://dev.epicgames.com/community/api/documentation/image/fb8b8a6a-1cfc-48e9-a0b8-9f1c4b0c5960?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/fb8b8a6a-1cfc-48e9-a0b8-9f1c4b0c5960?resizing_type=fit)

Now your animation is set up to play whenever the Tracker progresses.

[![Now your animation is set up to play whenever the Tracker progresses.](https://dev.epicgames.com/community/api/documentation/image/6e154cff-2665-4053-b473-d10c5368c238?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6e154cff-2665-4053-b473-d10c5368c238?resizing_type=fit)

## Final Result

As the players eliminate enemies or NPCs, the UI shows the elimination progress with the icon popping and the +1 appearing, popping, and disappearing.

[![As the players eliminate enemies or NPCs, the UI shows the elimination progress with the icon popping and the +1 appearing, popping, and disappearing.](https://dev.epicgames.com/community/api/documentation/image/99406ab1-d321-40dd-8cf2-b2ff77016a22?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/99406ab1-d321-40dd-8cf2-b2ff77016a22?resizing_type=fit)
