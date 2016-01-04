function solid_truss
close all; clear all;
init_params2();
format shortG;
global nodes; global elems; global bounds; global loads;
load model_data2;
np = size(nodes,1);
ne = size(elems,1);
nb = size(bounds,1);
nf = size(loads,1);
global Tk;
Tk=zeros(np*3);
hold on;
axis equal;
drawTruss();
xmax=max(nodes(:,1));
xmin=min(nodes(:,1));
ymax=max(nodes(:,2));
ymin=min(nodes(:,2));
zmax=max(nodes(:,3));
zmin=min(nodes(:,3));
axis([xmin-1 xmax+1 ymin-1 ymax+1 zmin-1 zmax+1]);
view([14 -10 6]);
% drawWall(ymin,ymax,zmin,zmax);
computeTotalStiffness();
global F;
F=zeros(np*3,1);
loadForce();
loadBoundaryCondition();
u = Tk\F;
F
u
drawDisplacedTruss();

    function drawTruss()
        for index=1:ne
            start = elems(index,1);
            stop = elems(index,2);
            h=plot3([nodes(start,1),nodes(stop,1)],...
                [nodes(start,2),nodes(stop,2)],...
                [nodes(start,3),nodes(stop,3)],'b-');
%             set(h,'LineWidth',4);
        end
    end

    function drawWall(ymin,ymax,zmin,zmax)
        patch([0 0 0 0],[ymin-1 ymax+1 ymax+1 ymin-1],...
            [zmin-1 zmin-1 zmax+1 zmax+1],'w');
    end

    function K=computeElementStiffness(index)
        start=elems(index,1);
        stop=elems(index,2);
        startX=nodes(start,1);
        startY=nodes(start,2);
        startZ=nodes(start,3);
        stopX=nodes(stop,1);
        stopY=nodes(stop,2);
        stopZ=nodes(stop,3);
        L=sqrt((startX-stopX)^2+(startY-stopY)^2+(startZ-stopZ)^2);
        l=(stopX-startX)/L;
        m=(stopY-startY)/L;
        n=(stopZ-startZ)/L;
        E=elems(index,3);
        A=elems(index,4);
        k=A*E/L;
        K = k * ...
            [ l^2 l*m l*n -l^2 -l*m -l*n
            l*m m^2 m*n -l*m -m^2 -m*n
            l*n m*n n^2 -l*n -m*n -n^2
            -l^2 -l*m -l*n l^2 l*m l*n
            -l*m -m^2 -m*n l*m m^2 m*n
            -l*n -m*n -n^2 l*n m*n n^2];
    end

    function computeTotalStiffness()
        for idx=1:ne
            K=computeElementStiffness(idx);
            ie=elems(idx,1);
            je=elems(idx,2);
            ll=[3*ie-2 3*ie-1 3*ie 3*je-2 3*je-1 3*je];
            for it=1:6
                for jt=1:6
                    Tk(ll(it),ll(jt)) = Tk(ll(it),ll(jt)) + K(it,jt);
                end
            end
        end
        
    end

    function loadForce()
        for index=1:nf
            fIndex=loads(index,1);
            fLoadX=loads(index,2);
            fLoadY=loads(index,3);
            fLoadZ=loads(index,4);
            fIndex_X=fIndex*3-2;
            fIndex_Y=fIndex*3-1;
            fIndex_Z=fIndex*3;
            F(fIndex_X) = fLoadX;
            F(fIndex_Y) = fLoadY;
            F(fIndex_Z) = fLoadZ;
        end
    end

    function loadBoundaryCondition()
        for index=1:nb
            nIndex=bounds(index,1);
            nXfix=bounds(index,2);
            nYfix=bounds(index,3);
            nZfix=bounds(index,4);
            if nXfix==1
                bidx=3*nIndex-2;
                processBoundaryCondition(bidx);
            end
            if nYfix==1
                bidx=3*nIndex-1;
                processBoundaryCondition(bidx);
            end
            if nZfix==1
                bidx=3*nIndex;
                processBoundaryCondition(bidx);
            end
        end
    end

    function processBoundaryCondition(idx)
        Tk(idx,:)=0;
        Tk(:,idx)=0;
        Tk(idx,idx)=1;
        F(idx)=0;
    end

    function drawDisplacedTruss()
        for index=1:ne
            start = elems(index,1);
            startX = nodes(start,1) + u(3*start-2);
            startY = nodes(start,2) + u(3*start-1);
            startZ = nodes(start,3) + u(3*start);
            stop = elems(index,2);
            stopX = nodes(stop,1) + u(3*stop-2);
            stopY = nodes(stop,2) + u(3*stop-1);
            stopZ = nodes(stop,3) + u(3*stop);
            h=plot3([startX,stopX],...
                [startY,stopY],...
                [startZ,stopZ],'r--');
%             set(h,'LineWidth',4);
        end
    end


end
