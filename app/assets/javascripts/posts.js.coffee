$(document).on('ajax:success', (xhr, data, status) ->
      $('#category-notice').append('<div id="notice">'+data.notice+'</div>'))
