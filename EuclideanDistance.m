function dEuc = EuclideanDistance(sample1, sample2) %testImage, modelNN
 
%this class will calculate and pass back the euclidean distance

dEuc = min(sqrt((sample1 - sample2) .^2));

