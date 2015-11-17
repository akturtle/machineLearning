load('cluster_data.mat');
K=4;
h=1;
color=['r','g','b','m'];

[mu, label]=myKmeans(dataA_X',K);
points=dataA_X';
h=figure;
for i=1:K
    classP=points(label==i,:);
    scatter(classP(:,1),classP(:,2),color(i));
    hold on;
    plot(mu(i,1),mu(i,2),['k','d'],'MarkerSize',10);
    hold on;
end
title('Kmeas for DataA')
saveas(h,['kmeas','_A'],'png');

[mu, label]=myKmeans(dataB_X',K);
points=dataB_X';
h=figure;
for i=1:K
    classP=points(label==i,:);
    scatter(classP(:,1),classP(:,2),color(i));
    hold on;
    plot(mu(i,1),mu(i,2),['k','d'],'MarkerSize',10);
    hold on;
end
title('Kmeas for DataB')
saveas(h,['kmeas','_B'],'png');

[mu, label]=myKmeans(dataC_X',K);
points=dataC_X';
h=figure;
for i=1:K
    classP=points(label==i,:);
    scatter(classP(:,1),classP(:,2),color(i));
    hold on;
    plot(mu(i,1),mu(i,2),['k','d'],'MarkerSize',10);
    
    hold on;
end
title('Kmeas for DataC')
saveas(h,['kmeas','_C'],'png');
