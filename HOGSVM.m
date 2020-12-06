clear all
close all
[trainImages, trainLabels] = loadFaceImages('face_train.cdataset');

% TRAINING
HOGtrainMatrix = prepareHOG(trainImages);
HOGSVMmodel = SVMtraining(HOGtrainMatrix,trainLabels);


% TESTING
[testImages, testLabels] = loadFaceImages('face_test.cdataset');

HOGtestMatrix = prepareHOG(testImages);
totalImages = size(HOGtestMatrix,1);
classificationResults = zeros(totalImages,1);

for i=1:totalImages
curImg = HOGtestMatrix(i,:);
classificationResults(i)=SVMTesting(curImg, HOGSVMmodel);
end


save Image_HOG_SVM HOGSVMmodel


% RESULTS
    
images{1} = imread('im1.jpg');    
figure(1);
   
ImageforDetection = cell2mat(images(1));
        
ImageforDetection = adapthisteq(ImageforDetection);
    
imshow(ImageforDetection); 


faceBox = HOGSVMDetector(ImageforDetection, HOGSVMmodel);


for i = 1:size(faceBox,1) 
    rectangle('Position',[faceBox(i,1),faceBox(i, 2),faceBox(i, 3),faceBox(i, 4)], 'EdgeColor','r','LineWidth',2);
end