function trapezoid

clear all;
close all;

divlist = [10e2, 10e3,10e4,10e5,10e6,10e7];
errorlist = [];
errorlist2 = [];
for cycle=1:length(divlist)
    
    div = divlist(cycle);
    x = linspace(0,1,div);
    fx = 4./(1+x.^2);

    dx = 1/div;

    result = 0;
    for idx=1:div
        result = result + fx(idx)*dx;
    end
    error = result - pi;
    errorlist(end+1) = error;
       
    result2 = 0;
    for idx=1:div-1
        result2 = result + 0.5*(fx(idx)+fx(idx+1))*dx;
    end
    error2 = result2 - pi;
    errorlist2(end+1) = error2;
end

loglog(divlist,errorlist,'r')
hold on,
legend({'Riemann'});
ax2=axes('xaxislocation','top','yaxislocation','right','color','none', 'xscale', 'log', 'yscale', 'log')
hold on
loglog(divlist,errorlist2,'g')
set(gca,'YDir','reverse'); 
legend({'Trapezoid'});

title('Trapezoid formula integration');
xlabel('number of division');
ylabel('error');


end