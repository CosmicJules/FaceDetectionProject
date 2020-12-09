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
GaborKNNmodel = NNtraining(GaborTrainMatrix,trainLabels);

fprintf('\nTraining Ending...');
%% TESTING

fprintf('\nTesting Starting...');

GaborTestMatrix = prepareGabor(testImages);
totalImages = size(GaborTestMatrix,1);
classificationResults = zeros(totalImages,1);

for i=1:totalImages
curImg = GaborTestMatrix(i,:);
classificationResults(i)=KNNTesting(curImg, GaborKNNmodel,9);
end
fprintf('\nTesting Ending...');

save Models/Image_Gabor_KNN GaborKNNmodel
fprintf('\nModel Saved!');

%% EVALUATION

confusionMatrix=confusionmat(testLabels,classificationResults)


%% RESULTS
    
image1=imread('im4.jpg');
image1=enhanceContrastLS(image1,1.1,  10);
image1=adapthisteq(image1);

fprintf('\nDetecting Faces in image...');

facesBox = GaborKNNDetector(image1,GaborKNNmodel,9);
FacesFound=size(facesBox,1);
subplot(1,1,1);
imshow(image1);
title('Faces Detected = '+string( size(facesBox,1)));
for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end