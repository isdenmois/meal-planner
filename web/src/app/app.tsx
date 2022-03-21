import { VFC } from 'react'
import { useAuthState } from 'react-firebase-hooks/auth'
import { auth } from 'shared/libs/firebase'
import { Routes } from './routes'
import { AuthRoutes } from './auth-routes'

export const App: VFC = () => {
  const [user, loading, error] = useAuthState(auth)

  if (loading) {
    return <div>...</div>
  }

  if (error) {
    return <div style={{ color: 'red' }}>{JSON.stringify(error)}</div>
  }

  if (user) {
    return <Routes />
  }

  return <AuthRoutes />
}
