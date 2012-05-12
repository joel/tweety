# encoding: utf-8
require 'spec_helper'

describe User do

  subject { Factory.build(:user) }
  
  describe "validation" do
    it { should be_valid }
  end
end