function [y] = real_answer(x)
  y = (x .+ 2) .- 2 .* (e .^ (x ./ 2));
  y = -2 .* y;
end
