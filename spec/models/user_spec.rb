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

    context "must be asymetric" do
      before { subject.follow!(followed.id) }
    
      context "when follow an another person" do  
        it "should follow the followed person" do
          should have(1).following
        end
      
        it "should not have a reverse relation" do 
          should_not have(1).follower
        end
      end
    
      context "when unfollow an another person" do  
        before { subject.unfollow!(followed.id) }
        
        it "should not follow the followed person" do
          should_not have(1).following
        end
      
        it "should not have a reverse relation" do 
          should_not have(1).follower
        end
      end
    end    
  end
end