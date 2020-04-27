%If png must read and show as [img, cmap]
close all;
img = imread('dennis.jpg');
%[c,s] = wavedec2(img,2,'sym4');
[cA,cH,cV,cD] = dwt2(img,'sym4');

figure;
subplot(2,2,1);
imshow(cA);
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

levels = 2;
thresh = multithresh(img,levels);
value = [0 thresh(2:end) 255]; 
seg_img = imquantize(img, thresh, value);

%threshCMap = multithresh(cmap, levels);
%valueCMap = [0 threshCMap(2:end) 255]; 
%seg_cmap = imquantize(cmap, thresh, valueCMap);

threshCA = multithresh(cA,levels);
valueCA = [min(min(min(cA))) threshCA(2:end) max(max(max(cA)))];
seg_CA = imquantize(cA,threshCA, valueCA);

threshCH = multithresh(cH,levels);
valueCH = [min(min(min(cH))) threshCH(2:end) max(max(max(cH)))];
seg_CH = imquantize(cH,threshCH, valueCH);

threshCV = multithresh(cV,levels);
valueCV = [min(min(min(cV))) threshCV(2:end) max(max(max(cV)))];
seg_CV = imquantize(cV,threshCV, valueCV);

threshCD = multithresh(cD,levels);
valueCD = [min(min(min(cD))) threshCD(2:end) max(max(max(cD)))];
seg_CD = imquantize(cD,threshCD, valueCD);
	 
figure;
imshow(seg_img);
axis off
title('RGB Segmented Image')

figure;
subplot(2,2,1);
imshow(seg_CA);
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

X = idwt2(seg_CA,seg_CH,seg_CV,seg_CD,'sym4');
Y = idwt2(cA,cH,cV,cD,'sym4');
%seg_I = waverec2(c,s,'sym4');
%max(max(abs(double(img)-seg_I)))
figure;
subplot(1,3,1);
imshow(img);
axis off
title('Original Image')
subplot(1,3,2);
imshow(uint8(X));
axis off
title('Final Image')
subplot(1,3,3);
imshow(uint8(Y));
axis off
title('Non-Quantized Image')
%title('2 levels');

