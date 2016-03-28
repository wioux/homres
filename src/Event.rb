class Event
	attr_accessor :time
	def initialize actions, timetaken, eventqueue
		@time=timetaken+eventqueue.current
		@actions=actions
	end
	def perform
		@actions.keys.each do |key|
			key.call(*(@actions[key]))
		end
	end
end