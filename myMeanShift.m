function [k,label]=myMeanShift(features,h)
[n,m]=size(features);
xOld=features;
xNew=zeros(n,m);
label = zeros(n,1);
for ii=1:n    
    iter=0;
    xMove=999;
    while xMove>10^(-10)&&iter<1000
        distance=-0.5.*sum((repmat(xOld(ii,:)',1,size(features,1))-features').^2)./(h.^2);
        prob=exp(distance);
        temp=sum(prob);
        xNew(ii,:) = features'*prob'/temp;
        xMove=norm(xNew(ii,:)-xOld(ii,:));
        xOld(ii,:)=xNew(ii,:);
        iter=iter+1;
        show=['iter=',num2str(iter),' ','xMove=',num2str(xMove)];
        disp(show)
    end

end
mu=xNew;
%---------------Labeling--------------------
k=1;
label(1)=k;
for i=2:n
    
    flag=0;
    for j = 1:i-1
        dist = norm(mu(i,:)-mu(j,:));
                
        if(dist<1e-4)
            label(i) = label(j);
            flag = 1;
        break;
        end
    end
    
    if(flag == 0)  
        k = k+1;
        label(i) = k;
    end
end
    
    
    
    
    
    