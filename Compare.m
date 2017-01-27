function Compare(iters)
%COMPARE Summary of this function goes here
%   Detailed explanation goes here
    
    GenerCount=zeros(3);
    Points = zeros(1,iters,2);
    for i=1:iters
        clc;
        disp(['iteration: #',num2str(i)]);
        pause(0.01);
        [~,~,~,t]=SGA(@BBTS,@RandomReplacement,0,'max',10,[0.9,0.1]);
        GenerCount(i,1)=length(t);
        for j=1:GenerCount(i,1)
            Points(j,i,1)=t(j);
        end
        [~,~,~,t]=SGA(@BBTS,@RandomReplacement,0,'max',10,[0.9,0.2]);
        GenerCount(i,2)=length(t);
        for j=1:GenerCount(i,2)
            Points(j,i,2)=t(j);
        end
        [~,~,~,t]=SGA(@BBTS,@RandomReplacement,0,'max',10,[0.7,0.1]);
        GenerCount(i,3)=length(t);
        for j=1:GenerCount(i,3)
            Points(j,i,3)=t(j);
        end
        [~,~,~,t]=SGA(@BBTS,@RandomReplacement,0,'max',10,[0.7,0.2]);
        GenerCount(i,4)=length(t);
        for j=1:GenerCount(i,4)
            Points(j,i,4)=t(j);
        end
    end
    MinGen=min(min(GenerCount));
    meanPoints = zeros(MinGen,2);
    iterOfBest=zeros(MinGen,2);
    Bests=zeros(MinGen,2);
    for i=1:4
        meanPoints(:,i)=mean(Points(1:MinGen,:,i),2);
        [Bests(i),iterOfBest(i)]=max(meanPoints(:,i));
    end
    plot(1:MinGen,meanPoints(:,1),'r',1:MinGen,meanPoints(:,2),'g',1:MinGen,meanPoints(:,3),'b',1:MinGen,meanPoints(:,4),'y', ...
         [iterOfBest(1),iterOfBest(1)],[0,Bests(1)],'--r',...
        [iterOfBest(2),iterOfBest(2)],[0,Bests(2)],'--g',...
         [iterOfBest(3),iterOfBest(3)],[0,Bests(3)],'--b',...
         [iterOfBest(4),iterOfBest(4)],[0,Bests(4)],'--y');
    MinYs=min(meanPoints);
    text(iterOfBest(1)+0.5,min(MinYs)-0.05+(Bests(1)-min(MinYs)+0.05)/2,['iteration ',num2str(iterOfBest(1))],'Rotation',90,'color','r');
    text(iterOfBest(2)+0.5,min(MinYs)-0.05+(Bests(2)-min(MinYs)+0.05)/2,['iteration ',num2str(iterOfBest(2))],'Rotation',90,'color','g')
    text(iterOfBest(3)+0.5,min(MinYs)-0.05+(Bests(3)-min(MinYs)+0.05)/2,['iteration ',num2str(iterOfBest(3))],'Rotation',90,'color','b');
    text(iterOfBest(4)+0.5,min(MinYs)-0.05+(Bests(4)-min(MinYs)+0.05)/2,['iteration ',num2str(iterOfBest(4))],'Rotation',90,'color','y');
    %ylim([min(MinYs)-0.05,3.95]);
    xlim([0,MinGen+1]);
    legend(gca,'PM=0.9 - PC=0.1','PM=0.9 - PC=0.2','PM=0.7 - PC=0.1','PM=0.7 - PC=0.2');
    title('Comparison between SimpleReplacement and RandomReplacement method in GA for an average of 1000 executions of 100 generations');
end

