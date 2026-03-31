---
name: autoloop
description: |
  Autonomous experimentation loop. Iteratively modifies code, measures a target metric,
  keeps improvements, discards regressions, and logs everything. Runs indefinitely until
  interrupted. Use when asked to "optimize", "experiment", "autoloop", "find the best",
  "tune performance", or "run experiments overnight".
user_invocable: true
---

# /autoloop -- Autonomous Experimentation Loop

Inspired by [karpathy/autoresearch](https://github.com/karpathy/autoresearch). Run an autonomous
loop that modifies code, measures a metric, keeps wins, reverts losses, and logs everything.

## Parameters

When the user invokes `/autoloop`, gather these (prompt if missing):

| Parameter | Required | Description | Example |
|-----------|----------|-------------|---------|
| `target_metric` | Yes | What to optimize (metric name + direction) | `val_bpb lower`, `test_coverage higher`, `bundle_size lower` |
| `editable_files` | Yes | Files the loop may modify (glob patterns OK) | `src/model.py`, `src/**/*.ts` |
| `eval_command` | Yes | Shell command that prints the metric value | `npm run test -- --coverage \| grep Stmts`, `python train.py` |
| `metric_extract` | No | Regex or grep pattern to pull the number from eval output | `grep "^val_bpb:" run.log` |
| `time_budget` | No | Max wall-clock per experiment (default: 5m) | `5m`, `30s`, `2m` |
| `constraint` | No | Hard constraint to not violate | `tests must pass`, `bundle < 500kb` |

### Built-in Presets

If the user says `/autoloop <preset>`, use these defaults:

**performance** -- Optimize runtime performance
- target_metric: `execution_time lower`
- eval_command: `time npm run bench 2>&1`
- metric_extract: `grep real`
- editable_files: `src/**/*.{ts,js}`
- constraint: `npm test must pass`

**bundle-size** -- Minimize production bundle
- target_metric: `bundle_bytes lower`
- eval_command: `npm run build 2>&1 && du -sb dist/`
- metric_extract: last line, first field
- editable_files: `src/**/*.{ts,js}`, `webpack.config.*`, `vite.config.*`
- constraint: `npm test must pass`

**test-coverage** -- Maximize test coverage
- target_metric: `coverage_pct higher`
- eval_command: `npm run test -- --coverage 2>&1`
- metric_extract: `grep "All files" | awk '{print $10}'`
- editable_files: `src/**/*.test.{ts,js}`, `tests/**/*`
- constraint: `all tests must pass`

**prompt-engineering** -- Optimize LLM prompt quality
- target_metric: `score higher`
- eval_command: `python eval_prompt.py`
- metric_extract: `grep "^score:"`
- editable_files: `prompts/**/*.md`, `prompts/**/*.txt`
- constraint: none

**val-bpb** -- autoresearch-style ML training optimization
- target_metric: `val_bpb lower`
- eval_command: `uv run train.py > run.log 2>&1`
- metric_extract: `grep "^val_bpb:" run.log`
- editable_files: `train.py`
- time_budget: `5m`
- constraint: `peak VRAM should not blow up dramatically`

## Setup Phase

Before the loop begins:

1. **Agree on a run tag** with the user. Propose one based on date + target (e.g., `loop-mar31-coverage`).

2. **Create an experiment branch**:
   ```bash
   git checkout -b autoloop/<tag>
   ```
   The branch must not already exist.

3. **Read all editable files** to build full context of what can be changed.

4. **Read supporting files** (README, config, tests) to understand constraints.

5. **Verify eval works** by running `eval_command` once. Parse the metric. This is the baseline.

6. **Initialize experiments.tsv** with header row:
   ```
   timestamp	commit	metric_value	status	description
   ```
   Record the baseline as the first row with status `baseline`.

7. **Confirm with user**, then begin the loop.

## The Experiment Loop

**LOOP FOREVER** (until manually interrupted):

### Step 1: Plan the Experiment
Review the current state: recent results in experiments.tsv, the current code, what has been tried.
Formulate a hypothesis. Write a 1-line description of what you will try.

### Step 2: Modify Code
Edit only files in `editable_files`. Make a focused change that tests one idea.

### Step 3: Commit
```bash
git add <modified files>
git commit -m "experiment: <description>"
```

### Step 4: Run Evaluation
```bash
timeout <time_budget> <eval_command> > run.log 2>&1
```
Redirect ALL output to run.log to avoid flooding context.

### Step 5: Extract Metric
```bash
<metric_extract pattern on run.log>
```
If no output, the run crashed. Read `tail -50 run.log` for the error.

### Step 6: Check Constraints
If a `constraint` was specified, verify it still holds (e.g., run tests). If the constraint
is violated, treat as a failure regardless of metric improvement.

### Step 7: Decide Keep or Discard

**Keep** if:
- Metric improved in the target direction
- All constraints still hold
- OR: metric is equal but code is simpler (fewer lines, removed complexity)

**Discard** if:
- Metric got worse
- Metric is equal and code got more complex
- Constraint was violated
- Run crashed and quick fix attempts failed

### Step 8: Act on Decision

**If keeping:**
- The branch advances. This commit stays.
- Log: `<timestamp>\t<commit>\t<metric>\tkeep\t<description>`

**If discarding:**
```bash
git reset --hard HEAD~1
```
- Log: `<timestamp>\t<commit>\t<metric>\tdiscard\t<description>`

**If crashed:**
- Attempt a quick fix (typo, missing import). If fixable, re-run.
- If fundamentally broken, revert and log with status `crash` and metric `0`.

### Step 9: Repeat
Go back to Step 1. Generate a new experiment idea based on accumulated results.

## Strategy for Generating Ideas

Cycle through these approaches to avoid getting stuck:

1. **Low-hanging fruit** -- hyperparameter tweaks, obvious simplifications
2. **Ablation** -- remove components to test if they help
3. **Literature** -- ideas from comments/docs in the code, known techniques
4. **Combination** -- merge two near-miss improvements
5. **Radical** -- fundamentally different approach (new algorithm, architecture)
6. **Simplification** -- can you get the same result with less code?

If stuck after 5+ consecutive discards, try a completely different angle.

## Rules

- **NEVER STOP** to ask if you should continue. The user expects autonomous operation.
  Run indefinitely until manually interrupted. If you run out of ideas, think harder.
- **Redirect eval output** to run.log. Never let experiment output flood the context window.
- **Do NOT modify** files outside `editable_files`.
- **Do NOT install** new packages or dependencies unless explicitly allowed.
- **Do NOT commit** experiments.tsv -- keep it untracked for easy inspection.
- **Simplicity criterion**: equal metric + simpler code = keep. Tiny improvement + ugly complexity = discard.
- **Timeout**: if an experiment exceeds 2x the time_budget, kill it and treat as crash.
- **Log everything** to experiments.tsv so the user can review all attempts on return.
