require "rails_helper"

RSpec.describe UserSessionsController do
  let!(:user) { create(:user, username: "user", password: "testpass") }
  let(:valid_attributes) { { email: "user", password: "testpass" } }
  let(:invalid_attributes) { { email: "user", password: "invalidpass" } }

  describe "GET #new" do
    before { get :new }

    it { expect(response).to be_success }
  end

  describe "POST #create" do
    before { post :create, user_session_form: attributes }

    context "when valid data" do
      let(:attributes) { valid_attributes }

      it { expect(response).to redirect_to root_path }
      it { expect(controller.current_user).not_to be_nil }
    end

    context "when invalid data" do
      let(:attributes) { invalid_attributes }

      it { expect(response).to render_template(:new) }
    end
  end

  describe "DELETE #destroy" do
    before { delete :destroy }

    it { expect(response).to redirect_to login_path }
    it { expect(controller.current_user).to be_nil }
  end
end
