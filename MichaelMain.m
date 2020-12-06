clc
clear all
close all


[trainImages,trainLabels] = loadFaceImages('face_train.cdataset');

    x=trainImages(1,:);
    x=reshape(x, [27 18]);

    x=hog_feature_vector(x)




