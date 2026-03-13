---
name: "example-skill"
description: "跨编辑器 skill 模板。用于创建新 skill、验证目录结构、或作为编写新 skills 时的最小参考实现。触发场景包括需要一个基础 skill 骨架、需要查看 core 和 adapters 的组织方式，或需要复制一个兼容多编辑器的起点。"
---

# 示例 Skill

这是一个最小但完整的 skill 模板，可作为创建新 skill 时的参考实现。

## 工作流

1. 先读取 `core/SKILL.core.md`，理解通用流程。
2. 根据当前编辑器读取对应的 `adapters/<editor>/SKILL.md`。
3. 只在需要时继续补充 `references/`、`scripts/`、`assets/`、`tests/`。

## 参考文件

- 通用流程：`core/SKILL.core.md`
- Codex 适配：`adapters/codex/SKILL.md`
- Claude 适配：`adapters/claude/SKILL.md`
- Antigravity 适配：`adapters/antigravity/SKILL.md`
- Cursor 适配：`adapters/cursor/SKILL.md`
