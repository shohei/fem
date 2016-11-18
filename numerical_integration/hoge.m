function hoge
clear all;
close all;


x1 = 1:1000;
y1 = x1.^2;
x2 = 2*x1;
y2 = y1;
loglog(x1,y1,'r')
hold on,
ax2=axes('xaxislocation','top','yaxislocation','right','color','none', 'xscale', 'log', 'yscale', 'log')
hold on
loglog(x2,y2,'g')

end