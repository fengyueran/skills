---
name: "example-skill"
description: "示例 skill 在 Claude 中的适配文件。用于在 Claude 中查看或使用多编辑器兼容 skill 的最小模板结构，包括 core 流程与各编辑器 adapters 的组织方式。"
---

# example-skill (claude adapter)

在 Claude 中执行时：

1. 先遵循 `../../core/SKILL.core.md` 的通用流程。
2. 再应用 Claude 平台约束（工具调用、上下文窗口、输出习惯）。
3. 与 core 冲突时，以本适配文件为准并同步修正 core。
