$(document).ready ->
  if $('#pollSlider-button')
    $('#pollSlider-button').click ->
      rightElement = $('#pollSlider-button > i.fa-chevron-right').first()
      if rightElement.attr('data-display') == 'true'
        rightElement.attr('data-display', 'false')
        $('#pollSlider-button > i.fa-chevron-left').css({'display': 'inline-block'})
        $('#pollSlider-button > i.fa-chevron-right').css({'display': 'none'})
        $('.pollSlider').animate({'left': '0px'})
        $('#pollSlider-button').animate({'margin-left': '80%'})
        if $(".modal-sidebar").length == 0
          $("body").append("<div class='modal-sidebar'></div>")
      else
        rightElement.attr('data-display', 'true')
        $('#pollSlider-button > i.fa-chevron-right').css({'display': 'inline-block'})
        $('#pollSlider-button > i.fa-chevron-left').css({'display': 'none'})
        $('.pollSlider').animate({'left': '-80%'})
        $('#pollSlider-button').animate({'margin-left': '0px'})
        $(".modal-sidebar").remove()

    return
