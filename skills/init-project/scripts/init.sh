#!/bin/bash

# ============================================================
# init-project Skill — 初始化脚本
# 由 SKILL.md Step 2 调用，不建议直接手动运行
# ============================================================

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔══════════════════════════════════════════╗"
echo "║   AI Vibe Coding 项目结构初始化           ║"
echo "║   Claude / Codex / Copilot / Cursor / Aider ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# ── 公共规则内容（各平台共享）─────────────────────────────

SHARED_RULES=$(cat << 'EOF'

## 项目简介
<!-- 填写项目简介 -->

## 技术栈
<!-- 例如：React + TypeScript + Tailwind CSS + Node.js -->

## 编码规范
- 缩进：2 个空格
- 字符串：优先单引号
- 命名：变量/函数用 camelCase，组件/类用 PascalCase，常量用 UPPER_SNAKE_CASE
- 禁止遗留 console.log 在生产代码中
- TypeScript 禁止使用 any 类型

## AI 协作约定
- 修改现有代码前先理解上下文
- 涉及删除操作必须先告知用户确认
- 生成代码后说明关键决策点
- 每次生成新功能时同步生成对应单元测试

## 禁止行为
- 不得删除未经确认的文件
- 不得修改 .env 中的敏感信息
- 不得在未告知的情况下变更项目依赖
EOF
)

# ── 1. 多平台主配置文件 ────────────────────────────────────

echo -e "${YELLOW}[1/7] 创建多平台主配置文件...${NC}"

_create_if_not_exists() {
  local file=$1
  if [ -f "$file" ]; then
    echo -e "  ⚠️  $file 已存在，跳过（如需覆盖请手动删除后重新运行）"
  else
    cat > "$file"
    echo -e "${GREEN}  ✓ $file${NC}"
  fi
}

_create_if_not_exists "CLAUDE.md" << EOF
# Claude Code 项目指令
# 平台：Claude Code | 路径：项目根目录 | 提交到 git
# 说明：定义 Claude 在本项目中的 AI 行为规则与约定，团队共享
${SHARED_RULES}
EOF

_create_if_not_exists "CLAUDE.local.md" << 'EOF'
# Claude Code 个人本地配置
# 平台：Claude Code | 路径：项目根目录 | 被 git 忽略，仅本地生效
# 说明：个人偏好与实验性设置，不影响团队其他成员

## 个人偏好
<!-- 例如：我偏好函数式组件、喜欢详细注释 -->

## 本地环境差异
<!-- 例如：本地数据库端口 5433，非默认 5432 -->
EOF

_create_if_not_exists "AGENTS.md" << EOF
# OpenAI Codex 项目指令
# 平台：OpenAI Codex | 路径：项目根目录 | 提交到 git
# 说明：定义 Codex Agent 在本项目中的行为规则，与 CLAUDE.md 保持同步
${SHARED_RULES}
EOF

_create_if_not_exists ".aider.instructions.md" << EOF
# Aider 项目指令
# 平台：Aider | 路径：项目根目录 | 提交到 git
# 说明：Aider 在本项目中的编码规范与协作约定，与其他平台配置保持同步
${SHARED_RULES}
EOF

mkdir -p .github
_create_if_not_exists ".github/copilot-instructions.md" << EOF
# GitHub Copilot 项目指令
# 平台：GitHub Copilot | 路径：.github/ 目录 | 提交到 git
# 说明：Copilot 在本项目中的补全与建议行为规范，与其他平台配置保持同步
${SHARED_RULES}
EOF

mkdir -p .cursor/rules
_create_if_not_exists ".cursor/rules/project.mdc" << EOF
---
description: 项目全局规则，适用于所有文件和场景
alwaysApply: true
---

# Cursor 项目指令
# 平台：Cursor | 路径：.cursor/rules/ 目录 | 提交到 git
# 说明：Cursor AI 在本项目中的行为规范，与其他平台配置保持同步
${SHARED_RULES}
EOF

# ── 2. .claude/ 配置目录 ───────────────────────────────────

echo -e "${YELLOW}[2/7] 创建 .claude/ 配置目录...${NC}"

mkdir -p .claude

_create_if_not_exists ".claude/settings.json" << 'EOF'
{
  "model": "claude-sonnet-4-20250514",
  "permissions": {
    "allow": [
      "Bash(git:*)",
      "Bash(npm:*)",
      "Bash(npx:*)",
      "Read(**)",
      "Write(src/**)",
      "Write(tests/**)"
    ],
    "deny": [
      "Bash(rm -rf *)",
      "Write(.env)"
    ]
  }
}
EOF

_create_if_not_exists ".claude/settings.local.json" << 'EOF'
{
  "//": "本文件不提交 git，存放个人本地配置，如本地 MCP 密钥、环境差异等"
}
EOF

# ── 3. commands/ ───────────────────────────────────────────

echo -e "${YELLOW}[3/7] 创建 commands/...${NC}"

mkdir -p commands

_create_if_not_exists "commands/README.md" << 'EOF'
# commands/ — 自定义斜杠命令
# 用途：定义可在 Claude Code 中通过 /project:* 调用的自定义命令
# 使用方式：在 Claude Code 中输入 /project:<命令名> 即可触发
# 适用平台：Claude Code
#
# 文件列表：
#   review.md     → /project:review     代码审查
#   fix-issue.md  → /project:fix-issue  修复问题
#   deploy.md     → /project:deploy     部署检查
EOF

_create_if_not_exists "commands/review.md" << 'EOF'
# /project:review — 代码审查
# 用途：触发全面代码审查，适用于 PR 前或阶段性检查
# 使用方式：Claude Code 中输入 /project:review

对当前改动进行代码审查，输出格式：
`[等级] 文件:行号 — 问题说明 → 改进建议`

等级说明：
- Critical：必须修复（安全漏洞、功能错误）
- Warning：建议修复（性能问题、潜在风险）
- Suggestion：可选优化（代码风格、最佳实践）
EOF

_create_if_not_exists "commands/fix-issue.md" << 'EOF'
# /project:fix-issue — 修复问题
# 用途：根据 issue 描述或报错信息，定位并修复问题
# 使用方式：Claude Code 中输入 /project:fix-issue，然后粘贴错误信息

修复流程：
1. 理解问题现象和复现步骤
2. 定位根本原因（非症状）
3. 提出修复方案并说明理由
4. 最小化改动范围实施修复
5. 说明验证方式
EOF

_create_if_not_exists "commands/deploy.md" << 'EOF'
# /project:deploy — 部署检查
# 用途：部署前的自动化检查清单与流程引导
# 使用方式：Claude Code 中输入 /project:deploy

部署前检查：
- [ ] lint 通过
- [ ] 全量测试通过
- [ ] 环境变量完整
- [ ] 版本号已更新
- [ ] CHANGELOG 已更新

<!-- 在此补充你的具体部署命令 -->
EOF

# ── 4. rules/ ──────────────────────────────────────────────

echo -e "${YELLOW}[4/7] 创建 rules/...${NC}"

mkdir -p rules

_create_if_not_exists "rules/README.md" << 'EOF'
# rules/ — 模块化规则文件
# 用途：定义 AI 跨会话持续生效的行为规则，Claude Code 自动加载此目录
# 使用方式：无需手动调用，Claude Code 启动后自动读取并应用
# 适用平台：Claude Code（全局规则库）
#
# 文件列表：
#   code-style.md       代码风格与命名规范
#   testing.md          测试策略与覆盖率要求
#   api-conventions.md  API 设计与接口约定
EOF

_create_if_not_exists "rules/code-style.md" << 'EOF'
# 代码风格规范
# 用途：约束 AI 生成代码的格式与命名风格，跨会话持续生效
# 适用平台：Claude Code（全局规则库）

- 缩进 2 空格，最大行宽 100 字符
- 命名：变量/函数 camelCase，组件/类 PascalCase，常量 UPPER_SNAKE_CASE
- 公共函数必须有 JSDoc 注释，复杂逻辑必须有行内注释
- 禁止魔法数字，使用具名常量
- 禁止 any 类型（TypeScript）
EOF

_create_if_not_exists "rules/testing.md" << 'EOF'
# 测试策略与规范
# 用途：规范 AI 生成测试代码的策略与覆盖要求，跨会话持续生效
# 适用平台：Claude Code（全局规则库）

- 单元测试：纯函数、hooks、工具方法（覆盖率 ≥ 80%）
- 集成测试：API 接口、数据库操作
- 命名格式：`it('应该在[条件]下[做什么]', ...)`
- AI 生成新功能时必须同步生成对应测试
EOF

_create_if_not_exists "rules/api-conventions.md" << 'EOF'
# API 设计约定
# 用途：统一 API 接口设计规范，避免 AI 生成不一致的接口风格
# 适用平台：Claude Code（全局规则库）

- RESTful：GET 查询 / POST 创建 / PUT 全量更新 / PATCH 部分更新 / DELETE 删除
- 统一响应格式：{ success, data, message, code }
- 错误信息对用户友好，不暴露内部细节
- URL 版本前缀：/api/v1/，破坏性变更必须升级版本
EOF

# ── 5. skills/ ─────────────────────────────────────────────

echo -e "${YELLOW}[5/7] 创建 skills/...${NC}"

mkdir -p skills/security-review skills/deploy

_create_if_not_exists "skills/README.md" << 'EOF'
# skills/ — 自动触发工作流
# 用途：定义 Claude 在特定场景下自动执行的工作流，无需手动调用
# 使用方式：对话涉及对应场景时，Claude 自动识别并执行
# 适用平台：Claude Code
#
# 子目录：
#   security-review/   涉及安全敏感操作时触发
#   deploy/            执行部署相关操作时触发
EOF

_create_if_not_exists "skills/security-review/README.md" << 'EOF'
# Security Review Skill
# 用途：涉及安全敏感操作时自动触发的审查工作流
# 触发场景：用户输入处理、身份认证、数据库查询、文件上传、第三方 API 调用

审查清单：
- [ ] SQL 注入防护
- [ ] XSS / CSRF 防护
- [ ] 敏感数据加密存储（禁止明文）
- [ ] API 鉴权验证
- [ ] 依赖包已知漏洞扫描建议
EOF

_create_if_not_exists "skills/deploy/README.md" << 'EOF'
# Deploy Skill
# 用途：执行部署相关操作时自动触发的检查工作流
# 触发方式：配合 commands/deploy.md 使用

自动执行步骤：
1. npm run lint
2. npm run test
3. npm run build
4. 检查必要环境变量是否存在
5. 输出部署就绪报告
EOF

# ── 6. agents/ ─────────────────────────────────────────────

echo -e "${YELLOW}[6/7] 创建 agents/...${NC}"

mkdir -p agents

_create_if_not_exists "agents/README.md" << 'EOF'
# agents/ — 子代理角色定义
# 用途：定义专业化子代理角色与职责，让 Claude 以特定角色身份执行任务
# 使用方式：对话中指定"请以 code-reviewer 角色审查"，或由 Claude 自动调用
# 适用平台：Claude Code
#
# 文件列表：
#   code-reviewer.md    代码质量审查专家
#   security-auditor.md 安全审计专家
EOF

_create_if_not_exists "agents/code-reviewer.md" << 'EOF'
# Code Reviewer Agent
# 用途：专注代码质量审查的子代理角色定义
# 调用方式：需要深度代码审查时，指定此 Agent 执行

职责：识别代码异味、检查边界条件、评估可维护性，提供附带示例的改进建议。
优先级：安全漏洞 > 功能正确性 > 性能问题 > 代码风格
输出风格：直接、具体，每条建议附带修改后的示例代码。
EOF

_create_if_not_exists "agents/security-auditor.md" << 'EOF'
# Security Auditor Agent
# 用途：专注安全审计的子代理角色定义
# 调用方式：涉及安全敏感功能时，指定此 Agent 执行

职责：OWASP Top 10 检测、敏感信息泄露检测、权限与访问控制审查。
覆盖范围：前端（XSS/CSRF）、后端（注入/越权）、配置（端口/密钥暴露）
输出格式：`漏洞类型 | 风险等级(高/中/低) | 位置 | 修复建议`
EOF

# ── 7. .gitignore ──────────────────────────────────────────

echo -e "${YELLOW}[7/7] 更新 .gitignore...${NC}"

GITIGNORE_BLOCK="
# AI 工具本地配置（不提交 git）
CLAUDE.local.md
.claude/settings.local.json"

if [ -f .gitignore ]; then
  if ! grep -q "CLAUDE.local.md" .gitignore; then
    echo "$GITIGNORE_BLOCK" >> .gitignore
    echo -e "${GREEN}  ✓ .gitignore 已追加${NC}"
  else
    echo -e "${GREEN}  ✓ .gitignore 已存在相关配置，跳过${NC}"
  fi
else
  echo "$GITIGNORE_BLOCK" > .gitignore
  echo -e "${GREEN}  ✓ .gitignore 已创建${NC}"
fi

# ── 完成 ───────────────────────────────────────────────────

echo ""
echo -e "${BLUE}╔══════════════════════════════════════════╗"
echo -e "║           ✅  初始化完成！                ║"
echo -e "╚══════════════════════════════════════════╝${NC}"
echo ""
echo -e "${CYAN}📁 项目结构：${NC}"
echo "  your-project/"
echo "  ├── CLAUDE.md / AGENTS.md / .aider.instructions.md"
echo "  ├── .github/copilot-instructions.md"
echo "  ├── .cursor/rules/project.mdc"
echo "  ├── .claude/ (settings.json / settings.local.json)"
echo "  ├── commands/ (README / review / fix-issue / deploy)"
echo "  ├── rules/    (README / code-style / testing / api-conventions)"
echo "  ├── skills/   (README / security-review / deploy)"
echo "  └── agents/   (README / code-reviewer / security-auditor)"
echo ""
echo -e "${YELLOW}📝 下一步：${NC}"
echo "  1. 编辑 CLAUDE.md，填写项目简介和技术栈"
echo "  2. 按需调整 rules/ 中的规范"
echo "  3. 在 Claude Code 中使用 /project:review 等斜杠命令"
echo ""
