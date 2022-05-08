%% Morfolojik İşlemler-2
filepath='D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/';
%% Bağlantılı bileşenlerin çıkarılması
close all;clc;
bw = imread('basic_shapes.png');   %Read in binary(or logical) image
[L,num] = bwlabel(bw);         %Get labelled image and number of objects
subplot(121), imshow(bw);
title('Orijinal Görüntü')
axis image; axis off;    %Plot binary input image
c1 = colorbar('Northoutside','Ticks',[0, 1]);
c1.Label.String = 'Görüntü renk skalası';
subplot(122), imagesc(L);  %Display labelled image
title('Bağlantılı Bileşenli Görüntü')
axis image; axis off; colormap(parula(5))
c2=colorbar('Northoutside','Ticks',0:num);
c2.Label.String = 'Bileşen renk skalası';
%saveas(gcf,'Connected_components_labelling.png') %save figure
%% Bağlantılı bileşelerin kütle merkezini hesaplama ve gösterimi.
f = imread('ten-objects.tif');
[L, num] = bwlabel(f);
imshow(f)
hold on % So later plotting commands plot on top of the image.
for k = 1:num
    [r, c] = find(L == k); % k etiketli bileşenin piksellerini bulma
    % Nesnelerin kütle merkezlerini hesaplama
    meanr = mean(r);  meanc = mean(c);
    plot(meanc,  meanr, 'Marker', 'o', 'MarkerEdgeColor', 'r',...
         'MarkerFaceColor', 'r', 'MarkerSize', 4);
%     plot(meanc,  meanr, 'Marker', 'o', 'MarkerEdgeColor', 'r');
end
%% Komşuluk tipinin bağlantılı bileşen sayısına etkisi
f = zeros(8);
f(:,1:3)=1; f(2:3,5:6)=1; f(4:6,7)=1; f(7,6)=1;
subplot(131), imshow(f);
title('Orijinal Görüntü')
colorbar('Northoutside');
[L4,num4] =  bwlabel(f,4);
subplot(132), imagesc(L4);axis image; axis off; colormap(jet)
title({'4-bağlantılılık ile' [num2str(num4) ' bileşen elde edilir.']})
colorbar('Northoutside');
[L8,num8] =  bwlabel(f,8);
subplot(133), imagesc(L8);axis image; axis off; colormap(jet)
colorbar('Northoutside');
title({'8-bağlantılılık ile' [num2str(num8) ' bileşen elde edilir.']})
%% Bağlantılı bileşenlerin kümesini tanımlama
clear;close all;clc
f = imread('blob-clusters-1.png');
figure('Units','Normalized', 'OuterPosition', [0 0 1 1])
subplot(321), imshow(f)
title({'Orijinal görüntü'})

[L1,num1] = bwlabel(f); % default 8-bağlantılılık
g1 = label2rgb(L1,'jet',[.7 .7 .7],'shuffle');
subplot(322), imshow(g1);
title({'İkili görüntünün' 'bağlantılı bileşenleri'})

se = strel('disk',10);
f2 = imdilate(f,se);
subplot(323), imshow(f2)
title({'Genişletilmiş ikili görüntünün'})

[L2,num2] = bwlabel(f2);
g2 = label2rgb(L2,'jet',[.7 .7 .7],'shuffle');
subplot(324), imshow(g2)
title({'Genişletilmiş ikili görüntünün' 'bağlantılı bileşenleri'})

L3 = L2;
L3(~f) = 0; % f görüntüsündeki tüm arka plan konumlarına 0 ata.
g3 = label2rgb(L3,'jet', [.7 .7 .7],'shuffle');
subplot(325), imshow(g3)
title({'Kümelemeye göre renklendirilmiş' 'nesnelerle orijinal görüntü'})
%saveas(gcf,[filepath 'Connected_components_bwconncom.png']) %save figure
%% Şekil 1.16 Vur-yada-ıskala
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

Ae2 = imerode(~A,~B1); % ıskalamalar
[r,c] = find(Ae2 == 1);
subplot(222), imshow(Ae2)
hold on
plot(c,r,'r*')
subplot(223), imshow(Ae1 & Ae2)

% veya bwhitmiss fonksiyonu kullanılarak
subplot(224), imshow(bwhitmiss(A,B1,~B1))
%% Vur-yada-ıskala dönüşümü
A = imread('text.png');       %Read in text (binary image)
B = imcrop(A);                %Read in target shape interactively
%Perform the crop operation by double-clicking in the crop rectangle 
%or selecting Crop Image on the context menu.
se1 = B; se2 = ~B;            %Define hit and miss structure elements
bw = bwhitmiss(A,se1,se2);    %Perform hit miss transformation
[i,j] = find(bw == 1);        %Get explicit coordinates of locations
figure,
subplot(131), imshow(A)       %Display image
title('Original görüntü')
subplot(132), imshow(B); 
title('Hedef desen')
subplot(133), imshow(A);      % hedef desenin bulunduğu yerler
hold on
plot(j,i,'r*')
title('Hedef desenin bulunduğu yerler')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Vur-yada-ıskala dönüşümü: noisy image
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
%% Vur-yada-ıskala dönüşümü--Umrumda değil
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
% Sadece bir piksellik gürültüleri bulur.
interval2 = [0 -1 -1; 0 1 -1; 0 0 0];  
%1's for hits, -1 for misses; 0s for don't care
bw2 = bwhitmiss(A,interval2);  %Apply hit or miss transform
subplot(324), imshow(bw2)      %Display located pixels
title('Gürültü ve köşe noktalar') 
subplot(325), imshow(A-(bw2-bw1))  %Gürültü kaldırılmış görüntü
title('Gürültüsüz görüntü') 
hold on
plot(c,r,'r*')
%saveas(gcf,[filepath 'hit_or_miss7.png'])  %Save figure
%% Morfolojik inceltme
A = imread('A.tif');
A = imbinarize(A);
subplot(121), imshow(A) 
I = bwmorph(A, 'skel', Inf);
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
%% Örnek-1 Çeşitli geometrik şekillerin iskeletleri
clear;close all;clc;
f = imread('basic_shapes.png');
figure,
subplot(121), imshow(f) % Fig. (a)
title('Original') 

s = bwmorph(f, 'skel', Inf); % Fig. (d)
subplot(122), imshow(s) % Fig. (c)
title('İskelet') 
%İskeletdeki çıkıntılar komutu kullanarak azaltılır.
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Örnek-2 Gürültülü görüntü--İskelet çıkarma
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
%Sonra, düzgünleştirilmiş görüntüyü eşiklileme:

g = imbinarize(g, 1.7*graythresh(g));
subplot(333), imshow(g) % Fig. (c)
title('Threshold image') 
%İskeleti çıkaran komut:

s = bwmorph(g, 'skel', Inf); % Fig. (d)
subplot(334), imshow(s) % Fig. (c)
title('İskelet') 
%İskeletdeki çıkıntılar komutu kullanarak azaltılır.

s1 = bwmorph(s, 'spur', 30); % Fig. (e)
subplot(335), imshow(s1) % Fig. (c)
title('Çıkıntıları kaldırılmış iskelet') 
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
figure, imshow(s1)
%% Morfolojik açma-1
A = imread('open_shapes.png'); %Read in image
se = strel('disk',10); 
bw = imopen(A,se);             %Open with disk radius 10
subplot(1,3,1), imshow(A)
title('Orijinal görüntü')      %Display original
subplot(1,3,2), imshow(bw)     
title('Açma disk yarıçapı = 10')
se = strel('square',25); 
Abw1 = imerode(A,se);
imshow(A-Abw1)
bw = imopen(A,se);             %Open with square side 25
subplot(1,3,3), imshow(bw)      
title('Açma kare kenarı = 25')
%% Morfolojik açma-3: İstenmeyen gürültüyü kaldırma
A = imread('Noisy_Two_Ls.png');  
se = strel('square',2);
imgopennig = imopen(A,se);
figure,
subplot(131), imshow(A)
title('Gürültülü görüntü')      
subplot(132), imshow(imgopennig)  
title({'Morfolojik açma ile' 'gürültüsüz görüntü'})
%% Morfolojik rekonstrüksiyonun kullanımı
mask = ~imread('enhance_text.png'); %Read in binary text
figure, 
subplot(221), imshow(mask);
title('mask görüntü')
%mask = imclose(A,ones(3)); %Harflerdeki köprü kırılmalarına kapatır
se = strel('line',40,80);          %Define se length 40 with 80 angle
marker = imerode(mask,se);         %Erode to eliminate characters
im = imreconstruct(marker, mask);  %Reconstructed image 

subplot(223), imshow(~marker); title('marker image')
subplot(224), imshow(~im);
title({'Açmayla yeniden' 'yapılandırılmış görüntü'})
% Enlarge figure to full screen.
set(gcf,'Units','Normalized','OuterPosition',[0 0 1 1]);
%saveas(gcf,[filepath 'opening_text.png'])  %save figure
%% morfolojik rekonstrüksiyonun kullanımı-2
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
title({'Dikey çizgiyle' 'Morfolojik açarak yapılandırma'})
subplot(334),imshow(~fobr);
title({'Yeniden yapılandırmayla' ' açılmış görüntü'})
subplot(335),imshow(~g);title('Doldurulmuş orijinal görüntü')
subplot(336),imshow(~gborder);
title({'Sınır karakterleri' 'kaldırmış görüntü'})
%saveas(gcf,[filepath 'opening_text.png'])  %save figure
%% Yeniden yapılandırmayla açma-reconstruction
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
A = imread('rice.png');       %Read in image
%A = imread('cameraman.tif'); 
%se = strel('square',2);      %Define flat structuring element
se = strel('disk',2);         %Define flat structuring element
% vb değerleri tanımlanmaz.
Amax = imdilate(A, se);            %Gray scale dilate image
Amin = imerode(A, se);             %Gray scale erode image
Mgrad = Amax - Amin;               %subtract the two
Madj = imadjust(Mgrad);
subplot(131), imshow(Amax,[]);     %Display
title('Gray scale dilate image')
subplot(132), imshow(Amin,[]); 
title('Gray scale erode image')
subplot(133), imshow(Madj,[]);
title('Morfolojik görüntü gradyenti')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Morfolojik Gradyent
f = imread('aerial-view.tif');
figure,
subplot(221), imshow(f); % 
title('Orijinal görüntü')
se = strel('square',7);
gd = imdilate(f,se);
subplot(222), imshow(gd)
title('Genişletilmiş görüntü')
ge = imerode(f, se);
subplot(223), imshow(ge)
title('Aşındırılmış görüntü')
morph_grad = gd - ge;
subplot(224), imshow(morph_grad)
title('Görüntünün Morfolojik gradyenti')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Gri ölçekli açma ve kapama-1
I = imread('rice.png');              %Read in image
%figure, imhist(I)
Ith = imbinarize(I,graythresh(I));
se = strel('disk',12); 
background = imopen(I,se);           %Opening to estimate background
I2 = I - background;      %Subtract background 
%figure, imhist(I2)
% imbothat: filtering computes the morphological closing of the image 
% (using imclose) and then subtracts the original image from the result.
% imtophat: filtering computes the morphological opening of the image 
% (using imopen) and then subtracts the result from the original image. 
g = imbinarize(I2,graythresh(I2));
subplot(231), imshow(I); 
title('orijinal görüntü')
subplot(232), imshow(Ith); 
title('Eşiklenmiş görüntü')
subplot(233), imshow(background);
title({'morfolojik açmayla' 'aydınlatmanın tahmini'})
subplot(234), imshow(I2,[]);
title({'orijinalden aydınlatmanın' 'çıkarılmasının sonucu'})
subplot(235), imshow(g,[]);
title('Sonuç eşiklenmiş görüntü')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Using grayscale reconstruction to remove a complex background. 
f = imread('Fig0930(a).tif');     % Mask
se = ones(1,71);
fe = imerode(f,se);               % Marker
f_obr = imreconstruct(fe,f);
fo = imopen(f,se);
f_thr = f - f_obr;                % mask2, arka plan çıkarılmış görüntü
fth = f - fo;                     % veya imtophat(f,se)
g_obr = imreconstruct(imerode(f_thr,ones(1,11)),f_thr);
g_obrd = imdilate(g_obr,ones(1,21));
f2 = imreconstruct(min(g_obrd,f_thr),f_thr);
subplot(241), imshow(f)
title('Original Image')              %Display original
subplot(242), imshow(f_obr)          %Openend image
title('yeniden yapılandırma ile açma')
%fth = imtophat(f,se);
subplot(243), imshow(fo,[])      
title({'yapılandırma elemanı ile açma'})
subplot(244), imshow(f_thr,[])      
title({'Yeniden yapılandırma ile' ...
    'arkaplan çıkarılmış görüntü'})
subplot(245), imshow(fth,[])      
title({'Açma ile' 'arkaplan çıkarılmış görüntü'})
subplot(246), imshow(g_obr,[])      
title({'Sonuç-1'})
subplot(247), imshow(g_obrd,[])      
title({'Sonuç-2'})

figure, imshow(f2,[])      
title({'Sonuç yeniden yapılandırma'})
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Silindirik şapka filtreleme
A = imread('rice.png'); %Read in unevenly illuminated image
Atophat = imtophat(A,strel('disk',12)); %Apply tophat filter
subplot(131), imshow(A);       %Display original
title('orijinal görüntü')
subplot(132), imshow(Atophat); %Display raw filtered image
title({'silindir şapka filtresi' 'sonrası görüntü'})
B = imadjust(Atophat);         %Contrast adjust filtered image
bw = imbinarize(B,graythresh(B));
subplot(133), imshow(B);       %Display filtered and adjusted mage
title('kontrast geliştirilmiş görüntü')

figure, imshow(bw);       %Display filtered and adjusted mage
title('İkili görüntü')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Grayscale-Morphological smoothing using openings and closings
% close-open filtering
f = imread('plugs.tif');     %Read in image
bw = imbinarize(f,graythresh(f));
figure, imshow(bw); 
se  = strel('disk', 2);
fo  = imopen(f, se);          %Opening to estimate background
fc  = imclose(f, se);         %Subtract background
foc = imclose(fo, se);       %Subtract background
fco = imopen(fc, se);       %Opening to estimate background
bw  = imbinarize(foc,graythresh(foc));
figure, imshow(bw);      
fasf = f;
for k = 2:5
    se = strel('disk' ,k);
    fasf = imclose(imopen(fasf, se), se);
end
subplot(331), imshow(f);
title('orijinal görüntü')
subplot(332), imshow(fo);
title('Morfolojik açılmış görüntü')
subplot(333), imshow(fc);
title('Morfolojik kapanmış görüntü')
subplot(334), imshow(foc);
title({'Açmadan ve kapama' 'sonrası görüntü'})
subplot(335), imshow(fco);
title({'Kapamadan açma' 'sonrası görüntü'})
subplot(336), imshow(fasf);
title({'Açmadan kapama  sonrası' 'çeşitli yarıçaplarda görüntü'})
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
%% Renkli görüntülerde morfolofik işlemler
% Importing the image
I = imread('iris.tif');
subplot(231), imshow(I);
title("Original image");

% Dilated Image
se = strel("line", 7, 7);
dilate_img = imdilate(I, se);
subplot(232), imshow(dilate_img);
title("Dilated image");

% Eroded image
erode_img = imerode(I, se);
subplot(233), imshow(erode_img);
title("Eroded image");

% Opened image
open_img = imopen(I, se);
subplot(234), imshow(open_img);
title("Opened image");

% Closed image
close_img = imclose(I, se);
subplot(235), imshow(close_img);
title("Closed image");
%% Detect Cell Using Edge Detection and Morphology
%Step 1: Read Image
I = imread('cell.tif');

imshow(I); hold on

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
