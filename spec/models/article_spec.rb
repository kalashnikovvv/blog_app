require "rails_helper"

RSpec.describe Article do
  subject { build(:article) }

  describe "#tags_string" do
    before { subject.tags = ["abc", "def"] }
    it { expect(subject.tags_string).to eq "abc def" }
  end

  describe "#tags_string=" do
    context "when value is blank string" do
      before { subject.tags_string = "" }
      it { expect(subject.tags).to eq [] }
    end

    context "when value with leading spaces" do
      before { subject.tags_string = "   abc def" }
      it { expect(subject.tags).to eq ["abc", "def"] }
    end

    context "when value with middle spaces" do
      before { subject.tags_string = "abc    def" }
      it { expect(subject.tags).to eq ["abc", "def"] }
    end

    context "when value contains duplicates" do
      before { subject.tags_string = "abc def abc" }
      it { expect(subject.tags).to eq ["abc", "def"] }
    end
  end
end
