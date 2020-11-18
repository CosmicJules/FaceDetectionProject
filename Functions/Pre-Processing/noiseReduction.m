function Iout = noiseReduction(I,N)
mask=ones(N,N)/(N*N);
Iout=imfilter(I,mask);
end

