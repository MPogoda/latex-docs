 % Load image
I = imread('Lenna-gray.png');
figure(1); imshow(I); title('Input image');
% Compute Fourier Transform and center it
fftRes = fftshift( fft2(I) );
% Show result
Iampl = mat2gray( log( 1 + abs(fftRes) ) );
figure(2); imshow( Iampl ); imwrite( Iampl, 'Lenna-ampl.png' );
title('FFT - the amplitude spectrum');

Iph = mat2gray( angle(fftRes) );
figure(3); imshow( Iph ); imwrite( Iph, 'Lenna-phase.png' );
title('FFT - phase spectrum');

pause;
