require_relative 'EQBranch'
require 'gosu'
class EQAxon < EQBranch

#Constructors
	#@@axons=[]
	attr_accessor :aval, :threshold #compute vals
	#@@totalintegration=0
	def initialize vinput, voutput, aplength, reflength, proplength, threshold=1.0
		super(vinput, voutput, Gosu::Color::RED, aplength, reflength, proplength)

		#@@axons<<self
	#state_variables
		@aval = 0
		@threshold=threshold
	#structural values
	 	@inputs = {}
	 	@outputs = []
	end
	def add_input branch, weight
		@inputs[branch]=weight #this might be faster as some other data structure, but this seems the most compact for now
		branch.add_output self
	end
	# def weight input
	# 	@inputs[input]
	# end
	def set_input_callbacks
		@inputs.keys.each do |input|
			input.set_callbacks({
				:on_release => lambda{integrate_dendrite @inputs[input]}, #this value is captured?
				:on_refractory => lambda{deintegrate_dendrite @inputs[input]}
			})
		end
	end
	def add_output neuron
		@outputs<<neuron
		self
	end
	def outputs #in case of closure, break glass here
		@outputs
	end
	def inputs
		@inputs
	end
	def integrate_dendrite weight 
		if (@aval+=weight) > @threshold
			#@@totalintegration -= @aval-weight
			self.fire
		end
	end
	def deintegrate_dendrite weight
		@aval-=weight
	end
	def check_state_and_fire
		if @aval>@threshold
			self.fire
		end
	end
end