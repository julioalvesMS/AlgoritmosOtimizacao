function y = function_4_1_4(x)
    A = [
        1   1   1   1
        1   3   3   3
        1   3   5   5
        1   3   5   7
    ];
    
    b = [10  28  42  50];

    y = 0.5*x'*A*x - b*x;
end
