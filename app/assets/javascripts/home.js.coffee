# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
  $("#jstree_holder").jstree("plugins": ["themes", "ui", "crrm", "contextmenu", "json_data"]
  ,"json_data": {"ajax": {"url": "/groups", "data": (n) -> {"id" : null}}}
  ,"core" : {"initially_open" : [ "node_0"]}
  ,"types": {"types": {"group": {}}})
  .bind("create.jstree", (e, data) ->
    $.post "/groups", {
    "group[group_id]": (data.rslt.parent.attr("id").replace("node_","") if data.rslt.parent != -1)
    "group[position]": data.rslt.position,
    "group[title]": data.rslt.name,
    "group[icon]": data.rslt.obj.attr("rel")}, (result) ->
      $(data.rslt.obj).attr("id", "node_" + result.id);
    )

  $("#menu button").click ->
    switch this.id
      when "add_group" then $("#jstree_holder").jstree "create", null, "last", {"attr":
        { "rel": "group" }}