import { VFC } from 'react'
import './header.css'

interface Props {
  title: string
  buttons?: any
}

export const Header: VFC<Props> = ({ title, buttons }) => {
  return (
    <div className='header row'>
      <h1>{title}</h1>
      {buttons}
    </div>
  )
}
