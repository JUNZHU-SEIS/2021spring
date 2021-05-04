from scipy.special import (
		kei, ber, bei, ker,
		keip, berp, beip, kerp)
from config import Config
import numpy as np


def UniformLoading(a=1, x=1, dh=1, config=Config()):
	internal = config.GammaRatio*dh*(a*kerp(a)*ber(np.reshape(x,(-1,1)))-a*keip(a)*bei(np.reshape(x,(-1,1)))+1)
	external = config.GammaRatio*dh*(a*berp(a)*ker(np.reshape(x,(-1,1)))-a*beip(a)*kei(np.reshape(x,(-1,1))))
	return internal+external


def Deflection(t, x, config=Config(), nh=100):
	"""given time t (scalar) and positions x ([x1, x1, ...])
		output:
			1. deflection at given positions [def1, def2], at given time t
	"""
	dh = config.height / nh
	bot = config.rate * t
	a = np.linspace(bot, config.up2bot*bot, nh) / config.l
	return np.sum(UniformLoading(a, x), axis=1)


if __name__ == "__main__":
	Deflection(2, [1, 2])
