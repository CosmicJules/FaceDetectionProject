clear all
close all
[trainImages,trainLabels] = loadFaceImages('face_train.cdataset');
[testImages, testLabels] = loadFaceImages('face_test.cdataset');
% subplot(2,5,1),imshow(uint8(reshape(trainImages(477,:),[27,18])))
% newtrainImages=double.empty
% x=trainImages(1,:)
% m=size(trainImages,1);
% for i=1:size(trainImages,1)
%     x=trainImages(i,:);
%     x=reshape(x,[27,18]);
%     newtrainImages(:,:,i)=x;
% end


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

SVMmodel=SVMtraining(trainImages,trainLabels)


for i=1:size(testImages,1)
    x=testImages(i,:);
    classificationResult(i,1) = SVMTesting(x,SVMmodel);

end

% figure(1)
% 
% subplot(5,5,1), imshow(uint8(reshape(testImages(1,:),[27,18])))
% subplot(5,5,2), imshow(uint8(reshape(testImages(2,:),[27,18])))
% subplot(5,5,3), imshow(uint8(reshape(testImages(3,:),[27,18])))
% subplot(5,5,4), imshow(uint8(reshape(testImages(4,:),[27,18])))
% subplot(5,5,5), imshow(uint8(reshape(testImages(5,:),[27,18])))
% subplot(5,5,6), imshow(uint8(reshape(testImages(6,:),[27,18])))
% subplot(5,5,7), imshow(uint8(reshape(testImages(7,:),[27,18])))
% subplot(5,5,8), imshow(uint8(reshape(testImages(8,:),[27,18])))
% subplot(5,5,9), imshow(uint8(reshape(testImages(9,:),[27,18])))
% subplot(5,5,10), imshow(uint8(reshape(testImages(10,:),[27,18])))
% subplot(5,5,11), imshow(uint8(reshape(testImages(11,:),[27,18])))
% subplot(5,5,12), imshow(uint8(reshape(testImages(12,:),[27,18])))
% subplot(5,5,13), imshow(uint8(reshape(testImages(13,:),[27,18])))
% subplot(5,5,14), imshow(uint8(reshape(testImages(14,:),[27,18])))
% subplot(5,5,15), imshow(uint8(reshape(testImages(15,:),[27,18])))
% subplot(5,5,16), imshow(uint8(reshape(testImages(16,:),[27,18])))
% subplot(5,5,17), imshow(uint8(reshape(testImages(17,:),[27,18])))
% subplot(5,5,18), imshow(uint8(reshape(testImages(18,:),[27,18])))
% subplot(5,5,19), imshow(uint8(reshape(testImages(19,:),[27,18])))
% subplot(5,5,20), imshow(uint8(reshape(testImages(20,:),[27,18])))
% subplot(5,5,21), imshow(uint8(reshape(testImages(21,:),[27,18])))
% subplot(5,5,22), imshow(uint8(reshape(testImages(22,:),[27,18])))
% subplot(5,5,23), imshow(uint8(reshape(testImages(31,:),[27,18])))
% subplot(5,5,24), imshow(uint8(reshape(testImages(32,:),[27,18])))
% subplot(5,5,25), imshow(uint8(reshape(testImages(33,:),[27,18])))

save Image_SVM SVMmodel

figure(1)
image1=imread('im1.jpg')
image1=enhanceContrastLS(image1,1.1,  10)
image1=adapthisteq(image1)
imshow(image1)
facesBox = SVMDetector(image1,SVMmodel);

for i = 1:size(facesBox,1) 

    rectangle('Position',[facesBox(i,1),facesBox(i, 2),facesBox(i, 3),facesBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end

