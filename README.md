# Claude Code Skills

A collection of reusable skills for [Claude Code](https://claude.ai/code) to boost your productivity.

## 🚀 Quick Start

**One-command install:**
```bash
curl -fsSL https://raw.githubusercontent.com/busukajw/claude-code-skills/main/install.sh | bash
```

**Or manual install:**
```bash
git clone https://github.com/busukajw/claude-code-skills.git
cd claude-code-skills
./install.sh
```

## 📦 Included Skills

### bootstrap-project

Extract project patterns and scaffold new projects automatically.

**What it does:**
- Learn structure and conventions from existing projects
- Generate new projects with one command
- Apply patterns (docs, ADRs, tooling) to existing projects
- Store reusable templates globally

**Usage:**
```bash
/bootstrap-project learn .              # Learn from current project
/bootstrap-project new my-api           # Create new project
/bootstrap-project apply docs           # Apply docs pattern
/bootstrap-project show                 # List templates
```

**Perfect for:**
- Starting new projects with consistent structure
- Standardizing team project layouts
- Reusing your best project patterns

[View full documentation →](skills/bootstrap-project/SKILL.md)

## 🎯 What Are Claude Code Skills?

Skills are custom commands you can invoke in Claude Code to perform specialized tasks. They're like shell scripts, but Claude understands how to execute them contextually.

**Benefits:**
- 🔄 Reusable workflows
- 🎨 Customized to your needs
- 🚀 One command instead of multi-step processes
- 📤 Shareable with your team

## 📚 Documentation

- [Creating Your Own Skills](docs/creating-skills.md) - Tutorial on building custom skills
- [Skill Best Practices](docs/best-practices.md) - Guidelines for great skills
- [Troubleshooting](docs/troubleshooting.md) - Common issues and fixes

## 🛠️ Installation

Skills can be installed **globally** (available in all projects) or **per-project** (only in specific repos).

### Global Installation (Recommended)

```bash
# Clone the repo
git clone https://github.com/busukajw/claude-code-skills.git

# Run installer
cd claude-code-skills
./install.sh

# Skills are now available everywhere
/bootstrap-project --help
```

### Manual Installation

```bash
# Create skills directory
mkdir -p ~/.claude/skills

# Copy specific skill
cp -r skills/bootstrap-project ~/.claude/skills/

# Restart Claude Code
```

### Per-Project Installation

For project-specific skills:
```bash
# In your project
mkdir -p .claude/skills
cp -r /path/to/claude-code-skills/skills/bootstrap-project .claude/skills/

# Available only in this project
```

## 🌟 Usage Examples

### Bootstrap a new Python API project
```bash
# First, learn from a reference project
cd ~/projects/my-best-python-api
/bootstrap-project learn .

# Now create new projects with that structure
cd ~/projects
/bootstrap-project new awesome-api
```

### Apply docs structure to existing project
```bash
cd ~/projects/legacy-app
/bootstrap-project apply docs
/bootstrap-project apply adrs
```

### Create a template library
```bash
# Learn from different project types
cd ~/python-api-template && /bootstrap-project learn .
cd ~/react-app-template && /bootstrap-project learn .
cd ~/cli-tool-template && /bootstrap-project learn .

# See your template collection
/bootstrap-project show

# Use any template
/bootstrap-project new my-new-thing
```

## 🔧 Creating Your Own Skills

Want to create custom skills for your workflow? Check out our [Creating Skills Guide](docs/creating-skills.md).

**Quick example:**

1. Create directory: `mkdir -p ~/.claude/skills/my-skill/`
2. Create `SKILL.md`:

```markdown
# my-skill

Does something awesome.

## Usage
/my-skill [args]

## Instructions
[Tell Claude what to do when this skill is invoked]
```

3. Use it: `/my-skill`

## 🤝 Contributing

Contributions welcome! To add a new skill:

1. Fork this repo
2. Create `skills/your-skill/SKILL.md`
3. Update README.md
4. Submit PR

**Skill Guidelines:**
- Clear SKILL.md documentation
- Usage examples
- Error handling
- No hardcoded paths or credentials

## 📋 Skill Ideas

Want to contribute? Here are some skill ideas:

- **test-runner** - Smart test execution with coverage
- **doc-generator** - Auto-generate API docs from code
- **dependency-updater** - Safe dependency updates with testing
- **changelog-generator** - Create changelogs from git history
- **code-reviewer** - Automated code review checklist
- **env-setup** - Environment setup and validation

## 🐛 Troubleshooting

**Skill not found:**
```bash
# Verify installation
ls -la ~/.claude/skills/

# Restart Claude Code
```

**Permission denied:**
```bash
chmod +x install.sh
```

**Skills not working:**
- Check SKILL.md syntax
- Ensure you're using latest Claude Code
- Check Claude Code logs: `~/.claude/logs/`

## 📄 License

MIT License - use freely, modify as needed.

## 🙏 Acknowledgments

Built for the [Claude Code](https://claude.ai/code) community.

## 📞 Support

- 🐛 [Report issues](https://github.com/busukajw/claude-code-skills/issues)
- 💬 [Discussions](https://github.com/busukajw/claude-code-skills/discussions)
- 📖 [Claude Code Documentation](https://docs.anthropic.com)

---

**Star ⭐ this repo if you find it useful!**
