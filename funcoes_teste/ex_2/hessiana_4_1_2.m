function h = hessiana_4_1_2(x)
    x1 = x(1); x2 = x(2);
    h = [
        2400*x1^2 - 800*x2 + 2      -800*x1
        -800*x1                     400
    ];
end
