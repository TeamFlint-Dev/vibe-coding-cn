# Set Up the Game

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/set-up-the-game-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-27T00:39:01.884793

---

The island set up here is for a single player. This step includes creating a UEFN project and changing the **Island Settings**.

1. Open UEFN and select a **Blank** template from the **Project Browser**window.

   [![](https://dev.epicgames.com/community/api/documentation/image/14deee70-99e1-4111-b9a4-0db68fbbb70b?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/14deee70-99e1-4111-b9a4-0db68fbbb70b?resizing_type=fit)
2. This opens a Blank project in the editor.

   [![](https://dev.epicgames.com/community/api/documentation/image/97fc43c6-e6cb-4628-a003-6d5ab43ae2be?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/97fc43c6-e6cb-4628-a003-6d5ab43ae2be?resizing_type=fit)
3. In the **Outliner** panel, type **i**sland**** in the **s**earch**** bar, then select **Island Settings** from the asset list.

   [![](https://dev.epicgames.com/community/api/documentation/image/4d0b52bf-8523-4811-bc36-dfa8824643ff?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4d0b52bf-8523-4811-bc36-dfa8824643ff?resizing_type=fit)
4. The Island Settings user options appear in the **Details** panel .

   [![](https://dev.epicgames.com/community/api/documentation/image/2919fc57-1ce6-4a4e-97d3-e6e1633332cd?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2919fc57-1ce6-4a4e-97d3-e6e1633332cd?resizing_type=fit)
5. Modify the **User Options** with the values in the table below.

Use the **Search** bar to quickly locate each setting.

[![](https://dev.epicgames.com/community/api/documentation/image/71c193ad-acc1-4687-8e90-a737d8979ef1?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/71c193ad-acc1-4687-8e90-a737d8979ef1?resizing_type=fit)

| Option | Value | Explanation |
| --- | --- | --- |
| Max Players | 1 | This is a single-player game. |
| Down But Not Out | Off | Not necessary in a single-player game. |
| Locomotion Preset | Custom | Provides a way to customize locomotion settings. |
| Fall Damage | True | Players take damage when they fall from a certain height. |
| Glider Redeploy | False | This is unnecessary. |
| Allow Wall Kick | False | This is unnecessary. |
| Allow Wall Scramble | False | This is unnecessary. |
| Allow Building | None | This is unnecessary. |
