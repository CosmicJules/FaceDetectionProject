function Lut = contrast_LS_LUT(m,c)
Lut=zeros(256,1);
for i=1:256
    curVal=i;
    if curVal < -c/m
        curVal=1;
    end
    if curVal>(256-c)/m
        curVal=256;
    end
    Lut(i)=(curVal*m)+c;
end
Lut(i)=curVal;
Lut=uint8(Lut);
end
