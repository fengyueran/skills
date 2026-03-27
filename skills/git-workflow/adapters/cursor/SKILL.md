---
name: "git-workflow"
description: "Git 工作流在 Cursor 中的适配文件。用于在 Cursor 中选择主流的 feature branch、功能分支合并、发布与 hotfix 流程，并按任务读取对应参考文件。"
---

# git-workflow（cursor 适配）

在 Cursor 中：

1. 先读取 `../../core/SKILL.core.md`。
2. 再按任务类型读取对应 reference 文件，不默认全量加载。
3. 默认推荐主流、最稳的工作流，不主动引入复杂 Git Flow。
4. 优先给出可执行命令顺序，而不是抽象原则。
