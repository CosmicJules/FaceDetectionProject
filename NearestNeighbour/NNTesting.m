function prediction = NNTesting(testImage, modelNN)
    closestDist = Inf;
    closestLab = -1;
    
    %iterate through neiughbours, find distance from input image to each
    %neighbour, smallest distance is input into closestDist and its
    %corresponding label is added to closestLab
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