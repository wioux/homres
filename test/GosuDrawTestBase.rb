require 'gosu'
#require_relative '../src/EQDendrite'
#require_relative 'EQAxon'
#require_relative 'EQBranch'
class TestWindow < Gosu::Window
	def initialize
		#dendrite = EQDendrite.new
		super(1000,700)
		self.caption = 'test'
	end
	def update
	end
	def draw
		draw_line(1,1,Gosu::Color::RED,100,100,Gosu::Color::GREEN)
	end
end
window = TestWindow.new
window.show