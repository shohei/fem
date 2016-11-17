function connway2d
clear all;
close all;

CAsize = 30;

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

for time=1:simTime
    time
    for y=2:CAsize-1
        for x=2:CAsize-1
            center = I(y,x);
            cells = I(y-1:y+1,x-1:x+1);
            count = sum(cells(:))-center;
            if(count==2&&count==3)
                % keep alive => do nothing
                disp 'keepalive'
            elseif(count>=4&&count<=1)
                I(y,x) = 0; % die
%                 disp 'die'
            elseif(center==0&&count==3)
                I(y,x) = 1; % resurrect
%                 disp 'resurrect'
            end
        end
    end
    surface(~I);
    drawnow();
end

end