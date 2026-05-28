---
name: init-project
description: >
  初始化 AI Vibe Coding 项目结构。Use when users mention 初始化项目、
  init project、setup AI structure、创建项目结构、搭建 Claude Code 目录。
  Do NOT use when user only wants to create a single config file.
allowed-tools: Read, Write, Bash(mkdir:*), Bash(touch:*), Bash(cat:*), Bash(grep:*), Bash(echo:*)
---

# init-project Skill

初始化支持多 AI 平台的 Vibe Coding 项目结构，一次初始化，
兼容 Claude Code / OpenAI Codex / GitHub Copilot / Cursor / Aider。

---

## 执行流程

### Step 1：确认当前目录

```bash
pwd
ls -la
```

确认用户在项目根目录，若不在则提示用户 `cd` 到正确位置后再继续。

### Step 2：运行初始化脚本

```bash
bash scripts/init.sh
```

脚本会自动创建所有目录和文件，见 `references/structure.md` 了解完整结构。

### Step 3：提示用户填写项目信息

脚本执行完成后，告知用户需要手动编辑以下文件，填写项目实际信息：

- `CLAUDE.md` → 填写项目简介、技术栈
- `rules/code-style.md` → 按项目实际规范调整
- `.claude/settings.json` → 按需调整权限策略

### Step 4：输出初始化结果

列出已创建的文件结构（见 `references/structure.md`），并告知用户下一步操作。

---

## 输出格式

```
=== 初始化报告 ===
[✓] 多平台配置文件（CLAUDE.md / AGENTS.md / ...）
[✓] .claude/ 配置目录
[✓] commands/ 斜杠命令
[✓] rules/ 规则文件
[✓] skills/ 工作流
[✓] agents/ 子代理
[✓] .gitignore 已更新
=== 完成 ===
下一步：编辑 CLAUDE.md 填写项目信息
```

---

## ⚠️ Gotchas

- **执行前先确认当前目录** — 必须在项目根目录，否则文件会创建在错误位置
- **不要覆盖已有的 CLAUDE.md** — 若文件已存在，提示用户确认后再执行
- **不要修改 .env 文件** — 初始化不涉及任何环境变量文件
- **CLAUDE.local.md 和 settings.local.json 不提交 git** — 已在 .gitignore 中处理，无需额外操作
- **若 .github/ 目录已存在** — 只追加 copilot-instructions.md，不删除已有文件
