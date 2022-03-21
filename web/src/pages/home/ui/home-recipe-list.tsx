import { useStore } from '@nanostores/react'
import { $recipes, RecipeCard } from 'entities/recipe'
import { VFC } from 'react'

export const HomeRecipeList: VFC = () => {
  const { isLoading, data } = useStore($recipes)

  return (
    <div className='list'>
      {isLoading && '...'}

      {data.map(recipe => (
        <RecipeCard key={recipe.id} recipe={recipe} />
      ))}
    </div>
  )
}
