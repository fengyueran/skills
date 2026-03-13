# React Skill 路由表

本文件用于说明当前环境中已安装、且与 React 直接相关的 skills，以及它们是否适合纳入总入口调度。

路径约定：

- 优先使用相对 skill 路径或 skill 名称，不依赖本机绝对路径。
- 当这些 skills 被安装到同一 skills 根目录时，可按 `skills/<skill-name>/` 理解。
- 对于外部来源但尚未本地收编的 skills，可先按 skill 名称进行路由。

## 已识别的 React 相关 skills

### 1. `react-coding-standard`

- 路径：`skills/react-coding-standard/`
- 作用：基于 React 官方 Rules of React 约束编写、重构、评审和调试
- 是否纳入总入口：是
- 原因：它适合作为所有 React 任务的默认基础规范

### 2. `react-patterns`

- 路径：`skills/react-patterns/`
- 作用：提供组件组织、Hook 抽取、状态放置、组合方式与现代 React 模式选择
- 是否纳入总入口：是
- 原因：它适合回答“应该怎么组织 React 代码”，和 `react-coding-standard` 的“哪些写法不该违反”互补

### 3. `react-component-performance`

- 路径：`skills/react-component-performance/`
- 作用：处理慢渲染、重渲染抖动、列表卡顿、昂贵计算等组件级性能问题
- 是否纳入总入口：是
- 原因：边界清晰，适合组件级性能场景

### 4. `react-performance-optimization`

- 路径：`skills/react-performance-optimization/`
- 作用：覆盖 memoization、code splitting、virtualization、状态优化等更广义的 React 性能优化
- 是否纳入总入口：是
- 原因：适合更广范围的性能优化，但与 `react-component-performance` 有部分重叠

### 5. `vercel-react-best-practices`

- 路径：`skills/vercel-react-best-practices/`
- 作用：Vercel/Next.js 导向的 React 与 Next.js 性能建议
- 是否纳入总入口：条件纳入
- 原因：适合 Next.js 或性能导向项目，但不适合作为通用 React 默认规范

### 6. `react:components`

- 路径：`skills/react-components/`
- 作用：将 Stitch 设计稿转为 React 组件
- 是否纳入总入口：是
- 原因：场景非常明确，适合设计转代码任务

### 7. `fsd-module-generator`

- 路径：`skills/fsd-module-generator/`
- 作用：创建或扩展 FSD 模块和导出结构
- 是否纳入总入口：条件纳入
- 原因：它属于前端架构和目录生成，不是所有 React 项目都需要；仅在 FSD 项目中启用

### 8. `component-refactoring`

- 路径：`skills/component-refactoring/`
- 作用：重构 Dify 前端中的高复杂度 React 组件
- 是否纳入总入口：条件纳入
- 原因：仓库耦合强，只适合特定项目，不适合作为通用 React 子 skill

## 路由建议

### 默认组合

- 所有 React 任务先使用 `react-coding-standard`
- 架构设计、组件拆分、状态放置判断时追加 `react-patterns`

### 视任务追加

- 组件组织、custom hook、compound components、状态放置：追加 `react-patterns`
- 组件慢渲染、局部重渲染问题：追加 `react-component-performance`
- 包体积、代码分割、大列表、并发特性：追加 `react-performance-optimization`
- Next.js 项目性能治理：可补充 `vercel-react-best-practices`
- Stitch 设计稿转组件：切换到 `react:components`
- FSD 项目建模块：追加 `fsd-module-generator`
- Dify 高复杂度组件治理：在特定仓库中使用 `component-refactoring`

## 不建议的做法

- 不要默认同时读取所有 React skills
- 不要默认同时读取两个性能范围高度重叠的 skills
- 不要在非 FSD 项目中自动引入 `fsd-module-generator`
- 不要在非 Dify 项目中自动引入 `component-refactoring`
