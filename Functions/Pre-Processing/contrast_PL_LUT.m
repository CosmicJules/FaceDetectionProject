function Lut = contrast_PL_LUT(gamma)
Lut=zeros(256,1);
for i=1:256
    curVal=i;
    curVal=((curVal)^gamma)/255^(gamma-1);
    curVal=round(curVal);
    Lut(i)=curVal;
end
Lut=uint8(Lut);
end
