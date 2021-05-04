import numpy as np
import matplotlib.pyplot as plt
from config import Config


def rcP(inc, alpha, beta):
	inc = np.deg2rad(inc)
	scatter = np.arcsin(beta*np.sin(inc)/alpha)
	p = np.sin(inc) / alpha
	a = 1/beta**2-2*p**2
	b = 4*p**2*(np.cos(inc)/alpha)*(np.cos(scatter)/beta)
	c = 4*alpha/beta*p*np.cos(inc)/alpha
	pp = (-a**2+b) / (a**2+b)
	ps = (c*a) / (a**2+b)
	return pp, ps


def rcS(inc, alpha, beta):
	inc = np.deg2rad(inc)
	scatter = np.arcsin(alpha*np.sin(inc)/beta)
	p = np.sin(inc) / beta
	a = 1/beta**2-2*p**2
	b = 4*p**2*(np.cos(scatter)/alpha)*(np.cos(inc)/beta)
	c = 4*beta/alpha*p*np.cos(inc)/beta
	sp = (c*a) / (a**2+b)
	ss = (a**2-b) / (a**2+b)
	return sp, ss


def scp(rayp, alpha, beta):
	inc = np.arcsin(rayp * beta)
	sp, _ = rcS(inc, alpha, beta)
	return sp


def radiation(theta, phi):
	theta = np.deg2rad(theta)
	phi = np.deg2rad(phi)
	p_r = np.sin(2*theta.reshape(-1,1))*np.cos(phi)
	s_theta = np.cos(2*theta.reshape(-1,1))*np.cos(phi)
	s_phi = - np.cos(theta.reshape(-1,1))*np.sin(phi)
	return p_r, s_theta, s_phi


if __name__ == "__main__":
	conf = Config()
#	print(scp(0.000696594, conf.cmb_alpha, conf.cmb_beta))
	p_r, s_theta, s_phi = radiation(np.arange(180), np.arange(360))
	print(p_r)
	pass
