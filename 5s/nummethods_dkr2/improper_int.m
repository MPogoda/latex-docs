function [answer] = improper_int(func, a)
  b = -log(0.0005)
  answer = gaussian_method(func, a, b, 0.001);
end
