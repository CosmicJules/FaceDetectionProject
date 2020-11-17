clc
clear all
close all


[trainImages,trainLabels] = loadFaceImages('face_train.cdataset', 1);

subplot(1,3,1)
testImg=(reshape(trainImages(1,:),[27,18]));% Show image
imshow(uint8(testImg));



Cas = GetHaarCasade('haarcascade_frontalface_alt.mat');
% ShowHaarCasade(Cas, 1);

ObjectDetection('im2.jpg','haarcascade_frontalface_alt.mat')
%object detection working, need to train and get own .mat file
%necessary functions for classification should be available now