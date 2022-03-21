import { VFC, lazy, Suspense } from 'react'
import { Route, Switch } from 'wouter'

const HomePage = lazy(() => import('pages/home'))
const RecipePage = lazy(() => import('pages/recipe'))
const RecipeAddPage = lazy(() => import('pages/recipe-add'))
const RecipeEditPage = lazy(() => import('pages/recipe-edit'))

export const Routes: VFC = () => (
  <Suspense fallback={<div>Loading...</div>}>
    <Switch>
      <Route path='/recipe/add' component={RecipeAddPage} />
      <Route path='/recipe/:id' component={RecipePage} />
      <Route path='/recipe/:id/edit' component={RecipeEditPage} />
      <Route path='/' component={HomePage} />
    </Switch>
  </Suspense>
)
