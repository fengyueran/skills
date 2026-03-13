---
name: "react-development"
description: "React 开发总入口在 Cursor 中的适配文件。用于在 Cursor 中处理 React 相关任务时，先读取 React skill 路由表，再按任务类型选择 react-coding-standard、react-patterns 或其他更具体的 React skills。"
---

# react-development（cursor 适配）

在 Cursor 中：

1. 先读取 `../../references/react-skill-map.md`。
2. 先把 `react-development` 当作分发器，而不是直接执行所有细则的 skill。
3. 默认先使用 `react-coding-standard`，再按任务决定是否追加其他 React skills。
4. 当多个 skill 能处理同一问题时，优先选择更窄、更针对当前任务的那个。
