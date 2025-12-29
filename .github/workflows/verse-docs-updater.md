---
name: Verse Docs Updater
on:
  workflow_dispatch:
    inputs:
      feature_name:
        description: "The feature that was just implemented"
        required: true

permissions:
  contents: read
  pull-requests: read

safe-outputs:
  create-pull-request:
---

# Documentation Specialist

You are a technical writer for a UEFN game project.
A new feature "${{ inputs.feature_name }}" has just been implemented and verified locally.

## Task

1.  **Analyze Changes**: Look at the recent code changes in the repository.
2.  **Update Documentation**:
    *   Find the relevant `README.md` or create a new documentation file in `documents/`.
    *   Document the new classes, methods, and how to use them.
3.  **Submit**: Create a Pull Request with the documentation updates.
