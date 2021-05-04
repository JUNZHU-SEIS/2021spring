import numpy as np
import matplotlib.pyplot as plt
from config import Config
from hw03 import rcP, rcS, scp
from obspy.imaging.source import plot_radiation_pattern as prp


def CoefPlot(path, alpha, beta):
	RC, TR = [], []
	INC = np.arange(900) / 10
	for inc in INC:
		RC.append(rcP(inc, alpha, beta))
		TR.append(rcS(inc, alpha, beta))
	pp = [x[0] for x in RC]
	ps = [x[1] for x in RC]
	sp = [x[0] for x in TR]
	ss = [x[1] for x in TR]
	fig, ax = plt.subplots(1, 2, sharey=True)
	ax[0].plot(INC, pp, label=r'$R_{pp}$')
	ax[0].plot(INC, ps, label=r'$R_{ps}$')
	ax[0].axhline(y=0, c='r', ls='--', lw=2)
	ax[0].set_ylabel(r"coefficient")
	ax[0].set_xlabel(r"incident angle/$^\circ$")
	ax[0].legend()
	ax[0].grid()

	ax[1].plot(INC, sp, label=r'$R_{sp}$')
	ax[1].plot(INC, ss, label=r'$R_{ss}$')
	ax[1].axhline(y=0, c='r', ls='--', lw=2)
	ax[1].set_xlabel(r"incident angle/$^\circ$")
	ax[1].legend()
	ax[1].grid()
#	plt.show()
	plt.savefig(path, dpi=500)
	return


def SCPlot(rayppath, figpath, alpha, beta, radius):
	with open(rayppath, 'r') as f:
		data = [x.split() for x in f.readlines()]
		deg = [float(x[1]) for x in data]
		rayp = [float(x[5])/radius for x in data]
	coef = [scp(x, alpha, beta) for x in rayp]
	plt.plot(deg, coef)
	plt.grid()
	plt.xlabel(r'epicentral distance/$^{\circ}$')
	plt.ylabel('reflection coefficient')
#	plt.show()
	plt.savefig(figpath, dpi=500)
	return


def radiation(mt, figpath):
	prp(mt, kind=['p_sphere', 'p_quiver', 's_quiver'], show=False)
	plt.savefig(figpath, dpi=500)
	return


if __name__ == "__main__":
	plt.rcParams.update({
		"text.usetex": True,
		"font.family": "sans-serif",
		"font.sans-serif": ["Helvetica"]})
	conf = Config()
#	CoefPlot(conf.coefpath, alpha=conf.alpha, beta=conf.beta)
#	SCPlot(conf.rayppath, conf.scpath, conf.cmb_alpha, conf.cmb_beta, conf.radius)
	radiation(conf.mt, conf.rad_path)
