require_relative 'Event'
require_relative 'EventQueue'
require_relative 'Vector'
require 'gl'
require 'gosu'
require 'distribution'

class EQBranch
  #for the moment, we will assume that every node (Branch x Branch -> Branch) obeys the hodgkin-huxley equations, or something
  #similar enough to be discretized.
  def self.setepsilons #synaptic delay, ap_length, and ap_speed
  end

  def self.setconstants
    #hopefully we do not have to solve this one level deeper with k and d
    @@mpr = 0 #unused for the moment
    @@k = 0.9
    @@d = 0.9
    @@logd = Math.log(@@d)
    @@i1 = @@k/(@@k + Math.log(@@d))
    @@i2 = (@@logd + @@k)/@@logd
    @@i3 = @@logd - @@k
  end

  attr_accessor :u, :v
  attr_accessor :t0, :thresht, :mpt
  def initialize(u, v)
    @u, @v = u, v

    #async variables
    @t0 = @@eventqueue.current#the time at which the last calculation was performed,
    @mpt = 0 #membrane potential at time t
    @thresht = 1 #threshold at time t

    @prop_time = (u - v).length
    @prop_time *= 1 + (rand+rand+rand+rand)/2.0
    ##this is not even remotely accurate for average branch length with a path with a random walk derivative,
    ##the goal is simply to create some poisson-ish noise.

    @outputs = []
  end

  def addoutput branch,weight
    @outputs << [branch,weight]
  end

  def setproc #only construct this once. Why not?
    @event = Proc.new{onfire}
  end

  ##TODO:naturalize reset values.
  def onfire
    self.thresht = 1
    self.mpt = -0.1
    @outputs.each do |x|
      branch, weight = x
      branch.addweight weight, @@eventqueue.current##solves mp(t) = T(t) and adds a new fire event at t, if it exists
    end
  end

  ##This function pushes the membrane state to time t, where presumably there will be a discontinuity
  def updatemembrane t
    dt = t - t0
    c1 = thresht - @@i1*mpt
    self.thresht = c1*Math::E**(-@@k*dt) + @@i1*mpt*@@d**dt
    self.mpt *= @@d**(dt)
    self.t0  =  t
  end

  ##This function adds a weighted input to my branch at time t. there are three steps to this.
  ##Since the addition itself is treated as a discontinuity, our analytic solutions will change
  ##with respect to d
  def addweight weight, t
    updatemembrane t
    @@eventqueue.cancel @event
    self.mpt += weight
    if mpt > thresht
      fire t0
    elsif mpt < 0 #the condition might be stricter than this
      #solve for when mp and T are equal, fire then
      fire t0 + solvespike
    end
  end

  def solvespike
    c1 = thresht - @@i1*mpt
    Math.log((c1/mpt)*@@i2)/@@i3
  end

  def fire t
    @@eventqueue.insert @event, t + @prop_time
  end

  def incr t
    updatemembrane t0 + t
  end

  def self.seteventqueue eventqueue
    @@eventqueue = eventqueue
  end
end
