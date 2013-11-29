# create add/edit entry dialog
window.editEntryDialog = () ->
  $('#edit_entry_dialog').dialog height: 280, width: 400, modal: true,
  buttons: Ok: ->
    $(this).dialog 'close'
  , Cancel: ->
    $(this).dialog 'close'
