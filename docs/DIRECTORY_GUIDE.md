# 📁 五大目录编写维护指南（带 MindHub 案例对比）

本指南通过表格对比，用 **通用示例** 和 **MindHub 真实例子** 帮助你快速掌握如何编写和维护项目的五大目录。

> 💡 **小白看这里**：每个目录都有"左 = 通用示例"和"右 = MindHub 具体例子"的对比表格。先看表格，再看代码。

---

## 1️⃣ `.claude/` — Claude Code 配置中枢

**简单来说**：这是你项目的"档案夹"，告诉 Claude 关于你项目的所有信息。

### 📋 用途对比表

| 功能 | 通用项目的配置 | MindHub 的配置 |
|------|---------------|----------------|
| **项目名字** | `"name": "MyApp"` | `"name": "MindHub"` |
| **技术栈** | `"language": ["TypeScript"]`<br/>`"framework": ["React"]` | `"language": ["TypeScript"]`<br/>`"framework": ["Next.js 16", "React", "Tailwind CSS", "shadcn/ui"]` |
| **后端服务** | 可选配置 | `"backend": ["Supabase", "Node.js"]`<br/>`"ai-integration": ["DeepSeek API", "Firecrawl"]` |
| **自动加载的规则** | `code-style.md`<br/>`testing.md` | `code-style.md`<br/>`testing.md`<br/>`component-patterns.md` |
| **敏感文件排除** | `.env`, `*.key`, `secrets/` | `.env.local`, `*.key`, `secrets/`<br/>`node_modules/`, `.next/`, `out/` |

### ✍️ 编写模板

**通用项目的 `settings.json`**：
```json
{
  "version": "1.0",
  "project": {
    "name": "My Project",
    "description": "What this does",
    "language": ["TypeScript"],
    "framework": ["React"]
  },
  "rules": { "enabled": true, "path": "../rules", "auto-load": true },
  "commands": { "enabled": true, "path": "../commands" },
  "skills": { "enabled": true, "path": "../skills" },
  "agents": { "enabled": true, "path": "../agents" },
  "privacy": {
    "exclude-patterns": [".env", "*.key", "secrets/"],
    "max-context-files": 50
  }
}
```

**MindHub 的 `settings.json`**（更复杂的例子）：
```json
{
  "version": "1.0",
  "project": {
    "name": "MindHub",
    "description": "AI 驱动的知识工作台",
    "language": ["TypeScript"],
    "framework": ["Next.js 16", "React", "Tailwind CSS", "shadcn/ui"],
    "backend": ["Supabase", "Node.js"],
    "ai-integration": ["DeepSeek API", "Firecrawl"]
  },
  "rules": {
    "enabled": true,
    "path": "../rules",
    "auto-load": true,
    "priority": ["code-style.md", "testing.md", "component-patterns.md"]
  },
  "commands": {
    "enabled": true,
    "path": "../commands",
    "frequently-used": ["dev-setup.md", "component-review.md", "deploy.md"]
  },
  "skills": {
    "enabled": true,
    "path": "../skills",
    "auto-trigger": {
      "setup-supabase": ["supabase", "数据库", "集成"],
      "deploy-vercel": ["部署", "deploy", "生产"]
    }
  },
  "agents": { "enabled": true, "path": "../agents" },
  "privacy": {
    "exclude-patterns": [".env.local", "*.key", "node_modules/", ".next/"],
    "max-context-files": 80
  }
}
```

### ✅ 维护清单

```
[ ] 技术栈变了吗？更新 language 和 framework
[ ] 新增 API 服务？更新 ai-integration 或 backend
[ ] 有新的敏感文件？加到 exclude-patterns
[ ] 规则和命令都已启用吗？
```

---

## 2️⃣ `commands/` — 自定义斜杠命令

**简单来说**：在 Claude Code 里输入 `/project:xxx` 就能一键执行常见任务。

### 📋 命令对比表

| 命令 | 通用项目的命令 | MindHub 的命令 |
|------|---------------|----------------|
| **开发设置** | `/project:setup` | `/project:dev-setup`<br/>（npm install + 配置 .env.local） |
| **代码审查** | `/project:review` | `/project:component-review`<br/>（检查 React 组件质量） |
| **修复问题** | `/project:fix` | `/project:fix-types`<br/>（修复 TypeScript 错误） |
| **部署** | `/project:deploy` | `/project:deploy`<br/>（部署到 Vercel） |
| **数据库** | 无 | `/project:db-migrate`<br/>（Supabase 迁移） |

### ✍️ 命令文件示例

**通用的 `commands/review.md`**：
```markdown
---
name: review
description: >
  代码审查。检查风格、测试、性能。
  Triggered by: /project:review、进行代码审查
trigger-keywords:
  - review
  - 审查
---

# /project:review — 代码审查

## 审查流程

1. 检查最近修改的文件
2. 验证代码风格（rules/code-style.md）
3. 检查测试覆盖（rules/testing.md）
4. 输出审查报告
```

**MindHub 的 `commands/component-review.md`**（更详细）：
```markdown
---
name: component-review
description: >
  React 组件审查。检查组件模式、Hooks 用法、
  无障碍支持、样式、性能。
trigger-keywords:
  - component
  - react
  - 组件
---

# /project:component-review — React 组件审查

## 审查清单

### ✅ 检查项
- Props 是否有类型定义（TypeScript）？
- 是否遵循 rules/component-patterns.md？
- 是否有不必要的重新渲染？
- 是否有单元测试？
- Tailwind CSS 样式是否正确？

### 🔴 常见问题
- TypeScript any 类型
- 缺少错误处理
- 没有 loading 状态
```

### ✅ 编写新命令的清单

```
[ ] YAML 前置信息：name, description, trigger-keywords
[ ] 3-5 个清晰的执行步骤
[ ] 提供输出示例（表格或结构化格式）
[ ] 说明与 rules/ 的关系
[ ] 在 README.md 中索引
```

---

## 3️⃣ `rules/` — 代码规范和工作流标准

**简单来说**：定义你的项目"长什么样子"。Claude 会自动遵守这些规则。

### 📋 规则对比表

| 规则 | 通用项目的规则 | MindHub 的规则 |
|------|---------------|----------------|
| **代码风格** | `code-style.md`<br/>（变量命名、缩进） | `code-style.md`<br/>+ `component-patterns.md`<br/>（React 特定模式） |
| **测试** | `testing.md`<br/>（单元测试） | `testing.md`<br/>+ Jest + React Testing Library<br/>+ E2E 测试（Playwright） |
| **API 设计** | `api-conventions.md`<br/>（REST 规范） | `api-design.md`<br/>（Next.js Route Handlers） |
| **性能** | `performance.md`<br/>（一般优化） | `performance.md`<br/>（Core Web Vitals 目标<br/>LCP < 2.5s） |
| **安全** | `security.md` | `security.md`<br/>+ Supabase RLS 策略 |
| **Git** | `git-workflow.md`<br/>（分支规范） | `git-workflow.md`<br/>（feature/fix/release 分支） |

### ✍️ 规则文件示例

**通用的 `rules/code-style.md`**：
```markdown
---
rule-category: code-style
severity: high
---

# 代码风格规范

## 变量命名

✅ DO
- Classes: PascalCase → `UserRepository`
- Functions: camelCase → `fetchUserData()`
- Constants: UPPER_SNAKE_CASE → `MAX_RETRY_COUNT`

❌ DON'T
- 混用命名风格
- 单字母变量（除了循环）

## 函数长度
- 不超过 30 行
- 单一职责原则
- 不超过 3 个参数
```

**MindHub 的 `rules/component-patterns.md`**（React 特定）：
```markdown
---
rule-category: component-design
severity: high
applies-to: src/components/**/*.tsx
---

# React 组件模式规范

## 函数组件结构

✅ DO
\`\`\`typescript
interface ComponentProps {
  children: ReactNode;
  className?: string;
  isLoading?: boolean;
}

export const MyComponent = ({ 
  children, 
  className, 
  isLoading = false 
}: ComponentProps) => {
  const handleClick = () => { /* ... */ };
  return (
    <div className={cn('base-class', className)}>
      {isLoading ? <Skeleton /> : children}
    </div>
  );
};

MyComponent.displayName = 'MyComponent';
\`\`\`

❌ DON'T
- 使用 React.FC（已过时）
- Props 没有类型定义
- 在组件体内定义子组件

## Hook 优先级
1. useState（简单状态）
2. useCallback（事件处理）
3. useMemo（计算密集操作）
4. useEffect（副作用）
```

### ✅ 维护清单

```
每个 Sprint：
  [ ] 是否有新的约定需要添加？
  [ ] 哪些规则在实践中难以执行？

每个季度：
  [ ] 收集团队反馈
  [ ] 是否需要调整或删除某些规则？
  [ ] 新技术栈是否需要新规则？
```

---

## 4️⃣ `skills/` — 自动化工作流

**简单来说**：当你说"帮我部署"或"设置数据库"时，Claude 自动按一定步骤执行。

### 📋 Skill 对比表

| Skill | 通用项目的 Skill | MindHub 的 Skill |
|-------|-----------------|-----------------|
| **初始化** | `init-project/` | `init-project/`<br/>（来自 ai-vibe-starter） |
| **部署** | `deploy/` | `deploy-vercel/`<br/>（部署到 Vercel） |
| **数据库** | 无 | `setup-supabase/`<br/>（创建表、RLS 策略） |
| **迁移** | 可选 | `migrate-db/`<br/>（数据库迁移脚本） |
| **性能审计** | 可选 | `performance-audit/`<br/>（检查 Core Web Vitals） |

### ✍️ Skill 结构

每个 Skill 的目录结构：
```
skills/deploy-vercel/
├── SKILL.md                 # 🎯 触发条件和流程
├── scripts/
│   ├── validate.sh         # 检查构建
│   ├── build.sh            # 构建应用
│   └── deploy.sh           # 部署脚本
└── references/
    └── deployment-checklist.md   # 部署清单
```

**SKILL.md 模板**（通用）：
```markdown
---
name: deploy
description: >
  部署应用。验证构建、检查环境变量、上传到云服务。
  Use when 部署、deploy、发布到生产
allowed-tools: Read, Write, Bash(npm:*, git:*)
---

# deploy Skill

## 执行流程

### Step 1: 验证构建
\`\`\`bash
npm run build
\`\`\`

### Step 2: 检查环境变量
确保所有必要的环境变量都已设置

### Step 3: 推送部署
\`\`\`bash
git push origin main
\`\`\`
```

**SKILL.md 示例**（MindHub 部署到 Vercel）：
```markdown
---
name: deploy-vercel
description: >
  部署到 Vercel。验证构建、运行测试、部署到生产。
  Use when 部署、deploy、发布生产、vercel
allowed-tools: Read, Write, Bash(npm:*, git:*)
---

# deploy-vercel Skill

## 执行流程

### Step 1: 本地验证
\`\`\`bash
npm run type-check  # TypeScript 检查
npm run lint        # ESLint 检查
npm run build       # 构建验证
\`\`\`

### Step 2: 运行测试
\`\`\`bash
npm run test        # 单元测试
npm run test:e2e    # E2E 测试
\`\`\`

### Step 3: 推送到 main 分支
\`\`\`bash
git push origin main
\`\`\`
Vercel 自动构建和部署

### Step 4: 验证部署
- [ ] 访问 https://mindhub.vercel.app
- [ ] 检查功能是否正常
- [ ] 运行性能审计
```

### ✅ 编写新 Skill 的清单

```
[ ] SKILL.md：name, description, allowed-tools, 清晰的步骤
[ ] 至少 3 个可验证的执行步骤
[ ] scripts/ 中的可执行脚本
[ ] ⚠️ Gotchas 部分覆盖所有边界情况
[ ] references/ 中的完整说明或清单
[ ] 在 skills/README.md 中注册
```

---

## 5️⃣ `agents/` — 专业化 AI 角色

**简单来说**：在对话中可以说"@前端专家"或"@devops工程师"，让 Claude 从不同角度帮你。

### 📋 Agent 对比表

| Agent | 通用项目的 Agent | MindHub 的 Agent | 职责 |
|-------|-----------------|-----------------|------|
| **前端专家** | ✓ | `@frontend-expert` | React/TypeScript、性能、无障碍 |
| **后端工程师** | ✓ | `@backend-engineer` | API、数据库、认证 |
| **DevOps** | ✓ | `@devops-engineer` | 部署、CI/CD、基础设施 |
| **AI 专家** | ✗ | `@ai-specialist` | DeepSeek 集成、提示词、成本优化 |
| **技术主管** | ✗ | `@tech-lead` | 架构决策、团队协调 |

### ✍️ Agent 定义示例

**通用的前端专家 `agents/frontend-expert.md`**：
```markdown
---
name: frontend-expert
role: 前端开发专家
expertise:
  - React
  - TypeScript
  - 样式
  - 性能
trigger: "@frontend-expert" or "找前端专家"
---

# 👨‍💻 前端开发专家

## 我的职责
- React/TypeScript 代码审查
- 性能优化建议
- 组件设计评估

## 我的工作方式
我会查看：
- rules/code-style.md
- rules/testing.md
- /project:component-review

## 调用我
\`\`\`
@frontend-expert 这个组件的性能如何？
或
我想从 React 最佳实践的角度审查这段代码
\`\`\`
```

**MindHub 的 AI 专家 `agents/ai-specialist.md`**（项目特定）：
```markdown
---
name: ai-specialist
role: AI 集成工程师
expertise:
  - DeepSeek API
  - LLM 集成
  - 提示词工程
  - 流式输出
  - 错误处理
trigger: "@ai-specialist" or "AI问题" or "deepseek"
---

# 🤖 AI 集成工程师

## 我的专长
- **API 集成**：DeepSeek、OpenAI 兼容接口
- **流式处理**：Server-Sent Events (SSE)
- **提示工程**：编写有效的 prompt
- **错误处理**：超时、速率限制、重试机制
- **成本优化**：Token 使用、模型选择

## 我的输出示例
\`\`\`
=== AI 集成审查 ===
功能: 生成资源摘要

✅ 优点:
- 使用了流式输出
- 有基础的错误处理

⚠️ 建议:
- 添加 5s 超时
- 实现指数退避重试
- 使用缓存避免重复调用

🔴 问题:
- 无速率限制
\`\`\`

## 调用我
\`\`\`
@ai-specialist 帮我审查这个 DeepSeek API 集成
或
我想优化 Token 消耗
\`\`\`
```

### ✅ 创建新 Agent 的清单

```
[ ] 角色是否高度专业化？（不要太通用）
[ ] 是否清晰描述了能做什么和不能做什么？
[ ] 输出格式是否一致和可预测？
[ ] 是否引用了项目的 rules/ 和 commands/?
[ ] 团队成员是否能理解何时使用这个 Agent？
```

---

## 🔄 五大目录如何协作

```
┌─────────────────────────────────┐
│   .claude/settings.json         │ ← 中枢配置
│   (启用所有功能)                │
└──────────────┬──────────────────┘
               │
      ┌────────┴────────┬────────────┬────────────┐
      ▼                 ▼            ▼            ▼
  commands/         rules/        skills/      agents/
  斜杠命令          代码规范       工作流       AI 角色
  (一键执行)        (自动检查)    (自动触发)  (角色切换)
```

### 🎯 实例：新增一个部署命令

1. **创建** `commands/deploy.md`
   - 引用 `rules/git-workflow.md` 和 `rules/performance.md`

2. **创建或更新** `skills/deploy/SKILL.md`
   - 定义自动化部署流程

3. **更新** `.claude/settings.json`
   - 确保 commands 和 skills 已启用

4. **创建或更新** `agents/devops-engineer.md`
   - 定义谁审批部署

---

## 📊 维护面板示例

创建 `MAINTENANCE.md` 追踪项目状态：

| 目录 | 上次更新 | 负责人 | 状态 | 优先级 |
|------|---------|--------|------|--------|
| `.claude/` | 2024-05-28 | @owner | ✅ | 中 |
| `commands/` | 2024-05-20 | @owner | 📝 需补充 deploy.md | 高 |
| `rules/` | 2024-05-15 | @team | ⚠️  security.md 需更新 | 高 |
| `skills/` | 2024-05-10 | @devops | ✅ | 中 |
| `agents/` | 2024-05-05 | @owner | 🔴 缺少 tech-lead | 低 |

**下周 TODO：**
```
[ ] 为知识图谱性能优化添加 Skill
[ ] 补充数据库迁移流程
[ ] 更新 performance.md
[ ] 为新成员编写入门指南
```

---

## 🚀 快速开始

### 方式一：一键初始化（推荐）
```bash
cd your-project
cp -r /path/to/ai-vibe-starter/skills ./skills
```
在 Claude Code 中说：`帮我初始化项目结构`

### 方式二：手动复制模板
1. 复制本指南中的模板
2. 根据你的项目调整
3. 提交到 git

### 方式三：参考 MindHub
1. 查看本指南中的 MindHub 例子
2. 复制你需要的部分
3. 适配到你的项目

---

## 📚 学习路径

```
初学者 → 开发者 → 技术主管

初学者:
  ✓ 查看表格对比理解用途
  ✓ 运行 /project:dev-setup
  ✓ 学习 /project:component-review

开发者:
  ✓ 使用 @frontend-expert 进行审查
  ✓ 创建自定义 /project:* 命令
  ✓ 遵守 rules/ 规范编写代码

技术主管:
  ✓ 设计 agents/
  ✓ 定义团队的 skills/
  ✓ 维护 MAINTENANCE.md
```

---

## ✅ 核心收益总结

| 功能 | 说明 | 举例 |
|------|------|------|
| 🤖 AI 理解项目 | Claude 自动加载规则和命令 | `@frontend-expert 审查这个组件` |
| ⚡ 一键执行任务 | `/project:*` 命令快速操作 | `/project:deploy` 一键部署 |
| 📚 知识共享 | 所有规范在 git 中，新成员快速上手 | 新员工第一天就能遵守团队规范 |
| 🎯 质量一致 | rules/ 确保代码规范统一 | 所有 PR 都符合团队标准 |
| 👥 角色清晰 | agents 定义不同岗位的工作方式 | `@ai-specialist` 处理 AI 问题 |
| 🔄 高度可复用 | skills 可在多个项目间共享 | 用 `skills/deploy-vercel/` 在多个项目中 |

---

## 🎓 小白总结

1. **`.claude/`** — 项目的"档案"，告诉 Claude 你的项目是啥
2. **`commands/`** — 快捷键，直接 `/project:xxx` 执行常见任务
3. **`rules/`** — 团队的"宪法"，定义代码应该长什么样
4. **`skills/`** — 自动化工作流，说一句话 Claude 自动帮你做
5. **`agents/`** — 专家角色，用 `@角色名` 切换不同的视角

**最简单的用法**：
```
初始化：/project:dev-setup
审查代码：@frontend-expert 帮我看看
部署：/project:deploy
```

---
