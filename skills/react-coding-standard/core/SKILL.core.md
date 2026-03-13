---
name: "react-coding-standard"
description: "基于 React 官方 Rules of React 应用 React 编码规范。用于编写、重构、评审或调试 React 组件和自定义 Hook，尤其适用于检查 render 纯度、不可变性、Hooks 调用规则，以及 useEffect 的正确使用。"
---

# 应用 React 编码规范

将附带的参考文档作为 React 代码决策的唯一准绳。

## 先读这里

- 在修改 React 代码之前，总是先读取 `references/react-coding-standard.md`。
- 将该参考文档视为正确性规范，而不是风格偏好列表。

## 应用这些规则

1. 保持组件和 Hook 在 render 期间是纯的。
2. 不要修改 props、state、Hook 参数，或已经传入 JSX 的值。
3. 让 React 调用组件和 Hook，不要直接调用组件函数。
4. 只在 React 组件或自定义 Hook 的顶层调用 Hook。
5. 仅在渲染后需要与外部系统同步时使用 `useEffect`。
6. 先判断是否保持单组件，再决定提取 custom hook、子组件或其他更合适的组织模式。

## 按任务类型使用

### 编写或重构

- 读取 `references/react-coding-standard.md` 的第 1 到第 8 节。
- 优先在 render 时做简单计算，避免引入不必要的 state 和 Effect。
- 保持逻辑局部、可预测。
- 对组件拆分按以下顺序判断：单组件 -> custom hook -> 子组件 -> 其他更重的模式

### 评审

- 读取 `references/react-coding-standard.md` 第 9 节的评审清单。
- 只指出违反规范或高度可能违反规范的代码。
- 优先关注行为和正确性问题，而不是个人风格偏好。

### 调试

- 优先从 render 纯度、值修改、Hook 顺序违规开始排查。
- 如果组件出现异常重渲染或 Hook 相关错误，先检查第 2 到第 6 节。

## 完成标准

- React 代码符合附带规范。
- 所有评审问题都能在参考文档中找到依据。
- 说明中明确指出违反的规则和可能的运行时影响。
