function rahmen

clear all; close all;
format shortG;
global nodes; global elems; global bounds; global loads;
global np; global ne; global nb; global nf;
% init_params();
% load model_data;
simply_supported_beam_params();
load simply_beam;

np=size(nodes,1);
ne=size(elems,1);
nb=size(bounds,1);
nf=size(loads,1);
global Tk;
Tk=zeros(np*3);
hold on;
drawRahmen();
computeTotalStiffness();
global F; F = zeros(np*3,1);
loadForce();
loadBoundaryCondition();
Tk
u=Tk\F;
u
drawDisplacedRahmen();
ylim([-1 1]);

    function drawRahmen()
        for idx=1:ne
            start=elems(idx,1);
            stop=elems(idx,2);
            startX=nodes(start,1);
            startY=nodes(start,2);
            stopX=nodes(stop,1);
            stopY=nodes(stop,2);
            plot([startX,stopX],[startY,stopY],'b-');
        end
    end

    function K=computeElementStiffness(eIndex)
        E = elems(eIndex,3);
        A = elems(eIndex,4);
        I = elems(eIndex,5);
        start=elems(eIndex,1);
        stop=elems(eIndex,2);
        startX=nodes(start,1);
        stopX=nodes(stop,1);
        startY=nodes(start,2);
        stopY=nodes(stop,2);
        l = sqrt((stopX-startX)^2+(stopY-startY)^2);
        theta = angle((stopX-startX)+i*(stopY-startY));
        k1=A*E/l;
        k2=12*E*I/l^3;
        k3=6*E*I/l^2;
        k4=4*E*I/l;
        k5=2*E*I/l;
        c=cos(theta);
        s=sin(theta);
        K = [
            k1*c^2+k2*s^2 (k1-k2)*c*s -k3*s -k1*c^2-k2*s^2 (-k1+k2)*c*s -k3*s
            (k1-k2)*c*s k1*s^2+k2*c^2 k3*c (-k1+k2)*c*s -k1*s^2-k2*c^2 k3*c
            -k3*s k3*c k4 k3*s -k3*c k5
            -k1*c^2-k2*s^2 (-k1+k2)*c*s k3*s k1*c^2+k2*s^2 (k1-k2)*c*s k3*s
            (-k1+k2)*c*s -k1*s^2-k2*c^2 -k3*c (k1-k2)*c*s k1*s^2+k2*c^2 -k3*c
            -k3*s k3*c k5 k3*s -k3*c k4
            ];
        %         K = [
        %             A*E/l 0 0 -A*E/l 0 0
        %             0 12*E*I/l^3 6*E*I/l^2 0 -12*E*I/l^3 6*E*I/l^2
        %             0 6*E*I/l^2 4*E*I/l 0 -6*E*I/l^2 2*E*I/l
        %             -A*E/l 0 0 A*E/l 0 0
        %             0 -12*E*I/l^3 -6*E*I/l^2 0 12*E*I/l^3 -6*E*I/l^2
        %             0 6*E*I/l^2 2*E*I/l 0 -6*E*I/l^2 4*E*I/l
        %             ];
    end

    function computeTotalStiffness()
        for eIndex=1:ne
            ii=elems(eIndex,1);
            jj=elems(eIndex,2);
            ll=[3*ii-2 3*ii-1 3*ii 3*jj-2 3*jj-1 3*jj];
            K = computeElementStiffness(eIndex);
            for it=1:6
                for jt=1:6
                    Tk(ll(it),ll(jt)) = Tk(ll(it),ll(jt)) + K(it,jt);
                end
            end
        end
    end

    function loadForce()
        for idx=1:nf
            fIdx = loads(idx,1);
            F(3*fIdx-2) = loads(idx,2);
            F(3*fIdx-1) = loads(idx,3);
            F(3*fIdx) = loads(idx,4);
        end
    end

    function loadBoundaryCondition()
        for idx=1:nb
            nIndex = bounds(idx,1);
            isXFix=bounds(idx,2);
            xFix=bounds(idx,3);
            isYFix=bounds(idx,4);
            yFix=bounds(idx,5);
            isThetaFix=bounds(idx,6);
            lambda = bounds(idx,7);
            
            if(isXFix==1)
                bidx=3*nIndex-2;
                processBoundaryCondition(bidx);
            end
            if(isYFix==1)
                bidx=3*nIndex-1;
                processBoundaryCondition(bidx);
            end
            if(isThetaFix==1)
                bidx=3*nIndex;
                processSemiRigidCondition(bidx,lambda);
            end
        end
    end

    function processBoundaryCondition(idx)
        Tk(idx,:) = 0;
        Tk(:,idx) = 0;
        Tk(idx,idx) = 1;
    end

    function processSemiRigidCondition(idx,lambda)
        Tk(idx,:) = 0;
        Tk(:,idx) = 0;
        Tk(idx,idx) = 1;
    end

    function drawDisplacedRahmen()
        for idx=1:ne
            start=elems(idx,1);
            stop=elems(idx,2);
            startX=nodes(start,1)+u(3*start-2);
            startY=nodes(start,2)+u(3*start-1);
            stopX=nodes(stop,1)+u(3*stop-2);
            stopY=nodes(stop,2)+u(3*stop-1);
            plot([startX,stopX],[startY,stopY],'r--');
        end
    end



end