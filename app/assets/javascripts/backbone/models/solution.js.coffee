class Sam2.Models.Solution extends Backbone.Model
  paramRoot: 'solution'

  defaults:
    solutionLabel: null
    description: null

class Sam2.Collections.SolutionsCollection extends Backbone.Collection
  model: Sam2.Models.Solution
  url: '/solutions'
