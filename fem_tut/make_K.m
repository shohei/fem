function K=make_K(components,dof_total,elements,connectivity,dof_node,dof_tria3,Ke)

K = zeros(dof_total,dof_total);

for rt=1:dof_total
   for ct=1:dof_total 
       K(rt,ct) = 0;
   end
end

for e=1:elements
   for r=1:dof_tria3
      rt = connectivity(e,floor((r+1)/dof_node)) * dof_node - mod(r,dof_node);
      for c=1:components
         ct = connectivity(e,floor((c+1)/dof_node)) * dof_node - mod(c,dof_node);
         K(rt,ct) = K(rt,ct) + Ke(e,r,c);
      end
   end    
end


end