function init_params2

nodes = [
    2.54, 3.49, 5.08
    2.54, 1.58, 5.08
    3.50, 3.49, 2.54
    3.50, 1.58, 2.54
    1.59, 1.58, 2.54
    1.59, 3.49, 2.54
    5.08, 5.08, 0.0
    5.08, 0.0, 0.0
    0.0, 0.0, 0.0
    0.0, 5.08, 0.0
    ];

elems = [
    1, 2, 2e9, 1e-4
    1, 4, 2e9, 1e-4
    2, 3, 2e9, 1e-4
    1, 5, 2e9, 1e-4
    2, 6, 2e9, 1e-4
    2, 4, 2e9, 1e-4
    2, 5, 2e9, 1e-4
    1, 3, 2e9, 1e-4
    1, 6, 2e9, 1e-4
    3, 6, 2e9, 1e-4
    3, 4, 2e9, 1e-4
    4, 5, 2e9, 1e-4
    5, 6, 2e9, 1e-4
    3, 10, 2e9, 1e-4
    6, 7, 2e9, 1e-4
    4, 7, 2e9, 1e-4
    3, 8, 2e9, 1e-4
    5, 8, 2e9, 1e-4
    4, 9 2e9, 1e-4
    6, 9, 2e9, 1e-4
    5, 10, 2e9, 1e-4
    6, 10, 2e9, 1e-4
    3, 7, 2e9, 1e-4
    4, 8, 2e9, 1e-4
    5, 9, 2e9, 1e-4
    ];

bounds = [
    7, 1, 1, 1;
    8, 1, 1, 1;
    9, 1, 1, 1;
    10,1, 1, 1;
    ];

loads = [
    1, 1e4, 0, 0
    2, 0.0, -1e4, 0
    ];

save model_data2;


end