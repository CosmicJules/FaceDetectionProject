%testing NN functions

clear all
close all

%Training
sampling = 1;

[trainImages,trainLabels] = loadFaceImages('face_train.cdataset', sampling);

%indexesFace = find (labels == 'face');
%indexesNonFace = find (labels == 'non-face');

% figure
% for i=1:100
%     Im = reshape(trainImages(i,:),18,27);
%     subplot(10,10,i), imshow(Im), title(['label: ',num2str(trainLabels(i))])
% end

ModelNN = NNtraining(trainImages, trainLabels);

%Testing
[testImages, testLabels] = loadFaceImages('face_test.cdataset');

for i=1:size(testImages,1)
    
    testnumber= testImages(i,:);
    
    classificationResult(i,1) = NNTesting(testnumber, ModelNN);
    
end
