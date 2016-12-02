function chebyshev_interpolation
clear all; close all;

x=linspace(-1,1,100);
y=1./(1+25*x.^2);
plot(x,y);
hold on;
title('chebyshev interpolation');

N=17;
div = 10;
x=linspace(-1,1,N*div);
lambda = zeros(1,N);
lambda(1) = pi;
lambda(1,2:end) = pi/2;
c = zeros(N,N*div);
wi = pi/N;
fN = 0;
for k=1:N
    for idx=2:N
        xi = linspace(x(idx-1),x(idx),div);
        c(k,((k-1)*div)+1:k*div) = c(k,((k-1)*div)+1:k*div) + 1/lambda(idx)*wi*T(N-1,xi).*f(xi);        
    end
end
for k=1:N
  fN = fN + c(k,:).*T(N-1,x);
end
plot(x,fN,'r'); 


    function res=T(N,x)
        theta = acos(x);
        res = cos(N*theta);
    end

    function y=f(x)
        y=1./(1+25*x.^2);
    end


end