function [GaborMatrix] = prepareGabor(images)
%takes an array of images, performs preprocessing and applies gabor feature
%vector to  images and returns these images in an array
totalImages = size(images,1);
GaborMatrix=[];

for i = 1:totalImages
    curImg = reshape(images(i,:),[27,18]);
    curImg = uint8(curImg);
    curImg=enhanceContrastLS(curImg,0.6,20);
    curImg=adapthisteq(curImg);
    Gab = gabor_feature_vector(curImg);
    GaborMatrix=[GaborMatrix; Gab];
end
end