import { VFC } from 'react'
import './ingredient-block.css'

interface Props {
  ingredient: string
}

export const IngredientBlock: VFC<Props> = ({ ingredient }) => {
  const [title, count] = ingredient.split(':')
  return (
    <li className='ingredient'>
      <span>{title}</span>
      {!!count && <span className='secondary'>{count}</span>}
    </li>
  )
}
