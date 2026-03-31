# HolyClaude

**The Ultimate AI Coding Agent**

Six open-source tools combined into one Claude Code plugin. Persistent memory, structured workflows, virtual team review, headless browsing, autonomous experimentation, and 13 official Anthropic plugins — all wired together and ready to go.

```
┌─────────────────────────────────────────────────────┐
│  Layer 6: RESEARCH        /autoloop                 │
│  Autonomous experiments — set a metric, let it run  │
├─────────────────────────────────────────────────────┤
│  Layer 5: TEAM            /office-hours /review     │
│  Virtual specialists — CEO, Eng, Design, Security   │
├─────────────────────────────────────────────────────┤
│  Layer 4: WORKFLOW        /spec /plan /tdd          │
│  Structured dev — spec first, then plan, then build │
├─────────────────────────────────────────────────────┤
│  Layer 3: PLUGINS         /feature-dev /commit      │
│  13 official Anthropic plugins + 14 agents          │
├─────────────────────────────────────────────────────┤
│  Layer 2: BROWSER         /browse                   │
│  Headless Chrome — navigate, extract, interact      │
├─────────────────────────────────────────────────────┤
│  Layer 1: MEMORY          /mem-search               │
│  Cross-session persistence — every action remembered│
├─────────────────────────────────────────────────────┤
│  Layer 0: CLAUDE CODE     Anthropic foundation      │
└─────────────────────────────────────────────────────┘
```

## What You Get

| | Count | Examples |
|---|---|---|
| **Skills** | 61 | /office-hours, /review, /spec, /tdd, /browse, /autoloop |
| **Commands** | 9 | /feature-dev, /commit, /review-pr, /hookify, /ralph-loop |
| **Agents** | 14 | code-architect, code-reviewer, silent-failure-hunter |
| **Plugins** | 13 | Full Anthropic official plugin collection |
| **Hooks** | 6 lifecycle events | Setup, SessionStart, PostToolUse, Stop |

## Installation

```bash
git clone https://github.com/ajsai47/holyclaude.git
cd holyclaude
./setup
```

Restart Claude Code after setup completes. That's it.

**Requirements:** macOS or Linux, [Bun](https://bun.sh) (auto-installed if missing), Node.js 18+

<details>
<summary>What <code>./setup</code> does</summary>

1. Installs Bun if not present
2. Runs `bun install` for dependencies (Playwright, tree-sitter parsers)
3. Compiles the headless browser binary (58MB)
4. Installs Playwright Chromium
5. Symlinks skills into `~/.claude/skills/` for slash-command discovery
6. Installs plugin at `~/.claude/plugins/holyclaude`
7. Initializes the memory system data directory

</details>

## Quick Start

```bash
# Remember everything — search previous sessions
/mem-search "authentication bug"

# Plan your approach with virtual team leads
/office-hours

# Write a detailed spec before coding
/spec

# Break the spec into implementation steps
/plan

# Build with test-driven development
/tdd

# Pre-landing review by virtual specialists
/review

# Ship — PR, version bump, changelog, push
/ship

# Run autonomous experiments overnight
/autoloop performance
```

## The Layers

### Layer 1: Memory

> Powered by [claude-mem](https://github.com/thedotmack/claude-mem) by thedotmack

Every tool call — every file read, edit, command, and decision — is automatically captured and persisted across sessions. When you start a new session, your agent has full context of previous work.

| Skill | What it does |
|-------|-------------|
| `/mem-search` | Full-text + semantic search across all sessions |
| `/make-plan` | Create plans informed by previous session context |
| `/do` | Execute tasks with memory-aware context |
| `/smart-explore` | AST-powered code exploration with tree-sitter |
| `/timeline-report` | Chronological view of activity around any point in time |

**How it works:** An MCP server backed by SQLite captures observations from every `PostToolUse` hook. On `SessionStart`, it generates a context index with token economics — showing what past work is available and how much it costs to load. On `Stop`, it summarizes the session for future recall.

### Layer 2: Browser

> Powered by [gstack](https://github.com/garrytan/gstack) browse daemon by garrytan

A compiled headless Chrome binary for QA testing and web research. Navigate pages, fill forms, click elements, take screenshots, extract content.

```bash
/browse goto https://your-app.com
/browse text                    # Extract page text
/browse click "Submit"          # Click elements
/browse screenshot              # Capture the page
/browse links                   # List all links
```

**Capabilities:** Playwright backend, SSRF protection, cookie import from real Chrome/Edge/Brave, console/network monitoring, PDF export, accessibility tree inspection, visual diffing.

### Layer 3: Plugins

> Powered by [claude-code plugins](https://github.com/nirholas/claude-code) by nirholas

13 official Anthropic plugins with commands, agents, and development skills.

| Command | What it does |
|---------|-------------|
| `/feature-dev` | Guided 7-phase feature development with code-explorer, code-architect, and code-reviewer agents |
| `/commit` | Smart git commit with auto-generated message |
| `/commit-push-pr` | Commit, push, and create PR in one step |
| `/review-pr` | Multi-agent PR review — 6 specialized agents analyze comments, tests, errors, types, code quality, simplification |
| `/hookify` | Create custom Claude Code hooks from conversation analysis |
| `/ralph-loop` | Self-referential iteration loop — keeps running until the task is done |
| `/create-plugin` | 8-phase guided plugin creation workflow |

**Agents included:** code-architect, code-explorer, code-simplifier, comment-analyzer, conversation-analyzer, plugin-validator, pr-test-analyzer, silent-failure-hunter, type-design-analyzer, and more.

### Layer 4: Workflow

> Powered by [Superpowers](https://github.com/obra/claude-code-superpowers) by obra

Structured development process that prevents yolo coding. Spec first, plan second, build third.

| Skill | What it does |
|-------|-------------|
| `/spec` | Write a detailed specification before building anything |
| `/plan` | Break a spec into ordered, testable implementation steps |
| `/subagent-dev` | Spawn focused sub-agents for parallel implementation |
| `/tdd` | Test-driven development — write the test first, then make it pass |

**Philosophy:** The Iron Law — never write production code without a failing test. Red-green-refactor. Every step is documented, reviewable, and reversible.

### Layer 5: Team

> Powered by [gstack](https://github.com/garrytan/gstack) by garrytan

A virtual team of specialists who review your work like real colleagues. Each brings a different lens — security, performance, API design, testing, maintainability.

| Skill | What it does |
|-------|-------------|
| `/office-hours` | Discuss approach with virtual team leads (CEO, Eng, Design) |
| `/plan-ceo-review` | Challenge assumptions — is this solving a real problem? |
| `/plan-eng-review` | Lock architecture — data flow, edge cases, performance |
| `/plan-design-review` | UX review — interaction gaps, visual consistency |
| `/review` | Pre-landing diff review by security, perf, API, and testing specialists |
| `/ship` | Detect merge base, run tests, bump version, create PR, push |
| `/qa` | Full QA pass — functional, edge cases, regression, accessibility |
| `/investigate` | Root cause analysis for build/test/deploy failures |
| `/retro` | Post-ship retrospective — what worked, what didn't |
| `/cso` | Chief Security Officer mode — infrastructure-first security audit |

### Layer 6: Research

> Inspired by [autoresearch](https://github.com/karpathy/autoresearch) by karpathy

Autonomous experimentation loops. Set a metric, point at files, let it run.

```bash
/autoloop performance     # Benchmark, modify, keep if faster
/autoloop bundle-size     # Build, modify imports, keep if smaller
/autoloop test-coverage   # Add tests, measure coverage, keep if higher
/autoloop prompt-engineering  # Modify prompts, evaluate, keep if better
```

**How it works:** Creates an experiment branch, then loops: modify → evaluate → compare → keep or discard → log to `experiments.tsv` → repeat. Runs indefinitely until interrupted. Every experiment is logged so you can review what was tried.

## How It All Fits Together

```
Session starts
  │
  ├── Memory loads context from previous sessions (SessionStart hook)
  ├── Superpowers injects workflow context (SessionStart hook)
  │
  ▼
You work
  │
  ├── Every tool call captured as an observation (PostToolUse hook)
  ├── Security warnings on sensitive file edits (PreToolUse hook)
  │
  ▼
You review
  │
  ├── /review — virtual specialists analyze your diff
  ├── /qa — browser-based testing with screenshots
  │
  ▼
You ship
  │
  ├── /ship — tests, version bump, changelog, PR
  ├── /ralph-loop — keeps iterating until done
  │
  ▼
Session ends
  │
  ├── Session summarized and persisted (Stop hook)
  └── Everything available for next session
```

You don't need to use every step. Pick what fits the task.

## File Structure

```
holyclaude/
├── .claude-plugin/plugin.json    Plugin manifest
├── .mcp.json                     MCP server config (memory)
├── hooks/
│   └── hooks.json                6 lifecycle hooks (memory + workflow + security)
├── skills/
│   ├── memory/                   5 skills — /mem-search, /make-plan, /do, etc.
│   ├── workflow/                 16 skills — /spec, /plan, /tdd, etc.
│   ├── team/                     31 skills — /office-hours, /review, /ship, etc.
│   ├── research/autoloop/        1 skill — /autoloop
│   └── dev/                      8 skills — plugin/agent/hook development
├── commands/                     9 slash commands
├── agents/                       14 agent definitions
├── plugins/                      13 official Anthropic plugins (full source)
├── browse/
│   ├── src/                      21 TypeScript files (~330KB)
│   └── dist/browse               Compiled binary (built on setup)
├── memory/scripts/               MCP server, worker service, context generator
├── setup                         One-command installer
└── package.json
```

## Credits

HolyClaude stands on the shoulders of:

| Project | Author | What it provides |
|---------|--------|-----------------|
| [Claude Code](https://docs.anthropic.com/en/docs/claude-code) | Anthropic | Foundation runtime — plugin system, MCP, tools, CLI |
| [claude-mem](https://github.com/thedotmack/claude-mem) | thedotmack | Persistent cross-session memory with SQLite + MCP |
| [Superpowers](https://github.com/obra/claude-code-superpowers) | obra | Structured workflow — spec, plan, TDD, sub-agents |
| [gstack](https://github.com/garrytan/gstack) | garrytan | Virtual team review + headless browser automation |
| [autoresearch](https://github.com/karpathy/autoresearch) | karpathy | Autonomous experimentation loop pattern |
| [claude-code plugins](https://github.com/nirholas/claude-code) | nirholas | 13 official Anthropic plugins with agents and skills |

## License

MIT
