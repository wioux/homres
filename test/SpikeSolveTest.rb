require_relative "../src/EQBranch"
require_relative "../src/Vector"
require_relative "../src/EventQueue"

eq=EventQueue.new

EQBranch.setepsilons
EQBranch.setconstants
EQBranch.seteventqueue eq

branch = EQBranch.new Vector.new(0,0), Vector.new(1,1)

#phase diagram domain 
#frequency
#weight
######
#potential other dimensions
#threshold reset value
#mp reset value
#thresholddecay/mpdecay
#the addition of an epsilon
data=""
testruntimeconstant=5.0
(-50).upto(50) do |i|
	#puts "weight: "+(i/50.0).to_s
	(1).upto(100) do |j|
		#puts "time: "+(testruntimeconstant/j).to_s
		eq.cancelall
		t=0.0
		#obviously better numerical methods here would give a much better line
		dt=testruntimeconstant/j
		weight=i/50.0
		branch.addweight weight,t
		eq.pop
		while t_=eq.nexteventtime and t_>t+dt
			puts eq.nexteventtime
			t+=dt
			branch.addweight weight,t
			eq.pop
		end
		data+=i.to_s+" "+j.to_s+" "+eq.nexteventtime.to_s+"\n"
	end
end

output = File.open( "../data/phase.dat","w" )
output<<data
output.close
