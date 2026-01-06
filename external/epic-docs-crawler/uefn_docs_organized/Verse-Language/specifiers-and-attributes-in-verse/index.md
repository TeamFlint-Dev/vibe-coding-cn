# Specifiers and Attributes

> **来源**: https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse
> **爬取时间**: 2025-12-27T00:01:54.916731

---

**Specifiers** in Verse describe behavior related to [semantics](https://dev.epicgames.com/documentation/en-us/fortnite/semantics), and can add [specifiers](https://dev.epicgames.com/documentation/en-us/fortnite/specifiers-and-attributes-in-verse) to identifiers and certain keywords. Specifier syntax uses angle brackets (`<` and `>`) with the keyword in between. For example, in `IsPuzzleSolved()<decides><transacts>:void`, "decides" and "transacts" are specifiers.

**Attributes** in Verse describe behavior that is used outside of the Verse language (unlike specifiers, which describe Verse semantics). Attribute [syntax](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#syntax) uses the at sign (`@`) followed by the keyword, for example `@editable`.

The following sections describe all of the specifiers and attributes available in Verse and when you can use them.

## Effect Specifiers

**Effects** in Verse indicate categories of behavior that a [function](https://dev.epicgames.com/documentation/en-us/fortnite/verse-glossary#function-verse) can exhibit. You can add effect specifiers to:

- After the `()` in a function definition: `name()<specifier>:type = codeblock`.
- The `class` keyword: `name := class<specifier>(){}`.

| Specifier | Description | Example |
| --- | --- | --- |
| **no\_rollback** | This is the default effect when no exclusive effect is specified. The `no_rollback` effect indicates that any actions performed by the function cannot be undone, as a result, the function cannot be used in a failure context. This effect cannot be manually specified. | `name():type = codeblock` |
| **transacts** | The `<transacts>` effect is a combination of `<allocates>`, `<reads>`, and `<writes>`.  The `<transacts>` effect cannot be combined with these specifiers. | `name()<transacts> : type = codeblock`  `# not allowed because transacts implies reads`  `name()<transacts><reads>: type = codeblock`  `# not allowed because transacts implies writes`  `name()<transacts><writes>: type = codeblock` |
| **allocates** | This effect indicates that the function may instantiate an object in memory. If the method is called in a failure context that fails, the effects are undone. | `name()<allocates> : type = codeblock` |
| **reads** | A method with this effect may read from mutable state. | `name()<reads> : type = codeblock` |
| **writes** | A method with this effect may write to mutable state. If the method is called in a failure context that fails, the effects are undone. | `name()<writes> : type = codeblock` |
| **computes** | A `<computes>` method promises to forever return the same output for any given input. A `<computes>` method can not be `<transacts>` `<reads>`, `<writes>` or `<allocates>`. | `name()<computes>` |
| **converges** | This effect guarantees that not only is there no side effect from the execution of the related function, but that the function completes (does not infinitely recurse). This effect can only appear in functions that have the native specifier, but this isn’t checked by the compiler. Code that provides default values for class fields or values for global variables is required to have this effect. | `name()<converges> : type = codeblock` |
| **decides** | This effect indicates that the function can fail and that calling this function is a failable expression. Because a `<decides>` function can fail, it is mutually exclusive with the `<suspends>` effect. It can be useful to combine `<decides>` with the `<transacts>` or `<computes>` effect, which allows the actions performed by this function to be rolled back (as if the actions were never performed) if there’s a failure anywhere in the function. | `# allowed`  `name()<decides><transacts> : type = codeblock`  `# allowed`  `name()<decides><computes> : type = codeblock`  `# not allowed because decides and suspends are mutually exclusive`  `name()<decides><suspends> : type = codeblock` |
| **suspends** | This effect indicates that the function is async. Creates an async context for the body of the function. Mutually exclusive with the `<decides>` effect. | `name()<suspends> : type = codeblock`  `# not allowed because decides and suspends are mutually exclusive`  `name()<decides><suspends> : type = codeblock` |

In all cases, calling a function that has a specific effect will require the caller to have that effect as well.

## Access Specifiers

Access specifiers define what can interact with a member and how. You can apply access specifiers to the following:

- The identifier for a member: `name<specifier> : type = value`
- The keyword `var` for a member: `var<specifier> name : type = value`

You can have an access specifier on both the identifier and the `var` keyword for a variable, to differentiate between who has access to read and write the variable. For example, the following variable `MyInteger` has the public specifier on the identifier so anyone can read the value, but the `var` keyword has the protected specifier so only the current class and subtypes can write to the variable.

```verse
var<protected> MyInteger<public>:int = 2
```

| Specifier | Description | Usage | Example |
| --- | --- | --- | --- |
| **public** | The identifier is universally accessible. | You can use this specifier on:   - module - class - interface - struct - enum - method - data | ```verse name<public> : type = value ``` |
| **protected** | The identifier can only be accessed by the current class and any subtypes. | You can use this specifier on:   - class - interface - struct - functions within a class - enum - non-module method - data | ```verse name<protected> : type = value ``` |
| **private** | The identifier can only be accessed in the current, immediately enclosing, scope (be it a module, class, struct, etc.). | You can use this specifier on:   - class - interface - struct - functions within a class - enum - non-module method - data | ```verse name<private> : type = value ``` |
| **internal** | The identifier can only be accessed in the current immediately enclosing, module. This is the default access level. | You can use this specifier on:   - module - class - interface - struct - enum - method - data | ```verse name<internal> : type = value ``` |
| **scoped** | The identifier can only be accessed in the current scope and any enclosing scopes. Any assets you expose to Verse that appear in the **Assets.digest.Verse** file will have the `<scoped>` specifier. | You can use this specifier on:   - module - class - interface - functions - struct - enum - non-module method - data | ```verse # Enclosing scope for ModuleB and ModuleC. ModuleA<public> := module:          ModuleB<public> := module:          # Internal to ModuleB.         class_b1 := class{}          # Allows access from anywhere inside ModuleA.         class_b2<scoped{ModuleA}> := class {} ``` |

## Class Specifiers

Class specifiers define certain characteristics of classes or their members, such as whether you can create a subclass of a class.

| Specifier | Description | Example |
| --- | --- | --- |
| **abstract** | When a class or a class method has the `abstract` specifier, you cannot create an instance of the class. Abstract classes are intended to be used as a superclass with partial implementation or as a common interface. This is useful when it doesn't make sense to have instances of a superclass but you don't want to duplicate properties and behaviors across similar classes. | ```verse pet := class<abstract>():     Speak() : void  cat := class(pet):     Speak() : void = {} ``` |
| **castable** | Indicates that this type is dynamically castable. The `<castable>` specifier has a backward compatibility restriction on its use. Once a class or interface is published, the `<castable>` attribute can be neither added nor removed. Doing so can introduce unsafe casting behaviors, so this is disallowed.  The `castable_subtype` type functions very similarly to `subtype`, but requires that any types used with it are also marked `<castable>`. This increases code safety in places where dynamic casts are used. | ```verse my_base := class {}  my_castable_type := class<castable>(my_base) {}  my_child_type := class(my_castable_type) {}  MySubtypeFunction(t:castable_subtype(my_base)):void=     return  Main()<decides>:void = ``` |
| **concrete** | When a class has the `concrete` specifier, you can construct an instance of the class with an empty archetype, which means that every field of the class must have a default value. Every subclass of a concrete class is implicitly concrete. A concrete class can only inherit directly from an abstract class if both classes are defined in the same module. | ```verse cat := class<concrete>():      # field must be initialized because the class is concrete     Name : string = "Cat" ``` |
| **unique** | A unique class in Verse is assigned a unique identity for each instance. This means that, even if two instances of the same unique class have the same field values, they are not equal since they are distinct instances. This allows instances of unique classes to be compared for equality by comparing their identities. Classes without the unique specifier don't have any such identity, and so can only be compared for equality based on the values of their fields. This means that unique classes can be compared with the = and <> operators, and are subtypes of the comparable type. | ```verse unique_class := class<unique>:     Field : int  Main()<decides> : void =     X := unique_class{Field := 1}     X = X # X is equal to itself     Y := unique_class{Field := 1}     X <> Y # X and Y are unique and therefore not equal ``` |
| **final** | You can only use the `final` specifier on classes and members of classes, with the following restrictions:   - When a class has the final specifier, you cannot create a subclass of the class. - When a field has the final specifier, you cannot override the field in a subclass. - When a method has the final specifier, you cannot override the method in a subclass. | ```verse cat := class<final>(): ``` |
| **final\_super** | The `final_super` specifier is only applicable to class definitions and requires that the class definition derives from a parent class or interface. This specifier imposes a future compatibility constraint that the given class will always derive from its parent directly; for this and all future published versions of this class definition.  This is necessary in Scene Graph for immediate subtypes of `component` to limit the number of instances to exactly zero or one per Scene Graph entity. This limit extends to subtypes of those types as well. | ```verse component := class {} my_final_class := class<final_super>(component) {}  # Not allowed since my_final_class has the final_super specifier. my_subclass_type := class(my_final_class) {} ``` |

## Persistence Specifier

When a custom type, such as a class, has the `<persistable>` specifier, it means that you can use it in your module-scoped weak\_map variables and have its values persist across game sessions. For more details on persistence in Verse, check out [Using Persistable Data in Verse](https://dev.epicgames.com/documentation/en-us/fortnite/using-persistable-data-in-verse).

You can use the persistable specifier with the following types. Follow the links for more details.

- [class](https://dev.epicgames.com/documentation/en-us/fortnite/class-in-verse)
- [enum](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse)
- [struct](https://dev.epicgames.com/documentation/en-us/fortnite/struct-in-verse)

## Open and Closed Specifiers

Currently usable only with enums. The `<open>` and `<closed>` specifiers determine how you can change the definition of the enum once your island is published.

You can use the open and closed specifiers with the following types. Follow the links for more details.

- [enum](https://dev.epicgames.com/documentation/en-us/fortnite/enum-in-verse)

| Specifier | Description | Example |
| --- | --- | --- |
| **Open** | A specifier that currently applies to enums only.  You can add or reorder enum values in an open enum, or change it to a <closed> enum.  Open enums are best used when you expect the number of values in your enum may increase in the future. For example, an enum of weapon types. | ```verse # Enums are <closed> by default so you must explicitly define the enum as an open enum with the <open> specifier my_enum := enum<open>{Value1, Value2, Value3} ``` |
| **Closed** | A specifier that currently applies to enums only.  Enums are **closed** by default.  Closed enums are best used for cases where your values are expected to stay the same, like days of the week. | ```verse # Enums are <closed> by default so the specifier is not required. my_enum := enum{Value1, Value2, Value3}  # You can also explicitly define the enum as closed by adding the <closed> specifier my_enum := enum<closed>{Value1, Value2, Value3} ``` |

## Implementation Specifiers

It's not possible to use implementation specifiers when writing code, but you will see them when looking at the UEFN APIs.

| Specifier | Description | Example |
| --- | --- | --- |
| **native** | Indicates that the definition details of the element are implemented in C++. Verse definitions with the `native` specifier auto-generate C++ definitions. A Verse developer can then fill out its implementation. You can see this specifier used on:   - class - interface - enum - method - data | ```verse GetCreativeObjectsWithTag<native><public>(Tags:tag)<transacts>:[]creative_object_interface ``` |
| **native\_callable** | Indicates that an instance method is both native (implemented in C++) and may be called by other C++ code. You can see this specifier used on an instance method. This specifier doesn’t propagate to subclasses and so you don’t need to add it to a definition when overriding a method that has this specifier | ```verse creative_device<native><public> := class<concrete>:     OnBegin<public>()<suspends>:void = external {}      OnEnd<native_callable><public>():void = external {} ``` |

## Attributes

Attributes in Verse describe behavior that is used outside of the Verse language (unlike specifiers, which describe Verse semantics). Attributes can be added on the line of code before definitions.

Attribute syntax uses the at sign (`@`) followed by the keyword.

| Attribute | Description | Example |
| --- | --- | --- |
| **editable** | Indicates this field is an exposed property that can be changed directly from UEFN so you don't need to modify the Verse code to change its value. For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse @editable Platform : color_changing_tiles_device = color_changing_tiles_device{} ``` |
| **editable\_text\_box** | An editable string that displays as a text box in the editor. Editable text boxes currently do not support tooltips or categories.  For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse # An editable string that displays as a text box in the editor. # Editable text boxes currently do not support tooltips or categories. @editable_text_box:     # Whether this text can span multiple lines.     MultiLine := true      # The maximum amount of characters this text block can display.     MaxLength := 32 MessageBox:string = "This is a short message!" ``` |
| **editable\_slider** | An editable slider that uses the float type. You can drag the slider in the editor to increase or decrease the value. For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse # An editable slider that uses the float type. You can drag the slider in the editor to increase # or decrease the value. @editable_slider(float):     # The categories this editable belongs to.     Categories := array{FloatsCategory}      # The tool tip for this editable.     ToolTip := SliderTip      # The minimum value of each component. You cannot set an editable value for this number lower ``` |
| **editable\_number** | An editable number with minimum and maximum.  For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse # An editable number with minimum and maximum @editable_number(int):      # The tool tip for this editable.     ToolTip := EditableIntTip      # The category this editable belongs to.     Categories := array{IntsCategory}      # The minimum value of each component. You cannot set an editable value for this number lower ``` |
| **editable\_vector\_slider** | An editable vector slider. You can drag to change the values of each of the vector components.  For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse # An editable vector slider. You can drag to change the values of each of the vector components. @editable_vector_slider(float):     # The tool tip for this editable.     ToolTip := VectorSliderTip      # The categories this editable belongs to.     Categories := array{FloatsCategory}      # Shows the option to preserve the ratio between vector values in the editor.     ShowPreserveRatio := true ``` |
| **editable\_vector\_number** | An editable vector number, which can be a vector2, vector2i, or vector3.  For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse # An editable vector number, which can be a vector2, vector2i, or vector3. @editable_vector_number(float):      # The categories this editable belongs to.     Categories := array{FloatsCategory}      # The tool tip for this editable.     ToolTip := VectorFloatTip      # Shows the option to preserve the ratio between vector values in the editor. ``` |
| **editable\_container** | An editable container of values. Currently, this only supports arrays.  For more details, see [Customize Device Properties](https://dev.epicgames.com/documentation/en-us/fortnite/editable-properties-in-verse). | ```verse An editable container of values. Currently, this only supports arrays. @editable_container:      # The category this editable belongs to.     Categories := array{IntsCategory}      # The tool tip for this editable.     ToolTip := IntArrayTip      # Whether dragging elements to reorder this container is allowed. ``` |
