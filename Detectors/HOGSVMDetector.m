function [faceDetections] = SVMDetector(image,model)
    [width, height] = size(image);
    results = double.empty;
    detect = double.empty;
    index = 1;
    sizes=[27,18;];
    for j=1:size(sizes)
        windowWidth=sizes(j,2);
        windowHeight=sizes(j,1);
        for y = 1:width-windowWidth   
            for x = 1:height-windowHeight
                search = [x, y, windowWidth-1, windowHeight-1];
                img = imcrop(image, search);
               
                img=imresize(img,[27,18]);
                %img = double(reshape(img, [1, 486]));
                img = hog_feature_vector(img);
                        
%                 img=imresize(img,[27,18]);      
               
                [results(index), CONF(index)] = SVMTesting(img,model);
                detect(index, 1:5) = [x,y,windowWidth,windowHeight,CONF(index)];
                index = index+1;
            end
        end
    end

    
    faceDetections = detect(results == 1, :);
    
    %smaller threshold - fewer boxes
    faceDetections = simpleNMS(faceDetections,0.25);
end