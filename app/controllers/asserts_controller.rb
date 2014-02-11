class AssertsController < ApplicationController
  
  def tree
    @asserts = Assert.all
    respond_to do |format|
       format.json do
        
        #get all assert relations(source,rel,target)
        links = []
        @rels = Neo4j._query('START root=node(*) MATCH (root)-[r]->(m) WHERE HAS(root._classname) and root._classname="Assert" RETURN id(root) as source, type(r) as rel, id(m) as target')
        @rels.each do |link|
          links << link
        end
        
        #get all links
        nodes = @asserts.map{|a| {:name => a.assertName, :id => a.neo_id}}
        
        #update links source and target to right nodes position for D3.js
        # temp = {}
        # nodes.each_with_index do |node,index|
          # #puts node[:id]
          # temp.merge!(node[:id] => index)
        # end
# 
        # links = links.map { |l| {:source => temp[l[:source]], :target => temp[l[:target]] , :rel => l[:rel]}} 
        
        links = links.map {|l| {:source => nodes.find_index{|n| n[:id] == l[:source]}, :target => nodes.find_index{|n| n[:id] == l[:target]} , :rel => l[:rel][7..-1]}}
        
        #render json: @asserts
        render :json => {:nodes => nodes, :links => links}
      end 
    end
  end 
  # GET /asserts
  # GET /asserts.json
  def index
    @asserts = Assert.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @asserts }
     
    end
  end
  
  # GET /asserts/1
  # GET /asserts/1.json
  def show
    @assert = Assert.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @assert }
    end
  end

  # GET /asserts/new
  # GET /asserts/new.json
  def new
    @assert = Assert.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @assert }
    end
  end

  # GET /asserts/1/edit
  def edit
    @assert = Assert.find(params[:id])
  end

  # POST /asserts
  # POST /asserts.json
  def create
    puts "My assert Attributes: #{params[:assert]}"
    @assert = Assert.new(params[:assert])

    respond_to do |format|
      if @assert.save
        format.html { redirect_to @assert, notice: 'Assert was successfully created.' }
        format.json { render json: @assert, status: :created, location: @assert }
      else
        format.html { render action: "new" }
        format.json { render json: @assert.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /asserts/1
  # PUT /asserts/1.json
  def update
    @assert = Assert.find(params[:id])

    respond_to do |format|
      if @assert.update_attributes(params[:assert])
        format.html { redirect_to @assert, notice: 'Assert was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @assert.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /asserts/1
  # DELETE /asserts/1.json
  def destroy
    @assert = Assert.find(params[:id])
    @assert.destroy

    respond_to do |format|
      format.html { redirect_to asserts_url }
      format.json { head :no_content }
    end
  end
end
