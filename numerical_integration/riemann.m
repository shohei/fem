function riemann

clear all;
close all;

divlist = [10e2,10e3,10e4,10e5,10e6,10e7];
errorlist = [];
for cycle=1:6
    
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
end

loglog(divlist,errorlist,'bo');
title('Riemann integration');
xlabel('number of division');
ylabel('error');

end