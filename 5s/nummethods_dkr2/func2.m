function [y] = func2(x)
  y = (e .^ (-(x .^ 2))) ./ sqrt(2 - cos(x));
end
