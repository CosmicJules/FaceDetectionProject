function returnBoxes = simpleNMS(givenBoxes,threshold)


returnBoxes = givenBoxes;
toDelete = [];

for k=1:size(givenBoxes,1)
    currentRectangle = givenBoxes(k,:);

    currentArea = currentRectangle(3)*currentRectangle(4);
    
    % Loop over every other rectangle to determine intersection
    for j=1:size(givenBoxes,1)
        currentIntersection = rectint(currentRectangle(1:4),givenBoxes(j,1:4));
        
        % If the rectangles intersect (k is not j i.e. not the same rectangle)
        if k ~= j && currentIntersection > 0
            
            % Delete
            if (currentIntersection / currentArea) > threshold
                if (currentRectangle(5) > givenBoxes(j,5))
                    toDelete = [toDelete,j];
                else
                    toDelete = [toDelete,k];
                end
            end
        end
    end
end


%delete in descending order
toDelete = sort(unique(toDelete),'descend');

if ~isempty(toDelete)
    % Delete all unnecessary rectangles
    for k=1:size(toDelete,2)
        returnBoxes(toDelete(k),:)=[];
    end
end


end
