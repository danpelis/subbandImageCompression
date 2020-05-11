%Closes all open figures as to not clutter user's screen after multiple
%runs
close all;

% Reads in image 
% If png must read and show as [img, cmap]
img = imread('dennis.jpg');

% Declares the two input vaiables. The Quantization step size and 
% the chosen Wavelet
quantLevels = str2double(input("Please Enter Amount Quantization Levels (1-20): ",'s'));
wavename = input("Enter Desired Wavelet(haar, dbN, biorN.M, symN, coifN): ",'s');


% Wavelet Deompositon
[cA,cH,cV,cD] = dwt2(img,wavename);

% Outputs a plot of the subbands for the decopmosed image
figure;
subplot(2,2,1);
imshow(uint8(cA));
axis off
title('cA')
 
subplot(2,2,2);
imshow(cH);
axis off
title('cH')

subplot(2,2,3);
imshow(cV);
axis off
title('cV')

subplot(2,2,4);
imshow(cD);
axis off
title('cD')

% Quantization of each subband
% threshXX are step values for the band
% valueXX are the reconstruction values for the band
% seg_XX is the quantized band
threshCA = multithresh(cA,quantLevels);
valueCA = [min(min(min(cA))) threshCA(2:end) max(max(max(cA)))];
seg_CA = imquantize(cA,threshCA, valueCA);

threshCH = multithresh(cH,quantLevels);
valueCH = [min(min(min(cH))) threshCH(2:end) max(max(max(cH)))];
seg_CH = imquantize(cH,threshCH, valueCH);

threshCV = multithresh(cV,quantLevels);
valueCV = [min(min(min(cV))) threshCV(2:end) max(max(max(cV)))];
seg_CV = imquantize(cV,threshCV, valueCV);

threshCD = multithresh(cD,quantLevels);
valueCD = [min(min(min(cD))) threshCD(2:end) max(max(max(cD)))];
seg_CD = imquantize(cD,threshCD, valueCD);
	 
% Outputs a plot showing the quantized subbands
figure;
subplot(2,2,1);
imshow(uint8(seg_CA));
axis off
title('RGB Segmented cA')
 
subplot(2,2,2);
imshow(seg_CH);
axis off
title('RGB Segmented cH')

subplot(2,2,3);
imshow(seg_CV);
axis off
title('RGB Segmented cV')

subplot(2,2,4);
imshow(seg_CD);
axis off
title('RGB Segmented cD')

% Subband Reconstuction
X = idwt2(seg_CA,seg_CH,seg_CV,seg_CD,wavename);

% Outputs plot of original and final images
figure;
subplot(1,2,1);
imshow(img);
axis off
title('Original Image')
subplot(1,2,2);
imshow(uint8(X));
axis off
title('Final Image')

peaksnr = psnr(uint8(X),img);
disp("Peak signal-to-noise ratio: " + peaksnr);
