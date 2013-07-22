$ ->
  # create groups tree
  holder = $('#groups_tree_holder').dynatree initAjax: {url: '/groups'}, dnd: preventVoidMoves: true, onDragStart: (node) ->
    console.log "tree.onDragStart"
    true
  , onDragEnter: (node, sourceNode) ->
    console.log "enter drag"
    ["before", "after"]
  , onDrop: (node, sourceNode, hitMode, ui, draggable) ->
    console.log "tree.onDrop"
    sourceNode.move node, hitMode

  # activate tree nodes by right mouse too
  #holder.mousedown (e) ->
   # if e.button == 2 && e.target.tagName == 'A'
    #  e.target.click()

  # attach context menu to each group in tree
  ###
  holder.contextMenu selector: 'a', callback: (key, options) ->
    node = $.ui.dynatree.getNode this
    switch key
      when 'add' then addGroup node
      when 'edit' then editGroup node
      when 'remove' then removeGroup node
  ,
  items:
    add: {name: 'Add subgroup', icon: 'add'},
    edit: {name: 'Edit group', icon: 'edit'},
    remove: {name: 'Remove group', icon: 'delete'},
    separator: '---'
    quit: {name: 'Quit', icon: 'quit'},
  ###
  # context menu actions
  # add group
  addGroup = (parent) ->
    $('#group_id').val if parent.getLevel() then parent.data.key else ''
    $('#edit_group_dialog').dialog 'open'

  # edit group
  editGroup = (group) ->
    $('#key').val group.data.key
    $('#title').val group.data.title
    $('#edit_group_dialog').dialog 'open'

  # remove group
  removeGroup = (group) ->
    $.ajax("/groups/#{group.data.key}", method: 'delete').done (data) ->
      holder.dynatree('getTree').getNodeByKey(data).remove()

  # create add/edit group dialog
  $('#edit_group_dialog').dialog autoOpen: false,
  height: 220,
  width: 280,
  modal: true,
  close: ->
    $(this).find('form input').val('')
    $('input[name="group[icon]"]').val('/assets/def.png')
  ,
  buttons: Ok: ->
    if $('#key').val().length
      $.ajax("/groups/#{$('#key').val()}", method: 'put', data: $(this).find('form').serialize()).done (data) ->
        node = holder.dynatree('getTree').getNodeByKey data.key.toString()
        node.data.title = data.title
        node.render()
    else
      $.post '/groups', $(this).find('form').serialize(), (result) ->
        parent = if result.group_id then holder.dynatree('getTree').getNodeByKey result.group_id.toString() else holder.dynatree('getRoot')
        parent.addChild(result)
        parent.expand()
    $(this).dialog 'close'
  , Cancel: ->
    $(this).dialog 'close'

  # add group to root node
  $('#add_group').click ->
    addGroup holder.dynatree('getRoot')