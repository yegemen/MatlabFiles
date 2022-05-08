%% Morfolojik ??lemler-2

%% Ba?lant?l? bile?enlerin �?kar?lmas?
close all;clc;
bw = imread('basic_shapes.png');   %Read in binary(or logical) image
%baglantili bilesenleri belirlemek i�in bwlabel i siyah beyaz g�r�nt�ye
%uygulayabiliyoruz.
[L,num] = bwlabel(bw);         %Get labelled image and number of objects %L artan piksel degerleri, num baglantili bilesen sayisi
subplot(121), imshow(bw);
title('Orijinal G�r�nt�')
axis image; axis off;    %Plot binary input image
c1 = colorbar('Northoutside','Ticks',[0, 1]);
c1.Label.String = 'G�r�nt� renk skalas?';
subplot(122), imagesc(L);  %Display labelled image , etiketli g�r�nt�y� ekrana bast?r?yoruz.
title('Ba?lant?l? Bile?enli G�r�nt�')
axis image; axis off; colormap(parula(5))
c2=colorbar('Northoutside','Ticks',0:num);
c2.Label.String = 'Bile?en renk skalas?';
%saveas(gcf,'Connected_components_labelling.png') %save figure

%% Ba?lant?l? bile?elerin k�tle merkezini hesaplama ve g�sterimi.
f = imread('ten-objects.tif');
[L, num] = bwlabel(f);
imshow(f)
hold on % So later plotting commands plot on top of the image.
for k = 1:num
    [r, c] = find(L == k); % k etiketli bile?enin piksellerini bulma
    % Nesnelerin k�tle merkezlerini hesaplama
    meanr = mean(r);  meanc = mean(c);
    plot(meanc,  meanr, 'Marker', 'o', 'MarkerEdgeColor', 'r',...
         'MarkerFaceColor', 'r', 'MarkerSize', 4);
%     plot(meanc,  meanr, 'Marker', 'o', 'MarkerEdgeColor', 'r');
end

%% Kom?uluk tipinin ba?lant?l? bile?en say?s?na etkisi
%num degerleri degisiklik gosterir. bwlabel de verdigimiz komsuluk degerine
%gore.
f = zeros(8);
f(:,1:3)=1; f(2:3,5:6)=1; f(4:6,7)=1; f(7,6)=1;
subplot(131), imshow(f);
title('Orijinal G�r�nt�')
colorbar('Northoutside');
[L4,num4] =  bwlabel(f,4);
subplot(132), imagesc(L4);axis image; axis off; colormap(jet)
title({'4-ba?lant?l?l?k ile' [num2str(num4) ' bile?en elde edilir.']})
colorbar('Northoutside');
[L8,num8] =  bwlabel(f,8);
subplot(133), imagesc(L8);axis image; axis off; colormap(jet)
colorbar('Northoutside');
title({'8-ba?lant?l?l?k ile' [num2str(num8) ' bile?en elde edilir.']})

%% Ba?lant?l? bile?enlerin k�mesini tan?mlama
clear;close all;clc
f = imread('blob-clusters-1.png');
figure('Units','Normalized', 'OuterPosition', [0 0 1 1])
subplot(321), imshow(f)
title({'Orijinal g�r�nt�'})

[L1,num1] = bwlabel(f); % default 8-ba?lant?l?l?k
g1 = label2rgb(L1,'jet',[.7 .7 .7],'shuffle');
subplot(322), imshow(g1);
title({'?kili g�r�nt�n�n' 'ba?lant?l? bile?enleri'})

se = strel('disk',10);
f2 = imdilate(f,se);
subplot(323), imshow(f2)
title({'Geni?letilmi? ikili g�r�nt�n�n'})

[L2,num2] = bwlabel(f2);
g2 = label2rgb(L2,'jet',[.7 .7 .7],'shuffle');
subplot(324), imshow(g2)
title({'Geni?letilmi? ikili g�r�nt�n�n' 'ba?lant?l? bile?enleri'})

L3 = L2;
L3(~f) = 0; % f g�r�nt�s�ndeki t�m arka plan konumlar?na 0 ata.
g3 = label2rgb(L3,'jet', [.7 .7 .7],'shuffle');
subplot(325), imshow(g3)
title({'K�melemeye g�re renklendirilmi?' 'nesnelerle orijinal g�r�nt�'})
%saveas(gcf,[filepath 'Connected_components_bwconncom.png']) %save figure

%% sekil 1.16 Vur-yada-iskala
A = zeros(7,14);
A(3:5,3) = 1; A(4:6,5) = 1; A(5,4) = 1;
A(2:6,7) = 1; A(3:6,9) = 1; A(4:5,8) = 1;
A(2:3,11:13) = 1; A(5:6,13) = 1; A(5,12) = 1;
B1 = zeros(4,3);
B1(1:3,1) = 1; B1(3,2) = 1; B1(2:4,3) = 1;
Ae1 = imerode(A,B1); % vurmalar
[r,c] = find(Ae1 == 1);
figure('Units','Normalized', 'OuterPosition', [0 0 1 1])
subplot(221), imshow(Ae1)
hold on
plot(c,r,'r*')

Ae2 = imerode(~A,~B1); % iskalamalar
[r,c] = find(Ae2 == 1);
subplot(222), imshow(Ae2)
hold on
plot(c,r,'r*')
subplot(223), imshow(Ae1 & Ae2)

% veya bwhitmiss fonksiyonu kullanilarak
subplot(224), imshow(bwhitmiss(A,B1,~B1))

%% Vur-yada-iskala d�n�s�m�
A = imread('text.png');       %Read in text (binary image)
B = imcrop(A);                %Read in target shape interactively
%Perform the crop operation by double-clicking in the crop rectangle 
%or selecting Crop Image on the context menu.
se1 = B; se2 = ~B;            %Define hit and miss structure elements
bw = bwhitmiss(A,se1,se2);    %Perform hit miss transformation
%sectigimiz yapilandirma elemani ile ayni desene sahip konumlari bulduk.
[i,j] = find(bw == 1);        %Get explicit coordinates of locations
% 1 olan konumlar?n koordinatlarini bulduk.
figure,
subplot(131), imshow(A)       %Display image
title('Original g�r�nt�')
subplot(132), imshow(B); 
title('Hedef desen')
subplot(133), imshow(A);      % hedef desenin bulunduu yerler
hold on
plot(j,i,'r*') % konumlarin bulundugu yerlere kirmizi renkli yildiz basar.
title('Hedef desenin bulundu?u yerler')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Vur-yada-iskala d�n�s�m�: noisy image, onceki goruntunun gurultulu hali
A = imread('noisy_text.png'); %Read in text (binary image)
A = imbinarize(A(:,:,1));     %convert logical image
B = imcrop(A);                %Read in target shape interactively
%Perform the crop operation by double-clicking in the crop rectangle 
%or selecting Crop Image on the context menu.
se1 = B; se2 = ~B;            %Define hit and miss structure elements
bw = bwhitmiss(A,se1,se2);    %Perform hit miss transformation
[i,j] = find(bw == 1);        %Get explicit coordinates of locations
subplot(131), imshow(A)       %Display image
subplot(132), imagesc(B); 
axis image;axis off;          %Display target shape
subplot(133), imshow(A); 
hold on
plot(j,i,'r*')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Vur-yada-iskala d�n�s�m�--Umrumda degil
A = imread('Noisy_Two_Ls.png');    %Read in image
%CASE 1 
se1 = [0 0 0; 1 1 0; 0 1 0];       %se1 defines the hits
se2 = [1 1 1; 0 0 1; 0 0 1];       %se2 defines the misses
%e1 = imerode(A,se1);
% e2 = imerode(~A,se2);
% imshow(~e2)
bw = bwhitmiss(A,se1,se2);         %Apply hit or miss transform
subplot(321), imshow(A)            %Display Image
title('Original')
subplot(322), imshow(bw)           %Display located pixels
title('CASE 1')
%NOTE ALTERNATIVE SYNTAX
interval1 = [-1 -1 -1; 1 1 -1; 0 1 -1]; 
% 1's for hits, -1 for misses; 0s for don't care
bw1 = bwhitmiss(A, interval1);     %Apply hit or miss transform
subplot(323), imshow(bw1)          %Display located pixels
title('Altenatif CASE 1')
[r,c] = find(bw1 == 1);
hold on
plot(c,r,'r*')
%CASE 2
% se1 = [0 0 0; 0 1 0; 0 0 0];       %se1 defines the hits
% se2 = [0 1 1; 0 0 1; 0 0 0];       %se2 defines the misses
% Sadece bir piksellik g�r�lt�leri bulur.
interval2 = [0 -1 -1; 0 1 -1; 0 0 0];  
%1's for hits, -1 for misses; 0s for don't care
bw2 = bwhitmiss(A,interval2);  %Apply hit or miss transform
subplot(324), imshow(bw2)      %Display located pixels
title('G�r�lt� ve k�?e noktalar') 
subplot(325), imshow(A-(bw2-bw1))  %G�r�lt� kald?r?lm?? g�r�nt�
title('G�r�lt�s�z g�r�nt�') 
hold on
plot(c,r,'r*')
%saveas(gcf,[filepath 'hit_or_miss7.png'])  %Save figure

%% Morfolojik inceltme
A = imread('A.tif');
A = imbinarize(A);
subplot(121), imshow(A) 
I = bwmorph(A, 'skel', Inf); %goruntunun iskeletini cikartmak icin.
subplot(122), imshow(I) 
% figure,
% subplot(121), imshow(A) % Fig. (a)
% se1 = [0 0 0; 0 1 1; 0 1 0]; %se1 defines the hits
% se2 = [1 1 1; 1 0 0; 1 0 0]; %se2 defines the miss
% %interval = [-1 -1 -1; -1 1 1; -1 1 0];  
% iter=500;
% Aold = A;
% for i=1:iter
%     bw = bwhitmiss(A, interval);
%     thinAB = A & ~(bw);
%     A = thinAB;
% end
% subplot(122), imshow(thinAB) % Fig. (a)

%% �rnek-1 �esitli geometrik sekillerin iskeletleri
clear;close all;clc;
f = imread('basic_shapes.png');
figure,
subplot(121), imshow(f) % Fig. (a)
title('Original') 

s = bwmorph(f, 'skel', Inf); % Fig. (d)
subplot(122), imshow(s) % Fig. (c)
title('?skelet') 
%?skeletdeki �?k?nt?lar komutu kullanarak azalt?l?r.
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% �rnek-2 G�r�lt�l� g�r�nt�--iskelet �ikarma
clear;close all;clc;
I = imread('chromosome.tif');
f = im2double(I);
figure,
subplot(331), imshow(f) % Fig. (a)
title('Original') 
h = fspecial('gaussian', 50, 25);
g = imfilter(f, h, 'same');
subplot(332), imshow(g) % Fig. (b)
title('Smoothed image') 
%Sonra, d�zg�nlestirilmis g�r�nt�y� esiklileme:

g = imbinarize(g, 1.7*graythresh(g));
subplot(333), imshow(g) % Fig. (c)
title('Threshold image') 
%?skeleti �?karan komut:

s = bwmorph(g, 'skel', Inf); % Fig. (d)
subplot(334), imshow(s) % Fig. (c)
title('?skelet') 
%?skeletdeki �?k?nt?lar komutu kullanarak azalt?l?r.

s1 = bwmorph(s, 'spur', 30); % Fig. (e)
subplot(335), imshow(s1) % Fig. (c)
title('�?k?nt?lar? kald?r?lm?? iskelet') 
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
figure, imshow(s1)

%% Morfolojik a�ma-1
A = imread('open_shapes.png'); %Read in image
se = strel('disk',10); 
bw = imopen(A,se);             %Open with disk radius 10
subplot(1,3,1), imshow(A)
title('Orijinal g�r�nt�')      %Display original
subplot(1,3,2), imshow(bw)     
title('A�ma disk yar?�ap? = 10')
se = strel('square',25); 
Abw1 = imerode(A,se);
imshow(A-Abw1)
bw = imopen(A,se);             %Open with square side 25
subplot(1,3,3), imshow(bw)      
title('A�ma kare kenar? = 25')

%% Morfolojik a�ma-3: ?stenmeyen g�r�lt�y� kald?rma
A = imread('Noisy_Two_Ls.png');  
se = strel('square',2);
imgopennig = imopen(A,se);
figure,
subplot(131), imshow(A)
title('G�r�lt�l� g�r�nt�')      
subplot(132), imshow(imgopennig)  
title({'Morfolojik a�ma ile' 'g�r�lt�s�z g�r�nt�'})

%% Morfolojik rekonstr�ksiyonun kullan?m?
mask = ~imread('enhance_text.png'); %Read in binary text
figure, 
subplot(221), imshow(mask);
title('mask g�r�nt�')
%mask = imclose(A,ones(3)); %Harflerdeki k�pr� k?r?lmalar?na kapat?r
se = strel('line',40,80);          %Define se length 40 with 80 angle
marker = imerode(mask,se);         %Erode to eliminate characters
im = imreconstruct(marker, mask);  %Reconstructed image 

subplot(223), imshow(~marker); title('marker image')
subplot(224), imshow(~im);
title({'A�mayla yeniden' 'yap?land?r?lm?? g�r�nt�'})
% Enlarge figure to full screen.
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
%saveas(gcf,[filepath 'opening_text.png'])  %save figure

%% morfolojik rekonstr�ksiyonun kullan?m?-2
mask = ~imread('enhance_text.png');  %Read in binary text
marker = imerode(mask,ones(51,1));   %erode in letters
fo = imopen(mask,ones(51,1));        %opening
fobr = imreconstruct(marker, mask);  %Reconstruct image
g = imfill(mask,'holes');
gborder = imclearborder(mask);
figure('Units','Normalized','OuterPosition',[0 0 1 1])
subplot(331),imshow(~mask);title('Original mask Image')
subplot(332),imshow(~marker);title({'eroded with vertical' 'line-marker'})
subplot(333),imshow(~fo);
title({'Dikey �izgiyle' 'Morfolojik a�arak yap?land?rma'})
subplot(334),imshow(~fobr);
title({'Yeniden yap?land?rmayla' ' a�?lm?? g�r�nt�'})
subplot(335),imshow(~g);title('Doldurulmu? orijinal g�r�nt�')
subplot(336),imshow(~gborder);
title({'S?n?r karakterleri' 'kald?rm?? g�r�nt�'})
%saveas(gcf,[filepath 'opening_text.png'])  %save figure

%% Yeniden yap?land?rmayla a�ma-reconstruction
mask = imread('open_shapes.png');  %Read in image
se = strel('square',10);
imgopennig = imopen(A,se);
figure,
marker = imerode(mask,se);    %Open with disk radius 10
subplot(131), imshow(mask)
title('Original Image-Mask')  %Display original
subplot(132), imshow(marker)  %Open with square side 10
title('Eroded image-Marker')
im = imreconstruct(marker, mask);    %Reconstruct image
subplot(133), imshow(im)             %Open with square side 25
title('Reconstructed image')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Morphological image gradient using flat structuring element
A = imread('rice.png');      %'cameraman.tif'  %Read in image
se = strel('square',3);      %Define flat structuring element
% vb de?erleri tan?mlanmaz.
Amax = imdilate(A, se);            %Gray scale dilate image
Amin = imerode(A, se);             %Gray scale erode image
Mgrad = Amax - Amin;               %subtract the two
subplot(131), imshow(Amax,[]);     %Display
title('Gray scale dilate image')
subplot(132), imshow(Amin,[]); 
title('Gray scale erode image')
subplot(133), imshow(Mgrad,[]);
title('Morfolojik g�r�nt� gradyenti')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Morfolojik Gradyent
f = imread('aerial-view.tif');
figure,
subplot(221), imshow(f); % 
title('Orijinal g�r�nt�')
se = strel('square',3);
gd = imdilate(f,se);
subplot(222), imshow(gd)
title('Geni?letilmi? g�r�nt�')
ge = imerode(f, se);
subplot(223), imshow(ge)
title('A??nd?r?lm?? g�r�nt�')
morph_grad = gd - ge;
subplot(224), imshow(morph_grad)
title('G�r�nt�n�n Morfolojik gradyenti')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Gri �l�ekli a�ma ve kapama-1
I = imread('rice.png');              %Read in image
se = strel('disk',15); 
background = imopen(I,se);           %Opening to estimate background
I2 = imsubtract(I, background);      %Subtract background                
se = strel('disk',2);
% imbothat filtering computes the morphological closing of the image 
%(using imclose) and then subtracts the original image from the result.
g = I + imtophat(I,se) - imbothat(I,se);
subplot(231), imshow(I); 
title('orijinal g�r�nt�')
subplot(232), imshow(background);
title({'morfolojik a�mayla' 'ayd?nlatman?n tahmini'})
subplot(233), imshow(I2,[]);
title({'orijinalden ayd?nlatman?n' '�?kar?lmas?n?n sonucu'})
subplot(234), imshow(g,[]);
title('Orijinal + imtophat - imbothat')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Morfolojik a�ma-2: Remove a complex background. 
f = imread('Fig0930(a).tif');     %Read in binary text
se = ones(1,71); 
fo = imopen(f,se);  % G�r�nt�n�n arka plan? elde edildi.
subplot(131), imshow(f)
title('Original Image')           %Display original
subplot(132), imshow(fo)          %Openend image
title('Opening horizantal line')
fth = f - fo;                     %veya imtophat(f,se)
fth = imadjust(fth);
subplot(133), imshow(fth,[])      
title({'Substraction Opening' 'from original'})
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Silindirik ?apka filtreleme
A = imread('rice.png'); %Read in unevenly illuminated image
Atophat = imtophat(A,strel('disk',15)); %Apply tophat filter
subplot(131), imshow(A);       %Display original
title('orijinal g�r�nt�')
subplot(132), imshow(Atophat); %Display raw filtered image
title({'silindir ?apka filtresi' 'sonras? g�r�nt�'})
B = imadjust(Atophat);         %Contrast adjust filtered image
subplot(133), imshow(B);       %Display filtered and adjusted mage
title('kontrast geli?tirilmi? g�r�nt�')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Morphological smoothing using openings and closings
% close-open filtering
f = imread('plugs.tif');     %Read in image
se = strel('disk', 5);
fo = imopen(f, se);          %Opening to estimate background
fc = imclose(f, se);         %Subtract background
foc = imclose(fo, se);       %Subtract background
foci = imopen(fc, se);       %Opening to estimate background
fasf = f;
for k = 2:5
    se = strel('disk' ,k);
    fasf = imclose(imopen(fasf, se), se);
end
subplot(331), imshow(f);
title('orijinal g�r�nt�')
subplot(332), imshow(fo);
title('Morfolojik a�?lm?? g�r�nt�')
subplot(333), imshow(fc);
title('Morfolojik kapanm?? g�r�nt�')
subplot(334), imshow(foc);
title({'A�madan sonra' 'kapanm?? g�r�nt�'})
subplot(335), imshow(foci);
title({'Kapamadan sonra' 'a�?lm?? g�r�nt�'})
subplot(336), imshow(fasf);
title({'A�madan sonra kapanm??' '�e?itli yar?�aplarda g�r�nt�'})
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Gri �l�ekli a�ma ve kapama-3
f = imread('1-DSignal.png');%Read in image
f = f(:,:,1);
fo = imopen(f, ones(10,5)); %Opening to estimate background
fc = imclose(fo, ones(10,5));          %Subtract background
subplot(331), imshow(f);
title('orijinal g�r�nt�')
subplot(332), imshow(fo);
title('Morfolojik a�?lm?? g�r�nt�')
subplot(333), imshow(fc);
title('Morfolojik kapanm?? g�r�nt�')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Renkli g�r�nt�lerde morfolofik i?lemler
% Importing the image
I = imread('iris.tif');
subplot(2, 3, 1),
imshow(I);
title("Original image");

% Dilated Image
se = strel("line", 7, 7);
dilate_img = imdilate(I, se);
subplot(2, 3, 2),
imshow(dilate_img);
title("Dilated image");

% Eroded image
erode_img = imerode(I, se);
subplot(2, 3, 3),
imshow(erode_img);
title("Eroded image");

% Opened image
open_img = imopen(I, se);
subplot(2, 3, 4),
imshow(open_img);
title("Opened image");

% Closed image
close_img = imclose(I, se);
subplot(2, 3, 5),
imshow(close_img);
title("Closed image");

%% Detect Cell Using Edge Detection and Morphology
%Step 1: Read Image
I = imread('cell.tif');
imshow(I)
title('Original Image');
text(size(I,2),size(I,1)+15, ...
'Image courtesy of Alan Partin', ...
'FontSize',7,'HorizontalAlignment','right');
text(size(I,2),size(I,1)+25, ....
'Johns Hopkins University', ...
'FontSize',7,'HorizontalAlignment','right');

%Step 2: Detect Entire Cell
[~,threshold] = edge(I,'sobel');
fudgeFactor = 0.5;
BWs = edge(I,'sobel',threshold * fudgeFactor);
% Display the resulting binary gradient mask.
imshow(BWs)
title('Binary Gradient Mask')

%Step 3: Dilate the Image
se90 = strel('line',3,90);
se0 = strel('line',3,0);

BWsdil = imdilate(BWs,[se90 se0]);
imshow(BWsdil)
title('Dilated Gradient Mask')

%Step 4: Fill Interior Gaps
BWdfill = imfill(BWsdil,'holes');
imshow(BWdfill)
title('Binary Image with Filled Holes')

%Step 5: Remove Connected Objects on Border
BWnobord = imclearborder(BWdfill,4);
imshow(BWnobord)
title('Cleared Border Image')

%Step 6: Smooth the Object
seD = strel('diamond',1);
BWfinal = imerode(BWnobord,seD);
BWfinal = imerode(BWfinal,seD);
imshow(BWfinal)
title('Segmented Image');

%Step 7: Visualize the Segmentation
imshow(labeloverlay(I,BWfinal))
title('Mask Over Original Image')

BWoutline = bwperim(BWfinal);
Segout = I;
Segout(BWoutline) = 255;
imshow(Segout)
title('Outlined Original Image')