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

## 📖 文档导航

| 文档 | 用途 |
|------|------|
| [docs/DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md) | **推荐首先阅读** — 五大目录的编写和维护指南 |
| [docs/CASE_STUDY_MINDHUB.md](docs/CASE_STUDY_MINDHUB.md) | **真实案例** — 完整的 MindHub 项目使用示例 |
| [skills/init-project/SKILL.md](skills/init-project/SKILL.md) | 初始化流程和触发条件 |
| [skills/remove-project/SKILL.md](skills/remove-project/SKILL.md) | 完整移除和清理流程 |

---

## 仓库结构

```
ai-vibe-starter/
├── README.md
├── docs/
│   └── DIRECTORY_GUIDE.md         ← 五大目录的维护指南
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

## 📚 初始化后的五大目录快速参考

| 目录 | 说明 | 编辑指南 |
|------|------|---------|
| `.claude/` | Claude 配置中枢，包含 `settings.json` 和本地配置 | [详见 DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md#1️⃣--claude--claude-code-配置中枢) |
| `commands/` | 自定义斜杠命令库，支持 `/project:*` 触发 | [详见 DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md#2️⃣--commands--自定义斜杠命令) |
| `rules/` | 代码规范和工作流标准，跨会话自动加载 | [详见 DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md#3️⃣--rules--跨会话规则文档) |
| `skills/` | 自动触发的工作流（如 init-project、deploy） | [详见 DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md#4️⃣--skills--自动触发的工作流) |
| `agents/` | 专业化子代理角色（如代码审查专家、安全审计）| [详见 DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md#5️⃣--agents--专业化子代理角色) |

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

### `.claude/` — 配置中枢
项目级别的 Claude Code 配置：

- `settings.json` — 团队共享配置（提交 git）
- `settings.local.json` — 个人本地配置（忽略 git）

📖 [编写指南 →](docs/DIRECTORY_GUIDE.md#1️⃣--claude--claude-code-配置中枢)

### `commands/` — 自定义斜杠命令
在 Claude Code 中通过 `/project:*` 调用：

- `/project:review` — 代码审查
- `/project:fix-issue` — 修复问题
- `/project:deploy` — 部署检查

📖 [编写指南 →](docs/DIRECTORY_GUIDE.md#2️⃣--commands--自定义斜杠命令)

### `rules/` — 规则文件
Claude Code 自动加载，跨会话持续生效：

- `code-style.md` — 代码风格与命名规范
- `testing.md` — 测试策略与覆盖率要求
- `api-conventions.md` — API 设计约定

📖 [编写指南 →](docs/DIRECTORY_GUIDE.md#3️⃣--rules--跨会话规则文档)

📖 [编写指南 →](docs/DIRECTORY_GUIDE.md#4️⃣--skills--自动触发的工作流)

### `agents/` — 专业化子代理角色
在对话中指定使用的 AI 角色：

- `code-reviewer.md` — 代码质量审查专家
- `security-auditor.md` — 安全审计专家

📖 [编写指南 →](docs/DIRECTORY_GUIDE.md#5️⃣--agents--专业化子代理角色)

---

## ✅ 初始化后的下一步

1. **编辑 `CLAUDE.md`** — 填写项目简介和技术栈
2. **调整 `rules/` 中的规范** — 按项目实际需求自定义
3. **创建第一个命令** — 例如 `/project:deploy`
4. **定义团队角色** — 在 `agents/` 中创建专家代理
5. **开启 Vibe Coding** — 在 Claude Code 中使用各种功能

---

## 🔧 维护建议

### 版本控制

提交到 git：✅
- `CLAUDE.md` — 团队共享配置
- `commands/`, `rules/`, `skills/`, `agents/` — 工作流定义
- `.claude/settings.json` — 项目配置

忽略 git：❌
- `CLAUDE.local.md` — 个人配置（已在 `.gitignore` 中）
- `.claude/settings.local.json` — 个人敏感信息（已在 `.gitignore` 中）

### 定期审查

**每个 Sprint：**
- 是否有新的代码规范需要添加到 `rules/`？
- `commands/` 中是否有不再需要的命令？

**每个季度：**
- 团队是否增长？是否需要新的 `agents/` 角色？
- 现有的 `skills/` 是否还有效？
- 是否有技术栈更新影响 `.claude/settings.json`？

📖 [完整维护指南 →](docs/DIRECTORY_GUIDE.md#-维护面板)

---

## ❓ FAQ

**Q: 如何扩展现有项目的结构？**

A: 按照 [DIRECTORY_GUIDE.md](docs/DIRECTORY_GUIDE.md) 中的规范：
1. 在对应目录中创建新文件
2. 遵循文档中的模板格式
3. 在 README.md 中索引新文件

**Q: 我的项目已经有 CLAUDE.md，会被覆盖吗？**

A: 不会。`init-project` Skill 会提示你确认，不会无故删除已有文件。详见 [init-project/SKILL.md](skills/init-project/SKILL.md)。

**Q: 可以只初始化其中一部分吗？**

A: 可以。你可以手动复制 `skills/` 目录到项目中，然后根据需要逐步创建 `commands/`, `rules/`, `skills/`, `agents/` 等目录。

**Q: 如何为团队贡献新的 Skill？**

A: 参考 [DIRECTORY_GUIDE.md 中的 Skill 编写清单](docs/DIRECTORY_GUIDE.md#skill-编写清单)，创建符合规范的 SKILL.md 并提交 PR。

---

## � 案例研究

想看一个完整的、真实的项目示例吗？

📖 **[MindHub 案例研究](docs/CASE_STUDY_MINDHUB.md)** — 一个 Next.js + TypeScript 项目，展示如何为真实项目配置五大目录：

- **`.claude/settings.json`** — 完整的 MindHub 配置示例
- **`commands/`** — 7 个实用命令（dev-setup、component-review、deploy 等）
- **`rules/`** — 代码风格、测试、性能、安全等规则
- **`skills/`** — setup-supabase、deploy-vercel 等自动化工作流
- **`agents/`** — 前端专家、AI 专家、技术主管等角色定义

通过这个案例，快速了解如何在你的项目中应用 ai-vibe-starter！

---

**方式一：一键初始化（推荐）**

```bash
cd your-project
cp -r /tmp/ai-vibe-starter/skills ./skills
```

在 Claude Code 中说：`帮我初始化项目结构`

**方式二：手动复制**

复制本项目的 `.claude/`, `commands/`, `rules/` 等模板到你的项目，按需修改。

---

## 移除

在 Claude Code 中直接说：

> 移除 AI 项目结构

AI 自动触发 `remove-project` Skill，预览所有将删除的内容，确认后执行，不会误删你自己的文件。

---

