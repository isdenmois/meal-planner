import { getAuth, setPersistence, browserLocalPersistence } from 'firebase/auth'
import { app } from './app'

export const auth = getAuth(app)

setPersistence(auth, browserLocalPersistence)
