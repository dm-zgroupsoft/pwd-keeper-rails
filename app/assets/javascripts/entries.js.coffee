# create add/edit entry dialog
editEntryDialog = () ->
  $('select').selectBoxIt()
  $('#edit-entry-dialog').dialog height: 300, width: 420, modal: true,
  buttons: Ok: ->
    $.ajax($(this).find('form').attr('action'), method: 'post', data: $(this).find('form').serialize()).done (result) ->
      node = $('#groups-tree-holder').dynatree 'getActiveNode'
      $('#entries-holder').load "/groups/#{node.data.key}/entries", onEntriesHolderLoaded
    $(this).dialog 'close'
  , Cancel: ->
    $(this).dialog 'close'

window.onEntriesHolderLoaded = () ->
  $('#entries-table').tablesorter({theme: 'jui', headerTemplate: '{content} {icon}', widgets: ['uitheme', 'zebra'], sortList: if $('#entries-table tr').length > 1 then [[0,0]] else [] })
  $('#entries-table').contextMenu selector: 'tr', callback: (key, options) ->
    entryId = this.attr('id')
    groupId = $('#groups-tree-holder').dynatree('getActiveNode').data.key
    switch key
      when 'add' then addNewEntry groupId
      when 'edit' then editEntry groupId, entryId
      when 'remove' then removeEntry groupId, entryId
  ,
  items:
    add: {name: 'Add new record', icon: 'add'},
    edit: {name: 'Edit record', icon: 'edit'},
    remove: {name: 'Remove record', icon: 'delete'},
    separator: '---',
    quit: {name: 'Quit', icon: 'quit'},

# add new entry
window.addNewEntry = (groupId) ->
  $('#group-dialog-holder').load "/groups/#{groupId}/entries/new", editEntryDialog

# edit entry
editEntry = (groupId, entryId) ->
  $('#group-dialog-holder').load "/groups/#{groupId}/entries/#{entryId}/edit", editEntryDialog

# remove entry
removeEntry = (groupId, entryId) ->
  $.ajax("/groups/#{groupId}/entries/#{entryId}", method: 'delete').done (data) ->
    node = $('#groups-tree-holder').dynatree 'getActiveNode'
    $('#entries-holder').load node.data.url, onEntriesHolderLoaded