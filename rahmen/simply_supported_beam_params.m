function simply_supported_beam_params

nodes = [
 0.0,0.0;    
 0.5,0.0;
 1.0,0.0
];

elems = [
  1,2,1.0,1.0,1.0
  2,3,1.0,1.0,1.0
];

bounds = [
  1,1,0,1,0,0,0;
  3,0,0,1,0,0,0;
];


loads = [
  2,0.0,-1.0,0.0
];

save simply_beam;

end