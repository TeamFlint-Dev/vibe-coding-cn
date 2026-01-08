# Modify and Run Your First Verse Program

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/modify-and-run-your-first-verse-program-in-unreal-editor-for-fortnite>
> **爬取时间**: 2025-12-26T23:08:27.684005

---

By following the steps on this page, you can learn how to create, run, edit, and troubleshooot a **Verse** program that says "Hello, world!" in **Unreal Editor for Fortnite** **(UEFN)**.

See [Launching Unreal Editor for Fortnite](https://dev.epicgames.com/documentation/en-us/uefn/launching-in-unreal-editor-for-fortnite) for how to access UEFN.

## Your First Verse Program

The **VKT - Verse Device Starter Games** template works as an introduction to [devices created with Verse](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#verse-authored-device), and contains multiple devices that you can look at for examples. In the steps below, you'll create and modify a new Verse device in this template.

1. In the **Project Browser** window, select **Feature Examples** to view all the UEFN Feature Examples.

   [![Select Feature Examples in Unreal Editor for Fortnite](https://dev.epicgames.com/community/api/documentation/image/a0a03bce-7a29-483a-985c-8daa296e4573?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a0a03bce-7a29-483a-985c-8daa296e4573?resizing_type=fit)
2. From the list of Feature Examples, click **Verse Device** to highlight.

   [![Select Verse Device Template in Unreal Editor for Fortnite](https://dev.epicgames.com/community/api/documentation/image/925d5864-5a0c-4753-b15d-e739c4b4c1da?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/925d5864-5a0c-4753-b15d-e739c4b4c1da?resizing_type=fit)
3. At the the bottom of the screen, under **Project Name**, name your [project](unreal-editor-for-fortnite-glossary#project) **MyVerseProject**, then click **Create**.
4. In the [Menu Bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), go to **Verse > Verse Explorer**.
5. In [Verse Explorer](https://dev.epicgames.com/documentation/en-us/fortnite/verse-explorer-user-interface-reference-in-unreal-editor-for-fortnite), right-click on your project name and choose **Add new Verse file to project** to open the **Create Verse Script** window.

   [![Create New File in Verse Explorer](https://dev.epicgames.com/community/api/documentation/image/ca85b069-f9c9-4e3d-ac7f-b36c890e5286?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ca85b069-f9c9-4e3d-ac7f-b36c890e5286?resizing_type=fit)
6. In the Create Verse Script window, click **Verse Device** to select as your template and click **Create**.

   [![Select Verse Device in Create Verse Script window](https://dev.epicgames.com/community/api/documentation/image/4fd55f8f-e897-49fc-bb8e-09d69f46a794?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/4fd55f8f-e897-49fc-bb8e-09d69f46a794?resizing_type=fit)
7. In the **Menu Bar**, go to **Verse > Build Verse Code** to ensure your newly created verse device appears in the project folder.
8. In the **Content Browser**, navigate to your project folder.

   If the [Content Browser](unreal-editor-for-fortnite-glossary#content-browser) isn't already open, click **Window** on the [Menu Bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), then select **Content Browser** or select **Content Drawer** at the bottom left of the UEFN window.

   The path should be **All > MyVerseProject  > hello\_world\_device**.

   [![Navigate to the CreativeDevices folder in the Content Browser](https://dev.epicgames.com/community/api/documentation/image/dc0c7b75-c186-4448-94fc-409d801093a2?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/dc0c7b75-c186-4448-94fc-409d801093a2?resizing_type=fit)
9. Click and drag the **hello\_world\_device** into the [level](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#level).
10. In the [toolbar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), click **Launch Session** to [playtest your island](https://dev.epicgames.com/documentation/en-us/fortnite/playtesting-your-island-in-unreal-editor-for-fortnite).

    [![In the Toolber choose Launch Session to playtest your island](https://dev.epicgames.com/community/api/documentation/image/64d904c5-f0ea-460e-9717-e3e4e3a81383?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/64d904c5-f0ea-460e-9717-e3e4e3a81383?resizing_type=fit)

    *Click image to expand.*
11. In the **Save Content** window, click **Save Selected** to save your changes to the project.

    [![In the Save Content window, choose Save Selected](https://dev.epicgames.com/community/api/documentation/image/7cbebf61-fb50-4ab5-822a-5014b5c4866f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/7cbebf61-fb50-4ab5-822a-5014b5c4866f?resizing_type=fit)
12. When the [server](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#server) finishes loading the project, open the Main Menu and click **Start Game**.

    [![Open the Main Menu and choose Start Game](https://dev.epicgames.com/community/api/documentation/image/172586f1-c6ee-49ce-9c90-5b644393bd60?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/172586f1-c6ee-49ce-9c90-5b644393bd60?resizing_type=fit)
13. In the [client](https://dev.epicgames.com/documentation/en-us/fortnite/unreal-editor-for-fortnite-glossary#client), press **Escape** to open the Main Menu screen and click **Island Settings**. Then click **Log** in the top navigation bar to view the log.
14. In the log, find the line that says "Hello, world!" that's followed by "2 + 2 = 4" on the next line. These lines are from the hello\_world\_device.verse file. Because you added the Verse-created device to your level, its code ran when you started the game.

    [![Open the log to see "Hello, world!" printed](https://dev.epicgames.com/community/api/documentation/image/38d564e0-5e4a-4bc1-82cd-c303445b558f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/38d564e0-5e4a-4bc1-82cd-c303445b558f?resizing_type=fit)

Now that you’ve run your first Verse program, let’s look at the code in **hello\_world\_device.verse** and change it. Keep the client running for the next section.

## Modify the Program

Follow these steps to view the hello\_world\_device.verse file, which created the device from the previous section, then add a new line of code.

1. In the [Menu Bar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite), click **Verse > Verse Explorer** to see all the Verse files in your project.
2. Under your project’s name, double-click **hello\_world\_device.verse** to open the file.

   [![In the Verse Explorer, open the hello_world_device.verse file](https://dev.epicgames.com/community/api/documentation/image/9dac3a55-1808-408f-8295-48864a7f84ac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9dac3a55-1808-408f-8295-48864a7f84ac?resizing_type=fit)
3. The Verse file opens in [Visual Studio Code (VS Code)](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#visual-studio-code), an editor for writing programs. If you don’t have Visual Studio Code on your computer, a prompt will appear asking you to install it.

   [![hello-world-device.verse file is opened in Visual Studio Code](https://dev.epicgames.com/community/api/documentation/image/b26e23e2-86b3-46ac-bc38-bc9006753b84?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/b26e23e2-86b3-46ac-bc38-bc9006753b84?resizing_type=fit)

   *Click image to expand.*

The Verse code extension is an extension for VS Code that provides Verse [error](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#compiler-error) checking and [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) highlighting, and also allows you to compile and push changes to your Verse scripts directly from VS code.

The Verse extension bundled with UEFN is the only officially supported language extension for Verse. This extension is enabled automatically when you launch UEFN. If you uninstall the extension, it will be reinstalled when you launch UEFN again.

You can verify the installation of the Verse code extension by the presence of the Editor Focus, Build Verse Changes, and Push Verse Change Buttons on the top of your VS Code window.

[![Verse Code Extension Buttons](https://dev.epicgames.com/community/api/documentation/image/78f874d8-7429-4cfb-81ee-1f63697d7bc4?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/78f874d8-7429-4cfb-81ee-1f63697d7bc4?resizing_type=fit)

*Click image to expand.*

You'll see how the rest of this code works later, but for now, any code you enter under the line `OnBegin<override>()<suspends>:void=` will run when the game begins, so add the following code at the end of the file:

```verse
Print("This is my first line of Verse code!")
```

Your Verse file should now look like this:

```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
hello_world_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # TODO: Replace this with your code
        Print("Hello, world!")
        Print("2 + 2 = {2 + 2}")
        Print("This is my first line of Verse code!")
```

Any text after the symbol `#` is considered a code comment and ignored by the computer when the program runs. Code comments are useful for you and anyone else reading your code, because these comments can contain explanations for your code. In this example, `# Runs when the device is started in a running game` and `#TODO: Replace this with your code` are both code comments.

### Save Your Changes

1. Save the **hello\_world\_device.verse** file in Visual Studio Code.
2. In the UEFN toolbar, click **Verse**, then click **Build Verse Code** to compile your code.

   [![Click Build Verse Scripts to compile your code](https://dev.epicgames.com/community/api/documentation/image/2f739977-eef6-4453-911a-b96166eaeb4e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2f739977-eef6-4453-911a-b96166eaeb4e?resizing_type=fit)

   *Click image to expand.*
3. Upon successful compilation, a green check mark will appear over the **Verse** button. If problems occur during compilation, a red stop icon will appear, and you won't be able to compile your code until you resolve all errors. If this occurs, see [Troubleshoot Your Code](https://dev.epicgames.com/documentation/en-us/fortnite/modify-and-run-your-first-verse-program-in-unreal-editor-for-fortnite) for tips on fixing your code.

   [![Compiler error vs no compiler error](https://dev.epicgames.com/community/api/documentation/image/8b7d4344-835b-432f-b184-1199ac96f16c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/8b7d4344-835b-432f-b184-1199ac96f16c?resizing_type=fit)

   *Click image to expand.*
4. When your code finishes compiling, the options **Push Changes** and **Push Verse Changes** appear in the UEFN toolbar. **Push Changes** updates your client with all changes made in the editor, such as adding and removing props, modifying object properties, and any changes made to Verse code. **Push Verse Changes** only updates your Verse code, and is faster than **Push Changes**. This is helpful in situations where you want to make small, incremental changes to your code without refreshing your session. Click **Push Verse Changes** to update your client.

   [![Click to push Verse changes in the UEFN toolbar](https://dev.epicgames.com/community/api/documentation/image/33de0faf-515c-4358-b226-99af9e9ac677?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/33de0faf-515c-4358-b226-99af9e9ac677?resizing_type=fit)

   *Click image to expand.*
5. When the server finishes updating the project, open the Main Menu and click **Start Game**.
6. In the log, find the line that says "This is my first line of Verse code!" That’s from the code you just added to the script!

   [![This is my first line of Verse code prints to the log](https://dev.epicgames.com/community/api/documentation/image/a16d9536-dd29-4d5c-8fb6-aec45ae0f30c?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/a16d9536-dd29-4d5c-8fb6-aec45ae0f30c?resizing_type=fit)

## Sequential Execution

When you added that line of code to print text to the log, the text "This is my first line of Verse code!" was printed to the log after "2 + 2 = 4". This is because those lines of code are executed in the order they’re written under the line `OnBegin<override>()<suspends>:void=`.

If you change the order of the print lines, the text will print to the log in the new order, with "This is my first line of Verse code!" appearing before "2 + 2 = 4":

```verse
OnBegin<override>()<suspends>:void=
    #TODO: Replace this with your code
    Print("Hello, world!")
    Print("This is my first line of Verse code!")
    Print("2 + 2 = {2 + 2}")
```

Code is generally executed line by line, in the order the expressions appear. This is called **sequential execution**. As you learn more about programming with Verse, you’ll learn how to shape the execution flow to change your program’s behavior.

## Troubleshoot Your Code

Now that you’ve written and run your first line of Verse code, here's how to troubleshoot some of the issues you might run into when writing code.

There are two kinds of errors you can encounter: **compiler errors** and **bugs**.

### Compiler Errors

As with any kind of writing, you can have typos in your code. These typos prevent the compiler from understanding what you want the program to do. They are called compiler errors because they prevent the program from compiling, and are often errors in syntax. This prevents you from being able to run your code in a playtest.

VS Code can detect some compiler errors and inform you of them by changing the color of the filename to red on the file tab and in the Explorer panel.

VS Code also adds a red squiggle under the line where it detects an issue. When you hover over the squiggle, an error message will appear with a possible quick fix if there’s one that VS Code can provide.

VS Code might not catch all compiler errors, so it’s also good practice to build your code before trying to run your code to catch any errors early on. To do this, click **Verse** , and then **Build Verse Code** in the UEFN [Toolbar](https://dev.epicgames.com/documentation/en-us/fortnite/user-interface-reference-for-unreal-editor-for-fortnite). This option compiles all the Verse files in the project, which translates the code you've written into computer-executable instructions.

[![Find more syntax errors by choosing Build Verse Code in the Toolbar](https://dev.epicgames.com/community/api/documentation/image/9d862140-9e36-4309-b498-3983343716ee?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/9d862140-9e36-4309-b498-3983343716ee?resizing_type=fit)

*Click image to expand.*

The output log will show either a **success message** if your code builds successfully, or **errors** that you’ll need to fix before you can use your code while playtesting

When you select **Build Verse Code**, a popup message will also appear if there was a compilation error.

[![Build Error message pops up when there's a build error with the Verse script](https://dev.epicgames.com/community/api/documentation/image/ecb710c2-fe8b-454f-8e8c-584d435f2b2e?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/ecb710c2-fe8b-454f-8e8c-584d435f2b2e?resizing_type=fit)

Selecting **See Errors** in the popup message will open the **Message Log** window and show all of the errors in the code that VS Code was able to detect.

[![Message Log shows build errors from your code](https://dev.epicgames.com/community/api/documentation/image/649131e9-dbe0-4ff6-ac45-60066053cff3?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/649131e9-dbe0-4ff6-ac45-60066053cff3?resizing_type=fit)

*Click image to expand.*

Once you fix any errors, you can compile the code again and verify that your code builds successfully by clicking **Build Verse Scripts** again in the UEFN toolbar, or clicking **Rebuild** in the popup message.

### Bugs

When your code builds successfully, but your program isn’t doing what you expect, these issues are called **bugs**. Bugs are issues with logic in your code, and one way to find them is by printing to the log.

The code in **hello\_world\_device** is a good example of how printing to the log is used to verify whether code is running when you start the game.

```verse
OnBegin<override>()<suspends>:void=
    #TODO: Replace this with your code
    Print("Hello, world!")
    Print("This is my first line of Verse code!")
    Print("2 + 2 = {2 + 2}")
```

You can also print values to test if your code is doing what you expect. When you run the following code, the text "2 + 2 = 4" appears in the log:

```verse
Print("2 + 2 = {2 + 2}")
```

The expression `{2 + 2}` was evaluated to be 4 before the text was printed to the log. The curly brackets {} between the double quotes " " on the last line means that the expression should be evaluated before being converted to text. Injecting a value into a string like this is an example of [string interpolation](https://dev.epicgames.com/documentation/en-us/fortnite/string-in-verse).

If you change the expression between the curly brackets, the value that is printed will change. In the following example, the expression is changed to `{2 + 3}`, so "2 + 2 = 5" will appear in the log:

```verse
nBegin<override>()<suspends>:void=
    #TODO: Replace this with your code
    Print("Hello, world!")
    Print("This is my first line of Verse code!")
    Print("2 + 2 = {2 + 3}")
```

## Next Steps

Now that you've had a brief introduction to Verse and how to run and troubleshoot your code, go to [Learn the Basics of Writing Code in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/learn-the-basics-of-writing-code-in-verse) to expand your knowledge of programming in general and learn more about how to harness this programming tool.

You can also play Verse Devices Starter minigame by interacting with the button on the console when you spawn. You can learn how this minigame was created by reading [Verse Starter Template](verse-starter-template-in-unreal-editor-for-fortnite), and you can check out the code files used in this project in the Verse Explorer!
