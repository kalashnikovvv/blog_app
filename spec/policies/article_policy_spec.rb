require "rails_helper"

RSpec.describe ArticlePolicy do
  subject { described_class }

  permissions :new?, :create? do
    context "for a visitor" do
      let(:current_user) { nil }
      it { is_expected.not_to permit(current_user) }
    end

    context "for a user" do
      let(:current_user) { create(:user) }
      it { is_expected.to permit(current_user) }
    end
  end

  permissions :update?, :edit?, :destroy? do
    let(:user) { create(:user) }
    let(:article) { create(:article, user: user) }

    context "for a visitor" do
      let(:current_user) { nil }
      it { is_expected.not_to permit(current_user, article) }
    end

    context "for a user" do
      context "when article does not belongs to user" do
        let(:current_user) { create(:user) }
        it { is_expected.not_to permit(current_user, article) }
      end

      context "when article belongs to user" do
        let(:current_user) { user }
        it { is_expected.to permit(current_user, article) }
      end
    end
  end
end
