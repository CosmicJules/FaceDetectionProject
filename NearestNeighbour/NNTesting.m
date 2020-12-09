function prediction = NNTesting(testImage, modelNN)
    closestDist = Inf;
    closestLab = -1;
    
    
    for i = 1:size(modelNN.neighbours)
        x=modelNN.neighbours(i,:);
        y = modelNN.labels(i,:);
        distance=EuclideanDistance(testImage,x)
       
        if distance<closestDist
            closestLab= y;
            closestDist=distance;
        end
    end
    testImage=closestLab;
    prediction=testImage;
end