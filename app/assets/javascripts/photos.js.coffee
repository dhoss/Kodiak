jQuery ->

  if $('#new_attachment').length > 0
    new_attachment = new Dropzone("#new_attachment", {
        paramName: "photo[imagefile]"
        enqueueForUpload: false
    })

    new_attachment.on("success", (file) ->
      console.log("successfully uploaded file")
      $('#status_message').html("<b style='color: green;'>Student Saved</b>")
    )

    new_attachment.on("error", (file) ->
      console.log("error occurred while uploading file")
      $('#status_message').html("<b style='color: red;'>An error occurred while saving the Student.</b>")
    )

    $("#new_attachment_save_button").click( ->
      console.log("Save Button Clicked")
      if new_attachment.files.length > 0
        console.log("found file to process")
        file = new_attachment.files[0]
        new_attachment.filesQueue.push(file);
        new_attachment.processQueue();
      else
        $("#new_attachment").submit();
    )
