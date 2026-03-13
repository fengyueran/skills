# FSD Scaffold Templates (React + Redux Toolkit)

## TOC

- app
- pages
- widgets
- features
- entities
- shared

## app

Directory skeleton:

```text
[app-dir]/
  routes/
  store/
    store.ts
    root-reducer.ts
  styles/
  entrypoint/
  app.tsx
  main.tsx (optional)
```

Minimal file contents:

```ts
// [app-dir]/store/root-reducer.ts
import { combineReducers } from '@reduxjs/toolkit';
import { userReducer } from '@/entities/user';
import { authReducer } from '@/features/auth';

export const rootReducer = combineReducers({
  user: userReducer,
  auth: authReducer,
});
```

```ts
// [app-dir]/store/store.ts
import { configureStore } from '@reduxjs/toolkit';
import { rootReducer } from './root-reducer';

export const store = configureStore({
  reducer: rootReducer,
});

export type RootState = ReturnType<typeof store.getState>;
export type AppDispatch = typeof store.dispatch;
```

```tsx
// [app-dir]/app.tsx
import { Provider } from 'react-redux';
import { store } from './store/store';

export function App({ children }: { children?: React.ReactNode }) {
  return <Provider store={store}>{children ?? null}</Provider>;
}
```

```ts
// [app-dir]/entrypoint/index.ts
export * from '../app';
```

## pages

Directory skeleton:

```text
[pages-dir]/[page-name]/
  ui/
    index.ts
    page.tsx
  api/ (optional)
  model/ (optional)
  lib/ (optional)
  config/ (optional)
  index.ts
```

Minimal file contents:

```tsx
// [pages-dir]/[page-name]/ui/page.tsx
import { useEffect } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import { fetchAuthProfile, selectAuthStatus } from '@/features/auth';

export function PageView() {
  const dispatch = useDispatch();
  const status = useSelector(selectAuthStatus);

  useEffect(() => {
    dispatch(fetchAuthProfile() as never);
  }, [dispatch]);

  if (status === 'loading') return <div>Loading...</div>;
  if (status === 'failed') return <div>Load failed</div>;

  return <div>Page content</div>;
}
```

```ts
// [pages-dir]/[page-name]/ui/index.ts
export { PageView } from './page';
```

```ts
// [pages-dir]/[page-name]/index.ts
export { PageView as [PageName]Page } from './ui';
```

## widgets

Directory skeleton:

```text
[widgets-dir]/[widget-name]/
  ui/
    index.ts
    widget.tsx
  model/ (optional)
  api/ (optional)
  lib/ (optional)
  config/ (optional)
  index.ts
```

Minimal file contents:

```tsx
// [widgets-dir]/[widget-name]/ui/widget.tsx
import { useSelector } from 'react-redux';
import { selectCurrentUser } from '@/entities/user';

export function WidgetView() {
  const user = useSelector(selectCurrentUser);
  return <section>{user ? user.name : 'Guest'}</section>;
}
```

```ts
// [widgets-dir]/[widget-name]/ui/index.ts
export { WidgetView } from './widget';
```

```ts
// [widgets-dir]/[widget-name]/index.ts
export { WidgetView as [WidgetName]Widget } from './ui';
```

## features

Directory skeleton:

```text
[features-dir]/[feature-name]/
  ui/
    index.ts
    feature.tsx
  model/
    index.ts
    [feature-name].slice.ts
    [feature-name].selectors.ts
    [feature-name].types.ts
  api/
    requests.ts
  lib/ (optional)
  config/ (optional)
  index.ts
```

Minimal file contents:

```ts
// [features-dir]/[feature-name]/model/[feature-name].types.ts
export type FeatureStatus = 'idle' | 'loading' | 'succeeded' | 'failed';

export interface FeatureState {
  status: FeatureStatus;
}
```

```ts
// [features-dir]/[feature-name]/api/requests.ts
export async function getProfile() {
  const res = await fetch('/api/profile');
  if (!res.ok) throw new Error('request failed');
  return res.json();
}
```

```ts
// [features-dir]/[feature-name]/model/[feature-name].slice.ts
import { createAsyncThunk, createSlice } from '@reduxjs/toolkit';
import { getProfile } from '../api/requests';
import type { FeatureState } from './[feature-name].types';

const initialState: FeatureState = {
  status: 'idle',
};

export const fetchAuthProfile = createAsyncThunk('auth/fetchProfile', async () => {
  return getProfile();
});

const featureSlice = createSlice({
  name: 'auth',
  initialState,
  reducers: {},
  extraReducers: (builder) => {
    builder
      .addCase(fetchAuthProfile.pending, (state) => {
        state.status = 'loading';
      })
      .addCase(fetchAuthProfile.fulfilled, (state) => {
        state.status = 'succeeded';
      })
      .addCase(fetchAuthProfile.rejected, (state) => {
        state.status = 'failed';
      });
  },
});

export const authReducer = featureSlice.reducer;
```

```ts
// [features-dir]/[feature-name]/model/[feature-name].selectors.ts
export const selectAuthStatus = (state: { auth: { status: string } }) => state.auth.status;
```

```tsx
// [features-dir]/[feature-name]/ui/feature.tsx
import { useDispatch, useSelector } from 'react-redux';
import { fetchAuthProfile } from '../model/[feature-name].slice';
import { selectAuthStatus } from '../model/[feature-name].selectors';

export function FeatureView() {
  const dispatch = useDispatch();
  const status = useSelector(selectAuthStatus);

  return (
    <button type="button" onClick={() => dispatch(fetchAuthProfile() as never)}>
      Refresh ({status})
    </button>
  );
}
```

```ts
// [features-dir]/[feature-name]/ui/index.ts
export { FeatureView } from './feature';
```

```ts
// [features-dir]/[feature-name]/model/index.ts
export { authReducer } from './[feature-name].slice';
export * as authActions from './[feature-name].slice';
export * as authSelectors from './[feature-name].selectors';
```

```ts
// [features-dir]/[feature-name]/index.ts
export { FeatureView as [FeatureName]Feature } from './ui';
export { authReducer, authActions, authSelectors } from './model';
```

## entities

Directory skeleton:

```text
[entities-dir]/[entity-name]/
  model/
    index.ts
    [entity-name].types.ts
    [entity-name].slice.ts
    [entity-name].selectors.ts
  ui/ (optional)
  api/ (optional)
  lib/ (optional)
  config/ (optional)
  index.ts
```

Minimal file contents:

```ts
// [entities-dir]/[entity-name]/model/[entity-name].types.ts
export interface User {
  id: string;
  name: string;
}

export interface UserState {
  current: User | null;
}
```

```ts
// [entities-dir]/[entity-name]/model/[entity-name].slice.ts
import { createSlice, type PayloadAction } from '@reduxjs/toolkit';
import type { User, UserState } from './[entity-name].types';

const initialState: UserState = {
  current: null,
};

const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    setCurrentUser(state, action: PayloadAction<User | null>) {
      state.current = action.payload;
    },
  },
});

export const { setCurrentUser } = userSlice.actions;
export const userReducer = userSlice.reducer;
```

```ts
// [entities-dir]/[entity-name]/model/[entity-name].selectors.ts
export const selectCurrentUser = (state: { user: { current: { id: string; name: string } | null } }) =>
  state.user.current;
```

```ts
// [entities-dir]/[entity-name]/model/index.ts
export { userReducer } from './[entity-name].slice';
export * as userActions from './[entity-name].slice';
export * as userSelectors from './[entity-name].selectors';
```

```ts
// [entities-dir]/[entity-name]/index.ts
export type { User, UserState } from './model/[entity-name].types';
export { userReducer, userActions, userSelectors } from './model';
```

## shared

Directory skeleton:

```text
[shared-dir]/[segment]/[module-name]/
  index.ts
```

or

```text
[shared-dir]/[segment]/[module-name].ts
```

Minimal file contents:

```ts
// [shared-dir]/lib/http/request.ts
export async function request<T>(input: RequestInfo | URL, init?: RequestInit): Promise<T> {
  const res = await fetch(input, init);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return (await res.json()) as T;
}
```

```ts
// [shared-dir]/lib/http/index.ts
export { request } from './request';
```

```ts
// [shared-dir]/[segment]/[module-name].ts
export {};
```
