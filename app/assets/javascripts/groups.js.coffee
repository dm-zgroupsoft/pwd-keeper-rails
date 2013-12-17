$ ->
  # create groups tree
  holder = $('#groups-tree-holder').dynatree initAjax: {url: '/groups'}, onActivate: (node)->
    $('#entry-holder').html ''
    $('#entries-holder').load "/groups/#{node.data.key}/entries", onEntriesHolderLoaded
  ,
  dnd: preventVoidMoves: true, onDragStart: (node) ->
    true
  , onDragEnter: (node, sourceNode) ->
      true
  , onDragOver: (node, sourceNode, hitMode) ->
      if node.isDescendantOf sourceNode
        false
  , onDrop: (node, sourceNode, hitMode, ui, draggable) ->
    $.ajax("groups/#{sourceNode.data.key}/move", method: 'patch', data: {target_id: node.data.key, mode: hitMode}).done (result) ->
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
    $('#group-dialog-holder').load "/groups/new?parent_id=#{parentGroupId}", editGroupDialog

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
      action = $(this).find('form').attr('action')
      $.ajax(action, method: 'post', data: $(this).find('form').serialize()).done (result) ->
        if action == '/groups'
          parent = holder.dynatree('getTree').getNodeByKey(result.parent_id.toString()) || holder.dynatree('getRoot')
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