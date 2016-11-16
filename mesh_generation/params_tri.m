function engrd

bpoints = [
  0.0, 0.0
  10.0, 0.0
  20.0, 0.0
  30.0, 0.0
  40.0, 0.0
  41.52, 7.65
  45.85, 14.14
  52.35, 18.48
  60.0, 20.0
  60.0, 27.5
  60.0, 40.0
  40.0, 40.0
  20.0, 40.0 
  37.0, 23.0
  10.0, 40.0
  0.0, 40.0
  0.0, 20.0
];

concats = [
  1,2,0,0,0
  2,0,0,1,3
  3,0,2,0,0
];

domains = [
  1,1,20,20,13,14,7,8,9,10,11,12
  2,1,20,20,3,4,5,6,7,14,13,8
  3,1,20,10,1,2,3,18,13,15,16,17
];

materials = [
  1,206e8,0.3,1.0  
];

save grid_data;

end