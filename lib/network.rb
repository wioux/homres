
require 'branch'

class Network
  attr_reader :time
  attr_accessor :branches

  def initialize
    @time = 0.0
    @branches = []
  end

  def tick(dt)
    branches.each{ |x| x.incr(dt) }
    @time += dt
  end

  def create(u, v)
    Branch.new(time, u, v).tap{ |branch| branches << branch }
  end
end
