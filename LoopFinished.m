function Output = LoopFinished( GenerCount,ParentsFitness,CheckCount,MaxFitness,MaxGener)
%Check if loop is finished
	
	Var=var(ParentsFitness(max([length(ParentsFitness)-CheckCount+1,1]):end));
	
    if GenerCount>MaxGener
		Output=true;
    elseif var([max(ParentsFitness),MaxFitness])<=0.001
        Output=true;
    elseif GenerCount<CheckCount
		Output=false;
	elseif Var>0.001
		Output=false;
	else
		Output=true;
    end
end