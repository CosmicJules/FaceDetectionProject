clc
clear all
close all

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset');
[testImages, testLabels] = loadFaceImages('face_test.cdataset');

for i=1:size(trainImages,1)
    x=uint8(reshape(trainImages(i,:),[27,18]))
    x=enhanceContrastLS(x,0.6,20)
    x=adapthisteq(x)
    x=reshape(x,[1,486])
    trainImages(i,:)=x;
end
for i=1:size(testImages,1)
    x=uint8(reshape(testImages(i,:),[27,18]))
    x=enhanceContrastLS(x,0.6,20)
    x=adapthisteq(x)
    x=reshape(x,[1,486])
    testImages(i,:)=x;
end

NNmodel=NNtraining(trainImages,trainLabels)


for i=1:size(testImages,1)
    x=testImages(i,:);
    [classificationResult(i,1)] = NNTesting(x,NNmodel);

end



save Image_NN NNmodel

figure(1)
image1=imread('im1.jpg')
%image1=enhanceContrastLS(image1,1.1,  10)
image1=adapthisteq(image1)
imshow(image1)
facesBox = NNDetector(image1,NNmodel);

for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end