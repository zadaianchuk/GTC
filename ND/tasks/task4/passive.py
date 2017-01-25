from __future__ import division
import numpy as np


class Compartment:
    'Common base class for all types of compartments'
    def __init__(self, C_m=62.8*10**(-12), R_m=1.59*10**(9),R_a=0.0318*10**(9),E_l=0,type='undifined',current=lambda t: 0):
        self.C_m = C_m
        self.R_m = R_m
        self.E_l=E_l
        self.R_a=R_a
        self.type=type
        self.current=current
    @property
    def tau(self):
        return self.R_m*self.C_m 
    
def I_e_step(I_0,t_0,t):
    return I_0*(t>=t_0)
def I_e_sin(I_0,fr,t): 
    return I_0*np.sin(2*math.pi*fr*t)

class Experiment:
    def __init__(self,t_start=0.0,t_end=1,delta_t=10**(-4)):
        self.t_start=t_start
        self.t_end=t_end
        self.delta_t=delta_t
    @property
    def t(self):
        return np.arange(self.t_start,self.t_end,self.delta_t)
    def voltage(self,Neurite):
        N=len(Neurite)
        N_itr=len(self.t)
        V=np.zeros((N,N_itr))

        for Comp in Neurite:
            Comp.current_vec=np.vectorize(Comp.current)(self.t)
        V[:,0]=0 # initial in time condition
        for i in range(0,N_itr-1):
            V[0,i+1]=((self.delta_t/Neurite[0].C_m)*
            ((Neurite[0].E_l-V[0,i])/Neurite[0].R_m+(2*V[1,i]-2*V[0,i])/(Neurite[0].R_a+Neurite[0].current_vec[i]))
                    +V[0,i]) #sealed end
            V[-1,i+1]=0 #killed end
            for j in range(1,N-1):
                V[j,i+1]=((self.delta_t/Neurite[j].C_m)*
                ((Neurite[j].E_l-V[j,i])/Neurite[j].R_m+(V[j+1,i]+V[j-1,i]-2*V[j,i])/(Neurite[j].R_a)+Neurite[j].current_vec[i])
                          +V[j,i])
                # I can vectorize it, but it will take some time...
        return V