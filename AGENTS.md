## Skills

Skill 是一组本地指令，存放在 `SKILL.md` 文件中。

## 使用方式

- 当用户明确提到某个 skill，或任务意图与该 skill 明确匹配时，使用对应 skill。
- 只打开该 skill 目录下与当前任务直接相关的文件。
- 能通过 `scripts/` 执行的逻辑，优先执行脚本而不是在对话中重复长逻辑。
- 保持上下文精简，避免加载无关参考资料。
- 跨编辑器场景优先读取 `core/SKILL.core.md`，再读取目标编辑器的 `adapters/<editor>/SKILL.md`。

## 仓库约定

- Core 路径：`skills/<skill-name>/core/SKILL.core.md`
- 适配层路径：`skills/<skill-name>/adapters/<editor>/SKILL.md`
- 可选目录：`references/`、`scripts/`、`assets/`、`tests/`
- Skill 名称使用小写 kebab-case 格式。
- 规则冲突时，以编辑器适配层为准；通用流程仍回写到 core。
