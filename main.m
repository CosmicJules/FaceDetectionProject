clear all
close all


[images,labels] = loadFaceImages('face_train.cdataset',1);

subplot(1,3,1)
testImg=(reshape(images(1,:),[27,18]));% Show image
imshow(uint8(testImg));

subplot(1,3,2)
testImg2=(reshape(images(19,:),[27,18]));% Show image
imshow(uint8(testImg2));

subplot(1,3,3)
testImg3=(reshape(images(37,:),[27,18]));% Show image
imshow(uint8(testImg3));