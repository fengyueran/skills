# FSD 功能拆分指南

## 目录
- 1. 输入信息
- 2. 拆分步骤
- 3. 决策规则
- 4. 输出模板
- 5. 示例

## 1. 输入信息

开始拆分前，先明确：

- 用户目标：这个功能给用户带来什么结果
- 使用范围：仅一个页面，还是多个页面复用
- 数据来源：是否有请求、轮询、上传下载、写操作
- 状态范围：页面局部状态，还是可复用业务状态
- 约束：性能、权限、风控、埋点、实验开关

## 2. 拆分步骤

1. 先识别实体（Entities）
- 抽取核心业务对象：如 `user`、`order`、`equation`
- 为每个实体确定基础类型、基础状态、基础选择器

2. 再识别能力（Features）
- 抽取用户可感知动作：如 `login`、`run-solver`、`toggle-like`
- 每个能力单独成一个 feature slice

3. 识别可复用区块（Widgets）
- 多页面复用且是较大 UI 区块时，提升为 widget
- 若仅单页使用且复用不明确，先留在页面

4. 组装页面（Pages）
- pages 负责路由入口、页面级数据生命周期、加载/错误/空态编排
- 页面中组合 widgets/features/entities/shared

5. 最后校正 shared/app
- shared 放跨业务域可复用能力
- app 放全局入口、providers、routes、styles、全局埋点

## 3. 决策规则

- 一个逻辑仅在单页使用：优先留在 `pages/[page-name]`
- 需要跨页面复用且对用户可见：提升到 `features/[feature-name]`
- 是多个 feature/entity 的大块组合：放 `widgets/[widget-name]`
- 是领域对象本身的数据结构与基础能力：放 `entities/[entity-name]`
- 与业务域无关且跨域复用：放 `shared/[segment]/[module-name]`
- 只做全局启动/装配：放 `app`

边界红线：

- `features` 不依赖 `widgets/pages/app`
- `entities` 不依赖 `features/widgets/pages/app`
- `shared` 不依赖任何上层

## 4. 输出模板

在创建文件前，先给出如下拆分结果：

```md
## FSD 拆分结果

### Entities
- entities/[entity-name]

### Features
- features/[feature-name]

### Widgets
- widgets/[widget-name]（如无可省略）

### Pages
- pages/[page-name]

### Shared
- shared/[segment]/[module-name]（如无可省略）

### App
- app/{routes|store|styles|entrypoint}（按需）

### Segment 计划
- [slice-a]: ui, model, api
- [slice-b]: ui

### 边界检查
- [ ] import 方向符合 layers 规则
- [ ] 无跨层越界依赖
- [ ] 仅通过公共 API 导出
```

## 5. 示例

需求：用户在方程详情页点击“运行”，查看日志与结果，并可重复执行。

拆分：

- `entities/equation`：方程类型、基础数据与选择器
- `features/run-solver`：运行动作、状态机、请求与重试
- `widgets/solver-console`：日志+结果的大块展示区
- `pages/equation-detail`：组合 widget/feature，控制页面 loading/error
- `shared/lib/http`：请求封装（若项目已有则复用）
- `app`：仅补埋点与全局 provider（如需要）
