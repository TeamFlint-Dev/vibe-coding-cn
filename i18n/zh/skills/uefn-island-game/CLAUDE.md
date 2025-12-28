# CLAUDE.md

This file provides guidance to Claude when working with this UEFN island game project.

## Project Overview

A UEFN-based idle/collection game where players fish for items, display them in slots to earn passive income, and use earnings to unlock more slots.

**Core Loop**: Collect → Display → Earn → Upgrade → Collect more

## Key Commands

```bash
# No CLI commands - development is done in UEFN editor
# Verse source files location: Content/Verse/
```

## Architecture

- **Pattern**: SceneGraph (Entity-Component-Event)
- **Communication**: Scene Events (SendUp/SendDown/SendDirect)
- **Data Flow**: Unidirectional, event-driven state changes

## Always Rules

When working on this project, Claude should ALWAYS:

1. **Use SceneGraph architecture** - CreativeDevice is deprecated, always prefer SceneGraph entities and components
2. **Components communicate only through Scene Events** - Never access other components directly
3. **Each component has single responsibility** - If a component does multiple unrelated things, split it
4. **Follow existing naming conventions**:
   - Entities: `snake_case_entity`
   - Components: `snake_case_component`
   - Events: `snake_case_event`
   - Variables: `PascalCase`
   - Constants: `UPPER_SNAKE_CASE`
5. **Keep files under 300 lines** - Split into multiple components/files if needed
6. **Reference item_config.verse for all items** - Never define items inline
7. **Use constants from constants.verse** - Never hardcode game balance values
8. **Check @implementation-plan.md before starting work** - Follow the task sequence
9. **Update @progress.md after completing tasks** - Keep progress tracking current

## Never Rules

Claude should NEVER:

1. **Never use CreativeDevice** - It's being deprecated, always use SceneGraph
2. **Never access components directly** - Use Scene Events for all inter-component communication
3. **Never hardcode game balance values** - All numbers go in `constants.verse` or `item_config.verse`
4. **Never modify existing event definitions** - Add new events instead of changing existing ones
5. **Never put business logic in entities** - Entities are containers, logic belongs in components
6. **Never create files over 300 lines** - Split large files into smaller, focused modules
7. **Never skip the implementation plan** - Each task builds on previous tasks

## Code Patterns

### Preferred: Event-based State Change

```verse
# Component sends event up to parent when state changes
PlaceItem(Item:item_type)<transacts>:void =
    set CurrentItem = option{Item}
    if (ParentEntity := GetParentEntity[]):
        ParentEntity.SendUp(display_slot_updated_event:
            SlotIndex := SlotIndex
            PreviousItem := OldItem
            NewItem := CurrentItem
        )
```

### Preferred: Event Subscription

```verse
# Component subscribes to events it cares about
OnBegin<override>()<suspends>:void =
    SubscribeToEvent(income_tick_event, OnIncomeTick)

OnIncomeTick(Event:income_tick_event):void =
    # Handle the event
    AddCurrency(Event.Amount, "income")
```

### Avoid: Direct Component Access

```verse
# ❌ DON'T DO THIS - Direct component access
UpdateSlot():void =
    DisplaySystem.Slots[0].CurrentItem := Item  # Bad: direct access
    EconomyComponent.Currency += 100            # Bad: direct modification
```

### Avoid: Hardcoded Values

```verse
# ❌ DON'T DO THIS - Hardcoded values
GetSlotCost():int =
    100 * 2  # Bad: magic numbers

# ✅ DO THIS - Use constants
GetSlotCost(SlotIndex:int):int =
    GAME_CONSTANTS{}.GetSlotUnlockCost(SlotIndex)
```

## File Organization

```
Verse/
├── Entities/           # Scene graph node containers
│   ├── simulation_entity.verse
│   ├── player_base_entity.verse
│   └── display_slot_entity.verse
├── Components/         # Behavior and data modules
│   ├── slot_component.verse
│   ├── fishing_component.verse
│   └── economy_component.verse
├── Events/             # Scene event definitions
│   └── core_events.verse
├── Data/               # Data structures and configs
│   ├── item_types.verse
│   └── item_config.verse
└── Utils/              # Helper functions and constants
    └── constants.verse
```

## Context Documents

Before starting development, read these memory-bank files:

| Document | Purpose |
|----------|---------|
| `memory-bank/@game-design-document.md` | Core loop, item design, economy balance |
| `memory-bank/@tech-stack.md` | SceneGraph constraints, API references |
| `memory-bank/@architecture.md` | Entity hierarchy, event flow, data structures |
| `memory-bank/@implementation-plan.md` | Current phase, task breakdown, dependencies |
| `memory-bank/@progress.md` | Completed work, blockers, next actions |

## Development Workflow

1. **Read progress** - Check `@progress.md` for current state
2. **Pick task** - Follow sequence in `@implementation-plan.md`
3. **Review architecture** - Understand where new code fits in `@architecture.md`
4. **Implement** - Follow code patterns above
5. **Update progress** - Mark task complete in `@progress.md`

## Key Technical Constraints

- **SceneGraph is Beta** - Test thoroughly before release
- **Player Persistent Data** - Required for save system, need to research API
- **Performance target** - 60 FPS, income calculation < 1ms per tick

## Reference Documents

- [SceneGraph Framework Guide](references/scenegraph-framework-guide.md)
- [SceneGraph API Reference](references/scenegraph-api-reference.md)
- [UEFN Dev Skill](../uefn-dev/SKILL.md)
