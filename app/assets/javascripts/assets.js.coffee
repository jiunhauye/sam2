# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  graph_mash

graph_layer ->
  data = {}
  $.ajax({
    dataType: "json",
    url: "/assets/tree.json",
    data: data,
    success: success
  });  
  
  console.log("data==>"+data)
  
  $("#about").dialog
    autoOpen: not 1
    show: "blind"
    hide: "explode"
    width: 800
    height: 600
  
  a = {}
  a["Strategy"] = true
  a["Operation"] = true
  a["Execution"] = true
  a["Implementation"] = true
  
  
  
  b = ""
  d3.map(a).keys().forEach (a) ->
    b += "<input type='checkbox' value='" + a + "' id='" + a + "' name='chartOption'"
    "mammalia" is a and (b += " checked='checked'")
    b += "/><label for='" + a + "'>" + a + "</label>"
    return
  
  $("#chartSelector").html b
  $("#chartSelector").buttonset()
  $("#chartSelector").change (a) ->
    graph_layer_drawChart(data)
  
  graph_layer_drawChart(data)
  $("#slider").slider
    change: maxAgeChange
    min: 10
    max: ABS_MAX
    value: maxAge
 
graph_layer_drawChart(data) ->
  null isnt d3.select("#graph") and d3.select("#graph").remove()
  null isnt force and force.stop()
  null isnt force2 and force2.stop()
  nodes = []
  links = []
  w = $("#graphHolder").width()
  h = $("#graphHolder").height()
  ratio = (if w > h then h / (2 * maxAge) else w / (2 * maxAge))
  a = w / 2 + 150
  b = h / 2
  c = Math.round($("#species_information").position().top - $("#toolbox").position().top)
  c = $("#toolbox").height() - c - 10
  $("#species_information").css "height", c + "px"
  c = d3.select("#graphHolder").append("svg:svg").attr("id", "graph").attr("width", w).attr("height", h)
  graph_layer_drawReference c, a, b, 4
  e = []
  g = []
  k = {}
  d = 0
  data.nodes.forEach (l, a) ->
    if 0 is a or null isnt $("#" + l["class"]).attr("checked")
      e.push(l)
      k[a] = d
      d++
    return
  
  data.links.forEach (a, b) ->
    null isnt k[a.source] and g.push(
      source: k[a.source]
      target: a.target
      age: a.age
    )
    return
  
  f = e[0]
  f.fixed = not 0
  f.x = a
  f.y = b
  force = d3.layout.force().charge(-30).linkDistance((a) ->
    ratio * a.age
  ).size([
    w
    h
  ]).gravity(0).nodes(e).links(g).start()
  links = c.append("g").attr("class", "linkContainer").selectAll(".link").data(g).enter().append("line").attr("class", "link")
  nodes = c.append("g").attr("class", "nodeContainer").selectAll(".node").data(e).enter().append("image").call(force.drag).attr("xlink:href", (a) ->
    getImageName a.name
  ).attr("id", (a) ->
    a.name
  ).attr("class", "image").attr("x", -25).attr("y", -25).attr("width", 50).attr("height", 50).attr("cursor", "pointer").on("click", (a) ->
    showInformation a.name, a.species, a.age
    return
  )
  $("svg image").tipsy
    gravity: "w"
    html: not 0
    title: ->
      a = @__data__
      "<span class='floatingp'>" + a.name + "</span><br/>Max. recorded age: <b>" + a.age + " years</b><br/>(click for more info)"
  
  c.select("#root").style("cx", a).style("cy", b).style("fill", "black").attr("r", 1).on("mousedown.drag", null).on "mouseover", null
  force.on "tick", ->
    links.attr("x1", (a) ->
      a.source.x
    ).attr("y1", (a) ->
      a.source.y
    ).attr("x2", (a) ->
      a.target.x
    ).attr "y2", (a) ->
      a.target.y
  
    nodes.attr "transform", (a) ->
      "translate(" + a.x + "," + a.y + ")"
  
    




graph_layer_drawReference(a,b,c,maxLayer) ->
  a=a.append("g").attr("id","referenceGroup").attr("class","referenceGroup")
  e = d3.scale.linear().domain([0,maxLayer]).range([d3.rgb(100, 80, 30), "lightyellow" ])
  g = d3.scale.linear().domain([0,maxLayer]).range([d3.rgb(200, 150, 150),"darkred"])
  k = Math.round(0.1 * maxLayer)
  d = maxLayer

  while 0 < d
    f = ratio * d
    l = g(d)
    m = e(d)
    a.append("circle").attr("class", "reference").attr("cx", b).attr("cy", c).attr("r", f).style("fill", m).style("stroke", "gray").style "stroke-width", "1px"
    a.append("svg:text").text(d).attr("x", b + f - 5 + 1).attr("y", c + 1).style "fill", "black"
    a.append("svg:text").text(d).attr("x", b + f - 5).attr("y", c).style "fill", l
    a.append("svg:text").text(d).attr("x", b - f - 5 + 1).attr("y", c + 1).style "fill", "black"
    a.append("svg:text").text(d).attr("x", b - f - 5).attr("y", c).style "fill", l
    d -= k

graph_mash ->
  w = 1260
  h = 1300
  fill = d3.scale.category20()

  vis = d3.select("#graph").append("svg:svg").attr("width", w).attr("height", h)

  d3.json("/assets/tree.json", (json) ->
    force = d3.layout.force()
        .charge(-320)
        .linkDistance(160)
        .nodes(json.nodes)
        .links(json.links)
        .size([w, h])
        .start()
        
  
    vis.append("defs").selectAll("marker")
      #.data(["Compose", "AssociateWith", "Aggregate", "Inherit", "use", "support", "realize", "implement", "refer"])
      .data(["Compose", "AssociateWith", "Aggregate", "Inherit"])
      .enter().append("marker")
      .attr("id", (d) -> d)
      .attr("viewBox", "0 -5 10 10")
      .attr("refX", 15)
      .attr("refY", -1.5)
      .attr("markerWidth", 6)
      .attr("markerHeight", 6)
      .attr("orient", "auto")
      .append("path")
      .attr("d", "M0,-5L10,0L0,5")
      

    # link = vis.selectAll("line.link")
      # .data(json.links)
      # .enter().append("svg:line")
      # .attr("class", "link")
      # .style("stroke-width", (d) -> Math.sqrt(d.value))
      # .attr("x1", (d) -> d.source.x)
      # .attr("y1", (d) -> d.source.y)
      # .attr("x2", (d) -> d.target.x)
      # .attr("y2", (d) -> d.target.y)
      
    path = vis.selectAll("g.path")
    .data(json.links)
    .enter().append("path")
    .attr("class", (d) -> "link " + d.rel )
    .attr("marker-end", (d) -> "url(#" + d.rel + ")")
    
      
      

    node = vis.selectAll("g.node")
      .data(json.nodes)
      .enter().append("svg:g")
      .attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")
      .attr("class", "node")
      .call(force.drag)

    node.append("svg:circle")
      #.attr("r", (d) -> if d.value > 25 then 50 else d.value*2 + 5)
     .attr("r", 5)
      .style("fill", (d) -> '#fea')

    node.append("svg:title").text((d) -> d.name)
    node.append("svg:text")
      .attr("text-anchor", "middle")
      .attr("dy", ".3em")
      .text((d) -> d.name)

    vis.style("opacity", 1e-6)
      .transition()
      .duration(0)
      .style("opacity", 1)

    force.on("tick", ->
      #link.attr("x1", (d) -> d.source.x).attr("y1", (d) -> d.source.y).attr("x2", (d) -> d.target.x).attr("y2", (d) -> d.target.y)
      path.attr("d", (d) -> 
        dx = d.target.x - d.source.x
        dy = d.target.y - d.source.y
        dr = Math.sqrt(dx * dx + dy * dy)
        "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y
      
      )
      
      node.attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")
    )
    
    
  )

  
 