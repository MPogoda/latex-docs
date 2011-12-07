a = 0;
b = 2;
h = 0.25;
x = [a:h:b]';
y_a = 0;

[y_e] = euler_method(@func, x, y_a);
[real_y] = real_answer(x);

[x y_e real_y abs(real_y .- y_e)]

[y_ec] = euler_cauchy_method(@func, x, y_a);

[x y_ec abs(real_y .- y_ec)]

[y_rk] = runge_kutta_method(@func, x, y_a);
[x y_rk abs(real_y .- y_rk)]
