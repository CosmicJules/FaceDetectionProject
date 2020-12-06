function [HOGMatrix] = prepareHOG(images)

totalImages = size(images,1);
HOGMatrix=[];

for i = 1:totalImages
    curImg = reshape(images(i,:),[27,18]);
    curImg = uint8(curImg);
    HOG = hog_feature_vector(curImg);
    HOGMatrix=[HOGMatrix; HOG];
end
end