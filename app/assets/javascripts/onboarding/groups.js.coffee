#= require knockout

class OnboardingGroups

  minGroups: 5
  groupsSelected: ko.observable(0)

  constructor: (el) ->

    @groups = el.find('.group-listing :checkbox')
    @progressBar = el.find('.progress-bar')
    @countSelected()

    @groups.on 'change', (e) =>
      checkbox = $(e.target)
      @joinOrLeaveGroup(checkbox.data('url'), checkbox.prop('checked'))
      @countSelected()

    @minGroupsSelected = ko.computed =>
      @groupsSelected() >= @minGroups

    @progressStatusText = ko.computed =>
      if @minGroupsSelected()
        ""
      else
        remaining = @minGroups - @groupsSelected()
        "#{remaining} more to go"

  countSelected: ->
    count = @groups.filter(':checked').length
    @groupsSelected(count)
    @updateProgressBarWidth(count)

  updateProgressBarWidth: (count) ->
    width = (count / @minGroups) * 100
    width = 100 if width > 100
    @progressBar.css('width', "#{width}%")

  joinOrLeaveGroup: (url, liked) ->
    if liked
      url += '/join.json'
    else
      url += '/leave.json'
      
    $.ajax
      url: url
      method: 'post'

$(document).on 'ready', ->
  onboardingGroups = $('#onboarding-groups')
  if onboardingGroups.length > 0
    view = new OnboardingGroups(onboardingGroups)
    ko.applyBindings(view)
