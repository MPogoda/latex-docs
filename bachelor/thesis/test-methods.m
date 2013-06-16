% Load image
I = im2double(imread('Lenna.png'));
figure(1); imshow(I);
title('Input image');

% Blur image
PSF = fspecial('disk', 15);
figure(2); imshow( mat2gray(PSF) );
imwrite( mat2gray(PSF), 'psf-disk15.png');
title('PSF');

Blurred = imfilter(I, PSF,'circular','conv' );

% Add noise
noise_mean = 0;
noise_var = 0.00001;
Blurred = imnoise(Blurred, 'gaussian', noise_mean, noise_var);
figure(3); imshow(Blurred);
imwrite( Blurred, 'Lenna-bn.png' );
title('Blurred image with noise');
estimated_nsr = noise_var / var(Blurred(:));

% Restore image
wiI = deconvwnr(Blurred, PSF, estimated_nsr);
figure(4); imshow( wiI ); title('Wiener');
imwrite( wiI, 'Lenna-wiener.png' );
reI = deconvreg(Blurred, PSF);
figure(5); imshow(reI); title('Regul');
imwrite(reI, 'Lenna-regul.png');
bI = deconvblind(Blurred, PSF, 100);
figure(6); imshow( bI ); title('Blind');
imwrite( bI, 'Lenna-blind.png' );
luI = deconvlucy(Blurred, PSF, 100);
figure(7); imshow( luI ); title('Lucy');
imwrite( luI, 'Lenna-lucy.png' );

