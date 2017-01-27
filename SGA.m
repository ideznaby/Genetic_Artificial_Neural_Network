function [FinalX,FinalY,iterOfBest,Progresses]=SGA(SelectionMethod,ReplacementMethod,ShowResults,BestType,SMArguments,PCM,traindata, trainclasses, validationdata, validationclasses)
%SGA Simple Genetic Algorithm

    %Input Checking
    if nargin<5
		%Determine that the problem is to find the maximum or minimum
		if nargin<4
			if nargin<3
				disp('Arguments:');
				disp('1)[Mandatory] SelectionMethod: it should be @RWS, @SUS, or @BBTS');
				disp('2)[Mandatory] ShowResults: it should be either 1 or 0');
				disp('3)[Optional-mandatory if SMArguments is set] type: it should be either "max" or "min"');
				disp('4)[Optional] SMArguments: it should be a number');
				return;
			end
		elseif strcmp(BestType,'max')
			BestTypeMethod=@max;
		elseif strcmp(BestType,'min')
			BestTypeMethod=@min;
		else
			error('type should be either "max" or "min"')
		end
    elseif strcmp(BestType,'max')
        BestTypeMethod=@max;
    elseif strcmp(BestType,'min')
        BestTypeMethod=@min;
    else
        error('type should be either "max" or "min"')
    end
    
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Phase1: Initialization

    %problem specific variables
    Nodenums = [69 10 3];
    net = patternnet(Nodenums(2));
    %net.trainFcn = 'traingd';
    %net.trainParam.showWindow=0;
    %net.trainParam.epochs = 5;
    net = configure(net,traindata',trainclasses');
    %set general variables
    PopSize=30;
    OffspringSize=30;
    ChromoSize=2;
    Pc=PCM(1);
    Pm=PCM(2);
    MateSize=30;
    MaxFitness=679;
	%how many of last fitnesses' variance to be checked for loop finishing
    CheckCount=10;
    MaxGener=10;
	
    
    ResultsProgress = zeros(1,1);
    Population = cell(PopSize,ChromoSize);

    for i=1:1:PopSize
        for j=1:ChromoSize
            Population{i,j}=rand(Nodenums(j)+1,Nodenums(j+1));
        end
    end
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    %Phase2: Main Loop
    Parents=Population;
    Offsprings=cell(PopSize,ChromoSize);
    GenerCount=0;
    pause('on');
    ParentsFitness=zeros(1,1);
    while ~(LoopFinished(GenerCount,ResultsProgress,CheckCount,MaxFitness,MaxGener))
        
        %generate fitness for each chromosome
        ParentsFitness=calcfit(Parents,validationdata, validationclasses,net);
        
        Probabilities=ParentsFitness/sum(ParentsFitness);

        %fill mating pool with Selection Method
        MatingPool=SelectionMethod(Parents,MateSize,Probabilities,BestType,ParentsFitness,SMArguments);
        
        %create new generation
        i=1;
        while i<OffspringSize
            c1=random('unid',MateSize);
            c2=random('unid',MateSize);
            if rand()>Pc
                Offsprings{i,1}=MatingPool{c1,1};
                Offsprings{i,2}=MatingPool{c1,2};
                Offsprings{i+1,1}=MatingPool{c2,1};
                Offsprings{i+1,2}=MatingPool{c2,2};
            else
                child1 = cell(1,2);
                child2 = cell(1,2);
                [child1{1} child2{1}] = Crossover(c1,c2,MatingPool,1);
                [child1{2} child2{2}] = Crossover(c1,c2,MatingPool,2);
                %Mutate
                child1 = Mutate(child1,Pm, net, traindata, trainclasses);
                child2 = Mutate(child2,Pm, net, traindata, trainclasses);
                Offsprings{i,1}=child1{1};
                Offsprings{i,2}=child1{2};
                Offsprings{i+1,1}=child2{1};
                Offsprings{i+1,2}=child2{2};
            end
            i=i+2;
        end
        
        %generate fitness for each chromosome
        OffspringFitness=calcfit(Offsprings,validationdata, validationclasses,net);

        %Selecting from Offsprings to replace in New Generation
        Parents=ReplacementMethod(Parents,ParentsFitness,Offsprings,OffspringFitness,BestType,SMArguments);
        
        %generate fitness for each chromosome
        ParentsFitness=calcfit(Parents,validationdata, validationclasses,net);
        GenerCount=GenerCount+1;
        
        ResultsProgress(GenerCount)=BestTypeMethod(ParentsFitness);
        
        %show the the results
        if ShowResults
			[c,i]=BestTypeMethod(ParentsFitness);
			plot((1:GenerCount),ResultsProgress,'b');
        end
        GenerCount
    end

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   %Phase3: Finalization
   
   [c,i]=BestTypeMethod(ParentsFitness);
   %FinalX=ParentXs(i);
   FinalY=c;
   [~,iterOfBest]=BestTypeMethod(ResultsProgress);
   ResultsProgress(iterOfBest)
   c
   FinalX = cell(2);
   FinalX{1} = Parents{i,1};
   FinalX{2} = Parents{i,2};
   %disp(['FinalChromosome=',Parents(i,:),', FinalX=',num2str(FinalX),', FinalY=',num2str(FinalY)])
   Progresses=ResultsProgress;
end