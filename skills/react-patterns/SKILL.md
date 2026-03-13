---
name: "react-patterns"
description: "提供 React 组件组织、组合方式、Hook 抽取、状态放置与现代 React 模式选择指南。用于设计或重构 React 组件架构、判断组件应保持单体还是拆分、选择 custom hook / compound components / provider / context 等模式，或在 React 18/19 场景下决定更合适的实现方式。"
---

# React 模式指南

用于回答“React 代码应该怎么组织”，而不是“React 代码哪些写法违规”。

## 使用方式

1. 先判断当前问题属于哪一类：
   - 组件组织与拆分
   - 逻辑复用与 Hook 抽取
   - 状态放置与共享范围
   - 组合模式选择
   - React 18/19 新模式
2. 只读取和当前任务直接相关的 reference 文件，不默认全量加载。
3. 先给出模式选择结论，再给出理由和替代方案。

## 读取规则

- 组件拆分、单一职责、`single component / custom hook / subcomponents / container-presentational` 选择：
  读取 `references/component-patterns.md`
- Hook 何时抽取、抽取哪些逻辑、哪些不该抽：
  读取 `references/hook-patterns.md`
- 状态该放在哪里、何时提升、何时 context、何时外部 store：
  读取 `references/state-patterns.md`
- React 18/19、Server/Client 组件、`useOptimistic`、`useActionState` 等现代模式：
  读取 `references/modern-react-patterns.md`

## 输出要求

- 明确推荐哪种模式
- 说明为什么选它，而不是相邻替代方案
- 若存在明显 tradeoff，给出 1 到 2 个备选方案
- 避免把所有模式一起堆给用户

## 参考文件

- 组件模式：`references/component-patterns.md`
- Hook 模式：`references/hook-patterns.md`
- 状态模式：`references/state-patterns.md`
- 现代 React 模式：`references/modern-react-patterns.md`
- 核心工作流：`core/SKILL.core.md`
- Codex 适配：`adapters/codex/SKILL.md`
- Claude 适配：`adapters/claude/SKILL.md`
- Antigravity 适配：`adapters/antigravity/SKILL.md`
- Cursor 适配：`adapters/cursor/SKILL.md`
