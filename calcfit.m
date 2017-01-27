function [ fitnesses ] = calcfit( population, data, dataclasses, net )
%CALCFIT Summary of this function goes here
%   Detailed explanation goes here
for i= 1:size(population,1)
    net.IW{1} = population{i,1}(2:end,:)';
    net.LW{2} = population{i,2}(2:end,:)';
    % % biases:
    net.b{1}  =  population{i,1}(1,:)';
    net.b{2}  =  population{i,2}(1,:)';
    y = net(data');
    fitnesses(i) = perform(net,dataclasses',y);
end
end

