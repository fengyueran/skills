---
name: "fsd-module-generator"
description: "用于在任意前端项目中按 FSD 六层（App、Pages、Widgets、Features、Entities、Shared）创建或扩展模块。当用户提到“生成 FSD 模块”、“创建 page/widget/feature/entity/shared 模块”、“按 FSD 新建 slice”、“补齐 index.ts 导出”或“检查 FSD 分层边界”时触发。"
---

# Generate FSD Module

在当前工作区按 FSD 分层创建/扩展模块骨架，并完成导出注册与边界检查。

支持层级：`App`、`Pages`、`Widgets`、`Features`、`Entities`、`Shared`。

# Layer Map

基于项目中已存在的层目录就地扩展（不预设根路径）：

- `App`: `app` 目录（app-wide concerns，按 `routes/store/styles/entrypoint` 分段）
- `Pages`: `pages/[page-name]`
- `Widgets`: `widgets/[widget-name]`
- `Features`: `features/[feature-name]`
- `Entities`: `entities/[entity-name]`
- `Shared`: `shared/[segment]/[module-name]`

# Quick Rules

- slice/模块目录名统一 `kebab-case`（`shared` 的 segment 除外）
- TypeScript 优先
- `Pages/Widgets/Features/Entities` 禁止同层 slice 直接依赖
- UI 主入口优先使用 `ui/index.ts`，仅在存在多个变体时使用语义化文件名（如 `profile-form.tsx`）
- `App` 与 `Shared` 不创建 slices，直接按 segments 组织
- `Pages/Widgets/Features/Entities` 先建 slice，再按需要建 segments
- 在 slice `index.ts` 中优先使用命名空间导出：`export * as xxxActions`、`export * as xxxSelectors`
- 公共导出统一走层级 `index.ts`
- 非 `App` 层禁止 `export default`

详细边界与反例见：`references/boundaries.md`。  
六层最小脚手架文件模板见：`references/scaffold-templates.md`。
功能拆分决策指南见：`references/splitting-guide.md`。
实现规范（组件化/单一职责/可测试性）见：`references/implementation-guide.md`。

# Global Workflow

1. 确认层级、模块名、目标路径。
2. 先按 `references/splitting-guide.md` 产出功能拆分结果（layer/slice/segment 清单）。
3. 定位现有层目录（优先复用已有 `pages/widgets/features/entities/shared` 目录）。
4. 依据复用预期选择 segments（先少后多）：
   - 仅当前 slice 内部使用：先建 `ui` 或 `model`。
   - 有后端交互：增加 `api`。
   - 有配置/开关：增加 `config`。
   - 有可复用工具：增加 `lib`。
5. 按 `references/scaffold-templates.md` 创建最小文件集与初始代码。
6. 更新对应层根 `index.ts` 导出。
7. 对照 `references/boundaries.md` 做依赖方向和职责边界检查。
8. 对照 `references/implementation-guide.md` 做实现质量自检（组件化、职责、测试性）。

# Layer Templates (Minimal)

## 1) App

应用全局层（技术 + 业务全局事项），例如 Provider、全局路由、全局样式、分析埋点。

- 通常不放 `slices`，而是直接按 segment 组织。
- 推荐 segments：`routes`、`store`、`styles`、`entrypoint`。

最小模板：

- `[app-dir]/routes/`
- `[app-dir]/store/`
- `[app-dir]/styles/`
- `[app-dir]/entrypoint/`
- `[app-dir]/app.tsx`
- `[app-dir]/main.tsx`（存在时）
- 文件模板：`references/scaffold-templates.md#app`

## 2) Pages

- `[pages-dir]/[page-name]/ui/index.ts`
- `[pages-dir]/[page-name]/index.ts`
- 更新：`[pages-dir]/index.ts`
- 可选：`api/`、`model/`、`lib/`、`config/`
- 文件模板：`references/scaffold-templates.md#pages`

## 3) Widgets

- `[widgets-dir]/[widget-name]/ui/index.ts`
- `[widgets-dir]/[widget-name]/model/`
- `[widgets-dir]/[widget-name]/index.ts`
- 更新：`[widgets-dir]/index.ts`
- 可选：`api/`、`lib/`、`config/`
- 文件模板：`references/scaffold-templates.md#widgets`

## 4) Features

- `[features-dir]/[feature-name]/ui/index.ts`
- `[features-dir]/[feature-name]/model/[feature-name].types.ts`
- `[features-dir]/[feature-name]/model/[feature-name].slice.ts`
- `[features-dir]/[feature-name]/model/[feature-name].selectors.ts`
- `[features-dir]/[feature-name]/api/`
- `[features-dir]/[feature-name]/index.ts`
- 更新：`[features-dir]/index.ts`
- 可选：`lib/`、`config/`
- 文件模板：`references/scaffold-templates.md#features`

## 5) Entities

- `[entities-dir]/[entity-name]/model/[entity-name].types.ts`
- `[entities-dir]/[entity-name]/model/[entity-name].slice.ts`
- `[entities-dir]/[entity-name]/model/[entity-name].selectors.ts`
- `[entities-dir]/[entity-name]/index.ts`
- 更新：`[entities-dir]/index.ts`
- 可选：`ui/`、`api/`、`lib/`、`config/`
- 文件模板：`references/scaffold-templates.md#entities`

## 6) Shared

- `[shared-dir]/[segment]/[module-name]/`
- 或：`[shared-dir]/[segment]/[module-name].ts`
- 更新：`[shared-dir]/[segment]/index.ts`
- 必要时更新：`[shared-dir]/index.ts`
- 文件模板：`references/scaffold-templates.md#shared`

# Boundary Reference

遇到以下情况必须读取 `references/boundaries.md`：

- 需要判定某层是否可以 import 另一层
- 不确定某段逻辑应放在哪一层
- 评估是否有“页面承载业务流程”或“shared 业务化”风险
- 做最终完成前的边界验收

遇到以下情况必须读取 `references/splitting-guide.md`：

- 用户问“一个功能该放哪层/如何拆 slice”
- 需求跨多个层且边界不明确
- 需要先给出拆分方案再创建脚手架

遇到以下情况必须读取 `references/implementation-guide.md`：

- 用户要求“组件化/单一职责/好测试”
- 某个 slice 出现“大文件 + 多分支 + 难测”征兆
- 需要给出实现质量改造建议

# Done Criteria

- 目标目录与文件已创建。
- 层级入口 `index.ts` 已注册导出。
- 命名与导出规范符合约束。
- 依赖方向与职责边界通过检查（按 `references/boundaries.md`）。
