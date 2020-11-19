function [faceDetections] = SVMDetector(image,model)
    [width, height] = size(image);
    results = double.empty;
    detect = double.empty;
    index = 1;
    for y = 1:width-27   
        for x = 1:height-18
            search = [x, y, 17, 26];
            img = imcrop(image, search);
            img = double(reshape(img, [1, 486]))
            results(index) = SVMTesting(img,model);
            detect(index, 1:4) = [x,y,18,27];
            index = index+1;
        end
    end
    
    
    faceDetections = detect(results == 1, :);
    
    %faceDetections = simpleNMS(faceDetections,0.1);
end