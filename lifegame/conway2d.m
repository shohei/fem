function connway2d
clear all;
close all;

CAsize = 100;

[X,Y] = meshgrid(1,CAsize+1);
figure();
hold on;

plot(X,Y,'k');
plot(Y,X,'k');

I = zeros(CAsize+1);
surface(I);
colormap(gray);
axis off;

I = rand(CAsize+1)>0.85;
I(1,:) = 0;
I(CAsize,:)=0;
I(:,1)=0;
I(:,CAsize)=0;
surface(~I);

simTime=100;

 writerObj = VideoWriter('newfile.avi');
 open(writerObj);

for time=1:simTime
    clf();axis off;
    time
    for y=2:CAsize-1
        for x=2:CAsize-1
            center = I(y,x);
            cells = I(y-1:y+1,x-1:x+1);
            count = sum(cells(:))-center;
            if(count==2&&count==3)
                continue; % keep alive
            elseif(count>=4 || count<=1)
                I(y,x) = 0; % die
            elseif(center==0&&count==3)
                I(y,x) = 1; % resurrect
            end
        end
    end
    surface(~I);
    ruleStr = sprintf('Time: %d',time);
    ylim=get(gca,'YLim');
    xlim=get(gca,'XLim');
    text(xlim(2)*0.05,ylim(2)*0.85,ruleStr,'VerticalAlignment','bottom','HorizontalAlignment','left');      

    drawnow();

    frame = getframe(gcf);
    writeVideo(writerObj, frame);

%      pause(0.05);
end
 close(writerObj);

end