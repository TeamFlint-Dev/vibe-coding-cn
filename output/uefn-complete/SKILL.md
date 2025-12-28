---
name: uefn-complete
description: Complete UEFN and Verse programming resource - API reference, tutorials, code examples, and best practices for Fortnite Creative development
---

# UEFN Complete - Verse Programming Resource

Comprehensive AI assistance for **Unreal Editor for Fortnite (UEFN)** and **Verse programming language** development.

## When to Use This Skill

This skill should be triggered when:
- Working with **UEFN** (Unreal Editor for Fortnite)
- Writing **Verse** code for Fortnite Creative
- Looking up **Verse API** classes, functions, or types
- Checking **version changes** between UEFN updates
- Understanding **Fortnite device** programming
- Building **custom game modes** in Fortnite Creative
- Debugging Verse compilation errors
- Learning Verse best practices and patterns
- Finding code examples and templates

## Quick Reference

### Verse API Module Structure

| Module | Path | Description |
|--------|------|-------------|
| **Verse Core** | `/Verse.org/` | Language primitives, simulation, concurrency |
| **UnrealEngine** | `/UnrealEngine.com/` | UE5 integration, transforms, math, UI |
| **Fortnite** | `/Fortnite.com/` | Game-specific APIs, devices, players |

### Essential Import Statements

```verse
# Core imports for most devices
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# UI and widgets
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/UI }

# Math and transforms
using { /UnrealEngine.com/Temporary/SpatialMath }

# Characters and AI
using { /Fortnite.com/Characters }
using { /Fortnite.com/AI }
```

### Common Verse Patterns

**Pattern 1:** Basic Device Structure
```verse
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

my_device := class(creative_device):
    @editable TriggerZone : trigger_device = trigger_device{}
    
    OnBegin<override>()<suspends> : void =
        TriggerZone.TriggeredEvent.Subscribe(OnPlayerEntered)
    
    OnPlayerEntered(Player : ?agent) : void =
        if (ValidPlayer := Player?):
            Print("Player entered!")
```

**Pattern 2:** Game Loop with Timer
```verse
GameLoop()<suspends> : void =
    loop:
        Sleep(1.0)  # Wait 1 second
        UpdateGameState()
```

**Pattern 3:** Option Handling (Null-Safety)
```verse
if (Player := MaybePlayer?):
    # Player is valid
    Player.SetPosition(NewPosition)
else:
    Print("No player found")
```

**Pattern 4:** Array Operations
```verse
Players : []player = GetPlayspace().GetPlayers()
for (Player : Players):
    Player.AddScore(100)
```

**Pattern 5:** Event Subscription
```verse
OnBegin<override>()<suspends> : void =
    ButtonDevice.InteractedWithEvent.Subscribe(OnButtonPressed)

OnButtonPressed(Agent : agent) : void =
    if (Player := player[Agent]):
        # Handle player interaction
        Print("Button pressed by player")
```

**Pattern 6:** Spawning and Positioning
```verse
SpawnAtLocation(Position : vector3, Rotation : rotation) : void =
    if (SpawnedProp := PropAsset.SpawnProp(Position, Rotation)):
        # Prop spawned successfully
        AllSpawnedProps += array{SpawnedProp}
```

## Verse Language Fundamentals

### Type System
- **Strong typing** with type inference
- Common types: `int`, `float`, `string`, `logic` (bool), `void`
- Container types: `[]T` (array), `[K]V` (map), `?T` (option)

### Effect Specifiers
| Specifier | Description |
|-----------|-------------|
| `<suspends>` | Function can pause execution (async) |
| `<decides>` | Function can fail (for if checks) |
| `<transacts>` | Function has transactional side effects |
| `<varies>` | Function may return different values |
| `<computes>` | Pure function, no side effects |
| `<converges>` | Function is guaranteed to terminate |

### Access Specifiers
| Specifier | Description |
|-----------|-------------|
| `<public>` | Accessible from anywhere |
| `<protected>` | Accessible from class and subclasses |
| `<private>` | Accessible only within same scope |
| `<internal>` | Accessible within same module |

### Common Attributes
| Attribute | Description |
|-----------|-------------|
| `@editable` | Exposes property in UEFN editor |
| `@doc` | Documentation string |

## Fortnite API Quick Reference

### Devices (creative_device base)
```verse
# Common device types
trigger_device          # Trigger zones
button_device           # Interactive buttons
spawn_pad_device        # Player spawn points
item_spawner_device     # Item spawning
timer_device            # Game timers
score_manager_device    # Score tracking
```

### Player Operations
```verse
# Get all players
Players := GetPlayspace().GetPlayers()

# Player properties
Player.GetFortCharacter()  # Get character
Player.GetTransform()      # Get position/rotation

# Fort character operations
if (FortCharacter := Player.GetFortCharacter[]):
    FortCharacter.Damage(10.0)
    FortCharacter.Heal(25.0)
    FortCharacter.SetMaxHealth(200.0)
```

### UI Operations
```verse
# Create canvas for UI
MyCanvas : canvas = canvas{}

# Add to player
if (PlayerUI := GetPlayerUI[Player]):
    PlayerUI.AddWidget(MyCanvas)
```

## Version History & Updates

Latest tracked version: **v39.11** (December 2025)

| Version Range | Notable Changes |
|---------------|-----------------|
| v39.x | Latest updates (Dec 2025) |
| v38.x | UI improvements, new devices |
| v37.x | Enhanced Verse concurrency |
| v36.x | Performance optimizations |
| v35.x | New gameplay APIs |

📍 **API Diffs:** [vz-creates/uefn](https://github.com/vz-creates/uefn)

## Available References

### API Documentation
- [references/verse-api-diffs.md](references/verse-api-diffs.md) - Version tracking and API changes
- [references/verse-pocket-wiki.md](references/verse-pocket-wiki.md) - Structured Verse documentation

### Resources & Tutorials
- [references/awesome-verse.md](references/awesome-verse.md) - Curated list of Verse resources

## External Resources

### Official Documentation
- [Verse Language Quick Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-language-quick-reference)
- [Verse API Reference](https://dev.epicgames.com/documentation/en-us/uefn/verse-api)
- [UEFN Documentation](https://dev.epicgames.com/documentation/en-us/uefn/)
- [Code Snippet Repository](https://dev.epicgames.com/community/fortnite/snippets)

### Community Resources
- [Versus - Learn Verse](https://verse-book.netlify.app)
- [/r/FortniteCreative](https://www.reddit.com/r/FortniteCreative/)
- [/r/uefn](https://www.reddit.com/r/uefn/)

### YouTube Tutorials
- [Fortnite Sensei](https://www.youtube.com/@fortnite_sensei)
- [Wahlbeck Warforge](https://www.youtube.com/@WarforgeXP)

### Discord Communities
- [Fortnite Create Official](https://discord.gg/fortnitecreative)
- [The Lab - Fortnite Creative](https://discord.gg/thelabfn)

## Debugging Tips

### Common Errors
1. **"Function must be called in a failure context"**
   - Wrap failable calls in `if` statements or use `?` operator

2. **"Expected suspends effect"**
   - Add `<suspends>` to function signature or use `spawn{}`

3. **"Type mismatch"**
   - Check option types (`?T`) vs concrete types (`T`)

### Print Debugging
```verse
using { /UnrealEngine.com/Temporary/Diagnostics }

Print("Debug message")
Print("Value: {MyValue}")
```

## Key Concepts

### Failure Context
Verse uses explicit failure handling instead of exceptions:
```verse
# Using if for failable operations
if (Result := FailableOperation[]):
    # Success path
else:
    # Failure path

# Using ? for option chaining
ValidPlayer := MaybePlayer?
```

### Concurrency Model
```verse
# Spawn concurrent task
spawn{ AsyncOperation() }

# Race multiple operations
race:
    Operation1()
    Operation2()

# Sync multiple operations  
sync:
    Operation1()
    Operation2()
```

---

**Generated by Skill Seeker** | Multi-source unified skill | Enhanced with Claude AI

## Data Sources
- vz-creates/uefn (81 ⭐) - Verse API diffs
- spilth/awesome-verse (75 ⭐) - Resource collection
- LilWikipedia/UEFNVersePocketWiki (23 ⭐) - Documentation
