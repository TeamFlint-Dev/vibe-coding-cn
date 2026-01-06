# 3. Build a Shooting Gallery

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/first-island-03-build-a-shooting-gallery-in-fortnite
> **爬取时间**: 2025-12-26T23:53:20.392854

---

Time to add some targets for the player to shoot!

Throughout this tutorial, we will be referring to targets as **good targets** and **bad targets**. The good targets are the ones that earn the player points when successfully shot. The bad targets cause the player to lose points if hit.

## Devices Used

- 3 x **[Target Dummy Track](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-target-dummy-track-devices-in-fortnite-creative)** device
- 3 x **[Target Dummy](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-target-dummy-devices-in-fortnite-creative)** device
- 1 x **[Barrier](https://dev.epicgames.com/documentation/en-us/fortnite-creative/using-barrier-devices-in-fortnite-creative)** device

## Add a Moving Target

The player scores for hitting moving targets!

1. Open the **Content Browser** and navigate through the folders to **Fortnite** > **Devices**.
2. Search for **target** to surface the target devices.

   [![Search for Target in the search bar.](https://dev.epicgames.com/community/api/documentation/image/c4ee8077-917f-4df4-8d4e-0f751cd1bfb8?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c4ee8077-917f-4df4-8d4e-0f751cd1bfb8?resizing_type=fit)

   Search for Target in the search bar.
3. Drag a **Target Dummy Track** into the viewport. This target slides back and forth on a track.

   ![](https://dev.epicgames.com/community/api/documentation/image/cd0a862a-29ae-44cf-804f-583061648145?resizing_type=fit)
4. In the **Details** panel, under **User Options**, customize **Target Type** to **Round**.

   These round targets will be your good targets. When the player shoots one, they earn points.
5. With User Options still expanded, expand **Advanced** to show more options, then customize the following, scrolling as needed.

   | Option and Value |
   | --- |
   | Score Value = **0**  Show Health Bar = **Uncheck**  Move on Proximity = **Uncheck**  Score Bullseye Knockdown = **Check**  Hing from Center = **Check**  Reset Time Type = **Random**  Random Reset Minimum Time = **3.0 s**  Random Reset Maximum Time = **6.0 s**  Pop-Up Delay Type = **Random**  Random Pop-Up Minimum Time = **3.0 s**  Random Pop-Up Maximum Time = **6.0 s** |

With these settings, the following happens:

- The target shape becomes round.
- When the target drops, it folds from the middle of the stand instead of from the bottom.
- The reset and pop-up times are randomized to reset or pop-up between three and six seconds.

## Add More Targets

Shooting one target isn’t very exciting, so you can up the pace by adding more targets.

Since this one is already customized, it's easy to copy it, then arrange the copies in a staggered pattern like a shooting gallery at a carnival.

1. Click the **Target Dummy Track** device in the viewport to select it.
2. Press the **Alt key**, then drag the **Y-axis arrow** to create a  duplicate target.

   You can drag an item by any axis to make a copy while pressing the **Alt** key. The axis you select limits the direction you can drag it: left or right, up or down, forward or backward. Clicking the right angle where two axes meet lets you drag the object on two axes.
3. Duplicate the target until you have three.
4. Use the grid on the floor to **translate (move)**the targets into a staggered pattern.

   [![Three Targets Dummy Track devices.](https://dev.epicgames.com/community/api/documentation/image/19a6de12-4b61-4ab1-9ed2-8c61b1cf3a0b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/19a6de12-4b61-4ab1-9ed2-8c61b1cf3a0b?resizing_type=fit)

   Three Targets Dummy Track devices.

To create even more random behavior, alter the Random Reset and Pop-Up Delay times on the duplicate target dummies so they don't behave identically.

## Add a Non-Moving Target

Using sliding targets adds one layer of complexity to the shooting gallery because a moving target is harder to shoot at than one that doesn't move.

On this step, add a second layer of complexity by adding a non-moving target that a player should **not** hit, and deduct points if the player does hit it!

1. In the **Content Browser**, search for **target** again.

   [![Type target into the search bar.](https://dev.epicgames.com/community/api/documentation/image/9d25907e-695f-4a50-b8b6-7aab0caa95c9?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d25907e-695f-4a50-b8b6-7aab0caa95c9?resizing_type=fit)

   Type target into the search bar.
2. This time, drag the **Target Dummy** into the viewport. Unlike the first target, this one doesn't move on a track. Instead, it swings between knockdown and stand-up positions.

   This target will be your **bad target**. If the player shoots one, they lose points.
3. In the **Details** panel, under **User Options**, set **Target Type** to **Teddy Bear**, then expand **Advanced** to set the following values:

   | Option and Value |
   | --- |
   | Score Value = **0**  Show Health Bar = **Uncheck**  Pop Up Delay Type = **Random**  Random Pop Up Minimum Time = **2.0 s**  Random Pop Up Maximum Time = **10.0 s**  Time Before Hiding Type = **Random**  Random Hide Minimum Time = **2.0 s**  Random Hide Maximum Time = **10.0 s**  Start Position = **Down** |

These settings cause the target to start in the down position, then pop up randomly.

## Add a Barrier

To control player movement and prevent the player from getting close to the targets as they're shooting, you'll create a barrier that keeps the player at a distance.

1. In the **Content Browser**, search for **barrier**.

   [![Type barrier into the search bar.](https://dev.epicgames.com/community/api/documentation/image/192d9a7d-f13e-4767-aaea-06950fcd1dbe?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/192d9a7d-f13e-4767-aaea-06950fcd1dbe?resizing_type=fit)

   Type barrier into the search bar.
2. Drag the **Barrier** device into the viewport and place it in front of the target devices.

   [![Drag a Barrier device into the viewport.](https://dev.epicgames.com/community/api/documentation/image/35b22cbd-5788-4c1e-886d-46b1963f4073?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/35b22cbd-5788-4c1e-886d-46b1963f4073?resizing_type=fit)

   Add a Barrier device to the viewport.
3. In the **Details** panel, under **User Options**, set the **Barrier Depth**, **Barrier Width**, and **Barrier Height** options to make the barrier the same size as the shooting gallery area. Use the **transform arrows** to reposition it as needed.
4. Open the **Barrier Material** dropdown menu and select **Clear** from the menu options. This makes the barrier see-through.

   [![Select Clear Barrier Material to remove the design from the barrier.](https://dev.epicgames.com/community/api/documentation/image/a5d9f07e-8484-4db2-845b-a4a8158af0c3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a5d9f07e-8484-4db2-845b-a4a8158af0c3?resizing_type=fit)

   Select Clear Barrier Material to remove the design from the barrier.
5. Scroll down to the **Block Weapon Fire** and **uncheck** the option.

When players spawn into the game, they can wander around the area behind the barrier, but can't enter the shooting gallery area.

## Next Up

[![4. Playtest Your Island](https://dev.epicgames.com/community/api/documentation/image/07ce08f1-02b8-40b5-9f91-e1d881c4d0cc?resizing_type=fit&width=640&height=640)

4. Playtest Your Island

See why playtesting is a crucial element of game design and development.](https://dev.epicgames.com/documentation/en-us/fortnite/first-island-04-playtest-your-island-in-fortnite)
