% Ders3
clc;clear;close all

%1 Komsuluk uzerinde filtreleme
A = imread('cameraman.tif');       %Read in image
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imshow(A);         %Display image
func = @(x) mean(x(:));            %Set filter to apply
% @(x) x e bagli fonksiyon olusturmak icin, mean(x(:); veya mean2(x) x
% dizisinin ortalamasini hesaplamak icin.
B = nlfilter(A, [3 3], func);      %Apply over 3x3 neighbourhood
%3x3 luk matrisin ortalama degerini hesapla, bu ortalama deger hesabindan
%sonra buldugun degeri i,j ninci elemana hedef piksele yerlestir diyor.
% A goruntusu 0-255 araliginde degerlerle olusturulmus, ancak B sonucunda
% double duyarlikli bir matris olusacak.
subplot(1,2,2), imshow(B,[])       %Display result image B 
% [] koymamizin sebebi goruntunun dinamik araliginda bunu ciz, yani sonuc
% double da olsa bunu veriyor. eger double istemiyorsak 
% func = @(x) uint8(mean(x(:)); seklinde func u tanimlamaliydik.

%func = @(x) max(x(:)); seklinde yapsaydik 3x3 luk blok icindeki en buyuk
%degeri merkezdeki hedef piksele koyardik. veya min yapabilirdik. nlfilter
%fonksiyonu yardimiyla farkli seyler yapabiliriz. 5x5 de yapabilirdik.

%2 Dogrusal Konvolisyon Filtreleme
A = imread('peppers.png');            %Read in image 
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imshow(A);            %Display image 	
%k = fspecial('prewitt');     % Filtremizin cekirdegi
%k = fspecial('motion',50,54) % 50 lik yer al 54 derece dondur. (motion
%bulaniklastirma) farkli sekilde kullanimlari da var fspecial in.
k = 1./9*ones(3); % filtre degerini bu sekilde kendimiz de belirleyebiliyoruz.
% Create a motion blur convolution kernel 
B = imfilter(A, k, 'symmetric'); % goruntu,uygulanacak filtre, kenardaki piksellerin cozumu
% Apply using symmetric mirroring at edges 
% imfilter komutuyla uretilen cekirdegi goruntuye uyguladik. 
subplot(1,2,2), imshow(B);           %Display result image B 

%3 Gurultu ekleme
%imnoise fonksiyonu ile gurultu eklenir,
%(goruntu,gurultu_tipi,gurultu_yogunlugu)
I = imread('eight.tif');            %Read in image	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(I);          %Display image
title('Original image')
Isp = imnoise(I,'salt & pepper',0.03);%Add %3 (0.03) salt and pepper noise
subplot(1,3,2), imshow(Isp);        %Display result image Isp
title('Salt and pepper noise image')
Ig = imnoise(I, 'gaussian', 0.02);  %Add Gaussian noise(with 0.02 variance)
subplot(1,3,3), imshow(Ig);         %Display result image Ig
title('Gaussian noise image')

% 4 Ortalama Filtre
k = ones(3,3)/9.;                 %Define mean filter, 3x3 luk matris olusturup 9 a bolduk.
%imfilter ile olusturugumuz k goruntulere uygulandi.
I_m = imfilter(I, k);             %Apply to original image
Isp_m = imfilter(Isp, k);         %Apply to salt and pepper image	
Ig_m = imfilter(Ig, k);           %Apply to Gaussian image	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(I_m);      %Display result image
subplot(1,3,2), imshow(Isp_m);    %Display result image
subplot(1,3,3), imshow(Ig_m);     %Display result image
%ortalama filtrenin dezavantaji, kenar bolgelerde hasara yol acar.

% 5 Medyan Filtre
% medfilt2(goruntu,bolge) , 3x3 luk bolge aldik, o bolgedeki butun
% pikselleri kucukten buyuge siraliyor, ve ortadaki pikseli medyan degeri
% olarak dondurup merkezdeki hedef pikselin yerine yerlestirdik.
I_m = medfilt2(I, [3 3]);        %Apply to original image
Isp_m = medfilt2(Isp, [3 3]);    %Apply to salt and pepper image	
Ig_m = medfilt2(Ig, [3 3]);      %Apply to Gaussian image	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(I_m);     %Display result image
subplot(1,3,2), imshow(Isp_m);   %Display result image
subplot(1,3,3), imshow(Ig_m);    %Display result image

% 6 Sira Filtresi
I_m = ordfilt2(I, 9, ones(3));      %Apply to original image
Isp_m = ordfilt2(I,1,[0 1 0; 1 0 1; 0 1 0]);    %Apply to salt and pepper image	
Isp_m = Isp_m(2:end-1,2:end-1);
Ig_m = ordfilt2(Ig, 9, ones(3));    %Apply to Gaussian image	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(I_m)          %Display result image
subplot(1,3,2), imshow(Isp_m)        %Display result image
subplot(1,3,3), imshow(Ig_m)         %Display result image
% sira filtresi bulundugu pikselin komsularina bakiyor, komsularinin maks
% degerinden buyukse komsularinin maks degeri atiyor, minimum degerinden
% dusukse minimum degeri ile degistiriliyor.

% 7 Gauss Filtresi
% fspecial ile uretiyoruz, boyutunu ve standart sapmasini tanimliyoruz.
k = fspecial('gaussian', [7 7], 1.5);  %Define Gaussian filter
I_g = imfilter(I, k);                %Apply to original image
Isp_g = imfilter(Isp, k);            %Apply to salt and pepper image	
Ig_g = imfilter(Ig, k);              %Apply to Gaussian image	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(I_g)          %Display result image
subplot(1,3,2), imshow(Isp_g)        %Display result image
subplot(1,3,3), imshow(Ig_g)         %Display result image

% 8 Kenar algilama filtreleri
I = imread('circuit.tif');              %Read in image
IEr = edge(I, 'roberts');               %Roberts edges
IEp= edge(I, 'prewitt');                %Prewitt edges	
IEs = edge(I, 'sobel');                 %Sobel edges	
subplot(2,2,1), imshow(I)               %Display image
subplot(2,2,2), imshow(IEr)             %Display result image
subplot(2,2,3), imshow(IEp)             %Display result image
subplot(2,2,4), imshow(IEs)             %Display result image
