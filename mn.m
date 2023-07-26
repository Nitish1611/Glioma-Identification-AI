
[file path] = uigetfile('*.bmp;*.jpg;*.gif','Pick an Image File');
if isequal(file,0) || isequal(path,0);
    warndlg('User Pressed Cancel');
else
    inp = imread(file);
   inp = imresize(inp,[256 256]);
    [r c p]=size(inp);
    if p == 3
    g = rgb2gray(inp);
    end


figure(1);
imshow(inp);

figure(2);
imshow(g);


M = medfilt2(g);
figure(4);
imshow(J);
title('median filter')


B = imdiffusefilt(g);
figure(5);
imshow(B)
title('Anisotropic Diffusion with Default Parameters')


%DWT





W = wiener2(g,[5 5]);

[peaksnr, snr] = psnr(M,g);
[peaksnr1, snr1] = psnr(W,g);
[peaksnr2, snr2] = psnr(B,g);





fprintf('\n The Peak-SNR value is %0.4f', peaksnr);

  
fprintf('\n The Peak-SNR value is %0.4f', peaksnr2);
fprintf('\n The Peak-SNR value is %0.4f', peaksnr1);



g=double(g)
[LL, LH, HL, HH] = dwt2(g, 'haar');
figure(6);
imshow(LH);

title('Vertical Detail Coefficients');

% Reconstruct the image using the DWT coefficients
reImage = idwt2(LL, LH, HL, HH, 'haar');

% Calculate the PSNR value
MAXp = 255; % Maximum possible pixel value
MSE = mean(mean((g - reImage).^2));
psnr4 = 20*log10(MAXp) - 10*log10(MSE);

% Display the PSNR value
%disp(['PSNR value: ' num2str(PSNR)]);
%This code uses the built-in dwt2 and idwt2 functions in MATLAB to perform the DWT and inverse DWT on the image, respectively. The mean function is used to calculate the MSE, and the disp function is used to display the PSNR value in the MATLAB command window. Note that the maximum possible pixel value is assumed to be 255 in this example; you should adjust this value to match the range of pixel values in your specific image.




fprintf('\n The Peak-SNR value is %0.4f', psnr4);

a=1:10;


a=[peaksnr,peaksnr1,peaksnr2,psnr4]


fprintf('\n The Peak-SNR value is %0.4f', a);

plot(a)
figure(7)
title('psnr comparision')

end
