function [y] = second_deriv(x)
  x2 = x .^ 2;
  y = (6 .* cos(1 ./ x2) .* x2 - 4 .* sin(1 ./ x2)) ./ (x2 .^ 3);

  y = - abs(y);
end
