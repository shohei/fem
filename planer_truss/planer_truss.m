function planer_truss
clear all;
close all;
global np;global ne;global nb;global nf;
global nodes;global elems;
global cnsts;global loads;
load exp1;
eks = {};
K = zeros(np*2);
F = zeros(np*2,1);
u = zeros(np*2,1);
computeLocalStiffnessMatrix();
computeTotalStiffnessMatrix();
loadBoundaryCondition();
loadForce();
u = K\F;
fprintf('[computed displacement]\n');
u
draw_truss();
draw_displaced_truss();

    function computeLocalStiffnessMatrix()
        for idx=1:ne
            n1=elems(idx,2);
            n2=elems(idx,3);
            n1x=nodes(n1,2);
            n1y=nodes(n1,3);
            n2x=nodes(n2,2);
            n2y=nodes(n2,3);
            z = (n2x-n1x) + (n2y-n1y) * i;
            theta = angle(z);
            deg = theta*180/pi;
            c = cos(theta);
            s = sin(theta);
            l = abs(z);
            A = elems(idx,4);
            E = elems(idx,5);
            k = A*E/l;
            ek = k * [
                c^2 c*s -c^2 -c*s
                c*s s^2 -c*s -s^2
                -c^2 -c*s c^2 c*s
                -c*s -s^2 c*s s^2
                ];
            eks = [eks;  {n1,n2, ek}];
        end
    end

    function computeTotalStiffnessMatrix()
        for idx=1:ne
            it = double(cell2mat(eks(idx,1)));
            jt = double(cell2mat(eks(idx,2)));
            ek = cell2mat(eks(idx,3));
            
            ll = [2*it-1,2*it,2*jt-1,2*jt];
            for ie=1:4
                for je=1:4
                    K(ll(ie),ll(je)) = K(ll(ie),ll(je)) + ek(ie,je);
                end
            end
        end
    end

    function loadBoundaryCondition()
        count = size(cnsts,1);
        for i=1:count
            idx = cnsts(i,1);
            xidx = 2*idx;
            yidx = 2*idx-1;
            isXConstrained = cnsts(i,2);
            isYConstrained = cnsts(i,3);
            
            if(isXConstrained==1)
                K(xidx,:) = 0;
                K(:,xidx) = 0;
                K(xidx,xidx) = 1;
            end
            
            if(isYConstrained==1)
                K(yidx,:) = 0;
                K(:,yidx) = 0;
                K(yidx,yidx) = 1;
            end
        end
    end

    function loadForce()
        count = size(loads,1);
        for idx=1:count
            fidx = loads(idx,1);
            F(2*fidx-1) = loads(idx,2);
            F(2*fidx) = loads(idx,3);
        end
    end

    function draw_truss()
        count = size(elems,1);
        for i=1:count
            n1=elems(i,2);
            n2=elems(i,3);
            n1x=nodes(n1,2);
            n1y=nodes(n1,3);
            n2x=nodes(n2,2);
            n2y=nodes(n2,3);
            plot([n1x,n2x],[n1y,n2y],'b-');
            hold on;
        end
    end

    function draw_displaced_truss()
        count = size(elems,1);
        for i=1:count
            n1=elems(i,2);
            n2=elems(i,3);
            n1x=nodes(n1,2)+u(2*n1-1);
            n1y=nodes(n1,3)+u(2*n1);
            n2x=nodes(n2,2)+u(2*n2-1);
            n2y=nodes(n2,3)+u(2*n2);
            plot([n1x,n2x],[n1y,n2y],'r--');
            hold on;
        end
    end

end