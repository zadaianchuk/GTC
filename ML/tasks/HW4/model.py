class Model(object):
    """Common for all ML models class"""  
    def load_data(self):
        """Loads data from disk and stores it in memory."""
        raise NotImplementedError("Each Model must re-implement this method.")
        
    def fit(self,X,y):
        """Use X and y to estimate model parameters"""
        raise NotImplementedError("Each Model must re-implement this method.")           
    def predict(self,X):
        """Use X to predict y"""
        raise NotImplementedError("Each Model must re-implement this method.") 
    def accuracy(self,X,y):
        """Use X and y to calculate the accuracy"""
        raise NotImplementedError("Each Model must re-implement this method.") 
