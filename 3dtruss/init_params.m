function init_params

nodes = [
  0.0, 0.0, 0.0
  0.0, 3.0, 0.0
  12.0, 3.0, 0.0
  0.0, 0.0, 4.0
];

elems = [
  1, 3, 2e9, 1e-4,
  3, 4, 2e9, 1e-4, 
  2, 3, 2e9, 1e-4
];

bounds = [
  1, 1, 1, 1;    
  2, 1, 1, 1;
  4, 1, 1, 1;
];

loads = [
  3, 0.0, 4e2, -5e2
];

save model_data;

end