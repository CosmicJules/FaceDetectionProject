function prediction = NNTesting(testImage, modelNN)
    closestDist = Inf;
    closestLab = -1;
    size(modelNN.neighbours,1)
    for i = 1:size(modelNN.neighbours,1)
        x=modelNN.neighbours(i,:);
        distance=EuclideanDistance(testImage,x);
        if distance<closestDist
            closestDist=distance;
            closestLab=modelNN.labels(i);
        end
    end
    testImage=closestLab;
    prediction=testImage;
end