require "rails_helper"

RSpec.describe UsersController do
  let(:user) { create(:user) }
  let(:valid_attributes) { { username: "user", email: "user@test.com" } }
  let(:invalid_attributes) { { username: "" } }

  before do
    stub_authorize
  end

  describe "GET #new" do
    before { get :new }

    it { expect(response).to be_success }
  end

  describe "GET #edit" do
    before { get :edit, id: user.id }

    it { expect(response).to be_success }
  end

  describe "POST #create" do
    before { post :create, user: attributes }

    context "when valid data" do
      let(:attributes) { valid_attributes.merge(password: "testpass", password_confirmation: "testpass") }

      it { expect(response).to redirect_to root_path }
      it { expect(User.count).to eq(1) }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:new) }
      it { expect(User.count).to eq(0) }
    end
  end

  describe "PUT #update" do
    before do
      login_user user
      put :update, id: user.id, user: attributes
    end

    context "when valid data" do
      let(:attributes) { valid_attributes }

      it { expect(response).to redirect_to edit_user_path(user) }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:edit) }
    end
  end
end
