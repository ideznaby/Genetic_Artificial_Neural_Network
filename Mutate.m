function [ ChildMX ] = Mutate( Child,ProbMutation, net, traindata, trainclasses)
%MUTATE Summary of this function goes here
if(rand<ProbMutation)
    %indexr1=random('unid',size(Child,1),1,1);
    %indexr2=random('unid',size(Child,1),1,1);
    %temp=Child(indexr1,:);
    %Child(indexr1,:)=Child(indexr2,:);
    %Child(indexr2,:)=temp;
    ChildMX=Child;
    net.IW{1} = Child{1}(2:end,:)';
    net.LW{2} = Child{2}(2:end,:)';
    % % biases:
    net.b{1}  =  Child{1}(1,:)';
    net.b{2}  =  Child{2}(1,:)';
    net = train(net,traindata',trainclasses');
    ChildMX{1}(2:end,:) = net.IW{1}';
    ChildMX{2}(2:end,:) = net.LW{2}';
    ChildMX{1}(1,:) = net.b{1};
    ChildMX{2}(1,:) = net.b{2};
else
    ChildMX=Child;
end
end

