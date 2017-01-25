from __future__ import division
from model import Model
import numpy as np

import itertools
class NaiveBayesModel(Model):
    def load_data(self):
        self.train_data=np.genfromtxt('./data/train.csv', delimiter=',')
        self.train_labels=np.genfromtxt('./data/train_labels.txt', delimiter=',')
        self.test_data=np.genfromtxt('./data/test.csv', delimiter=',')
        self.test_labels=np.genfromtxt('./data/test_labels.txt', delimiter=',')
    def fit(self,X,y):
        K=2  # number of topics
        J=50 # max number of word in doc
        alpha_pi=1000
        inds=[y==k for k in range(K)]
        pi=[(sum(ind)+alpha_pi)/(y.shape[0]+2*alpha_pi) for ind in inds]
        
        N=X.shape[1] # number of words
        alpha=0.005

        theta=np.zeros((N,J,K),dtype=float)

        for (j,k) in itertools.product(range(J),range(K)):
            X_k=X[inds[k]]
            X_bin=X_k==j
            theta[:,j,k]=((X_bin.sum(axis=0)+alpha)/(X_k.shape[0]+J*alpha))
        self.params=[theta,pi]
        
    def predict(self,x):
        theta=self.params[0]
        pi=self.params[1]
        N=x.shape[0]
        K=2
        log_sum=[np.log(theta[range(N),x.astype(int),k]).sum() for k in range(K)]
        return np.argmax(log_sum)
    def accuracy(self,X,y):
        theta=self.params[0]
        pi=self.params[1]
        return (np.apply_along_axis(lambda x: self.predict(x),axis=1,arr=X)==y).sum()/y.shape[0]
    
class NaiveBayes2Model(Model):
    def load_data(self):
        self.train_data=np.genfromtxt('./data/train.csv', delimiter=',')
        self.train_labels=np.genfromtxt('./data/train_labels.txt', delimiter=',')
        self.test_data=np.genfromtxt('./data/test.csv', delimiter=',')
        self.test_labels=np.genfromtxt('./data/test_labels.txt', delimiter=',')
    def fit(self,X,y):
        K=2  # number of topics
        J=50 # max number of word in doc
        
        alpha=1000
        ind0=y==0
        ind1=y==1
        pi=[]
        pi.append((sum(ind0)+alpha)/(y.shape[0]+2*alpha))
        pi.append((sum(ind1)+alpha)/(y.shape[0]+2*alpha))
        
        
        n=X.shape[1]
        alpha=0.001
        Theta0=((X[ind0].sum(axis=0)+alpha)/(X[ind0].sum()+n*alpha))
        Theta1=((X[ind1].sum(axis=0)+alpha)/(X[ind1].sum()+n*alpha))
        self.params=[Theta0,Theta1,pi]
        
    def predict(self,x):
        Theta0=self.params[0]
        Theta1=self.params[1]
        pi=self.params[2]
 
        if pi[0]+x.dot(np.log(Theta0))>pi[1]+x.dot(np.log(Theta1)):
            return 0
        return 1
    
    def accuracy(self,X,y):
        theta=self.params[0]
        pi=self.params[1]
        return (np.apply_along_axis(lambda x: self.predict(x),axis=1,arr=X)==y).sum()/y.shape[0]