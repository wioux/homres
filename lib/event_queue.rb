
require 'priority_queue'

class EventQueue
  attr_accessor :time

  def initialize
    @time = 0.0
    @events=PriorityQueue.new
  end

  def pop
    if @events.min
      @time += @events.min[1]
      @events.delete_min[0]
    end
  end

  def cancel(action)
    @events.delete(action)
  end

  def at(time, &action)
    @events.push(action, time)
    action
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
