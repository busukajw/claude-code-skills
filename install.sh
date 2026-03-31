#!/bin/bash
# Claude Code Skills Installer

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}  Claude Code Skills Installer${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Determine skills directory
SKILLS_DIR="$HOME/.claude/skills"

echo -e "${BLUE}📂 Installing to:${NC} $SKILLS_DIR"
echo ""

# Create directory if it doesn't exist
mkdir -p "$SKILLS_DIR"

# Get script directory (works for both local and curl | bash)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Function to install a skill
install_skill() {
    local skill_name=$1
    local source_dir="$SCRIPT_DIR/skills/$skill_name"
    local target_dir="$SKILLS_DIR/$skill_name"

    if [ ! -d "$source_dir" ]; then
        echo -e "${YELLOW}⚠️  Skill not found: $skill_name${NC}"
        return 1
    fi

    # Check if already installed
    if [ -d "$target_dir" ]; then
        echo -e "${YELLOW}📦 $skill_name already installed. Updating...${NC}"
        rm -rf "$target_dir"
    else
        echo -e "${GREEN}📦 Installing $skill_name...${NC}"
    fi

    # Copy skill
    cp -r "$source_dir" "$target_dir"

    echo -e "${GREEN}✅ $skill_name installed${NC}"
    echo ""
}

# Install all skills
echo -e "${BLUE}Installing skills...${NC}"
echo ""

for skill_dir in "$SCRIPT_DIR/skills"/*; do
    if [ -d "$skill_dir" ]; then
        skill_name=$(basename "$skill_dir")
        install_skill "$skill_name"
    fi
done

# Summary
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✨ Installation complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${BLUE}📦 Installed skills:${NC}"
ls -1 "$SKILLS_DIR" | sed 's/^/  - /'
echo ""
echo -e "${BLUE}💡 Usage examples:${NC}"
echo "  /bootstrap-project learn .    # Learn from current project"
echo "  /bootstrap-project new my-api # Create new project"
echo "  /bootstrap-project show       # List templates"
echo ""
echo -e "${BLUE}📚 Documentation:${NC}"
echo "  https://github.com/YOUR_USERNAME/claude-code-skills"
echo ""
echo -e "${GREEN}Happy coding! 🚀${NC}"
