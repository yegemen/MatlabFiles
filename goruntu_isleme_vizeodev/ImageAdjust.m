function ImageAdjust(imagefile)

%fonksiyona goruntu dosyasinin adi verilmeli, 
%ornek:ImageAdjust('cameraman.tif')

I = imread(imagefile); %goruntuyu okuyorum
sinif = class(I); %veri tipini aliyorum
[a,b] = size(I); %boyutlari aliyorum
Iout(1:a,1:b)=0; %ayni boyutta yeni matris olusturuyorum.

switch sinif %veri tipine gore max,min degerlerini atiyorum
    case('uint8')
        minIout = 0;
        maxIout = 255;
    case('uint16')
        minIout = 0;
        maxIout = 65535;
    case('double')
        minIout = 0;
        maxIout = 1;
    otherwise
        error('Hata')
end

for x=1:a
    for y=1:b
        Iout(x,y) = minIout + ( (I(x,y)-min(I(:))) / (max(I(:))-min(I(:))) ) * (maxIout-minIout);
    end
end
%for dongusunde, soruda verilen formulu uyguladim.

Iout = uint8(Iout);
imshow(Iout,[]);