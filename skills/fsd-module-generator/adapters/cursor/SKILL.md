# fsd-module-generator (cursor adapter)

在 Cursor 中执行时：

1. 先遵循 `../../core/SKILL.core.md` 的通用流程与约束。
2. 必要时按需读取 `references/` 中对应文档，不做无关加载。
3. 结合 Cursor 的编辑器内工作流、上下文读取方式与输出习惯执行。
4. 若与 core 冲突，以本适配文件和当前会话约束为准，并回写 core 的通用部分。
