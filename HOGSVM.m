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
HOGtrainMatrix = prepareHOG(trainImages);
HOGSVMmodel = SVMtraining(HOGtrainMatrix,trainLabels);
fprintf('\nTraining Ending...');

%% TESTING

fprintf('\nTesting Starting...');
HOGtestMatrix = prepareHOG(testImages);
totalImages = size(HOGtestMatrix,1);
classificationResults = zeros(totalImages,1);

for i=1:totalImages
curImg = HOGtestMatrix(i,:);
classificationResults(i)=SVMTesting(curImg, HOGSVMmodel);
end

fprintf('\nTesting Ending...');
save Models/Image_HOG_SVM HOGSVMmodel
fprintf('\nModel Saved!');



%% RESULTS
      
image1=imread('im1.jpg');
image1=enhanceContrastLS(image1,1.1,  10);
image1=adapthisteq(image1);

fprintf('\nDetecting Faces in image...');

facesBox = HOGSVMDetector(image1,HOGSVMmodel);
FacesFound=size(facesBox,1);
subplot(1,1,1);
imshow(image1);
title('Faces Detected = '+string( size(facesBox,1)));
for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end