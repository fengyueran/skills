---
name: "react-development"
description: "作为 React 开发总入口，统一路由编写、重构、评审、调试、性能优化、组件生成和 FSD 模块搭建等任务。用于用户提出任意 React 开发需求时，先判断任务类型，再按需读取和组合相关 React skills，而不是盲目加载所有 React 技能。"
---

# 应用 React 开发总入口

将此 skill 作为 React 任务的总入口，用于选择后续要读取的具体 skills。

## 默认策略

1. 总是先读取 `references/react-skill-map.md`。
2. 对所有通用 React 改动，优先使用 `react-coding-standard`。
3. 对模式选择、组件架构、状态放置问题，追加 `react-patterns`。
4. 只有当任务明显属于某个子领域时，才追加对应 skill。
5. 不要为了“更全面”而自动同时加载所有 React 相关 skills。

## 路由规则

### 通用编写、重构、评审、调试

- 首选：`react-coding-standard`
- 适用：组件编写、Hook 调整、review、调试、修复规范性错误

### 模式选择与组件架构

- 首选：`react-patterns`
- 适用：组件拆分、compound components、custom hook 抽取、状态放置、现代 React 组织方式

### 性能优化

- 首选窄技能：`react-component-performance`
- 首选广技能：`react-performance-optimization`
- 补充可选：`vercel-react-best-practices`
- 规则：
  - 组件级慢渲染、重渲染抖动、列表卡顿：优先 `react-component-performance`
  - 包体积、代码分割、虚拟列表、并发特性：优先 `react-performance-optimization`
  - Next.js 或 Vercel 风格的性能建议：补充 `vercel-react-best-practices`
  - 不要默认同时使用 `react-component-performance` 和 `react-performance-optimization`

### 设计转组件

- 使用：`react:components`
- 适用：从 Stitch 设计稿生成 React 组件
- 不适用：普通 React 业务开发

### FSD 结构与模块搭建

- 使用：`fsd-module-generator`
- 适用：需要新建或扩展 FSD module、slice、层级导出

### 高复杂度 React 组件拆分

- 条件使用：`component-refactoring`
- 适用：目标仓库是 Dify 前端，且组件复杂度高
- 不适用：通用 React 项目

## 完成标准

- 已根据任务类型选择最合适的 React skill 组合
- 至少有一个明确的主 skill，而不是并列堆叠多个相近技能
- 若追加其他 skill，理由与任务类型一致
