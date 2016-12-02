function strain_element=make_strain_element(elements,nodes_tria3,...
    connectivity,B,dof_tria3,components,U)
Ue = zeros(dof_tria3,1);

strain_element = zeros(elements,components);
for e=1:elements
   for n=1:nodes_tria3
      Ue(n*2-1) = U(connectivity(e,n)*2-1);
      Ue(n*2) = U(connectivity(e,n)*2);      
   end
   
   for r=1:components
       for c=1:dof_tria3
           strain_element(e,r) = strain_element(e,r) + B(e,r,c) * Ue(c);
       end
   end   
end

end