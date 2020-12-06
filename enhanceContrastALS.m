function [Iout, Lut] = enhanceContrastALS(Iin)

Imin = min(Iin(:)); %finds lowest value used
Imax = max(Iin(:)); %finds greatest value used

m = 255/(Imax - Imin); % calculates gradient
c = -1 * (m * Imin); % calculates y-axis intercept

Lut = [0:255];

for index=1:256                             %linear stretching function LUT
    if(Lut(index) < (-c/m))
        Lut(index) = 0;
    elseif(Lut(index) > ((255-c)/m))
        Lut(index) = 255;
    else
        Lut(index) = (m * Lut(index)) + c;
    end
end

LUT = uint8(Lut); %cast to int
Iin = uint8(Iin); %cast to int

Iout = intlut(Iin, LUT);