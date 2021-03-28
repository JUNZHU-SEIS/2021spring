# Author: Jun Zhu
# Date:   MAR 28 2021
# Email:  Jun__Zhu@outlook.com

import numpy as np
import matplotlib.pyplot as plt
from matplotlib.ticker import MaxNLocator

def inwindow(x=[4,4.1],y=[2,4]):
	"""check if the box is in the window
		notes:
			if True, return 1
			if False, return 0
	"""
	if (x[1]>y[0]) and (x[0]<y[1]):
		tick = 1
	else:
		tick =0
	return tick

def fold(
		shot_p=0,
		shot_n=2,
		shot_i=1,
		offset=1,
		receiver_n=2,
		receiver_i=1):
	"""calculate multiplicity
	"""
	first_CMPs = []
	CMP_lists = []
	CMPs = []
	shot_pn = shot_p
	for n in range(shot_n):
		first_CMP = shot_pn + 1/2*offset
		first_CMPs.append(first_CMP)
		CMP_n = first_CMP + np.arange(receiver_n)*receiver_i/2
		CMP_lists.append(CMP_n)
		CMPs += list(CMP_n)
		shot_pn +=  shot_i
	CMPs = list(set(CMPs))
	CMPs.sort()
	boxes = [[x, CMPs[i+1]] for i,x in enumerate(CMPs[:-1])]
	boxes = [[shot_p, first_CMPs[0]]] + boxes
	windows = [[x[0],x[-1]] for x in CMP_lists]
	multiplicity = [sum([inwindow(box,window) for window in windows]) for box in boxes]
	n = multiplicity
	lastbox_width = boxes[-1][-1]-boxes[-1][0]
	bins = [x[0] for x in boxes]
	width = np.append(np.diff(bins), lastbox_width)
	ax = plt.figure().gca()
	ax.bar(bins, n, width=width, align='edge', edgecolor='k', color='r')
	ax.axvline(x=shot_p, ls='--', c='gray')
	ax.set_xlabel('distance')
	ax.set_ylabel('fold')
	parameters = "shot_p"+str(shot_p)+"shot_n"+str(shot_n)+"shot_i"+str(shot_i)+"offset"+str(offset)+"receiver_n"+str(receiver_n)+"receiver_i"+str(receiver_i)
	ax.set_title(parameters)
	ax.yaxis.set_major_locator(MaxNLocator(integer=True))
	ax.grid(linestyle='-.', axis='y')
	fname = "../image/"+parameters+".png"
	plt.savefig(fname, dpi=500)
	#plt.show()
	pass

if __name__ == "__main__":
	candidate_receiver_i = np.arange(20) + 1
	for receiver_i in candidate_receiver_i:
		fold(
			shot_p=0,
			shot_n=10,
			shot_i=20,
			offset=20,
			receiver_n=12,
			receiver_i=receiver_i)
	pass
