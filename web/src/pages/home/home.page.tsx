import { VFC } from 'react'
import { HomeRecipeList } from './ui/home-recipe-list'
import { Header, Icon, icons } from 'shared/ui'

export const HomePage: VFC = () => {
  return (
    <div className='layout'>
      <Header title='Recipe list' buttons={<Icon href='/recipe/add' icon={icons.plus} />} />

      <div className='content'>
        <HomeRecipeList />
      </div>
    </div>
  )
}
