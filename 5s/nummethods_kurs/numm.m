A = [
7.2   -2    0.6   0.2
-2    7.3   2     -1.5
0.6   2     7.5   0
0.2   -1.5  0     8
];

A = generate_hessenberg_matrix(A);
A = fix_small_numbers(A)
i = 1;

while (1)
  [Q R] = calculate_qr(A)
  printf("A_%d:\n", i);
  A = fix_small_numbers(R * Q);
  disp(A);
  i += 1;
  pause
end
