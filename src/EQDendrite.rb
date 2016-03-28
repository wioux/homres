require_relative 'EQBranch'
require 'gosu'
class EQDendrite < EQBranch

#Constructors

	TYPECOLORS=[Gosu::Color::BLUE,Gosu::Color::CYAN,Gosu::Color::CYAN,Gosu::Color::GREEN,Gosu::Color::YELLOW]
	attr_accessor :lval,:rval,:aval
	attr_accessor :left_input, :right_input
	#@@totalintegration=0
	def initialize vinput, voutput, aplength, reflength, proplength, type=0
		super(vinput, voutput, Gosu::Color::BLUE, aplength, reflength, proplength)
		#@@dendrites<<self
	#state_variables
		lval = false
		rval = false
		aval = false
	#structural values
		set_type type
		#type -
		#0 only one input
		#1 Left and Not Right
		#2 Right and Not Left
		#3 Left or Right
		#4 Left and Right
	 	@outputs = []
	end
	def set_type type
		@type = type
		color = TYPECOLORS[type]
	end
	def add_left_input branch
		@left_input=branch
		branch.outputs<<self
	end
	def add_right_input branch
		@right_input=branch
		branch.outputs<<self
	end
	def check_state_and_fire
		if aval
			self.fire
		end
	end
	#do we fire again after refractory?
	def set_input_callbacks #super long method 
		#does everything need a self. prefix?
		if type==0
			@input.set_callbacks({
				:on_release => lambda{
					aval = true
					self.fire
				}, 
				:on_refractory => lambda{
					aval = false
				}
			})		
		elsif type==1 #L and not R
			@left_input.set_callbacks({
				:on_release => lambda{
					lval=true
					if not rval
						self.fire
						aval = true
					end
				}, 
				:on_refractory => lambda {
					lval=false
					aval=false
				}
			})		
			@right_input.set_callbacks({
				:on_release => lambda {
					rval=true 
					aval=false
				}, 
				:on_refractory => lambda {
					rval=false 
					if lval
						aval=true
						self.fire
					end
				}
			})		
		elsif type==2 #R and not L
			@left_input.set_callbacks({
				:on_release => lambda {
					lval=true
					aval=false
				},
				:on_refractory => lambda {
					lval=false
					if rval
						aval=true
						self.fire

					end
				}
			})		
			@right_input.set_callbacks({
				:on_release => lambda {
					rval= true
					if not lval
						aval=true
						self.fire
					end
				},
				:on_refractory => lambda {
					rval=false
				}
			})		

		elsif type==3#R or L
			@left_input.set_callbacks({
				:on_release => lambda {
					lval= true
					aval=true
					self.fire
				},
				:on_refractory => lambda {
					lval=false
					aval=rval
				}
			})		
			@right_input.set_callbacks({
				:on_release => lambda {
					rval= true
					aval=true
					self.fire
				},
				:on_refractory => lambda {
					rval=false
					aval=lval
				}
			})	
		
		elsif type==4 #L and R
			@left_input.set_callbacks({
				:on_release => lambda {
					lval= true 
					if rval
						aval=true
						self.fire
					end
				} ,
				:on_refractory => lambda {
					lval=false
					aval=false
				}
			})		
			@right_input.set_callbacks({
				:on_release => lambda {
					rval= true
					if lval
						aval=true
						self.fire
					end
				}, 
				:on_refractory => lambda {
					rval=false
					aval=false
				}
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
end




















