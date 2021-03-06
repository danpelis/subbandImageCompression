%{
%If png must read and show as [img, cmap]
clear;
close all;
img = imread('patern_test.jpg');
imshow(img)
waveLevel = 5;

[c,s] = wavedec2(img, waveLevel, 'sym4');


V{1,waveLevel} = []; % cell(2019,1515,3)
D{1,waveLevel} = []; %cell(1,10);
H{1,waveLevel} = [];
A{1,waveLevel} = [];
Vimg{1,waveLevel} = [];
Himg{1,waveLevel} = [];
Dimg{1,waveLevel} = [];
Aimg{1,waveLevel} = [];

[H1,V1,D1] = detcoef2('all',c,s,1);
V1img = wcodemat(V1,255,'mat',1);
for level = 1:waveLevel
    %[H, V, D] = detcoef2('all',c,s,level);
    D{1,level} = num2cell(detcoef2('D',c,s,level));
    V{1,level} = num2cell(detcoef2('V',c,s,level));
    H{1,level} = num2cell(detcoef2('H',c,s,level));
    A{1,level} = num2cell(appcoef2(c,s,'sym4',(level)));
    
    Vimg{1, level} = num2cell(wcodemat(str2double(V{1,level}),255,'mat', level));
    Himg{1, level} = num2cell(wcodemat(str2double(H{1,level}),255,'mat', level));
    Dimg{1, level} = num2cell(wcodemat(str2double(D{1,level}),255,'mat', level));
    Aimg{1, level} = num2cell(wcodemat(str2double(A{1,level}),255,'mat', level));
end

siz = s(size(s,1),:); 
coeffs{1, (waveLevel*4)} = [];
for level = 1:waveLevel
    %[H, V, D] = detcoef2('all',c,s,level);
    reD = upcoef2('D', D{1, level}, 'sym4', level, siz);
    coeffs{1, (waveLevel)}
    reV = upcoef2('V', V{1, level}, 'sym4', level, siz);
    coeffs{1, (waveLevel)}
    reH = upcoef2('H', H{1, level}, 'sym4', level, siz);
    reA = upcoef2('A', A{1, level}, 'sym4', level, siz);
end


imRe = waverec2(c,s,'sym4');


return

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
	 
%}
%If png must read and show as [img, cmap]
close all;
img = imread('patern_test.jpg');
figure
imshow(img)
decLevels = 1;
quantLevels = 20;
wavename = 'haar';
%[c,s] = wavedec2(img,2,'sym4');
[cA,cH,cV,cD] = dwt2(img,wavename);
[cAA,cAH,cAV,cAD] = dwt2(cA,wavename); 

Level2=[cAA,cAH; cAV,cAD]; %contacinat
figure;
imshow([Level2,cH; cV,cD],'Colormap',gray); %2 level

Z = idwt2([cAA,cAH; cAV,cAD],cH, cV, cD, 'sym4');
figure;
imshow(uint8(Z));
axis off
title('2 Level Decomp')

return
%{
if decLevels > 1
    for level = 1:decLevels
        
    end
end
%}


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


thresh = multithresh(img,quantLevels);
value = [0 thresh(2:end) 255]; 
seg_img = imquantize(img, thresh, value);

%threshCMap = multithresh(cmap, quantLevels);
%valueCMap = [0 threshCMap(2:end) 255]; 
%seg_cmap = imquantize(cmap, thresh, valueCMap);

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
