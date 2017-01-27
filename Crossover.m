function [ child1 child2 ] = Crossover( parent1,parent2, parents, numofweight )
%CROSSOVER Summary of this function goes here
%   Detailed explanation goes here
indexes = rand(size(parents{parent1 , numofweight}));
indexes1 = indexes < 0.5;
indexes2 = indexes >= 0.5;
child1 = zeros(size(parents{parent1 , numofweight}));
child2 = zeros(size(parents{parent1 , numofweight}));
child1(indexes1) = parents{parent1 , numofweight}(indexes1);
child1(indexes2) = parents{parent2 , numofweight}(indexes2);
child2(indexes2) = parents{parent1 , numofweight}(indexes2);
child2(indexes1) = parents{parent2 , numofweight}(indexes1);
end

