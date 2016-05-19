require "rails_helper"

RSpec.describe CommentPolicy do
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
    let(:comment) { create(:comment, user: user, created_at: time) }

    context "for a visitor" do
      let(:current_user) { nil }

      context "when comment under 15 minites" do
        let(:time) { 10.minutes.ago }
        it { is_expected.not_to permit(current_user, comment) }
      end

      context "when comment over 15 minites" do
        let(:time) { 20.minutes.ago }
        it { is_expected.not_to permit(current_user, comment) }
      end
    end

    context "for a user" do
      context "when user is not current" do
        let(:current_user) { create(:user) }

        context "when comment under 15 minites" do
          let(:time) { 10.minutes.ago }
          it { is_expected.not_to permit(current_user, comment) }
        end

        context "when comment over 15 minites" do
          let(:time) { 20.minutes.ago }
          it { is_expected.not_to permit(current_user, comment) }
        end
      end

      context "when user is current" do
        let(:current_user) { user }

        context "when comment under 15 minites" do
          let(:time) { 10.minutes.ago }
          it { is_expected.to permit(current_user, comment) }
        end

        context "when comment over 15 minites" do
          let(:time) { 20.minutes.ago }
          it { is_expected.not_to permit(current_user, comment) }
        end
      end
    end
  end
end
