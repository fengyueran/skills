# React 编码规范

本规范基于 React 官方的 Rules of React，总结为团队可直接执行的编码约束。

适用范围：

- React 函数组件
- 自定义 Hooks
- 使用 JSX/TSX 的前端代码

不包含：

- CSS 命名规范
- 目录分层规范
- 测试框架选型
- 第三方状态管理库约定

## 1. 总原则

- 把组件和 Hook 写成可预测、可组合、可复用的代码。
- 把 render 当成纯计算过程，不在 render 中做副作用。
- 把 props、state、context 视为当前渲染快照，不直接修改。
- 让 Hook 调用位置稳定、可读、可推断。

## 2. 组件与 Hook 必须纯

### 2.1 保持幂等

- 在相同的 `props`、`state`、`context` 输入下，组件必须返回一致的输出。
- 不要在 render 中使用会导致结果变化的非确定性值，例如 `Date.now()`、`Math.random()`、随机 ID 生成。
- 如需生成一次性值，放到事件处理、Effect、lazy initializer，或使用稳定的 React 机制处理。

推荐：

```tsx
function Clock() {
  const [time, setTime] = useState(() => new Date());

  useEffect(() => {
    const id = setInterval(() => setTime(new Date()), 1000);
    return () => clearInterval(id);
  }, []);

  return <time>{time.toLocaleTimeString()}</time>;
}
```

避免：

```tsx
function Clock() {
  return <time>{new Date().toLocaleTimeString()}</time>;
}
```

### 2.2 不要在 render 中做副作用

- 不要在 render 中请求接口、操作 DOM、写日志、改全局变量、启动定时器。
- 优先把副作用写在事件处理函数里。
- 只有在确实需要“渲染后同步外部系统”时，才使用 `useEffect`。

推荐：

```tsx
function ProductPage({ title }: { title: string }) {
  useEffect(() => {
    document.title = title;
  }, [title]);

  return <h1>{title}</h1>;
}
```

避免：

```tsx
function ProductPage({ title }: { title: string }) {
  document.title = title;
  return <h1>{title}</h1>;
}
```

### 2.3 允许局部可丢弃的变更，不允许跨渲染污染

- 允许在 render 中修改函数内部刚创建的局部变量。
- 不要修改组件外部创建的对象、数组或模块级共享值。

推荐：

```tsx
function List({ items }: { items: string[] }) {
  const children = [];

  for (const item of items) {
    children.push(<li key={item}>{item}</li>);
  }

  return <ul>{children}</ul>;
}
```

避免：

```tsx
const children: JSX.Element[] = [];

function List({ items }: { items: string[] }) {
  for (const item of items) {
    children.push(<li key={item}>{item}</li>);
  }

  return <ul>{children}</ul>;
}
```

## 3. 不可变性规则

### 3.1 不要直接修改 props 和 state

- `props` 和 `state` 是当前渲染的快照。
- 更新 state 必须通过 state setter，而不是原地修改对象或数组。
- 需要变更对象或数组时，创建新值后再更新。

推荐：

```tsx
setUser((prev) => ({ ...prev, name: "Alice" }));
```

避免：

```tsx
user.name = "Alice";
setUser(user);
```

### 3.2 不要修改传入 Hook 的参数和 Hook 返回值

- 把 Hook 看成黑盒。
- 传给 Hook 的对象，不要在 Hook 内原地改写。
- Hook 返回的对象、数组、函数，也不要被调用方随意改写。

### 3.3 值一旦传入 JSX，就不要再修改

- 先把数据整理好，再放进 JSX。
- 不要先渲染，再继续修改同一个对象或数组。

## 4. React 负责调用组件和 Hook

### 4.1 不要直接调用组件函数

- 组件必须通过 JSX 使用，例如 `<Dialog />`，不要写成 `Dialog()`.
- 让 React 决定组件何时渲染、如何保留状态、如何跳过不必要的渲染。

推荐：

```tsx
return <Dialog open={open} />;
```

避免：

```tsx
return Dialog({ open });
```

### 4.2 不要把 Hook 当普通值传来传去

- 不要把某个 Hook 作为参数传入另一个组件或函数。
- 不要根据条件动态替换“要调用哪个 Hook”。
- 把 Hook 调用留在组件或自定义 Hook 的顶层。

## 5. Hooks 规则

### 5.1 只在顶层调用 Hook

- 不要在 `if`、`for`、`while`、三元表达式、短路表达式、嵌套函数里调用 Hook。
- 不要在提前 `return` 之后调用 Hook。
- 不要在 `try/catch/finally` 里调用 Hook。
- 保持每次渲染的 Hook 调用顺序完全一致。

推荐：

```tsx
function Panel({ enabled }: { enabled: boolean }) {
  const theme = useContext(ThemeContext);

  if (!enabled) {
    return null;
  }

  return <section className={theme}>content</section>;
}
```

避免：

```tsx
function Panel({ enabled }: { enabled: boolean }) {
  if (!enabled) {
    return null;
  }

  const theme = useContext(ThemeContext);
  return <section className={theme}>content</section>;
}
```

### 5.2 只在 React 函数组件或自定义 Hook 中调用 Hook

- 可以在函数组件中调用 Hook。
- 可以在自定义 Hook 中调用 Hook。
- 不要在普通工具函数、事件处理函数、类组件、异步函数中调用 Hook。

推荐：

```tsx
function useOnlineFlag() {
  const [online, setOnline] = useState(true);
  return { online, setOnline };
}
```

避免：

```tsx
async function fetchWithStatus() {
  const [online] = useState(true);
  return online;
}
```

## 6. Effect 使用规范

- 先问自己：这段逻辑是不是副作用。
- 如果只是根据 props/state 计算值，用普通变量即可，不要上 `useEffect`。
- 如果逻辑由用户动作触发，优先写在事件处理函数中。
- 只有当代码需要在渲染后与外部系统同步时，再使用 `useEffect`。

优先级：

1. render 内纯计算
2. 事件处理函数
3. `useEffect` 作为最后手段

## 7. 组件设计要求

- 保持组件和 Hook 的局部推理能力，读当前文件就能理解主要行为。
- 把可复用状态逻辑提取为自定义 Hook，把 UI 渲染留在组件中。
- 保持数据流单向，避免隐式共享和模块级可变状态。
- 让每个组件只负责表达自己的 UI 和必要交互。

## 8. 组件拆分策略

### 8.1 默认先保持单组件

- 不要把 `ui + container` 当成固定规则。
- 对于简单组件，优先保持单文件或单组件实现，避免机械拆分。
- 当拆分只会新增一层 props 透传，而不会明显提升可读性、复用性、可测试性时，不要拆。

### 8.2 优先提取 custom hook，而不是先拆 container

- 当复杂度主要来自状态管理、副作用、事件编排、数据获取、表单逻辑时，先考虑提取自定义 Hook。
- 自定义 Hook 负责复用逻辑，组件继续负责表达 UI。
- 只有在逻辑层和展示层已经明显分离时，才进一步考虑 `ui + container`。

推荐：

```tsx
function UserList() {
  const { users, loading, onRetry } = useUsers();

  if (loading) {
    return <Spinner />;
  }

  return <UserTable users={users} onRetry={onRetry} />;
}
```

### 8.3 JSX 过长时，先拆子组件

- 当一个组件包含多个清晰的 UI 区块时，优先提取子组件。
- 提取子组件的目标是缩短主组件、明确区块职责，而不是为了形式上“分层”。
- 子组件仍应保持 props 驱动，避免重新引入隐式共享状态。

### 8.4 什么时候考虑更重的组件模式

仅在满足下列特征时考虑更重的组织模式，例如 `container-presentational`：

- 上层负责数据获取、权限、路由、埋点、状态编排等逻辑
- 下层已经接近纯展示组件，只依赖 props 渲染
- 同一份 UI 可能复用在不同数据来源或不同容器中
- 需要单独测试展示层，而不带数据和副作用逻辑

不建议引入更重模式的情况：

- 组件很小，逻辑和 UI 紧密耦合
- 只有少量本地 state 和事件处理
- 拆分后只是得到一个很薄的 container 和一个很薄的 ui
- 团队最终会把大量简单组件都过度模式化

### 8.5 Props down, events up

- 数据通过 props 向下传递。
- 交互通过回调向上传递。
- 尽量避免子组件直接感知上层复杂状态结构。

### 8.6 状态尽量局部化

- 状态放在真正使用它的最近位置。
- 只有当多个子节点确实需要共享时，才提升状态。
- 避免“为了以后可能复用”而过早集中状态。

## 9. 审查清单

提交 React 代码前，至少检查以下问题：

- render 是否纯，无副作用
- 是否直接修改了 `props`、`state` 或 Hook 参数
- Hook 是否全部在顶层调用
- Hook 是否只在组件或自定义 Hook 中调用
- 是否有直接调用组件函数的写法
- 是否把本该放在事件处理里的逻辑错误地写进了 `useEffect`
- JSX 使用过的值是否在后续又被修改
- 是否本该提取 custom hook 却引入了不必要的重模式
- 是否本该保持单组件，却被机械套用某种架构模式
- 是否存在可以先拆子组件却被过早架构化的问题

## 10. 落地建议

- 开启 React `StrictMode`
- 启用 `eslint-plugin-react-hooks`
- 在代码评审中优先检查 purity、immutability、hook placement 三类问题

## 11. 来源

本规范基于 React 官方文档：

- [Rules of React](https://react.dev/reference/rules)
- [Components and Hooks must be pure](https://react.dev/reference/rules/components-and-hooks-must-be-pure)
- [React calls Components and Hooks](https://react.dev/reference/rules/react-calls-components-and-hooks)
- [Rules of Hooks](https://react.dev/reference/rules/rules-of-hooks)
