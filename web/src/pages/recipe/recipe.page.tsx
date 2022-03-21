import { VFC } from 'react'
import { useStore } from '@nanostores/react'
import { IngredientBlock, recipeTemplate } from 'entities/recipe'
import { Header, Icon, icons } from 'shared/ui'
import { Params } from 'wouter'

interface Props {
  params: Params<{ id: string }>
}

export const RecipePage: VFC<Props> = ({ params }) => {
  const recipe = useStore(recipeTemplate(params.id))

  if (!recipe) {
    return (
      <div className='layout'>
        <Header title='Recipe' />
        Loading...
      </div>
    )
  }

  return (
    <div className='layout'>
      {!!recipe.imageURL && <img src={recipe.imageURL} className='cover' />}

      <Header title={recipe.title} buttons={<Icon href={`/recipe/${params.id}/edit`} icon={icons.edit} />} />

      <div className='content'>
        {!!recipe.link && (
          <a href={recipe.link} className='mb-2'>
            {recipe.link}
          </a>
        )}

        {!!recipe.ingredients?.length && (
          <>
            <h4 className='mb-2'>Ingredients</h4>

            <ul className='mb-4'>
              {recipe.ingredients.map((ingredient, index) => (
                <IngredientBlock key={index} ingredient={ingredient} />
              ))}
            </ul>
          </>
        )}

        {!!recipe.steps?.length && (
          <>
            <h4 className='mb-2'>Steps</h4>
            <ol className='mb-4'>
              {recipe.steps.map((step, index) => (
                <li key={index}>{step}</li>
              ))}
            </ol>
          </>
        )}
      </div>
    </div>
  )
}
