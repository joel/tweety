require 'spec_helper'

describe Relationship do
  let(:follower) { FactoryGirl.create(:user) }
  let(:followed) { FactoryGirl.create(:user) }
  
  describe "relationships" do
    subject { follower.relationships.build(:followed_id => followed.id) }

    it "should create a new instance given valid attributes" do
      expect { follower.save! }.to_not raise_error
    end
  end

  context "validations" do
    subject { FactoryGirl.build(:relationship) }

    describe "relationships without follower" do
      before { subject.follower_id = nil }
      it { should_not be_valid }
    end
    describe "relationships without followed" do
      before { subject.followed_id = nil }
      it { should_not be_valid }
    end
  end
end
