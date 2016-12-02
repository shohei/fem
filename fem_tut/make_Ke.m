function Ke=make_Ke(components,elements,dof_tria3,D,B,thickness,area_element)

% Dt= zeros(components,components);
Dt = D';
Bt= zeros(dof_tria3,components);
% Bt= B';
BtDt= zeros(dof_tria3,components);
% BtDt = Bt*Dt;

% for r=1:components
%    for c=1:components
%       Dt(c,r) = D(r,c); 
%    end
% end

for e=1:elements
   for r=1:components
      for c=1:dof_tria3
          Bt(c,r) = B(e,r,c);
      end
   end
end

for r=1:dof_tria3
   for c=1:components
      BtDt(r,c) = 0;
      for m=1:components
          BtDt(r,c) = BtDt(r,c) + Bt(r,m) * Dt(m,c);
      end
   end    
end

Ke = zeros(elements,dof_tria3,dof_tria3);
for r=1:dof_tria3
   for c=1:dof_tria3
      for m=1:components
          Ke(e,r,c) = Ke(e,r,c) + BtDt(r,m) * B(e,m,c);
      end
      Ke(e,r,c) = Ke(e,r,c) * area_element(e) * thickness;
   end    
end

end