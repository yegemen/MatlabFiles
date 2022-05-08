% Ders 1 - Piksel
% Piksel islemleri
clc; close all; clear
% close all pencereleri kapatir
% (1) Goruntuye sabit bir deger ekleme
A = imread('cameraman.tif'); % Read image, camaraman.tif görüntüsü okundu ve ortaya cikan A görüntüsü bir matris olarak alindi ve bu görüntüdeki her bir pikselin degerini bize tanimladi.
figure(1)
subplot(1,2,1), imshow(A) % Display image
% subplot ile figure penceresini istedigimiz gibi bölüyoruz. 1 satir 2 sutun ve
% ilk elemanina A yi koyduk
title('Original Image') % resime baslik yazisi

%B = imadd(A, 100); % Add 100 to each pixel value
B = A + 100; % A matrisinin tum elemanlarina 100 ekler.
subplot(1,2,2), imshow(B) % Display image
title('Result Image')

% (2) Goruntuden baska bir goruntu cikarma (hareket algilama)
A = imread('cola1.png');
B = imread('cola2.png');

figure(2)
subplot(1,3,1), imshow(A) % Display image
title('First Image')
subplot(1,3,2), imshow(B) % Display image
title('Second Image')

Output1 = imsubtract(A,B); % Output = A - B tasma problemini cozer
subplot(1,3,3), imshow(Output1) % Display image
title('Difference Image')

% Output2 = imabsdiff(A,B); % Output = A - B tasma problemini cozer
% subplot(1,3,3), imshow(Output2) % Display image
% title('Difference Image')

% (3) Goruntu piksellerini sabitle carpma veya
% diger bir goruntuye bolme
A = imread('cameraman.tif'); % Read image
A = im2double(A); % Goruntu araligini [0,255] -> [0,1]
B = A + 0.35;
figure(3)
subplot(1,3,1), imshow(A) % Display image
title('Original Image')
Output1 = A*1.5;
subplot(1,3,2), imshow(Output1)
title('Original Image*1.5')
%Output2 = A/4;
Output2 = imdivide(A,B);
subplot(1,3,3), imshow(Output2)
title('Original Image/B')

% (4) Mantiksal islemler - Not, Or, AND
A = imread('cameraman.tif'); % Read image
figure(4)
subplot(1,2,1), imshow(A) % Display image
title('Original Image')
%B = imcomplement(A); % 255 - A (incomplement tumleyenini alir)
B = 255 - A; % goruntunun negatifini aliyoruz. imcomplement ile aynisi
subplot(1,2,2), imshow(B) % Display image
title('NOT Image')

A = imread('toycars1.png');         %Read in 1st image
B = imread('toycars2.png');         %Read in 2nd image
Abw = imbinarize(A(:,:,1));         %Convert to binary , (3 boyutlu matrisi tek boyuta çevirdik)
Bbw = imbinarize(B(:,:,1));         %Convert to binary
figure(5)
subplot(1,3,1), imshow(Abw) % Display image
subplot(1,3,2), imshow(Bbw) % Display image
%Output = xor(Abw,Bbw); % hareket eden nesneleri tespit etme
Output = and(Abw,Bbw); % goruntulerdeki farkliliklari tespit etme
subplot(1,3,3), imshow(Output) % Display image

% (5) Esikleme
I = imread('coins_and_keys.png');
bw1 = imbinarize(I(:,:,1), 0.41);
figure(6)
subplot(1,2,1), imshow(I) % Display image
subplot(1,2,2), imshow(bw1) % Display image
% esikleme tipik olarak arka fondan on fonun birbirinden ayrilmasini
% saglayan ikili bir goruntuye donusturme islemidir.

% (6) Goruntunun donusumleri
I = imread('cameraman.tif'); % Read image
figure(4)
subplot(2,2,1), imshow(I) % Display image
title('Original Image')
Id = im2double(I); % double duyarlilikli bir goruntuye donusturuyoruz, cunku logaritma islemi yaparken tam sayi degerleri ile islem
% yaptigimizda sonuclar istenildigi gibi cikmayacaktir. bunun reel sayi
% degerlerinde islemler yapildiginda dogru sonuclari verecegini
% dusunebiliriz. 
item = 1;
for c=[3,5,7]
    Output = c*log(1+Id);
    subplot(2,2,1+item), imshow(Output) % Display image
    str = ['c= ' num2str(c)];
    title(str)
    item = item + 1;
end



