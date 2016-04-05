
require 'vector'

class EQBranch
  Constants =
    begin
      mpr = 0 #unused for the moment
      k = 0.9
      d = 0.9
      logd = Math.log(d)
      i1 = k/(k + Math.log(d))
      i2 = (logd + k)/logd
      i3 = logd - k

      OpenStruct.new(
        mpr: mpr,
        k: k,
        d: d,
        logd: logd,
        i1: i1,
        i2: i2,
        i3: i3
      )
    end

  attr_accessor :u, :v

  # t0, membrane threshold/potential at t0
  attr_accessor :t0, :thresht, :mpt

  def initialize(t0, u, v)
    @u, @v = u, v

    #async variables
    @t0 = t0
    @mpt = 0
    @thresht = 1

    @prop_time = (u - v).norm

    ##this is not even remotely accurate for average branch length with a path with a random walk derivative,
    ##the goal is simply to create some poisson-ish noise.
    @prop_time *= 1 + (rand+rand+rand+rand)/2.0

    @outputs = []
  end

  def connect(branch, weight)
    @outputs << [branch, weight]
  end

  ##TODO:naturalize reset values.
  def fire
    self.thresht = 1
    self.mpt = -0.1
    @outputs.each do |x|
      branch, weight = x
      branch.add weight
    end
  end

  ##This function pushes the membrane state to time t, where presumably there will be a discontinuity
  def update t
    d, k, i1 = Constants.d, Constants.k, Constants.i1

    dt = t - t0
    c1 = thresht - i1*mpt
    self.thresht = c1*Math::E**(-k*dt) + i1*mpt*d*dt
    self.mpt *= d**dt
    self.t0  =  t
  end

  ##This function adds a weighted input to my branch at time t. there are three steps to this.
  ##Since the addition itself is treated as a discontinuity, our analytic solutions will change
  ##with respect to d
  def add weight
    update t

    self.mpt += weight
    if mpt > thresht
      fire t0
    elsif mpt < 0 #the condition might be stricter than this
      #solve for when mp and T are equal, fire then
      fire t0 + solvespike
    end
  end

  def solvespike
    i1, i2, i3 = Constants.i1, Constants.i2, Constants.i3

    c1 = thresht - i1*mpt
    Math.log((c1/mpt)*i2) / i3
  end

  def incr t
    updatemembrane t0 + t
  end
end
