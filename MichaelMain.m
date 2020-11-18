clc
clear all
close all


[trainImages,trainLabels] = loadFaceImages('face_train.cdataset');

subplot(1,3,1)
testImg=(reshape(trainImages(1,:),[27,18]));% Show image
imshow(uint8(testImg));


% 
% Cas = GetHaarCasade('haarcascade_frontalface_alt.mat');
% % ShowHaarCasade(Cas, 1);
% 
% ObjectDetection('im2.jpg','haarcascade_frontalface_alt.mat')
% %object detection working, need to train and get own .mat file
% %necessary functions for classification should be available now



% newImages=double.empty
% x=trainImages(1,:)
% reshape(x,[27,18])
% m=size(trainImages,1)
% for i=1:size(trainImages)
%     x=trainImages(i,:)
%     x=reshape(x,[27,18])
%     newImages(:,:,i)=x
% end

% figure(1)
% subplot(2,5,1),imshow(uint8(newImages(:,:,1)))
% subplot(2,5,2),imshow(uint8(newImages(:,:,2)))
% subplot(2,5,3),imshow(uint8(newImages(:,:,3)))
% subplot(2,5,4),imshow(uint8(newImages(:,:,4)))
% subplot(2,5,5),imshow(uint8(newImages(:,:,5)))
% subplot(2,5,6),imshow(uint8(newImages(:,:,6)))
% subplot(2,5,7),imshow(uint8(newImages(:,:,7)))
% subplot(2,5,8),imshow(uint8(newImages(:,:,8)))
% subplot(2,5,9),imshow(uint8(newImages(:,:,9)))
% subplot(2,5,10),imshow(uint8(newImages(:,:,10)))
% 
% figure(2)
% subplot(2,5,1),imshow(uint8(newImages(:,:,11)))
% subplot(2,5,2),imshow(uint8(newImages(:,:,12)))
% subplot(2,5,3),imshow(uint8(newImages(:,:,13)))
% subplot(2,5,4),imshow(uint8(newImages(:,:,14)))
% subplot(2,5,5),imshow(uint8(newImages(:,:,15)))
% subplot(2,5,6),imshow(uint8(newImages(:,:,16)))
% subplot(2,5,7),imshow(uint8(newImages(:,:,17)))
% subplot(2,5,8),imshow(uint8(newImages(:,:,18)))
% subplot(2,5,9),imshow(uint8(newImages(:,:,19)))
% subplot(2,5,10),imshow(uint8(newImages(:,:,200)))

subplot(1,3,2)

feature = hog_feature_vector(testImg);
showHog(feature,[27,18])




