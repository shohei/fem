function [F,Kc]=set_boundary_condition(dof_total,K,Um,U,F)

% Kc = zeros(dof_total,dof_total);
% for r=1:dof_total
%    for c=1:dof_total
%       Kc(r,c) = K(r,c); 
%    end
% end

Kc = K;

for r=1:dof_total
   if Um(r)==true
      for rr=1:dof_total
         if rr ~= r            
            F(rr) = F(rr) - Kc(rr,r) * U(r);
         end          
      end
      
      for rr=1:dof_total
         Kc(rr,r) = 0; 
      end
       
      for cc=1:dof_total
         Kc(r,cc) = 0; 
      end
      Kc(r,r) = 1;
      F(r) = U(r);
      Kc
   end    
end
K
Kc
end