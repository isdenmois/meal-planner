import type { User } from 'firebase/auth'
import { atom } from 'nanostores'
import { auth } from 'shared/libs/firebase'

export const $viewer = atom<User | null>(auth.currentUser)

auth.onAuthStateChanged(user => {
  $viewer.set(user)
})
