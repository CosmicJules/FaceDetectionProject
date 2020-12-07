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

[trainImages, trainLabels] = loadFaceImages('face_train.cdataset');
[testImages, testLabels] = loadFaceImages('face_test.cdataset');

%% TRAINING
fprintf('\nTraining Starting...');

GaborTrainMatrix = prepareGabor(trainImages);
GaborSVMmodel = SVMtraining(GaborTrainMatrix,trainLabels);

fprintf('\nTraining Ending...');
%% TESTING

fprintf('\nTesting Starting...');

GaborTestMatrix = prepareGabor(testImages);
totalImages = size(GaborTestMatrix,1);
classificationResults = zeros(totalImages,1);

for i=1:totalImages
curImg = GaborTestMatrix(i,:);
classificationResults(i)=SVMTesting(curImg, GaborSVMmodel);
end
fprintf('\nTesting Ending...');

save Models/Image_Gabor_SVM GaborSVMmodel
fprintf('\nModel Saved!');

%% RESULTS
    
image1=imread('im1.jpg');
image1=enhanceContrastLS(image1,1.1,  10);
image1=adapthisteq(image1);

fprintf('\nDetecting Faces in image...');

facesBox = GaborSVMDetector(image1,GaborSVMmodel);
FacesFound=size(facesBox,1);
subplot(1,1,1);
imshow(image1);
title('Faces Detected = '+string( size(facesBox,1)));
for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end