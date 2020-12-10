function [faceDetections] = NNDetector(image,model)
%find total size of input image, allocate arrays for results and bounding
%boxes
    [width, height] = size(image);
    results = double.empty;
    detect = double.empty;
    index = 1;
    %sizes array enables multi scale detecting, one size i.e. [27,18] means
    %single scale
    sizes=[27,18];
    
    for j=1:size(sizes)
        %set search window size based on sizes array
        windowWidth=sizes(j,2)
        windowHeight=sizes(j,1)
        %for loop to iterate through the image moving one pixel across at a
        %time then one pixel down at a time, ensures no pixels are missed
        %out when searching for a face
        for y = 1:width-windowWidth   
            for x = 1:height-windowHeight
                search = [x, y, windowWidth-1, windowHeight-1];
                img = imcrop(image, search);
                img=imresize(img,[27,18]);
                %inputs image from window into NNTesting to evaluate if
                %image contains a face
                img = double(reshape(img, [1, 486]));
                [results(index)] = NNTesting(img,model);
                detect(index, 1:4) = [x,y,windowWidth,windowHeight];
                index = index+1;
            end
        end
    end

    %only results that contain faces are returned
    faceDetections = detect(results == 1, :);
    
    %smaller threshold - fewer boxes
    %boxes passed through simpleNMS to remove duplicates (i.e. overlapping
    %boxes)
    faceDetections = simpleNMS(faceDetections,0.45);
end