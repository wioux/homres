
require 'spec_helper'

require 'event_queue'

RSpec.describe EventQueue do
  let(:queue){ EventQueue.new }

  describe "#time" do
    it "should start at 0.0" do
      expect(queue.time).to eq(0.0)
    end

    it "should increase by a pop'd event's time" do
      queue.at(10){ }
      queue.at(20){ }

      queue.pop
      expect(queue.time).to eq(10.0)

      queue.pop
      expect(queue.time).to eq(30.0)
    end
  end

  describe "#at and #pop" do
    it "should enqueue and dequeue the next event" do
      event1, event2 = double, double

      queue.at(20){ event2 }
      queue.at(10){ event1 }

      expect(queue.pop.call).to eq(event1)
      expect(queue.pop.call).to eq(event2)
    end
  end
end
