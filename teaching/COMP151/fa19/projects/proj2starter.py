# Logan Mayfield
# F19 - COMP151
#  Wave generators and starter code from 
#  project 2 prep. lab.

# needed for white noise generation
import random

# produce an empty sound given time measured in floating point seconds
# i.e. 0.5 seconds 
def makeSilence(sec):
  numSamples = int(sec * 22050)
  return makeEmptySound(numSamples,22050)

# produce a sine wave that lasts for sec seconds and has
# frequency freq and amplitude amp. i.e. sineWave(440.0,5000,2.5)
def sineWave(freq,amp,sec):
  result = makeSilence(sec)
  rate = getSamplingRate(result)
  # length of note's cycle
  cycleLength = 1.0/freq
  # number of samples in a cycle
  sampPerCycle = cycleLength*rate
  #Compute the wave
  samps = getSamples(result)
  for i in range(0,len(samps)):
    # find point on +/- 1 sin wave
    raw = sin((i/sampPerCycle) * 2 * pi)
    value = raw * amp
    setSampleValue(samps[i],value)  
  return result

# sec seconds of white noise with amplitude amp
#  whiteNoise(5000,1.25)
def whiteNoise(amp,sec):
  noise = makeSilence(sec)
  samples = getSamples(noise)
  # generate random samples that are more or less
  # in the +/- 1 range, then scale up amplitude
  for i in range(0,len(samples)):
    samp = samples[i]
    value = amp*random.normalvariate(0,0.5)
    setSampleValue(samp,value)
  return noise


# squareWave with amplitude amp and frequency freq that
# lasts sec seconds: squareWave(220.0,2500,5)
def squareWave(freq,amp,sec):
  swave = makeSilence(sec)
  rate = getSamplingRate(swave)
  # note cycle length as seconds
  secPerCycle = 1.0/freq
  # cycle length in samples 
  samplesPerCycle = rate*secPerCycle
  # the halfway point (in samples) where the wave
  # goes from positive to negative
  turnAt = int(samplesPerCycle/2)
  
  samples = getSamples(swave)
  # count number of samples to find "turn around"
  # point
  timeToTurn = 0
  for i in range(0,len(samples)):
    samp = samples[i]
    if timeToTurn < turnAt:
      setSampleValue(samp,amp)
    else:
      setSampleValue(samp,-1*amp)
    # update sample count modulo the sample length
    timeToTurn = (timeToTurn + 1) % samplesPerCycle
  return swave

# triangle wave that lasts sec seconds, has amplitude amp, and
# frequency freq: triangleWave(458.2,10000,0.5)
def triangleWave(freq,amp,sec):
  twave = makeSilence(sec)
  rate = getSamplingRate(twave)
  # cycle length in seconds
  secPerCycle = 1.0/freq
  # now in samples
  samplesPerCycle = rate*secPerCycle
  # point at which the triangle turns down
  turnAt = int(samplesPerCycle/2)
  # the difference between two steps on the triangle
  stepSize = int(amp / turnAt)
  
  samples = getSamples(twave)
  # count samples for turn around
  timeToTurn = 0
  # track the current sample value
  value = (-1*amp)/2  
  for i in range(0,len(samples)):
    samp = samples[i]
    if timeToTurn < turnAt:
      # going up!
      setSampleValue(samp,value)
      value = min(value + stepSize,amp/2)   
    else:
      # coming down
      setSampleValue(samp,value)
      value = max(value - stepSize,-1*amp/2)
    # update sample cound modulo cycle length
    timeToTurn = (timeToTurn + 1) % samplesPerCycle
  return twave

# sawtooth wave with frequency freq, amplitude amp, and
# duration sec seconds.  sawtoothWave(1000,5000,1)
def sawtoothWave(freq,amp,sec):
  stwave = makeSilence(sec)
  rate = getSamplingRate(stwave)
  # cycle length in seconds
  secPerCycle = 1.0/freq
  # now in samples
  samplesPerCycle = int(rate*secPerCycle)
  # step sizes
  step = int(amp/samplesPerCycle)  
  
  value = int(amp/2)
  samples = getSamples(stwave)
  for i in range(0,len(samples)):
    samp = samples[i]
    if (i % samplesPerCycle) == 0:
      value = int(amp/2)
      setSampleValue(samp,value)
    else:
      setSampleValue(samp,value)
      value = max(value - step,-1*int(amp/2))
  return stwave
      

# compute and return the duration of a single
# beat for a given tempo bpm 
def secondsPerBeat(bpm):
  mpb = 1.0/bpm
  return mpb * 60.0

# determine the number of samples (rounded down) needed
# for sec seconds of audio at a sampling rate of rate
def secsToSamples(sec,rate):
  return int(sec * rate)

# copy source audio into target starting at start seconds
# into target
def copy(source,target,start):
  s_samps = getSamples(source)
  t_samps = getSamples(target)
  rate = getSamplingRate(source)
  t_idx = secsToSamples(start,rate)
  for i in range(0,len(s_samps)):
    ss = s_samps[i]
    ts = t_samps[t_idx]
    setSampleValue(ts,getSampleValue(ss))
    t_idx = t_idx + 1
                    