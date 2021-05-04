class Config():
	def __init__(self):
		self.alpha = 4.98
		self.beta = 2.9
		self.rho = 2.667
		self.coefpath = "../image/coef.png"

		self.radius = 6371
		self.cmb_alpha = 13.6602
		self.cmb_beta = 7.2811
		self.rayppath = "taup/rayp"
		self.scpath = "../image/scpcoef.png"

		self.mt = [-3.43, 2.42, 1.01, -0.94, 0.17, -1.27]
		self.rad_path = "../image/radiation.png"

if __name__ == "__main__":
	print(Config().__dict__)
