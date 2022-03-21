import { getFirestore, enableIndexedDbPersistence } from 'firebase/firestore'
import { app } from './app'

export const db = getFirestore(app)

enableIndexedDbPersistence(db)
