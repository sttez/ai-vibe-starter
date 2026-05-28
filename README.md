# ai-vibe-starter

一键初始化支持多 AI 平台的 Vibe Coding 项目结构。

写一次配置，Claude Code / OpenAI Codex / GitHub Copilot / Cursor / Aider 全部生效。

---

## 快速开始

**第一步：将本仓库的 `skills/` 目录复制到你的项目中**

```bash
cd your-project
git clone https://github.com/sttez/ai-vibe-starter.git /tmp/ai-vibe-starter
cp -r /tmp/ai-vibe-starter/skills ./skills
```

**第二步：通过自然语言触发初始化**

在 Claude Code 中直接说：

> 帮我初始化项目结构

AI 自动识别并执行 `init-project` Skill，完成所有文件的创建。

---

## 仓库结构

```
ai-vibe-starter/
├── README.md
└── skills/
    ├── init-project/              # 初始化 Skill
    │   ├── SKILL.md               ← AI 识别触发的核心手册
    │   ├── scripts/
    │   │   └── init.sh            ← 确定性执行的初始化脚本
    │   └── references/
    │       └── structure.md       ← 按需读取的完整结构说明
    └── remove-project/            # 移除 Skill
        ├── SKILL.md               ← AI 识别触发的核心手册
        ├── scripts/
        │   └── remove.sh          ← 确定性执行的移除脚本
        └── references/
            └── checklist.md       ← 执行前展示给用户的删除清单
```

---

## 初始化后生成的项目结构

```
your-project/
├── CLAUDE.md                          # Claude Code
├── CLAUDE.local.md                    # Claude Code 本地（不提交 git）
├── AGENTS.md                          # OpenAI Codex
├── .aider.instructions.md             # Aider
├── .github/
│   └── copilot-instructions.md        # GitHub Copilot
├── .cursor/
│   └── rules/
│       └── project.mdc                # Cursor
├── .claude/
│   ├── settings.json                  # 团队配置（提交 git）
│   └── settings.local.json            # 本地配置（不提交 git）
├── commands/
│   ├── README.md
│   ├── review.md                      # /project:review
│   ├── fix-issue.md                   # /project:fix-issue
│   └── deploy.md                      # /project:deploy
├── rules/
│   ├── README.md
│   ├── code-style.md
│   ├── testing.md
│   └── api-conventions.md
├── skills/
│   ├── README.md
│   ├── security-review/
│   └── deploy/
└── agents/
    ├── README.md
    ├── code-reviewer.md
    └── security-auditor.md
```

---

## 平台支持

| 平台 | 配置文件 | 路径 |
|------|---------|------|
| Claude Code | `CLAUDE.md` | 项目根目录 |
| OpenAI Codex | `AGENTS.md` | 项目根目录 |
| Aider | `.aider.instructions.md` | 项目根目录 |
| GitHub Copilot | `copilot-instructions.md` | `.github/` |
| Cursor | `project.mdc` | `.cursor/rules/` |

所有平台共享同一套规则内容，切换平台无缝衔接。

---

## 目录说明

### `commands/` — 自定义斜杠命令
在 Claude Code 中通过 `/project:*` 调用：

- `/project:review` — 代码审查
- `/project:fix-issue` — 修复问题
- `/project:deploy` — 部署检查

### `rules/` — 规则文件
Claude Code 自动加载，跨会话持续生效：

- `code-style.md` — 代码风格与命名规范
- `testing.md` — 测试策略与覆盖率要求
- `api-conventions.md` — API 设计约定

### `skills/` — 自动触发工作流
对话涉及对应场景时 Claude 自动调用：

- `security-review/` — 涉及安全操作时触发
- `deploy/` — 执行部署操作时触发

### `agents/` — 子代理角色
专业化子代理，可在对话中指定角色：

- `code-reviewer.md` — 代码质量审查专家
- `security-auditor.md` — 安全审计专家

---

## 移除

在 Claude Code 中直接说：

> 移除 AI 项目结构

AI 自动触发 `remove-project` Skill，预览所有将删除的内容，确认后执行，不会误删你自己的文件。

---

## 初始化后的下一步

1. 编辑 `CLAUDE.md`，填写项目简介和技术栈
2. 按需调整 `rules/` 中的规范
3. 在 Claude Code 中使用 `/project:review` 等斜杠命令开始 Vibe Coding

---

