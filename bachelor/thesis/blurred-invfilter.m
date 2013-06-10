I = im2double( imread('Lenna.png') );
figure(1); imshow(I); title('Input image');

PSF = fspecial( 'gaussian', 30, 8 );

% Blur image
Blurred = imfilter( I, PSF, 'circular', 'conv' );
figure(2); imshow(Blurred);
title('Blurred image'); imwrite( Blurred, 'Lenna-blurred.png' );
% Add noise
noise_mean = 0;
noise_var = 0.0;
Blurred = imnoise( Blurred, 'gaussian', noise_mean, noise_var );
figure( 3 ); imshow( Blurred ); title( 'Blurred with noise');
imwrite( Blurred, 'Lenna-b0.png' );
% Deconvolution
Deconv = deconvwnr( Blurred, PSF, 0);
figure(3); imshow(Deconv);
imwrite( Deconv, 'Lenna-b0deconv.png' );
title('Output image');
