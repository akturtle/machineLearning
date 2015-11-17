load('cluster_data.mat');
K=4;
h=1;
%[mu, label]=myKmeans(dataA_X',K);
[mu, clu]=myEm(dataA_X',K);
%[k, label]=myMeanShift(dataA_X',h);

points=dataA_X';
color=['r','g','b','m'];
for i=1:K
    classP=points(label==i,:);
    scatter(classP(:,1),classP(:,2),color(i));
    hold on;
end

