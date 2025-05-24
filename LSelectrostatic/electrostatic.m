function [ indmaxf ] = electrostatic(X,N,i,p_best)
indmaxf = 1;
fmax = -Inf;
dist = abs(X(1,i)-X(1,:));
% dist = distance(X(1,i),X(2,i),X(1,:),X(2,:));
      dist(i)=1000;
 for j=1:N
   if dist(j)~=1000
      F=(((p_best(i)+1) * p_best(j))/(dist(j) ^ 2));
      if j == 1
         fmax = F;
      end
      if F>fmax
         fmax=F;
         indmaxf=j;
      end
   end
end

end

