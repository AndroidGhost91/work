bindForms = ->
  $('form').on 'click', '.remove_fields', (event) ->
    el = $(this)
    el.prev('input').prop('checked', true)
    target = el.closest(el.data('target'))
    target.hide().appendTo(target.parent())
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    el = $(this)
    time = new Date().getTime()
    regexp = new RegExp(el.data('id'), 'g')
    fields = el.data('fields').replace(regexp, time)

    if el.data('target')
      target = $(el.data('target'))

      if el.data('insertion') == 'after'
        target.filter(':visible').last().after(fields)
      else if el.data('insertion') == 'before'
        target.filter(':visible').last().before(fields)
      else
        target.append(fields)
    else
      el.before(fields)

    event.preventDefault()

  stateSelect = $('.state-select')
  stateSelectName = stateSelect.attr('name')
  stateSelectContainer = stateSelect.wrap('<div class="state-select-container" />').parent()

  originalSelect = '<select class="form-control" name="' + stateSelectName + '"></select>'
  stateSelectFallback = '<input type="text" class="form-control" name="' + stateSelectName + '" />'
  lastValue = stateSelect.val()

  $('.country-select').on 'change load-states', ->
    stateSelect.prop('disabled', true)
    lastValue = stateSelect.val()

    $.getJSON '/states_for_country', { code: @value }, (data) ->
      stateSelectContainer.html('')

      if _.isEmpty(data)
        stateSelectContainer.append(stateSelectFallback)
        stateSelect = stateSelectContainer.find('input')
      else
        stateSelectContainer.append(originalSelect)
        stateSelect = stateSelectContainer.find('select')
        stateSelect.select2(theme: 'bootstrap')

        options = ''
        for code, value of data
          options += """<option value="#{code}">#{value.name}</option>"""

        stateSelect.html(options)

      stateSelect.prop('disabled', false)
      stateSelect.val(lastValue).triggerHandler('change')

  $('.country-select').trigger('load-states')
  $('button').tooltip
    trigger: 'click'
    placement: 'bottom'
  clipboard = new Clipboard('#profile-copy')
  clipboard.on 'success', (e) ->
    setTooltip e.trigger, 'Copied!'
    hideTooltip e.trigger
    return
  clipboard.on 'error', (e) ->
    setTooltip e.trigger, 'Failed!'
    hideTooltip e.trigger
    return
  $('.profile-link').on 'click', (e) ->
    e.preventDefault()
    $('#profile-copy').trigger 'click'
    return


setTooltip = (btn, message) ->
  $(btn).tooltip('hide').attr('data-original-title', message).tooltip 'show'
  return

hideTooltip = (btn) ->
  setTimeout (->
    $(btn).tooltip 'hide'
    return
  ), 1000
  return

$(document).ready(bindForms)
$(document).on('page:load', bindForms)
