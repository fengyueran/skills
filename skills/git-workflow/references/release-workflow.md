# 发布流程

## 目录

- 1. 正式发布
- 2. 预发布
- 3. Hotfix
- 4. 发布后清理

## 1. 正式发布

主流推荐：

- 先把功能分支合并到 `main` / `master`
- 在主分支确认构建、测试、changelog、版本号
- 从主分支打 tag
- 基于 tag 或主分支 commit 发布

标准顺序：

1. `feature/*` 合并到 `main`
2. `main` 上更新版本和 changelog
3. 打 `vX.Y.Z` tag
4. 发布到 npm / registry

结论：

- 正式 release 不应直接从 `feature/*` 分支发布

## 2. 预发布

适用：

- alpha
- beta
- rc
- canary

允许：

- 从功能分支或 release 分支发布预发布版本

要求：

- 明确带预发布标识
- 不与正式 tag 混淆

## 3. Hotfix

适用：

- 线上紧急问题
- 已发布版本必须快速修复

主流做法：

1. 从当前主分支或最近发布 tag 切出 `hotfix/*`
2. 修复并验证
3. 合并回主分支
4. 重新打补丁版本 tag 并发布

## 4. 发布后清理

- 删除已合并的功能分支
- 确认远端分支已清理
- 保证 tag 与发布版本一致
