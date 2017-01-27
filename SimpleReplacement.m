function NewGeneration = SimpleReplacement( Parents,ParentFitness,Offsprings,OffspringFitness,BestType,~ )
%REPLACEGENERATION is a selecttion method
%   It's used to replace Offsprings with previous generation via Random
%   Replacement method

    %Ellitism: Best/Worst Selection
    if (strcmp(BestType,'max'))
        [~,BestInd]=max(ParentFitness);
        [~,WorstInd]=min(OffspringFitness);
    else
        [~,BestInd]=min(ParentFitness);
        [~,WorstInd]=max(OffspringFitness);
    end
    
    NextGeneration=Offsprings;
    
    %Ellitism: Worst-Best Replacement
    NextGeneration{WorstInd,1}=Parents{BestInd,1};
    NextGeneration{WorstInd,2}=Parents{BestInd,2};
        
    NewGeneration=NextGeneration;
end

