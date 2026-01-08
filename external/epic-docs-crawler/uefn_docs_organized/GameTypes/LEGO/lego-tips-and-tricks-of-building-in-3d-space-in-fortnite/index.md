# Tips and Tricks of Building in 3D Space

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/lego-tips-and-tricks-of-building-in-3d-space-in-fortnite>
> **爬取时间**: 2025-12-27T00:35:54.130585

---

The brick building possibilities are endless with the LEGO® Brick Editor. The LEGO Brick Editor speeds up building and creates endless possibilities for your LEGO islands.

There are numerous brick types and colors in the brick index. For more information, see [Working with the LEGO® Brick Editor](https://dev.epicgames.com/documentation/en-us/fortnite/working-with-the-lego-brick-editor-in-fortnite).

The LEGO® Assembly device does not work with objects made with the LEGO Brick Editor.

## How Brick-by-Brick Building Works

The LEGO Brick Editor provides a way to snap bricks together much like you do when building with LEGO bricks in the comfort of your own home. The editor’s controls were built with you in mind, so they provide visual support to help you correctly place your bricks while maintaining the brick-by-brick feeling.

The brick index contains numerous original LEGO bricks and a wide variety of brick colors. You can search for bricks by colour, name, shape, size, or function.

To start building, drag an initial brick into the viewport. You can combine multiple bricks into a group with the **Kragle** tool. The group of bricks then turns into a static mesh to become a solid, movable object. Bricks and kragled objects automatically connect to the nearest brick, and can be swung at a 90° angle around the selected stud when rotated.

For more information about brick rotation, see the [LEGO Brick Editor Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-brick-editor-template-in-fortnite) document.

When using the LEGO Brick Editor, you can drag individual bricks and large kragled objects around by clicking and dragging. Some building techniques require you to rotate bricks before you pick them up, making it a two step building process. For rotation and translating, the editor uses special gizmos to show you the rotation angle of the bricks and kragled objects.

With the LEGO Brick Editor you can save your custom creations; and you can continue building on them later!

To continue building after having kragled a build:

- Select the  kragled object, then select the **Separate** tool to break the bricks up again.

You can also duplicate your kragled objects and bricks. For example, if you design a new tree, you can make a forest of them with the shortcut **ALT+Drag**. To get the best performance, iterate on the item you are building with the bricks, then Kragle it into a Static Mesh, and use Alt-Drag to instance.

Using the shortcut **CTRL+D** also creates duplicates, but aligns your duplicate with the original instance. This is a quick way to cover a big area with bricks.

## 3D Building Techniques

Learn some 3D building techniques, and pass them on to other brick-inspired creatives. For building with the LEGO Brick Editor, here are some tips and tricks that you’ll find useful as you begin creating items in 3D space.

- In the LEGO Brick Editor, you can place individual bricks or groups of bricks side by side,but there needs to be a connecting brick placed on top or underneath to snap to. Bricks sitting side by side will not kragle together, they must be attached to another brick.
- Some objects might need to have side-building to achieve the right look and feel. This means you can go beyond regular vertical construction. If you do side-by-side building, make sure to rotate the bricks  to make placement easier.
- You can use double-click to select all pieces that are connected by studs and tubes. Bricks that are aligned, but not connected, will not be selected.
- Additional techniques and possibilities beyond top-down building can add considerable complexity and difficulty to a building experience. Balance possibility with practicality and playability.
- Some connections that are possible in a physical build do not make sense or add too much complexity in a digital experience.
- Let your creativity soar! Who said all bricks must touch the ground? Let some bricks float in the air. Test new solutions for overcoming key obstacles thoroughly, or use solutions that have already been proven to have worked and test them in this new situation.
- You can place multiple bricks together and remove individual bricks from your creation to create modular items, which is not possible in physical brick building. This type of modular building is faster and more fun to build an entire wall and then cut out the door and windows as desired afterwards.
- Playful destruction is also a form of creation. It’s more fun to remove a building or object you no longer need rather than delete it completely.

## Rotation Hotkeys

The building process moves more quickly in the LEGO Brick Editor with the use of hotkeys.

These are only active when dragging with the left mouse button in the viewport.

| Hotkey | Action | GIF |
| --- | --- | --- |
| **CTRL + Shift + Q** | Adjusts the roll of the object to the left (rotation about the forward axis) from the camera’s view. |  |
| **CTRL+ Shift + E** | Adjusts the roll of the object to the right (rotation about the forward axis) from the camera’s view. |  |
| **CTRL+ Shift + W** | Adjusts the pitch of the object (rotation about left axis) away from the camera. |  |
| **CTRL+ Shift + S** | Adjusts the pitch of the object (rotation about left axis) towards the camera. |  |
| **CTRL+ Shift + A** | Adjusts the yaw of the object (rotation about the up axis) clockwise. |  |
| **CTRL + Shift + D** | Adjusts the yaw of the object (rotation about the up axis) counter-clockwise. |  |

## Build to Match Existing LEGO Assets

First time using the LEGO Brick Editor? No problem! Pull assets out of the **Content Browser** from the **LEGO Content folder**, and see if there’s anything that inspires you, or a style you want to complement with a custom built object.

Prop and prefab content from the Content Browser cannot be un-kragled, nor kragled together with objects built using the LEGO Brick Editor. Props and prefabs cannot be selected when in LEGO Brick Editor mode, because the editor considers them non-LEGO UEFN props and assets.

Drop-in a prefabricated structure, then switch to the LEGO Brick Editor to build your own brick-built object to customize your LEGO world.

[![An example of creating objects that complement LEGO Elements.](https://dev.epicgames.com/community/api/documentation/image/36c70d73-1411-4f3e-a57f-587a42877fbc?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/36c70d73-1411-4f3e-a57f-587a42877fbc?resizing_type=fit)

Pull out all the fun weapons, and try them for yourself to better understand how players might use them. Playing with the tools and your brick-built objects can help make your islands more engaging and inspire new gameplay! If you feel stuck, see these LEGO tutorials to help you get started.

- [Home Builder](https://dev.epicgames.com/documentation/en-us/fortnite/build-lego-home-builder-in-fortnite)
- [Music Concert](https://dev.epicgames.com/documentation/en-us/fortnite/build-your-own-lego-music-concert-in-fortnite-creative)
- [Obstacle Course](https://dev.epicgames.com/documentation/en-us/fortnite/build-your-own-lego-obstacle-course-in-fortnite-creative)
- [Scary Space](https://dev.epicgames.com/documentation/en-us/fortnite/lego-scary-space-in-unreal-editor-for-fortnite)
- [Santa’s Toy Factory](https://dev.epicgames.com/documentation/en-us/fortnite/lego-santas-toy-factory-in-unreal-editor-for-fortnite)
- [Action Adventure Template](https://dev.epicgames.com/documentation/en-us/fortnite/lego-action-adventure-in-unreal-editor-for-fortnite)
- [Bloom Tycoon](https://dev.epicgames.com/documentation/en-us/fortnite/lego-bloom-tycoon-in-fortnite)

## Build with Gameplay in Mind

The following are tips and tricks for designing gameplay that works with your brick-built objects.

- Use [lighting](https://dev.epicgames.com/documentation/en-us/fortnite/lighting-in-unreal-editor-for-fortnite), color tones, and some clever building techniques in the scenery to give your island some visual appeal.
- Adding minifig characters to your project can add life to the gameplay when you add [character definitions](https://dev.epicgames.com/documentation/en-us/fortnite/using-character-devices-in-fortnite-creative) and [conversation UI](https://dev.epicgames.com/documentation/en-us/fortnite/conversations-in-unreal-editor-for-fortnite).

Minifigs can also give you a sense of scale when you’re building custom items for your world.
