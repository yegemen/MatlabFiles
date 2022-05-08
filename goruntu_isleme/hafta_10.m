%% Morfolojik islemler-1

%% sekil1.3 örnegi
bw = zeros(7,7);
bw(2:3,3:6)=1;
bw(4,4:6)=1;
bw(6,2:3)=1;
se = [0 1 0; 1 1 1; 0 1 0];     %Yapilandirma elemani
bw_erode = imerode(bw,se);
figure
subplot(131), imshow(bw);
subplot(132), imshow(bw_erode);
bw_dilate = imdilate(bw,se);
subplot(133), imshow(bw_dilate);

%% Dilate Image
clc;clear;
% Örnek-1 yazi kalinlastirma ornegi
bw = imread('text.png');        %Read in binary image
se = [0 1 0; 1 1 1; 0 1 0];     %Define structuring element
bw_out = imdilate(bw,se);       %Dilate image
subplot(1,2,1), imshow(bw)      %Display original
subplot(1,2,2), imshow(bw_out)  %Display dilated image

% örnek-2
bw = imread('broken_text.tif');
se = [0 1 0; 1 1 1; 0 1 0];
bw_out = imdilate(bw, se);
imshow(bw_out)
subplot(1,2,1), imshow(bw)      %Display original
subplot(1,2,2), imshow(bw_out)  %Display dilated image

%% Erode Image
bw = imread('text.png');        %Read in binary image
%se = ones(6,1);                 %Define structuring element
se = [0 1 0; 1 1 1; 0 1 0];
bw_out = imerode(bw,se);        %Erode image
subplot(1,2,1), imshow(bw)      %Display original
subplot(1,2,2), imshow(bw_out)  %Display eroded image

%% strel fonksiyonu (otomatik yapilandirma elemani donduren fonksiyon)
bw = imread('text.png');         %Read in binary image
%se1 = strel('square',4);         %4 by 4 square
se1 = strel('diamond',3);       %4 by 4 diamond
%imshow(se1.Neighborhood)
se2 = strel('line',5,-45);        %line,length 5,angle 45 degrees
bw_1 = imdilate(bw,se1);         %Dilate image
bw_2 = imerode(bw,se2);          %Erode image
subplot(1,2,1), imshow(bw_1)     %Display dilated image
subplot(1,2,2), imshow(bw_2)     %Display eroded image

%% Yapilandirma elemaninin görsel temsili
se = strel('disk',15);
%se = [0 1 0; 1 1 1; 0 1 0];
figure
imshow(se.Neighborhood)

%% Erezyon ve genisleme kullanma: Örn--Krater Çarpma Bölgesi
close all
I = rgb2gray(imread('crater1.png'));
E = edge(I,'prewitt');
figure,
subplot(221),imshow(I,[]);
subplot(222),imshow(E);
se = strel('disk',5);
bw1 = imdilate(E, se);
bw = imfill(bw1,'holes'); % nesnenin icini doldurmak icin 
subplot(223),imshow(bw1);
subplot(224),imshow(bw);

bw2 = imerode(bw,se);
figure(2)
subplot(121),imshow(bw);
title('sonuç görüntü');
subplot(122),imshow(bw2);
title({'ayni sayida a??nd?r?lm??' 'sonuç görüntü'});

%% Yapilandirma elemanini iyi tanimlamanin önemi
length = 18; tlevel = 0.2;    %Define SE and percent threshold level
A = imread('circuit.tif'); 
subplot(2,3,1), imshow(A)     %Read image and display
B = ~imbinarize(A,tlevel);    %Thresholding image 
subplot(2,3,2), imshow(B)     %Display
se = ones(4,length);
bw1 = imerode(B,se);          %Erode horizontal lines
subplot(2,3,3), imshow(bw1)   %Display result
bw2 = imerode(bw1,se');       %Erode vertical lines
subplot(2,3,4), imshow(bw2)   %Display result
bw3 = imdilate(bw2,se);       %Dilate back horizontal and vertical
bw4 = imdilate(bw3,se');      %s?ras? önemli de?il.
subplot(2,3,5), imshow(bw4)   %Display

boundary = bwperim(bw4);      %ortaya çikan çiplerin 
                              %sinir noktalarini bulma
[i,j] = find(boundary==1);    %Superimpose boundaries
subplot(2,3,6), imshow(A)
hold on 
plot(j,i,'r.')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Erozyonun parçaçik boyutlandirmasina uygulanmasi
clear;close all;clc;
A = rgb2gray(imread('enamel.png'));
figure(1),
subplot(1,3,1), imshow(A); % Read in image and display
bw = ~imbinarize(A,0.4);
subplot(1,3,2), imshow(bw); 
title('Dönüstürülmüs ikili Görüntü') %Display resulting binary image
bw = imfill(bw,'holes');             %Threshold and fill in holes
subplot(1,3,3), imshow(bw);          %Display resulting binary image
title('Doldurulmus ikili Görüntü')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
% Label and count number of objects in initial binary image
[L,num0] = bwlabel(bw);
se = strel('disk',2);  %Define structuring element, radius=2
n = 0;                 %Set number of erosions = 0      
num = num0;            %initialise number of objects in image
tic();                 %i?lem zaman?n? ba?latma
while num > 0          %Begin iterative erosion 
n = n + 1;
    bw = imerode(bw,se);      %Erode
    [L,num] = bwlabel(bw);    %Count and label objects
    F(n) = num0 - num; %görüntüden kald?r?lan nesne sy?s? CDF
    figure(2); imshow(bw); drawnow   %Display eroded binary image
    %pause(2)
end
time=toc();
%Plot Unnormalized Cumulative distribution 
figure(3); 
subplot(121), plot(0:n,[0 F],'ro','MarkerFaceColor','r'); 
axis square; axis([0 n 0 max(F)]); %Force square axis
title('Kümilatif Dagilimin Grafigi')
xlabel('Erezyon Sayisi'); ylabel('Kaldirilan Parçacik Sayisi')
subplot(122), plot(diff([0 F]),'b*'); 
%Plot estimated size density function
axis square; axis([0 n 0 max(F)]);
xlabel('Erezyon Sayisi'); ylabel('Büyüklük Yogunlugu')
title({'Tahmini Büyüklük Yogunlugu' 'Fonksiyonu Grafigi'})
fprintf('islem zamani = %2.4f sn\n',time)
figure(4)
bar(diff([0 F]))
xlabel('Nesne Boyutu'); ylabel('Nesne Sayisi')

%% Morfolojik açma-kapama
A = imread('openclose_shapes.png');
figure(1),
subplot(121),imshow(A,[]);title('Orijinal Görüntü');
A = ~imbinarize(A); %Read in image and convert to binary
subplot(122),imshow(A);
title('Negatif Dönüstürülmüs ikili Görüntü');
se = strel('disk',5); 
bw1 = imopen(A,se);   %Define SEs then open and close
bw2 = imclose(A,se); 
figure(2)
subplot(321), imshow(bw1);
title('Açma: Disk yariçapi = 3')
subplot(322), imshow(bw2)  %Display results
title('Kapama: Disk yariçapi = 3')
se = strel('disk',15); bw1 = imopen(A,se);
bw2 = imclose(A,se); %Define SEs then open and close
subplot(323), imshow(bw1); 
title('Açma: Disk yariçapi = 5')
subplot(324), imshow(bw2)  %Display results
title('Kapama: Disk yariçapi = 5')
se = strel('disk',25); 
bw1 = imopen(A,se);
bw2 = imclose(A,se); %Define SEs then open and close
subplot(325), imshow(bw1);
title('Açma: Disk yariçapi = 15')
subplot(326), imshow(bw2);  %Display results
title('Kapama: Disk yariçapi = 15')
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

%% Bir nesnenin sinirini çikarma süreci
% bwperim fonksiyonuna karsi gelen yapiyi tanimlama
%A = imread('circles.png'); %Read in binary image
%A = imread('basic_shapes.png');
A = rgb2gray(imread('crater1.png'));
bw = bwperim(A);           %Calculate perimeter
se = strel('disk',2);      %B yap?landirma elemeni çesitli yariçaplarda.
bw1 = A - imerode(A,se);   %se allows thick perimeter extraction
subplot(131), imshow(A)
title('Orijinal Görüntü');
subplot(132), imshow(bw)
title({'Matlab bwperim ile' 'S?n?r Görüntüsü'});
subplot(133), imshow(bw1) %Display results
title('Kal?n S?n?r Görüntü');
%saveas(gcf,'circles_boundary.png') %save figure

%% An application: noise removal
% Morfolojik filtreleme - Önce Açma, daha sonra kapama yapilarak 
% görüntüden gürültü kaldirilir.
% A = imread('circles.png');
I = imread('eight.tif');
A = im2double(imnoise(I,'gaussian'));
A = imbinarize(A,0.6);
% x = rand(size(A));
% d1 = find(x<=0.05); d2 = find(x>=0.95);
% A(d1) = 0; A(d2) = 1; % Tuz&biber gürültüsü ekleme
figure,
subplot(131), imshow(A)
title('Gürültülü ikili Görüntü');
se1 = ones(3,3);
se2 = [0 1 0;1 1 1;0 1 0];
Af1 = imclose(imopen(A,se1),se1);
subplot(132), imshow(Af1)
title('Morfolojik filtreli Görüntü-se1');
Af2 = imclose(imopen(A,se2),se2);
subplot(133), imshow(Af2)
title('Morfolojik filtreli Görüntü-se2');
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

