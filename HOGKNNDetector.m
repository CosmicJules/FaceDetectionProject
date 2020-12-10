function [faceDetections] = KNNDetector(image,model,K)
%find total size of input image, allocate arrays for results and bounding
%boxes
    [width, height] = size(image);
    results = double.empty;
    detect = double.empty;
    index = 1;
    %sizes array enables multi scale detecting, one size i.e. [27,18] means
    %single scale
    sizes=[27,18;18,12];

    for j=1:size(sizes)
        windowWidth=sizes(j,2)
        windowHeight=sizes(j,1)
        for y = 1:width-windowWidth
            for x = 1:height-windowHeight
                search = [x, y, windowWidth-1, windowHeight-1];
                img = imcrop(image, search);
                img=imresize(img,[27,18]);
                %img=edgeExtraction(img,7,7)
%                 img = double(reshape(img, [1, 486]));

                %inputs image from window into KNNTesting to evaluate if
                %image contains a face
                img = hog_feature_vector(img);
                [results(index), distance(index)] = KNNTesting(img,model,K);
                detect(index, 1:5) = [x,y,windowWidth,windowHeight,distance(index)];
                index = index+1;
            end
        end
    end


    %only results that contain faces are returned
    faceDetections = detect(results == 1, :);

    %smaller threshold - fewer boxes
    %boxes passed through simpleNMS to remove duplicates (i.e. overlapping
    %boxes)
    faceDetections = KNNsimpleNMS(faceDetections,0.3);
end