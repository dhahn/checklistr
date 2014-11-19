require "rails_helper"

RSpec.describe ItemsController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the posts into @posts" do
      item1, item2 = Item.create(name: "t"), Item.create(name: "t2")
      get :index

      expect(assigns(:items)).to match_array([item1, item2])
    end
  end

  describe "POST #create" do
    describe "with valid attributes" do
      it "saves the new item in the database" do
        expect {
          post :create, item: { name: "t" }
        }.to change(Item, :count).by(1)
      end

      it "redirects to the index action" do
        post :create, item: { name: 't' }
        expect(response).to redirect_to items_path
      end
    end

    describe "with invalid attributes" do
      it "does not save the new item in the database" do
        expect {
          post :create, item: { name: nil }
        }.to_not change(Item, :count)
      end

      it "renders the :index template" do
        post :create, item: { name: nil }
        expect(response).to render_template :index
      end
    end
  end

  describe "PUT #update" do
    let(:item) { Item.create(name: "t") }

    describe "with valid attributes" do
      before { put :update, id: item.id, item: { name: "f" } }

      it "finds the requested @item" do
        expect(assigns(:item)).to eq(item)
      end

      it "changes @item's attributes" do
        expect(assigns(:item).name).to eq("f")
      end

      it "redirects to the index action" do
        expect(response).to redirect_to items_path
      end
    end

    describe "with invalid attributes" do 
      before { put :update, id: item.id, item: { name: nil } }

      it "finds the requested @item" do
        expect(assigns(:item)).to eq(item)
      end

      it "does not change @item's attributes" do
        expect(assigns(:item)).to eq(item)
      end

      it "redirects to the index action" do
        expect(response).to render_template :index
      end
    end
  end

  describe "DELETE #destroy" do
    let(:item) { Item.create(name: "t") }
    before { item }

    it "deletes the item" do
      expect{ 
        delete :destroy, id: item
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the index page" do
      delete :destroy, id: item
      expect(response).to redirect_to items_path
    end
  end
end