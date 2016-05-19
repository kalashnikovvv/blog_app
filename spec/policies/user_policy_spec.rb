require "rails_helper"

RSpec.describe UserPolicy do
  subject { described_class }

  permissions :new?, :create? do
    context "for a visitor" do
      let(:current_user) { nil }
      it { is_expected.to permit(current_user) }
    end

    context "for a user" do
      let(:current_user) { create(:user) }
      it { is_expected.not_to permit(current_user) }
    end
  end

  permissions :update?, :edit?, :destroy? do
    let(:user) { create(:user) }

    context "for a visitor" do
      let(:current_user) { nil }
      it { is_expected.not_to permit(current_user, user) }
    end

    context "for a user" do
      context "when user is not current" do
        let(:current_user) { create(:user) }
        it { is_expected.not_to permit(current_user, user) }
      end

      context "when user is current" do
        let(:current_user) { user }
        it { is_expected.to permit(current_user, user) }
      end
    end
  end
end
