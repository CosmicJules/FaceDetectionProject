function Lut = contrast_HE_LUT(Iin)
a=histcounts(Iin)
b=cumsum(a)
Lut=zeros(256,1);
for i=1:256
    curVal=i;
    curVal=0,(256*b(i))/(256*256)-1;
    curVal=max(curVal);
    curVal=round(curVal);
    Lut(i)=curVal;
end
Lut=uint8(Lut);
end

