clear all
close all
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset')


HOGMatrix = [];
for img=1:size(trainImages,1)
    curImg = trainImages(img,:);
    
    curImg = reshape(curImg,[27,18]);
    
    HOG = hog_feature_vector(curImg);
    HOGMatrix = [HOGMatrix; HOG];
end

HOGmodel = SVMtraining(HOGMatrix,trainLabels);

[testImages, testLabels] = loadFaceImages('face_test.cdataset');

correct=0;
for img=1:size(testImages,1)
    img
    curImg = testImages(img,:);
    curImg = reshape(curImg,[27,18]);
    
    HOG=hog_feature_vector(curImg);
    correct = correct + (SVMTesting(HOG,HOGmodel)==testLabels(img));
end

save Image_HOG_SVM HOGmodel

% subplot(1,2,1)
% testimg=(reshape(trainImages(30,:),[27,18]));% Show image
% imshow(uint8(testimg));
% 
% subplot(1,2,2)
% testHog = hog_feature_vector(testimg);
% showHog(testHog,[27 18])


image=imread('im1.jpg')
% image=adapthisteq(image)
image = hog_feature_vector(image)
imshow(image)
facesBox = SVMDetector(image,HOGmodel);

for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3) - facesBox(i, 1),facesBox(i, 4) - facesBox(i, 2)], 'EdgeColor','r','LineWidth',2);
end

size(facesBox,1)
