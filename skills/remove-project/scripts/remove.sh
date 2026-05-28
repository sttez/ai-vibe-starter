#!/bin/bash

# ============================================================
# remove-project Skill — 移除脚本
# 由 SKILL.md Step 3 调用，执行前已由 AI 获得用户确认
# ============================================================

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${YELLOW}"
echo "╔══════════════════════════════════════════╗"
echo "║   AI Vibe Coding 项目结构移除            ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# ── 1. 多平台主配置文件 ────────────────────────────────────

echo -e "${YELLOW}[1/5] 移除多平台主配置文件...${NC}"

for f in "CLAUDE.md" "CLAUDE.local.md" "AGENTS.md" ".aider.instructions.md"; do
  if [ -f "$f" ]; then
    rm "$f"
    echo -e "${GREEN}  ✓ 已删除 $f${NC}"
  fi
done

if [ -f ".github/copilot-instructions.md" ]; then
  rm ".github/copilot-instructions.md"
  echo -e "${GREEN}  ✓ 已删除 .github/copilot-instructions.md${NC}"
  # 只有 .github/ 为空时才删除目录
  if [ -d ".github" ] && [ -z "$(ls -A .github)" ]; then
    rmdir .github
    echo -e "${GREEN}  ✓ 已删除空目录 .github/${NC}"
  fi
fi

if [ -f ".cursor/rules/project.mdc" ]; then
  rm ".cursor/rules/project.mdc"
  echo -e "${GREEN}  ✓ 已删除 .cursor/rules/project.mdc${NC}"
  if [ -d ".cursor/rules" ] && [ -z "$(ls -A .cursor/rules)" ]; then
    rmdir .cursor/rules
    echo -e "${GREEN}  ✓ 已删除空目录 .cursor/rules/${NC}"
  fi
  if [ -d ".cursor" ] && [ -z "$(ls -A .cursor)" ]; then
    rmdir .cursor
    echo -e "${GREEN}  ✓ 已删除空目录 .cursor/${NC}"
  fi
fi

# ── 2. .claude/ 配置目录 ───────────────────────────────────

echo -e "${YELLOW}[2/5] 移除 .claude/ 配置目录...${NC}"

if [ -d ".claude" ]; then
  rm -rf .claude
  echo -e "${GREEN}  ✓ 已删除 .claude/${NC}"
fi

# ── 3. 四个核心目录 ────────────────────────────────────────

echo -e "${YELLOW}[3/5] 移除 commands/ rules/ skills/ agents/...${NC}"

for d in "commands" "rules" "skills" "agents"; do
  if [ -d "$d" ]; then
    rm -rf "$d"
    echo -e "${GREEN}  ✓ 已删除 $d/${NC}"
  fi
done

# ── 4. 清理 .gitignore ─────────────────────────────────────

echo -e "${YELLOW}[4/5] 清理 .gitignore...${NC}"

if [ -f ".gitignore" ]; then
  sed -i '/# AI 工具本地配置（不提交 git）/d' .gitignore
  sed -i '/CLAUDE\.local\.md/d' .gitignore
  sed -i '/\.claude\/settings\.local\.json/d' .gitignore
  echo -e "${GREEN}  ✓ .gitignore 已清理${NC}"
fi

# ── 5. 完成 ────────────────────────────────────────────────

echo -e "${YELLOW}[5/5] 检查残余文件...${NC}"

LEFTOVERS=0
for f in "CLAUDE.md" "AGENTS.md" ".aider.instructions.md" \
         ".github/copilot-instructions.md" ".cursor/rules/project.mdc"; do
  if [ -f "$f" ]; then
    echo -e "${RED}  ⚠️  未能删除：$f${NC}"
    LEFTOVERS=1
  fi
done
for d in ".claude" "commands" "rules" "skills" "agents"; do
  if [ -d "$d" ]; then
    echo -e "${RED}  ⚠️  未能删除：$d/${NC}"
    LEFTOVERS=1
  fi
done

if [ $LEFTOVERS -eq 0 ]; then
  echo -e "${GREEN}  ✓ 无残余文件${NC}"
fi

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════╗"
echo -e "║        ✅  移除完成！                    ║"
echo -e "╚══════════════════════════════════════════╝${NC}"
echo ""
echo "项目已恢复为初始化前的状态。"
echo ""
