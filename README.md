# HolyClaude

**The Ultimate AI Coding Agent**

Five tools combined into one Claude Code plugin: persistent memory, structured workflows,
virtual team review, headless browsing, and autonomous experimentation.

```
+---------------------------------------------------+
|              Layer 5: RESEARCH                     |
|         /autoloop - autonomous experiments         |
+---------------------------------------------------+
|              Layer 4: TEAM                         |
|   /office-hours /review /ship /qa /investigate     |
+---------------------------------------------------+
|              Layer 3: WORKFLOW                      |
|        /spec /plan /subagent-dev /tdd              |
+---------------------------------------------------+
|              Layer 2: BROWSER                      |
|          /browse - headless Chrome                 |
+---------------------------------------------------+
|              Layer 1: MEMORY                       |
|    /mem-search /make-plan /do /smart-explore       |
+---------------------------------------------------+
|              Layer 0: CLAUDE CODE                  |
|           Anthropic foundation runtime             |
+---------------------------------------------------+
```

## Installation

```bash
git clone https://github.com/ajsai47/holyclaude.git
cd holyclaude
./setup
```

Restart Claude Code after setup completes.

## Quick Start

```
# Search previous work
/mem-search "authentication bug"

# Plan your approach
/office-hours

# Write a spec
/spec

# Build with TDD
/tdd

# Review before shipping
/review

# Ship it
/ship

# Run experiments overnight
/autoloop performance
```

## Features

### Memory (claude-mem)

Persistent cross-session memory. Automatically captures observations from every tool
call, groups them into sessions, and makes everything searchable.

- Full-text and semantic search across all sessions
- Timeline view for chronological exploration
- Auto-captures file reads, edits, commands, and decisions
- MCP server for structured memory queries

### Workflow (superpowers)

Structured development process that prevents yolo coding.

- `/spec` -- Write detailed specifications before building
- `/plan` -- Break specs into ordered implementation steps
- `/subagent-dev` -- Spawn focused sub-agents for parallel implementation
- `/tdd` -- Test-driven development: test first, implement second

### Team (gstack)

Virtual team of specialists who review your work like real colleagues.

- `/office-hours` -- Discuss approach with virtual team leads
- `/review` -- Security, performance, API, testing, and maintainability review
- `/ship` -- Automated PR creation with version bump and changelog
- `/qa` -- Comprehensive QA: functional, edge cases, regression, accessibility
- `/investigate` -- Root cause analysis for failures

### Browser

Headless Chrome automation for testing and web research.

- `/browse` -- Navigate, extract, interact with any web page
- Compiled binary for fast startup
- Full Playwright/Puppeteer support

### Research (autoresearch)

Autonomous experimentation loops inspired by karpathy/autoresearch.

- `/autoloop` -- Set a metric, point at files, let it run overnight
- Built-in presets: performance, bundle-size, test-coverage, prompt-engineering
- Logs every experiment to experiments.tsv
- Keeps improvements, reverts regressions, never stops

## How It Works

HolyClaude hooks into Claude Code's lifecycle:

1. **Session starts** -- Memory loads context from previous sessions
2. **You work** -- Observations captured automatically from every tool call
3. **You review** -- Virtual team specialists catch issues
4. **You ship** -- Automated PR, version bump, changelog
5. **Session ends** -- Everything persisted for next time

## Credits

HolyClaude combines the work of:

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) by Anthropic -- foundation runtime
- [Superpowers](https://github.com/obra/claude-code-superpowers) by obra -- workflow skills and agents
- [Claude-Mem](https://github.com/thedotmack/claude-mem) by thedotmack -- persistent memory system
- [gstack](https://github.com/garrytan/gstack) by garrytan -- virtual team and deployment skills
- [autoresearch](https://github.com/karpathy/autoresearch) by karpathy -- autonomous experimentation pattern

## License

MIT
