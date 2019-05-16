function g = gradient_4_1_1(x)
    g = [
        2*x(1) - 40*x(1)*(- x(1)^2 + x(2)) - 2
        -20*x(1)^2 + 20*x(2)
    ];
end
