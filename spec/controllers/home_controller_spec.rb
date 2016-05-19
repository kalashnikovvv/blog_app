require "rails_helper"

RSpec.describe HomeController do
  describe "GET #index" do
    before { get :index }

    it { expect(response).to be_success }
  end
end
