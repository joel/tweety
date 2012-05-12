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

    context "with followers" do
      before { subject.follow!(followed) }
      
      it "follow another user" do
        subject.following.include?(followed).should be_true
      end
      
      it "include the follower in the followers array" do
        followed.followers.include?(subject).should be_true
      end
      
      describe "unfollow another user" do
        before { subject.unfollow!(followed) }
        it { subject.following.include?(followed).should be_false }
      end
    end
  end
  
end