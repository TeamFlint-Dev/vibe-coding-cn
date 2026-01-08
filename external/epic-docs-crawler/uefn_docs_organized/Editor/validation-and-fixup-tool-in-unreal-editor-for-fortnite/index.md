# Validation and Fix-Up Tool

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/validation-and-fixup-tool-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:17:47.325014

---

In **Unreal Editor for Fortnite (UEFN),** your projects are run through a [validation](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#validation) process to ensure that the project data supplied is valid and usable. UEFN projects are processed, validated, and run on Epic’s servers.

Not all of the [assets](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#asset) and objects that are available in Fortnite or Unreal Engine 5 can be used in UEFN projects, so this check is important to do before you upload your project. A validation check is run on your project before it’s uploaded, and again once it's on Epic’s servers, to check that everything in your project is configured correctly before it is processed.

When you have objects with properties that don't meet UEFN’s conditions, your project won't process properly. This means you won’t be able to launch a session, and you won’t be able to publish.

These validation checks change over time as UEFN changes.

## UEFN Validation Checks

UEFN runs the following validation checks:

- **Specific platforms** - UEFN projects can run on mobile [platforms](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#platform), which have significantly less memory available than console platforms.
- **Allowed types and assets** - UEFN supports most but not all of the types allowed in UE5.
- **Total texture size and texture usage** - This helps your project run with less memory, especially on console platforms.
- **Property validation** - Some object properties don't work on every platform that UEFN supports, so these properties are disabled in UEFN.
- **Reference validation** -If your project references Fortnite content, you can only reference it via the published, stable API.
- **Fortnite Implementation** - The game is big and built on top of the engine, and choices made along the way sometimes mean some Unreal features cannot coexist. A great example is that Fortnite uses dynamic lighting, and baked lighting would not work in combination.

Often there are new technologies and features in development that intend to replace certain systems, or may require significant changes to those systems. In such cases, Epic might choose not to transition to a new feature to avoid breaking projects.

Other checks ensure that your project can [cook](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#cook) and meet its memory requirements to run successfully.

## Property and Reference Validation

**Property Validation** ensures that your objects only have modifications to properties that are editable in UEFN.

Normally, you can’t make edits to properties that aren’t visible in UEFN, but certain older objects released by Epic may have these changes, and if you copy objects from Unreal Engine and paste them into UEFN, this can occur.

In both of these cases, these hidden edits have to be removed.

**Reference Validation** checks that objects containing references should only have references to assets that are allowed in UEFN.

Any assets that are in your [content browser](user-interface-reference-for-unreal-editor-for-fortnite#contentbrowser) should generally be safe to reference, but sometimes changing references to such objects (like trying to directly reference the static mesh of actors), or copying objects directly from Unreal Engine projects will generate references that aren’t allowed.

The validation fix-up feature solves two common UEFN validation issues:

- **Illegal Property Overrides** - Modifying a property that UEFN shouldn’t have access to.
- **Illegal Property Values** - Referencing something that UEFN shouldn’t have access to.

The fix-up feature detects which properties are invalid and reverts them to their default value.

Any changes made by the fix-up feature are fully [transacted](unreal-editor-for-fortnite-glossary#transacted) (so they can be undone), and will only affect the in-memory state of your content (until you decide to save it).

Automatic fix-up provides a report showing which properties were reverted, why, and what their original value was. This provides a way for you to make an informed decision on whether to keep the automatic fix-up result, or undo it and manually fix things yourself.

Validation issues are not all expected to go away when you run the **Fix-Up button**. For example, resolving a Texture validation issue has its own process. To learn more about Texture validation, see [**Resizing Textures**](resizing-textures-in-unreal-editor-for-fortnite).

## Validation Fix-Up Tool

There are several ways the validation fix-up process runs in UEFN.

### Automatic Fix-Up

Automatic fix-up runs over one or more objects to automatically find and revert properties that are in an invalid state.

### Project Fix-Up

If UEFN detects validation errors prior to uploading your project, it offers you the option to run automatic fix-up over the set of failed assets/actors.

[![If UEFN detects validation errors prior to uploading your project, it offers you the option to run automatic fix-up over the set of failed assets/actors.](https://dev.epicgames.com/community/api/documentation/image/83770e37-e9c6-461b-b8c7-09b2708c8910?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/83770e37-e9c6-461b-b8c7-09b2708c8910?resizing_type=fit)

### Asset Fix-Up

You can run automatic fix-up over a given asset (or set of assets) via the **Content Browser** by selecting the asset(s) you want to process and selecting **Asset Actions** > **Fix Validation Issues** from the asset context menu.

[![You can run automatic fix-up over a given asset (or set of assets) via the **Content Browser**.](https://dev.epicgames.com/community/api/documentation/image/54303896-1e39-4d48-a7f8-4f3b4588cd1e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/54303896-1e39-4d48-a7f8-4f3b4588cd1e?resizing_type=fit)

### Actor Fix-Up

You can run automatic fix-up over a given actor (or set of actors) via the **Scene Outliner**, by selecting the actor(s) you want to process and running **Fix Validation Issues** from the actor context menu.

[![You can run the automatic fix-up over a given actor (or set of actors) via the **Scene Outliner**.](https://dev.epicgames.com/community/api/documentation/image/c931bffd-0daa-4b34-ae64-800709279166?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/c931bffd-0daa-4b34-ae64-800709279166?resizing_type=fit)

### Manual Fix-Up

You can run manual fix-up on a single invalid property by clicking **Reset Property to Default** below supported validation warnings or errors.

[![You can run manual fix-up on a single invalid property by clicking **Reset Property to Default** below supported validation warnings or errors.](https://dev.epicgames.com/community/api/documentation/image/53a4410c-49ae-4a1f-be57-8b049ece7a65?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/53a4410c-49ae-4a1f-be57-8b049ece7a65?resizing_type=fit)
