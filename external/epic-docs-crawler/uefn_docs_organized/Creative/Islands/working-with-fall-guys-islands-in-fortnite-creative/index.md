# Working with Fall Guys Islands

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/working-with-fall-guys-islands-in-fortnite-creative
> **爬取时间**: 2025-12-27T00:15:42.709229

---

Design your own Fall Guys island with custom templates and assets, available in Fortnite Creative and Unreal Editor for Fortnite (UEFN). All islands or UEFN projects created with these templates are considered to be Fall Guys islands. Players spawn into Fall Guys islands as a [Bean](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-glossary#bean) character.

Unique Fall Guys prefabs and galleries are available to use with the Fall Guys templates to ensure that your island has that distinct Fall Guys look and feel.

Fall Guys islands do not support [in-island transactions](https://dev.epicgames.com/documentation/en-us/fortnite/in-island-transactions-in-fortnite).

## Fall Guys Island Game Mechanics

### Scale for Fall Guys Beans

Like the LEGO® Minifigure used in LEGO Islands, the Fall Guys Bean is much smaller than Fortnite characters. Unlike the LEGO Minifigure however, Fall Guys assets are not automatically scaled to the size of the Bean. You can use other Fortnite assets in your island or project without needing to resize them.

### Fall Guys Beans and Emotes

Beans haven't learned how to do the Fortnite dances yet, so they can't use regular Fortnite emotes, but when players press the Emote control, one of four uniquely Fall Guys emotes will randomly play.

### How Fall Guys Beans Use Fortnite Movement Types

Fall Guys characters use many of the same movements that Fortnite characters use. However, the physics rules used for the Fall Guys Bean are slightly different, and this will result in a slightly different feel for players moving through your islands.

| Movement/Action | Description |
| --- | --- |
| **Run**  [Running Bean](https://dev.epicgames.com/community/api/documentation/image/6da833eb-a6df-474c-a71c-7579aa7c5668?resizing_type=fit) | The Fall Guy will feel a little heavier in terms of acceleration, momentum, and jiggle. However, the Bean is built for precise and responsive platforming in ways a Fortnite character can't match. The Fall Guy used for Creative islands is also faster and more responsive than the ones in the original Fall Guys game. |
| **Turn**  [Turning Bean](https://dev.epicgames.com/community/api/documentation/image/8f5d9024-c47d-4baa-be78-e97e4948e31d?resizing_type=fit) | - A Bean's turning depends on the direction they're moving in rather than where the character is facing. - A Bean leans into the turn and wobbles with the momentum. - A Bean turns very quickly while in the air, which gives players a chance to easily adjust their position for platforming. - As a Bean runs to the left or right, the camera will gently pan to move behind it. However, the player can always manually move the camera at any time. |
| **Jump**  [Jumping Bean](https://dev.epicgames.com/community/api/documentation/image/2a463544-e582-438a-a1c0-d2b4aba390f3?resizing_type=fit) | - The Bean's jump helps with platforming and easily traversing the world. - Beans can jump around the same height as other Fortnite characters. This feels fairly high relative to the Bean's height, and gives the Bean more time in the air before landing. - While jumping, a Bean has more air control than other Fortnite characters. This gives players more precision for platforming. - A Bean's jump uses no energy, and Beans will always jump the same distance relative to gravity. - The Bean jump height is the same whether the player taps or long-presses the Jump control. - Beans produce a signature dust effect when jumping, just like they do in Fall Guys Original. |
| **Mantle**  [Mantling Bean](https://dev.epicgames.com/community/api/documentation/image/246e95c0-69b1-4ae6-b9cb-461089b6ca29?resizing_type=fit) | - Beans can [mantle](https://dev.epicgames.com/documentation/en-us/fortnite/fortnite-creative-glossary#mantle) on various island surfaces, just like other Fortnite characters. - A Bean's mantle happens automatically when the Bean is in range of the object or surface. - Mantling for Beans is affected by the Bean's physicality, and requires the surface to be at the Bean's scale. - Beans mantle more slowly than other Fortnite characters. - Mantling is still very responsive, and players can easily use it to save them from falling. - Fall Guys Beans cannot mantle objects set with the **Movable** tag. You can use this tag if you don't want players to mantle on specific things. |
| **Swim**  [Swimming Bean](https://dev.epicgames.com/community/api/documentation/image/18109e0d-856c-4f3d-8b14-8f6c2f1de142?resizing_type=fit) | - If a Bean falls into deep water, they will swim just like other Fortnite characters. - Beans can jump out of the water. - Beans cannot do a dolphin dive. - A Bean's swim speed and ability to turn in the water is similar to how they move and turn outside of water. |
| **Zipline**  [Zipline Bean](https://dev.epicgames.com/community/api/documentation/image/2b731f9d-9c5b-4dbc-9045-12e5d3ba47af?resizing_type=fit) | Beans can use ziplines just like other Fortnite characters. |
| **Interact** | For Fortnite characters, the player interacts with things by pointing the camera at them. For the Bean, interacting with something is based on which direction the Bean is facing rather than the camera's position. |

### Unique Movement Types for Fall Guys Beans

| Unique Movement | Description |
| --- | --- |
| **Dive**  [Diving Bean](https://dev.epicgames.com/community/api/documentation/image/ba3a76ca-d353-41bb-a26d-6243652c1c7b?resizing_type=fit) | - Use the **Shift** key or right mouse button (on PC), or the **left arrow button** (on a controller), to make the Bean dive forward quickly and fling itself forward. This can help players traverse terrain, and also can be used to dodge. - A Bean can also dive while in the air! Players can use this as a tactic to reach specific platforms or change their momentum, or as a last-minute save from impacts or missed platforms. When diving in the air, the player needs to land before they can dive again. - Only Beans can use this dive! It's not available to other Fortnite characters. |
| **Ragdoll**  [Ragdoll Bean](https://dev.epicgames.com/community/api/documentation/image/5c5084e4-3c1a-4509-8a97-c7feb335f592?resizing_type=fit) | - A large amount of force, from a fall or other impact, causes the Bean to ragdoll. This causes the Bean to roll, flop, and bounce around until the player regains control. - Some examples of when Beans can ragdoll:    - A large amount of force is applied to them by an object or other player.   - They hit the ground when moving at terminal velocity.   - They dive into a wall or other hard surface.   - They fall for more than 7 seconds without landing. - As a creator, you will be able to customize your launching devices to determine whether they cause ragdolling. - While a Bean is in the ragdoll state, the player will still have control over the Fall Guy's movement direction. They can use this to slow themselves down, move in a specific direction, or even turn their Bean into a projectile! - The Bean will come out of the ragdoll state if they slow down enough, at which point they will jump back to their feet and begin moving normally again. |
| **Jostle**  [Jostling Bean](https://dev.epicgames.com/community/api/documentation/image/1b6fdee9-179b-47cb-970e-c64fd678aa2b?resizing_type=fit) | - If Beans run into each other, this small amount of force is applied to each Bean and they visually react to the bump. - Players can use jostling to get through a packed crowd of Beans by bumping them out of the way rather than just stopping entirely. |

### Movement Types Unavailable for Fall Guys Beans

Some movements in Fortnite are things the Bean just can't do:

- **Crouch**
- **Dolphin Dive**
- **Drive**
- **Grind**
- **Hurdle**
- **Skydive**
- **Slide**
- **Sprint**

## Getting Started with Fall Guys Islands

To get started building Fall Guys obstacle courses, you can use the **Fall Guys Starter** island. It uses the following Fall Guys assets:

- Banners (from the Fall Guys Obstacles Gallery)
- Ramps (from the Fall Guys Components Gallery)
- Platforms (from the Fall Guys Components Gallery)
- Blocks (from the Fall Guys Components Gallery)
- Some small pillars (from the Fall Guys Obstacles Gallery)
- A small round platform (from the Fall Guys Obstacles Gallery)
- A Hop Flower device (Fortnite device)
- Slime cubes to make two Slime pits (use blocks from Fall Guys Elemental Gallery)
- 3 Damage Volumes to eliminate Beans and respawn them at the starting line:

  - Two Damage Volumes to go under the Slime pits
  - One Damage Volume to cover the water beneath the obstacle course
- A square platform with rounded corners (from the Fall Guys Obstacles Gallery)
- A Prop Mover device (Fortnite device)
- A custom Finish Line (using columns and arches from Fall Guys Components Gallery)
- Some flying banners (using pieces from the Fall Guys Obstacles Gallery)

This simple linear course illustrates the basic mechanics needed for a Fall Guys obstacle course level. You can add more intricate and complex obstacles, create larger platforming puzzles, add slides or funnels to your platforms, or use regular Fortnite props mixed with Fall Guys assets to make your island unique!

To learn more about using Fall Guys templates and assets, see [Accessing Brand](https://dev.epicgames.com/documentation/en-us/fortnite/accessing-brand-content-in-fortnite).

## Designing Your Own Obstacle Courses

Here are some design tips to consider when building your Fall Guys experience:

1. **Know your props!**

   - When first designing your course, use simple pieces like walls, floors and shapes to graybox the layout. These give you a rough idea of your concept, but are easier to move around if you want to change things.
   - When you have your basic layout, go to town on details and decorations. You can add ledges, pillars, scaffolds and cases. These are the basic components, and there are plenty of objects in the Fall Guys Obstacles Gallery you can use for decoration.
   - Don't be square! Experiment with curved pieces and height variations to create exciting layouts that players will want to dive into and explore.
   - You can use different colors, patterns, or icons on your components to guide players, warn them of obstacles and dangers, or otherwise communicate using the environment.
2. **Use the Bean's unique abilities and features!**

   - Use bouncers and launchers to send Beans flying, giving them opportunities to utilize dive and ragdolling.
   - While ragdolling, Beans can still move around in the air — so experiment and give players opportunities to use Bean movement in interesting ways.
   - Use varied spacing between platforms and obstacles to give Beans the chance to use jump, mantle, and dive.
3. **Take the Bean out of its comfort zone!**

   - Don't forget that you can mix in Fortnite props, building pieces and terrain! Give your imagination room to play and see where it takes you.
   - While the Fall Guys assets are bright and colorful, Fortnite assets have a wide variety of themes and atmospheres. Try out new environments and moods for your obstacle courses to take Beans to whole new worlds!

## IARC Audience Restrictions for Fall Guys Islands

The rating requirement for Fall Guys islands is Everyone-Equivalent, or the equivalent rating for your region. You need to make sure that your island doesn't exceed the maximum age rating. See the table below for more information.

| Rating Authority | Everyone-Equivalent |
| --- | --- |
| [ESRB](https://www.esrb.org/ratings-guide/) | E |
| [PEGI](https://pegi.info/what-do-the-labels-mean) | 3 |
| [ACB](https://www.classification.gov.au/classification-ratings/what-do-ratings-mean) | G |
| [Classlnd](https://www.gov.br/mj/pt-br/assuntos/seus-direitos/classificacao-1) | LIVRE |
| [USK](https://usk.de/die-usk-alterskennzeichen/) | 0 |
| [GRAC](https://www.grac.or.kr/english/) | ALL |
| Russia | 0 |
| IARC (Generic) | 3 |

## Island Settings

Some Island Settings are hidden for Fall Guys Islands. Here's a general list of the kinds of Island Settings you won't see on Fall Guys Islands.

- **Weapons, Damage, and Eliminations**: Beans don't use weapons or engage in combat.
- **Vehicles**: Beans don't use vehicles — it's hard to drive when you can't reach the pedals!
- **Energy**: Beans have unmeasurable amounts of energy.
- **Movement**: Beans have their own way of moving (see the sections above on how Beans move and which movement types they don't use).
- **Player-Built Structures**: Beans don't build.
- **Health and Shield**: Since Beans don't use weapons or engage in combat, they don't need health or shields.
- **Guards and Wildlife**: Beans don't need guards, and they are scared of dangerous animals.
- **Resources**: Since Beans don't build, they don't need resources.

## Available and Unavailable Devices

There is a huge number of Creative devices, and most are available to use with Fall Guys Islands. Go ahead and use them to make the best Bean experience possible! However, just as there are some Island Settings that aren't compatible with what Beans do and don't do, there are some devices that aren't available as well.

Here's a list of the kinds of Creative devices that won't be usable in Fall Guys Islands.

This is accurate as of initial release, but this list might change in subsequent releases.

- **Weapon Spawners, Damage Devices, Storms, and DBNO**: Beans don't use weapons or engage in combat, so devices that control anything related to those activities aren't usable. This also includes devices that spawn, grant, place or remove items.
- **Vehicles**: Beans don't use vehicles, so any vehicle spawner devices aren't usable. Fuel Pumps and Service Stations are also not usable. But who knows – maybe they will find a way some day!
- **Chair**: Beans don't fit in the Chair device.
- **Fishing**: Beans think fishing is boring.
- **Placeable Ledges**: Beans don't build, so this device isn't usable.
- **Health and Shield**: Since Beans don't use weapons or engage in combat, they don't need health or shields. That means devices that heal, restore shields, or provide healing and shield items aren't usable.
- **Hiding Props and Prop-O-Matic**: Beans don't know how to play hide and seek, so these aren't usable.
- **Guards, Wildlife, Sentries and Creatures**: Beans don't need guards or sentries, and they are scared of dangerous animals and monsters. So devices that spawn or control any of those aren't available on a Fall Guys island. But you can make friendly NPCs with the NPC Spawner or Character devices!
- **Movement**: Devices related to ways Beans don't move (Skydive Volumes, for example) aren't usable.
- **Resources and Items**: Since Beans don't build, they don't need resources.

## Publishing Fall Guys Islands

Publishing a Fall Guys island follows the same process as publishing any other Creative or UEFN island through the Creator Portal. You need to make sure your island meets the IARC Audience rating before submitting for publishing. To learn more about the publishing process, see [Using Creator Portal](https://dev.epicgames.com/documentation/en-us/fortnite/using-creator-portal-in-fortnite-creative).

## Your Island in Discover

In the Creator Portal, Fall Guys islands are automatically tagged with "Fall Guys". These special tags will appear on your island's product details page.

Creator-made Fall Guys islands will show up in Discover and are searchable, like any other Fortnite island.

## More Resources

Looking for more information or inspiration for building Fall Guys islands? Take a look at these tutorials!

- Learn how to use Creative devices to make the Fall Guys obstacles more dynamic, in [Fall Guys - Designing an Obstacle Course](https://dev.epicgames.com/documentation/en-us/fortnite/fall-guys-designing-an-obstacle-course-in-fortnite-creative).
- You can use Verse to animate rotation for fans and other rotating obstacles, in [Animating Prop Movement](https://dev.epicgames.com/documentation/en-us/fortnite/animating-prop-movement-in-verse).
