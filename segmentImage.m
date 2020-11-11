function Iout = segmentImage(Iin,Thres)
    Lut = segmentImageLUT(Thres);
    Iout = intlut(Iin,Lut);
end