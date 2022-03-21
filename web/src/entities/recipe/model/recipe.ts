export interface Recipe {
  id: string
  title: string
  portion: number
  imageURL?: string
  link?: string
  ingredients: string[]
  steps: string[]
}
