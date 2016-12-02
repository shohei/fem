function cubic_computation

lx = 1;
ly = 1;
lz = 1;

p1=[0 0 0]';
p2=[lx 0 0]';
p3=[lx ly 0]';
p4=[0 ly 0]';
p5=[0 0 lz]';
p6=[lx 0 lz]';
p7=[lx ly lz]';
p8=[0 ly lz]';

function Ni = makeN(p)
    x = p(1);
    y = p(2);
    z = p(3);
    N1 = 1/8*(1-2*x/lx)*(1-2*y/ly)*(1-2*z/lz);
    N2 = 1/8*(1+2*x/lx)*(1-2*y/ly)*(1-2*z/lz);
    N3 = 1/8*(1+2*x/lx)*(1+2*y/ly)*(1-2*z/lz);
    N4 = 1/8*(1-2*x/lx)*(1+2*y/ly)*(1-2*z/lz);
    N5 = 1/8*(1-2*x/lx)*(1-2*y/ly)*(1+2*z/lz);
    N6 = 1/8*(1+2*x/lx)*(1-2*y/ly)*(1+2*z/lz);
    N7 = 1/8*(1+2*x/lx)*(1+2*y/ly)*(1+2*z/lz);
    N8 = 1/8*(1-2*x/lx)*(1+2*y/ly)*(1+2*z/lz);
    Ni  = [N1 N2 N3 N4 N5 N6 N7 N8];
end

Ni = makeN(p(2));
N = [...
    Ni(1) 0 0 Ni(2) 0 0 Ni(3) 0 0 Ni(4) 0 0 Ni(5) 0 0 Ni(6) 0 0 Ni(7) 0 0 Ni(8) 0 0;
    0 Ni(1) 0 0 Ni(2) 0 0 Ni(3) 0 0 Ni(4) 0 0 Ni(5) 0 0 Ni(6) 0 0 Ni(7) 0 0 Ni(8) 0 ;
    0 0 Ni(1) 0 0 Ni(2) 0 0 Ni(3) 0 0 Ni(4) 0 0 Ni(5) 0 0 Ni(6) 0 0 Ni(7) 0 0 Ni(8)];

% delta = [u1 v1 ]';
% delta = []';
u = zeros(1,8);
for idx=1:8
    u(idx) = N(idx) * p(idx);
end

dN_dx = [...
        -1/(4*lx)*(1-2*y/ly)*(1-2*z/lz) 
        1/(4*lx)*(1-2*y/ly)*(1-2*z/lz)
        1/(4*lx)*(1+2*y/ly)*(1-2*z/lz)
        -1/(4*lx)*(1+2*y/ly)*(1+2*z/lz)
        -1/(4*lx)*(1-2*y/ly)*(1+2*z/lz)
        1/(4*lx)*(1-2*y/ly)*(1+2*z/lz)
        1/(4*lx)*(1+2*y/ly)*(1+2*z/lz)
        -1/(4*lx)*(1+2*y/ly)*(1+2*z/lz)];
dN_dy = [...
        -1/(4*ly)*(1-2*x/lx)*(1-2*z/lz) 
        -1/(4*ly)*(1+2*x/lx)*(1-2*z/lz)
        1/(4*ly)*(1+2*x/lx)*(1-2*z/lz)
        1/(4*ly)*(1-2*x/lx)*(1-2*z/lz)
        -1/(4*ly)*(1-2*x/lx)*(1+2*z/lz)
        -1/(4*ly)*(1+2*x/lx)*(1+2*z/lz)
        1/(4*ly)*(1+2*x/lx)*(1+2*z/lz)
        1/(4*ly)*(1-2*x/lx)*(1+2*z/lz)];
dN_dz = [...
        -1/(4*lz)*(1-2*x/lx)*(1-2*y/ly) 
        -1/(4*lz)*(1+2*x/lx)*(1-2*y/ly)
        -1/(4*lz)*(1+2*x/lx)*(1+2*y/ly)
        -1/(4*lz)*(1-2*x/lx)*(1+2*y/ly)
        1/(4*lz)*(1-2*x/lx)*(1-2*y/ly)
        1/(4*lz)*(1+2*x/lx)*(1-2*y/ly)
        1/(4*lz)*(1+2*x/lx)*(1+2*y/ly)
        1/(4*lz)*(1-2*x/lx)*(1+2*y/ly)];

B = zeros(1,8);
for idx=1:8
    B(i) = [...
    dN_dx(i) 0 0 
    0 dN_dy(i) 0
    0 0 dN_dz(i)
    dN_dy(i) dN_dx(i) 0
    0 dN_dz(i) dN_dy(i)
    dN_dz(i) 0 dN_dx(i)];
end

E = 400*10e6 %[Pa]
v = 0.3;
D = E*(1-v)/((1+v)*(1-2*v))* [...
    1 v/(1-v) v/(1-v) 0 0 0
    v/(1-v) 1 v/(1-v) 0 0 0
    v/(1-v) v/(1-v) 1 0 0 0
    0 0 0 (1-2*v)/(2*(1-v)) 0 0
    0 0 0 0 (1-2*v)/(2*(1-v)) 0 
    0 0 0 0 0 (1-2*v)/(2*(1-v))];


     














end