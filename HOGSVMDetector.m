function [faceDetections] = HOGSVMDetector(image,model)
    [width, height] = size(image);
    results = double.empty;
    detect = double.empty;
    index = 1;
    for y = 1:width-135   
        for x = 1:height-144
            search = [x, y, 134, 143];
            img = imcrop(image, search);
            img = double(reshape(img, [1, 19440]))
            HOGimg=hog_feature_vector(img)
            results(index) = SVMTesting(HOGimg,model);
            detect(index, 1:4) = [x,y,135,144];
            index = index+1;
        end
    end
    
    
    faceDetections = detect(results == 1, :);
    
    %faceDetections = simpleNMS(faceDetections,0.1);
end