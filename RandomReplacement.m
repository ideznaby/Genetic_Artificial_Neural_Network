function NewGeneration = RandomReplacement( Parents,ParentFitness,Offsprings,OffspringFitness,BestType,BoltsmanConstant )
%REPLACEGENERATION is a selecttion method
%   It's used to replace Offsprings with previous generation via Random
%   Replacement method
    
    NextGeneration=Parents;
    if strcmp(BestType,'max')
        [~,BestIndex]=max(ParentFitness);
    else
        [~,BestIndex]=min(ParentFitness);
    end
    for i=1:size(Offsprings,1)
        r=random('unid',size(Parents,1));
        while r==BestIndex
            r=random('unid',size(Parents,1));
        end
        F_Offspring=OffspringFitness(i);
        F_Parent=ParentFitness(r);
        p=1/(1+exp((F_Parent-F_Offspring)/BoltsmanConstant));
        if strcmp(BestType,'max')
            P_Offspring=p;
        else
            P_Offspring=1-p;
        end
        
        if (F_Offspring==0)
            continue;
        elseif (rand<P_Offspring)||(F_Parent==0)
            NextGeneration(r,:)=Offsprings(i,:);
        else
            continue;
        end
    end
    NewGeneration=NextGeneration;
end

