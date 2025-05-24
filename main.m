% By Taymaz Rahkar Farshi (PhD)
% 2019-2020 Istanbul
% taymaz.farshi@gmail.com
% https://www.researchgate.net/profile/Taymaz_RFarshi
% https://scholar.google.com/citations?user=l67ZmagAAAAJ&hl=en
% Paper name : A multimodal particle swarm optimization-based approach for image segmentation
% DOI: https://doi.org/10.1016/j.eswa.2020.113233
% https://www.sciencedirect.com/science/article/pii/S0957417420300592
clear ;close all;clc;
%% Visualizations
show_3D_Histogram = 0;
show_Color_distribution = 1; % Take long, 0 is recomanded
show_smoothed_Color_distribution = 1; % Take long, 0 is recommanded
show_cluster_center_on_color_space = 1;
show_cluster_center_on_color_space_smoothed  = 1;

addpath ('LSelectrostatic');
addpath ('altmany');
nich = 80;  % Minimum euclidean distance between cluster centers
dim = 3; % do not change this variable
global GausHist;
global FileName;
global I;

[FileName,PathName] = uigetfile('*.tif;*.bmp;*.png;*.jpg','Select file',pwd);
I = imread(strcat(PathName,FileName));
mkdir('Results',FileName);


[U,V,Z] = size(I);
if Z==1
    I = cat(3, I, I, I);
end
Hist = Hist3D(I);

GausHist = smooth3(Hist,'gaussian',[13 13 13],7);

if show_3D_Histogram
    figure
    [freq, freq_emph, freq_ly] = image_hist_RGB_3d(I,10);
end
if show_Color_distribution
    figure
    ColorSpace( Hist )
end
if show_smoothed_Color_distribution
    figure
    ColorSpace( GausHist )
end

tic
[T_P_best, T_P_best_pos] = PSO(GausHist);
RunTime = toc

%%  Keep best solution in MMPSO and remove rest of the particles
delind =(T_P_best==0);
T_P_best_pos(:,delind) =[];
T_P_best(delind)= [];

T_P_best_pos1 = T_P_best_pos;
T_P_best1 = T_P_best;
result=[];
%
while ~isempty(T_P_best)
    [T_G_best,max_indx] = max(T_P_best);
    result = [result,T_P_best_pos(:,max_indx)];
    [T_P_best,T_P_best_pos] = dellnich(T_P_best,T_P_best_pos,nich,max_indx,dim);
end
%% 
result
result = round(result);
[a,b,c] =size(result);


[Eticets,I2,IG ] = Coloring( result );
imwrite(I2,['Results\',FileName ,'\Segmented.bmp'])


[ F,F2,Q ] = Performance_Eval(numel(Eticets),IG,result );
[curRI,curGCE,curVOI] = Performance_Eval_2(PathName,FileName,IG);


if show_cluster_center_on_color_space_smoothed
    figure
    ColorSpace( GausHist );
    hold on
    plot3(result(2,:),result(1,:),result(3,:),'r*','MarkerSize', 15, 'LineWidth', 3)
    hold off
end

if show_cluster_center_on_color_space
    figure
    ColorSpace( Hist );
    hold on
    plot3(result(2,:),result(1,:),result(3,:),'r*','MarkerSize', 15, 'LineWidth', 3)
    hold off
end

fileID = fopen(['Results\',FileName ,'\Data.txt'],'w');
for i =1:a
    for j = 1:b
        fprintf(fileID,'%d ',result(i,j));
    end
    fprintf(fileID,'\n');
end
fprintf(fileID,'\n \n');
fprintf(fileID,'\n \n Number of segment = %d',numel(result(1,:)));
fprintf(fileID,'\n \nF = %s ',num2str(F));
fprintf(fileID,'\n \nF2 = %s',num2str(F2));
fprintf(fileID,'\n \nQ = %s',num2str(Q));

fprintf(fileID,'\n \nRI = %s ',num2str(curRI));
fprintf(fileID,'\n \nGCE = %s',num2str(curGCE));
fprintf(fileID,'\n \nVOI = %s',num2str(curVOI));
fclose(fileID);

disp('Finish.');


