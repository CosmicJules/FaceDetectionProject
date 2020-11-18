clear all
close all
[images,labels] = loadFaceImages('face_train.cdataset');


% newImages=double.empty
% x=images(1,:)
% m=size(images,1);
% for i=1:size(images,1)
%     x=images(i,:);
%     x=reshape(x,[27,18]);
%     newImages(:,:,i)=x;
% end

% figure(1)
% subplot(2,5,1),imshow(uint8(newImages(:,:,1)))
% subplot(2,5,2),imshow(uint8(newImages(:,:,2)))
% subplot(2,5,3),imshow(uint8(newImages(:,:,3)))
% subplot(2,5,4),imshow(uint8(newImages(:,:,4)))
% subplot(2,5,5),imshow(uint8(newImages(:,:,5)))
% subplot(2,5,6),imshow(uint8(newImages(:,:,6)))
% subplot(2,5,7),imshow(uint8(newImages(:,:,7)))
% subplot(2,5,8),imshow(uint8(newImages(:,:,8)))
% subplot(2,5,9),imshow(uint8(newImages(:,:,9)))
% subplot(2,5,10),imshow(uint8(newImages(:,:,10)))
% 
% figure(2)
% subplot(2,5,1),imshow(uint8(newImages(:,:,11)))
% subplot(2,5,2),imshow(uint8(newImages(:,:,12)))
% subplot(2,5,3),imshow(uint8(newImages(:,:,13)))
% subplot(2,5,4),imshow(uint8(newImages(:,:,14)))
% subplot(2,5,5),imshow(uint8(newImages(:,:,15)))
% subplot(2,5,6),imshow(uint8(newImages(:,:,16)))
% subplot(2,5,7),imshow(uint8(newImages(:,:,17)))
% subplot(2,5,8),imshow(uint8(newImages(:,:,18)))
% subplot(2,5,9),imshow(uint8(newImages(:,:,19)))
% subplot(2,5,10),imshow(uint8(newImages(:,:,200)))



for i=1:size(images,1)
    x=uint8(reshape(images(i,:),[27,18]))
    x=enhanceContrastPL(x,0.7);
    x=histeq(x);
    %x=noiseReduction(x,1);
    x=reshape(x,[1,486])
    images(i,:)=x;
end

figure(1)
subplot(2,2,1),imshow(uint8(reshape(images(1,:),[27,18])))
% 
% model=SVMtraining(images,labels)
% x=reshape(images(2,:),[27,18])
% [prediction maxi]=SVMDetection(x,model);


figure(3)
subplot(2,2,1),imshow(uint8(reshape(images(1,:),[27,18])))