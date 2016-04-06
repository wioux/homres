
require 'network'

RSpec.describe Network do
  let(:network){ Network.new }

  describe "#time" do
    pending "should initially be 0.0"
  end

  describe "#tick" do
    pending "should cycle the simulation by one event"
  end

  describe "#create(u, v)" do
    it "should insert a branch from u to v" do
      u, v = Vector[0, 0, 0], Vector[10, 0, 0]
      branch = network.create(u, v)

      expect(network.branches).to include(branch)
      expect([branch.u, branch.v]).to eq([u, v])
      expect(branch.t0).to eq(network.time)
    end
  end
end
