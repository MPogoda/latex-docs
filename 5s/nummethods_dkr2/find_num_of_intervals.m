function [n] = find_num_of_intervals(snd_deriv_func, a, b, max_error)
  h = (b - a) / 1000;
  M2 = max(abs(feval(snd_deriv_func, [a:h:b])));
  n = ceil(sqrt(((b - a)^3) * M2 / (12 * max_error)));
end
