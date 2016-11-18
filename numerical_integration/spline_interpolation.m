function spline_interpolation
clear all;
close all;
format compact;

div = 100;
x = linspace(-1,1,100);
y = 1./(1+25*x.^2);

    function yn=fx(n)
        yn = 1./(1+25*n^2);
    end

plot(x,y);
hold on;
title('3rd-order N-spline interpolation');

N = 10;
x = linspace(-1,1,N+1);

for idx=2:N
 a(idx)=2*((x(idx+1)-x(idx))+(x(idx)-x(idx-1)));
 b(idx)=x(idx+1)-x(idx);
 c(idx)=x(idx)-x(idx-1);
end
a(1)=2*(x(2)-x(1));
a(N+1)=2*(x(N+1)-x(N));
b(N+1)=x(N+1)-x(N);
c(1)=x(2)-x(1);
c(N+1)=x(N+1)-x(N);

A = zeros(N+1);
A(1,1) = a(1);
A(1,2) = c(1);
A(N+1,N) = b(N+1);
A(N+1,N+1) = a(N+1);
for idx=2:N
   A(idx,idx-1) = b(idx);
   A(idx,idx) = a(idx);
   A(idx,idx+1) = c(idx);
end

Y = zeros(N+1,1);
Y(1) = 3*(fx(2)-fx(1));
Y(N+1) = 3*(fx(N+1)-fx(N));
for idx=2:N
   Y(idx) = 3*(...
     (x(idx)-x(idx-1))/(x(idx+1)-x(idx))*(fx(idx+1)-fx(idx)) + ...
     (x(idx+1)-x(idx))/(x(idx)-x(idx-1))*(fx(idx)-fx(idx-1)) );
end

X = A\Y;
C2 = X;

for idx=1:N
   C3(idx) = 1/(x(idx+1)-x(idx))*(...
        -2*C2(idx)-C2(idx+1)+...
        3*(fx(idx+1)-fx(idx))/(x(idx+1)-x(idx)));
   C4(idx) = 1/(x(idx+1)-x(idx))^2*(...
       C2(idx)+C2(idx+1)-...
       2*(fx(idx+1)-fx(idx))/(x(idx+1)-x(idx)));
   C1(idx) = fx(idx);
end

% Consider: i < x <  i+1
for idx=1:N
  xi = linspace(x(idx),x(idx+1),10);
  P(idx,:) = C1(idx) + C2(idx)*(xi-x(idx)) + ...
       C3(idx)*(xi-x(idx)).^2 + ...
       C4(idx)*(xi-x(idx)).^3;
  plot(xi,P(idx,:),'r');
end

h_legend=legend({'$1/1+25x^2$', 'N-Spline'},'Interpreter','latex')
set(h_legend,'FontSize',14);


end