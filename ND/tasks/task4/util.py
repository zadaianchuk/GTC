def squeeze(x):
    squeezed=[]
    for i in range(len(x)-1):
        if (x[i]==0)and(x[i+1]==1):
            squeezed.extend([0,1])
    return squeezed
def I_e_step(I_0,t_0,t):
    return I_0*(t>=t_0)
def I_e_sin(I_0,fr,t): 
    return I_0*np.sin(2*math.pi*fr*t)