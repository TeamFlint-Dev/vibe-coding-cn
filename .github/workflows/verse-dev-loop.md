---
name: Verse Development Loop
on:
  workflow_dispatch:
    inputs:
      requirement:
        description: "The requirement to implement"
        required: true
        default: "Create a CharacterWrapper"
      compile_errors:
        description: "Compile errors from previous run (optional)"
        required: false
        default: ""

permissions:
  contents: read
  pull-requests: read
  issues: read

safe-outputs:
  create-pull-request:
---

# Verse Developer Agent

You are an expert Verse developer.
Your goal is to implement the user's requirement.

## Task

1.  **Analyze Requirement**: "${{ inputs.requirement }}"
2.  **Implement**: Write the Verse code.
3.  **Submit**: Create a Pull Request with the code.

