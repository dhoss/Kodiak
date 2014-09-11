# Get the template HTML and remove it from the doument
previewNode = document.querySelector("#template")
previewNode.id = ""
previewTemplate = previewNode.parentNode.innerHTML
previewNode.parentNode.removeChild previewNode
attachment = new Dropzone(document.body, # Make the whole body a dropzone
  url: "/attachments"
  thumbnailWidth: 80
  thumbnailHeight: 80
  parallelUploads: 20
  previewTemplate: previewTemplate
  autoQueue: false
  previewsContainer: "#previews"
  clickable: ".fileinput-button"
  paramName: "photo[imagefile]"
  autoDiscover: false
  headers:
          'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
)
attachment.on "addedfile", (file) ->
  
  # Hookup the start button
  file.previewElement.querySelector(".start").onclick = ->
    attachment.enqueueFile file
    return

  return


# Update the total progress bar
attachment.on "totaluploadprogress", (progress) ->
  document.querySelector("#total-progress .progress-bar").style.width = progress + "%"
  return

attachment.on "sending", (file, xhr, formData) ->
  formData.append 'photo[gallery]', $("[name='photo[gallery]']").val()
  # Show the total progress bar when upload starts
  document.querySelector("#total-progress").style.opacity = "1"
  
  # And disable the start button
  file.previewElement.querySelector(".start").setAttribute "disabled", "disabled"
  return


# Hide the total progress bar when nothing's uploading anymore
attachment.on "queuecomplete", (progress) ->
  document.querySelector("#total-progress").style.opacity = "0"
  return


# Setup the buttons for all transfers
# The "add files" button doesn't need to be setup because the config
# `clickable` has already been specified.
document.querySelector("#actions .start").onclick = ->
  attachment.enqueueFiles attachment.getFilesWithStatus(Dropzone.ADDED)
  return

document.querySelector("#actions .cancel").onclick = ->
  attachment.removeAllFiles true
  return
