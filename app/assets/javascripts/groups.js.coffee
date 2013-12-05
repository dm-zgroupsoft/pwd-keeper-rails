$ ->
  # create groups tree
  holder = $('#groups-tree-holder').dynatree initAjax: {url: '/groups'}, onActivate: (node)->
    $('#entries-holder').load node.data.url, () ->
      $("#entries-table").tablesorter({theme: 'jui', headerTemplate: '{content} {icon}', widgets: ['uitheme', 'zebra'], sortList: [[0,0]] })
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
    node = $.ui.dynatree.getNode this
    switch key
      when 'add' then addGroup node
      when 'edit' then editGroup node
      when 'remove' then removeGroup node
      when 'add_new_record' then addNewEntry node
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
  addGroup = (parent) ->
    $('#group-dialog-holder').load "/groups/new?group_id=#{if parent.getLevel() then parent.data.key else ''}", editGroupDialog

  editGroup = (group) ->
    $('#group-dialog-holder').load "/groups/#{group.data.key}/edit", editGroupDialog

  removeGroup = (group) ->
    $.ajax("/groups/#{group.data.key}", method: 'delete').done (data) ->
      holder.dynatree('getTree').getNodeByKey(data).remove()

  # add new entry
  addNewEntry = (group) ->
    $('#group-dialog-holder').load "/groups/#{group.data.key}/entries/new", editEntryDialog

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
    addGroup holder.dynatree('getRoot')