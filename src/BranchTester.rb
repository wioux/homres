require_relative 'EQBranch'

class Tester
	def initialize
		EQBranch.setconstants
		EQBranch.setepsilons
		events=EventQueue.new
		EQBranch.seteventqueue events
	end
	
end