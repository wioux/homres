require_relative "../src/EQBranch"
require_relative "../src/Vector"
require_relative "../src/EventQueue"

require 'csv'

EQBranch.setepsilons
EQBranch.setconstants
EQBranch.seteventqueue EventQueue.new

branch = EQBranch.new Vector.new(0,0), Vector.new(1,1)
branch.setproc


frames=10
frames.times do |x|
  testtime=[]
  testthresh=[]
  testmp=[]
  branch.settime 0
  branch.setthresh 1
  branch.setmp (x-10.0)/2
  100.times do |t|
    branch.incr(0.05)
    testtime<<(t/20.0)
    testthresh<<branch.thresh
    testmp<<branch.mp
  end
end
