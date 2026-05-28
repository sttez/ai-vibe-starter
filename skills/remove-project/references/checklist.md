# 移除清单
# 本文件供 AI 按需读取，用于在执行前向用户展示将要删除的完整内容

## 将被删除的文件

### 多平台主配置文件
- CLAUDE.md
- CLAUDE.local.md
- AGENTS.md
- .aider.instructions.md
- .github/copilot-instructions.md
- .cursor/rules/project.mdc

### .claude/ 配置目录（整个目录）
- .claude/settings.json
- .claude/settings.local.json

### 四个核心目录（整个目录）
- commands/（含 README.md / review.md / fix-issue.md / deploy.md）
- rules/（含 README.md / code-style.md / testing.md / api-conventions.md）
- skills/（含 README.md / security-review/ / deploy/）
- agents/（含 README.md / code-reviewer.md / security-auditor.md）

### .gitignore 中的相关行
- `# AI 工具本地配置（不提交 git）`
- `CLAUDE.local.md`
- `.claude/settings.local.json`

## 不会被删除的内容

- .github/ 目录本身（若其中还有其他文件）
- .cursor/ 目录本身（若其中还有其他文件）
- .gitignore 文件本身
- 用户自己创建的任何其他文件
