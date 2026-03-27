# 新功能开发流程

## 目录

- 1. 默认分支策略
- 2. 开发步骤
- 3. 合并策略
- 4. 不推荐的做法

## 1. 默认分支策略

主流推荐：

- 长期主线：`main` 或 `master`
- 功能分支：`feature/<short-description>`
- 缺陷修复：`fix/<short-description>`
- 热修复：`hotfix/<short-description>`

不默认采用：

- 复杂的 Git Flow 长期分支体系
- 长期存活的 feature 分支

## 2. 开发步骤

1. 从主分支拉取最新：

```bash
git checkout main
git pull origin main
```

2. 创建功能分支：

```bash
git checkout -b feature/user-profile
```

3. 在功能分支上开发，并做小步提交。

4. 开发过程中定期同步主分支：

```bash
git fetch origin
git rebase origin/main
```

5. 推送远端：

```bash
git push -u origin feature/user-profile
```

6. 合并回主分支：

- 团队协作：通常通过 PR 合并
- 单人开发：完成验证后可直接在本地合并回主分支

## 3. 合并策略

默认推荐：

- 功能分支完成后合并到主分支
- 保持分支生命周期短
- 合并前确保测试和代码评审通过

协作差异：

- 团队协作：通常通过 PR 合并
- 单人开发：可在本地验证后直接 merge / rebase 后再合并

推荐选择：

- 希望历史更线性：`rebase` 后再 merge / squash merge
- 希望保留功能边界：使用 squash merge

## 4. 不推荐的做法

- 长期在本地分支堆积大量未同步提交
- 从旧主分支切新功能分支
- 未经验证直接把功能分支推到主分支
- 在 feature 分支上做正式 release
