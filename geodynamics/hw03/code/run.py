from config import Config
from loading import Deflection
from plot import Plot
import numpy as np


if __name__ == "__main__":
	config = Config()
	x = config.x
	t = np.arange(config.t0, config.te, config.delta)
	print(x, t)
	history = []
	for s in t:
		history.append(Deflection(s, x))
	history = np.array(history)
	labels = ['%d km'%(label/1e3) for label in config.r]
	title = 'T%dkm'%(config.T/1e3)
	Plot(t, np.transpose(history), labels, title)
	print(history, history.shape)
