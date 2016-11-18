function wolfram1d_2
clear all;
close all;

CAsize = 100;

[X,Y] = meshgrid(1,CAsize+1);

k = {'111','110','101','100','011','010','001','000'};
%  v = {'1','0','1','0','0','1','0','1'}; %165

%   writerObj = VideoWriter('newfile.avi');
%   open(writerObj);

v = {};
 for rule=1:256
    figure(1);
    gcf();
    clf();
    hold on;
    plot(X,Y,'k');
    plot(Y,X,'k');
    I = zeros(CAsize+1);
    surface(I);
    colormap(gray);
    axis off;
    
    origin = zeros(1,CAsize);
    origin(CAsize/2) = 1;
    
    I(CAsize,:) = horzcat(origin,0);
    surface(I);

    sequence =  dec2bin(rule,8);
    for jdx=1:8
       v(rule,jdx) = cellstr(sequence(jdx));       
    end
    lookup_table = containers.Map(k,v(rule,:));
    extended_origin = horzcat(origin(CAsize),origin,origin(1));

    for time=2:CAsize
        next = [];
        for idx=1:CAsize
            key = '';
            key(1) = int2str(extended_origin(idx));
            key(2) = int2str(extended_origin(idx+1));
            key(3) = int2str(extended_origin(idx+2));
            next(end+1) = str2num(lookup_table(key));
        end
        I(CAsize-time+1,:) = horzcat(next,0);
        extended_origin = horzcat(next(CAsize),next,next(1));
    end  
    
    surface(I);
    ruleStr = sprintf('Rule: %d',rule);
    ylim=get(gca,'YLim');
    xlim=get(gca,'XLim');
    text(xlim(2)*0.05,ylim(2)*0.85,ruleStr,'VerticalAlignment','bottom','HorizontalAlignment','left');      
   drawnow();
   
%    frame = getframe(gcf);   
%    for second=1:50 % default 30 fps
%        writeVideo(writerObj, frame);
%    end
   
 end

%   close(writerObj);
 
 
end