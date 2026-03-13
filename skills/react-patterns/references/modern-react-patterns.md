# 现代 React 模式

用于 React 18/19 相关模式选择。

## 目录

- 1. Server / Client Components
- 2. Optimistic UI
- 3. Action State
- 4. Compiler 与 memoization

## 1. Server / Client Components

适用：

- 能在服务端完成的数据获取和静态渲染，优先放在服务端
- 只有需要交互、浏览器 API、客户端状态时才进入 client component

原则：

- 尽量让 client 边界更小
- 不要把整个页面都变成 client component

## 2. Optimistic UI

适用：

- 用户操作需要快速反馈
- 后端成功率高，失败时能回滚

可以考虑：

- `useOptimistic`

## 3. Action State

适用：

- 表单提交
- 用户动作驱动的异步流程

可以考虑：

- `useActionState`

## 4. Compiler 与 memoization

原则：

- 不要默认到处手写 `useMemo` / `useCallback`
- 先看是否真有性能瓶颈
- 若团队使用 React Compiler，遵循其约定，避免过度手工优化
