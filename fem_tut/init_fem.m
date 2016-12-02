function [nodes,elements,components,...
    nodes_tria3,dof_node,dof_total,...
    dof_tria3,thickness,young,...
    poisson,x,y,connectivity,Um,U,F]=init_fem

    nodes = 6;
    elements = 4;
    components = 3;
    nodes_tria3 = 3;
    dof_node = 2;
    dof_total = dof_node*nodes;
    dof_tria3 = dof_node*nodes_tria3;
    thickness = 1;
    young = 2.1e5;
    poisson = 0.3;

    x = [0,1,2,2,1,0];
    y = [0,0,0,1,1,1];

    connectivity = zeros(elements,nodes_tria3);
    connectivity(1,1) = 1;
    connectivity(1,2) = 2;
    connectivity(1,3) = 5;
    connectivity(2,1) = 2;
    connectivity(2,2) = 3;
    connectivity(2,3) = 4;
    connectivity(3,1) = 2;
    connectivity(3,2) = 4;
    connectivity(3,3) = 5;
    connectivity(4,1) = 1;
    connectivity(4,2) = 5;
    connectivity(4,3) = 6;
    
    Um = [true,true,false,false,false,...
          false,false,false,false,false,...
          true,false]';
      
    U = zeros(12,1);    

    F = [0,0,0,0,0,...
        0,0,-100,0,0,...
        0,0]';
end