# FSD 边界参考

## 目录

- 1. 分层依赖矩阵
- 2. App 层规则
- 3. Pages 层规则
- 4. Widgets 层规则
- 5. Features 层规则
- 6. Entities 层规则
- 7. Shared 层规则
- 8. 文件与导出约定
- 9. 验证清单
- 10. 常见违规与修复

## 1. 分层依赖矩阵

在当前工作区中，基于已存在的分层目录（`pages/widgets/features/entities/shared`）就地扩展。

允许依赖方向：

- `shared` -> `shared`
- `entities` -> `entities`, `shared`
- `features` -> `features`, `entities`, `shared`
- `widgets` -> `widgets`, `features`, `entities`, `shared`
- `pages` -> `pages`, `widgets`, `features`, `entities`, `shared`
- `app` -> 可组合业务层公开导出的模块/组件（通过各层 index.ts 暴露）

说明：

- `App` 和 `Shared` 是分层例外：各自层内的不同 segment 可以互相引用。
- `Pages/Widgets/Features/Entities` 应保持 slice 隔离，避免同层随意耦合。

禁止示例：

- `shared` 引用 `entities/features/widgets/pages/app`
- `entities` 引用 `features/widgets/pages/app`
- `features` 引用 `widgets/pages/app`
- `widgets` 引用 `pages/app`

## 2. App 层规则

职责：

- 处理应用级全局事项，包含技术层面（Provider、路由、全局样式）
- 也包含业务全局事项（埋点、全局遥测）

允许：

- 注册路由与全局入口
- 组装 Provider 树（`store`、session、theme）
- 组织应用启动流程
- 初始化全局分析/遥测能力

禁止：

- 实现领域业务流程
- 在 `app.tsx` 或 `main.tsx` 堆积业务逻辑

路径：

- 含 `app.tsx` 的 `app` 入口目录

分段约定：

- App 通常不放 `slices`，直接按 segment 组织
- 推荐 segments：`routes`、`store`、`styles`、`entrypoint`

## 3. Pages 层规则

职责：

- 页面（路由）切片与页面级编排（含加载/错误等页面状态）

允许：

- 组合 `widgets/features/entities/shared`
- 处理路由参数并透传回调
- 维护页面级状态（含加载、错误、占位等）
- 在页面场景发起数据获取与变更

禁止：

- 编写领域判断分支与业务计算
- 定义全局业务状态

推荐模板：

- `[pages-dir]/[page-name]/ui/index.ts`
- `[pages-dir]/[page-name]/index.ts`

## 4. Widgets 层规则

职责：

- 大块自包含 UI 区块，可跨页面复用

允许：

- 组合多个 `features/entities`
- 为展示与交互协调维护轻量状态

禁止：

- 承载完整端到端业务用例
- 编写应归属 features 的跨场景业务规则
- 引用 `pages` 或 `app`

推荐模板：

- `[widgets-dir]/[widget-name]/ui/index.ts`
- `[widgets-dir]/[widget-name]/model/`
- `[widgets-dir]/[widget-name]/index.ts`

## 5. Features 层规则

职责：

- 面向用户可感知的业务能力（interaction/use-case）

允许：

- 承载业务流程与交互逻辑
- 在 `api/` 与 `model/` 处理中副作用与请求
- 组合多个 entities

禁止：

- 重新定义 entities 已拥有的实体契约
- 引用 `widgets/pages/app`
- 发展为“大而全”的聚合 feature

补充判断：

- 若能力仅在单一页面使用且无复用预期，可先保留在页面切片；
- 若能力需要跨页面复用，再沉淀为 `feature`。

推荐模板：

- `[features-dir]/[feature-name]/ui/index.ts`
- `[features-dir]/[feature-name]/model/[feature-name].types.ts`
- `[features-dir]/[feature-name]/model/[feature-name].slice.ts`
- `[features-dir]/[feature-name]/model/[feature-name].selectors.ts`
- `[features-dir]/[feature-name]/api/`
- `[features-dir]/[feature-name]/index.ts`

## 6. Entities 层规则

职责：

- 定义领域对象、基础状态与最小可复用实体展示

允许：

- `types`、`slice/selectors`、基础实体组件
- 实体内 API 适配（前提是不依赖上层）

禁止：

- 跨页面/跨场景业务编排
- 引用 `features/widgets/pages/app`

推荐模板：

- `[entities-dir]/[entity-name]/model/[entity-name].types.ts`
- `[entities-dir]/[entity-name]/model/[entity-name].slice.ts`
- `[entities-dir]/[entity-name]/model/[entity-name].selectors.ts`
- `[entities-dir]/[entity-name]/index.ts`

## 7. Shared 层规则

职责：

- 共享基础层，承载基础设施和可复用资源，服务于多个业务域

分段：

- `ui | lib | model | api | config`

允许：

- 通用基础组件与可复用的业务主题 UI 组件（仅展示，不含业务决策）
- 通用工具函数与底层能力

禁止：

- 绑定到单一业务域且不可复用的实现
- 登录流程、下单规则、权限判断等业务行为逻辑（应放 `features/entities/pages/widgets`）
- 引用 `entities/features/widgets/pages/app`

推荐模板：

- `[shared-dir]/[segment]/[module-name]/`
- 或 `[shared-dir]/[segment]/[module-name].ts`

## 8. 文件与导出约定

- slice/模块目录名使用 `kebab-case`（shared 的 segment 名除外）
- 优先使用 TypeScript
- UI 主入口优先使用 `ui/index.ts`；仅在同目录多变体时使用语义化文件名（如 `profile-form.tsx`）
- `features/entities` 的 model 文件使用 slice 前缀命名：`[slice].types.ts`、`[slice].slice.ts`、`[slice].selectors.ts`
- 在 slice `index.ts` 中优先使用命名空间导出：`export * as xxxActions`、`export * as xxxSelectors`
- 避免重复导出：同一 action/selectors 不同时做直出和命名空间导出
- 优先在 `model/index.ts` 聚合导出，再由 slice 根 `index.ts` 从 `./model` 二次导出
- 对外导出统一经各层 `index.ts`
- 统一命名导出
- 非 `app` 层禁止 `export default`

最小文件内容模板见：`references/scaffold-templates.md`。

## 9. 验证清单

完成脚手架变更后，至少检查：

1. 新增目录与文件符合层级路径约定
2. 层级 `index.ts` 已更新且导出路径有效
3. import 方向符合依赖矩阵
4. 未引入非 `app` 层默认导出
5. `pages/shared` 未出现越界业务逻辑

建议命令：

```bash
rg -n "from ['\"][^'\"]*pages|from ['\"][^'\"]*app" .
rg -n "export default" .
rg -n "fetch\(|axios\.|request\(" .
```

## 10. 常见违规与修复

- 违规：feature 反向依赖 widget
  - 修复：将共性逻辑下沉到 `entities` 或 `shared`，feature 只保留业务编排

- 违规：page 内实现复杂业务流程
  - 修复：把流程迁移到 `features/[feature-name]/model`，page 只保留组合壳

- 违规：shared 出现领域专用 helper
  - 修复：迁移到 `entities/[entity-name]/lib` 或 `features/[feature-name]/lib`
