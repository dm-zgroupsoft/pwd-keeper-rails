# create add/edit entry dialog
editEntryDialog = () ->
  $('select').selectBoxIt()
  $('#edit-entry-dialog').dialog height: 360, width: 420, modal: true,
  buttons: Ok: ->
    $.ajax($(this).find('form').attr('action'), method: 'post', data: $(this).find('form').serialize()).done (result) ->
      node = $('#groups-tree-holder').dynatree 'getActiveNode'
      $('#entries-holder').load "/groups/#{node.data.key}/entries", onEntriesHolderLoaded
      $('#entry-holder').load "/groups/#{node.data.key}/entries/#{result}"
    $(this).dialog 'close'
  , Cancel: ->
    $(this).dialog 'close'

window.onEntriesHolderLoaded = () ->
  groupId = $('#groups-tree-holder').dynatree('getActiveNode').data.key

  $('#entries-table').tablesorter({theme: 'jui', headerTemplate: '{content} {icon}', widgets: ['uitheme', 'zebra'], sortList: if $('#entries-table tr').length > 1 then [[0,0]] else [] })

  $('.copy-login, .copy-pass').each (i, element) ->
    initZClip(element)

  $('#entries-table tr').click ->
    $('#entries-table tr').removeClass 'entry-selected'
    $(this).addClass 'entry-selected'
    $('#entry-holder').load "/groups/#{groupId}/entries/#{$(this).attr('id')}"

  # activate entries by right mouse too
  $('#entries-table tr').mousedown (e) ->
    e.target.click() if e.button == 2

  $('#entries-table').contextMenu selector: 'tr', callback: (key, options) ->
    entryId = this.attr('id')
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
    $('#entries-holder').load "/groups/#{node.data.key}/entries", onEntriesHolderLoaded
    $('#entry-holder').html ''

initZClip = (element) ->
  clip = new ZeroClipboard()
  clip.glue(element);
  clip.on 'load', (client) ->
    $(clip.htmlBridge).tipsy { gravity: $.fn.tipsy.autoNS }
  clip.on 'complete', (client, args) ->
    copied_hint = $(this).data('copied-hint');
    $(clip.htmlBridge).prop('title', copied_hint).tipsy('show')