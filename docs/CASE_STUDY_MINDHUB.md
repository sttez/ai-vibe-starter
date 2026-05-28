# 案例研究：MindHub 项目

本文档通过 **MindHub**（AI 驱动的知识工作台）项目，展示如何使用 ai-vibe-starter 的五大目录来组织和维护一个现实的 AI-友好项目。

---

## 项目背景

**MindHub** 是一个 Next.js + TypeScript + Tailwind CSS 的 Web 应用，包含以下核心功能：
- 资源工作台（Bento grid 卡片 + AI 摘要）
- 任务流编辑器（React Flow 拖拽）
- 知识图谱可视化（Cytoscape.js）
- AI 洞察分析
- Supabase 后端集成

**技术栈**：Next.js 16 + TypeScript + Tailwind CSS v4 + shadcn/ui

---

## 📍 MindHub 的完整文件结构

使用 ai-vibe-starter 后，MindHub 的目录应该是：

```
MindHub/
├── CLAUDE.md                          # Claude Code 项目说明
├── CLAUDE.local.md                    # 本地开发配置
├── AGENTS.md                          # OpenAI Codex 配置
├── .aider.instructions.md             # Aider 配置
├── .github/
│   └── copilot-instructions.md        # GitHub Copilot
├── .cursor/
│   └── rules/
│       └── project.mdc                # Cursor rules
├── .claude/
│   ├── settings.json                  # 🔓 团队共享配置
│   └── settings.local.json            # 🔒 本地配置
├── commands/
│   ├── README.md
│   ├── dev-setup.md                   # /project:dev-setup
│   ├── component-review.md            # /project:review
│   ├── fix-type-errors.md             # /project:fix-types
│   ├── deploy.md                      # /project:deploy
│   └── db-migration.md                # /project:db-migrate
├── rules/
│   ├── README.md
│   ├── code-style.md                  # TypeScript + React 规范
│   ├── testing.md                     # Jest + React Testing Library
│   ├── api-design.md                  # Route Handlers 设计规范
│   ├── component-patterns.md          # React/Next.js 组件模式
│   ├── performance.md                 # Core Web Vitals 目标
│   ├── git-workflow.md                # Git 分支和提交规范
│   └── security.md                    # 安全审查清单
├── skills/
│   ├── init-project/                  # 来自 ai-vibe-starter
│   ├── setup-supabase/                # 配置 Supabase 集成
│   ├── migrate-db/                    # 数据库迁移
│   ├── deploy-vercel/                 # Vercel 部署
│   └── performance-audit/             # 性能审计
├── agents/
│   ├── README.md
│   ├── frontend-expert.md             # React/Next.js 专家
│   ├── backend-engineer.md            # API/DB 工程师
│   ├── devops-engineer.md             # 部署和基础设施
│   ├── ai-specialist.md               # AI 集成专家
│   └── tech-lead.md                   # 技术负责人
├── src/
│   ├── app/
│   ├── components/
│   ├── services/
│   ├── lib/
│   ├── contexts/
│   └── types/
├── docs/
│   ├── README.md
│   └── architecture.md
├── package.json
├── next.config.ts
├── tsconfig.json
└── .gitignore
```

---

## 1️⃣ `.claude/settings.json` 示例

```json
{
  "version": "1.0",
  "project": {
    "name": "MindHub",
    "description": "AI 驱动的知识工作台 Web 应用",
    "language": ["TypeScript"],
    "framework": ["Next.js 16", "React", "Tailwind CSS", "shadcn/ui"],
    "backend": ["Supabase", "Node.js"],
    "ai-integration": ["DeepSeek API", "Firecrawl"]
  },
  "claude-instructions": {
    "enabled": true,
    "path": "../CLAUDE.md"
  },
  "rules": {
    "enabled": true,
    "path": "../rules",
    "auto-load": true,
    "priority": [
      "code-style.md",
      "testing.md",
      "component-patterns.md"
    ]
  },
  "commands": {
    "enabled": true,
    "path": "../commands",
    "frequently-used": [
      "dev-setup.md",
      "component-review.md",
      "deploy.md"
    ]
  },
  "skills": {
    "enabled": true,
    "path": "../skills",
    "auto-trigger": {
      "setup-supabase": ["supabase", "数据库", "集成"],
      "migrate-db": ["迁移", "migration", "数据库变更"],
      "deploy-vercel": ["部署", "deploy", "生产", "production"],
      "performance-audit": ["性能", "性能优化", "Core Web Vitals"]
    }
  },
  "agents": {
    "enabled": true,
    "path": "../agents"
  },
  "privacy": {
    "exclude-patterns": [
      ".env.local",
      "*.key",
      "secrets/",
      "node_modules/",
      ".next/",
      "out/"
    ],
    "max-context-files": 80
  },
  "typescript": {
    "strict": true,
    "target-version": "ES2020"
  },
  "nextjs": {
    "app-router": true,
    "version": "16"
  }
}
```

---

## 2️⃣ `commands/` 示例

### `/project:dev-setup` — 开发环境快速设置

```markdown
---
name: dev-setup
description: >
  设置本地开发环境。Install dependencies, create .env.local,
  start dev server. Triggered by: dev setup、环境配置、初始化开发。
trigger-keywords:
  - dev setup
  - 开发环境
  - 初始化开发
---

# /project:dev-setup — 开发环境设置

## 📋 执行流程

### Step 1: 安装依赖
\`\`\`bash
npm install
\`\`\`

### Step 2: 配置环境变量
创建 `.env.local`，复制以下模板：

\`\`\`bash
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
NEXT_PUBLIC_AI_PROVIDER=deepseek
NEXT_PUBLIC_AI_API_KEY=your-api-key
NEXT_PUBLIC_AI_BASE_URL=https://api.deepseek.com
NEXT_PUBLIC_AI_MODEL=deepseek-chat
NEXT_PUBLIC_FIRECRAWL_API_KEY=your-firecrawl-key
\`\`\`

### Step 3: 启动开发服务器
\`\`\`bash
npm run dev
\`\`\`

打开 http://localhost:3000

## ✅ 完成检查

```
[ ] npm install 成功
[ ] .env.local 已创建并配置
[ ] dev server 运行在 http://localhost:3000
[ ] 可以看到 MindHub 首页
```

## 🔗 相关规则

参考：
- rules/code-style.md
- skills/setup-supabase/SKILL.md
```

### `/project:component-review` — 组件代码审查

```markdown
---
name: component-review
description: >
  审查 React 组件。Check component patterns, hooks usage,
  accessibility, styling. Use when reviewing src/components/*.
---

# /project:component-review — 组件审查

## 📋 审查清单

### 组件结构
- [ ] 是否遵循 rules/component-patterns.md？
- [ ] Props 是否有类型定义（TypeScript）？
- [ ] 是否使用了不必要的 state？

### 性能
- [ ] 是否有不必要的重新渲染？
- [ ] 是否正确使用了 useMemo/useCallback？
- [ ] 是否按 rules/performance.md 优化？

### 可访问性
- [ ] 是否有合理的 ARIA 标签？
- [ ] 键盘导航是否正常？
- [ ] 对比度是否符合 WCAG AA？

### 样式
- [ ] 是否使用了 Tailwind CSS 规范？
- [ ] 是否适配响应式设计？
- [ ] 是否有 dark mode 支持？

### 测试
- [ ] 是否有单元测试？
- [ ] 是否有故事书（Storybook）？
- [ ] 是否符合 rules/testing.md？

## 📝 输出示例

```
=== 组件审查结果 ===
📁 components/ResourceWorkbench.tsx

✅ 优点:
  - Props 类型完整
  - 使用了 React.memo 优化重渲染
  - 无障碍支持完善

⚠️ 建议:
  - 将 useFetchResources hook 提取到 hooks/ 目录
  - 添加加载状态的骨架屏

🔴 需修复:
  - 未处理网络错误情况
  - TypeScript any 类型在第 42 行
```
```

### `/project:deploy` — 部署前检查

```markdown
---
name: deploy
description: >
  部署前检查。Build validation, type checking, env setup verification.
  Triggers on: deploy、部署、发布到生产。
---

# /project:deploy — 部署检查

## ✅ 部署清单

### 代码质量
```bash
npm run type-check
npm run lint
npm run build
```

### 环境配置
- [ ] `.env.local` 是否包含所有必要的环境变量？
- [ ] 是否使用了正确的 API endpoints？

### 数据库
- [ ] 最新的数据库迁移已应用？
- [ ] Supabase 连接是否正常？

### 性能
- [ ] 是否运行了性能审计？
- [ ] Core Web Vitals 是否满足目标？

### 安全
- [ ] 是否检查了敏感信息泄露？
- [ ] 是否通过了安全扫描？

## 🚀 部署步骤

```bash
# 1. 本地验证
npm run build

# 2. 推送到主分支
git push origin main

# 3. Vercel 自动部署
# 检查 https://vercel.com/dashboard
```
```

---

## 3️⃣ `rules/` 示例

### `component-patterns.md` — React 组件模式

```markdown
---
rule-category: component-design
severity: high
applies-to: src/components/**/*.tsx
---

# React 组件模式规范

## 函数组件结构

### ✅ 推荐

```typescript
import { ReactNode } from 'react';
import { cn } from '@/lib/utils';

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
  const handleClick = () => {
    // 处理逻辑
  };

  return (
    <div className={cn('base-class', className)}>
      {isLoading ? <Skeleton /> : children}
    </div>
  );
};

MyComponent.displayName = 'MyComponent';
```

### ❌ 避免

```typescript
// 1. 使用 React.FC（已过时）
const MyComponent: React.FC = (props) => { }

// 2. Props 没有类型定义
const MyComponent = (props) => { }

// 3. 在组件体内定义其他组件
const Component = () => {
  const SubComponent = () => <div>...</div>;
  return <SubComponent />;
}
```

## Hook 使用规范

**优先级**：
1. `useState` for simple state
2. `useCallback` for event handlers
3. `useMemo` for expensive computations
4. `useEffect` only for side effects

**禁止**：
- ❌ 在条件中使用 hooks
- ❌ 过度使用 useMemo（除非有性能问题）
- ❌ useContext 中未使用 selector 导致不必要的重渲染

## 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 组件文件 | PascalCase | `ResourceCard.tsx` |
| 组件函数 | PascalCase | `export const ResourceCard` |
| Props 接口 | `${ComponentName}Props` | `ResourceCardProps` |
| 事件处理 | `handle${EventName}` | `handleDelete()` |
| 自定义 Hook | `use${FunctionName}` | `useFetchResources()` |

## 文件组织

```
components/
├── ResourceCard.tsx           # 单独文件
├── ResourceWorkbench/
│   ├── index.tsx             # 导出
│   ├── ResourceWorkbench.tsx # 主组件
│   ├── ResourceGrid.tsx      # 子组件
│   └── useResourceData.ts    # 相关 hook
```
```

### `testing.md` — 测试策略

```markdown
---
rule-category: quality-assurance
severity: high
applies-to: src/**/__tests__/**
---

# 测试策略

## 单元测试（Jest）

每个组件或 hook 需要 ≥ 80% 覆盖率。

### 组件测试

```typescript
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { ResourceCard } from './ResourceCard';

describe('ResourceCard', () => {
  it('renders with title and description', () => {
    render(<ResourceCard title="Test" description="Desc" />);
    expect(screen.getByText('Test')).toBeInTheDocument();
  });

  it('calls onDelete when delete button clicked', async () => {
    const onDelete = jest.fn();
    render(<ResourceCard onDelete={onDelete} />);
    
    await userEvent.click(screen.getByRole('button', { name: /delete/i }));
    expect(onDelete).toHaveBeenCalled();
  });
});
```

## 集成测试（Playwright）

关键用户流程必须有 e2e 测试：
- 创建/编辑/删除资源
- 知识图谱交互
- 部署流程

```bash
npm run test:e2e
```

## 运行测试

```bash
npm run test              # 单元测试
npm run test:watch       # 监听模式
npm run test:coverage    # 覆盖率报告
npm run test:e2e         # E2E 测试
```

## CI/CD 集成

所有 PR 必须通过：
- [ ] TypeScript type checking (`npm run type-check`)
- [ ] ESLint (`npm run lint`)
- [ ] 单元测试 (`npm run test`)
- [ ] 构建成功 (`npm run build`)
```

---

## 4️⃣ `skills/` 示例

### `setup-supabase/SKILL.md` — Supabase 集成

```markdown
---
name: setup-supabase
description: >
  配置 Supabase 集成。Create database schema, auth setup,
  environment variables. Use when 设置数据库、supabase集成、
  配置后端服务。
allowed-tools: 
  - Read
  - Write
  - Bash(npm:*, curl:*)
---

# setup-supabase Skill — Supabase 集成

## 执行流程

### Step 1: 验证环境变量

检查 `.env.local` 中是否包含：
- NEXT_PUBLIC_SUPABASE_URL
- NEXT_PUBLIC_SUPABASE_ANON_KEY

### Step 2: 创建数据库表

运行 `supabase-schema.sql` 中的迁移脚本，包括：
- resources 表（资源）
- tasks 表（任务）
- tags 表（标签）

### Step 3: 配置 RLS 策略

启用行级安全（Row Level Security）：
- 只有创建者可以编辑自己的资源
- 公开资源所有用户可读

### Step 4: 测试连接

```bash
npm run test:supabase
```

## 🔗 相关文件

- supabase-schema.sql
- src/services/supabase.ts
- .env.local

## ⚠️ 注意事项

- API Key 不要提交到 git
- 生产和开发环境使用不同的 Supabase 项目
- RLS 策略确保数据隐私
```

### `deploy-vercel/SKILL.md` — Vercel 部署

```markdown
---
name: deploy-vercel
description: >
  部署到 Vercel。Connect GitHub repo, set env vars, deploy.
  Use when 部署、部署到vercel、发布生产。
---

# deploy-vercel Skill — Vercel 部署

## 执行流程

### Step 1: 连接 GitHub 仓库

1. 访问 https://vercel.com/import
2. 导入 GitHub 仓库
3. 选择项目根目录

### Step 2: 配置环境变量

在 Vercel 项目设置中添加：
```
NEXT_PUBLIC_SUPABASE_URL=...
NEXT_PUBLIC_SUPABASE_ANON_KEY=...
NEXT_PUBLIC_AI_API_KEY=...
NEXT_PUBLIC_FIRECRAWL_API_KEY=...
```

### Step 3: 部署

```bash
git push origin main
```

Vercel 自动构建和部署。

### Step 4: 验证部署

- [ ] 访问 https://mindhub.vercel.app
- [ ] 运行性能审计
- [ ] 检查功能是否正常
```

---

## 5️⃣ `agents/` 示例

### `frontend-expert.md` — 前端专家

```markdown
---
name: frontend-expert
role: 前端开发专家
expertise:
  - React/Next.js
  - TypeScript
  - Tailwind CSS
  - 组件设计
  - 性能优化
  - 无障碍支持
trigger: "@frontend-expert" or "找前端专家" or "react问题"
---

# 👨‍💻 前端开发专家

## 我的专长

- **React/Next.js** — 函数式组件、Hooks、SSR/SSG
- **TypeScript** — 类型系统、接口设计
- **样式** — Tailwind CSS、响应式设计、Dark Mode
- **性能** — Core Web Vitals、代码分割、图片优化
- **无障碍** — ARIA、键盘导航、屏幕阅读器支持

## 我的工作方式

当你需要：
- 组件设计建议 → 使用 rules/component-patterns.md
- 性能问题诊断 → 检查 rules/performance.md
- TypeScript 错误修复 → 运行 /project:fix-types
- 代码审查 → 使用 /project:component-review

## 我的输出格式

```
=== 前端审查 ===
📁 src/components/ResourceCard.tsx

优点:
✅ 使用 React.memo 避免不必要重渲染
✅ Props 类型完整

建议:
⚠️ 图片应该使用 Next.js Image 组件
⚠️ 缺少 loading state

问题:
🔴 TypeScript any 类型 on line 42
🔴 缺少单元测试
```

## 调用我的方式

```
@frontend-expert 这个组件的性能如何？

或

我想要从 React 最佳实践的角度审查这段代码
```
```

### `ai-specialist.md` — AI 集成专家

```markdown
---
name: ai-specialist
role: AI 集成工程师
expertise:
  - AI API 集成
  - 流式输出处理
  - 提示词工程
  - 错误处理
  - 成本优化
trigger: "@ai-specialist" or "AI问题" or "deepseek集成"
---

# 🤖 AI 集成专家

## 我的专长

- **API 集成** — DeepSeek、OpenAI 兼容接口
- **流式处理** — Server-Sent Events (SSE) 实现
- **提示工程** — 编写有效的 prompt
- **错误处理** — 超时、速率限制、重试
- **成本优化** — Token 使用、模型选择

## 我的输出格式

```
=== AI 集成审查 ===
功能: 生成资源摘要

性能:
✅ 使用了流式输出
⚠️ Token 消耗可优化

错误处理:
🔴 缺少超时处理
🔴 无重试机制

建议:
1. 添加 5s 超时
2. 实现指数退避重试
3. 使用缓存避免重复调用
```
```

---

## 📊 维护面板

创建 `MAINTENANCE.md` 追踪 MindHub 的维护状态：

```markdown
# MindHub 维护面板

## 核心指标

| 指标 | 目标 | 当前 | 状态 |
|------|------|------|------|
| 测试覆盖率 | ≥ 80% | 76% | 🟡 需改进 |
| TypeScript 错误 | 0 | 0 | ✅ |
| 性能 (LCP) | < 2.5s | 2.1s | ✅ |
| Bundle 大小 | < 200KB | 185KB | ✅ |

## 最近更新

| 目录 | 上次更新 | 负责人 | 状态 |
|------|---------|--------|------|
| commands/ | 2024-05-28 | @owner | ✅ |
| rules/ | 2024-05-20 | @team | ✅ |
| skills/ | 2024-05-15 | @devops | ⚠️  需更新 deploy skill |
| agents/ | 2024-05-10 | @owner | ✅ |

## 下周 TODO

- [ ] 为知识图谱添加性能优化
- [ ] 补充数据库迁移 skill
- [ ] 更新 performance.md
- [ ] 代码审查覆盖率改进
```

---

## 🚀 为 MindHub 完整应用 ai-vibe-starter

### 第 1 步：复制文件

```bash
cd MindHub
cp -r /path/to/ai-vibe-starter/skills ./skills
```

### 第 2 步：创建五大目录

```bash
# 使用 init-project skill
# 或手动创建
mkdir -p commands rules agents

# 将上面的示例文件放入相应目录
cp example-commands/* commands/
cp example-rules/* rules/
cp example-agents/* agents/
```

### 第 3 步：更新 `.claude/settings.json`

使用上面的示例配置，修改为 MindHub 的实际配置。

### 第 4 步：在 Claude Code 中开始使用

```
@claude 帮我审查这个组件
/project:component-review
@frontend-expert 这个性能如何？
```

---

## 📖 学习路径

```
初学者 → 开发者 → 技术主管

1. 初学者: /project:dev-setup, /project:component-review
2. 开发者: @frontend-expert, /project:deploy
3. 主管: @tech-lead, MAINTENANCE.md, 管理所有 agents
```

---

## ✅ 核心收益

| 收益 | 说明 |
|------|------|
| 🤝 知识共享 | 所有规则在 git 中，新成员快速上手 |
| ⚡ 开发加速 | `/project:*` 命令一键执行常见任务 |
| 🎯 质量一致 | rules/ 确保团队代码规范统一 |
| 🔄 可复用 | skills 可在多个项目间共享 |
| 👥 角色清晰 | agents 定义不同岗位的工作方式 |

---
