function[mu, label,weight,cova]=myEm(features,k) 
[n,m]=size(features);
mu=zeros(k,m);
piOld=ones(k,1);
%using K-means' result to initialize the Em
[mu, assignments]=myKmeans(features,k);
muOld=mu;
sigmaDia=ones(k,m);
for i=1:k
    data_k = features(assignments==i,:);
    piOld(i)=size(data_k,1)/n;
    if size(data_k,1) == 0 || size(data_k,2) == 0
        sigmaDia(:,i) = diag(cov(features));
    else
        sigmaDia(i,:) = diag(cov(data_k))';
    end
end

Nj=zeros(1,k);
prob=zeros(n,k);  
cnt=1;
zOld=zeros(n,k);
assigDif=999;    
z=zeros(n,k);
iter=0;
while assigDif>0.005 &&iter<20000&&cnt<100000

%-------------------E-step---------------------------------------   
for i=1:k 
    temp=features-repmat(mu(i,:),n,1);
    prob(:,i)=exp(-0.5.*(temp.^2)*(1./sigmaDia(i,:)'))./sqrt(prod(sigmaDia(i,:)));
end
temp=prob*diag(piOld);
sumP=sum(temp,2);
z=temp./repmat(sumP,1,k);
 
%------------------M-STEP--------------------------------------
%iid covanriance
Nj=sum(z);
for j=1:k
    piOld(j)=Nj(j)/n;
    temp=repmat(z(:,j),1,m).*features;
    summu=sum(temp);
    mu(j,:)=summu./Nj(j);    
    temp=features-repmat(mu(j,:),n,1);
    s=sum(repmat(z(:,j),1,m).*temp.*temp)/Nj(j);
    sigmaDia(j,:)=s;
end

    
if sum(piOld>1/n)<4 %if empty cluster appears, reinitianlize gm
[mu, assignments]=myKmeans(features,k);
muOld=mu;
sigmaDia=ones(k,m);
for i=1:k
    data_k = features(assignments==i,:);
    piOld(i)=size(data_k,1)/n;
    if size(data_k,1) == 0 || size(data_k,2) == 0
        sigmaDia(:,i) = diag(cov(features));
    else
        sigmaDia(i,:) = diag(cov(data_k))';
    end
end
   iter=0;     
   assigDif=99;
else  
    dif=z-zOld;
    assigDif=sum(norm(dif));
end
zOld=z;
muOld=mu;
iter=iter+1;
cnt=cnt+1;
disp(iter);
end
disp(cnt);
mu=muOld;
[~, I]=sort(z,2,'descend');
label=I(:,1);       
weight=piOld;
cova=sigmaDia;
end