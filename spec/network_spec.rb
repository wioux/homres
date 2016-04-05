
require 'network'

RSpec.describe Network do
  let(:network){ Network.new }

  describe "#time" do
    pending "should initially be 0.0"
  end

  describe "#tick(dt)" do
    it "should update all branches by dt" do
      network.branches = [double, double]

      network.branches.each{ |x| expect(x).to receive(:incr).with(10.0) }
      network.tick(10.0)

      network.branches.each{ |x| expect(x).to receive(:incr).with(20.0) }
      network.tick(20.0)
    end

    pending "should increment #time by dt"
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
