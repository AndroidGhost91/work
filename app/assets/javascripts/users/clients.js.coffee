#= require readmore

bindPage = ->
  $('.user-client-description').readmore
    moreLink: '<a class="read-more" href="#">Read more...</a>'
    lessLink: '<a class="read-more" href="#">Close</a>'

$(document).ready(bindPage)
$(document).on('page:load', bindPage)
