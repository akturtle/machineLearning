load('cluster_data.mat');
K=4;
h=1;
color=['r','g','b','m'];
% 
% [mu, label,weight,cova]=myEm(dataA_X',K);
% points=dataA_X';
% h=figure;
% for i=1:K
%     classP=points(label==i,:);
%     scatter(classP(:,1),classP(:,2),color(i));
%     hold on;
%     plot(mu(i,1),mu(i,2),['k','d'],'MarkerSize',10);
%     hold on;
% end
% title('EM for DataA')
% saveas(h,['EM','_A'],'png');
% 
% [mu, label,weight,cova]=myEm(dataB_X',K);
% points=dataB_X';
% h=figure;
% hold on;
% for i=1:K
%     classP=points(label==i,:);
%     scatter(classP(:,1),classP(:,2),color(i));
%     plot(mu(i,1),mu(i,2),[color(i),'d'],'MarkerSize',10);
%     vl_plotframe([mu(i,:) cova(i,1) 0 cova(i,2)]);
% end
% title('EM for DataB')
% saveas(h,['EM','_B'],'png');
% 
[mu, label,weight,cova]=myEm(dataC_X',K);
points=dataC_X';
h=figure;
hold on;
for i=1:K
    classP=points(label==i,:);
    scatter(classP(:,1),classP(:,2),color(i));
    plot(mu(i,1),mu(i,2),[color(i),'d'],'MarkerSize',10);
    vl_plotframe([mu(i,:) cova(i,1) 0 cova(i,2)]);
end
hold off;
title('EM for DataC')
saveas(h,['EM','_C'],'png');
