% Ders4
clc;clear;close all

% 1 Kenar algilama Filtreleri
I = imread('circuit.tif');              %Read in image
IEr = edge(I, 'roberts');               %Roberts edges
IEp = edge(I, 'prewitt');               %Prewitt edges	
IEs = edge(I, 'sobel');                 %Sobel edges	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,2,1), imshow(I)               %Display image
title('Original image')
subplot(2,2,2), imshow(IEr)             %Display result image
title('Robert filtresi')
subplot(2,2,3), imshow(IEp)
title('Prewitt filtresi')
subplot(2,2,4), imshow(IEs)
title('Sobel filtresi')

%2 Birinci mertebeden turev (Sobel) ve ikinci mertebeden turev
% Laplasyen filtreleri
I = imread('trui.png');       % Read in image (in grey scale)
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1), imshow(I);
title('Original image')
I = double(I);                 % Convert image double 
%laplas operatoru turev operatoru oldugu icin 8 bitlik goruntu islemlerinde
%hassas duyarlikli islem yapamayacagi icin daha iyi hesap yapabilecegimiz
%double duyarlikli goruntuyu aliyoruz.

h = fspecial('sobel');                % h = Sobel x-derivative (x yonundeki sobel turevi)
%fspecial bize ozel filtreleri olusturuyor, sobel i cagirdik.
Gxs = imfilter(I, h);     
%x yonundeki sobel filtresini, x yonundeki goruntudeki degisimleri,
%x yonundeki goruntunun piksel yogunlugundaki degisimleri buluyor.
subplot(2,3,2), imshow(Gxs,[]);
title({'x-derivative'; '(Sobel)'})
Gys = imfilter(I, h');                % h' = Sobel y-derivative	
subplot(2,3,3), imshow(Gys,[]);
title({'y-derivative'; '(Sobel)'})
Gm = sqrt(Gxs.^2 + Gys.^2);           % Gm = abs(Gxs) + abs(Gys);
% x ve y yonundeki degisimlerin siddetinin olcusu olan sey, bu degisimlerin
% mutlak degerlerinin toplami veya karelerinin toplami
subplot(2,3,4), imshow(Gm,[]);
title('Gradient Magnitude of Sobel filters')
% x yonundeki degisim, y yonundeki degisim ve bunlarin toplam gradyentin
% buyuklugu olarak baktigimiz zaman goruntumuzun kenarlarini kalin olarak
% cizen bir goruntu veriyor.
% 1. mertebeden sobel operatorunun yaptigi islem kenarlari kalin olarak
% belirleme islemidir.

% Laplasyen filtre olusturma
%laplasyen ise gradyenin degisimi, x yonundeki gradyenin degisimini
%olcuyor, y yonundeki degisimin olcusunun toplamini bir skaler sayi olarak
%dondurdugu icin gradyendeki degisikleri ince cizgi olarak ekrana basiyor.
k = fspecial('laplacian',0);    
IL= imfilter(I, k, 'symmetric');     % Laplacian edges of 4-neighborhood	
subplot(2,3,5), imshow(IL,[]);
title({'Laplasyen'; '(Original Kernel)'})
% tam olarak olusturan fspecial komutunu bilmedigimizden el ile
% olusturacagiz:
Lkernel = -1 * ones(3); % ones 3x3 luk tum elemanlari 1 olan matris olusturup -1 ile carptik tum elemanlar -1 oldu
Lkernel(2,2) = 8;      % Rotated kernel = [-1,-1,-1; -1,8,-1; -1,-1,-1]
% Lapalcian kernel for 8-neighborhood
ILR= imfilter(I, Lkernel, 'symmetric'); % Laplacian rotated added	
% 8 komsuluga bakarak degisimler olculecektir.
subplot(2,3,6), imshow(ILR,[]);
title({'Laplasyen'; '(rotated added Kernel)'})

% 3 Laplasyen operatoru
%renkli goruntuye uygulamak
A = imread('peppers.png'); % Read in image (in grey scale)
%once goruntuyu gri olcekliye ceviriyoruz:
I = rgb2gray(A); % Read in image (in grey scale)
A = double(A); 
k = fspecial('laplacian');           % Create Laplacian filter
IEl= imfilter(A, k, 'symmetric');    % Laplacian edges	IEl= imfilter(I, k, 'symmetric');
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imagesc(I);          % Display image
axis image; axis off 
title('Original Image')
subplot(1,2,2), imagesc(uint8(IEl));        % Display image
colormap('gray');
axis image; axis off
title('Laplasyen filtrelenmis goruntu')
saveas(gcf,'Laplasyen1.png') % figure penceresindeki goruntuyu
% bulundugunuz dizine 'Laplasyen1.png' ismiyle kayit eder.

% 4 Gaussyenin Laplasyeni (LoG) filtresi 
% laplasyen filtresinin yuksek gurultuye karsi hassasiyetini ortadan
% kaldimak icin
%gausyen filtresinin yaptigi sey; goruntuyu yumusatiyor yani yogunluktaki
%gecisleri ani sureksizlikler gibi degil de daha hafif gecisler sagliyor.
I = rgb2gray(imread('peppers.png')); % Read in image (in grey scale)
k = fspecial('log',[10 10],2.0);     % Create LoG filter , 10x10 luk gausyen, standart sapma 2.0
IELoG= imfilter(I, k, 'symmetric');  % LoG edges	
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imagesc(I);          % Display image
axis image; axis off 
title('Original Image')
subplot(1,2,2), imagesc(IELoG);      % Display image
colormap('gray');
axis image; axis off
title('LoG filtrelenmis goruntu')
saveas(gcf,'Log1.png')

% 5 (LoG) filtresinin sifir gecis ile kenar algilanmasi 
I = rgb2gray(imread('peppers.png'));   %Read in image (in grey scale)
%renkli goruntuyu gri olcekli goruntuye cevirdik.
I = double(I); %hesaplamalari daha iyi duyarlilikta yapabilmek icin
k = fspecial('log', [25 25], 3.0);     %Create LoG filter
%log filtresi olusturup 25x25 lik ve 3 standart sapmali gausyenin oldugu
%log filtresi olusturuyoruz.
BW = edge(I,'zerocross',[],k); %Zero-crossing edges (auto thresholding)
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imshow(I,[]);             %Display image
title('Orijinal goruntu')
subplot(1,2,2), imshow(BW,[]);          %Display image        
title('Goruntunun sifirr gecis noktalari')
%laplasyenin 0 gecisine sahip oldugu pikselleri belirleyip bunlar?n kenar
%oldugunu bilerek ekrana bastirma islemi ile bir goruntudeki bir cesit
%nesneleri bolutlemis oluyoruz. nesnelerin kenar cizgilerini ortaya
%cikariyoruz.

% 6 Laplasyen kenar keskinlestirme
A = imread('cameraman.tif');         %Read in image
A = double(A);
h = fspecial('laplacian');    %Generate 3x3 Laplacian filter
ALap = imfilter(A, h);    %Filter image with Laplacian kernel
AOut = imsubtract(A, ALap);  %Subtract Laplacian from original image.
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(uint8(A),[]);           %Display image
subplot(1,3,2), imagesc(uint8(ALap)); axis image; axis off   
%Display original, Laplacian and 
subplot(1,3,3), imshow(uint8(AOut),[]);           %enhanced image

% 7 LoG kenar keskinlestirme
A = imread('cameraman.tif');         %Read in image
%A = double(A);
h = fspecial('log',[15 15],2.0);     % Create LoG filter	
B = imfilter(A, h, 'symmetric');    %LoG Filter image with Laplacian kernel
C = imsubtract(A, B);  %Subtract Laplacian from original image.
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,3,1), imshow(uint8(A),[]);           %Display image
subplot(1,3,2), imagesc(B); axis image; axis off 
colormap('gray')
%Display original, Laplacian and 
subplot(1,3,3), imshow(uint8(C),[]);           %enhanced image

tic
% 8 Keskin olmayan maske filtresi
Iorig = imread('cameraman.tif');      %Read in image
g = fspecial('gaussian', [5 5], 1.5); %Generate 5x5 Gaussian kernel
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,3,1), imshow(Iorig)   %Display Original image
title('Original Image')
Is = imfilter(Iorig, g);  %Create smoothed image by filtering
Ie = imsubtract(Iorig, Is);     %Get difference image
subplot(2,3,2), imshow(Ie)      %Display unsharp difference
title('Kenarlar = Original Image - Smoothed Image')
Iout = Iorig + (0.3)*Ie;%Add (0.3)*difference image to original.
subplot(2,3,3), imshow(Iout)                       
title('İyileştirilmiş = Original + 0.3*Kenarlar')
Iout = Iorig + (0.5)*Ie;%Add (0.5)*difference image to original.  
subplot(2,3,4), imshow(Iout)  
title('İyileştirilmiş = Original + 0.5*Kenarlar')
Iout = Iorig + (0.7)*Ie;%Add (0.7)*difference image to original.
subplot(2,3,5), imshow(Iout)
title('İyileştirilmiş = Original + 0.7*Kenarlar')
Iout = Iorig + (2.0)*Ie;%Add (2.0)*difference image to original.
subplot(2,3,6), imshow(Iout)
title('İyileştirilmiş = Original + 2.0*Kenarlar')
toc
