function main_fem()

[nodes,elements,components,nodes_tria3,dof_node,dof_total,...
    dof_tria3,thickness,young,poisson,x,y,connectivity,Um,U,F] = init_fem();
D=make_D(young,poisson);
[B,area_element]=make_B(elements,x,y,connectivity);
Ke=make_Ke(components,elements,dof_tria3,D,B,thickness,area_element);
K=make_K(components,dof_total,elements,connectivity,dof_node,dof_tria3,Ke);
[F,K]=set_boundary_condition(dof_total,K,Um,U,F);
U=solve_fem(K,F);
Fr=make_reaction(K,U,dof_total);
strain_element=make_strain_element(elements,nodes_tria3,connectivity,B,dof_tria3,components,U);
stress_element=make_stress_element(elements,components,strain_element,D);

disp 'finish.';

end
