# 分支与提交约定

## 分支命名

推荐：

- `feature/user-profile`
- `fix/login-error`
- `hotfix/payment-timeout`
- `refactor/api-client`
- `docs/release-notes`

规则：

- 小写 kebab-case
- 简短、可读、表达意图
- 前缀体现任务类型

## 提交约定

推荐采用 Conventional Commits：

- `feat: add user profile page`
- `fix: handle empty cart state`
- `refactor: split API client`
- `docs: update release notes`

更细时可加 scope：

- `feat(profile): add avatar upload`
- `fix(auth): refresh token retry`

## 合并请求标题

推荐：

- `feat(profile): add user profile page`
- `fix(cart): handle empty state correctly`

原则：

- 与提交信息风格一致
- 能直接对应到 changelog 或 release note
- 团队协作时可作为 PR 标题；单人开发时可作为 squash merge message
