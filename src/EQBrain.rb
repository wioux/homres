require_relative 'Event'
require_relative 'EventQueue'
require_relative 'EQAxon'
require_relative 'EQDendrite'
require_relative 'Vector'
require 'distribution'
class EQBrain
	## This class is responsible for filling the EQBranch data structures, and performing the global functions of 
	## the brain (like switching between asleep and awake), everything else is implemented locally/

	def initialize xsize,ysize,count
		#First order variables
		@xsize=xsize
		@ysize=ysize
		@count=count
		#Axon stuff
		
		setup

	end

	def set_distributions #really we are making random variables
		norm = Distribution::Normal.rng
		pois = ->(){
			1.0
		}

		@d_axon_length = lambda{norm.call*5+30}
		@d_threshold = lambda{norm.call**2}
		@d_arbors_per_axon = lambda{rand+10}
		@d_branch_uncertainty = lambda{norm.call*10}
		@d_axon_dendrite_length_ratio = lambda{pois.call*0.2}
		@d_weight_dist = norm
		@d_branch_probability = lambda{|x|pois.call*0.1<1/(x+1)}
		@d_dendrite_type = lambda{rand(4)+1}
	end
	def setup
		set_distributions


		make_axons
		make_dendrites
		#make_astroglial_mesh 
		make_connections
	end
	def make_axons
		@instance_params=Array.new(@count).map do
			start=Vector.rand_vector(@xsize,@ysize)#can be set to a random length
			[start,start+Vector.rand_angle(@d_axon_length.call),@d_threshold.call]
		end
		@axons = @instance_params.map! do |instance|
			EQAxon.new(
				instance[0],
				instance[1],
				1.0,
				1.0,
				(instance[1]-instance[0]).length,
				instance[2]
			)
		end
	end
	def make_dendrites 
		#possible that this is considered a job of the axons themselves, would need to compare memory usage.
		#randomness is important here
		#all connections currently implemented in 2 dimensions, obviously this fails to be representative in qualitative ways.
		@axons.each do |axon|
			#get base direction for all arbors = axon direction
			base_dir=(axon.vinput-axon.voutput)
			(@d_arbors_per_axon.call).to_i.times do
				#get new direction for each dendrite from base direction
				#puts base_dir
				#puts (Vector.rand_angle(@d_branch_uncertainty.call))
				dendrite_dir = (base_dir + (Vector.rand_angle(@d_branch_uncertainty.call)))*@d_axon_dendrite_length_ratio.call
				#these distributions need to be done better.
				dendrite=EQDendrite.new(
						axon.vinput+dendrite_dir,
						axon.vinput,
						1.0,
						1.0,
						dendrite_dir.length
					)
				branch dendrite,0
				axon.add_input(dendrite,@d_weight_dist.call)
				
			end
		end
	end
	def make_connections
		
	end
	
	def branch parent, depth
		if @d_branch_probability.call depth
			parent.set_type(@d_dendrite_type.call)
			base_dendrite_dir = parent.vinput-parent.voutput
			#Vector::rand_angle will eventually take a distribution 
			left_dendrite_dir = base_dendrite_dir + Vector.rand_angle(@d_branch_uncertainty.call) 
			right_dendrite_dir = base_dendrite_dir + Vector.rand_angle(@d_branch_uncertainty.call)
			

			parent.left_input = EQDendrite.new(
				parent.vinput+left_dendrite_dir,
				parent.vinput,
				1.0,
				1.0,
				left_dendrite_dir.length)
			branch(parent.left_input,depth+1)
			parent.right_input = EQDendrite.new(parent.vinput+right_dendrite_dir,
				parent.vinput,
				1.0,
				1.0,
				right_dendrite_dir.length)
			branch(parent.right_input,depth+1)
		else
			parent.set_type(0)
		end
	end
	def stimulate n
		@axons[n].fire
	end
end














