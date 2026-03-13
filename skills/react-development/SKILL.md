---
name: "react-development"
description: "作为 React 开发总入口，统一路由编写、重构、评审、调试、性能优化、组件生成和 FSD 模块搭建等任务。用于用户提出任意 React 开发需求时，先判断任务类型，再按需读取和组合相关 React skills，而不是盲目加载所有 React 技能。"
---

# React 开发总入口

用于所有 React 相关任务的统一入口。先判断任务类型，再按需读取对应 skill。

## 工作流

1. 先读取 `references/react-skill-map.md`。
2. 识别当前任务属于哪一类：
   - 通用编码、重构、评审、调试
   - 模式选择与组件架构
   - 性能优化
   - 组件生成
   - FSD 结构搭建
3. 默认先应用 `react-coding-standard`。
4. 遇到模式选择、组件拆分、状态放置问题时，追加 `react-patterns`。
5. 只追加读取与当前任务直接相关的 skill，不默认全量加载。
6. 如果多个 skill 重叠，优先选择范围更窄、针对性更强的那个。

## 路由原则

- React 通用代码任务：先用 `react-coding-standard`
- React 组件组织、Hook 抽取、状态模式：追加 `react-patterns`
- React 性能问题：在标准规范之外，再选一个性能 skill
- 设计转组件：使用专门的组件生成 skill
- FSD 模块搭建：使用 `fsd-module-generator`
- 避免同时加载两个高重叠的性能 skill，除非用户明确要求

## 参考文件

- 技能路由表：`references/react-skill-map.md`
- 核心工作流：`core/SKILL.core.md`
- Codex 适配：`adapters/codex/SKILL.md`
- Claude 适配：`adapters/claude/SKILL.md`
- Antigravity 适配：`adapters/antigravity/SKILL.md`
- Cursor 适配：`adapters/cursor/SKILL.md`
