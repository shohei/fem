function wolfram1d_2
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

origin = zeros(1,CAsize);
% for idx=1:CAsize
%     origin(end+1) = (rand>0.5);
% end
origin(CAsize/2) = 1;
origin

I(CAsize,:) = horzcat(origin,0);
surface(I);

k = {'000','001','010','011','100','101','110','111'};
v = {'0','1','1','0','1','1','0','1'};

lookup_table = containers.Map(k,v);

extended_origin = horzcat(origin(CAsize),origin,origin(1));

writerObj = VideoWriter('newfile.avi');
open(writerObj);

for time=2:CAsize
    
    next = [];
    for idx=1:CAsize
        key = '';
        %convert to string
        key(1) = int2str(extended_origin(idx));
        key(2) = int2str(extended_origin(idx+1));
        key(3) = int2str(extended_origin(idx+2));        
        next(end+1) = str2num(lookup_table(key));
    end
    next
    I(CAsize-time+1,:) = horzcat(next,0);
    surface(I);
    drawnow();
    
     frame = getframe(gcf);
     writeVideo(writerObj, frame);
   
    pause(0.1);

    extended_origin = horzcat(next(CAsize),next,next(1));
    
end

 close(writerObj);

end