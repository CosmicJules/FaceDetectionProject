function prediction = KNNTesting(testImage, modelNN, K)
    closestDist = Inf;
    closestLab = -1;
    K = [1 , 3, 5 , 10]
    distances = zeros(size(modelNN.neighbours,1));
    
    for i = 1:size(modelNN.neighbours)
        x=modelNN.neighbours(i,:);
        y = modelNN.labels(i,:);
        distance=EuclideanDistance(testImage,x);
        distances(i) = distance;
        
        if distance<closestDist
            closestLab= y
            closestDist=distance
        end
    end
    
    fuds=sort(distances)
    testImage=closestLab;
    prediction=testImage;
end