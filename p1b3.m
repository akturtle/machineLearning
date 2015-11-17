load('cluster_data.mat');
K=4;
h=1;
color=['r','g','b','m'];

% [mu, label]=myMeanShift(dataA_X',h);
% points=dataA_X';
% pic=figure;
% for i=1:K
%     classP=points(label==i,:);
%     scatter(classP(:,1),classP(:,2),color(i));
%     hold on;
% end
% title('MeanShift for DataA')
% saveas(pic,['MeanShift','_A'],'png');

[mu, label]=myMeanShift(dataB_X',h);
points=dataB_X';
pic=figure;
for i=1:K
    classP=points(label==i,:);
    scatter(classP(:,1),classP(:,2),color(i));
    hold on;
end
title('MeanShift for DataB')
saveas(pic,['MeanShift','_B'],'png');

% [mu, label]=myMeanShift(dataC_X',h);
% points=dataC_X';
% pic=figure;
% for i=1:K
%     classP=points(label==i,:);
%     scatter(classP(:,1),classP(:,2),color(i));
%     hold on;
% end
% title('MeanShift for DataC')
% saveas(pic,['MeanShift','_C'],'png');
