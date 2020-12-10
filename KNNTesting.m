function [prediction totalDist] = KNNTesting(testImage, modelNN, K)
    %allocating arrray to stroe euclidian distance between test image and
    %each neighbour, also an array to store each neighbours label
    distances = zeros(size(modelNN.neighbours,1));
    labels=zeros(size(modelNN.labels,1));

    %iterate through neighbours and calculate distance between input image
    %and each neighbour
    for i = 1:size(modelNN.neighbours)
        x=modelNN.neighbours(i,:);
        labels(i) = modelNN.labels(i,:);
        distance=EuclideanDistance(testImage,x);
        distances(i) = distance;
    end
    
    %sort distances by size, then use sorting index to sort corresponding
    %labels
    [distances, sortIdx]=sort(distances,'ascend');
    labels=labels(sortIdx);

    facesCount=0;
    nonFaceCount=0;

    
    %iteraet through K number of distances to find number of faces and
    %number of non faces, also total distance is calculated to use as a
    %confidence for NMS
    nonFaceDistance=0;
    facesDistance=0;
    for i=1:K
        if labels(i)==-1
            nonFaceCount=nonFaceCount+1
            nonFaceDistance=nonFaceDistance+distances(i)
        else
            facesCount=facesCount+1
            facesDistance=facesDistance+distances(i)
        end
    end

    %higher number of faces in nearest neighbours = face, otherwise not a
    %face
    if facesCount>nonFaceCount
        prediction=1;
    else
        prediction=-1;
    end

    
    totalDist=facesDistance;
end