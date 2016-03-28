class Vector
	include Comparable
	attr_accessor :x,:y,:z
	def initialize x=0,y=0,z=0
		@x=x
		@y=y
		@z=z
	end
	def + v
		Vector.new x+v.x, y+v.y, z+v.z
	end
	def - v
		Vector.new x-v.x, y-v.y, z-v.z
	end
	def * a
		Vector.new x*a, y*a, z*a
	end
	def draw_to v,color
		[x,y,color,v.x,v.y,color]
	end
	def self.rand_angle length
		angle = Math::PI*rand*2
		#normal(0,1) for each 
		#theta = Math::PI*rand*2
		#phi = 
		Vector.new(length*Math.cos(angle),length*Math.sin(angle))
	end	
	def self.rand_vector xmax=0, ymax=0, zmax=0 ,xmin=0, ymin=0 ,zmin=0
		Vector.new(rand(xmin..xmax),rand(ymin..ymax),rand(zmin..zmax))
	end
	def length_squared
		x**2+y**2+z**2
	end
	def length
		Math.sqrt(length_squared)
	end
	def normalize
		self*1.0/length
	end
	def <=> v
		length_squared <=> v.length_squared
	end
end

