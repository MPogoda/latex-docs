function [Q R] = calculate_qr(A)
  %printf("Begin calculating QR factorization of matrix A\n");
  %printf("Input matrix A_0:\n");
  %disp(A);
  %printf("========================\n");

  m = size(A, 2);

  Q = eye(m);

  for i = 1:(m - 1)
    %printf("Begin making all subdiagonal elements of %d column zeros.\n", i);
    v = A(:, i);
    v(1:(i - 1)) = 0;
    v(i) += sign(v(i)) * sqrt(sum(v .^ 2));
    %printf("Vector V:\n");
    %disp(v);

    %printf("Transformation matrix H_%d:\n", i);
    H = eye(m) - (2 / (v' * v)) * (v * v');
    %disp(H);

    Q *= H;

    A = H * A;
    %printf("Matrix H_%d * A_%d:\n", i, i - 1);
    %disp(A);
    %printf("========================\n");
  end

  R = A;
end
