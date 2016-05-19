require "rails_helper"

RSpec.describe ArticlesController do
  let(:user) { create(:user) }
  let(:article) { create(:article, user: user) }
  let(:valid_attributes) { { title: "Title", text: "Text", publish_date: Date.today } }
  let(:invalid_attributes) { { title: "" } }

  before do
    login_user user
    stub_authorize
  end

  describe "GET #index" do
    context "when user is current" do
      before { get :index, user_id: user.id }

      it { expect(response).to be_success }
    end

    context "when user is not current" do
      let(:other_user) { create(:user) }
      before { get :index, user_id: other_user.id }

      it { expect(response).to be_success }
    end
  end

  describe "GET #show" do
    before { get :show, id: article.id }

    it { expect(response).to be_success }
  end

  describe "GET #new" do
    before { get :new }

    it { expect(response).to be_success }
  end

  describe "GET #edit" do
    before { get :edit, id: article.id }

    it { expect(response).to be_success }
  end

  describe "POST #create" do
    before { post :create, article: attributes }

    context "when valid data" do
      let(:attributes) { valid_attributes }

      it { expect(response).to redirect_to article_path(assigns(:article)) }
      it { expect(Article.count).to eq(1) }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:new) }
      it { expect(Article.count).to eq(0) }
    end
  end

  describe "PUT #update" do
    before { put :update, id: article.id, article: attributes }

    context "when valid data" do
      let(:attributes) { valid_attributes }

      it { expect(response).to redirect_to article_path(article) }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:edit) }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, id: article.id }

    it { expect(response).to redirect_to root_path }
    it { expect(Article.count).to eq(0) }
  end
end
