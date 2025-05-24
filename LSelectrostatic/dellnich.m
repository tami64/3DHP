function [ T_P_best,T_P_best_pos ] = dellnich(T_P_best,T_P_best_pos,nich,max_indx,dim)
[M,N] = size(T_P_best);
for j =1:N
    Dist (j) = sqrt(sum((T_P_best_pos(:,max_indx)-T_P_best_pos(:,j)).^2));
end
[unused,N]=size(T_P_best);
% dell_list=[max_indx];
dell_list=[];
for j=1:N
    if  Dist(j)<= nich
        dell_list=[dell_list,j];
    end
end
T_P_best(dell_list) = [];
T_P_best_pos(:,dell_list) = [];

end