# Skills 仓库

这个仓库用于存放可复用的 skills，并通过适配层兼容多个编辑器（如 Codex、Claude）。

## 目录结构

- `AGENTS.md`：仓库级代理说明
- `skills/`：每个 skill 一个独立目录
- `examples/`：端到端使用示例
- `tools/`：日常维护辅助脚本

推荐的 skill 结构（跨编辑器）：

- `skills/<skill-name>/core/SKILL.core.md`：编辑器无关的核心流程
- `skills/<skill-name>/adapters/codex/SKILL.md`：Codex 适配文件
- `skills/<skill-name>/adapters/claude/SKILL.md`：Claude 适配文件

兼容原则：

- 先维护 `core`，再同步到各编辑器 `adapters`
- 编辑器专属语法只写在各自 `adapters` 中
- 能共用的任务步骤、输入输出规范都放在 `core`

## 新增 Skill

1. 在 `skills/<skill-name>/` 下创建目录
2. 添加 `core/SKILL.core.md`
3. 至少添加一个适配文件（例如 `adapters/codex/SKILL.md`）
4. 按需添加 `references/`、`scripts/`、`assets/`、`tests/`

## Skill 命名

统一使用小写 kebab-case，例如：

- `release-notes-writer`
- `api-migration-helper`
