function [y] = euler_method(func, x, y_a)
  m = length(x);
  h = mean(diff(x));
  y = y_a .* ones(m, 1);
  for i = 2:m
    y(i:end) += h * func(x(i - 1), y(i - 1));
  end
end
