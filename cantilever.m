function cantilever

F=1.0;
% F = [Fz1 My1 -F 0]';
E=1;
Iy=1;
L=1;
K = E*Iy*L^3*[...
    12 -6*L -12 -6*L;
    -6*L 4*L^2 6*L 2*L^2;
    -12 6*L 12 6*L;
    -6*L 2*L^2 6*L 4*L^2;
    ];
delta=[0 0 w2 by2];
K*delta


end