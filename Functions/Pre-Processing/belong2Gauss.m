function belonging = belong2Gauss(distance, sd, threshold)
    belonging = (distance/sd) <= threshold;
end