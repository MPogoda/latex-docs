function [B] = generate_hessenberg_matrix(A)
  printf("Begin generating Hessenberg matrix\n");
  printf("Input matrix:\n")
  disp(A);
  printf("==============================\n");
  m = size(A, 1);

  for j = 2:(m - 1)
    for i = (j + 1):m
      sqrt_ij = sqrt(A(j, j - 1)^2 + A(i, j - 1)^2);
      cos_ij = -A(j, j - 1) / sqrt_ij;
      sin_ij =  A(i, j - 1) / sqrt_ij;

      T = eye(m);
      T(i, i) = T(j, j) = cos_ij;
      T(i, j) = -sin_ij;
      T(j, i) = sin_ij;
      printf("Transformation matrix T_%d%d:\n", i, j);
      disp(T);

      A = T' * A * T;

      printf("Input matrix after making A_%d%d = 0:\n", i, (j - 1));
      disp(A);
      printf("==============================\n");
    end
  end

  B = A;
end
