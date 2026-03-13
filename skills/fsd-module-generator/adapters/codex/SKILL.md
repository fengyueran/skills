# fsd-module-generator (codex adapter)

在 Codex 中执行时：

1. 先遵循 `../../core/SKILL.core.md` 的通用流程与约束。
2. 必要时按需读取 `references/` 中对应文档，不做无关加载。
3. 结合 Codex 当前会话的工具权限、输出格式与验证要求执行。
4. 若与 core 冲突，以本适配文件和当前会话约束为准，并回写 core 的通用部分。
