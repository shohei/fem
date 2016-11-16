function mesh_gen
clear all; close all;
format compact;

global bpoints; global concats; global domains; global materials;
global npts; global ndom; global ncats;

params_tri;
load grid_data;

npts = size(bpoints,1);
ncats = size(concats,1);
ndom = size(domains,1);

hold on;
for idx=1:ncats
   x1=bpoints(idx,1);
   y1=bpoints(idx,2)
   x2=bpoints(idx+1,1)
   y2=bpoints(idx+1,2)
   plot([x1],[y1]);       
end




end