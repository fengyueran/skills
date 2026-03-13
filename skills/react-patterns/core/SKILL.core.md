---
name: "react-patterns"
description: "提供 React 组件组织、组合方式、Hook 抽取、状态放置与现代 React 模式选择指南。用于设计或重构 React 组件架构、判断组件应保持单体还是拆分、选择 custom hook / compound components / provider / context 等模式，或在 React 18/19 场景下决定更合适的实现方式。"
---

# 应用 React 模式指南

将此 skill 用于回答“应该采用哪种 React 组织模式”。

## 默认策略

1. 先识别问题是组件模式、Hook 模式、状态模式，还是现代 React 模式。
2. 只读取与当前问题相关的 reference 文件。
3. 先给出最小可行模式，不默认推荐最复杂方案。
4. 明确说明为什么不选相邻模式。

## 按问题类型读取

### 组件组织与拆分

- 读取：`references/component-patterns.md`
- 适用：单组件、拆子组件、compound components、container-presentational、slot/children 设计

### Hook 抽取与逻辑复用

- 读取：`references/hook-patterns.md`
- 适用：何时提取 custom hook、何时不要抽、表单/请求/交互逻辑复用

### 状态放置与共享

- 读取：`references/state-patterns.md`
- 适用：state 放在本地、提升到父组件、用 context、还是用外部 store

### 现代 React 模式

- 读取：`references/modern-react-patterns.md`
- 适用：Server/Client components、React 18/19 hooks、optimistic UI、compiler 相关判断

## 输出要求

- 先给模式选择结论
- 再说明原因和主要 tradeoff
- 若用户在两个模式间犹豫，给出清晰判断边界
