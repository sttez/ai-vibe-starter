---
name: remove-project
description: >
  移除 AI Vibe Coding 项目结构。Use when users mention 移除项目结构、
  remove AI structure、卸载初始化、清理 Claude Code 目录、撤销初始化。
  Do NOT use when user only wants to delete a single file.
allowed-tools: Read, Bash(rm:*), Bash(rmdir:*), Bash(ls:*), Bash(grep:*), Bash(sed:*)
---

# remove-project Skill

完整移除由 init-project Skill 创建的所有文件和目录，将项目恢复到初始化之前的状态。

---

## 执行流程

### Step 1：确认当前目录

```bash
pwd
ls -la
```

确认用户在项目根目录，检查初始化文件是否存在。

### Step 2：预览将要删除的内容

告知用户以下内容将被删除（见 `references/checklist.md` 完整列表），**等待用户明确确认后再继续**。

### Step 3：运行移除脚本

用户确认后执行：

```bash
bash scripts/remove.sh
```

### Step 4：输出移除结果

```
=== 移除报告 ===
[✓] 多平台配置文件已删除
[✓] .claude/ 已删除
[✓] commands/ rules/ skills/ agents/ 已删除
[✓] .gitignore 已清理
=== 完成 ===
项目已恢复为初始化前的状态
```

---

## ⚠️ Gotchas

- **执行前必须等待用户明确确认** — 删除操作不可撤销，必须二次确认
- **不要删除用户自己的文件** — 只删除 init-project 创建的文件，不动其他内容
- **若 .github/ 下还有其他文件** — 只删除 copilot-instructions.md，不删除整个 .github/ 目录
- **若 .cursor/ 下还有其他文件** — 只删除 rules/project.mdc，不删除整个 .cursor/ 目录
- **不要删除 .gitignore 本身** — 只清理 init-project 写入的那几行
