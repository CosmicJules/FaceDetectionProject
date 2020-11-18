function Iout = myconvolution( Iin,B )
  [rows,cols] = size(Iin);

  %padded matrix
  new_img = zeros(rows+2,cols+2);
  new_img = cast(new_img, 'uint8');

  %original image to padded result
  new_img(2:end-1,2:end-1) = Iin;

  %create new output image the same size as the padded result
  Iout = zeros(size(new_img));
  Iout = cast(Iout, 'uint8');

  for i=2:1:rows+1
    for j=2:1:cols+1
      value=0;
      for g=-1:1:1
        for l=-1:1:1
          value=value+new_img(i+g,j+l)*B(g+2,l+2); 
        end
      end
     Iout(i,j)=value;
    end
  end
end