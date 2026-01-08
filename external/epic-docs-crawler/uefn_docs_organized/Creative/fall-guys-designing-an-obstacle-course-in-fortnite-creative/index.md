# Fall Guys — Designing an Obstacle Course

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/fall-guys-designing-an-obstacle-course-in-fortnite-creative>
> **爬取时间**: 2025-12-27T00:15:36.877997

---

The Fall Guys templates have custom assets to style an obstacle course for those cute little Beans. This tutorial has tricks and hacks to help you construct fun and challenging parkour courses that will entertain and delight!

The secret to Fall Guys assets is they are meant to be paired with Fortnite Creative devices to create moving props and obstacles. You’ll learn which props pair best with which devices, and how to set up and style the course for challenges and thrills!

## Learning Objectives

- How to pair Fortnite Creative devices with Fall Guys props
- How to design an obstacle course from scratch

## Pairing Devices and Fall Guys Props

The Fall Guys templates include classic Fall Guys props like fans, flippers, and bouncers. Because these are just [props](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#prop), the Fall Guys assets don’t do anything unless you combine them with Fortnite Creative devices.

Below are instructions for creating a few types of gameplay by pairing Fall Guys props with Fortnite Creative devices.

If you want to learn how to use Verse to manipulate Fall Guys props to build platform behavior, see [Animating Prop Movement](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-in-verse).

### Fall Guys Fan

Create an air current that pushes players through the air in any direction. You can use these to help players back onto the path or blow them off.

[![Create an air current that pushes players through the air in any direction with the Air Vent device and the Fall Guys fan and propeller.](https://dev.epicgames.com/community/api/documentation/image/5cb7e65d-2f6f-40c5-b367-c8529d4d86bd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/5cb7e65d-2f6f-40c5-b367-c8529d4d86bd?resizing_type=fit)

#### Ingredients

You will need:

- **[Air Vent Gallery](https://dev.epicgames.com/documentation/en-us/fortnite/air-vent-gallery)**
- **Fall Guys Fan**
- **Fall Guys Blue Propeller**

#### Method

1. Assemble the Fall Guys fan by placing the propeller in the center of the fan, then place the **Air Vent** device in the center of the fan.
2. Customize the Air Vent by changing the following device options:

| Option | Setting | Description |
| --- | --- | --- |
| **Visible During Game** | Off | You don’t want this device to be visible during the game. |
| **Knock Up Force** | Low | This determines how much force the air vent applies to the players. It is set to **Low**, because it needs to help players get to the top of the tallest structure without overshooting the course. |
| **Gust Range** | 6.25 meters | The gust is strong enough to carry players to the top of the tallest structure. |

### Knockout Glove

Create a moving Knockout Glove that pushes players off course.

[![](https://dev.epicgames.com/community/api/documentation/image/7a98b69d-b0e9-414d-ab8c-fb3a04ead024?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7a98b69d-b0e9-414d-ab8c-fb3a04ead024?resizing_type=fit)

#### Ingredients

You will need:

- **Fall Guys Knockout Glove**
- [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) device

#### Method

1. Place the Fall Guys Knockout Glove, then place the Prop Mover device on the side of the glove. It needs to intersect with the glove object in order to work.

   Make sure the arrow on the device points in the direction you want the prop to move.
2. Customize the Prop Mover by changing the following device options:

| Option | Setting | Description |
| --- | --- | --- |
| **Distance Measurement** | Tile | You can see how many tiles the prop needs to move toward its destination. |
| **On Player Collision Behavior** | Continue | The prop should continue toward its destination even if it collides with a player. |
| **Player Damage on Collision** | 0.0 | Players should not take damage, but should be able to continue moving even while being pushed. |
| **On Prop Collision Behavior** | Reverse | When the prop hits another prop in its path, the moving prop should reverse its course. |
| **Prop Damage on Collision** | 0.0 | The prop is placed solely to tell the moving prop to reverse its motion. |
| **Path Complete Action** | Ping Pong | The prop should continue moving back and forth between two points. |

### Watermelon Scythe Obstacle

Use multiple Watermelon Scythes to create an obstacle that players can’t easily pass.

#### Ingredients

You will need:

- **3** x [Prop Mover](https://dev.epicgames.com/documentation/en-us/fortnite/using-prop-mover-devices-in-fortnite-creative) devices
- **3** x **Watermelon Scythes**
- **3** x **White Buttons**

#### Method

1. Set up the Watermelon Scythes so they stagger from right-to-left across 3 tiles. Decide which props will move right, and which props will move left.
2. Place a white button at the end of the third tile on the left for props moving to the right. Place a white button at the end of the third tile on the right for props moving to the left.
3. Once you've added the props, place a Prop Mover device in the first Watermelon Scythe, making sure to point the device arrow in the direction you want the prop to travel.
4. Customize the Prop Mover by changing the following device options:

| Option | Setting | Description |
| --- | --- | --- |
| **Distance Measurement** | Tile | You can see how many tiles the prop needs to move toward its destination. |
| **Distance** | 3.0 Tiles | Creates a narrow space for players to travel while bumping into the props. |
| **Speed** | Props moving left:   - 0.75 tiles / per second   Props moving right:   - 1.0 tile / per second | This staggers the speed the different props move and creates opportunities for some players and delays for others. |
| **On Player Collision Behavior** | Continue | The prop should continue toward its destination even if it collides with a player. |
| **Player Damage on Collision** | 0.0 | Players should not take damage, but should be able to continue moving even while being pushed. |
| **On Prop Collision Behavior** | Reverse | When the prop hits another prop in its path, the moving prop should reverse its course. |
| **Prop Damage on Collision** | 0.0 | The prop is placed solely to tell the moving prop to reverse its motion. |
| **Path Complete Action** | Ping Pong | The prop should continue moving back and forth between two points. |

Copy and place the device into the remaining props, again with the arrow pointing in the direction the prop should travel.

## Designing an Obstacle Course from Scratch

Let your creative process loose on a blank template to design and style your own Fall Guys obstacle course.

Follow the steps below to graybox a course and theme the environment for your own Fall Guys island.

### Gray Boxing

When creating your obstacle course, there are a few design and [block out](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#grayboxing) considerations to consider:

- How far can a Fall Guys Bean jump and dive?
- How high can a Bean jump and mantle?

How long is a Bean affected by ragdoll physics after a fall?

Once you’ve tested the physical limitations of a Fall Guys Bean, you can begin designing a fun course.

#### Sketch Out Your Course

Draw the course path on a piece of paper. Scale your obstacles along the path and build on the difficulty of the obstacles players will face. This also gives you a chance to theme sections of the course along with the difficulty so players know when they’ve reached a new difficulty zone.

[![Draw the course path on a piece of paper to scale your obstacles along the path and build upon the difficulty of the obstacles players will face.](https://dev.epicgames.com/community/api/documentation/image/e6e3e46d-eae4-4c01-bc7d-e2c7c7c7cfd6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/e6e3e46d-eae4-4c01-bc7d-e2c7c7c7cfd6?resizing_type=fit)

#### Test Your Design

Test the obstacle course as you build to make sure obstacles are challenging and fun, not annoying and difficult. Fix areas where it’s difficult to reach using the default movements of the Bean.

After finishing the obstacle course, playtest the island to make sure the course and all the obstacles work and are at a good level of difficulty.

### Theming

Part of creating an island is deciding on a theme, then finding props and environmental elements to complement the style you’re going for.

To create a Floor Is Lava Fall Guys Obstacle Course, the following props and devices could be used to create the look.

#### Ingredients

To recreate the Floor-Is-Lava look, use the following props and devices:

| Prop / Device | Description |
| --- | --- |
| **Modular Mountain Gallery** | Provides tall walls around the obstacle course to cover up the blank parts of the island. |
| **Lava Tiles Floor** | Creates an interesting environment that seems to be alive. |
| **Elemental Cube** | A lava floor tile that can be stretched to cover large areas of the island floor. |
| **VFX Spawner device** | Visual Effect: **Embers**  Adds an element of heat to the environment. |

[![Use different galleries and devices to create a custom theme for your Fall Guys island.](https://dev.epicgames.com/community/api/documentation/image/580defa3-2778-46be-90b8-e9172ea5c7db?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/580defa3-2778-46be-90b8-e9172ea5c7db?resizing_type=fit)

Experiment with different devices and Fall Guys props to create a truly unique island. Theming and level design can elevate your gameplay and make a truly memorable experience for players.
