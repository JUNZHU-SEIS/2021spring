import numpy as np


class Config():
	def __init__(self):
		self.rate = 300 * 1e3
		self.duration = 2
		self.height = 2 * 1e3
		self.up2bot = 0.8
		#unit conversion Gpa2pa
		self.E = 70 * 1e9
		self.possion = 0.25
		#unit conversion
		self.rhoBasalts = 2700 * 9.8065
		self.gamma = 2900 * 9.8065
		#thickness
		self.T = 100 * 1e3
		self.r = np.arange(0, 100, 10) * 1e3
		self.delta = 0.01

		self.R = 6371 * 1e3 - self.T
		self.pi = 3.141592654
		self.t0 = 0
		self.te = 2

		self.GAMMA = self.gamma + self.E * self.T / self.R**2
		self.GammaRatio = self.gamma / self.GAMMA
		self.D = self.E*self.T**3/12/(1 - self.possion**2)
		self.l = (self.D / ((self.E*self.T/self.R**2) + self.gamma))**0.25
		self.x = np.array(self.r) / self.l


if __name__ == "__main__":
	config = Config()
	print(config.gamma, config.GAMMA, config.x, config.r, config.l, config.D, config.GammaRatio)
