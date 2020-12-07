function [GaborMatrix] = prepareGabor(images)

totalImages = size(images,1);
GaborMatrix=[];

for i = 1:totalImages
    curImg = reshape(images(i,:),[27,18]);
    curImg = uint8(curImg);
    Gab = gabor_feature_vector(curImg);
    GaborMatrix=[GaborMatrix; Gab];
end
end