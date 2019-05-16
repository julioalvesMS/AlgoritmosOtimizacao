function g = gradient_4_1_2(x)
    x1 = x(1); x2 = x(2);
    g = [
        2*x1 - 800*x1*(- x1^2 + x2) - 2
        - 400*x1^2 + 400*x2
    ];
end
