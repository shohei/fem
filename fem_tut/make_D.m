function D=make_D(young,poisson)

coef = young/(1-2*poisson)/(1+poisson);

D = zeros(3,3);
D(1,1) = coef * (1-poisson);
D(1,2) = coef * poisson;
D(1,3) = 0;
D(2,1) = D(1,2);
D(2,2) = coef * (1-poisson);
D(2,3) = 0;
D(3,1) = D(1,3);
D(3,2) = D(2,3);
D(3,3) = coef * (1-2*poisson)/2;

end