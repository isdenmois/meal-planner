import { collection, query, orderBy, doc, onSnapshot } from 'firebase/firestore'
import { mapTemplate } from 'nanostores'
import { db } from 'shared/libs/firebase'
import { fromQuery } from 'shared/libs/nanostores'
import { Recipe } from './recipe'

const recipeCollection = collection(db, 'recipes')
const recipeListQuery = query(recipeCollection, orderBy('title'))
export const $recipes = fromQuery<Recipe>(recipeListQuery)

const getRecipeReference = (id: string) => doc(recipeCollection, id)

export const recipeTemplate = mapTemplate<Recipe>((store, id) => {
  const ref = getRecipeReference(id)
  const unsubscribe = onSnapshot(ref, snapshot => {
    store.set(snapshot.data() as any)
  })

  return unsubscribe
})
