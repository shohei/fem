function lagrange_interpolation
clear all; close all;

div = 100;
x = linspace(0,pi,100);
y = sin(x);
plot(x,y);
hold on;

a = x(1);
b = x(end);
fx = (x-b)/(a-b)*sin(a) + (x-a)/(b-a)*sin(b);
plot(x,fx);

a = x(1);
b = x(floor((1+end)/2));
c = x(end);
fx = ((x-b).*(x-c))/((a-b)*(a-c))*sin(a) + ...
     ((x-a).*(x-c))/((b-a)*(b-c))*sin(b) + ...
     ((x-a).*(x-b))/((c-a)*(c-b))*sin(c);
plot(x,fx);

a = x(1);
b = x(floor(end*0.3));
c = x(floor(end*0.6));
d = x(end);
fx = ((x-b).*(x-c).*(x-d))/((a-b)*(a-c)*(a-d))*sin(a) + ...
     ((x-a).*(x-c).*(x-d))/((b-a)*(b-c)*(b-d))*sin(b) + ...
     ((x-a).*(x-b).*(x-d))/((c-a)*(c-b)*(c-d))*sin(c) + ...
     ((x-a).*(x-b).*(x-c))/((d-a)*(d-b)*(d-c))*sin(d);
plot(x,fx);

legend({'original' 'N=2' 'N=3' 'N=4' });

end