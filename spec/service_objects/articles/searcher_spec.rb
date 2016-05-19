require "rails_helper"

RSpec.describe Articles::Searcher do
  describe "#call" do
    let(:user1) { create(:user) }
    let(:user2) { create(:user) }
    let(:article1) { create(:article, user: user2, visible: true, tags: ["a", "b", "c"]) }
    let(:article2) { create(:article, user: user1, visible: false, tags: ["a", "c"]) }
    let(:article3) { create(:article, user: user2, visible: true, tags: ["a"]) }
    let(:article4) { create(:article, user: user1, visible: false, tags: ["b", "c"]) }

    subject { described_class.new(options).call }

    context "with empty options" do
      let(:options) { {} }

      it "returns all records" do
        is_expected.to match_array([article1, article2, article3, article4])
      end
    end

    context "with option 'only_visible' equal false" do
      let(:options) { { only_visible: false } }

      it "returns all records" do
        is_expected.to match_array([article1, article2, article3, article4])
      end
    end

    context "with option 'only_visible' equal true" do
      let(:options) { { only_visible: true } }

      it "returns only visible records" do
        is_expected.to match_array([article1, article3])
      end
    end

    context "with option 'user_id'" do
      let(:options) { { user_id: user1.id } }

      it "returns only user records" do
        is_expected.to match_array([article2, article4])
      end
    end

    context "with option 'tags'" do
      let(:options) { { tags: ["a"] } }
      it "returns only records with tag" do
        is_expected.to match_array([article1, article2, article3])
      end
    end
  end
end
