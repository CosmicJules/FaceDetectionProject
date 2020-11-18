function Iout = enhanceBrightness(Iin,c)
    Lut = brightnessLut(c);
    Iout = intlut(Iin,Lut);
end