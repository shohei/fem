function chebyshev

figure();hold on;
title('Chebyshev polynomial');

for n=1:4
    x = linspace(-1,1,100);
    theta = acos(x);
    %   theta = linspace(0,2*pi,100);
    %   x = cos(theta);
  Tnx = cos(n*theta);
  plot(x,Tnx);
end
l = legend({'N=1' 'N=2' 'N=3' 'N=4'});
set(l,'FontSize',14);

end