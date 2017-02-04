$ ->
  $('.sortable-rows').sortable
    handle: '.sort-handle'
    update: (e, ui) ->
      ids = {}
      $(this).find('.item').each (i) ->
        ids[$(this).data('id')] = i

      $.post $(this).data('url'), feed_ids: ids

