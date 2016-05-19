require "rails_helper"

RSpec.describe CommentsController do
  let(:article) { create(:article) }
  let(:user) { create(:user) }
  let(:comment) { create(:comment, article: article) }
  let(:valid_attributes) { { text: "Text" } }
  let(:invalid_attributes) { { text: "" } }

  before do
    login_user user
    stub_authorize
  end

  describe "GET #new" do
    before { get :new, article_id: article.id }

    it { expect(response).to be_success }
  end

  describe "GET #edit" do
    before { get :edit, id: comment.id, article_id: article.id }

    it { expect(response).to be_success }
  end

  describe "POST #create" do
    before { post :create, article_id: article.id, comment: attributes }

    context "when valid data" do
      let(:attributes) { valid_attributes }

      it { expect(response).to be_success }
      it { expect(Comment.count).to eq(1) }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:new) }
      it { expect(Comment.count).to eq(0) }
    end
  end

  describe "PUT #update" do
    before { put :update, id: comment.id, article_id: article.id, comment: attributes }

    context "when valid data" do
      let(:attributes) { valid_attributes }

      it { expect(response).to be_success }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:edit) }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy, id: comment.id, article_id: article.id }

    it { expect(response).to be_success }
    it { expect(Comment.count).to eq(0) }
  end
end
