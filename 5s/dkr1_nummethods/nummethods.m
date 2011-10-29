% Aitken interpolation method.
% inputs : x --- vector X_i - X, where X_i -- given points, X -- the x coordinate of the point we are looking for
%          y --- vector f(X_i)
% output : Y --- value f(X) we have to compute
function Y = aitken(x, y)

  n = length(x);
  P = [y zeros(n, n - 1)];

  for k = 1:(n - 1)
    P(1:k, k + 1) = NaN;
    for i = (k + 1):n
      P(i, k + 1) = (P(i - 1, k) * x(i) - P(i, k) * x(i - k)) / (x(i) - x(i - k));
    end
  end

  Y = P(n, n);
end

% Lagrange interpolation method.
% inputs: x --- vector X_i - X (X_i --- given coordinates, X --- x coordinate of point we have to compute
%         y --- vector of given f(X_i)
% output: Y --- f(X).
function Y = la(x, y)
  Y = 0;

  n = length(x);

  for i = 1:n
    l = y(i);
    for j = 1:n
      if (i == j)
        continue;
      end
      l *= x(j) / (x(j) - x(i));
    end
    Y += l;
  end
end

% Choose correct shift so the value x_i < 0 and x_{i+1} >= 0
% Used for correct determination between which points the point we are looking for is located
function i = choose_shift(x)
  n = length(x);

  for i = 1:(n - 1)
    if (x(i + 1) >= 0)
      break;
    end
  end

  if i == n
    i = 1;
  end
end

% Calculate finite differences of given vector f(X_i)
function diffs = calculate_diffs(y)

  m = length(y);
  diffs = [y zeros(m, m-1)];

  for k = 2:m
    for j = 1:(m-k+1)
      diffs(j, k) = diffs(j+1,k-1) - diffs(j,k-1);
    end
    for j = (m-k+2):m
      diffs(j, k) = NaN;
    end
  end
end

% Modification of Newton interpolation method,
% used when the point we are looking for is located approximately
% in the middle of the table.
% Inputs : diffs --- the table of finite differencies up to (n-1)th
%          k --- 'middle' of the table
%          t --- (X - X_0) / (X_1 - X_0)
% Output : Y --- value f(X)
function Y = stirling_formula(diffs, k, t)
  Y = diffs(k, 1);
  T = t;
  for i = 2:k
    z = diffs(k-i+1, i);
    if mod(i, 2)
      z *= t;
    else
      z += diffs(k-i, i);
      z /= 2;
      if (i ~= 2)
        T *= (t^2 - (i/2 - 1)^2);
      end
    end
    T /= i-1;
    z *= T;

    Y += z;
  end
end

% Second Newton interpolation formula
% used if the point we are looking for is located at the end of table
% Input  : diffs --- table of finite differencies up to (n-1)th
%          t = (X - X_{n-1}) / (X_1 - X_0)
% Output : Y = f(X)
function Y = second_newton_formula(diffs, t)
  m = size(diffs, 2);
  Y = diffs(m, 1);
  T = 1;
  for i = 2:m
    T *= (t + (i - 2)) / (i - 1);
    Y += T * diffs(m-i+1,i);
  end
end

% Inputs
% given x coordinates
x = [1.415; 1.420; 1.425; 1.430; 1.435; 1.440; 1.445; 1.450; 1.455; 1.460];
% given y coordinates
y = [0.880; 0.889; 0.890; 0.891; 0.892; 0.893; 0.894; 0.895; 0.896; 0.897];
% number of given coordinates
m = length(x);
% x coordinates of points we wanna compute f(x)
X1 = 1.4167;
X2 = 1.4240;
X3 = 1.4360;
X4 = 1.4610;

% Plot given points as red pluses
plot(x, y, 'r;table;');
xlabel('x');
ylabel('y');
hold;

% Calculate Y1 = f(X1) using Aitken method
Y1 = aitken(x - X1, y);

% Calculate Y2 = f(X2) using lagrange interpolation method
x -= X2;
k = choose_shift(x);        % find shift
x = [x(k:m); x(1:(k - 1))]; % shift vector
Y2old = NaN;                % the value Y2 calculated in previous iteration
for i = 2:m
  Y2 = la(x(1:m), y(1:m), X2);
  if (Y2 - Y2old) < 0.001   % if difference between Y2 and Y2old less then 0.001
                            % than we reached the accuracy we wanted
    break;
  end
  Y2old = Y2;               % store y2 value
  if (k > 1) && (mod(i, 2) == 0) % every even iteration rotate vector back, if needed
    --k;
    x = [x(m); x(1:(m -1))];
  end
end
x += X2;

% calculate Y3 and Y4 using modifications of Newton method
diffs = calculate_diffs(y);
k = choose_shift(x - X3);
Y3 = stirling_formula(diffs, k, (X3 - x(k)) / (x(2) - x(1)));
Y4 = second_newton_formula(diffs, (X4 - x(10))/(x(2)-x(1)));

plot(X1, Y1, 'bx;y1;', X2, Y2, 'gx;y2;', X3, Y3, 'mx;y3;', X4, Y4, 'bx;y4;');
pause;
result = [X1 X2 X3 X4; Y1 Y2 Y3 Y4]
