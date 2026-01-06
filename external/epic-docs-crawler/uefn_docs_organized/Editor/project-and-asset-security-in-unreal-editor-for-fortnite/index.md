# Project and Asset Security

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/project-and-asset-security-in-unreal-editor-for-fortnite
> **爬取时间**: 2025-12-26T23:55:37.775423

---

**Unreal Editor for Fortnite** (UEFN) is a powerful game development tool that includes advanced scripting capabilities. These capabilities make it possible for you to create complex and unique gameplay, but they also come with some risk to your data and your computer.

As long as you’re working on your own, the chance of something going wrong is minimal. However, when you work with other people, or when you download other people’s work for use in your projects, there is a potential risk of introducing content that accidentally or maliciously breaks your project, executes arbitrary code, or gets undesired access to your computer.

**You can minimize these risks by only opening projects and assets that come from people you trust.**

This page summarizes the most common actions you can take in UEFN that may expose you to risk and what you can do to reduce that risk.

## Opening a UEFN Project

UEFN projects can contain scripts that execute code and access data on your computer in ways that you may not be aware of and may not be comfortable with. If you copy or download a project authored by someone else, and you open that project in UEFN, you expose yourself to the risk of these scripts running on your computer.

If UEFN detects that you’re opening a project that comes from an unknown source (typically downloaded from the internet), it warns you of the risk before continuing.

To protect yourself:

- Only open UEFN projects that come from sources you trust.
- Don’t rely solely on warning messages to evaluate whether projects are safe. In some cases, UEFN may not be able to detect that a project comes from an unknown source.

## Using Third-Party Assets

Unreal assets are often saved as binary files with the .uasset extension. Some kinds of .uasset files, such as Blueprint scripts, are capable of executing code that can affect your project data and access other data on your computer.

To protect yourself:

- Only import assets that come from sources you trust into your projects.

## Joining and Working with a UEFN Team

When you join a team in UEFN and work collaboratively on a project in Unreal Revision Control, you routinely sync to your computer snapshots of the changes made to the project by other team members. Another team member might accidentally or maliciously introduce scripted content into your shared project. The next time you sync, these scripts could then execute on your computer.

To protect yourself:

- Only work collaboratively with people you trust.
- Agree between yourselves in advance on which third-party asset sources you trust, and/or get agreement from teammates before you import content from other third parties.

## Opening Verse Files in Visual Studio Code

When you open Verse files from UEFN, Visual Studio Code prompts you to trust the authors of the code. Trusting the authors enables a Visual Studio Code extension for Verse written by Epic Games, which provides rich language features such as syntax highlighting, autocompletion, and error reporting. Trusting the authors might also allow other Visual Studio Code extensions not written by Epic to execute code and access your computer’s data.

To protect yourself:

- Only install extensions for Visual Studio Code that are written by people you trust.
- Only open Verse files written by people you trust.
