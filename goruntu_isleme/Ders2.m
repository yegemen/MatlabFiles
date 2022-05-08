% Ders 2 - Pikseller
% Histogramlar ve Esikleme
clc; close all; clear

% (7) gamma duzeltmesi - imadjust
A = imread('cameraman.tif');           %Read in image
figure('units','normalized','outerposition',[0 0 1 1])
subplot(1,2,1), imshow(A);             %Display image
B = imadjust(A, [0 1], [0 1], 0.5);    %Gamma duzeltmesi A goruntusunu 0 1 dinamik araligindan 0 1 dinamik araligina
%gama d�zeltmesini 0.5 uygulayarak yap diyoruz.
subplot(1,2,2), imshow(B);             %Display result 

% (8) Piksel Dagilimlari (Histogram)
 
 I = imread('coins.png');                 %Read in image
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(1,2,1), imshow(I);               %Display image
 subplot(1,2,2), imhist(I);               %Display histogram 
 [counts, bins] = imhist(I);
 counts(60);                  %Query 60th bin value
 
 % (9) Global esikleme
 T = graythresh(I);
 It = imbinarize(I,T);
 imshow(It);
 
 % (10) Adaptive (Lokal) esikleme
 I  = imread('rice.png');                %Read in image
 h  = fspecial('average', [15 15]);      %mean filter, N=15
 Im = imfilter(I, h, 'replicate');       %Create mean image = Im
 It = I - (Im + 20);        %Subtract mean image (+ constant C=20) 
 % bu islemin sonucunda tek tepeli bir dagilim ciktigindan 
 % T=0 esik degeri olarak kullanilir.
 Ibw = imbinarize(It, 0);   %Threshold result at 0 (keep + results only)
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(1,3,1), imshow(It);                %Display image 
 subplot(1,3,2), imshow(Ibw);              %Display result 
 % global esikleme
 T  = graythresh(I);
 Ig = imbinarize(I,T);
 subplot(1,3,3), imshow(Ig);
 
 % Medyan filtresi
 I_med = medfilt2(I,[20 20]);
 It = I - (I_med + 20);        %Subtract mean image (+ constant C=20) 
 % bu islemin sonucunda tek tepeli bir dailim ciktigindan 
 % T=0 esik degeri olarak kullanilir.
 Ibw = imbinarize(It, 0);   %Threshold result at 0 (keep + results only)
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(1,3,1), imshow(It);                %Display image 
 subplot(1,3,2), imshow(Ibw);              %Display result 
 
 % Max-min filter
 localMax = colfilt(I, [25 25],'sliding', @max);
 localMin = colfilt(I, [25 25],'sliding', @min);
 t = floor((localMax-localMin)/2) + 20;
 It = I - t;        %Subtract mean image (+ constant C=20) 
 % bu işlemin sonucunda tek tepeli bir dagilimm ciktigindan 
 % T=0 esik degeri olarak kullanilir.
 Ibw = imbinarize(It, 0);   %Threshold result at 0 (keep + results only)
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(1,3,1), imshow(It);                %Display image 
 subplot(1,3,2), imshow(Ibw);              %Display result 
 
 % (11) Kontrast genisletme
 Iin = imread('pout.tif');
 [counts, ~] = imhist(Iin);
 Id = im2double(Iin);
 c = max(Id(:));
 d = min(Id(:));
 Iout = (Id - 0.625)*(1. - 0.)/(0.625 - 0.3125) + 1.;
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(1,2,1), imshow(Iin);               %Display image 
 subplot(1,2,2), imshow(Iout);              %Display result
 
 Ics = imadjust(Iin, stretchlim(Iin, [0.05 0.95]), []); 
 %Stretch consrast using method 1
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(2,2,1), imshow(Iin);                   %Display image 
 subplot(2,2,2), imshow(Ics);                   %Display result 

 subplot(2,2,3), imhist(Iin);                %Display input histogram 
 subplot(2,2,4), imhist(Ics);              %Display output histogram 

 % (12) Histogram esitleme
 I = imread('pout.tif');            %Read in image
 Ieq = histeq(I);                   %Create histogram equalized image
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(2,2,1), imshow(I);         %Display image 
 subplot(2,2,2), imshow(Ieq);       %Display result 
 subplot(2,2,3), imhist(I);         %Display histogram of image 
 subplot(2,2,4), imhist(Ieq);       %Display histogram of result 
 
 % (13) Histogram eslestirme
 I = imread('pout.tif');                     %Read in image
 pz = 0:255;                                 %Define ramp like pdf as desired output histogram
 Im = histeq(I, pz);                         %Supply desired histogram to perform matching
 figure('units','normalized','outerposition',[0 0 1 1])
 subplot(2,3,1), imshow(I);                  %Display image 
 subplot(2,3,2), imshow(Im);                 %Display result 
 subplot(2,3,3), plot(pz);                   %Display distribıtion 
 subplot(2,3,4), imhist(I);                  %Display histogram of image 
 subplot(2,3,6), imhist(Im);                 %Display histogram of result 


 
 
 
 
 
 
 
 
 
