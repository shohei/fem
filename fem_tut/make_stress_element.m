function stress_element=make_stress_element(elements,components,strain_element,D)

stress_element = zeros(elements,components);
for e=1:elements
   for r=1:components
      for c=1:components
         stress_element(e,r) = stress_element(e,r) ...
             + D(r,c) * strain_element(e,c);
      end
   end
end


end