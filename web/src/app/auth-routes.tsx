import { VFC, lazy, Suspense } from 'react'

const AuthPage = lazy(() => import('pages/auth'))

export const AuthRoutes: VFC = () => (
  <Suspense fallback={<div>Loading...</div>}>
    <AuthPage />
  </Suspense>
)
