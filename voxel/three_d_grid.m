function three_d_grid

clf
figure(1)
for g = 0:.2:2
    for i = 0:.2:2
        
        plot3([g g], [0 2], [i, i],'r')
        hold on
    end
end

for g = 0:.2:2
    for i = 0:.2:2
        
        plot3([0 2], [g g], [i, i],'g')
        hold on
    end
end

for g = 0:.2:2
    for i = 0:.2:2
        
        plot3([i i], [g g], [0 2],'b')
        hold on
    end
end

end