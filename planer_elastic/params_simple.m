function params_simple

nodes = [
    0.0,0.0
    100.0,0.0
    0.0,100.0
    100.0,100.0
    ];

material =[
    206.0e3, 0.3, 2.0
    ];

elems = [
   1,2,3,1
   2,4,3,1
];

bounds = [
    1,1,0.0,1,0.0
    3,1,0.0,0,0.0
];

loads = [
    2,196000.0,0.0
    4,196000.0,0.0
];

save simpledata;

end