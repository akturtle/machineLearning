function[mu, label,weight,cova]=myEm(features,k) 
[n,m]=size(features);
mu=zeros(k,m);
piOld=ones(k,1);
piOld=(1/k).*piOld;
% index=randperm(n);
% index=index(1:k);
% muOld=features(index,:);
% Initialize the K component means, find K points as initial center 
ma = zeros(1,m);        % max value
mi = zeros(1,m);        % min value
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
mu=[-6,0;-2,0;2,0;6,0];


SigmaOld=zeros(m,m,k);
iniVar=diag(diag(cov(features)));
sigmaDia=ones(k,m)*iniVar;
for i=1:k
    SigmaOld(:,:,i)=eye(m,m).*5;
end
iter=0;
muMove=99;
Nj=zeros(1,k);
prob=zeros(n,k);  
alpha=5;
cnt=1;
zOld=zeros(n,k);
assigDif=999;    
z=zeros(n,k);
while assigDif>0.05 &&iter<20000&&cnt<100000

%-------------------E-step---------------------------------------   
for i=1:k 
    temp=features-repmat(mu(i,:),n,1);
    prob(:,i)=exp(-0.5.*(temp.^2)*(1./sigmaDia(i,:)'))./sqrt(prod(sigmaDia(i,:)));
end
temp=prob*diag(piOld);
sumP=sum(temp,2);
z=temp./repmat(sumP,1,k);
% for i=1:n
%         sumZ=zeros(1,k);
%         for j=1:k  
%            sumZ(j)=+piOld(j)*mvnpdf(features(i,:),muOld(j,:),SigmaOld(:,:,j));
%         end
%         temp=sum(sumZ);
%         for j=1:k
%             z(i,j)=sumZ(j)/temp;
%         end
% end   
%------------------M-STEP--------------------------------------
    Nj=sum(z);
    for j=1:k
        piOld(j)=Nj(j)/n;
        muTem=zeros(1,m);
        Sigma=zeros(m,m);
        summu=zeros(1,m);
        temp=repmat(z(:,j),1,m).*features;
        summu=sum(temp);
%         for i=1:n
%             summu=summu+z(i,j)*features(i,:);
%         end
        mu(j,:)=summu./Nj(j);
        
%------------full covariance-------------       
%         for i=1:n
%             Sigma=Sigma+z(i,j).*(features(i,:)'-mu(j,:)')*(features(i,:)'-mu(j,:)')';
%         end
%         SigmaOld(:,:,j)=Sigma./Nj(j);


    end
%%------------iid covanriance-------------
        s=zeros(m,1);
%%to do:add regulization
        for i=1:k
            temp=features-repmat(mu(i,:),n,1);
            s=sum(repmat(z(:,j),1,m).*temp.*temp)/Nj(i);
            SigmaOld(:,:,i)=diag(s); 
            sigmaDia(i,:)=s;
        end
    
    
    if sum(piOld>1/n)<4
        for i=1:k
            if piOld(i)<(1/n)
                
                sigmaDia(i,:)=alpha*ones(1,m);
                [maxWeight,ind]=max(piOld);
                piOld(i)=maxWeight/2;
                piOld(ind)=maxWeight/2;
                %mu(i,:)=mu(ind,:)+rand(1,m).*sqrt(sigmaDia(i,:));
                mu(i,:)=zeros(1,m);
                mu(i,:)=sum(mu)./(k-1);
               
            end 
        end
       iter=0;     
       assigDif=99;
    else  
    dif=z-zOld;
    assigDif=sum(norm(dif));
    %muMove=sum(sum((mu-muOld).^2));

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