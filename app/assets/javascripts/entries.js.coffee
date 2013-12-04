# create add/edit entry dialog
window.editEntryDialog = () ->
  $('select').selectBoxIt()
  $('#edit-entry-dialog').dialog height: 320, width: 400, modal: true,
  buttons: Ok: ->
    $.ajax($(this).find('form').attr('action'), method: $(this).find('form').attr('method'), data: $(this).find('form').serialize()).done (result) ->
      node = $('#groups-tree-holder').dynatree('getTree').getNodeByKey result.group_id.toString()
      $('#entries-holder').load(node.data.url)
    $(this).dialog 'close'
  , Cancel: ->
    $(this).dialog 'close'
