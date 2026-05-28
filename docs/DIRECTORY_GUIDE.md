# 📁 五大目录编写维护指南

本指南帮助你维护和扩展 ai-vibe-starter 生成的项目结构。

---

## 1️⃣ `.claude/` — Claude Code 配置中枢

**位置**：项目根目录 `.claude/`

**包含**：
```
.claude/
├── settings.json          # 🔓 团队共享配置（提交 git）
└── settings.local.json    # 🔒 本地覆盖（忽略 git）
```

### settings.json 编写规范

```json
{
  "version": "1.0",
  "project": {
    "name": "Your Project Name",
    "description": "What this project does",
    "language": ["TypeScript", "Python"],
    "framework": ["React", "FastAPI"]
  },
  "claude-instructions": {
    "enabled": true,
    "path": "../CLAUDE.md"
  },
  "rules": {
    "enabled": true,
    "path": "../rules",
    "auto-load": true
  },
  "commands": {
    "enabled": true,
    "path": "../commands"
  },
  "skills": {
    "enabled": true,
    "path": "../skills"
  },
  "agents": {
    "enabled": true,
    "path": "../agents"
  },
  "privacy": {
    "exclude-patterns": [".env", "*.key", "secrets/"],
    "max-context-files": 50
  }
}
```

### 维护清单

```
quarterly-review:
[ ] 项目技术栈是否变了？更新 language 和 framework
[ ] 新增了规则或技能？确保 path 和 enabled 状态正确
[ ] 是否有需要 exclude 的敏感文件？
[ ] 团队新成员能否正确加载这个配置？
```

---

## 2️⃣ `commands/` — 自定义斜杠命令

**位置**：项目根目录 `commands/`

**用途**：提供可在 Claude Code 中通过 `/project:*` 调用的快捷命令

### 目录结构

```
commands/
├── README.md                    # 命令使用说明
├── review.md                    # /project:review
├── fix-issue.md                 # /project:fix-issue
├── deploy.md                    # /project:deploy
├── test.md                      # /project:test (自定义示例)
└── onboard.md                   # /project:onboard (新人快速上手)
```

### 命令文件模板

每个命令文件采用统一格式：

```markdown
---
name: review
description: >
  执行代码审查。检查代码风格、测试覆盖率、性能问题。
  Triggered by: /project:review、进行代码审查、code review
trigger-keywords: 
  - review
  - 审查
  - code review
---

# /project:review — 代码审查

## 📋 审查流程

1. **扫描最近修改的文件**
   ```bash
   git diff --name-only origin/main...HEAD
   ```

2. **检查以下方面**
   - 代码风格是否符合 `rules/code-style.md`
   - 是否有测试覆盖（见 `rules/testing.md`）
   - 性能瓶颈分析
   - 安全隐患检查

3. **生成审查报告**
   - 严重问题：必须修复
   - 改进建议：建议修复
   - 风格问题：可选修复

## 📝 输出示例

```
=== 代码审查报告 ===
📁 Modified Files: 5
🟢 通过: 2 个文件
🟡 建议: 2 个文件
🔴 需修复: 1 个文件

详细信息：
[src/api.ts] 缺少错误处理 → lines 42-50
[src/utils.ts] 命名不符合规范 → useHelpers() 应为 useHelperUtils()
...
```

## 🔧 扩展这个命令

- 接入 ESLint / Prettier 配置
- 接入 Coverage 报告
- 调用 `/project:fix-issue` 自动修复部分问题
```

### 编写新命令的清单

```
for-each-command:
  [ ] 填写 YAML 前置元数据（name, description, trigger-keywords）
  [ ] 列出 3-5 个具体执行步骤
  [ ] 提供输出示例（格式化的表格或树形结构）
  [ ] 添加 🔧 扩展部分（如何接入其他工具）
  [ ] 在 README.md 中索引这个命令
```

---

## 3️⃣ `rules/` — 跨会话规则文档

**位置**：项目根目录 `rules/`

**用途**：定义代码规范和工作流标准，Claude Code 自动加载

### 目录结构

```
rules/
├── README.md                    # 规则总览
├── code-style.md                # 编码规范
├── testing.md                   # 测试策略
├── api-conventions.md           # API 设计规范
├── performance.md               # 性能基准和优化原则
├── security.md                  # 安全检查清单
└── git-workflow.md              # Git 提交和分支规范
```

### 规则文件模板

```markdown
---
rule-category: code-style
severity: high
applies-to: all
---

# 代码风格规范

## 变量命名

### ✅ DO

```typescript
// PascalCase for classes
class UserRepository { }

// camelCase for variables and functions
const userList = [];
function fetchUserData() { }

// UPPER_SNAKE_CASE for constants
const MAX_RETRY_COUNT = 3;
const API_BASE_URL = 'https://api.example.com';
```

### ❌ DON'T

```typescript
class user_repository { }        // ❌ snake_case for class
const UserList = [];             // ❌ PascalCase for variable
function fetch_user_data() { }   // ❌ snake_case for function
```

## 函数签名

**单一职责**：每个函数只做一件事

**长度限制**：不超过 30 行

**参数个数**：不超过 3 个（用对象传多个参数）

## 注释规范

```typescript
// ✅ 解释"为什么"，不要解释"是什么"
// 使用缓存避免重复查询数据库，性能提升 40%
const cachedUser = cache.get(userId);

// ❌ 没有价值的注释
// 获取用户
const user = getUser(userId);
```

## 错误处理

必须有 try-catch 的场景：
- 数据库查询
- API 调用
- 文件 I/O
- JSON 解析

## 类型检查

```
TypeScript strict mode:
  "strict": true,
  "noImplicitAny": true,
  "noImplicitThis": true,
  "strictNullChecks": true
```

## 审查建议

使用此规范时，在 `/project:review` 中检查：
1. 所有变量是否遵循命名规范
2. 函数是否超过 30 行
3. 是否有必要的注释说明"为什么"
4. 关键路径是否有错误处理
```

### 维护周期

```
每个 sprint 末：
  [ ] 是否有新的约定需要添加到规则？
  [ ] 哪些规则在实践中难以执行？
  [ ] 新技术栈是否需要新的规则？
  
每个季度：
  [ ] review 规则的合理性
  [ ] 收集团队反馈
  [ ] 与团队讨论是否需要调整
```

---

## 4️⃣ `skills/` — 自动触发的工作流

**位置**：项目根目录 `skills/`

**用途**：针对特定场景的自动化工作流（如本 ai-vibe-starter 中的 init-project / remove-project）

### 扩展现有项目的 skills 示例

```
skills/
├── init-project/                # 来自 ai-vibe-starter
├── remove-project/              # 来自 ai-vibe-starter
├── security-review/
│   ├── SKILL.md
│   ├── scripts/
│   │   ├── scan.sh
│   │   └── report.sh
│   └── references/
│       └── cve-database.md
├── deploy/
│   ├── SKILL.md
│   ├── scripts/
│   │   ├── validate.sh
│   │   ├── build.sh
│   │   └── deploy.sh
│   └── references/
│       └── deployment-checklist.md
└── database-migration/
    ├── SKILL.md
    ├── scripts/
    │   ├── backup.sh
    │   ├── migrate.sh
    │   └── verify.sh
    └── references/
        └── migration-guide.md
```

### Skill 编写清单

```
for-new-skill:
  [ ] SKILL.md 已编写（name, description, allowed-tools, 流程）
  [ ] 至少包含 3 个清晰的步骤
  [ ] scripts/ 中至少有一个可执行脚本
  [ ] ⚠️ Gotchas 部分涵盖了所有边界情况
  [ ] references/ 中有背景说明或清单
  [ ] 在 skills/README.md 中注册这个 skill
```

---

## 5️⃣ `agents/` — 专业化子代理角色

**位置**：项目根目录 `agents/`

**用途**：定义可指定的 AI 角色，在对话中切换专家视角

### 目录结构

```
agents/
├── README.md                        # 所有可用代理列表
├── code-reviewer.md                 # 代码质量审查专家
├── security-auditor.md              # 安全审计专家
├── performance-optimizer.md         # 性能优化专家
├── devops-engineer.md               # DevOps 工程师
└── tech-lead.md                     # 技术负责人
```

### 代理定义模板

```markdown
---
name: code-reviewer
role: 代码质量审查专家
expertise:
  - Code Quality
  - Design Patterns
  - Testing
  - Refactoring
trigger: "@code-reviewer" or "找代码审查专家"
---

# 👨‍💼 代码审查专家

## 我的职责

- 代码质量评估
- 设计模式审查
- 测试覆盖率分析
- 重构建议

## 我的工作方式

1. **代码审查**
   - 检查代码是否符合 `rules/code-style.md`
   - 提出 N+1 查询等性能问题
   - 检查错误处理的完整性

2. **设计审查**
   - 评估架构设计是否合理
   - 识别紧耦合或循环依赖
   - 提出重构建议

3. **测试建议**
   - 检查是否有充分的单元测试
   - 识别未测试的关键路径
   - 提出集成测试策略

## 我的输出格式

```
=== 代码审查结果 ===
✅ 优点:
  - 错误处理完整
  - 单元测试覆盖率 92%

⚠️ 建议:
  - 函数 parseConfig() 中有 N+1 查询
  - 缺少类型注解在第 45 行

🔴 问题:
  - 未捕获的 Promise rejection
```

## 调用我的方式

```
@code-reviewer 请审查这个 PR

或

我想要从代码质量的角度审查这个函数
```

## 我使用的规则

- `rules/code-style.md` — 代码规范
- `rules/testing.md` — 测试策略
- `commands/review.md` — 标准审查流程
```

### 代理设计原则

```
when-creating-agents:
  [ ] 角色是否高度专业化？（不要太通用）
  [ ] 是否清晰描述了可以做什么和不能做什么？
  [ ] 输出格式是否一致和可预测？
  [ ] 是否引用了项目的 rules/ 和 commands/?
  [ ] 团队其他成员是否能理解何时使用这个代理？
```

---

## 🔄 跨目录的协调

```
commands/  ←→  rules/      (命令引用规则)
   ↓
skills/  ←→  agents/      (技能可由代理执行)
   ↓
.claude/                   (配置中枢)
```

### 实例：新增一个部署命令

1. **创建** `commands/deploy.md`
   - 引用 `rules/git-workflow.md` 和 `rules/performance.md`

2. **创建或更新** `skills/deploy/SKILL.md`
   - 定义自动化流程

3. **更新** `.claude/settings.json`
   - 确保 commands 和 skills 已启用

4. **创建或更新** `agents/devops-engineer.md`
   - 指定谁可以审批部署

---

## 📊 维护面板

创建 `MAINTENANCE.md` 跟踪：

```markdown
# 项目维护面板

## 最近更新

| 目录 | 上次更新 | 负责人 | 状态 |
|------|---------|--------|------|
| .claude/ | 2024-05-28 | @owner | ✅ |
| commands/ | 2024-05-20 | @owner | 📝 需补充 deploy.md |
| rules/ | 2024-05-15 | @team | ⚠️  security.md 需更新 |
| skills/ | 2024-05-10 | @devops | ✅ |
| agents/ | 2024-05-05 | @owner | 🔴 缺少 tech-lead |

## TODO

- [ ] 添加 database-migration skill
- [ ] 创建 performance-optimizer 代理
- [ ] 完善 security.md 规则
- [ ] 为团队写使用文档
```

---
