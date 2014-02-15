class AssetsController < ApplicationController
  def tree
    @assets = Asset.all
    respond_to do |format|
       format.json do
        
        #get all assert relations(source,rel,target)
        links = []
        @rels = Neo4j._query('START root=node(*) MATCH (root)-[r]->(m) WHERE HAS(root._classname) and root._classname="Asset" RETURN id(root) as source, type(r) as rel, id(m) as target')
        @rels.each do |link|
          links << link
        end
        
        #get all links
        nodes = @assets.map{|a| {:name => a.assetName, :id => a.neo_id}}
        
        #update links source and target to right nodes position for D3.js
        # temp = {}
        # nodes.each_with_index do |node,index|
          # #puts node[:id]
          # temp.merge!(node[:id] => index)
        # end
# 
        # links = links.map { |l| {:source => temp[l[:source]], :target => temp[l[:target]] , :rel => l[:rel]}} 
        
        #improve coding style
        #links = links.map {|l| {:source => nodes.find_index{|n| n[:id] == l[:source]}, :target => nodes.find_index{|n| n[:id] == l[:target]} , :rel => l[:rel][7..-1]}}
        
        #Because we ignore the asset model from .to(Asset) to nil, so don't need [7...-1] normailize relation Asset.Compose --> Compose
        links = links.map {|l| {:source => nodes.find_index{|n| n[:id] == l[:source]}, :target => nodes.find_index{|n| n[:id] == l[:target]} , :rel => l[:rel]}}
        
        #render json: @assets
        render :json => {:nodes => nodes, :links => links}
      end 
    end
  end   
  # GET /assets
  # GET /assets.json
  def index
    @assets = Asset.all

    respond_to do |format|
      format.html { render :layout => false}# index.html.erb
      format.json { render json: @assets }
    end
  end

  # GET /assets/1
  # GET /assets/1.json
  def show
    @asset = Asset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/new
  # GET /assets/new.json
  def new
    @asset = Asset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @asset }
    end
  end

  # GET /assets/1/edit
  def edit
    @asset = Asset.find(params[:id])
  end

  # POST /assets
  # POST /assets.json
  def create
    @asset = Asset.new(params[:asset])

    respond_to do |format|
      if @asset.save
        format.html { redirect_to @asset, notice: 'Asset was successfully created.' }
        format.json { render json: @asset, status: :created, location: @asset }
      else
        format.html { render action: "new" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /assets/1
  # PUT /assets/1.json
  def update
    @asset = Asset.find(params[:id])

    respond_to do |format|
      if @asset.update_attributes(params[:asset])
        format.html { redirect_to @asset, notice: 'Asset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @asset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assets/1
  # DELETE /assets/1.json
  def destroy
    @asset = Asset.find(params[:id])
    @asset.destroy

    respond_to do |format|
      format.html { redirect_to assets_url }
      format.json { head :no_content }
    end
  end
end
