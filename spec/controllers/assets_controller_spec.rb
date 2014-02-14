require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe AssetsController do

  # This should return the minimal set of attributes required to create a valid
  # Asset. As you add validations to Asset, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "assetName" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AssetsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all assets as @assets" do
      asset = Asset.create! valid_attributes
      get :index, {}, valid_session
      assigns(:assets).should eq([asset])
    end
  end

  describe "GET show" do
    it "assigns the requested asset as @asset" do
      asset = Asset.create! valid_attributes
      get :show, {:id => asset.to_param}, valid_session
      assigns(:asset).should eq(asset)
    end
  end

  describe "GET new" do
    it "assigns a new asset as @asset" do
      get :new, {}, valid_session
      assigns(:asset).should be_a_new(Asset)
    end
  end

  describe "GET edit" do
    it "assigns the requested asset as @asset" do
      asset = Asset.create! valid_attributes
      get :edit, {:id => asset.to_param}, valid_session
      assigns(:asset).should eq(asset)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Asset" do
        expect {
          post :create, {:asset => valid_attributes}, valid_session
        }.to change(Asset, :count).by(1)
      end

      it "assigns a newly created asset as @asset" do
        post :create, {:asset => valid_attributes}, valid_session
        assigns(:asset).should be_a(Asset)
        assigns(:asset).should be_persisted
      end

      it "redirects to the created asset" do
        post :create, {:asset => valid_attributes}, valid_session
        response.should redirect_to(Asset.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved asset as @asset" do
        # Trigger the behavior that occurs when invalid params are submitted
        Asset.any_instance.stub(:save).and_return(false)
        post :create, {:asset => { "assetName" => "invalid value" }}, valid_session
        assigns(:asset).should be_a_new(Asset)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Asset.any_instance.stub(:save).and_return(false)
        post :create, {:asset => { "assetName" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested asset" do
        asset = Asset.create! valid_attributes
        # Assuming there are no other assets in the database, this
        # specifies that the Asset created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Asset.any_instance.should_receive(:update_attributes).with({ "assetName" => "MyString" })
        put :update, {:id => asset.to_param, :asset => { "assetName" => "MyString" }}, valid_session
      end

      it "assigns the requested asset as @asset" do
        asset = Asset.create! valid_attributes
        put :update, {:id => asset.to_param, :asset => valid_attributes}, valid_session
        assigns(:asset).should eq(asset)
      end

      it "redirects to the asset" do
        asset = Asset.create! valid_attributes
        put :update, {:id => asset.to_param, :asset => valid_attributes}, valid_session
        response.should redirect_to(asset)
      end
    end

    describe "with invalid params" do
      it "assigns the asset as @asset" do
        asset = Asset.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Asset.any_instance.stub(:save).and_return(false)
        put :update, {:id => asset.to_param, :asset => { "assetName" => "invalid value" }}, valid_session
        assigns(:asset).should eq(asset)
      end

      it "re-renders the 'edit' template" do
        asset = Asset.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Asset.any_instance.stub(:save).and_return(false)
        put :update, {:id => asset.to_param, :asset => { "assetName" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested asset" do
      asset = Asset.create! valid_attributes
      expect {
        delete :destroy, {:id => asset.to_param}, valid_session
      }.to change(Asset, :count).by(-1)
    end

    it "redirects to the assets list" do
      asset = Asset.create! valid_attributes
      delete :destroy, {:id => asset.to_param}, valid_session
      response.should redirect_to(assets_url)
    end
  end

end
