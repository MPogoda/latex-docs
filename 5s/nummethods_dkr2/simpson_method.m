function [answer] = simpson_method(func, a, b, max_error)
  n = 1;
  I_old = NaN;
  while (1)
    h = (b - a) / n;
    X = [a:h:b];
    Y = func(X);
    Yv = func((X(1:end-1) + X(2:end)) ./ 2);
    I_current = (h / 3) * ((Y(1) + Y(end)) / 2 + sum(Y(2:end-1)) + 2 * sum(Yv));
    if (2 * abs(I_old - I_current) / 15) < max_error
      break;
    end
    I_old = I_current;
    n *= 2;
  end
  n
  answer = I_current;
end
