---
name: "react-coding-standard"
description: "基于 React 官方 Rules of React 应用 React 编码规范。用于编写、重构、评审或调试 React 组件和自定义 Hook，尤其适用于检查 render 纯度、不可变性、Hooks 调用规则，以及 useEffect 的正确使用。"
---

# React 编码规范

在修改 React 组件或自定义 Hook 之前使用此 skill。

## 工作流

1. 读取 `references/react-coding-standard.md`。
2. 按以下优先级应用规则：
   - render 纯度
   - props、state 和 Hook 输入的不可变性
   - Hook 的调用位置和顺序
   - `useEffect` 的正确使用
   - 组件拆分策略与模式选择
3. 编写代码时：
   - 保持 render 无副作用
   - 优先在 render 中做普通计算，而不是滥用 `useEffect`
   - 用户动作触发的逻辑优先放在事件处理函数中，而不是 Effect 中
   - 仅在组件或自定义 Hook 的顶层调用 Hook
   - 先判断是否保持单组件，再考虑提取 custom hook、子组件或其他更合适的组织模式
4. 评审代码时：
   - 报告违反规范的具体问题
   - 附上文件和行号引用
   - 解释行为风险，而不是只给出风格偏好

## 参考文件

- 完整规范：`references/react-coding-standard.md`
- 核心工作流：`core/SKILL.core.md`
- Codex 适配：`adapters/codex/SKILL.md`
- Claude 适配：`adapters/claude/SKILL.md`
- Antigravity 适配：`adapters/antigravity/SKILL.md`
- Cursor 适配：`adapters/cursor/SKILL.md`
