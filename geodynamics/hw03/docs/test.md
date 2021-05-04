theorem
=======

equat ions relating steady-state concentrated loading and crustal response
--------------------------------------------------------------------------

$$\label{Brotchie}
D\nabla^4\omega+(ET/R^2)\omega+\gamma\omega=q$$ in which: $\omega$: the
radial displacement $q$: normal loading of intensity $D$: flexural
stiffness of the shell cross section $$D=ET^3/12(1-\nu^2)$$ $T$:
thickness of the shell $E$: Young's modulus $\nu$: Possion's ratio
**$R$: radius of its middle surface** $\gamma$: density of the liquid
$\nu$: Possion's ratio $\nabla^4$: biharmonic operator

Rewrite the equation [\[Brotchie\]](#Brotchie){reference-type="ref"
reference="Brotchie"}:

$$\label{rewritten}
\nabla^4\omega+(1/l^4)\omega=q/D$$

in which: **$l$: is the radius of relative stiffness**

$$l^4=D/[(ET/R^2)+\gamma]$$

The homogeneous (basic) solution:

[\[solution\]]{#solution label="solution"} $$\begin{aligned}
&\omega_0=C_1ber(x)+C_2bei(x)+C_3ker(x)+C_4kei(x)\\ 
&\omega_P=ql^4/D\\
&\omega=\omega_0+\omega_P\end{aligned}$$

in which: $x$: $r/l$

The solution for a concentrated load of magnitude P:

$$\label{volcano}
\omega=(Pl^2/2\pi D)kei(x)$$

in which: $P$: total loading due to the volcanic cone

The solution for uniform loading:
$$\omega_i=\frac{\gamma_{ice}h}{\gamma^{'}}(aker^{'}(a)ber(x)-akei^{'}(a)bei(x)+1)$$
$$\omega_0=\frac{\gamma_{ice}h}{\gamma^{'}}(aber^{'}(a)ker(x)-abei^{'}(a)kei(x))$$

in which: $a=A/l$

![schematic for r, l](schematic.png)

code setup
==========

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

figure
======

![T=100km](100T100km.png)

![T=50km](100T50km.png)

![T=100km](500T100km.png)

![T=50km](500T50km.png)
