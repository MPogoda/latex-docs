function [B] = fix_small_numbers(A)
  m = size(A, 2);
  for i = 1:m
    for j = 1:m
      if (abs(A(i, j)) < 1e-7)
        A(i, j) = 0;
      end
    end
  end

  B = A;
end
