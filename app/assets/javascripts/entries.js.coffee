# create add/edit record dialog
$('#edit_record_dialog').dialog autoOpen: false,
height: 320,
width: 380,
modal: true,
close: ->
  $(this).find('form input').val('')
  $('input[name="group[icon]"]').val('/assets/def.png')
,
buttons: Ok: ->
  $(this).dialog 'close'
, Cancel: ->
  $(this).dialog 'close'