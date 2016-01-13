function simple_elastic
clear all; close all;
format compact;
global np, global ne; global nf; global nb;
global nodes; global elems; global loads; global bounds;
global material;

params_simple;
load simpledata;

np = size(nodes,1);
ne = size(elems,1);
nb = size(bounds,1);
nf = size(loads,1);

hold on;
drawPlane();
global Tk; Tk = zeros(np*2,np*2);
makeTk();
loadBoundaryCondition();
global f; f = zeros(np*2,1);
loadForce();
Tk
f
u=Tk\f;
u
drawDisplacedPlane();
% computeStress();

    function drawPlane()
        for idx=1:ne
            start = elems(idx,1);
            middle = elems(idx,2);
            stop = elems(idx,3);
            startX=nodes(start,1);
            startY=nodes(start,2);
            middleX=nodes(middle,1);
            middleY=nodes(middle,2);
            stopX=nodes(stop,1);
            stopY=nodes(stop,2);
            plot([startX middleX],[startY middleY],'b-');
            plot([middleX stopX],[middleY stopY],'b-');
            plot([stopX startX],[stopY startY],'b-');
        end
    end

    function A=makeA(start,middle,stop)
        startX=nodes(start,1);
        startY=nodes(start,2);
        middleX=nodes(middle,1);
        middleY=nodes(middle,2);
        stopX=nodes(stop,1);
        stopY=nodes(stop,2);
        A = 1/2*det([
            1 startX  startY
            1 middleX middleY
            1 stopX   stopY
            ]);
    end

    function K=computeStiffness(start,middle,stop,material_idx)
        t = material(material_idx,3);
        A = makeA(start,middle,stop);        
        E = material(material_idx,1);
        v = material(material_idx,2);
        startX=nodes(start,1);
        startY=nodes(start,2);
        middleX=nodes(middle,1);
        middleY=nodes(middle,2);
        stopX=nodes(stop,1);
        stopY=nodes(stop,2);        
        D = E/(1-v^2)*[
                1 v 0
                v 1 0
                0 0 (1-v)/2
        ];
        B = 1/(2*A) * [
            middleY-stopY       0       stopY-startY       0      startY-middleY      0    
                  0       stopX-middleX       0      startX-stopX        0       middleX-startX
            stopX-middleX middleY-stopY startX-stopX stopY-startY middleX-startX startY-middleY
        ];
        K = A*t*B'*D*B;
    end


    function makeTk()
        for idx=1:ne
            start  = elems(idx,1);
            middle = elems(idx,2);
            stop   = elems(idx,3);
            material_idx = elems(idx,4);
            K=computeStiffness(start,middle,stop,material_idx);            
            ll=[2*start-1 2*start 2*middle-1 2*middle 2*stop-1 2*stop];
            for ie=1:6
                for je=1:6
                    Tk(ll(ie),ll(je)) = Tk(ll(ie),ll(je)) + K(ie,je);
                end
            end
        end
    end

    function loadBoundaryCondition()
        for idx=1:nb
            node_idx = bounds(idx,1);
            xFix = bounds(idx,2);
            xFixIdx = 2*node_idx - 1;
            yFix = bounds(idx,4);
            yFixIdx = 2*node_idx;
            if(xFix==1)
                Tk(xFixIdx,:) = 0;
                Tk(:,xFixIdx) = 0;
                Tk(xFixIdx,xFixIdx) = 1;
            end
            if(yFix==1)
                Tk(yFixIdx,:) = 0;
                Tk(:,yFixIdx) = 0;
                Tk(yFixIdx,yFixIdx) = 1;
            end
        end
    end

    function loadForce()
          for idx=1:nf
             node_idx = loads(idx,1);
             xIdx = 2*node_idx;
             xForce = loads(idx,2);
             yIdx = 2*node_idx-1;
             yForce = loads(idx,3);
             f(xIdx) = xForce;
             f(yIdx) = yForce;
          end
    end


    function drawDisplacedPlane()
        nodes_dash = nodes;
        for idx=1:np            
            xidx = 2*idx-1;
            yidx = 2*idx;
            xmove = u(xidx);
            ymove = u(yidx);
            nodes_dash(idx,1) = nodes_dash(idx,1) + xmove;
            nodes_dash(idx,2) = nodes_dash(idx,2) + ymove;
        end        
        
        for idx=1:ne
            start = elems(idx,1);
            middle = elems(idx,2);
            stop = elems(idx,3);
            startX=nodes_dash(start,1);
            startY=nodes_dash(start,2);
            middleX=nodes_dash(middle,1);
            middleY=nodes_dash(middle,2);
            stopX=nodes_dash(stop,1);
            stopY=nodes_dash(stop,2);                                    
            plot([startX middleX],[startY middleY],'r--');
            plot([middleX stopX],[middleY stopY],'r--');
            plot([stopX startX],[stopY startY],'r--');
        end                   
    end

end