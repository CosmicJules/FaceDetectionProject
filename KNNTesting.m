function [prediction totalDist] = KNNTesting(testImage, modelNN, K)
    distances = zeros(size(modelNN.neighbours,1));
    labels=zeros(size(modelNN.labels,1));

    for i = 1:size(modelNN.neighbours)
        x=modelNN.neighbours(i,:);
        labels(i) = modelNN.labels(i,:);
        distance=EuclideanDistance(testImage,x);
        distances(i) = distance;
    end
    [distances, sortIdx]=sort(distances,'ascend');
    labels=labels(sortIdx);

    facesCount=0;
    nonFaceCount=0;

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

    if facesCount>nonFaceCount
        prediction=1;
    else
        prediction=-1;
    end

    
    totalDist=facesDistance;
end