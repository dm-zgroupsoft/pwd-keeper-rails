$ ->
  # create groups tree
  holder = $('#groups_tree_holder').dynatree initAjax: {url: '/groups'}, onActivate: (node)->
    $('#entries_holder').load(node.data.url)
  ,
  dnd: preventVoidMoves: true, onDragStart: (node) ->
    true
  , onDragEnter: (node, sourceNode) ->
      true
  , onDragOver: (node, sourceNode, hitMode) ->
      if node.isDescendantOf sourceNode
        false
      if !node.data.isFolder && hitMode == 'over'
        'after'
  , onDrop: (node, sourceNode, hitMode, ui, draggable) ->
    sourceNode.move node, hitMode

  # activate tree nodes by right mouse too
  holder.mousedown (e) ->
    if e.button == 2 && e.target.tagName == 'A'
      e.target.click()

  # attach context menu to each group in tree

  holder.contextMenu selector: 'a', callback: (key, options) ->
    node = $.ui.dynatree.getNode this
    switch key
      when 'add' then addGroup node
      when 'edit' then editGroup node
      when 'remove' then removeGroup node
      when 'add_new_record' then addNewRecord node
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
  # add group
  addGroup = (parent) ->
    $('#group_dialog_holder').load "/groups/new?group_id=#{if parent.getLevel() then parent.data.key else ''}", openGroupDialog

  # edit group
  editGroup = (group) ->
    $('#group_dialog_holder').load "/groups/#{group.data.key}/edit", openGroupDialog

  # remove group
  removeGroup = (group) ->
    $.ajax("/groups/#{group.data.key}", method: 'delete').done (data) ->
      holder.dynatree('getTree').getNodeByKey(data).remove()

  # add new record
  addNewRecord = (group) ->
    $('#edit_record_dialog').dialog 'open'

  # create add/edit group dialog
  openGroupDialog = () ->
    $('#edit_group_dialog').dialog height: 220, width: 280, modal: true,
    buttons: Ok: ->
      console.log $('#group_id')
      is_new = $('#group_id').val().length == 0
      $.ajax($(this).find('form').attr('action'), method: $(this).find('form').attr('method'), data: $(this).find('form').serialize()).done (result) ->
        if is_new
          parent = if result.group_id then holder.dynatree('getTree').getNodeByKey result.group_id.toString() else holder.dynatree('getRoot')
          parent.addChild(result)
          parent.expand()
        else
          node = holder.dynatree('getTree').getNodeByKey result.key.toString()
          node.data.title = result.title
          node.render()
      $(this).dialog 'close'
    , Cancel: ->
      $(this).dialog 'close'

  # add group to root node
  $('#add_group').click ->
    addGroup holder.dynatree('getRoot')