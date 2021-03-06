clc
clear all
close all
%% Load and Prepare
addpath('Functions');
addpath('Functions/Pre-Processing');
addpath('images');
addpath('SVM-KM');
addpath('Datasets');
addpath('Detectors');
addpath('Models');

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset');
[testImages, testLabels] = loadFaceImages('face_test.cdataset');

%% Training

fprintf('\nTraining Starting...');

for i=1:size(trainImages,1)
    x=uint8(reshape(trainImages(i,:),[27,18]));
    x=enhanceContrastLS(x,0.6,20);
    x=adapthisteq(x);
    x=reshape(x,[1,486]);
    trainImages(i,:)=x;
end

fprintf('\nTraining Ending...');

%% Testing

fprintf('\nTesting Start...');

for i=1:size(testImages,1)
    x=uint8(reshape(testImages(i,:),[27,18]));
    x=enhanceContrastLS(x,0.6,20);
    x=adapthisteq(x);
    x=reshape(x,[1,486]);
    testImages(i,:)=x;
end

SVMmodel=SVMtraining(trainImages,trainLabels);


for i=1:size(testImages,1)
    x=testImages(i,:);
    classificationResult(i,1) = SVMTesting(x,SVMmodel);

end
fprintf('\nTesting End...');

save Models/Image_SVM SVMmodel;

fprintf('\nModel Saved!');


%% Results

image1=imread('im1.jpg');
image1=enhanceContrastLS(image1,1.1,  10);
image1=adapthisteq(image1);

fprintf('\nDetecting Faces in image...');

facesBox = SVMDetector(image1,SVMmodel);
FacesFound=size(facesBox,1);
subplot(1,1,1);
imshow(image1);
title('Faces Detected = '+string( size(facesBox,1)));
for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end
