from __future__ import division
from model import Model
import numpy as np
from IPython.core.debugger import Tracer; debug_here = Tracer()
import itertools
from scipy.optimize import minimize
from numpy.random import normal

def sigmoid(x):
    return 1/(1+np.exp(-x))   #X [n x f]; w [1 x f]; y [n x 1]
def loss(X,y,w):
    return -(y*np.log(sigmoid(w.dot(X.T)))+(1-y)*np.log(sigmoid(w.dot(X.T)))).sum() #[1]
def gradient(X,y,w):
    return (sigmoid(w.dot(X.T))-y).dot(X) #[1xf]

    

class LogisticRegressionModel(Model):       
    def fit(self,X,y):
        try:
            w=self.w
        except AttributeError:
            w=normal(loc=0.0, scale=0.1, size=(1,X.shape[1]))
        itr=1000
        lr=10**(-4)
        for i in range(itr):
            w=w-lr*gradient(X,y,w)
            if i%50==0:
                pass
                #print(loss(X,y,w))
        self.w=w
        
    def predict(self,x):
        w=self.w
        if sigmoid(x.dot(w.T))>0.5:
            return 1
        return 0
    
    def accuracy(self,X,y):       
        return (np.apply_along_axis(lambda x: self.predict(x),axis=1,arr=X)==y).sum()/y.shape[0]
