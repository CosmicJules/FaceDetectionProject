function returnBoxes = KNNsimpleNMS(givenBoxes,threshold)

returnBoxes = givenBoxes;
toDelete = [];

for k=1:size(givenBoxes,1)
    curRect = givenBoxes(k,:);
    
    curArea = curRect(3)*curRect(4);
    
    % Loop over every other rectangle and find intersections
    for j=1:size(givenBoxes,1)
        curIntersect = rectint(curRect(1:4),givenBoxes(j,1:4));
        
        % If they intersect
        if k ~= j && curIntersect > 0
            
            % Delete based on confidence
            if (curIntersect / curArea) > threshold
                if (curRect(5) >= givenBoxes(j,5))
                    toDelete = [toDelete,j];
                else
                    toDelete = [toDelete,k];
                end
            end
        end
    end
end

toDelete = sort(unique(toDelete),'descend');

if ~isempty(toDelete)
    % Delete all unnecessary rectangles
    for k=1:size(toDelete,2)
        returnBoxes(toDelete(k),:)=[];
    end
end


end