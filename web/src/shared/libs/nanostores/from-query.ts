import { DocumentData, onSnapshot, Query } from 'firebase/firestore'
import { atom, onMount, ReadableAtom } from 'nanostores'

interface ObservableCollection<T> {
  isLoading: boolean
  data: T[]
}

export const fromQuery = <T>(collection: Query<DocumentData>): ReadableAtom<ObservableCollection<T>> => {
  const store = atom<ObservableCollection<T>>({ data: [], isLoading: true })

  onMount(store, () => {
    const unsubscribe = onSnapshot(collection, querySnapshot => {
      const data: T[] = []

      querySnapshot.forEach(doc => {
        data.push({
          id: doc.id,
          ...doc.data(),
        } as any)
      })

      store.set({ isLoading: false, data })
    })

    return unsubscribe
  })

  return store
}
