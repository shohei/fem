function totalk



ll(1)=2*i-1;
ll(2)=2*i;
ll(3)=2*j-1;
ll(4)=2*j;

for ie=1:4
   it=ll(ie);
   for je=1:4
    jt=ll(je);
    tk(it,jt)=tk(it,jt)+ek(ie,je);
    end
end


end