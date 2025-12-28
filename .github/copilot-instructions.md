# GitHub Copilot Instructions for Vibe Coding CN

## Repository Overview

**Vibe Coding CN** is a multilingual AI pair-programming knowledge base and workflow system. The project's core assets are:
- **Massive prompt library** (`i18n/{lang}/prompts/`) organized by role (system/coding/user/meta)
- **Modular skills library** (`i18n/{lang}/skills/`) providing domain-specific AI context for tools like `ccxt`, `postgresql`, `telegram-dev`
- **Methodology documents** (`i18n/{lang}/documents/`) covering AI-assisted development principles and workflows

**Core Philosophy**: Plan-driven development with modular AI guidance. The project emphasizes structured, controlled AI collaboration over ad-hoc code generation.

## Project Structure

```
i18n/{lang}/
├── documents/     # Methodology, principles, templates
├── prompts/       # AI prompts organized by category
│   ├── coding_prompts/    # Programming-focused prompts
│   ├── system_prompts/    # AI behavior frameworks (includes CLAUDE.md versions)
│   ├── user_prompts/      # User-customizable prompts
│   └── meta_prompts/      # Prompt engineering aids
└── skills/        # Domain-specific knowledge modules

libs/
├── common/        # Shared utilities and models
├── database/      # Database adapters
└── external/      # External tools and dependencies
    ├── prompts-library/  # Excel ↔ Markdown conversion tool
    └── l10n-tool/        # Batch translation with code block protection
```

**Supported Languages**: 26 languages (zh, en, he, ar, es, hi, pt, ru, fr, de, ja, ko, it, tr, nl, pl, id, vi, th, fa, uk, bn, ta, ur, ms, sw, ha) following identical `documents/prompts/skills` structure.

## Essential Commands

### Documentation Quality
```bash
make lint          # Validate all markdown with markdownlint-cli
                   # REQUIRED before committing any .md changes
```

### Prompt Library Management
```bash
cd libs/external/prompts-library
python3 main.py    # Interactive Excel ↔ Markdown converter
                   # Source of truth for prompt maintenance
```

### Backup & Safety
```bash
bash backups/一键备份.sh    # Full project backup (respects .gitignore)
python backups/快速备份.py  # Alternative backup with .tar.gz output
```

## Development Workflow

### 1. Glue Coding Philosophy
This project follows the **"Glue Coding"** methodology (see `i18n/zh/documents/Methodology and Principles/gluecoding.md`):
- **Reuse over reinvention**: Leverage existing mature components
- **Minimal custom code**: Only write composition/invocation/adaptation layers
- **Never modify upstream**: Treat dependencies as immutable black boxes
- **Copy-and-use**: Community-verified code reuse is standard practice

### 2. Planning-First Approach
From `README.md` meta-methodology: "Planning is everything. Don't let AI autonomously plan or your codebase becomes unmaintainable chaos."

**Workflow Pattern**:
```
Planning → Context Fixation → Incremental Implementation → Self-Testing → Review
```

All development assets align with this flow:
- **Planning**: `i18n/zh/documents/` methodology guides
- **Context**: `i18n/zh/prompts/` structured prompts
- **Implementation**: `libs/` modular code
- **Testing**: Verify with `make lint` + domain-specific validation

### 3. Multi-Language Coordination
When adding/modifying content in one language:
1. Primary content in `i18n/zh/` (Chinese) is the source of truth
2. Use `libs/external/l10n-tool/` for batch translation to other languages
3. Maintain structural parity: same file names and directory hierarchy across all languages
4. Code blocks and technical terms remain in English regardless of language

## Coding Conventions

### File Naming & Structure
- **Text content**: Chinese for user-facing docs, comments, logs
- **Code symbols**: English for all function/variable/module names (clear, avoid obscure abbreviations)
- **File names**: English only, lowercase with hyphens or underscores, no spaces/special chars

### Formatting Standards
- **Indentation**: Consistent spaces (2 or 4, never mix) across entire repo
- **Markdown**: Lists, code blocks, tables aligned clearly; max line width 120 chars
- **Prompt organization**: Files use `(row,col)_` prefix for Excel-compatible categorization

### Dependency Management
When adding new tools/libraries:
1. Document in `i18n/zh/documents/Templates and Resources/工具集.md` or README
2. Record installation method, minimum version, source
3. Explain rationale (performance/compatibility/functionality)
4. Update `libs/external/` for external dependencies with license/source info

## Testing & Quality

### Current State
- No automated test suite yet
- Introducing code requires minimal reproducible test cases
- Prefer `pytest` for Python (files named `test_*.py`)

### Pre-Commit Checklist
```bash
make lint                          # Pass markdown validation
# If modifying prompts-library:
cd libs/external/prompts-library && python3 main.py  # Verify conversion works
# Ensure no temp files, secrets, or .gitignore violations
```

### Pull Request Requirements
- **Summary**: What changed and why (link to related Issue if applicable)
- **Testing**: Commands run + result overview
- **Screenshots**: For docs/UI changes (before/after comparison)
- **Risks**: Call out areas needing reviewer attention

## Commit Message Format

Follow simplified Conventional Commits:
```
feat|fix|docs|chore|refactor|test: scope – summary

Examples:
feat: prompts – add advanced debugging system prompt
docs: skills – update postgresql connection examples  
fix: l10n-tool – preserve code block formatting in translations
```

Avoid generic "update" messages; be specific about scope and action.

## Key Files & Directories

| Path | Purpose | When to Modify |
|------|---------|----------------|
| `AGENTS.md` | AI agent behavior guidelines | When adding workflow patterns or structural rules |
| `i18n/zh/prompts/` | Core prompt asset library | When creating/updating AI interaction templates |
| `i18n/zh/skills/` | Domain-specific AI context | When adding new tool/technology integrations |
| `libs/external/prompts-library/` | Prompt conversion tooling | When maintaining Excel ↔ Markdown sync |
| `Makefile` | Project automation commands | When adding new build/test/maintenance tasks |

## Prompt & Skills Architecture

### Prompt Categories
- **system_prompts/**: AI behavioral frameworks (includes versioned `CLAUDE.md/` subdirectories)
- **coding_prompts/**: Programming task templates (e.g., debugging, refactoring, architecture)
- **user_prompts/**: Reusable user interaction patterns
- **meta_prompts/**: Prompt engineering techniques and examples

### Skills Structure
Each skill in `i18n/{lang}/skills/{tool-name}/`:
- `SKILL.md`: Comprehensive guide with usage patterns, API references, best practices
- `references/`: Supporting documentation, examples, external resources
- `scripts/`: Tool-specific automation (if applicable)

**Example skills**: `ccxt` (crypto exchanges), `postgresql` (database), `telegram-dev` (bot development), `claude-code-guide` (AI coding workflows)

## Advanced Patterns

### Excel-Markdown Synchronization
The `prompts-library` tool maintains bidirectional sync:
- **Excel format** (`prompt_excel/`): Easier collaboration, bulk editing
- **Markdown format** (`prompt_docs/`): Git-friendly, version control
- Always verify converted output passes `make lint`

### Multi-Language Translation Pipeline
Using `libs/external/l10n-tool/`:
1. Identifies Chinese source files
2. Machine translates with code block protection
3. Post-processes for technical term accuracy
4. Maintains file structure across all 26 languages

## Security & Configuration

### Before Running Scripts
- **Backup tools**: Test in isolated temp directory first, verify output paths
- **Conversion tools**: Check write permissions and target directories
- **Dependencies**: Only use read-only copies for experimental tools

### External Dependencies
- Record all sources in `libs/external/` with provenance tracking
- Tag third-party scripts with license and origin
- Sync updates to dependency documentation when adding/removing

## Architecture Decision Workflow

**Pattern**: Unidirectional data flow with clear responsibility boundaries
1. **Documents** define methodology and principles
2. **Prompts** implement methodology as AI interaction patterns
3. **Skills** provide tool-specific context for prompts
4. **Code** (libs/) provides reusable implementation building blocks

When making architectural changes:
- Update this file (`copilot-instructions.md`) 
- Update `AGENTS.md` for behavior/workflow changes
- Update relevant `README.md` files in affected directories
- Ensure team shares single source of truth

## Quick Reference

```bash
# Essential workflow
make help                              # List all available commands
make lint                              # Pre-commit markdown validation
cd libs/external/prompts-library && python3 main.py  # Prompt management

# Documentation structure
i18n/zh/documents/Methodology and Principles/  # Core development philosophy
i18n/zh/documents/Templates and Resources/     # Practical templates & tools
i18n/zh/documents/Tutorials and Guides/        # Step-by-step guides

# Finding prompts by category
i18n/zh/prompts/system_prompts/CLAUDE.md/     # Versioned Claude prompts
i18n/zh/prompts/coding_prompts/               # Programming templates
i18n/zh/prompts/meta_prompts/                 # Prompt engineering help
```

## Contributing Philosophy

This is a knowledge base that grows through structured contribution:
- Add prompts that solve real, recurring AI collaboration challenges
- Create skills for tools you've successfully integrated with AI
- Document methodology that improves development velocity and code quality
- Maintain multilingual parity so all developers benefit equally

**Before major refactoring**: Run backup script, consult `AGENTS.md`, discuss in Issues.
