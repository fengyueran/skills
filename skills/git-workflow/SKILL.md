---
name: "git-workflow"
description: "主流 Git 开发与发布工作流指南。用于新功能开发时选择分支策略、命名 feature branch、处理功能分支合并、决定何时 rebase 或 merge、管理 hotfix，以及在库或应用发布时决定是否先合并到 main/master 再打 tag 和发布。"
---

# Git 工作流

用于回答“这个开发任务应该采用什么 Git 分支和发布流程”。

## 工作流

1. 先判断当前任务属于哪一类：
   - 新功能开发
   - 缺陷修复 / 热修复
   - 发布前整理
   - 正式发布或预发布
2. 默认采用主流做法：
   - `main` / `master` 作为长期主线
   - 短生命周期 `feature/*` 分支
   - 功能分支完成后合并回主分支
   - 正式发布从主分支打 tag 和发布
3. 只读取与当前任务直接相关的 reference 文件。

## 读取规则

- 新功能开发与分支协作：读取 `references/feature-development.md`
- 发布、打 tag、hotfix、预发布：读取 `references/release-workflow.md`
- 分支命名与提交约定：读取 `references/branch-and-commit-conventions.md`

## 输出要求

- 明确推荐当前任务应该使用的分支策略
- 给出最小可执行的 Git 操作顺序
- 如果存在替代方案，说明为什么当前不优先选它

## 参考文件

- 核心工作流：`core/SKILL.core.md`
- Feature 开发流程：`references/feature-development.md`
- 发布流程：`references/release-workflow.md`
- 命名与提交约定：`references/branch-and-commit-conventions.md`
- Codex 适配：`adapters/codex/SKILL.md`
- Claude 适配：`adapters/claude/SKILL.md`
- Antigravity 适配：`adapters/antigravity/SKILL.md`
- Cursor 适配：`adapters/cursor/SKILL.md`
