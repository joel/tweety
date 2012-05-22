# encoding: utf-8
require 'spec_helper'

describe User do
  subject { FactoryGirl.build(:user) }
  
  context "validation" do
    it { should be_valid }
  end
  
  context "relationships" do
    let(:followed) { FactoryGirl.create(:user) }
    before { subject.save! }

    context "with followers", pending: true do
      before { subject.follow!(followed.id) }
      
      it "follow another user" do
        subject.following.should include followed
      end
      
      it "include the follower in the followers array" do
        followed.followers.include?(subject).should be_true
      end
      
      describe "unfollow another user" do
        before { subject.unfollow!(followed.id) }
        
        it { subject.following.select(:follower_id).map(&:to_s).should_not include followed.id }
      end
    end
  end
  
end