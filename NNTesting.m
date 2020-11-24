function prediction = NNTesting(testImage, ModelNN)

%here we will predict what class (face/non-face)

testArray = [size(ModelNN),1];
testArrayLabels = [size(ModelNN),1];

for i = 1 : size(ModelNN)
    testArray(i,1) = EuclideanDistance(testImage, ModelNN.neighbours(i));
    %testArrayLabels(i,1) = ModelNN.label(i);
end

%sort testArray TOP END

 temp = 0;

for i = size(testArray) : -1:1
    
    current = i;
    next = i - 1;
    
    while (testArray(current) < testArray(next)) && (next> 0)
        %switch position current, next
        temp = testArray(current);
        testArray(current) = testArray(next);
        testArray(next) = temp;
        
        %switch corresponding labels
        tempLabel = testArrayLabels(current);
        testArrayLabels(current) = testArrayLabels(next);
        testArrayLabels(next) = tempLabel;
        
        %increment positions in array
        current = current - 1;
        next = next - 1;
         
    end
end

%Sorting testArray BOTTOM END
for i = 1 : size(testArray)
    
    current = i;
    next = i + 1;
    
    while (testArray(current) > testArray(next)) && (next < size(testArray))
        %switch position current, next
        temp = testArray(current);
        testArray(current) = testArray(next);
        testArray(next) = temp;
        
        %switch corresponding labels
        tempLabel = testArrayLabels(current);
        testArrayLabels(current) = testArrayLabels(next);
        testArrayLabels(next) = tempLabel;
        
        %increment positions in array
        current = current + 1;
        next = next + 1;
         
    end
end

prediction = testArrayLabels(1);

% for i = 1 : size(testArray)
%     j = i + 1;
%     if testArray(i) > testArray(i + 1)
%         %switch position i, i + 1
%         temp = testArray(i);
%         testArray(i) = testArray(i + 1);
%         testArray(i + 1) = temp;
%         
%         %switch corresponding labels
%         tempLabel = testArrayLabels(i);
%         testArrayLabels(i) = testArrayLabels(i + 1);
%         testArrayLabels(i + 1) = tempLabel;
%     else
%         %do nothing
%     end
% end
