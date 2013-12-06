$ ->
  # create groups tree
  holder = $('#groups-tree-holder').dynatree initAjax: {url: '/groups'}, onActivate: (node)->
    $('#entries-holder').load node.data.url, onEntriesHolderLoaded
  ,
  dnd: preventVoidMoves: true, onDragStart: (node) ->
    true
  , onDragEnter: (node, sourceNode) ->
      true
  , onDragStart: (node, sourceNode) ->
      true
  , onDragOver: (node, sourceNode, hitMode) ->
      if node.isDescendantOf sourceNode
        false
  , onDrop: (node, sourceNode, hitMode, ui, draggable) ->
    sourceNode.move node, hitMode

  # activate tree nodes by right mouse too
  holder.mousedown (e) ->
    if e.button == 2 && e.target.tagName == 'A'
      e.target.click()

  # attach context menu to each group in tree

  holder.contextMenu selector: 'a', callback: (key, options) ->
    groupId = $.ui.dynatree.getNode(this).data.key
    switch key
      when 'add' then addGroup groupId
      when 'edit' then editGroup groupId
      when 'remove' then removeGroup groupId
      when 'add_new_record' then addNewEntry groupId
  ,
  items:
    add: {name: 'Add subgroup', icon: 'add'},
    edit: {name: 'Edit group', icon: 'edit'},
    remove: {name: 'Remove group', icon: 'delete'},
    separator: '---',
    add_new_record: {name: 'Add new record', icon: 'add'},
    next_separator: '---',
    quit: {name: 'Quit', icon: 'quit'},

  # context menu actions
  addGroup = (parentGroupId) ->
    $('#group-dialog-holder').load "/groups/new?group_id=#{parentGroupId}", editGroupDialog

  editGroup = (groupId) ->
    $('#group-dialog-holder').load "/groups/#{groupId}/edit", editGroupDialog

  removeGroup = (groupId) ->
    $.ajax("/groups/#{groupId}", method: 'delete').done (data) ->
      holder.dynatree('getActiveNode').remove()

  # create add/edit group dialog
  editGroupDialog = () ->
    $('select').selectBoxIt()
    $('#edit-group-dialog').dialog height: 180, width: 360, modal: true,
    buttons: Ok: ->
      is_new = $(this).find('form #group_id').val().length == 0
      $.ajax($(this).find('form').attr('action'), method: $(this).find('form').attr('method'), data: $(this).find('form').serialize()).done (result) ->
        if is_new
          parent = if result.group_id then holder.dynatree('getTree').getNodeByKey result.group_id.toString() else holder.dynatree('getRoot')
          parent.addChild(result)
          parent.expand()
        else
          node = holder.dynatree('getTree').getNodeByKey result.key.toString()
          node.data.title = result.title
          node.data.addClass = result.addClass
          node.render()
      $(this).dialog 'close'
    , Cancel: ->
      $(this).dialog 'close'

  # add group to root node
  $('#add-group').click ->
    addGroup ''