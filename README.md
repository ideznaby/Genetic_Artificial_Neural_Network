# Genetic_Artificial_Neural_Network
In normal neural networks weights can converge to a local minimum and we might not achieve the optimum accuracy. Because of this problem I built a method to find initial weights of Artificial Neural Network using genetic algorithm. This type of initialization of weights can help optimization and it will help reaching a better local optimum. The details of the genetic algorithm that I designed are given below:
* My initial population size is 80. 
* Chromosomes have two parts which each part is a matrix of  ((numberofinputUnits +numberofbiasUnit)*numberOf hiddenUnits)) We generate these matrixes randomly.
* For crossover I chose uniform crossover and it is implemented as: a new matrix with the same size will be generated and the numbers will be between 0 and 1 and the threshold is 0.5, we compare each cell of generated matrix with our chromosomes if it is less than 0.5 it can take corresponding cell of part one chromosome otherwise it will choose a cell from second part. 
* Mutation part : I train neural network with validation set with few iterations.
* Fitness is the accuracy of ANN for cross validation data.
Needs to mention that this Genetic method is more efficient for deep neural network since, finding the initial weights are crucial. But, here I implemented it for a ANN with only a single hidden layer for demonstration.

Note that I did not use any third party libraries for Genetic Algorithm parts however, I implemented Neural Network with help of Matlab's Mathworks library.
