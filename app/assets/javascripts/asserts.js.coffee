# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# $(document).ready ->
  # w = 1260
  # h = 1300
  # fill = d3.scale.category20()
# 
  # vis = d3.select("#graph").append("svg:svg").attr("width", w).attr("height", h)
# 
  # d3.json("/asserts.json", (json) ->
    # force = d3.layout.force()
        # .charge(-320)
        # .linkDistance(160)
        # .nodes(json.nodes)
        # .links(json.links)
        # .size([w, h])
        # .start()
#         
#   
    # vis.append("defs").selectAll("marker")
      # .data(["compose", "include", "aggregate", "depend", "use", "support", "realize", "implement", "refer"])
      # .enter().append("marker")
      # .attr("id", (d) -> d)
      # .attr("viewBox", "0 -5 10 10")
      # .attr("refX", 15)
      # .attr("refY", -1.5)
      # .attr("markerWidth", 6)
      # .attr("markerHeight", 6)
      # .attr("orient", "auto")
      # .append("path")
      # .attr("d", "M0,-5L10,0L0,5")
#       
# 
    # # link = vis.selectAll("line.link")
      # # .data(json.links)
      # # .enter().append("svg:line")
      # # .attr("class", "link")
      # # .style("stroke-width", (d) -> Math.sqrt(d.value))
      # # .attr("x1", (d) -> d.source.x)
      # # .attr("y1", (d) -> d.source.y)
      # # .attr("x2", (d) -> d.target.x)
      # # .attr("y2", (d) -> d.target.y)
#       
    # path = vis.selectAll("g.path")
    # .data(json.links)
    # .enter().append("path")
    # .attr("class", (d) -> "link " + d.rel )
    # .attr("marker-end", (d) -> "url(#" + d.rel + ")")
#     
#       
#       
# 
    # node = vis.selectAll("g.node")
      # .data(json.nodes)
      # .enter().append("svg:g")
      # .attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")
      # .attr("class", "node")
      # .call(force.drag)
# 
    # node.append("svg:circle")
      # #.attr("r", (d) -> if d.value > 25 then 50 else d.value*2 + 5)
     # .attr("r", 5)
      # .style("fill", (d) -> '#fea')
# 
    # node.append("svg:title").text((d) -> d.name)
    # node.append("svg:text")
      # .attr("text-anchor", "middle")
      # .attr("dy", ".3em")
      # .text((d) -> d.name)
# 
    # vis.style("opacity", 1e-6)
      # .transition()
      # .duration(0)
      # .style("opacity", 1)
# 
    # force.on("tick", ->
      # #link.attr("x1", (d) -> d.source.x).attr("y1", (d) -> d.source.y).attr("x2", (d) -> d.target.x).attr("y2", (d) -> d.target.y)
      # path.attr("d", (d) -> 
        # dx = d.target.x - d.source.x
        # dy = d.target.y - d.source.y
        # dr = Math.sqrt(dx * dx + dy * dy)
        # "M" + d.source.x + "," + d.source.y + "A" + dr + "," + dr + " 0 0,1 " + d.target.x + "," + d.target.y
#       
      # )
#       
      # node.attr("transform", (d) -> "translate(" + d.x + "," + d.y + ")")
    # )
#     
#     
  # )
 
