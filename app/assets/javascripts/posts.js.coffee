$(document).on('ajax:success', (xhr, data, status) ->
      $('#category-notice').append('<div id="notice">'+data.notice+'</div>'))

Dropzone.options.newPost =
  
  autoProcessQueue: false
  uploadMultiple: true
  parallelUploads: 100
  maxFiles: 100
  
  init: ->
    dropZone = this
    
    @element.querySelector("button[type=submit]").addEventListener "click", (e) ->
      
      e.preventDefault()
      e.stopPropagation()
      dropZone.processQueue()
      return

    
    @on "sendingmultiple", ->

    
    @on "successmultiple", (files, response) ->

    
    @on "errormultiple", (files, response) ->

    return

