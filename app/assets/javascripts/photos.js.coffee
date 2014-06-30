jQuery ->

    Dropzone.options.attachment = 
        paramName: "photo[imagefile]"
        enqueueForUpload: false
        headers:
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')

        init: ->
          @on "success", (file) ->
            console.log("successfully uploaded file")
            $('#status_message').html("<b style='color: green;'>Attachment uploaded.</b>")
            $('input[name="post[attachment_name]"]').val(file.name)
            return
        
          @on "error", (file) ->
            console.log("error occurred while uploading file")
            $('#status_message').html("<b style='color: red;'>An error occurred while saving the attachment.</b>")
            return

          return
    
