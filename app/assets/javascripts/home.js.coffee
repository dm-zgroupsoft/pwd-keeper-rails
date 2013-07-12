# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#jstree_holder").jstree("plugins": ["themes", "ui", "crrm", "contextmenu", "json_data"], "json_data": {"ajax": {"url": "/groups"}})

  # create group/subgroup
  .bind("create.jstree", (e, data) ->
    $.post "/groups", {
    "group[group_id]": data.rslt.parent.attr("id").replace "node_", "" if data.rslt.parent != -1
    "group[position]": data.rslt.position,
    "group[title]": data.rslt.name,
    "group[icon]": data.rslt.obj.attr("rel") || 'assets/rails.png'
    },
    (result) ->
      $(data.rslt.obj).attr "id", "node_#{result}"
  )

  # remove group/subgroup
  .bind("remove.jstree", (e, data) ->
    data.rslt.obj.each ->
      $.ajax {async: false, type: 'DELETE', url: "/groups/#{this.id.replace "node_", ""}"}
  )

  $("#menu button").click ->
    $("#jstree_holder").jstree this.id