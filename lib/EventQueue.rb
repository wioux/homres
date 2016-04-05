require 'priority_queue'
class EventQueue
	attr_accessor :current
	def initialize
		@current=0.0
		@events=PriorityQueue.new
	end
	def pop
		if @events.min
			@current+=@events.min[1]
			@events.delete_min[0].call
		end
	end
	def cancel event
		@events.delete(event)
	end
	def insert event, time
		@events.push event, time
	end
	
	#debug

	def nexteventtime
		if @events.min
			return @events.min[1]
		else 
			return false
		end
	end
	def cancelall
		@current=0.0
		@events=PriorityQueue.new
	end
end

#### Docs

# q = PriorityQueue.new
# q.push "node1", 0 
# q.push "node2", 1

# q.min #=> "node1"

# q.decrease_priority("node2", -1)

# q.pop_min #=> "node2"
# q.min     #=> "node1"