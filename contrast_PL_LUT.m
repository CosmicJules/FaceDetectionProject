function Lut = contrast_PL_LUT(gamma)

Lut = [0:255]

Lut = (Lut.^gamma)/(255.^(gamma-1))

Lut = uint8(Lut);