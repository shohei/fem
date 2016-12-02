function Fr=make_reaction(K,U,dof_total);

Fr = zeros(dof_total,1);

for r=1:dof_total
   Fr(r) = 0;
   for c=1:dof_total
      Fr(r) = Fr(r) + K(r,c) * U(c); 
   end
end

end