# 组件模式

用于判断 React 组件应该如何组织。

## 目录

- 1. 默认原则
- 2. 保持单组件
- 3. 拆子组件
- 4. Container / Presentational
- 5. Compound Components
- 6. Composition 优先于继承

## 1. 默认原则

- 默认先保持最简单的组件结构。
- 优先通过 props、children、组合解决问题。
- 不要把设计模式当成固定模板套用。

## 2. 保持单组件

适用：

- 组件体量小
- 逻辑和 UI 紧密耦合
- 没有明确复用需求
- 拆分后只会增加 props 透传和文件数量

## 3. 拆子组件

优先于更重的架构模式。

适用：

- JSX 区块很多
- 某些视觉区块职责明确
- 同一个父组件里出现重复 UI 片段

目标：

- 缩短主组件
- 提高可读性
- 保持数据流简单

## 4. Container / Presentational

这是一种可选模式，不是默认规范。

适用：

- 上层负责数据获取、权限、路由、埋点、状态编排
- 下层接近纯展示，只依赖 props
- 同一套 UI 需要复用在不同数据来源中

不适用：

- 小组件
- 轻量本地交互
- 拆分后只剩很薄的两层文件

## 5. Compound Components

适用：

- 多个子组件共同表达一个完整交互单元
- 父子之间有天然语义关系
- 希望 API 更声明式，例如：

```tsx
<Tabs>
  <Tabs.List />
  <Tabs.Trigger />
  <Tabs.Content />
</Tabs>
```

避免：

- 只是为了“高级感”而引入复杂 API
- 组件本身很简单，却强上 compound 模式

## 6. Composition 优先于继承

- 通过 `children`、slots、props 组合能力扩展组件
- 避免用继承表达 UI 差异
- 优先做小而专注的可组合组件
