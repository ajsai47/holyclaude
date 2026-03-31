# HolyClaude

Six tools, one agent. HolyClaude combines persistent memory, structured workflows,
virtual team review, headless browsing, autonomous experimentation, and Anthropic's
official plugin collection into a single Claude Code plugin.

## Architecture

```
Layer 6: Research    /autoloop            Autonomous experiment loops
Layer 5: Team        /office-hours ...    Virtual team review & deployment
Layer 4: Workflow    /spec /plan ...      Structured dev process
Layer 3: Plugins     /feature-dev ...     Anthropic official plugins (14)
Layer 2: Browser     /browse              Headless Chrome automation
Layer 1: Memory      /mem-search ...      Persistent cross-session memory
Layer 0: Claude Code                      Foundation runtime
```

Each layer builds on those below it. Memory persists context across sessions.
Workflows structure your development process. The virtual team reviews your work.
The browser lets you test and research. The experiment loop optimizes autonomously.

## Integrated Flow

The full development cycle through all layers:

1. **Memory recall** -- Session starts, claude-mem loads context from previous sessions
2. **Office hours** -- `/office-hours` to discuss approach with virtual team leads
3. **Spec** -- `/spec` to write a detailed specification
4. **Plan** -- `/plan` to break the spec into implementation steps
5. **Build** -- `/subagent-dev` or `/tdd` to implement with tests
6. **Review** -- `/review` for pre-landing diff review by virtual specialists
7. **QA** -- `/qa` for comprehensive quality assurance
8. **Ship** -- `/ship` to create PR, push, and deploy
9. **Memory persist** -- Session ends, observations auto-saved for next time

You do not need to use every step for every task. Pick what fits.

## Skill Reference

### Memory Layer (claude-mem)

Auto-starts on session. Captures observations from tool use. Persists across sessions.

| Skill | When to Use |
|-------|-------------|
| `/mem-search` | Find work from previous sessions |
| `/make-plan` | Create a plan with memory-informed context |
| `/do` | Execute a task with memory awareness |
| `/smart-explore` | Explore codebase with memory-guided heuristics |
| `/timeline-report` | View chronological activity around a point in time |

MCP tools available: `search`, `timeline`, `get_observations`, `smart_search`, `smart_unfold`, `smart_outline`

### Workflow Layer (superpowers)

Structured development process with agent-driven implementation.

| Skill | When to Use |
|-------|-------------|
| `/spec` | Write a detailed specification before building |
| `/plan` | Break a spec into ordered implementation steps |
| `/subagent-dev` | Implement using focused sub-agents per task |
| `/tdd` | Test-driven development: write test first, then implement |

### Team Layer (gstack)

Virtual team of specialists who review, QA, and ship your work.

| Skill | When to Use |
|-------|-------------|
| `/office-hours` | Discuss approach with virtual team leads |
| `/plan-ceo-review` | CEO-perspective review of a plan |
| `/plan-eng-review` | Engineering lead review of a plan |
| `/plan-design-review` | Design lead review of a plan |
| `/review` | Pre-landing diff review by specialists (security, perf, API, testing) |
| `/ship` | Detect merge base, run tests, bump version, create PR, push |
| `/qa` | Full QA pass: functional, edge cases, regression, accessibility |
| `/qa-only` | QA without the review step |
| `/investigate` | Trace root cause of build/test/deploy failures |
| `/retro` | Post-ship retrospective |
| `/autoplan` | Auto-generate a plan from a goal |

### Plugins Layer (nirholas/claude-code)

14 official Anthropic plugins with commands, agents, and skills.

| Command | What It Does |
|---------|-------------|
| `/feature-dev` | Guided 7-phase feature development workflow |
| `/commit` | Smart git commit with message generation |
| `/commit-push-pr` | Commit, push, and create PR in one step |
| `/review-pr` | Multi-agent PR review (comments, tests, errors, types, simplification) |
| `/hookify` | Create custom hooks from conversation patterns |
| `/ralph-loop` | Self-referential iteration until task completion |
| `/create-plugin` | 8-phase guided plugin creation workflow |

**Agents**: code-architect, code-explorer, code-simplifier, comment-analyzer,
silent-failure-hunter, type-design-analyzer, conversation-analyzer, plugin-validator

**Dev skills** (in `skills/dev/`): agent-development, command-development,
hook-development, mcp-integration, plugin-settings, plugin-structure, skill-development

### Browser Layer

Headless Chrome for testing and research. Use `/browse` for all web browsing.

### Research Layer (autoresearch)

| Skill | When to Use |
|-------|-------------|
| `/autoloop` | Run autonomous experiments to optimize a metric |

Presets: `performance`, `bundle-size`, `test-coverage`, `prompt-engineering`, `val-bpb`

## Hooks

HolyClaude hooks into Claude Code's lifecycle:

- **SessionStart**: Memory system initializes, loads context from previous sessions
- **UserPromptSubmit**: Session tracking initialized
- **PostToolUse**: Observations captured from tool results
- **Stop**: Session summarized and persisted
- **SessionEnd**: Session completion recorded

## Memory System

The memory layer runs automatically. You do not need to manage it.

- **Observations**: Auto-captured from tool use (file reads, edits, commands)
- **Sessions**: Grouped by conversation, with summaries
- **Search**: Full-text + semantic search across all history
- **Timeline**: Chronological view around any observation

Data stored in `~/.claude-mem/`. MCP server at `memory/scripts/mcp-server.cjs`.

## File Layout

```
holyclaude/
  .claude-plugin/plugin.json   Plugin manifest
  .mcp.json                    MCP server config (claude-mem)
  hooks/hooks.json             Lifecycle hooks
  memory/scripts/              Memory system (MCP server, worker, hooks)
  skills/
    memory/                    /mem-search, /make-plan, /do, /smart-explore, /timeline-report
    workflow/                  /spec, /plan, /subagent-dev, /tdd
    team/                      /office-hours, /review, /ship, /qa, etc.
    research/autoloop/         /autoloop
  agents/                      14 agent definitions
  browse/                      Headless browser source (compiled on setup)
  commands/                    9 slash commands
  plugins/                     13 Anthropic official plugins (full source)
  examples/                    Hook and settings examples
  setup                        One-line installer
  package.json                 Dependencies
```
