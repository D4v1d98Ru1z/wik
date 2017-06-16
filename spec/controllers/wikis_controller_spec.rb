require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { User.create!(email:"user@user.com", password:"password") }
  let(:my_wiki) { Wiki.create!(title: "title", body: "body", private: false, user: my_user) }

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_wiki to @wiki" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #show" do
    before do
      sign_in :my_user
    end

    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end

    it "assigns my_wiki to a @wiki" do
      get :show, {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #new" do
    before do
      sign_in :my_user
    end

    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiates a @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST #create" do
    before do
      sign_in :my_user
    end

    it "increases the number of Wikis by 1" do
      expect {post :create, wiki: {title:"title", body: "body", user: my_user}}.to change(Wiki,:count).by(1)
    end

    it "assigngs the new wiki to a @wiki" do
      post :create, wiki: {title:"title", body: "body", user: my_user }
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new wiki" do
      post :create, wiki: {title:"title", body: "body", user: my_user }
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET #edit" do
    before do
      sign_in :my_user
    end

    it "returns http success" do
      get :edit, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, {id: my_wiki.id}
      expect(response).to render_template :edit
    end

    it "assigns wiki to be updated to @wiki" do
      get :edit, {id: my_wiki.id}
      wiki_instance = assigns(:wiki)
      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
    end
  end

  describe "PUT #update" do
    before do
      sign_in :my_user
    end

    it "updates the wiki with expected attributes" do
      new_title = "New Title"
      new_body = "New Body"

      put :update, id: my_wiki.id, wiki:{title: new_title, body: new_body, user: my_user}

      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
    end

    it "redirects to the updated wiki" do
      new_title = "New Title"
      new_body = "New Body"

      put :update, id: my_wiki.id, wiki:{title: new_title, body: new_body, user: my_user}

      expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE #destroy" do
    before do
      sign_in :my_user
    end

    it "deletes the wiki" do
      delete :destroy, {id: my_wiki.id}
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to the wiki index view" do
      delete :destroy, {id: my_wiki.id}
      expect(response).to redirect_to wikis_path
    end
  end

end
