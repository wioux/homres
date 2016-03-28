# Homological Resonance
A two-tiered communication structure for exponentially increasing the connectedness of a neural network.

## Neuroscience as I understand it ##

*Read at your leisure, not formal or even particularly good notation. Ask me questions, so that I can tell you if I'm making something up.*  

A neural network is the space consisting of:  
(t,N) where t is a time, and N is a neural state, described by (G,v<sub>th</sub>,v<sub>curr</sub>,w)  
* a digraph G = (V,E) with:  
* two (positive?) real-valued functions defined on the vertices: threshold and currentvalue  
  - v<sub>th</sub>: V -> R  
  - v<sub>curr</sub>: V -> R  
* two real valued functions defined on the edges: weight, time elapsed since last spike
  - w: E -> R
  - te: E -> R

where we assume certain things about how the neural state changes wrt time, which we can express as a system of differential equations. These are far from certain, since knowing a full set would completely specify the brain up to some sort of chaotic component. Unknown functions will be denoted f<sub>i</sub> for various i. Unknown coefficients will be similarly be denoted c<sub>j</sub> for various j. 

the accumulator v<sub>curr</sub> for each neuron increases at a rate proportional(c<sub>1</sub>) to the weight of each edge directed towards it times some function of the time elapsed since the other end of that edge spiked. e<sup>-x</sup> or similar. This could be well known, I am not sure, I will call it f<sub>1</sub>.  

d(v<sub>curr</sub>(v<sub>i</sub>),t)/dt = Sum<sub>{(v<sub>j</sub>,v<sub>i</sub>) in E} </sub>c<sub>1</sub>f<sub>1</sub>(te(v<sub>j</sub>,v<sub>i</sub>));

time elapsed is more or less just te = t-t<sub>lastspike</sub>. This is notably not really a differential equation, The idea is that the concentration of whatever (glutamate and GABA for our purposes) at the synaptic sites is a very very steep function when it is increasing, and likely drops off exponentially. There *is* a differentiable explanation of this, relating to the depolarization along the axon, which opens a selectively porous membrane, allowing the stored high concentration neurochemicals to leak out into the synapse very briefly, The depolarization of the axon is I think slow compared to the rate at with the high concentration neurotransmitters cross the 20nm synaptic gap, and so fast compared to the time between spikes that we can ignore the events that happen in the actualy synapse, and just say that te is simultaneous with whatever the latency of our axons are. Hence f<sub>1</sub>(te) = e<sup>-te</sup> (or whatever, existing research is our friend). If resonance cannot be obtained without it, then we will have to consider including it, and I will have to find some better mathematicians to decrease the numerical error that results.

There is refractory period between spikes (which cannot be similarly ignored) in which those activation sites on the synaptic cleft are vacated, I suspect that this to allow the local intracranial fluid to return to equilibrium, but having an upper bound on frequency like that will play a large role in whatever resonance comes out of it, and in fact, I suspect that the information lost during the refractory period plays a large role in..

d(w(u,v))/dt and d(th(v))/dt 

These are the functions where there is basically no real data available, just buttloads of speculaton. A degree in neuroscience *might* help to rule out possibilities for these functions, but I think we have at least an equal (and I believe much better), approach. 

##Homological Resonance as I Propose it##

Neurons do exactly one (two) thing(s), they propagate and combine signals. A not unreasonable analogy is some people in a crowd playing a game of telephone. The reason that the telephone analogy is apt is that people playing telephone are discrete, more or less made of neurons, and while under normal circumstances they are good at transmitting information, in a very loud concert, they need to get clever.

This problem seems ridiculously hard. Feynmann illustrates this point well in his bug on the surface of a pool speech. The electromagnetic field is at all times, almost entirely without exception, utter chaos. Yet we see crystal clear images. It's not unbelievable, it's just optics. The EM field being *messy* does not imply the EM field being *lossy*. 









