$ ->
  # create groups tree
  holder = $('#groups_tree_holder').dynatree initAjax: {url: '/groups'}

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
  ,
  items:
    add: {name: 'Add subgroup', icon: 'add'},
    edit: {name: 'Edit group', icon: 'edit'},
    remove: {name: 'Remove group', icon: 'delete'},
    separator: '---'
    quit: {name: 'Quit', icon: 'quit'},

  # context menu actions
  # add group
  addGroup = (parent) ->
    $('#group_id').val if parent.getLevel() then parent.data.key else ''
    $('#edit_group_dialog').dialog 'open'

  # edit group
  editGroup = (group) ->
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
  ,
  buttons: Ok: ->
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