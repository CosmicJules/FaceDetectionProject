clear all
close all
[images,labels] = loadFaceImages('face_train.cdataset');

for i=1:size(images,1)
    x=uint8(reshape(images(i,:),[27,18]))
    x=histeq(x)
    x=reshape(x,[1,486])
    images(i,:)=x;
end

SVMmodel=SVMtraining(images,labels)
