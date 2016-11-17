function create_bit_sequence

v = {};
for idx=1:256
    sequence =  dec2bin(idx,8);
    ruleStr = sprintf('Rule: %d',idx);
    ruleStr
    for jdx=1:8
       v(:,idx) = cellstr(sequence(jdx));       
    end
    v
end


end