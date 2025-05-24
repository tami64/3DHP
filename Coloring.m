function [ Eticets,I2,IG ] = Coloring( RGBpeaks )
% Taymaz Rahkar Farshi(PhD)  2019-2020

disp(' Creat color palette ... ')
global I;
ColorLabel =  [];
[U V Z] = size(I);
[X Y Z] = size(RGBpeaks);

I2 = I;
IG = double(zeros(U,V));
for u = 1:U
    for v = 1:V
        Peakss = [];
        pix = double([I(u,v,1); I(u,v,2);I(u,v,3)]);
        Dist = [];
        Peakindex = [];
        tt = 0;
        for r = 1:Y                              
                    Peakss = [Peakss; RGBpeaks(1,r),RGBpeaks(2,r),RGBpeaks(3,r)];                                   
                    Dist = [Dist,sqrt(sum((pix-Peakss(end,:)').^2))];
        end
                       
        [GId,indx] = min(Dist); 
        r = (Peakss(indx,1));
        g = (Peakss(indx,2));
        b = (Peakss(indx,3));
        
        I2(u,v,1) = uint8(Peakss(indx,1));
        I2(u,v,2) = uint8(Peakss(indx,2));
        I2(u,v,3) = uint8(Peakss(indx,3));
%         IG(u,v) = ColorLabel(r,g,b);
        IG(u,v) = indx;

    end
end
Eticets = unique(IG)';
numel(Eticets)

figure;
imshow(I);
figure;
imshow(I2);

end

