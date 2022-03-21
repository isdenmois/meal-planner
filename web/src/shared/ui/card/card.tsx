import { VFC } from 'react'
import './card.css'

interface Props {
  title: string
  imageUrl?: string
  onClick?: () => void
}

export const Card: VFC<Props> = ({ title, imageUrl, onClick }) => {
  return (
    <div className='card row' onClick={onClick}>
      {!!imageUrl && <img className='card__image' src={imageUrl} />}
      {!imageUrl && <div className='card__image card__image_empty' />}

      <div className='card__body'>
        <h3>{title}</h3>
      </div>
    </div>
  )
}
