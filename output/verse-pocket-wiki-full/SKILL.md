---
name: uefn-verse-complete
description: Complete UEFN and Verse programming documentation - Official API reference, language guide, tutorials, and code examples for Fortnite Creative development
---

# UEFN & Verse Complete Documentation

The most comprehensive AI skill for **Unreal Editor for Fortnite (UEFN)** and **Verse programming language** development.

## ⚡ What's Included

This skill contains **1.1MB+ of official documentation** from multiple authoritative sources:

| Source | Content | Size |
|--------|---------|------|
| **Official API** | Verse.digest.verse, Fortnite.digest.verse, UnrealEngine.digest.verse | 763 KB |
| **Verse Wiki** | Structured documentation covering all language features | 328 KB |
| **Versus Book** | Community learning guide with tutorials | 50 KB |
| **Awesome Verse** | Curated resource collection | 3 KB |

## When to Use This Skill

Trigger this skill when:
- Writing **Verse code** for Fortnite Creative
- Looking up **API classes**, functions, or types
- Understanding **effect specifiers** (`<suspends>`, `<decides>`, `<transacts>`)
- Working with **Fortnite devices** and creative_device
- Implementing **UI widgets** and player interactions
- Debugging **compilation errors** or runtime issues
- Learning **Verse patterns** and best practices

## Quick Reference

### Essential Imports
```verse
using { /Fortnite.com/Devices }           # Devices and triggers
using { /Fortnite.com/Characters }        # Character control
using { /Fortnite.com/UI }                # UI widgets
using { /Verse.org/Simulation }           # Core simulation
using { /UnrealEngine.com/Temporary/Diagnostics }  # Print debugging
using { /UnrealEngine.com/Temporary/SpatialMath }  # Math operations
```

### Common Device Pattern
```verse
my_device := class(creative_device):
    @editable TriggerZone : trigger_device = trigger_device{}
    
    OnBegin<override>()<suspends> : void =
        TriggerZone.TriggeredEvent.Subscribe(OnPlayerEntered)
    
    OnPlayerEntered(MaybeAgent : ?agent) : void =
        if (Agent := MaybeAgent?, Player := player[Agent]):
            Print("Player entered!")
```

### Effect Specifiers Quick Reference
| Specifier | Meaning | When to Use |
|-----------|---------|-------------|
| `<suspends>` | Can pause/await | Async operations, Sleep(), loops |
| `<decides>` | Can fail | Failable operations in if/for |
| `<transacts>` | Side effects | Modifying state |
| `<varies>` | May vary | Non-deterministic results |
| `<computes>` | Pure function | No side effects |
| `<converges>` | Terminates | Guaranteed to finish |

### Type System
```verse
# Primitives
var Count : int = 0
var Score : float = 100.0
var Name : string = "Player"
var IsActive : logic = true

# Option (nullable)
var MaybePlayer : ?player = false

# Array
var Items : []item = array{}

# Map
var Scores : [player]int = map{}
```

## Available References

### 📘 API Documentation (Official)
- [fortnite-api.verse](references/fortnite-api.verse) - **556 KB** - Complete Fortnite API
- [unreal-engine-api.verse](references/unreal-engine-api.verse) - **85 KB** - UE5 Integration
- [verse-core-api.verse](references/verse-core-api.verse) - **122 KB** - Core Language

### 📗 Language Guide
- [fortnite-digest.md](references/fortnite-digest.md) - **217 KB** - Fortnite API reference
- [unreal-engine-digest.md](references/unreal-engine-digest.md) - **41 KB** - UE APIs
- [verse-digest.md](references/verse-digest.md) - **30 KB** - Core Verse functions

### 📙 Tutorials & Style
- [verse-basics.md](references/verse-basics.md) - Complete Verse basics tutorial
- [01-13.*.md](references/) - Naming, formatting, functions, classes, etc.
- [SUMMARY.md](references/SUMMARY.md) - Learning path index

## Key Concepts

### Failure Context
Verse uses explicit failure handling:
```verse
# Success/failure branches
if (Player := MaybePlayer?):
    # Player exists
    DoSomething(Player)
else:
    # Handle missing player
    Print("No player")

# Failable in loops
for (Item : Items, Item.IsValid[]):
    ProcessItem(Item)
```

### Concurrency
```verse
# Spawn async task
spawn { AsyncOperation() }

# Race - first to complete wins
race:
    Sleep(5.0)  # Timeout
    WaitForEvent()

# Sync - wait for all
sync:
    Task1()
    Task2()
```

### Common Operations
```verse
# Get players
Players := GetPlayspace().GetPlayers()

# Player operations
if (FortChar := Player.GetFortCharacter[]):
    FortChar.Damage(25.0)
    FortChar.Heal(50.0)
    FortChar.SetMaxHealth(200.0)

# Spawn prop
if (Prop := PropAsset.SpawnProp(Position, Rotation)):
    Props += array{Prop}

# Timer/loop
loop:
    Sleep(1.0)
    UpdateGame()
```

## Debugging

### Print Debugging
```verse
using { /UnrealEngine.com/Temporary/Diagnostics }

Print("Message")
Print("Value: {MyValue}")
Print("Player {Player} at {Player.GetTransform().Translation}")
```

### Common Errors

| Error | Solution |
|-------|----------|
| "Function must be called in a failure context" | Wrap in `if` or use `?` operator |
| "Expected suspends effect" | Add `<suspends>` to function signature |
| "Type mismatch" | Check `?T` (option) vs `T` (concrete) types |
| "Cannot assign to immutable" | Use `var` instead of `set` for declaration |

## External Resources

### Official
- [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-quick-reference)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api)
- [Code Snippets](https://dev.epicgames.com/community/fortnite/snippets)

### Community
- [Versus Book](https://verse-book.netlify.app) - Learn Verse from scratch
- [/r/uefn](https://www.reddit.com/r/uefn/) - Reddit community
- [Discord: Fortnite Create](https://discord.gg/fortnitecreative)

### YouTube
- [Fortnite Sensei](https://www.youtube.com/@fortnite_sensei)
- [Wahlbeck Warforge](https://www.youtube.com/@WarforgeXP)

## Version Info

**API Version:** v39.11 (December 2025)
**Sources:**
- vz-creates/uefn - Official API diffs
- LilWikipedia/UEFNVersePocketWiki - Structured documentation
- glinesbdev/versus - Community learning guide
- spilth/awesome-verse - Resource collection

---
*Generated by Skill Seeker + Claude AI Enhancement*
*Total documentation size: 1.1 MB across 24 reference files*
