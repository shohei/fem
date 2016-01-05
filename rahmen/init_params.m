function init_params

nodes = [
 0.0,0.0;    
 1.0,0.0;
];

elems = [
  1,2,1.0,1.0,1.0;    
];

bounds = [
  1,1,0,1,0,1,1;
];


loads = [
  2,0.0,-1.0,0.0
];

save model_data;

end