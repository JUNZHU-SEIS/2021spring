import matplotlib.pyplot as plt
import numpy as np


def Plot(t, A, labels, title='T50km'):
	for line in range(A.shape[0]):
		plt.plot(t, A[line], lw=0.1)
		plt.scatter(t, A[line], label=labels[line], s=1)
	plt.legend()
	plt.xlabel('Time(Ma)')
	plt.ylabel('flexture(m)')
	plt.title(title)
	path = '../image/'+title+'.png'
	plt.savefig(path)
	plt.show()
	plt.close
	pass


if __name__ == "__main__":
	t = [0.1, 0.2]
	A = np.array([[1, 2], [1.5,1]])
	labels = ['1', '2']
	Plot(t, A, labels)
