%% Bölütleme 
% Ders 8
clear; clc; close all
%filepath='D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/';
% Esiklemeye ornek
I = imread('rice.png');
figure,
subplot(131), imshow(I);
subplot(132), histogram(I,25);
BW = imbinarize(I,131/255);
subplot(133), imshow(BW,[]); %imshow(I>130);
%saveas(gcf,[filepath,'rice.jpg'])

I = imread('toycars1.png');
I = I(:,:,1);
T1 =80;T2=138;
figure(1),
subplot(121), imshow(I);
subplot(122), histogram(I,25);
I(I<=T1)=0.5;
I((I>T1) & (I<T2))=1;
I(I>=T2)=0;
figure(2),
imshow(I,[]); 


% Global Esikleme
I = imread('cameraman.tif');
f = figure;
f.Position = [300 300 800 700];
subplot(311),imshow(I);
subplot(312),histogram(I);
T = graythresh(I);
g = imbinarize(I,T);
subplot(313),imshow(g);
%saveas(gcf,[filepath,'globalThres.jpg'])

% cift Esikleme
[x,map] = imread('spine.tif');
s = uint8(ind2gray(x,map));
T1=115;T2=125;
f = figure;
f.Position = [300 300 800 700];
subplot(321), imshow(s)
subplot(322), histogram(s)
subplot(323), imshow(s>T1 & s<T2)
subplot(324), imshow(s>T1)
%saveas(gcf,[filepath,'doubleThres.jpg'])

% Esikleme uygulamasi
t = imread('text.png');
m = size(t);
f = figure;
f.Position = [300 300 800 700];
subplot(321), imshow(t)
subplot(322), histogram(t)
r = rand(m)*128+127;
tr = uint8(r.*double(not(t)));
subplot(323), imshow(tr)
subplot(324), histogram(tr)
subplot(325), imshow(tr>120)
%saveas(gcf,[filepath,'ThresApp.jpg'])

% Sobel ornegi
a=imread('peppers.png');
a = a(:,:,1);
Sx = [-1 -2 -1;0 0 0; 1 2 1];
Sy = [-1 0 1;-1 0 1; -1 0 1];
Gxa = imfilter(a,Sx);
Gya = imfilter(a,Sy);
MG = abs(Gxa) + abs(Gya);
f = figure(1);
f.Position = [100 100 800 700];
subplot(221), imshow(a)
subplot(222), imshow(Gxa>0.5*255)
subplot(223), imshow(Gya)
subplot(224), imshow(MG)


f = figure(2);
f.Position = [100 100 800 700];
subplot(221), imshow(a)
s=edge(a,'sobel',0.07); % hem yatay hem dikey
subplot(222), imshow(s)
s=edge(a,'sobel',0.07,'vertical');
subplot(223), imshow(s)
s=edge(a,'sobel',0.07,'horizontal');
subplot(224), imshow(s)
%saveas(gcf,[filepath,'blocksSobel.jpg'])

% Prewitt ornegi
a=imread('lena.tif');
a=a(:,:,1);
surf(a)
f = figure;
f.Position = [100 100 800 700];
subplot(221), imshow(a)
s = edge(a,'prewitt',0.06);
subplot(222), imshow(s)
s = edge(a,'prewitt',0.06,'horizontal');
subplot(223), imshow(s)
s=edge(a,'prewitt',0.06,'vertical');
subplot(224), imshow(s)
%saveas(gcf,[filepath,'LenaPrewitt.jpg'])

% Laplasyen filtrelenmis goruntu
a=imread('cameraman.tif');
figure
subplot(121),imshow(a);
title('Original Image');
L = fspecial('laplacian',1);
icz=edge(a,'zerocross',L);
subplot(122),imshow(icz);
title('Laplacian Filtered Image');


% LoGfiltrelenmis goruntu
a=imread('cameraman.tif');
figure
subplot(131),imshow(a);
title('Original Image');
% g=fspecial('gaussian',7,3);
% ga = imfilter(a,g);
% subplot(132),imshow(ga)
% L = fspecial('laplacian',1);
% icz=edge(a,'zerocross',L);
log=fspecial('log',13,2);
icz=edge(a,'zerocross',log);
subplot(133),imshow(icz);
title('LoG Filtered Image');

% LoGfiltrelenmis goruntu
a=imread('rice.png');
figure
subplot(121),imshow(a);
title('Original Image');
log=fspecial('log',13,2);
icz=edge(a,'zerocross',log);
subplot(122),imshow(icz);
title('LoG Filtered Image');

% Sifir gecis tablosu
A = 50*ones(400);
A(80:320,80:320)=200;
A(280:320,120:160)=50;
imshow(A,[]);
L = [0 1 0;1 -4 1;0 1 0];
Fi = imfilter(A, L);
B = repmat(Fi,50,50);
imshow(B,[]);