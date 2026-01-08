# Verse Glossary

> **来源**: <https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary>
> **爬取时间**: 2025-12-26T22:58:00.494472

---

**Verse is a new programming language**, so if you’re an experienced programmer and you see something you don’t fully get, check this glossary.

If you’re **new to programming**, this glossary is also for you. We’ve added definitions for a lot of basic programming terms, and you might just find the answers you need here!

abstract class
:   When a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) or a class [method](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) has the abstract [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier), you cannot create an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) of the class. An abstract class is intended to be used as a [superclass](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#superclass), where some [members](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member) are implemented or specified but not all. Also referred to as a base class.

abstraction
:   A programming principle where unnecessary details are hidden from a user where the user doesn't need to understand the hidden complexities. For example, you can put money in a vending machine and get a treat out without understanding how the mechanics function.

access level
:   The permissions needed to access a [member](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member). These are specified using an [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) on the member.

access specifier
:   Access [specifiers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) define the [access level](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#accesslevel). The following are all the access specifiers you can use with classes:

    1. **public**: Unrestricted access.
    2. **internal**: Access limited to current module. This is the default access.
    3. **protected**: Access limited to current class and any subclasses.
    4. **private**: Access limited to current class.

additive effect
:   An additive effect is an [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) that can be added to an [exclusive effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#exclusiveeffect). Additive effects include [`suspends`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#suspends) and [`decides`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#decides).

agent
:   An agent can represent either a player or a non-player character (NPC).

algorithm
:   An algorithm is a sequence of instructions written to solve a problem or accomplish a task. Think of it like a recipe for a dish. When you write code that solves a problem or accomplishes a task, that code is your algorithm.

alternate integers
:   See [hexadecimal](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#hexadecimal).

API
:   An acronym for Application Programming Interface, these are [libraries](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#standardlibrary) that are generally grouped into sets of [callable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function), [types](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type), and data structures that allow users to access and interact with Unreal and Fortnite systems.

archetype
:   An archetype is an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) of a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) that is fully defined with [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) for its [fields](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member) in a class.

archetype instantiation
:   The process of creating an [archetype](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#archetype). Compare to [constructor](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constructor), which can also run [logic](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#logic) or other [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function).

argument
:   The [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) assigned to a [parameter](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#parameter) in a [function signature](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functionsignature) mapped from a function call.

assignment expression
:   In Verse, an assignment [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) stores a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) at a [mutable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mutable) location, such as when [initializing](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize) a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) or changing the value of a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable).

async
:   An async expression has the possibility of taking time to evaluate, but doesn’t necessarily have to. An async expression may or may not complete in the current [simulation update](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#simulationupdate), or in a later one. Async functions that are identified with with a `suspends` specifier are also called [coroutines](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#coroutine). Async expressions contrast with [immediate](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#immediate) expressions.

async context
:   The [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope) for where an async expression such as a [coroutine](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#coroutine) [call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) is permitted.

atomic
:   A single, complete unit of code that either [executes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) completely or [fails](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#fail) completely, without interruption or observation from other code. Atomic code cannot be interrupted. All adjacent, immediate, [non-async](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async)[expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) are considered to be atomic — their code is guaranteed to run without interruption with the same update, and without [preemption](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#preemption) or [context switching](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#contextswitch).

base class
:   A class from which other classes are derived. A class that inherits from a base class has all members and member functions and can have additional properties that are not included in the base class. A base class is also known as a parent class or superclass.

base-16
:   Hexadecimal (from hexa-, meaning six, and decimal, meaning ten), base-16 (often shortened to hex), is a numbering system that uses 16 symbols, instead of the more familiar 10 symbols in base-10.

bidirectional
:   Functioning in two directions.

bind
:   In computer programming, to bind is to create a connection between two or more programming objects for a specified amount of time.

    For Fortnite, binding is associating a function with an event.

    For Verse, to bind is to create a connection between two or more programming [objects](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#object) for a specified amount of time.   For example, if you bind a function to a button's `InteractedWithEvent`, it means that each time a player interacts with that button, the bound function is [called](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#call). This can refer to the association of a [variable](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#variable) with a value or [object](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#object), or to the association of a [handler](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#eventhandler) with an [event](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#event).

block expression
:   A block expression is a way to group expressions as a single expression or to [nest](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#nested) a [code block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock). Block expressions behave in a way similar to code blocks.

body
:   A [block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock) with its own [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope) that defines the sub-expressions of a language element, such as a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) body or a [loop](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#loop) body. For example, a function body contains expressions that define what the function does, and any [variables](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable)[declared](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declare) in the function are [local](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#local) to that function body.

Boolean
:   See [Boolean logic](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#booleanlogic).

Boolean logic
:   A system of logic where the value expressed is either true or false, and which is often used to determine [flow control](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#controlflow) in programming languages. This is named after George Boole (1815–1864), a mathematician who was a key contributor to the fields of logic and algebra.

    In Verse, this is the [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) used to represent true and false is `logic`. This Boolean logic is carried out through [failable expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression) in [failure contexts](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failurecontext).

bound
:   1. For **UEFN**, see [bind](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#bind).
    2. For **Verse**, a variable that has had a [bind](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#bind) performed on it. All Verse [variables](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) are bound immediately after they are defined — they cannot be in an unbound state.

braces
:   See [brackets](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#brackets).

brackets
:   Brackets are used in Verse to specify different kinds of information in the code. Verse uses four sets of brackets. Their uses include but are not limited to:

    1. `()` Parentheses are used for setting parameters in a function signature and arguments in a function call, and for grouping expressions, tuples, and subclasses.
    2. `[]` Brackets (also called square brackets) are used for failable function calls, type specifiers for arrays and maps, and indexing into an array.
    3. `{}` Curly brackets (or curly braces) are used in archetype instantiation, code block formatting, and string interpolation.
    4. `<>` Angle brackets used to add specifiers to identifiers and functions.

branch expression
:   A `branch`[expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) starts a [block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock) of one or more [async](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async) subexpressions. Any expression that follows is [executed](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) immediately.

    For more information, see [Concurrency](https://dev.epicgames.com/documentation/en-us/uefn/time-flow-and-concurrency-in-verse).

break
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that "breaks out" of the current [`loop`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#loop) and [executes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) the next expression after the loop expression. For more info, see [Loop and Break](https://dev.epicgames.com/documentation/en-us/uefn/loop-and-break-in-verse).

bug
:   1. For **Fortnite Creative** and **UEFN**, an incorrect or unexpected behavior in a program.
    2. For **Verse**, a bug is an error in a computer program that causes it to produce an incorrect or unexpected result. Bugs occur during [runtime](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#runtime), as opposed to [compiler errors](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compilererror), which occur during Verse compile time. The process of identifying and removing bugs is called [debugging](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#debugging).

built-in
:   In some programming languages, something that is built-in is something you can use directly within the language and its [standard libraries](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#standardlibrary).

built-in type
:   A built-in [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) cannot be broken down further, unlike a [composite type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compositetype).

C++
:   A popular programming language used in many different applications — especially game engines such as Unreal Engine.

cache
:   A way to store data so that it can be accessed more quickly.

call graph
:   A list of the [methods](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) in a [call stack](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#callstack), with information about each [call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call), such as execution time, time stamps, and the [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) for the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function).

call stack
:   The call stack is what a program uses to keep track of calls — which functions are running, which have finished, and which are still to come.

caller
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that makes a [call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call).

canceled
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that makes a [call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call).

case expression
:   A case expression can control the flow of a program from a list of options. For more information, see [Case](https://dev.epicgames.com/documentation/en-us/uefn/case-in-verse).

Ceil
:   A [math operation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mathexpression) that rounds a [rational](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rational) [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) up to the closest [integer](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#integer). Compare to [`Floor`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#floor).

changelist
:   A way of tracking changes to a file in [Perforce](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#perforce) between local files that are stored on your computer and files that are submitted to the server and merged with the source files for the project. A changelist is also called a CL.

char
:   A data type that stores a single character.

character encoding
:   Character encoding is the mapping between a text character and data that the computer can understand, called a [code point](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codepoint).

CI/CD
:   CI/CD is continuous integration and either continuous delivery or continuous deployment. CI/CD bridges development and application through automation in building, testing and deployment of applications.

code
:   Code, sometimes called source code, is the instructions written by a programmer that tells a software program how to operate. Verse source code can be read by the programmer, but not by the computer. Before the computer can read or execute the program, it has to be converted to computer-executable instructions, called [compiling](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compile). When a programmer says they are coding, they mean they are writing these instructions.

code block
:   A block, or **code block**, is a group of [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that introduces a new [body](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#body) of code. You could also have a code block that contains zero expressions, but this is usually a placeholder that will be filled in with expressions at some later point.

    Code blocks come after an [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier).

    A code block has three possible formats in Verse. All of these formats are [semantically](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#semantics) the same in that the format does not change what the code actually does.

    A **spaced format** begins the block with `:`, and each expression follows on its own line with an indentation of four spaces:

    ```verse
    if (test-arg-block):
      expression1
      expression2
    ```

    Note that `if (test-arg-block)` is not part of the block, but the block starts at the end of that line with `:`. You can also use `;` to separate multiple expressions on a single line:

    ```verse
    if (test-arg-block):
      expression1; expression2; expression3
    ```

    In a **multi-line braced format**, the block is enclosed by `{}` (curly braces), and the expressions are on new lines:

    ```verse
    if (test-arg-block)
    {
      expression1
      expression2
    }
    ```

    As with the spaced format, you can also use `;` to separate multiple expressions on a single line.

    ```verse
    if (test-arg-block)
    {
      expression1; expression2
    }
    ```

    The third format is the **single-line braced format**. Again, the block is enclosed by `{}`, but each expression is separated by `;` instead of being placed on a new line. Note that you don't have to put the `{}` characters on separate lines.

    ```verse
    if (test-arg-block) {expression1; expression2}
    ```

    For more on this, see [Code Blocks](https://dev.epicgames.com/documentation/en-us/uefn/code-blocks-in-verse).

code comment
:   See [comment](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#comment).

code point
:   A value in the [Unicode](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#unicode) code space for [character encoding](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#characterencoding).

code sample
:   A standalone program, module, or class that demonstrates one or more concepts, classes, functions, or some other aspect of a programming language. Compare to [code snippet](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codesnippet).

code snippet
:   A snippet is some code, often short, that's usually meant to showcase or implement a specific concept.

    Code snippets are not full, standalone programs. Code snippets can be copy-pasted into [code blocks](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock). Compare to [code sample](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codesample).

code unit
:   The minimal bit combination that can represent a unit of encoded text. UTF-8 uses 8-bits for its code unit.

coercion
:   The conversion of a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) into different data [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type). Type conversions can be implicitly or explicitly made. Implicit conversion. also called coercion, is done automatically.

comment
:   A comment written by the programmer that explains something about the code or the programmer's reason for how something is programmed. While the code itself shows the *how* of the program, comments are usually added to explain the *why*.

    Code comments can appear anywhere in the code and begin with `#`. When the program runs, code comments are ignored.

    You can comment a **single line** by placing a `#` at the beginning of the line. The return at the end of the line terminates the comment.

    ```verse
    # A single line is commented this way.
    ```

    You can make a **multi-line block** comment by using `<#` to start the block, and `#>` to end it:

    ```verse
    <# You can make multi-line comments
    in your code by starting and ending 
    the comments as shown here.
    #>
    ```

    For other ways to add comments to your code, see the [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-quick-reference).

commit
:   A commit is when you record a set of changes in code to a [version control](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#versioncontrol) system.

     In Verse, a commit is when code effects of a [failable expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression) are made permanent after that expression succeeds.

common type
:   Common types are [types](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that are [built in](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#built-intype) and used frequently. Common types include [`any`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#any), [`comparable`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#comparable), [`float`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#float), [`int`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#int), [`logic`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#logic), [`rational`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rational), and [`string`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#string).

comparison expression
:   In Verse, comparison [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) are when you compare two things using one of the inequality [operators](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator): `<`, `>`, `<=`, `>=`, `<>`.

compile
:   To convert programs from a human-readable language into computer-executable instructions.

compile time
:   When source code is converted into machine instructions. Compare to [runtime](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#runtime).

compiler
:   Software that converts human-readable program instructions into computer-executable instructions, this is sometimes referred to as the **parser**. The time period when the compiler runs is known as [compile time](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compiletime).

compiler error
:   A **compiler error** is caused by incorrect code use detected by the Verse compiler at [compile time](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compiletime). Compare with [bugs](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#bug), which occur at [runtime](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#runtime).

completed
:   The state of a [task](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#task) that ran through to completion.

component
:   1. A  self-contained tile for rendering a piece of terrain. Sometimes components are called [cells](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#cell). Also see [World Partition](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#worldpartition).
    2. Components are what provide data and behavior to the [entities](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#entity) in [Scene Graph](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#scenegraph). Components define what an entity is supposed to be doing in the scene.

    Components have editable properties that can be physical, like a static mesh and particle system, or logical, like a gameplay tag or custom Verse code that defines the movement of a platform. By default, all entities have a transform component to specify where the entity exists in the world.

    In Verse, a function or group of related functions in a program that can be reused.

composite type
:   A composite data type, sometimes called **compound** or **aggregate**, is any [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that can be made up of fields or elements (usually named) of primitive types or other composite types. It usually has a fixed number of fields or elements for its lifespan. Verse currently uses the following composite types: struct, class, enum, interface, and module.

computes
:   This [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) indicates that a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) returns the same output when repeatedly presented with the same input.

concatenate
:   See [concatenation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#concatenation).

concatenation
:   Concatenation is when a [string](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#string) is appended(added) to another string. You can use the [operator](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) + to concatenate strings.

concrete class
:   A [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) with a concrete [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) is a way to construct an instance of the class with an empty [archetype](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#archetype), meaning that all fields for the class must be defined with an initial [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value).

concurrent
:   Multiple computations that [execute](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execution) in the same effective period of time are concurrent. This would be overlapping logical simulation updates, [ticks](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#tick), and frames, even if potentially spread over physical time, such as on a single processor, and not necessarily [parallel](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#parallel).

condition
:   A condition is something that the program can check is true or false. A conditional expression can evaluate the condition and return a result of true or false.

conditional
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that [evaluates](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#evaluate) a condition and [executes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) instructions based on the [result](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#result) of the condition. An example of a conditional is an [`if` expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#ifexpression).

constant
:   A constant is a location where a value is stored, and its value cannot change during the runtime of the program. It's called a **constant** because it constantly remains the same.

    Basic syntax for a constant is `name : type = value`. The `name` is a name you assign to the constant (known as the [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier)). The `:` says that a [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) is coming. The `=` says a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) is coming, then the value itself. For example:

    ```verse
    PlayerSpeed : float = 2.0
    ```

    This says that PlayerSpeed has a value of 2.0, represented as a decimal value that does not change while the program is running.

    [![](https://dev.epicgames.com/community/api/documentation/image/2c9779a5-7193-4e2d-8720-9def52f75dac?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/2c9779a5-7193-4e2d-8720-9def52f75dac?resizing_type=fit)

    Constants always have assigned values. The name and type is the [declaration](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declaration), and the [initialization](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize) is where that value is expressed.

    Compare to [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable).

    For more information, see [Constants and Variables](https://dev.epicgames.com/documentation/en-us/uefn/constants-and-variables-in-verse).

constrained
:   When an expression is constrained, it has set limits.

container
:   In UEFN, a container is a [class](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#class) that contains properties that can be applied to multiple objects.

    In Verse,  a container is a way of organizing data in code. See [container type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#containertype) for more info.

container type
:   You can store multiple values together by using a [container](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#container) type such as [array](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#array), [map](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#map), [tuple](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#tuple), and [option](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#option).

context
:   The code [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope) that defines the [lifetime](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#lifetime) of various language elements and constraints. This is usually the range between a [code block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock) begin and end.

context switch
:   A context switch is the process of storing the [state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state) of a process or [thread](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#thread) so that it can be restored and resume [execution](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execution) at a later point, then restoring a different, previously saved, state.

contract with the genie
:   Writing code is sometimes compared to *making a contract with the genie* in the sense that a program will follow your instructions exactly, even when the result is not exactly what you're expecting. Also see [program](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#program).

converges
:   The "smallest" [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) set. It's code that is guaranteed to yield a value in a finite amount of time without [diverging](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#diverge).

coroutine
:   A routine with a durational [lifespan](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#lifespan) that either performs work over time or waits for various events and [states](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state) to occur, or a combination of both. **Coroutine** is synonymous with [async function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async).

data
:   Generally, data refers to the [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) used in an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression).

data member
:   See [member](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member).

data type
:   See [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type).

debugger
:   A tool used for debugging, where you can see the program [state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state) at each execution step.

debugging
:   The process of identifying and resolving errors in your code.

decides
:   An [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) that indicates that the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) can [fail](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#fail), and that [calling](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) this function is a [failable expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression). Function [definitions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#definition) with the decides effect must also have the [transacts](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#transacts) effect, which means the actions performed by this function can be [rolled back](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback) as though the actions were never performed if there's a failure anywhere in the function.

decision expression
:   Decision expressions use the [operators](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) `not`, `and`, and `or` to give you control over the success and failure decision flow.

declaration
:   A declaration is an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) where an [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) is introduced, along with its [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type). It may or may not be implemented (used), and it may or may not have a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) assigned (initialized).

    `var name : type = expression` is the [syntax](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#syntax) for the declaration of a variable. For example:

    ```verse
    var PlayerSpeed : float = 2.0
    ```

    This line of code declares that a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) named PlayerSpeed has a [float](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#float) value.

    In this example, the last part, `= 2.0`, is the [initialization](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize), which is separate from the declaration.

declare
:   You declare a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) or a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) by specifying its [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) and [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type). Compare to [initialize](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize).

decorate
:   When writing code, to decorate means to wrap one piece of code with another.

define
:   See [definition](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#definition).

definition
:   A definition is when an [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) is implemented or has a value assigned, such as a function definition or a class definition. Compare to [declaration](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declaration).

dependency
:   Dependency is where a [module](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#module) depends on other modules for some functionality.

deterministic
:   A deterministic system is one where the same initial state or input will always produce the same results.

deterministic destruction
:   Deterministic destruction, found in some programming languages, is when [objects](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#object) are destroyed when a program exits their [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope).

developer
:   Someone who uses Fortnite tools to author (develop) an island in Fortnite, especially when using UEFN. This term includes Fortnite island developers, artists, and architects.

device
:   Devices are [objects](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#object) in Fortnite that perform specific tasks intended to control gameplay.

    A device, like a prop, is something you can place on your island. But devices are different from [props](https://dev.epicgames.com/documentation/en-us/fortnite-creative/fortnite-creative-glossary#prop) in that you use them to create player interactions. Different devices do different things, but they all do *something*.

    Think of a device as a package of game mechanics with specific features that can be customized to support your gameplay. Most devices can be customized, but all of them have default settings that determine how they behave even if you don't customize them.

    In Verse, a device is the basic building block used to construct game mechanics. A device drives player interactions that control gameplay.

digest
:   An automatically-generated listing of all [public symbols](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#publicmember), such as modules, functions, classes, that the Verse compiler has processed. It also includes [comments](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codecomment). You can read a digest file to see what [API](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#api) and functionality is in an associated [module](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#module).

dispatch
:   To dispatch is to send something somewhere. In Verse, this could be to dispatch a call to a function or dispatch an event to a listener, for example.

diverge
:   A program's [execution](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execution) is said to diverge if it does not terminate (end) as expected. If it does yield a value within a finite amount of time without diverging, it [converges](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#converges).

doc
:   A generic note field that you'll find on [classes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) and [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) (but not function parameters) that contains helpful information about what the element it describes does or how to use it, and is used to populate that element's page in the Verse [API](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#api) Reference.

domain
:   Domain is the set of inputs accepted by a particular parameter. A [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) is one way to specify a domain, but domain is more encompassing than type.

dynamic typing
:   In a dynamically-typed programming language, variables and expressions do not have assigned types. This means that it cannot be verified until runtime. Compare to [strongly-typed](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#strongly-typed).

editable
:   An [attribute](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#attribute) you can add to code to expose properties in UEFN. Tagging code with this attribute consists of adding an `@attribute_name` (in this case `@editable`) before a field [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier):

    ```verse
    @editable
    PropertyName : type = DefaultValue
    ```

    For example, the [string](https://dev.epicgames.com/documentation/en-us/uefn/string-in-verse) field `GreetingMessage` is an editable property with the default value `"Hello, stranger"`:

    ```verse
    expose_properties := class(creative_device):
      @editable
      GreetingMessage : string = "Hello, stranger"
    ```

    For more on how to use this, see [Customize Your Device Properties in the Editor](https://dev.epicgames.com/documentation/en-us/uefn/editable-properties-in-verse).

effect
:   An effect is a category of behavior that a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) can exhibit.

    In the example below, the code says that a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) is named `IsCriticalHealth` and takes an integer [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) as input through the `Health` [parameter](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#parameter). Next, it says that the effects the function exhibits are [`decides`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#decides) and [`transacts`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#transacts), which means the function is a [failure context](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failurecontext) and its actions can be [rolled back](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback) if the function fails. If the `Health` value that is passed as input to the function is greater than 0.0 and less than or equal to 30.0, then the function succeeds. Otherwise the function fails, and the context that called the function must handle the failure.

    ```verse
    IsCriticalHealth(Health : float)<decides><transacts> : void =
        ((Health > 0.0) && (Health <= 30.0))
    ```

    For more on this, see [Specifiers and Attributes](https://dev.epicgames.com/documentation/en-us/uefn/specifiers-and-attributes-in-verse).

effect hierarchy
:   An effect is a category of behavior that a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) can exhibit. The application of [exclusive effects](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#exclusiveeffect) to a function has a hierarchy, with effects higher in the hierarchy permitting at least all the behavior of effects below them. The hierarchy is:

    1. `transacts`
    2. `varies`
    3. `computes`
    4. `converges`

    The `transacts` effect will include properties for the effects below, the `varies` effect includes the `computes` and `converges` effects but not `transacts`, and so on.

element
:   A single part in a larger group. For example, an [array](https://dev.epicgames.com/documentation/en-us/fortnite/array-in-verse) can contain different elements that can be stored and used individually.

empty block
:   A [code block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock) that contains zero (no) [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) is an empty block. Empty blocks are generally used only as placeholders, and will be filled in later with code.

empty string
:   A [string](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#string) containing no characters `""` is called an empty string.

equality expression
:   In Verse, equality [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) are when you compare if two things are equal using the = [operator](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator).

escape character
:   The Verse escape character is the **backslash ( \ )**, which creates an escape sequence within a [string literal](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#string). This is used to alter control characters that would otherwise be interpreted differently. For example, if you're working with a [string](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#string) and want to include characters that have preset uses, such as { }, you need to include the escape character *""* before the character in the string. This would make `"\\{\\}"` render as {} in the text.

evaluate
:   To evaluate is to [execute](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) to produce a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value).

exclusive effect
:   A few [effects](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) are considered to be **exclusive effects** to which [additive effects](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#additiveeffect) can be added, but that cannot be used with other exclusive effects. Exclusive effects include `computes`, `varies`, and `transacts`. Additive effects include `suspends` and `decides`.

execute
:   To run a program.

execution
:   The process of a computer interpreting a program and performing the instructions from that program.

expose
:   A [property](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#property) is **exposed** in UEFN by assigning it the [`editable`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#editable) [attribute](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#attribute) in Verse code. This means you can edit the exposed property directly in the UEFN interface. Also see [editable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#editable).

expression
:   An expression is the smallest unit of code (a combination of [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) and [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function)) that has a [result](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#result) when evaluated.

    The example below is an `if ... else` expression, meaning that if the value meets a named criteria, it's one thing, but if not, then it's something else.

    ```verse
    if (a > 5):
      “Big!”
    else
      “Small!”
    ```

    In Verse, everything is an expression, from [literals](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#literal) to [function calls](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functioncall) or [control flow](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#controlflow).

    This compares to a [statement](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#statement), which is a standalone command that does not have a resulting value. In Verse, everything is an expression, and there is no distinction between statements and expressions that can evaluate to a value.

    For more in-depth info, see [Expressions](https://dev.epicgames.com/documentation/en-us/uefn/expressions-in-verse).

f
:   See [float](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#float).

fail
:   In Verse, any code the user writes cannot fail, by default. What this means is that instead of having a function that returns [Booleans](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#boolean) or options, it uses `<decides>` to either return a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value), [void](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#void), or fail.

failable expression
:   A failable expression is an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that can either succeed and produce a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value), or fail and return no value. Examples of failable expressions include [indexing](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#index) into an [array](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#array) because an invalid index will fail, and using [operators](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) such as comparing two [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value).

failure context
:   A failure context is a [context](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#context) where it is allowable to [execute](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that could [fail](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#fail). The context defines what happens if the expression fails.

field
:   See [member](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member).

final
:   A [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) that can only be used on [classes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) and [members](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member) of classes:

    - When a class has the final specifier, you cannot create a subclass of the class.
    - When a field has the final specifier, you cannot override the field in a subclass.
    - When a method has the final specifier, you cannot override the method in a subclass.

fire-and-forget
:   Fire-and-forget refers to an expression where you don't care when it completes, or whether it completes successfully. This is extremely rare.

floating point number
:   A term used in various programming languages to define a variable with a fractional value, or a number that contains a decimal point, such as 0.5, or 1.0. Numbers created using a float [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) [declaration](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declaration) will have digits on both sides of a decimal point.

Floor
:   A [math operation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mathexpression) that rounds a [rational](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rational) [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) down to the closest [integer](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#integer). Compare to [`Ceil`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#ceil).

for expression
:   A `for` [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression), sometimes called a **for loop**, is the same as a [loop](https://dev.epicgames.com/documentation/en-us/fortnite/loop) expression, except that `for` expressions are [constrained](https://dev.epicgames.com/documentation/en-us/fortnite/constrained), which means that the number of iterations is known before the `for` loop is executed, and decisions on when to exit the loop are automated. For more info, see [For](https://dev.epicgames.com/documentation/en-us/fortnite/for-expression).

frame
:   A frame is one fully rendered image (such as on a computer monitor or TV) representing a simulation at a given point in time. A frame is sometimes used synonymously with a [simulation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#simulation) update (or tick) since they are usually in step, though new frames can occur at a different rate (more or less frequently) than a simulation update. The frame rate, or fps (frames per second) for short, is the number of frames that appear per second.

function (code)
:   A **function** (also called a **routine**) is reusable code that provides instructions for performing an action, or creating an output based on input.

    To define a function, you must provide three key parts: a unique name, the type of information to expect as its [result](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#result), and what the function will do when [called](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#call).

    The following is the basic syntax for a function:

    ```verse
    name() : type =  codeblock
    ```

    - The name() and type separated by a colon: This is the [function signature](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-signature), which is how you call and use the function, and the [value](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#value) that must be returned by the function is of the type you provide. This format is similar to how you create constants, except for the () after the name, which mimics how you call the function in your code.
    - The function code block: You define what the function will do when it's called by providing `=codeblock`, where `codeblock` is any sequence of one or more expressions. Whenever you call the function, the expressions in the [code block](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#code-block) are executed.

    [![](https://dev.epicgames.com/community/api/documentation/image/12da3d55-3b25-49df-97f3-3162c3a5fba7?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/12da3d55-3b25-49df-97f3-3162c3a5fba7?resizing_type=fit)

function call
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that [evaluates](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#evaluate) (known as [calling](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) or invoking) a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function). Functional calls can have two forms, depending on whether the function has the [`decides`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#decides) effect: `FunctionName()` and `FunctionName[]`. The [result](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#result) type of the function call expression is defined in the [function signature](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functionsignature).

function signature
:   The function signature [declares](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declare) the function name ([identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier)), and the input ([parameters](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#parameter)) and output ([result](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#result)), of the function. Verse functions can also have [specifiers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) that specify how to use or implement a function.

functional logic programming
:   The combination of [functional](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functionalprogramming) and [logic programming](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#logicprogramming) [paradigms](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#paradigm) into a single language.

functional programming
:   A type of [declarative programming](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declarativeprogramming) that focuses on the use of [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function). Functional programming aims to make testing and debugging easier by reducing [side effects](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#sideeffect). Haskell is an example of a functional programming language.

future
:   A task that has started to execute but has suspended without canceling. It is future because it will complete at some point in the future.

game loop
:   A game loop is code that runs repeatedly ([loops](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#loop)) to respond to input — usually the player interacting with their controller or mouse — to update [game state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#gamestate), and provide output that shows the player they affected the game state, like when they push a button that turns on a light. The loop usually ends when the game reaches a [completion state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#completed), such as the player reaching a goal, or [failure state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failure), such as the player running out of time before making the goal."

game state
:   The [state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state) of a game or other [simulation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#simulation). It's made up of all data [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) that describe a system. [Constant](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constant) and [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) values determine the system state.

gameboard
:   The surface on which a game is played. Traditionally, the term gameboard has applied to tabletop games. However, it is becoming more common to use it to describe video game levels. In video game development, gameboard levels can be split into different areas or zones, with different shapes, arrangements or terrains. As with tabletop gameboards, players can move characters or objects around the board (level) to progress through the game.

generator
:   A generator produces a sequence of [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value), one at a time, and gives the value in the sequence a name.

group
:   The action of enclosing an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) in `()`. This explicitly specifies the [order of evaluation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#orderofevaluation). Grouping can also improve code readability.

handler
:   A handler is the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) that is called to respond to a [bound](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#bind) event. For example, if you bind a function to a button's InteractedWithEvent, then each time a player interacts with that button, the handler associated with that event is called.

hard-coded
:   Hard-coded data is written directly into code instead of assigning the data to a variable. This usually makes code less flexible and harder to update, but there are instances where it makes sense to do this.

head node

hexadecimal
:   In Verse, you can use the hexadecimal ([base-16](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#base-16)) numeral system to represent integers, instead of the decimal numeral system that uses base-10. This means that hexadecimal values are represented with the digits 0–9 and the letters A–F. For example, 0x7F is the same as 127, and 0xFACE is the same as 64206.

    This is an alternate way of representing [integers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#integer).

hierarchical
:   Having clear levels or hierarchies of rank, importance, or control. Common hierarchical relationships are parent/child or superclass/subclass.

IDE
:   An integrated development environment (IDE) is a software that provides a user interface for creating and debugging programs.

identifier
:   An identifier is the name given to things in a program, such as [variables](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) or [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function), to uniquely identify them.

if expression
:   With the `if` [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression), you can make decisions that change the [flow](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#controlflow) of the program. As with other programming languages, the Verse `if` expression supports conditional execution, but in Verse, the conditions use success and [failure](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failure) to drive the decision.

immediate
:   An **immediate** [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) evaluates with no delay, meaning that the [evaluation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#evaluate) will complete within the current [simulation update](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#simulationupdate).

immutable
:   After an object has been created, its [state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state) cannot be modified. Compare to [mutable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mutable).

imperative programming
:   A [paradigm](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#paradigm) where the program explicitly describes how a program executes, step by step. C is an example of an imperative programming language.

index
:   An index represents the positions of items in a sequence by numerical representation. A sequence can be a list, a string of characters, or any arbitrary sequence of [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value).

    Indexes use [zero-based counting](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#zero-basednumbering). This means that the first position in the index is 0, and the fifth position would be 4.

infer
:   There are instances where you don't need to explicitly specify the type, such as when creating a constant. For example, in `MyConstant := 0`, the type for MyConstant is inferred to be int because an integer value is assigned to it. In instances like this, the type is inferred.

infinite loop
:   A loop block that will repeat forever. Also see [loop](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#loop) and [break](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#break).

infinite recursion
:   Infinte recursion happens when a function calls itself directly or indirectly, resulting in the function attempting to call itself forever and never terminating. This results in the program hanging.

infix
:   A format for an [operator](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) where there are two [operands](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operand) and the operator is between the operands.

inheritance
:   In Verse, you can create a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) that extends another class's definition by adding or modifying the fields and methods of the other class. This is often called subclassing or **inheritance**, because one class inherits definitions from the other class.

initialize
:   To create a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable), specify its [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) and [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type), which is called [declaring a variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declare), and assign a value to the variable, which is called **initializing**.

instance
:   Think of an instance as a unique copy of an [asset](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#asset). The original asset determines the default properties of any new instance you create. Changes you make to the properties for an instance don't affect the original asset. For example, you can change a [material](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#material) to have a different appearance without changing the master material. This would be a material instance.

    In Verse, an instance is to create a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable), specify its [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) and [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type), which is called [declaring a variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declare), and assign a value to the variable, which is called **initializing**.

instantiate
:   To create an instance of something.

    In Verse, instantiate is to to create an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) or value of a data structure or type such as a class or structure. Also see [archetype instantiation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#archetypeinstantiation).

integer
:   An integer is a whole number (not a fractional number) that can be positive, negative, or zero.

integer overflow
:   An integer overflow happens when an attempt is made to store a value that is too large for the values defined for the integer type.

internal class
:   A class that's marked `epic_internal`, which means that you cannot create your own instance of the class. You can only use the APIs to access an internal object.

interpolation
:   The blending of new values that lie between known values.

interpreter
:   A program that analyzes and executes a program line by line.

invocation time
:   The time it takes for an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) to be [evaluated](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#evaluate). An immediate [invocation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) takes what is effectively no time. An [async](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async) expression may complete immediately, or may be latent.

invoke
:   See [call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call).

is-a relationship
:   The relationship between a parent class and a child class is called an **"is-a" relationship**. The child class in an is-a relationship [inherits](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#inheritance) from the parent class.

iterate
:   To run code for each element in a sequence.

key-value pair
:   When a key is associated with a value, together they are a key-value pair. You can look up the value by using the key.

keyword
:   Keywords are reserved words that have a special meaning to the [compiler](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compiler). Examples of keywords are [`for`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#forexpression) and [`class`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class). Keywords cannot be used as [identifiers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier).

lifespan
:   See [lifetime](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#lifetime).

lifetime
:   The time between an object's creation and its destruction. Synonymous with lifespan.

linked list
:   A linear data structure where each element stores a reference to the next element in the list.

linked list node
:   Each element in a linked list is called a node. A node is a container that holds some data and a reference to the next node in the list.

literal
:   A fixed value in the Verse programming language, such as a number or a character. For example, 1 is an [integer](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#integer) literal.

local
:   Refers to a [constant](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constant) or [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) inside of a [code block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock). These can't be used outside of the code block where they were created. Also see [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope).

locale
:   In programming, a **locale** is a set of parameters that defines a user's language, region, and other aspects of the user interface. In Verse, `locale` specifically is a type that sets a context for when [`message`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#message) should be localized, and affects the language for text and numbers based on locale.

logic programming
:   A programming [paradigm](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#paradigm) that uses [Boolean logic](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#booleanlogic) to control how facts and rules about the problems within the system are represented or expressed.

loose property

math expression
:   In Verse, a math [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) is an expression that uses one of the following [operators](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator): `+`, `-`, `*` or `/`.

member
:   A named [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) or [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) that is a sub-part of a [composite data structure](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compositetype) (such as a Verse class, structure, interface or module). Member variables are often referred to as **fields**, and member functions as [**methods**](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method).

message
:   A `message` in Verse is a [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that can contain [locale](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#locale)-independent text. When you initialize a `message` [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) with a [`string`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#string) [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value), that string is the default text and language for the message.

metaverse environment
:   A persistent and globally consistent, real-time, 3D world with a runtime environment that executes concurrent, complex, interdependent user-written code with millions of simultaneously connected users.

method
:   A method is a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) attached to a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) and can only be called on an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) of that class.

module
:   A Verse **module** is an atomic unit of code that can be redistributed and depended upon, and can evolve over time without breaking [dependencies](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#dependency). You can import a module into your Verse file to use code definitions from other Verse files.

    For more info, see [Modules and Paths](https://dev.epicgames.com/documentation/en-us/uefn/modules-and-paths-in-verse).

mutable
:   This refers to an object state that can still be modified after creation. In Verse, mutability is only possible with [pointers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#pointer).

    Compare to [immutable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#immutable).

mutex
:   A mutex is a synchronization [primitive](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#primitivetype) that grants exclusive access to a shared resource using only one [thread](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#thread). Also see [mutual exclusion](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mutualexclusion).

mutual exclusion
:   When more than one process accesses the same segment of code, that segment is called the **critical section**. Mutual exclusion is a way to ensure that no two processes can access a critical section at the same time.

NaN
:   A value that represents Not a Number.

native
:   `native` indicates that the definition details of an element are implemented in [C++](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#c++). This [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) can auto-generate C++ definitions that a developer can then use. The `native` specifier is used on [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class), [interface](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#interface), [enum](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#enum), [method](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method), and [data](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#data).

native\_callable
:   Indicates that an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) [method](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) is both [native](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#native) (implemented in C++) and can be called by other C++ code. You can see this [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) used on an instance method. This specifier doesn't propagate to [subclasses](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#subclass), so you don't need to add it to a definition when overriding a method that has this specifier

nested
:   When code is nested, one block of code is contained within another block of code that performs a broader function.

no-rollback
:   This [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) indicates that a function's [mutable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mutable) data reads and writes cannot be undone, meaning the function cannot be invoked in a failure context (which has [rollback](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback) behavior in the event of failure).

node
:   In **UEFN**, a node is a fundamental unit within a graph-based system that represents a specific function, operation, or data point. In the context of node graphs, a node is an individual component that processes or routes audio signals, such as a sound source, effect (like reverb or delay), mixer, or output.

    For **Verse**, see [linked list node](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#linkedlistnode).

object
:   In UEFN, an object is another word for [asset](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#asset).

    In Verse, an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) of a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) is an object. An instance has the same behaviors defined by its class [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) but with real [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value).

    The terms **instance** and **object** are synonymous.

object-oriented programming
:   Object-oriented programming (OOP) is a programming paradigm that relies on the concept of classes and objects.

open world language
:   A language in which interdependent modules written by many different users and organizations can evolve over time without breaking interface compatibility and persistent data compatibility by following clearly-defined subtyping rules.

operand
:   The quantity on which an [operation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) is done. For example, in the expression `1 + 2`, the `+` is an operator, and `1` and `2` are both operands.

operation
:   An action carried out by a program to accomplish a specific task. There are four basic groups of computer operation: input, process, output, and storage. An operation is a type of [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression).

operator
:   A symbol that represents an action or process. For example, in `1 + 2`, the `+` is the operator.

operator precedence
:   This refers to the built-in [order of evaluation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#orderofevaluation) when combining [operators](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) in Verse. For example, if several operators are used in the same [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression), the order in which they are evaluated matters.

    For example, `1 + 2 * 3` does not [evaluate](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#evaluate) to `3 * 3` since multiplication takes precedence over addition.

    [Operator precedence](https://dev.epicgames.com/documentation/en-us/uefn/operators-in-verse) can be overridden by [grouping](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#group) expressions.

order of evaluation
:   Refers to the [operator precedence](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operatorprecedence) — the order in which certain [operations](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operation) should be performed in an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression).

overload
:   Overloading a function or operator means the same function name or operator symbol can have different parameters. For example, if you say a 3D vector equals another 3D vector, like (1,2,3), that's pretty clear. But you could use the equals operator to say your 3D vector equals a single number, like 1. In that case, maybe the 3D Vector gets set to (1,1,1), but the overloading part is that there are multiple "3D Vector =" operators with different parameters. The language would have to look at the context to see which one to use.

override
:   In Verse, you can **override** fields from a [superclass](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#superclass) and assign initial [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value). For example:

    ```verse
    tank := class(player_character):
      StartingShields<override> : int = 100
      MaxShields<override> : int = 200
      AllowOvershield<override> : logic = true
      DamageReduction : int = 50
     
    CreateTankPlayerCharacter() : tank =
      return tank{}
    ```

    The tank class will have values for `StartingShields`, `MaxShields`, and `AllowOvershield` that are different from the default class values.

    You can also override [method](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) values the same way.

    For more on this, see [subclass](https://dev.epicgames.com/documentation/en-us/uefn/subclass-in-verse).

paradigm
:   A typical pattern or model for something. In programming, a paradigm is a way that a programming language is organized. There are four major paradigms for programming languages:

    1. Imperative
    2. Logic
    3. Functional
    4. Object-oriented

    There are also multi-paradigm languages, like Verse.

parallel
:   Multiple computations that execute in the same physical time period, such as on separate processors, are parallel.

parameter
:   An input [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) that includes a a [domain](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#domain) such as a [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type), and an optional default [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) that's defined in a [function signature](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functionsignature), which is then used in the [body](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#body) of the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function). Compare to [argument](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#argument).

parametric type
:   A [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that can take a [parameter](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#parameter).

parse
:   To parse, in computer science, is where a string of commands — usually a program — is separated into more easily processed components, which are analyzed for correct syntax then attached to tags that define each component.

parser
:   A program for [parsing](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#parse) code.

path
:   Verse paths provide a global namespace for identifying things, and borrow from the idea of web domains. These paths are persistent, unique, and discoverable by any Verse programmer.

Perforce
:   Perforce (P4) is a software tool that provides **revision control** (also known as source code control or version control), which is a way to track and manage changes to software code. This is useful when you have teams of programmers working on the same project. If someone makes a mistake, version control makes it possible to compare earlier versions of the code to find and correct the problem without interrupting everyone else’s work.

persistence
:   When player data is saved from a session and reloaded into the next session for that game, this is called persistence.

ping pong
:   To reverse direction back and forth.

PingPong animation mode
:   To reverse the direction of an animation when the final keyframe is reached, and to play again in the opposite direction.

playspace
:   A Verse [API](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#api) [module](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#module) that you can use to get an [array](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#array) of players or teams, or the team for a particular player. It also lets you [subscribe](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#subscribe) to player-added and player-removed [events](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#event).

pointer
:   A pointer is a way to reference a [mutable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mutable) "box" that can hold a specified value [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type). With a pointer, you can change the specific value in that box. Compare to [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value).

pointer variable
:   A pointer [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) points to a memory location where a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) is stored. After you create a pointer variable, you can’t change the memory location of the pointer variable, but you can change the value stored at that memory location.

polling
:   Polling refers to actively sampling the status of an external device by a client program as a synchronous activity. Polling is most often used in terms of input/output (I/O), and is also referred to as polled I/O or software-driven I/O.

polymorphic
:   **Polymorphic** comes from **poly-**, meaning many, and **-morph**, meaning form. Polymorphic behavior occurs when a variable can have different values under different conditions.

postfix
:   A format for an [operator](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) where there is only one [operand](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operand) and the operator is after the operand.

precedence
:   The order in which certain [operations](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operation) need to be performed in an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression).

predicate
:   In Verse, a predicate is something that either succeeds or [fails](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#fail).

preemption
:   Temporarily interrupting an executing task with the intention of resuming it at a later time is called **preemption**. This is usually done by an external scheduler with no assistance or cooperation from the task.

prefix
:   A format for an [operator](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) where there is only one [operand](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operand) and the operator is before the operand.

primitive type
:   A primitive is any [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that is not created from other types. This means that a primitive is not a composite, and cannot be broken down further. Examples of built-in primitive types include `void`, `logic`, `int`, `float`, `rational`, and `char`. Primitives are built into the Verse language.

    Compare to [container type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#containertype).

program
:   A program is a set of instructions that tells the computer how to do something. The basics of any program are showing how the computer will receive input and return output.

    A program solves problems. But programs are very literal. It's like making a contract with a genie. The genie (the program) will give you exactly what you ask for. Exactly. Errors occur when the programmer makes assumptions about what should happen instead of precisely describing what input can be received and what output will result.

programming
:   The act of writing instructions (a program) that can be [compiled](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compile) and [executed](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) by the computer.

programming language
:   A formal language used to write computer programs. There are lots of programming languages, and each has its own exact rules. Examples would be Scratch, a visual programming language used for developing interactive stories, games and animations, or C++, a text-based language that is frequently used in game development. Verse is a programming language developed by Epic Games for creators who want to learn more about using development tools.

propagate
:   Propagate in a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) is what occurs if the [caller](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#caller) doesn't have to handle what happens in the case of [failure](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failure). For example, a function with a [`decides` effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) could be called from another function with a `decides` effect. Whatever called the caller would then have to handle the failure.

property
:   A property is a [member](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member)(field) that makes it possible to return [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) and expose those values.

pseudocode
:   Pseudocode (pronounced SOO-doh-kohd) is a detailed description in plain language (not programming language) of what an algorithm should do. *Pseudo-* means not true or real, so you could say that pseudocode is fake code, but it's useful for working out what an algorithm should accomplish.

    You can also think of pseudocode as a high-level outline. Pseudocode is usually written to plan out a large or complex part of a program before writing real code.

public member
:   A [member](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#member) that is visible to other [modules](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#module).

pure
:   Declares that a function will always give the exact same output given the same input, and has no side effects (writes to mutable variables, IO effects, and so on).

qualify
:   To define an [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) within a [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope) that allows the identifier to be "reused". For example, you could have a [constant](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constant) that is named "cat." You could use the same name for a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) field named "sarah.cat". Both include "cat" in the name, but "sarah.cat" has been qualified.

query
:   Query [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) use the [operator](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#operator) `?` to check if a logic or optional value is `true`.

race condition
:   A race condition is when a program attempts to perform two or more operations at the same time for operations that must be done in sequence to be done correctly.

RAII
:   An acronym for **resource acquision is initialization**, RAII describes when an [object](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#object) acquires resources between [initialization](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize) and finalization only, as a way to manage resources more effectively.

raise
:   When a [function](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#function) emits a signal, it raises an event. Interested parties are notified that an event occurred, such as interacting with a button, and all the [event handlers](https://dev.epicgames.com/documentation/en-us/uefn/unreal-editor-for-fortnite-glossary#eventhandler) are called.

range expression
:   Range [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) contain all the numbers between and including two specified values, with `..` between the values; for example, `1..5`. Range expressions can only be used in specific places, such as in `for` expressions.

rational number
:   A number that can be expressed as a simple fraction using two [integers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#integer). For example, 1.75 can also be expressed as 7/4, but the square root of 2 (√2) cannot be expressed as a fraction, and so is considered an irrational number. Another example of an irrational number is Pi, which starts as 3.14159... and continues infinitely.

raycasting
:   Raycasting draws an invisible line in space from an object to find out if anything collides with it.

recursion
:   Recursion is when a function [calls](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) itself.

refactor
:   To change the structure of code without changing its functionality. For example, a block of code that is repeated multiple times throughout a program could be refactored into a [function call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#functioncall) instead. Refactoring can increase code readability and reduce code complexity without changing the way the code behaves.

REPL
:   Read-Evaluate-Print Loop, or REPL, is a computer environment where you can input code and have it read and evaluated, then see the results. A REPL gives you a chance to explore a language and see what works (or fails to work) without breaking anything.

result
:   When an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) executes, then outputs a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) , that value is a result.

return
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that instructs a program to leave a subroutine and go back to the return address. The return address is where the subroutine was called from.

    Instead of relying on the last expression in a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) [code block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock) to produce the right [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value), you can also explicitly specify the [result](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#result) using a `return` expression. When the return expression is executed, it will exit out of the function's code block immediately. This means if you place the return expression before other code, the code that follows won't execute.

rollback
:   To restore a program to a previously defined [state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state), usually to recover from a [failed expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression).

routine
:   See [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function).

runtime
:   Refers to the time spent running the game, simulation, or application. Compare to [compile](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compile) time, which refers to the time spent compiling, or development time, which refers to the time spent developing, compiling, and debugging.

    It's common to differentiate between things that happen at runtime and things that happen at compile time.

scope
:   **Scope** refers to the part of the program where the association of a name to a [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) is valid, and where that name can be used to refer to the value. For example, any constants or variables that you create within a function only exist in the context of the function. This means that the [lifetime](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#lifetime) of objects is limited to the scope they’re created in and cannot be used outside of that code block.

script
:   A self-contained amount of [executable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) Verse [code](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#code) that is associated with an [object](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#object).

self variable
:   `Self` is a special [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) in Verse that can be used in a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) [method](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) to refer to the [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) of the class that the method was [called](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) on. You can refer to other fields of the instance the method was called on without using `Self`, but if you need to refer to the instance as a whole, you must use `Self`.

semantic analysis
:   Also known as context sensitive analysis. The semantic analysis runs in the compiler after it gathers the necessary semantic information from the source code (the code you wrote). It checks the consistency of your code for semantic errors and performs type checking such as ensuring each operator has an operand, or making sure a variable is declared before use.

semantic error
:   See [compiler error](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compilererror).

semantics
:   The meaning of an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression). Compare to [syntax](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#syntax).

semaphore
:   A semaphore is like a [mutex](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#mutex) except that while a mutex locks other [threads](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#thread) out of available resources, a semaphore only signals that the resource is in use.

sequential execution
:   Code is generally [executed](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) line by line, in the order the [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) appear. This is called sequential execution.

serialization
:   The process of reading or writing data to or from the save file. A [loose property](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#looseproperty) gets created with the same file being read has a property that the class/struct doesn't.

set
:   A [keyword](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#keyword) that can be used to change the value of a [variable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#variable) while the program is running.

    The syntax for this is `set name = value`. The `set` is the keyword, `name` is the name of the variable to be changed, and the `value` is what it should be changed to.

    [![](https://dev.epicgames.com/community/api/documentation/image/68a48c4c-ec21-4e62-ba5e-9b2ff902199f?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/68a48c4c-ec21-4e62-ba5e-9b2ff902199f?resizing_type=fit)

    This is called [assignment](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#assignmentexpression).

shadowing
:   Shadowing is when an [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier) hides another identifier. Shadowing is an error in Verse, and will prevent the code from [compiling](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compile).

side effect
:   A side effect occurs when some code, such as a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) or an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression), modifies some [state](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#state) outside of its [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope).

signed integer
:   A signed integer is a value that can hold a negative or positive number, or zero. It's called a signed integer because it can use a + or - sign on the far left to indicate whether the number is positive or negative. An unsigned integer can only be a positive number or zero.

simulation update
:   A recurring round, step or increment of logic, behavior and other calculations for a simulation. It is often shortened to **update** or used synonymously with **tick** or [**frame**](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#frame). A simulation update generally has an elapsed time that can be constant or varied. This is often referred to as **delta time**, which may or may not coincide with the actual passage of time. For example, a simulation update can be faster, the same as, or slower than real time.

    A simulation update often tends to be in 1:1 step with rendering a frame — this is the default for Verse. However, a simulation update may be less or more frequent than a frame, such as when an online game client goes out of sync with the server or the physics systems while doing several iterations of the changes of a simulated object. It is also possible that a simulation would not be visually rendered at all.

snippet
:   See [code snippet](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codesnippet).

spawn expression
:   A `spawn` [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) starts an [async](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async) [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function). Any expression that follows the spawn [executes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute) immediately without waiting for the `spawn` expression to complete. The `spawn` continues independently until it completes.

specifier
:   A specifier applies additional information to a [definition](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#definition). For example, the `decides` effect specifier on a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) definition marks the function as [failable](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression).

    Specifiers fall into one of two subcategories: [access specifiers](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#accessspecifier) and [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) specifiers.

speculative execution
:   Verse takes advantage of [failure context](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failurecontext) to let you try out actions without committing them. This is called **speculative execution**. When an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) succeeds, the effect of the expression is committed, such as changing the value of a variable. If the expression fails, the effects of the expression are [rolled back](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback), as though the expression never happened.

splat
:   When a [tuple](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#tuple) is used as a single element to a function, it will be as though that function were called with each of the tuple's elements separately. This is called tuple expansion or splatting.

standard library
:   A series of [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function), [constants](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constant), and other language definitions available in Verse. This library provides implementations for common programming needs. It's a resource for things programmers will use frequently, like math functions.

state
:   A state is the combination of original [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) in an [object](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#object) plus any modifications made.

statement
:   A standalone command that does not have a resulting value. Verse does not use statements. Instead, it uses [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression).

static checking
:   An automated check during [compilation](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compile) that can catch a bug based on the [semantics](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#semantics) of the code.

STM
:   Software transactional memory (STM) is a concurrency control mechanism analogous to database transactions for controlling access to shared memory in concurrent programming. Eventually, Verse will feature STM because it unlocks performance gains for large distributed simulations, among other motivations.

strongly-typed
:   A programming language is strongly typed when a [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) is assigned to every [identifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#identifier). When the type is not explicitly provided, it is inferred. This means that the language won't produce unpredictable results during runtime because the type for those identifiers and how operations affect those types are known. Also see [static checking](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#staticchecking).

structured concurrency
:   Structured concurrency describes [concurrent](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#concurrent) operations within a [lifespan](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#lifespan) that's constrained to a specific concurrent command and [async](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async) context scope. This is a structured [flow control](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#controlflow) like `if`, `for` or `return` that constrains to an associated [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope).

    In Verse, structured concurrency expressions include [`sync`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#sync), [`race`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#race), [`rush`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rush), and [`branch`](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#branchexpression).

subexpression
:   An [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that's [nested](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#nested) inside a [code block](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock).

submodule
:   A Verse [module](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#module) within another Verse module. You can think of it like folders and subfolders — each submodule adds another /NameOfModule to the path as it goes further down.

subroutine
:   A set of instructions within a computer program designed to perform a frequently used operation. Subroutines are similar to [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function), except that a function performs some calculations and returns the result to the [caller](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call). Subroutines do their job without reporting back to the calling program.

subscribe
:   Subscribing is a way to specify the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) you want to [call](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#call) when an [event](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#event) is [raised](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#raise). This is referred as **binding to an event**. The [bound](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#bind) function is referred to as a [handler](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#handler).

subtype
:   A [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that supports all the operations of its [supertype](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#supertype). The `subtype` [keyword](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#keyword) can be used with [parentheses](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#brackets) to specify that a type is constrained to a certain type. For example, several Verse [array](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#array) [methods](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) use `subtype` to define that all elements of the array must have the supertype comparable for the method to work.

    ```verse
    (Input:[]t where t:subtype(comparable)).RemoveFirstElement<public>
    (ElementToRemove:t)<computes><decides>:[]t
    RemoveFirstElement
    ```

    This needs the array elements to have a supertype of `comparable` so that it can determine if any of the elements in the array are equal to the `ElementToRemove` argument.

succeed
:   When an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) completes without failing, it succeeds. Compare to [failure context](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failurecontext).

superclass
:   [Classes](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) can [inherit](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#inheritance) from a **superclass**, which includes all [fields](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#method) of the superclass in the inheriting class. Such classes are said to be a [subclass](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#subclass) of the superclass.

supertype
:   A supertype is a [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) that has at least one [subtype](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#subtype). Any operations that a supertype supports must also be supported by any subtypes. In Verse, `any` is the supertype over all other types, and all other types are subtypes to `any`. The `comparable` type is a supertype of all types that are comparable in Verse such as `int` and `float`.

suspends
:   An [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) that temporarily stops (suspends) a function without cancelling it. A `suspends` [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) allows [async](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#async) [functions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) to suspend and cooperatively transfer control to other concurrent expressions before it completes.

    For more information, see [Concurrency](https://dev.epicgames.com/documentation/en-us/uefn/time-flow-and-concurrency-in-verse).

syntax
:   The rules or grammar of the programming language.

    Compare to [semantics](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#semantics).

syntax error
:   See [compiler error](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compilererror).

tail node
:   The first [node](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#linkedlistnode) in a [linked list](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#linkedlist) is called the head node, and the last node is called the tail node.

thread
:   The smallest unit of processing that can be performed in an operating system.

tick
:   See [simulation update](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#simulationupdate) which is used synonymously with tick, and, occasionally, [frame](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#frame).

tile
:   1. A section of a grid on a surface such as a floor or wall.
    2. A way of organizing menu options visually.

    For **Verse**:  A section of a grid on a surface such as a floor or wall.

time flow
:   A section of a grid on a surface such as a floor or wall.

    Time-flow control is at the heart of Verse programming language, and is accomplished with [concurrent](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#concurrent) [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression).

    Time flow is a type of flow control, but where [control flow](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#controlflow) is about the order in which a computer executes instructions based on the order of expressions in the program, time flow controls the execution in time, not sequence, based on how concurrency expressions are used.

    Time flow is another way of saying concurrency.

top-level expression
:   A top-level expression is an [expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) that is not nested inside a code block. Top-level expressions can also be compound expressions, such as [nested](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#nested) [code blocks](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#codeblock).

transacts
:   When a [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) has the `transacts` [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect), it means the function can read and write data, but those actions can be [rolled back](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#rollback) if the function also has the [decides](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#decides) effect. This effect is an [exclusive effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#exclusiveeffect).

    A function with no exclusive effect specified, can read and write data, but cannot be rolled back.

type
:   Type defines which operations can be performed on data, and how that data, or values, are stored for that type. There are [common types](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#commontype), such as integer and string, [composite types](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#compositetype), and custom types. Also see [primitive type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#primitivetype) and [container type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#containertype). The `type` [keyword](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#keyword) can be used with [curly braces](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#brackets) to define an expected type. Function [declarations](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declaration) and numeric ranges are currently supported as declarations. For example, the `Subscribe()` function for the `subscribable` interface uses the `type` keyword to define that its `Callback` parameter must be a function with a `void` return type.

    ```verse
    Subscribe<public>(Callback:type {__(:t):void})<transacts>:cancelable
    ```

type alias
:   A type alias is a way to make a new name for an existing [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type). When you [declare](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declare) a type alias, you can then use the aliased name instead of the existing type. A type alias does not create a new type, but only provides a new name for an existing type.

type casting
:   You can convert a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) to one of its subclasses (called **type casting**) by using the syntax `NewReference := type_to_cast_to[Reference]`, where `type_to_cast_to` is the type you want to use. This is a [failable expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#failableexpression) because the type conversion will fail if the [object](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#object) can’t be converted to that [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) — for example, if the class is a different type from the subclass.

    The following example shows how to convert `TaggedDevice`, which has the type `creative_device_base`, to a `customizable_light_device` type so you can use its specific functions. If the `TaggedDevice` isn't a Customizable Light device, then it won't call `TurnOn()`.

    ```verse
    if (LightDevice := customizable_light_device[TaggedDevice]):
      LightDevice.TurnOn()
    ```

type checker
:   Type checking is used to check a program before [execution](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execution). This verifies data type [values](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) and [syntax](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#syntax). The main purpose of a [type](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#type) system in a programming language is to reduce the likelihood of bugs in a program due to type errors.

Unicode
:   A character-encoding standard developed by the [Unicode Consortium](http://www.unicode.org/consortium/consort.html) to provide comparable support for characters across languages, platforms, and devices.

unique
:   The unique [specifier](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#specifier) can be applied to a [class](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#class) to make it a unique class. To construct an [instance](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#instance) of a unique class, Verse allocates a unique identity for the resulting instance. This allows instances of unique classes to be compared for equality by comparing their identities. Classes without the unique specifier don't have any such identity, and so can only be compared for equality based on the values of their fields. This means that unique classes can be compared with the = and <> operators, and are subtypes of the comparable type.

unset
:   No [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) is assigned. Compare to [set](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#set).

unstructured concurrency
:   Concurrent [expressions](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#expression) with a [lifespan](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#lifetime) that is not logically constrained to a specific [concurrent](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#concurrent) command or [async context](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#asynccontext) [scope](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#scope). This lifespan potentially extends beyond the scope where it was [executed](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#execute). It is similar to unstructured flow control, such as the `goto` or `assembly jump` command.

UTF-8
:   The [Unicode](https://www.unicode.org/versions/Unicode14.0.0/) character-encoding scheme — a standard developed by the [Unicode Consortium](http://www.unicode.org/consortium/consort.html) to provide comparable support for characters across languages, platforms, and devices.

    [Emojis](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#emoji) look like images or icons, but they are not. They are letters (characters) from the UTF-8 (Unicode) character set.

    UTF-8 covers almost all of the characters and symbols in the world.

value
:   A value is the information your program uses to operate. Examples of values are numbers or text.

variable (code)
:   A [value](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#value) that can be changed while a program is running. It's called a variable because it can vary.

    Sometimes the term "variable" refers to variables and [constants](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constant) collectively, but while variables and constants are similar, they have one important difference — the value of a constant cannot be changed while a program is running.

    Basic syntax for a variable is `var name : type = value`. The `var`is a [keyword](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#keyword) that says this is a variable, and `name` is a name you assign to the variable (known as the identifier). The `:` says that a type is coming. The `=` says a value is coming, then the value itself. For example:

    ```verse
    PlayerSpeed : float = 2.0
    ```

    This says that PlayerSpeed has a value of 2.0, represented as a decimal value that does not change while the program is running.

    [![](https://dev.epicgames.com/community/api/documentation/image/292c0941-aacf-4bce-8083-07a3cffbff7d?resizing_type=fit)](https://dev.epicgames.com/community/api/documentation/image/292c0941-aacf-4bce-8083-07a3cffbff7d?resizing_type=fit)

    The name and type is the [declaration](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#declaration), and the [initialization](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize) is where that value is expressed. A variable does not have to have an assigned value when [initialized](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#initialize), but it's good practice to do so.

    Variables differ from constants in that you can change the value of a variable at any time. This is done with an [assignment expression](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#assignmentexpression).

    Compare to [constant](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#constant). Also see [set](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#set).

varies
:   This [effect](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#effect) indicates that the same input to the [function](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#function) may not always produce the same output. The `varies` effect also indicates that the behavior of the function is not guaranteed to stay the same with new versions of its [containing package](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#container).

verbosity
:   A setting to limit how much additional information will show up when a log is generated.

Verse
:   Verse is a [statically-checked](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#staticchecking) programming language with an emphasis on gameplay programming.

Verse Explorer

Verse path
:   See [path](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#path).

Verse-authored device
:   A device for use in **Unreal Editor for Fortnite (UEFN)** that is programmed directly using Verse.

visual programming language
:   A type of programming language where the programmer uses visual elements by dragging them around and connecting them with other elements to achieve a specific sequence of program instructions.

Visual Studio Code
:   [Visual Studio Code](https://code.visualstudio.com/), also referred to as VS Code, is a source-code editor made by Microsoft for Windows, Linux and macOS.

VPL
:   See [visual programming language](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#visualprogramminglanguage).

zero-based numbering
:   A way of numbering where the first element in a sequence would be assigned as 0, rather than 1. This means that the zero position in an [index](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#index) represents 1, the first position represents 2, and so on. Numbering sequences that start at 0 are common in mathematic notation. In programming, that first position in an [array](https://dev.epicgames.com/documentation/en-us/uefn/verse-glossary#array) is sometimes termed the zeroth position.
