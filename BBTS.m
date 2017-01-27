function MatingPool = BBTS( CurrGener,MateSize,~,type,Fitness,SMArguments )
%BBTS Boltsman Binary Tournoment Selection
%   One of the Selection Methods based on Tournoment method
    
    PopSize=size(CurrGener,1);
    output=zeros(MateSize,size(CurrGener,2));
    
    %setting Boltzman constant if it's provided by the user
    if numel(SMArguments)>0
        if isnumeric(SMArguments)
            if SMArguments>0
                t=SMArguments;
            else
                error('Given Argument for BBTS method is not valid; It should be a non negative number');
            end
        else
            error('Given Argument for BBTS method is not valid; It should be a number');
        end
    else
        t=1;
    end
    
    for i=1:1:MateSize
        %selecting two random chromosomes to compete
        x=randperm(PopSize,2);
        a=x(1);
        b=x(2);
        Fa=Fitness(a);
        Fb=Fitness(b);
        %setting their probabilities of winning tournoment
        p=1/(1+exp((Fb-Fa)/t));
        if strcmp(type,'max')
            Pa=p;
        else
            Pa=1-p;
        end
        %put the winner in mating pool if the random number is less than
            %its probability of winning
        if rand<Pa
            output(i,:)=CurrGener(a,:);
        else
            output(i,:)=CurrGener(b,:);
        end
    end
    %[~,bestindx] = min(Fitness);
    %output(MateSize,:) = CurrGener(bestindx,:);
    MatingPool=output;
end
