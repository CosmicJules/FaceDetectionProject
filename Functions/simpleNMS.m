function returnBoxes = simpleNMS(givenBoxes,threshold)


returnBoxes = double.empty;

for k=1:size(givenBoxes,1)
    currentRectangle = givenBoxes(k,:);
    add=true

    currentArea = currentRectangle(3)*currentRectangle(4);
    
    % Loop over every other rectangle to determine intersection
    for j=1:size(givenBoxes,1)
        currentIntersection = rectint(currentRectangle(1:4),givenBoxes(j,1:4));
        
        % If the rectangles intersect (k is not j i.e. not the same rectangle)
        if k ~= j && currentIntersection > 0
            
            % Delete
            if (currentIntersection / currentArea) > threshold
                    add=false;
            end
        end
    end
    if(add==true)
        returnBoxes(k,:)=currentRectangle(1:4);
    end
end


end
