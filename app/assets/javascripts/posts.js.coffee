$(document).ready ->
  $(document).on 'ajax:success', (xhr, data, status) ->
    $('#category-notice').append '<div id="notice">'+data.notice+'</div>'
    return

  $.modal.defaults =
    showSpinner: true
    overlay: "#000"      
    opacity: 0.75        
    zIndex: 1           
    escapeClose: true    
    clickClose: true       
    closeText: 'Close'     
    closeClass: ''        
    showClose: false
    modalClass: "modal"    
    fadeDuration: null    
    fadeDelay: 1.0          
