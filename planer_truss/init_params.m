function init_params
np=3;
ne=2;
nb=2;
nf=1;
nodes = [
  1,0,0
  2,0.7071,0.7071
  3,1.4142,0.0
];
elems = [
  1,1,2,1,1
  2,2,3,1,1,
];
cnsts = [
  1,1,1
  3,1,1
];
loads = [
  2,0.86603,0.5    
];

save exp1;

end