function MatingPool = RWS( CurrGener,MateSize,Probabilities,~,~,~ )
%RWS Roulet Weel Selection Method
%   One of the Selection Methods based on probabilities

    PopSize=size(CurrGener,1);
    output=cell(MateSize,size(CurrGener,2));
    
    Circle=zeros(1,PopSize);
    
%   make sum of probabilities (step to step) for each element
%       of Population(current generation)and store them in Circle
    for j=1:1:PopSize
        Circle(j)=sum(Probabilities(1:j));
    end
    
    for j=1:1:MateSize
        %make a random number and select all chromosomes
            %where the random number is less than sum of probabilities of
            %those chromosomes
        t=CurrGener(rand<Circle,:);

        %select the first occurence of the conditions mentioned in above
            %comments
        output{j,1}=t{1,1};
        output{j,2}=t{1,2};
    end   
    MatingPool=output;
end