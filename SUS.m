function MatingPool = SUS( CurrGener,MateSize,Probabilities,~,~,~ )
%SUS_SELECTION Stochastic Universal Sampling
%   A selection method based on Sampling
    
    PopSize=size(CurrGener,1);
    output=zeros(MateSize,size(CurrGener,2));
    %select a random point as our start point
    FirstPoint=rand;
    %determine the size of steps between each point and its next point
    dist=1/MateSize;
%   make sum of probabilities (step to step) for each element
%       of Population(current generation)and store them in Circle
    Circle=zeros(1,PopSize);
    for j=1:1:PopSize
        Circle(j)=sum(Probabilities(1:j));
    end
    
    Pointer=FirstPoint;
    for j=1:1:MateSize
        %select all chromosomes where the Point is less
            %than sum of probabilities of those chromosomes
        t=CurrGener(Pointer<Circle,:);
        %select the first occurence of the conditions mentioned in above
            %comments
        output(j,:)=t(1,:);
        %increment Point by dist to next point  but beware that it should
        %be less than 1
        Pointer=mod(Pointer+dist,1);
    end   
    MatingPool=output;
end

