function Lut = segmentImageLUT(Thres)
Lut=zeros(256,1);
for i=1:256
    curVal=i;
    if curVal <= Thres
        curVal=256;
    else
        curVal=1;
    end
    Lut(i)=curVal;
end
Lut=uint8(Lut);
end