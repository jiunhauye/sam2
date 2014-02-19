# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
w = 0
h = 0
ratio = 0
class LayerInfo
  this.solution = "solution"
  this.strategy = "strategy"
  this.operation = "operation"
  this.execution = "execution"
  this.implementation = "implementation"
  this.layer = [new LayerInfo(LayerInfo.solution), new LayerInfo(LayerInfo.strategy),new LayerInfo(LayerInfo.operation),new LayerInfo(LayerInfo.execution),new LayerInfo(LayerInfo.implementation)]
  this.layerDomain = [this.solution, this.strategy,  this.operation,  this.execution, this.implementation]
  this.layerRange = d3.scale.ordinal().domain(this.layerDomain).range([0,1,2,3,4])  
  
  distancelinear : null
  constructor: (@layer,@totalRels =0,@totalNodes=0) ->
  
  updateDistancelinear:  ->
    return
    
  distance: (weight) ->
    unit = 2 *LayerInfo.layerRange(@layer) * 3.14  / @totalNodes
    max = LayerInfo.layerRange(@layer) *  1.1
    formula = d3.scale.linear().domain([1,@totalRels]).range([max,unit])
    result = formula(weight) 
    console.log("layer/rels/weight/unit/max/result:"+ LayerInfo.layerRange(@layer)+"/"+ @totalRels+"/"+weight+"/"+unit+"/"+max+"/"+result)
    result
     
  
  # linear = d3.scale.linear().domain().range([0,1])
layer = LayerInfo.layer
maxLayer = (layer.length)-1
ABS_MAX = maxLayer
force = null 
force2 = null 
nodes = null
links = null
data = null

graph_layer = (json) ->
  data = json
  console.log("data==>")
  console.log(data)
  
  $("#about").dialog
    autoOpen: not 1
    show: "blind"
    hide: "explode"
    width: 800
    height: 600
  
  # a = {}
  # a["solution"] = true
  # a["strategy"] = true
  # a["operation"] = true
  # a["execution"] = true
  # a["implementation"] = true
  
  
  
  b = ""
  d3.map(layer).forEach (i,a) ->
    b += "<input type='checkbox' value='" + a.layer + "' id='" + a.layer + "' name='chartOption'"
    "solution" is a.layer and (b += " checked='checked' style='opacity:0; position:absolute; left:9999px;'")
    b += "/>"
    "solution" isnt a.layer and (b += "<label for='" + a.layer + "'>" + a.layer + "</label>")
    return

  
  $("#chartSelector").html b
  $("#chartSelector").buttonset()
  $("#chartSelector").change (a) ->
    graph_layer_drawChart()
  
  graph_layer_drawChart()
  $("#slider").slider
    change: graph_layer_maxlayerChange
    min: 1
    max: ABS_MAX
    value: maxLayer

graph_layer_maxlayerChange = (a,b) ->
  maxLayer=b.value
  graph_layer_drawChart()

#function about(){$("#about").dialog("open");return!1}
 
graph_layer_drawChart = () ->
  null isnt d3.select("#graph") and d3.select("#graph").remove()
  null isnt force and force.stop()
  null isnt force2 and force2.stop()
  #clear all relations number
  layer.forEach (v,a) ->
    v.totalRels=0
    v.totalNodes=0
    
  nodes = []
  links = []
  w = $("#graphHolder").width()
  h = $("#graphHolder").height()
  ratio = (if w > h then h / (2 * maxLayer) else w / (2 * maxLayer))
  a = w / 2 + 150
  b = h / 2
  c = Math.round($("#species_information").position().top - $("#toolbox").position().top)
  c = $("#toolbox").height() - c - 10
  $("#species_information").css "height", c + "px"
  c = d3.select("#graphHolder").append("svg:svg").attr("id", "graph").attr("width", w).attr("height", h)
  graph_layer_drawReference c, a, b
  e = [] #collection of new node position
  g = [] #collection of new link position (filter data by nodes in e[])
  k = {} #record index transformation
  d = 0
  ##Relink all source and target
  console.log($("#solution").prop("checked"))
  console.log($("#strategy").prop("checked"))
  console.log($("#operation").prop("checked"))
  console.log($("#execution").prop("checked"))
  console.log($("#implementation").prop("checked"))
  
  solutionIndex = 0
  data.nodes.forEach (l, a) ->
    if $("#" + l["layer"]).prop("checked") isnt `undefined` and $("#" + l["layer"]).prop("checked") 
      # console.log(l["layer"])
      # console.log($("#" + l["layer"]).prop("checked"))
      l.count=0
      layer[LayerInfo.layerRange(l["layer"])].totalNodes++
      e.push(l)
      solutionIndex = d if "solution" == l["layer"] # index solutionIndex
      k[a] = d ##record lastest mapping 
      d++
    return

  ##add link
  data.links.forEach (a, b) ->
    console.log(k[a.source])
    if k[a.source] isnt `undefined` and k[a.source]? and k[a.target] isnt `undefined` and k[a.target]? 
      g.push(
        source: k[a.source]
        target: k[a.target]
        class:  a.rel
        ori: a
      )
      # e[k[a.source]].count++
      e[k[a.target]].count++
      # layer[LayerInfo.layerRange(e[k[a.source]]["layer"])].totalRels++
      layer[LayerInfo.layerRange(e[k[a.target]]["layer"])].totalRels++
    return
  
  
  ##add sudo for fix lay link
  tmp = 0
  console.log(Object.keys(k).length)
  while tmp < Object.keys(k).length    
    if(tmp != solutionIndex) ## tmp is the original position of nodes
      filted = g.filter (x) -> x.source == solutionIndex && x.target == tmp
      if(filted.length ==0)
        # g.push(
          # source:solutionIndex
          # target:tmp
          # class: "sudo"
        # )
        nodesNumber = layer[LayerInfo.layerRange(e[tmp].layer)].totalNodes
        while nodesNumber >0 ## add gravity
          g.splice(0,0,
            source:solutionIndex
            target:tmp
            class: "sudo"
          )     
          nodesNumber--
      else
          filted[0].class = "sudo"    
    tmp++
  
  ##add distance for no distance node
  tmp=1
  while tmp < layer.length
    filted = e.filter (x) -> x.layer is layer[tmp].layer
    
    tmp2=0
    while tmp2 < filted.length
      tmp3=tmp2
      while tmp3 < filted.length
        linkTmp = g.filter (x) -> x.source == e.indexOf(filted[tmp2]) && x.target ==  e.indexOf(filted[tmp3])
        if(linkTmp.length ==0)
          g.splice(0,0,
            source:tmp2
            target:tmp3
            class: "sudoSameLayer"
            layer: layer[tmp]
          )  
        tmp3++
      tmp2++    
    tmp++
    
        
    # tmp2=0
    # while (tmp2+1) < filted.length
      # linkTmp = g.filter (x) -> x.source == e.indexOf(filted[tmp2]) && x.target ==  e.indexOf(filted[tmp2+1])
      # if(linkTmp.length ==0)
        # g.splice(0,0,
          # source:tmp2
          # target:tmp2+1
          # class: "sudoSameLayer"
          # layer: layer[tmp]
        # )  
      # tmp2++    
    # tmp++    
    
    # tmp2=0
    # while tmp2 < filted.length
      # tmp3=0
      # while tmp3 < filted.length
        # linkTmp = g.filter (x) -> x.source == e.indexOf(filted[tmp2]) && x.target ==  e.indexOf(filted[tmp3])
        # if(linkTmp.length ==0)
          # g.splice(0,0,
            # source:tmp2
            # target:tmp3
            # class: "sudoSameLayer"
            # layer: layer[tmp].layer
          # )            
        # tmp3++
      # tmp2++    
    # tmp++
  
  for v of layer
    v.updateDistancelinear

      
  console.log("solutionIndex:"+solutionIndex)
  console.log(layer)
  console.log(e)
  console.log(k)
  console.log(g)
  f = e[solutionIndex]
  f.fixed = not 0
  f.x = a
  f.y = b
  
  # linear = d3.scale.linear().domain().range([0,1])
  force = d3.layout.force().charge(-30).linkDistance((a) ->
    if a.class.indexOf("sudo") is 0 # sudo link
      if a.class is "sudo"
        console.log("sudo source/target:"+LayerInfo.layerRange(a.source.layer)+"/"+LayerInfo.layerRange(a.target.layer)+"/"+Math.abs(LayerInfo.layerRange(a.source.layer)-LayerInfo.layerRange(a.target.layer))+a.source.layer+"-"+a.source.name+" / "+a.target.layer+"/"+a.target.name)
        ratio * LayerInfo.layerRange(a.target.layer)
      else
        console.log("sudolayer source/target:"+Math.abs(LayerInfo.layerRange(a.source.layer)-LayerInfo.layerRange(a.target.layer))+a.source.layer+"-"+a.source.name+" / "+a.target.layer+"/"+a.target.name)
        #ratio * 1
        ratio * layer[LayerInfo.layerRange(a.target.layer)].distance(a.target.count)
    else # real link
      if (LayerInfo.layerRange(a.source.layer)-LayerInfo.layerRange(a.target.layer)) is 0 # same layer       
        console.log("same source/target:"+Math.abs(LayerInfo.layerRange(a.source.layer)-LayerInfo.layerRange(a.target.layer))+a.source.layer+"-"+a.source.name+" / "+a.target.layer+"/"+a.target.name)        
        #ratio * 1
        #ratio * LayerInfo.layerRange(a.source.layer) * 0.6 
        #ratio * (LayerInfo.layerRange(a.source.layer) * (a.source.count/(a.source.count+a.target.count)))
        
        ratio * layer[LayerInfo.layerRange(a.target.layer)].distance(a.target.count)
        
      else # cross layer
        console.log("cross source/target:"+Math.abs(LayerInfo.layerRange(a.source.layer)-LayerInfo.layerRange(a.target.layer))+a.source.layer+"-"+a.source.name+" / "+a.target.layer+"/"+a.target.name)
        ratio * Math.abs(LayerInfo.layerRange(a.source.layer)-LayerInfo.layerRange(a.target.layer))    
      
  ).linkStrength((a) ->
    if a.class is "sudo" # sudo link
      1
    else # real link
      0.6
  ).size([
    w
    h
  ]).gravity(0).nodes(e).links(g).start()
  
  links = c.append("g").attr("class", "linkContainer").selectAll(".link").data(g).enter().append("line").attr("class", (d) -> d.class)
  nodes = c.append("g").attr("class", "nodeContainer").selectAll(".node").data(e).enter().append("image").call(force.drag).attr("xlink:href", (a) ->
    graph_layer_getImageName a.layer
  ).attr("id", (a) ->
    a.name
  ).attr("class", "image").attr("x", -25).attr("y", -25).attr("width", 25).attr("height", 25).attr("cursor", "pointer").on("click", (a) ->
    graph_layer_showInformation a.name, a.shortDescription, a.layer
    return
  )
  $("svg image").tipsy
    gravity: "nw"
    html: not 0
    title: ->
      a = @__data__
      "<span class='floatingp'>" + a.name + "</span><br/>Layer: <b>" + a.layer + " </b><br/>(click for more info)"
  
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


graph_layer_showInformation = (name,description,layer) ->
  $("#species_information").html("<p><b>"+name+"</b><br/>description: <b>"+description+" </b></p>")
  a=Math.round($("#wikiframe").position().top-$("#species_information").position().top)
  a=$("#species_information").height()-a-10
  #$("#wikiframe").css("height",a+"px")
  
graph_layer_getImageName = (a) ->
  "/assets/"+a+".png"
  # a = a.toLowerCase().replace(/[ -]/g, "_")
  # switch a
    # when "0" then return ".assets/image/solution.jpg"
    # when "1" then return ".assets/image/strategy.jpg" 
    # when "2" then return ".assets/image/operation.jpg" 
    # when "3" then return ".assets/image/execution.jpg"  
    # when "4" then return ".assets/image/implementation.jpg" 
  # else return ""     




graph_layer_drawReference = (a,b,c) ->
  a=a.append("g").attr("id","referenceGroup").attr("class","referenceGroup")
  e = d3.scale.linear().domain([0,maxLayer]).range([d3.rgb(100, 80, 30), "lightyellow" ])
  g = d3.scale.linear().domain([0,maxLayer]).range([d3.rgb(200, 150, 150),"darkred"])
  
  k = 1
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

graph_mash = ()->
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

test = ->
  alert("I am here")
  

$(document).ready ->  
  d3.json("/assets/tree.json", (json) ->
    graph_layer(json)  
  )
    
 