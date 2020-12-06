clear all
close all
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset');

% TRAINING
GaborTrainMatrix = prepareGabor(trainImages);
GaborSVMmodel = SVMtraining(GaborTrainMatrix,trainLabels);


% TESTING
[testImages, testLabels] = loadFaceImages('face_test.cdataset');

GaborTestMatrix = prepareGabor(testImages);
totalImages = size(GaborTestMatrix,1);
classificationResults = zeros(totalImages,1);

for i=1:totalImages
curImg = GaborTestMatrix(i,:);
classificationResults(i)=SVMTesting(curImg, GaborSVMmodel);
end


save Image_Gabor_SVM GaborSVMmodel


% RESULTS
    
images{1} = imread('im1.jpg');    
figure(1);
   
ImageforDetection = cell2mat(images(1));
        
ImageforDetection = adapthisteq(ImageforDetection);
    
imshow(ImageforDetection); 


faceBox = GaborSVMDetector(ImageforDetection, GaborSVMmodel);


for i = 1:size(faceBox,1) 
    rectangle('Position',[faceBox(i,1),faceBox(i, 2),faceBox(i, 3),faceBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end