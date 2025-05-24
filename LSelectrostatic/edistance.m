function [ temp ] = edistance(X,N,i,p_best,c1,c2,XMinMax,P_best_pos,dim)
temp=zeros(3,1);
for j =1:N
    dist (j) = sqrt(sum((P_best_pos(:,i)-P_best_pos(:,j)).^2));
end
% dist = distance(X(1,i),X(2,i),X(1,:),X(2,:));
% dist = abs(P_best_pos(1,i)-P_best_pos(1,:));
% dist = distance(P_best_pos(1,i),P_best_pos(2,i),P_best_pos(1,:),P_best_pos(2,:));
dist(i)=inf;
[notuse_dist indx]=min(dist);
if p_best(indx)>= p_best(i)
    temp(:,1)=P_best_pos(:,i)+ c1 * rand(dim,1) .* (P_best_pos(:,indx) - P_best_pos(:,i)) + c2 * rand(dim,1) .* (P_best_pos(:,indx) - P_best_pos(:,i));
else
    temp(:,1)=P_best_pos(:,i)+ c1 * rand(dim,1) .* (P_best_pos(:,i) - P_best_pos(:,indx)) + c2 * rand(dim,1) .* (P_best_pos(:,i) - P_best_pos(:,indx));
end
if temp(1)<XMinMax(1,1)
    temp(1)=XMinMax(1,1);
end
if temp(1)>XMinMax(1,2)
    temp(1)=XMinMax(1,2);
end

if temp(2)<XMinMax(2,1)
    temp(2)=XMinMax(2,1);
end
if temp(2)>XMinMax(2,2)
    temp(2)=XMinMax(2,2);
end

if temp(3)<XMinMax(3,1)
    temp(3)=XMinMax(3,1);
end
if temp(3)>XMinMax(3,2)
    temp(3)=XMinMax(3,2);
end

end
