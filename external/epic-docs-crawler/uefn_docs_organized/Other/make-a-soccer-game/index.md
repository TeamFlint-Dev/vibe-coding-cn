# Make a Soccer Game

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/make-a-soccer-game>
> **爬取时间**: 2025-12-26T23:59:36.299168

---

Follow the steps below to create your very own physics-enabled soccer game, where players use their pickaxe to get the ball into their opponents' goal:

## Set Up the Project

1. Create a new project from any island template.

   The **Blank** template is recommended if you want to ensure a flat area to work with.

   If you start with the Blank template, apply the **M\_FortniteLandscape\_Customizable** material to the **GridPlanes** to give the ground a grassy look.
2. From the Project dropdown in the menu bar, select **Project Settings**.

   [![](https://dev.epicgames.com/community/api/documentation/image/81276bd0-c65f-4ccb-a95e-d765de439433?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/81276bd0-c65f-4ccb-a95e-d765de439433?resizing_type=fit)
3. Scroll to the bottom, under **Experimental Access**, to find and enable the **Physics**checkbox.

   [![](https://dev.epicgames.com/community/api/documentation/image/7502969a-4d53-4c02-91c9-cb3ddba4a73b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7502969a-4d53-4c02-91c9-cb3ddba4a73b?resizing_type=fit)

## Import the Soccer Ball

1. Download a soccer ball asset from your preferred asset marketplace. In this example, a .glb asset is used. It contains a static mesh, texture and material instance.

   [![](https://dev.epicgames.com/community/api/documentation/image/f56bf1de-5518-4f6a-875c-774dd2e614ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f56bf1de-5518-4f6a-875c-774dd2e614ac?resizing_type=fit)

   [Soccer Ball](https://sketchfab.com/3d-models/soccer-ball-88590cf1e42e44bfb85ce3b6b1959648) by [tinmanjuggernaut](https://sketchfab.com/tinmanjuggernaut) on Sketchfab, used under the [Sketchfab Standard License](https://sketchfab.com/licenses).
2. Import the ball by dragging the .glb file into your **Content Browser**. You can leave the default settings.

   [![800](https://dev.epicgames.com/community/api/documentation/image/f7cda6f9-6a64-4aab-815c-8eb9ea386e20?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f7cda6f9-6a64-4aab-815c-8eb9ea386e20?resizing_type=fit)
3. Double-click the **static mesh**to open the asset for editing.

   [![](https://dev.epicgames.com/community/api/documentation/image/4fd42d45-dd81-4e24-b4af-028a75ac1037?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4fd42d45-dd81-4e24-b4af-028a75ac1037?resizing_type=fit)
4. In the viewport, select **Show** and check **Simple Collision**.
5. If there is collision already, delete it.

   [![](https://dev.epicgames.com/community/api/documentation/image/75905301-eb07-4b11-b0ed-0a95948c2905?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/75905301-eb07-4b11-b0ed-0a95948c2905?resizing_type=fit)

   Removing collision from the static mesh
6. From the **Collision** menu in the top ribbon, select **Add Sphere Simplified Collision**.

   [![](https://dev.epicgames.com/community/api/documentation/image/c09042b8-274f-4b97-8629-f9808aa38f7a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c09042b8-274f-4b97-8629-f9808aa38f7a?resizing_type=fit)
7. In the **Collision** settings of the **Details** panel, set:

   |  |
   | --- |
   | Radius - **102.0** |
   | Collision Preset - **Block All** |
   | Center - **0 on all axes** |

8. The collision should now be visible. Save your static mesh.

   [![](https://dev.epicgames.com/community/api/documentation/image/87af1bcd-d5b2-42e9-99df-80ad8360381a?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/87af1bcd-d5b2-42e9-99df-80ad8360381a?resizing_type=fit)

## Create the Soccer Ball Prop

1. In the **Content Browser**, right-click the static mesh and select **Scripted Asset Actions** > **Convert to Prop** > **Stone**.
2. A folder called **CustomProps** will be created in your project. Open the folder and drag the Blueprint prop into the scene.

   [![](https://dev.epicgames.com/community/api/documentation/image/6b63f09f-b220-4f01-9ec4-5b4ac2075191?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/6b63f09f-b220-4f01-9ec4-5b4ac2075191?resizing_type=fit)
3. In the **Details** panel, press the **+Add** button and add a **Fort Physics** component.

   [![](https://dev.epicgames.com/community/api/documentation/image/d371e266-8045-49b0-9a22-1a5510d504b6?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d371e266-8045-49b0-9a22-1a5510d504b6?resizing_type=fit)
4. On the **FortPhysics** component, set:

   |  |
   | --- |
   | Simulate Physics - **True** |
   | Override Mass - **True** |
   | Mass - **20.0** |
   | Linear Dampening - **0.1** |
   | Angular Dampening - **0.3** |
   | Impulse On Hit Multiplier - **3.0** |

## Add Soccer Game Elements

1. Select **IslandSettings0** in your Outliner and change the following settings:

   |  |
   | --- |
   | Max Players - **6** |
   | Teams - **Team Index: 2** |
   | Team Size - **Split Evenly** |
   | Join In Progress - **Spawn** |
   | Invincibility - **True** |
   | Allow Building - **None** |
   | Start With Pickaxe - **True** |

2. Place six **Player Spawner** devices:

   |  |
   | --- |
   | First 3: Player Team - **Team Index 1** |
   | Other 3: Player Team - **Team Index 2** |
   | Visible in Game - **False** |

   Try launching a session at this point to make sure everything works as intended.
3. Using props, build out your field!

   [![](https://dev.epicgames.com/community/api/documentation/image/f4c8b563-290c-4d53-9683-74b4e37c6d54?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/f4c8b563-290c-4d53-9683-74b4e37c6d54?resizing_type=fit)

   |  |
   | --- |
   | Use **Colossal Coliseum** in Fortnite > **Prefabs** |
   | Use **Recreation Soccer Field** as your pitch |

4. Find the **FortniteRecreation SoccerGoal** in the Content Browser and place two instances for your goal areas. Scale them up **1.5x** to accommodate the size of the ball.

   [![](https://dev.epicgames.com/community/api/documentation/image/26d66b8c-5512-4b7d-86cd-3e5291b454f4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/26d66b8c-5512-4b7d-86cd-3e5291b454f4?resizing_type=fit)
5. Add a **Barrier**device to enclose the field and keep the ball from flying out of bounds.

   [![](https://dev.epicgames.com/community/api/documentation/image/69477a5c-9b46-4e62-9fa2-48efecc29ebe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/69477a5c-9b46-4e62-9fa2-48efecc29ebe?resizing_type=fit)

   Change the **Zone Shape** to **Hollow Box**, and put the bottom of the device below the ground. Otherwise, it will interfere with the player spawners.

   If you are spawning in skydiving and not on the Player Spawn Pad, it could be that the bottom of the device needs to be lowered, or that the Zone Shape isn’t set to Hollow Box.

## Set Up Devices

Currently, the devices that work with **Physics** are all located in the **Fortnite > Devices > !Experimental** folder.

1. To detect goals, set up two **Volume**devices:

   [![](https://dev.epicgames.com/community/api/documentation/image/ecd5dcbd-dab2-4930-881f-3420ccf7ae5d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecd5dcbd-dab2-4930-881f-3420ccf7ae5d?resizing_type=fit)

   Name the volume device behind the Team 1 spawn pads **Team\_A\_Goal**.

   Name the volume device behind the Team 2 spawn pads **Team\_B\_Goal**.

   | Size Settings |
   | --- |
   | Width - **0.6** |
   | Depth - **2.2** |
   | Height - **1.0** |

2. Add a **Tracker** device:

   |  |
   | --- |
   | Name - **Tracker Score Team A** |
   | Stat to Track - **Score** |
   | Tracker Title - **Team A Score** |
   | Sharing - **Team** |

3. Duplicate the Tracker device and rename the copy to **Tracker Score Team B**. Change the Tracker Title to **Team B Score**.
4. Add a **HUD Message** device:

   |  |
   | --- |
   | Name - **HUD Message Device Score A** |
   | Play Sound - **Scoring\_Point\_Added\_Cue** |
   | Background - **Pick a color** |
   | Placement - **Custom** |
   | Screen Anchor - **Center** |
   | Message - **“Team A Goal!!!”** |

5. Duplicate the HUD Message device.

   |  |
   | --- |
   | Name - **HUD Message Device Score B** |
   | Message - **“Team B Goal!!!”** |
   | Background - **Pick a second color** |

6. Add two **Air Vent** devices at an angle next to the goal. When the ball hits either of these air vents, it will launch the ball away from the goal area.  Set **Knockup Force Multiplier** to **0.1**.

   [![](https://dev.epicgames.com/community/api/documentation/image/8935770e-55f2-44d7-ae77-9f49f7a26bf8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8935770e-55f2-44d7-ae77-9f49f7a26bf8?resizing_type=fit)

## Make a Game Manager Using Verse

Using Verse is the quickest and simplest way to manage your game, so let's create a Game Manager! For more information on how to create a Verse device, check out [Create Your Own Device Using Verse](https://dev.epicgames.com/documentation/uefn/create-your-own-device-using-verse-in-unreal-editor-for-fortnite).

Create a new Verse file and name it **game\_manager.verse**. Double-click the file to open it in VS Code.

Add the following code to the file:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/SpatialMath }

# A Verse-authored creative device that can be placed in a level
game_manager := class(creative_device):

    @editable
    TeamAGoal:volume_device = volume_device {}

    @editable
    TeamBGoal:volume_device = volume_device {}

    @editable
    TrackerScoreTeamA:tracker_device = tracker_device {}

    @editable
    TrackerScoreTeamB:tracker_device = tracker_device {}

    @editable
    HUDMessageGoalTeamA:hud_message_device = hud_message_device {}

    @editable
    HUDMessageGoalTeamB:hud_message_device = hud_message_device {}

    @editable
    FootballA:creative_prop = creative_prop {}

    # Runs when the device is started in a game
    OnBegin<override>()<suspends>:void=
        TeamAGoal.PropEnterEvent.Subscribe(OnTeamAGoalEnter)
        TeamAGoal.PropExitEvent.Subscribe(OnTeamAGoalExit)
        TeamBGoal.PropEnterEvent.Subscribe(OnTeamBGoalEnter)
        TeamBGoal.PropExitEvent.Subscribe(OnTeamBGoalExit)

    OnTeamAGoalEnter(prop : creative_prop) : void=
        HUDMessageGoalTeamB.Show()
        TrackerScoreTeamB.SetValue(TrackerScoreTeamB.GetValue() + 1)
        spawn{ResetBall()}
        Print("Team 2 Scored Goal")

    OnTeamAGoalExit(prop : creative_prop) : void=
        Print("Exit Goal!!!")

    OnTeamBGoalEnter(prop : creative_prop) : void=
        HUDMessageGoalTeamA.Show()
        TrackerScoreTeamA.SetValue(TrackerScoreTeamA.GetValue() + 1)
        spawn{ResetBall()}
        Print("Team 1 Scored Goal")

    OnTeamBGoalExit(prop : creative_prop) : void=
        Print("Exit Goal!!!")

    ResetBall() <suspends> : void=
        var BallHidePosition : vector3 = vector3{ X := 880.0, Y := 4000.0, Z := 200.0 }
        if (FootballA.TeleportTo[BallHidePosition, IdentityRotation()]):
        Sleep(3.0)
        var BallResetPosition : vector3 = vector3{ X := 0.0, Y := 0.0, Z := 400.0 }
        if (FootballA.TeleportTo[BallResetPosition, IdentityRotation()]):
```

Compile the code and save your project.

You may need to tweak the positions of hiding and resetting the ball.

In UEFN, place the Verse device you just created in the scene and connect all the editable variables to your devices.

[![](https://dev.epicgames.com/community/api/documentation/image/eed61d9d-6211-4034-a520-fbfa4f81f33d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/eed61d9d-6211-4034-a520-fbfa4f81f33d?resizing_type=fit)

Start a session or push all changes to the Live Edit session and verify:

- The ball is moving when you push into it or hit it with the pickaxe.
- When you push the ball into the goal, a HUD message pops up, the score changes, and the ball resets to the center of the field.

Enjoy your new soccer game!

Experiment by adding more balls, more devices, changing the scale, etc.! Here's an example of a modified soccer game:

[![](https://dev.epicgames.com/community/api/documentation/image/d80d1f83-3ac8-4bef-b146-c86bfc123cfd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/d80d1f83-3ac8-4bef-b146-c86bfc123cfd?resizing_type=fit)
