#Machine learning basic model

#Librery import
import json

#Cost function, to calculate the cost of the function
def cost(x, y, b, m):

    #variable declaration
    N = len(x)
    error = 0.0

    #Processing
    for i in range(N):
        hipotesis = b+m*x[i]
        error +=  (y[i] - hipotesis) ** 2

    return error / (2*N)

#This is the gradient descent algorithm
#This algorith is for calculating the error of a fucntion and optimize the best one 
def gradient(x, y, b, m, K, iteration):

    #variable declaration
    N = len(x)
    cost_log = []#All cost log

    #Data process, with number of iterations
    for ep in range(iteration):

        #b and m differencial delcaration
        b_deriv = 0
        m_deriv = 0

        #Loop to find all costs
        for i in range(N):
            hipotesis = b+m*x[i]
            b_deriv += hipotesis - y[i]
            m_deriv += (hipotesis - y[i]) * x[i]
            cost_log.append(cost(x, y, b, m))
        b -= (b_deriv / N) * K
        m -= (m_deriv / N) * K
        
    #The return values of the function are the parameters b, m. a cost_lkog and a prediction function
    return b, m, cost_log, lambda x : b + m * x

#Prediction function, it just return a basic linear funnction prediction on x as a output
def get_prediction(b, m, x):
    return b + m*x

#Model save, it will save the model params as aswell old models prarams
def save_model_params(b, m, path):
    with open(path, "r") as file:
        data = json.load(file)

    if data.isEmpty():
        params = []
    else:
        params = [data["params"], i for i in data["old_params"]]  

    with open(path, 'w') as archivo:
        json.dump(
            {
                'params' : [b, m],
                "old_params" : params
            }, 
            archivo
        )

def get_model_params(path) :
    with open(path, "r") as file:
        data = json.load(file)

    return data["params"]