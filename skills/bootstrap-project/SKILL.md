# bootstrap-project

Bootstrap new projects or apply patterns from reference projects.

## Usage

```
/bootstrap-project learn <path>          # Analyze reference project
/bootstrap-project new <name>            # Create new project from template
/bootstrap-project apply <pattern>       # Apply pattern to current project
/bootstrap-project show                  # Display learned templates
```

## What This Skill Does

Extracts project structure, conventions, and documentation patterns from reference projects and applies them to new or existing projects. Saves you from manually copying and adapting project scaffolding.

## Modes

### learn <path>
Analyze a reference project and extract reusable patterns:
- Directory structure and naming conventions
- Key documentation files (CLAUDE.md, DEVELOPMENT_WORKFLOW.md, etc.)
- Language/tooling detection (.python-version, package.json, etc.)
- ADR structure and templates
- gitignore patterns
- Stores template in `~/.claude/project-templates/<template-name>`

### new <name>
Create a new project from a learned template:
- Creates directory structure
- Generates CLAUDE.md with placeholders
- Sets up common files (.gitignore, README.md)
- Creates ADR directory if template includes it
- Prompts for template selection if multiple exist

### apply <pattern>
Apply specific pattern to current project:
- `structure` - Create missing directories
- `docs` - Generate documentation templates
- `adrs` - Set up ADR framework
- `gitignore` - Apply gitignore patterns
- `all` - Apply everything

### show
Display all learned templates and what they contain.

## Examples

```bash
# Learn from your current well-structured project
/bootstrap-project learn .

# Create a new project using the learned template
/bootstrap-project new my-new-api

# Apply just the ADR structure to an existing project
/bootstrap-project apply adrs

# See what templates you have
/bootstrap-project show
```

## Instructions

You are helping the user bootstrap projects using patterns from reference projects.

### Mode: learn <path>

**Task:** Analyze the reference project and extract reusable patterns.

**Steps:**

1. **Validate the path exists**
   ```bash
   cd <path> && pwd
   ```

2. **Analyze directory structure**
   - Use `find` to get all directories (exclude .git, __pycache__, node_modules, .venv)
   - Identify key directories: src/, tests/, docs/, config/, etc.
   - Note naming conventions (snake_case, kebab-case, etc.)

3. **Identify key files**
   Look for:
   - CLAUDE.md (project instructions)
   - DEVELOPMENT_WORKFLOW.md, CONTRIBUTING.md (dev guidelines)
   - ADR files in docs/decisions/ or similar
   - README.md structure
   - .gitignore patterns
   - Language-specific files (.python-version, package.json, Cargo.toml, etc.)

4. **Extract patterns**
   For each key file:
   - Read the file
   - Identify sections that are reusable vs project-specific
   - Create a template version with placeholders like {{PROJECT_NAME}}, {{DESCRIPTION}}

5. **Detect tooling**
   - Python: look for requirements.txt, pyproject.toml, ruff.toml
   - Node: look for package.json, eslint, prettier configs
   - Rust: look for Cargo.toml
   - Go: look for go.mod

6. **Store template**
   - Prompt user for template name (default: basename of path)
   - Create `~/.claude/project-templates/<template-name>/`
   - Save:
     - `structure.json` (directory tree)
     - `files/` (template files with placeholders)
     - `metadata.json` (language, tooling, description)

7. **Confirm to user**
   - Show what was extracted
   - Show where it was saved
   - Show how to use it

### Mode: new <name>

**Task:** Create a new project from a learned template.

**Steps:**

1. **Check available templates**
   ```bash
   ls -la ~/.claude/project-templates/
   ```

2. **If multiple templates exist:**
   - Use AskUserQuestion to let them choose which template
   - Show template metadata (language, description)

3. **If no templates exist:**
   - Tell user to run `/bootstrap-project learn <path>` first
   - Exit

4. **Gather project details**
   Use AskUserQuestion to get:
   - Project name (default: from <name> arg)
   - Project description
   - Primary language (if not in template)
   - Author name (optional)

5. **Create project directory**
   ```bash
   mkdir -p <name>
   cd <name>
   ```

6. **Apply structure**
   - Read `structure.json` from template
   - Create all directories
   - Copy template files, replacing placeholders:
     - {{PROJECT_NAME}} → user's project name
     - {{DESCRIPTION}} → user's description
     - {{AUTHOR}} → user's author name
     - {{DATE}} → current date

7. **Initialize git**
   ```bash
   git init
   git add .
   git commit -m "Initial commit from bootstrap-project template"
   ```

8. **Show next steps**
   - Tell user what was created
   - Suggest next actions (install dependencies, set up .env, etc.)

### Mode: apply <pattern>

**Task:** Apply specific pattern to current project.

**Steps:**

1. **Check available templates**
   - List templates in `~/.claude/project-templates/`
   - If multiple, ask which to use

2. **Based on <pattern> argument:**

   **structure:**
   - Read template's `structure.json`
   - Create any missing directories in current project
   - Don't overwrite existing directories

   **docs:**
   - Copy documentation templates (CLAUDE.md, DEVELOPMENT_WORKFLOW.md)
   - Replace placeholders with current project name (infer from directory)
   - Skip files that already exist (or ask to overwrite)

   **adrs:**
   - Create `docs/decisions/` directory
   - Copy ADR template (ADR-000-template.md)
   - Create initial ADR-001 if doesn't exist

   **gitignore:**
   - Copy .gitignore from template
   - If .gitignore exists, ask whether to merge or replace
   - If merge: append patterns that don't already exist

   **all:**
   - Apply all patterns in order: structure → docs → adrs → gitignore

3. **Confirm what was applied**
   - List files created/modified
   - Warn about any files that were skipped

### Mode: show

**Task:** Display all learned templates.

**Steps:**

1. **List templates**
   ```bash
   ls -la ~/.claude/project-templates/
   ```

2. **For each template:**
   - Read `metadata.json`
   - Show:
     - Template name
     - Language/tooling
     - Description
     - Key files included
     - When it was learned (if stored)

3. **Show usage examples**
   - How to create new project from each template
   - How to re-learn if needed

## Error Handling

- If template directory doesn't exist, create it
- If learning from a path that doesn't exist, show error
- If no templates exist when running `new` or `apply`, guide user to run `learn` first
- If placeholders can't be replaced, use sensible defaults
- Never overwrite files without asking first

## Notes

- Templates are stored globally in `~/.claude/project-templates/` (not per-project)
- You can learn from multiple reference projects to build a template library
- Templates are portable - you can share the directory with other users
- The skill doesn't modify the reference project, only reads from it

## Future Enhancements

Ideas for future versions:
- Export/import templates as .zip files
- Template inheritance (base template + language-specific extensions)
- Interactive mode with more customization options
- Integration with GitHub template repositories
- Auto-detect and suggest templates based on language detection
