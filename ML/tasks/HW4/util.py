import numpy as np
def load_data():
        train_data=np.genfromtxt('./data/train.csv', delimiter=',')
        train_data=np.c_[np.ones(train_data.shape[0]),train_data]
        train_labels=np.genfromtxt('./data/train_labels.txt', delimiter=',')
        test_data=np.genfromtxt('./data/test.csv', delimiter=',')
        test_data=np.c_[np.ones(test_data.shape[0]),test_data]
        test_labels=np.genfromtxt('./data/test_labels.txt', delimiter=',')
        return (train_data,train_labels,test_data,test_labels)