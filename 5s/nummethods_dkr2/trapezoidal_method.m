function [answer] = trapezoidal_method(funcname, sndderivname, a, b, max_error)
  n = find_num_of_intervals(sndderivname, a, b, max_error / 2);

  h = (b - a) / n;
  X = [a:h:b];
  Y = funcname(X);

  answer = h * ((Y(1) + Y(end) / 2) + sum(Y(2:end-1)));
end
