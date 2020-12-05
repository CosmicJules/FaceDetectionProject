%Edge detector

%Read image
I = imread('15.png');
figure(1)
subplot(1,2,1)
imshow(I) %display original image
title('Original Image');
subplot(1,2,2)
histogram(I, 'BinLimits', [0 256], 'BinWidth', 1) %display original image histogram

%use of linear stretching. m = 255/150
I_LS = enhanceContrastLS(I, (255/150), -85);
figure(2)
subplot(1,2,1)
imshow(I_LS) 
title('Linear Stretching');
subplot(1,2,2)
histogram(I_LS, 'BinLimits', [0 256], 'BinWidth', 1) 

%linear stretching (params auto generated)
I_LS_A = enhanceContrastALS(I);
figure(5)
subplot(1,2,1)
imshow(I_LS_A)
title('Linear Stretching (Automatically Generated)')
subplot(1,2,2)
histogram(I_LS_A, 'BinLimits', [0 256], 'BinWidth', 1) 

% use of power law contrast
I_PL = enhanceContrastPL(I,0.6); %Power law contrast enhancement
figure(3)
subplot(1,2,1)
imshow(I_PL) %display new image
title('Power Law');
subplot(1,2,2)
histogram(I_PL, 'BinLimits', [0 256], 'BinWidth', 1) %display new image histogram

%use of histogram equalisation contrast enhancement
I_histeq = histeq(I);
figure(4)
subplot(1,2,1)
imshow(I_histeq)
title('Histogram Equalisation');
subplot(1,2,2)
histogram(I_histeq, 'BinLimits', [0 256], 'BinWidth', 1)

% Sobel edge extraction 
[~,threshold] = edge(I_histeq,'sobel');
fudgeFactor = 0.3; %0.5 - original
edges = edge(I_histeq,'sobel',threshold * fudgeFactor);

figure(6)
imshow(edges)
title('Binary Gradient Mask')

% %Dilate image
% se90 = strel('line',3,90);
% se0 = strel('line',3,0);
% 
% edgesDil = imdilate(edges,[se90 se0]);
% figure(3)
% imshow(edgesDil)
% title('Dilated Gradient Mask')

%Fill gaps
edgesFill = imfill(edges,'holes');
figure(7)
imshow(edges)
title('Binary Image with Filled Holes')



