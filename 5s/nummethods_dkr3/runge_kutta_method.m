function [y] = runge_kutta_method(func, x, y_a)
  m = length(x);
  h = mean(diff(x));
  y = y_a .* ones(m, 1);
  for i = 2:m
    k1 = h * func(x(i - 1), y(i - 1));
    k2 = h * func(x(i - 1) + (h / 2), y(i - 1) + (k1 / 2));
    k3 = h * func(x(i - 1) + (h / 2), y(i - 1) + (k2 / 2));
    k4 = h * func(x(i - 1) + h, y(i - 1) + k3);

    y(i:end) += (1 / 6) * (k1 + 2 * k2 + 2 * k3 + k4);
  end
end
