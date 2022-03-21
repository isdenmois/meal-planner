import { VFC } from 'react'
import { Link } from 'wouter'
import { Card } from 'shared/ui'
import { Recipe } from '../model'

interface Props {
  recipe: Recipe
}

export const RecipeCard: VFC<Props> = ({ recipe }) => {
  return (
    <Link href={`/recipe/${recipe.id}`}>
      <Card title={recipe.title} imageUrl={recipe.imageURL} />
    </Link>
  )
}
