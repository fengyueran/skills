---
name: "fsd-module-generator"
description: "Generate or extend FSD modules in frontend projects across the six FSD layers: app, pages, widgets, features, entities, and shared. Use when creating a new FSD module or slice, scaffolding layer structure, deciding where a feature belongs, registering index.ts exports, or checking FSD dependency boundaries."
---

# Generate FSD Module

在当前工作区按 FSD 结构创建或扩展模块，并完成导出注册与边界检查。

## 执行步骤

1. 确认层级、模块名、目标路径。
2. 如果边界不清晰，先读取 `references/splitting-guide.md` 做 layer/slice/segment 拆分。
3. 优先复用项目中已有的 `app`、`pages`、`widgets`、`features`、`entities`、`shared` 目录。
4. 按最小原则创建需要的 segment：
   - 当前 slice 内部使用：先建 `ui` 或 `model`
   - 有后端交互：增加 `api`
   - 有配置或开关：增加 `config`
   - 有可复用工具：增加 `lib`
5. 按 `references/scaffold-templates.md` 创建最小文件集与初始代码。
6. 更新对应层和 slice 的 `index.ts` 导出。
7. 对照 `references/boundaries.md` 检查依赖方向和职责边界。
8. 若涉及组件化、职责拆分、可测试性，再读取 `references/implementation-guide.md` 做实现质量自检。

## 快速规则

- 模块目录统一使用 `kebab-case`
- TypeScript 优先
- 非 `app` 层禁止 `export default`
- 公共导出统一走层级 `index.ts`
- `app` 与 `shared` 直接按 segment 组织，不创建 slice

## 参考文件

- 完整通用流程：`core/SKILL.core.md`
- Codex 适配：`adapters/codex/SKILL.md`
- Claude 适配：`adapters/claude/SKILL.md`
