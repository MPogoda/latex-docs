function [y] = euler_cauchy_method(func, x, y_a)
  m = length(x);
  h = mean(diff(x));
  y = y_a .* ones(m, 1);
  for i = 2:m
    _y = y(i - 1) + h * func(x(i - 1), y(i - 1));
    y(i:end) += (h / 2) * (func(x(i - 1), y(i - 1)) + func(x(i), _y));
  end
end
