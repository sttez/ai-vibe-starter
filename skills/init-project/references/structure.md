# 项目结构说明
# 本文件供 AI 按需读取，了解 init-project Skill 生成的完整目录结构

## 完整目录结构

```
your-project/
├── CLAUDE.md                          # Claude Code — 团队共享，提交 git
├── CLAUDE.local.md                    # Claude Code — 个人本地，不提交 git
├── AGENTS.md                          # OpenAI Codex — 提交 git
├── .aider.instructions.md             # Aider — 提交 git
├── .github/
│   └── copilot-instructions.md        # GitHub Copilot — 提交 git
├── .cursor/
│   └── rules/
│       └── project.mdc                # Cursor — 提交 git
├── .claude/
│   ├── settings.json                  # Claude Code 团队配置 — 提交 git
│   └── settings.local.json            # Claude Code 本地配置 — 不提交 git
├── commands/
│   ├── README.md                      # 目录说明
│   ├── review.md                      # /project:review
│   ├── fix-issue.md                   # /project:fix-issue
│   └── deploy.md                      # /project:deploy
├── rules/
│   ├── README.md                      # 目录说明
│   ├── code-style.md                  # 代码风格规范
│   ├── testing.md                     # 测试策略规范
│   └── api-conventions.md             # API 设计约定
├── skills/
│   ├── README.md                      # 目录说明
│   ├── security-review/
│   │   └── README.md                  # 安全审查工作流
│   └── deploy/
│       └── README.md                  # 部署工作流
└── agents/
    ├── README.md                      # 目录说明
    ├── code-reviewer.md               # 代码审查子代理
    └── security-auditor.md            # 安全审计子代理
```

## 平台对应关系

| 平台            | 配置文件                          | 路径         |
|----------------|----------------------------------|-------------|
| Claude Code    | CLAUDE.md / CLAUDE.local.md      | 项目根目录   |
| OpenAI Codex   | AGENTS.md                        | 项目根目录   |
| Aider          | .aider.instructions.md           | 项目根目录   |
| GitHub Copilot | copilot-instructions.md          | .github/    |
| Cursor         | project.mdc                      | .cursor/rules/ |

## 不提交 git 的文件

- CLAUDE.local.md
- .claude/settings.local.json
