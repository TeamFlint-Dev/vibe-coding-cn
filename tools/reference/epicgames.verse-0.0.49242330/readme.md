# Verse extension for VS Code

Provides Verse language support.

## Features

Verse code `.verse` support
- Editor windows
  - Syntax Highlighting - colors text based on Verse grammar
  - Mouse Hover Tooltips - additional information when hovering mouse over identifiers and errors
  - Go to Definition (`F12`) - go to file and definition location of identifier that editor caret is on
  - Peek Definition (`Alt`+`F12`) - open preview of definition location of identifier that editor caret is on
  - Find symbol (`Ctrl`+`T`)
  - Error Squiggles - displayed under text whenever error detected and provides error message mouse hover info
  - Auto-complete - suggests list of potential identifiers and code based on context of where editor caret is located
  - Auto-formatting - formats text as you type and with copy and paste
  - Auto-save - saves whenever focus lost
- Document outline - Auto generated based on .verse file contents and allows quick navigation within a `.verse` file. Located at the bottom of the VS Code Explorer.
- Problems window - Lists out errors detected by the Verse extension language server 

## Verse Documentation

- [Verse Programming in Unreal Editor for Fortnite (UEFN) Onboarding Guide](https://dev.epicgames.com/documentation/en-us/uefn/onboarding-guide-to-programming-with-verse-in-unreal-editor-for-fortnite)
- [Learn Programming with Verse](https://dev.epicgames.com/documentation/en-us/uefn/learn-programming-with-verse-in-unreal-editor-for-fortnite)
- [Verse Language Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-reference)
- [Verse Framework API](https://dev.epicgames.com/documentation/en-us/uefn/verse-api) - also look at the `.digest.verse` files included with your Verse projects
- [Verse Scripting on the Epic Games Dev Community Forums](https://forums.unrealengine.com/tags/c/development-discussion/programming-scripting/148/fortnite/l/latest)

## Additional information

The Verse extension uses a bundled Verse language server executable to analyze
Verse code as it is typed and also to communicate bidirectionally with UEFN.
A Verse debugger is not yet available.

## Reporting an issue

Please use the Epic Dev Community forums to report issues with this
extension. You can access the forums
[here](https://forums.unrealengine.com/tags/c/development-discussion/programming-scripting/148/fortnite).

# License

Use of the Unreal Engine, Unreal Editor for Fortnite and Verse is governed by
the terms of the Unreal® Engine [End User License Agreement](https://www.unrealengine.com/eula).
