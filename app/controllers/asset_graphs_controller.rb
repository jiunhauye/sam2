class AssetGraphsController < ApplicationController
  
  # GET /asset_graphs
  # GET /asset_graphs.json
  def index
    @asset_graphs = AssetGraph.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asset_graphs }
    end
  end

  # GET /asset_graphs/1
  # GET /asset_graphs/1.json
  def show
    @asset_graph = AssetGraph.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset_graph }
    end
  end

  # GET /asset_graphs/new
  # GET /asset_graphs/new.json
  def new
    @asset_graph = AssetGraph.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset_graph }
    end
  end

  # GET /asset_graphs/1/edit
  def edit
    @asset_graph = AssetGraph.find(params[:id])
  end

  # POST /asset_graphs
  # POST /asset_graphs.json
  def create
    @asset_graph = AssetGraph.new(params[:asset_graph])
    @graphJson = JSON.parse(@asset_graph.graph)
    puts "===Start===Size#{@graphJson.length}"
    adjacencies = []
    @assets_tmp = []
    @graphJson.each do |obj|
      construct = {}
      obj.each do |key,value|        
        case key
          when "id"
            construct[:assetId] = value
          when "name"
            construct[:assetName] = value
          when "data"
            construct[:domainPath] = value["path"]
            construct[:state] = value["state"]
            construct[:level] = value["layer"]
            construct[:version] = value["version"]
          when "adjacencies"
             adjacencies = value
          else
            puts "key:#{key}---value:#{value}"
        end 
      end    
      puts "asset construct:#{construct}"
      
      result = Asset.new(construct)
      puts result.assetId
      ##OK Prepare to saving
      #result.save
      
      Asset.class_eval do
        def setAdjacencies(adjacencies)
          @adjacencies=adjacencies
        end
        def getAdjacencies()
          @adjacencies
        end
      end
      
      result.setAdjacencies(adjacencies)
      @assets_tmp << result      
    end
    
    
    ###build relationship
    # has_n(:AssociateWith).to(Asset) #associatedBy
    # has_n(:Compose).to(Asset) #Composed by
    # has_n(:Inherit).to(Asset) #Inherited by
    # has_n(:Aggregate).to(Asset) #aggregatedBy
    @assets_tmp.each do |asset|
      asset.getAdjacencies().each do |obj|
        nodeTo = ""
        relationship = ""
        obj.each do |key,value|
          case key
            when "nodeTo"
              nodeTo = value
            when "relationship"
              relationship = value            
          end
        end
        ##add relation
        if(!relationship.end_with?("By"))     
            puts relationship.to_sym
            asset.outgoing(relationship.to_sym) << @assets_tmp[@assets_tmp.index{ |x| x.assetId == nodeTo}]
        end      
      end
      #asset.save
    end
    
    
    puts "===END==="
    respond_to do |format|
      # if @asset_graph.save
        # format.html { redirect_to @asset_graph, notice: 'Asset graph was successfully created.' }
        # format.json { render json: @asset_graph, status: :created, location: @asset_graph }
      # else
        # format.html { render action: "new" }
        # format.json { render json: @asset_graph.errors, status: :unprocessable_entity }
      # end
    end
  end

  # PUT /asset_graphs/1
  # PUT /asset_graphs/1.json
  def update
    @asset_graph = AssetGraph.find(params[:id])

    respond_to do |format|
      if @asset_graph.update_attributes(params[:asset_graph])
        format.html { redirect_to @asset_graph, notice: 'Asset graph was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset_graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asset_graphs/1
  # DELETE /asset_graphs/1.json
  def destroy
    @asset_graph = AssetGraph.find(params[:id])
    @asset_graph.destroy

    respond_to do |format|
      format.html { redirect_to asset_graphs_url }
      format.json { head :no_content }
    end
  end
  
 
end
