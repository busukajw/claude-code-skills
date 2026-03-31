# Creating Your Own Claude Code Skills

A comprehensive guide to building custom skills for Claude Code.

## What Is a Skill?

A skill is a reusable command that tells Claude Code how to perform a specific task. When you type `/my-skill`, Claude reads the skill's instructions and executes them.

**Think of it as:** A recipe that Claude follows automatically.

## Skill Structure

Every skill needs:

```
~/.claude/skills/
└── my-skill/
    └── SKILL.md         # Required: The skill definition
```

That's it! One markdown file.

## Basic SKILL.md Template

```markdown
# my-skill

Brief description of what this skill does.

## Usage

/my-skill [arguments]

## What This Skill Does

Detailed explanation of the skill's purpose and capabilities.

## Instructions

[Tell Claude step-by-step what to do when this skill is invoked]

Step 1: Do this
Step 2: Then do that
Step 3: Finally, do this other thing

## Examples

Show concrete usage examples with expected outcomes.

## Error Handling

How to handle common error cases.
```

## Step-by-Step: Creating Your First Skill

### Example: A "quick-commit" Skill

Let's create a skill that does a fast git commit with automatic message generation.

**Step 1: Create the directory**
```bash
mkdir -p ~/.claude/skills/quick-commit
cd ~/.claude/skills/quick-commit
```

**Step 2: Create SKILL.md**

```markdown
# quick-commit

Quickly commit changes with an AI-generated commit message.

## Usage

/quick-commit [--push]

## What This Skill Does

Analyzes current git changes and creates a descriptive commit message automatically.
Optionally pushes to remote if --push flag is provided.

## Instructions

You are helping the user make a quick git commit with an auto-generated message.

**Steps:**

1. **Check for changes**
   ```bash
   git status --short
   ```

   If no changes, tell user "No changes to commit" and exit.

2. **Get the diff**
   ```bash
   git diff --staged
   git diff  # Also check unstaged
   ```

3. **Stage all changes**
   ```bash
   git add -A
   ```

4. **Analyze changes and generate commit message**
   - Read the diff output
   - Identify what changed (files, functions, features)
   - Generate a concise commit message following convention:
     - Start with verb: "Add", "Fix", "Update", "Remove", "Refactor"
     - Keep under 72 characters for first line
     - Add details in body if needed

   Example format:
   ```
   Add user authentication endpoint

   - Implement JWT token generation
   - Add login/logout routes
   - Include password hashing
   ```

5. **Create the commit**
   ```bash
   git commit -m "Generated message here"
   ```

6. **If --push flag provided**
   ```bash
   git push
   ```

7. **Confirm to user**
   - Show the commit message used
   - Show commit hash
   - Confirm if pushed

## Examples

```bash
# Basic usage
/quick-commit

# Commit and push
/quick-commit --push
```

## Error Handling

- If not in a git repository: "Not a git repository"
- If nothing to commit: "No changes to commit"
- If push fails: Show error and suggest checking remote

## Notes

- Does NOT skip git hooks (respects pre-commit hooks)
- Uses conventional commit message format
- Stages all changes (like git commit -am)
```

**Step 3: Test it**

```bash
# In any git repository
/quick-commit
```

Claude will read your SKILL.md and follow the instructions!

## Advanced Features

### Accepting Arguments

Parse arguments in your instructions:

```markdown
## Instructions

1. **Parse arguments**
   - Check if user provided `--force` flag
   - Check if user provided filename argument
   - Set behavior based on flags

2. **Execute based on arguments**
   If --force provided: skip confirmation
   If filename provided: process only that file
```

### Using AskUserQuestion

For interactive skills:

```markdown
## Instructions

1. **Ask user for confirmation**
   Use AskUserQuestion tool to ask:
   - "Do you want to proceed?"
   - Options: ["Yes", "No"]

2. **Based on answer:**
   - If "Yes": proceed with action
   - If "No": exit gracefully
```

### Multi-Step Workflows

```markdown
## Instructions

**Phase 1: Validation**
1. Check prerequisites
2. Validate inputs
3. Confirm with user

**Phase 2: Execution**
1. Perform main action
2. Handle errors
3. Rollback if needed

**Phase 3: Verification**
1. Verify results
2. Generate report
3. Show summary to user
```

### Error Recovery

```markdown
## Error Handling

For each error scenario:

**Error: File not found**
- Action: Ask user for correct path
- Retry with new path

**Error: Permission denied**
- Action: Suggest using sudo or checking permissions
- Show command to fix: chmod +x file

**Error: Network timeout**
- Action: Retry up to 3 times
- If still fails: save state and exit gracefully
```

## Real-World Examples

### Example 1: Test Runner with Smart Selection

```markdown
# smart-test

Run relevant tests based on changed files.

## Instructions

1. **Detect changes**
   ```bash
   git diff --name-only HEAD
   ```

2. **Map files to tests**
   - If src/api/users.py changed → run tests/test_users.py
   - If src/utils/*.py changed → run tests/test_utils.py
   - If no mapping found → run all tests

3. **Run tests**
   ```bash
   pytest <test-files> -v
   ```

4. **Show results**
   - Pass/fail count
   - Failed test names
   - Coverage percentage
```

### Example 2: Documentation Generator

```markdown
# gen-docs

Generate API documentation from code comments.

## Instructions

1. **Find API files**
   ```bash
   find src/api -name "*.py"
   ```

2. **Extract docstrings**
   - Read each file
   - Parse function docstrings
   - Extract parameters, returns, examples

3. **Generate markdown**
   - Create docs/api.md
   - Format as markdown tables
   - Include usage examples

4. **Commit documentation**
   ```bash
   git add docs/api.md
   git commit -m "Update API documentation"
   ```
```

## Best Practices

### ✅ DO

- **Be specific** - Clear, step-by-step instructions
- **Handle errors** - Plan for things going wrong
- **Validate inputs** - Check prerequisites before executing
- **Give feedback** - Tell user what's happening
- **Use examples** - Show concrete usage patterns
- **Be idempotent** - Safe to run multiple times

### ❌ DON'T

- **Hardcode paths** - Use environment variables or ask user
- **Skip confirmations** - For destructive actions, always confirm
- **Assume state** - Always check current state first
- **Hide errors** - Show clear error messages
- **Make destructive changes** - Without explicit user approval

## Testing Your Skill

```bash
# Test in a safe environment
cd /tmp/test-project

# Try your skill
/my-skill

# Check the results
# Verify it did what you expected

# Test error cases
# Try with bad inputs, missing files, etc.
```

## Skill Ideas to Get Started

**Easy:**
- `/hello` - Hello world example
- `/todo` - Add item to TODO.md
- `/note` - Quick note taking

**Medium:**
- `/backup` - Backup current project
- `/clean` - Clean build artifacts
- `/deploy` - Deploy to staging

**Advanced:**
- `/refactor` - Suggest refactoring opportunities
- `/security-scan` - Scan for common vulnerabilities
- `/performance-test` - Run performance benchmarks

## Publishing Your Skill

Once your skill works:

1. **Document it well** - README with examples
2. **Test thoroughly** - Try in different projects
3. **Share it** - GitHub, team wiki, or submit PR to this repo
4. **Get feedback** - Let others try it and improve

## Troubleshooting

**Skill not found:**
```bash
ls -la ~/.claude/skills/my-skill/
# Should show SKILL.md
```

**Skill not working:**
- Check SKILL.md syntax (valid markdown)
- Check instructions are clear
- Test each step manually first
- Check Claude Code logs: `~/.claude/logs/`

**Unexpected behavior:**
- Add more specific instructions
- Break down complex steps
- Add validation checks

## Need Help?

- Study existing skills in this repo
- Check [Claude Code documentation](https://docs.anthropic.com)
- Ask in community forums
- Open an issue on GitHub

---

**Happy skill building! 🚀**

Now you can create custom workflows tailored to your exact needs.
