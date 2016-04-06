
require 'branch'

class Network
  attr_reader :event_queue
  attr_accessor :branches

  def initialize
    @branches = []
    @event_queue = EventQueue.new
    @fire_event = {}
  end

  def tick
    event = event_queue.pop
    event.call
  end

  def create(u, v)
    Branch.new(event_queue.time, u, v).tap do |branch|
      branches << branch
      enqueue_fire_event(branch)
    end
  end

  def fire_branch(branch)
    branch.update(event_queue.time)

    branch.outputs.each do |output_branch, weight|
      event_queue.at(event_queue.time + branch.prop_time) do
        output_branch.update(event_queue.time)
        output_branch.add(weight)
        enqueue_fire_event(branch)
      end
    end

    branch.fire
  end

  def enqueue_fire_event(branch)
    @fire_event.delete(branch).tap do |event|
      event && event_queue.cancel(event)
    end

    if time_to_fire = branch.solvespike
      time_to_fire += event_queue.time
      @fire_event[branch] = event_queue.at(time_to_fire){ fire_branch(branch) }
    end
  end
end
