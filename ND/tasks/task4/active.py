from __future__ import division
import numpy as np

class Compartment:
    'Active HH compartment'
    #The units of V is mV 
    def __init__(self, 
                 C_m=1,
                 E_l=10.6,
                 E_k=-12,
                 E_Na=115,
                 g_Na=120,
                 g_k=36,
                 g_l=0.3,
                 g_a=0.5,
                 type='undifined',
                 current=lambda t: 0):
        self.C_m = C_m
        self.g_a=g_a
        self.g_l=g_l
        self.g_k=g_k
        self.g_Na=g_Na
        self.E_l=E_l
        self.E_k=E_k
        self.E_Na=E_Na
        self.type=type
        self.current=current
    @property
    def tau(self):
        return self.R_m*self.C_m  
    
def alpha_m(V):
    if V==25:
        return 1
    return 0.1*(V-25)/(1-np.exp(-(V-25)/10))

def alpha_h(V):
    return 0.07*np.exp(-V/20)

def alpha_n(V):
    if V==10:
        return 1
    return 0.01*(V-10)/(1-np.exp(-(V-10)/10))

def beta_m(V):
    return 4*np.exp(-V/18)

def beta_h(V):
    return 1/(1+np.exp(-(V-30)/10))
def beta_n(V):
    return 0.125*np.exp(-V/80)

class Experiment:
    def __init__(self,t_start=0.0,t_end=500,delta_t=0.025):
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
        m=np.zeros((N,N_itr))
        n=np.zeros((N,N_itr))
        h=np.zeros((N,N_itr))
        
        a_n=np.vectorize(alpha_n)
        b_n=np.vectorize(beta_n) 
        n[:,0]=a_n(V[:,0])/(a_n(V[:,0])+b_n(V[:,0]))
        
        a_h=np.vectorize(alpha_h)
        b_h=np.vectorize(beta_h) 
        h[:,0]=a_h(V[:,0])/(a_h(V[:,0])+b_h(V[:,0]))
        
        a_m=np.vectorize(alpha_m)
        b_m=np.vectorize(beta_m) 
        m[:,0]=a_m(V[:,0])/(a_m(V[:,0])+b_m(V[:,0]))
        
        for Comp in Neurite:
            Comp.current_vec=np.vectorize(Comp.current)(self.t)   
            
        if N==1:
            d_t=self.delta_t
            Neuron=Neurite[0]
            C_m= Neuron.C_m
            E_Na= Neuron.E_Na
            E_k= Neuron.E_k
            E_l= Neuron.E_l

            V=np.zeros((N_itr))
            m=np.zeros((N_itr))
            n=np.zeros((N_itr))
            h=np.ones((N_itr))

            #What is the start conditions? 
            
            m[0]=alpha_m(0)/(alpha_m(0)+beta_m(0))
            h[0]=alpha_h(0)/(alpha_h(0)+beta_h(0))
            n[0]=alpha_n(0)/(alpha_n(0)+beta_n(0))

            for i in range(0,N_itr-1):
                g_l=Neuron.g_l
                g_k=Neuron.g_k*(n[i])**4
                g_Na=Neuron.g_Na*((m[i])**3)*h[i]

                m[i+1]=m[i]+d_t*(alpha_m(V[i])*(1-m[i])-beta_m(V[i])*m[i])
                h[i+1]=h[i]+d_t*(alpha_h(V[i])*(1-h[i])-beta_h(V[i])*h[i])
                n[i+1]=n[i]+d_t*(alpha_n(V[i])*(1-n[i])-beta_n(V[i])*n[i])
                V[i+1]=V[i]+(d_t/C_m)*(g_l*(E_l-V[i])+g_k*(E_k-V[i])+g_Na*(E_Na-V[i])+Neuron.current_vec[i])    
        elif N>1:
            #for first Comp
            for i in range(0,N_itr-1):
                for j in range(0,N-1):
                    
                    d_t=self.delta_t

                    C_m=Neurite[j].C_m

                    E_Na=Neurite[j].E_Na
                    E_k=Neurite[j].E_k
                    E_l=Neurite[j].E_l
                    
                    
                    m[j,i+1]=d_t*(alpha_m(V[j,i])*(1-m[j,i])-beta_m(V[j,i])*m[j,i])+m[j,i]
                    n[j,i+1]=d_t*(alpha_n(V[j,i])*(1-n[j,i])-beta_n(V[j,i])*n[j,i])+n[j,i]
                    h[j,i+1]=d_t*(alpha_h(V[j,i])*(1-h[j,i])-beta_h(V[j,i])*h[j,i])+h[j,i]
                    
                    g_l=Neurite[j].g_l
                    g_k=Neurite[j].g_k*(n[j,i])**4
                    g_Na=Neurite[j].g_Na*((m[j,i])**3)*h[j,i]
                    g_ax=Neurite[j].g_a
                                   
                    if (j==0)and(Neurite[j].type=='sealed'):
                        V[j,i+1]=(d_t/C_m)*((E_l-V[j,i])*g_l+(E_k-V[j,i])*g_k+(E_Na-V[j,i])*g_Na+       (2*V[j+1,i]-2*V[j,i])*g_ax+Neurite[j].current_vec[i])+V[j,i]
                    else:
                        V[j,i+1]=(d_t/C_m)*((E_l-V[j,i])*g_l+(E_k-V[j,i])*g_k+(E_Na-V[j,i])*g_Na+(V[j+1,i]+V[j-1,i]-2*V[j,i])*g_ax+Neurite[j].current_vec[i])+V[j,i]
                V[-1,i+1]=0 #killed end  
        return (V,m,h,n)