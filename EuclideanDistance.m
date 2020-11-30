function dEuc = EuclideanDistance(sample1, sample2)
    sum = 0;
    for i=1:size(sample1)
        sum = sum + (sample1(i)-sample2(i))^2;
    end
    dEuc = sqrt(sum);
end