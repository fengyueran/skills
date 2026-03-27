---
name: "git-workflow"
description: "主流 Git 开发与发布工作流指南。用于新功能开发时选择分支策略、命名 feature branch、处理功能分支合并、决定何时 rebase 或 merge、管理 hotfix，以及在库或应用发布时决定是否先合并到 main/master 再打 tag 和发布。"
---

# 应用 Git 工作流

将此 skill 用于选择 Git 分支、合并和发布流程。

## 默认策略

1. 长期主线使用 `main` 或 `master`。
2. 新功能从主分支切出短生命周期 `feature/*` 分支。
3. 开发完成后合并回主分支；团队协作通常通过 PR，单人开发可在本地验证后直接合并。
4. 正式发布总是基于主分支进行，而不是直接从 feature 分支发布。
5. 只有预发布场景才允许从非主分支产出 `alpha` / `beta` / `rc`。

## 按任务类型读取

### 新功能开发

- 读取：`references/feature-development.md`
- 适用：创建 feature branch、同步主分支、提交、合并

### 发布与热修复

- 读取：`references/release-workflow.md`
- 适用：版本发布、tag、release branch、hotfix branch、预发布

### 命名与提交规范

- 读取：`references/branch-and-commit-conventions.md`
- 适用：branch naming、commit message、merge / PR 标题

## 输出要求

- 先给推荐工作流
- 再给最小命令序列
- 如存在替代方案，补充 tradeoff
