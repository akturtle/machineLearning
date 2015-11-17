function[mu, label]=myKmeans(features,k) 
[n,m]=size(features);
% index=randperm(n);
% index=index(1:k);
% muOld=features(index,:);

% Initialize the K component means, find K points as initial center 
ma = zeros(m);        % max value
mi = zeros(m);        % min value
mu = zeros(k,m);       


% random initialization
for i=1:m
   ma(i)=max(features(:,i));    
   mi(i)=min(features(:,i));    

   for j=1:k
        mu(j,i)=mi(i)+(ma(i)-mi(i))*rand();  
   end
end
muOld=mu;
disMu=zeros(n,k);
muMove=999;
label=zeros(n,1);
iter=0;
while muMove>0.001&&iter<10000
    for i=1:k
        disMu(:,i)=sum((features-repmat(muOld(i,:),n,1)).^2,2);
    end
    [~, I]=sort(disMu,2,'ascend');
    label=I(:,1);
    mu=zeros(k,m);
    for j=1:k
        mu(j,:)=sum(features(label==j,:))./sum(label==j);
    end
    muMove=sum(sum(sqrt((mu-muOld).^2))); 
    muOld=mu;
    iter=iter+1;
    show=['iter=',num2str(iter),' ','muMove=',num2str(muMove)];
    disp(show)
    disp(mu);
end
