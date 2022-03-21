import { VFC } from 'react'
import { Link } from 'wouter'
import './icon.css'

interface Props {
  href: string
  icon: string
}

export const Icon: VFC<Props> = ({ href, icon }) => (
  <Link href={href}>
    <a className='icon'>
      <img src={icon} />
    </a>
  </Link>
)
