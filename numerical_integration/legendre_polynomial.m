function legendre_polynomial
clear all; close all; 
figure; hold on;

N = 3;
div = 100;
x = linspace(-1,1,div);
f = (x.^2-1).^N;
plot(x,f,'r');

dfn_dxn = size(1,div);
dfn = f;
for idx=1:N
  dx = horzcat(diff(x),0);
  dfn = horzcat(diff(dfn_dxn),0);
  dfn_dxn = dfn ./ dx;
end
plot(x,dfn_dxn);

PN = 1/((2^N)*factorial(N))*dfn_dxn;

plot(x,PN,'b');

end