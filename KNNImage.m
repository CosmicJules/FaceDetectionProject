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

KNNModel=NNtraining(trainImages,trainLabels);


for i=1:size(testImages,1)
    x=testImages(i,:);
    classificationResult(i,1) = KNNTesting(x,KNNModel,1);

end
fprintf('\nTesting End...');

save Models/Image_KNN KNNModel;

fprintf('\nModel Saved!');
%% Evaluation

confusionMatrix=confusionmat(testLabels,classificationResult)

accuracy=(confusionMatrix(1,1)+confusionMatrix(2,2))/240
ErrorRate = (confusionMatrix(2,1)+confusionMatrix(1,2))/240
Recall = (confusionMatrix(2,2))/(confusionMatrix(2,2)+confusionMatrix(2,1))
Precision = (confusionMatrix(2,2))/(confusionMatrix(2,2)+confusionMatrix(1,2))
Specificity = (confusionMatrix(1,1))/(confusionMatrix(1,1)+confusionMatrix(1,2))
F1 = 2*((Precision*Recall)/(Precision + Recall))
FalseAlarmRate = 1-Specificity

%% Results

image1=imread('im2.jpg');
image1=enhanceContrastLS(image1,1.1,  10);
image1=adapthisteq(image1);

fprintf('\nDetecting Faces in image...');

facesBox = KNNDetector(image1,KNNModel,7);
FacesFound=size(facesBox,1);
subplot(1,1,1);
imshow(image1);
title('Faces Detected = '+string( size(facesBox,1)));
for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end