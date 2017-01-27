function Output = Ys( Chromosomes,Distances )
%Ys shows the Function of the problem
Output = zeros(size(Chromosomes,1),1);
distsum = 0;
		for  i=1:1:size(Chromosomes,1)
            distsum = 0;
            for j=1:1:size(Chromosomes,2)
                distsum = distsum + Distances(Chromosomes(i,j),Chromosomes(i,mod(j,size(Chromosomes,2)) + 1));
            end
            Output(i) = distsum;
        end
    
end