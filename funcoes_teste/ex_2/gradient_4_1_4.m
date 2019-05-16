function g = gradient_4_1_4(x)

    x1 = x(1); x2 = x(2); x3 = x(3); x4 = x(4);
    
    g = [
        x1 + x2 + x3 + x4 - 10
        x1 + 3*x2 + 3*x3 + 3*x4 - 28
        x1 + 3*x2 + 5*x3 + 5*x4 - 42
        x1 + 3*x2 + 5*x3 + 7*x4 - 50
    ];
end
