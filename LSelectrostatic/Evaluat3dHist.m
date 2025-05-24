function f = Evaluat3dHist( X )
global GausHist;

X = floor(X);

[n,m] = size(X);

r = X(1,:);
g = X(2,:);
b = X(3,:);

for i = 1:m
    if (r(i)<1 || g(i)<1 || b(i)<1 || r(i)>255 || g(i)>255 || b(i)>256)
        f(i) = 0;
    else
        try
        f(i) = GausHist(r(i),g(i),b(i));
        catch
            disp('');
        end
    end
end
end
