#= require underscore-min

class SearchDescription

  ranking: {
    'full': 1,
    'partial': 2,
    'none': 3
  }

  constructor: (hit, options) ->
    @hit = hit

    @customTitle = null
    @customDescription = null

    if options
      @customTitle = options.title
      @customDescription = options.description

  matches: ->
    results = _.reject @hit._highlightResult, (hit, key) ->
      hit.matchLevel == 'none' || /name/i.test(key)

  title: ->
    result = @hit._highlightResult
    if result[@customTitle]
      result[@customTitle].value
    else if result.full_name
      result.full_name.value
    else if result.name
      result.name.value

  description: ->
    result = @orderHits()[0]
    try
      if result[@customDescription]
        result[@customDescription].value

    if result
      result.value
    else if @hit.city
      "City: #{@hit.city}"

  orderHits: ->
    _.sortBy @matches(),((hit) ->
      @ranking[hit.matchLevel]
    ), this

  toHash: ->
    description = @description()

    if description && description.length > 20
      description = description.substring(0, 20) + '...'
    {
      title: @title(),
      description: description
    }

@SearchDescription = SearchDescription
