function [w1, mean1, sd1] = UpdateGMM(w0, mean0, sd0, alpha, pixVal)
    if nargin<5
        w1 = (1-alpha) * w0;
        mean1 = mean0;
        sd1 = sd0;
        
    else
        w1 = (1-alpha)*w0 + alpha;
        mean1 = (1-(alpha/w1))*mean0+(alpha/w1)*pixVal;
        sd1 = sqrt((1-(alpha/w1))*(sd0^2)+(alpha/w1)*(pixVal-mean1)^2);
    end
end
