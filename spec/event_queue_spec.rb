
require 'spec_helper'

require 'event_queue'

RSpec.describe EventQueue do
  let(:queue){ EventQueue.new }

  describe "#time" do
    it "should start at 0.0" do
      expect(queue.time).to eq(0.0)
    end

    it "should increase by a pop'd event's time" do
      queue.insert(double(call: nil), 10)
      queue.insert(double(call: nil), 20)

      queue.pop.inspect
      expect(queue.time).to eq(10.0)

      queue.pop
      expect(queue.time).to eq(30.0)
    end
  end

  describe "#pop" do
    it "should dequeue the next event and .call it" do
      event1, event2 = double, double

      expect(event1).to receive(:call).ordered
      expect(event2).to receive(:call).ordered

      queue.insert(event2, 20)
      queue.insert(event1, 10)

      2.times{ queue.pop }
    end
  end

  describe "#cancelall" do
    it "should clear the event queue" do
      queue.insert(double, 10)
      queue.cancelall

      expect(queue.pop).to be_nil
    end

    it "should reset #time" do
      queue.insert(double(call: nil), 10)
      queue.pop

      expect(queue.time).not_to eq(0.0)

      queue.cancelall
      expect(queue.time).to eq(0.0)
    end
  end
end
