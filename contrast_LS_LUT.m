function Lut = contrast_LS_LUT(m, c)

Lut = [0:255];

for index=1:256                             %linear stretching function LUT
    if(Lut(index) < (-c/m))
        Lut(index) = 0
    elseif(Lut(index) > ((255-c)/m))
        Lut(index) = 255
    else
        Lut(index) = (m * Lut(index)) + c
    end
end
        
Lut = uint8(Lut);   