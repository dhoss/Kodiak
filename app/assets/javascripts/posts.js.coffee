$(document).ready ->
  $(document).on 'ajax:success', (xhr, data, status) ->
    $('#category-notice').append '<div id="notice">'+data.notice+'</div>'
    return

  $('#attachments').fileupload
    paramName: 'attachments[]'
    url: '/attachments.json'
    dataType: 'json'
    add: (e, data) ->
      data.context = $('<p/>').text("Uploading...").appendTo document.body
      data.submit()
      return
    done: (e, data) -> 
      data.context.text "Upload finished."
      return
  return 


