require 'spec_helper'

require 'Branch'

RSpec.describe Branch do
  describe "#prop_time" do
    pending "it should be roughly equal to ||u-v||"
  end

  describe "#fire" do
    pending "it should add weight to connected branches"

    pending "it should decrease the branch's own membrane potential"

    pending "it should reset the threshold potential"
  end

  describe "#update(t)" do
    pending "should set membrane/threshold potential to the decayed values at time t"
  end

  describe "#add(weight)" do
    pending "it should increase membrane potential"

    pending "it should #fire if membrane potential gets high enough"

    pending "it should #fire if membrane potential gets low enough"
  end
end
