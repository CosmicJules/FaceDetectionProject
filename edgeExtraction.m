function [Edges,Ihor,Iver] = edgeExtraction(Iin,B1,B2)
Ihor = double(conv2(Iin,B1));
Iver = double(conv2(Iin,B2));
Edges = sqrt(Iver.^2+Ihor.^2);

% figure(10)
% subplot(1,3,1)
% imshow(Ihor)
% subplot(1,3,2)
% imshow(Iver)
% subplot(1,3,3)
% imshow(Edges)
end