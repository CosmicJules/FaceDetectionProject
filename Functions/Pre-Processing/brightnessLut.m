function Lut = brightnessLut(c)
Lut=zeros(256,1);
for i=1:256
    curVal=i+c;
    if curVal < 1
        curVal=1;
    end
    if curVal>256
        curVal=256;
    end
    Lut(i)=curVal;
end
Lut(i)=curVal;
Lut=uint8(Lut);
end