
[trainImages,trainLabels] = loadFaceImages('face_train.cdataset');
[testImages, testLabels] = loadFaceImages('face_test.cdataset');
img=imread("im1.jpg")
x=gabor_feature_vector(img)
img=imgaborfilt(img,x)
figure(1)
subplot(1,2,1), imshow(img)