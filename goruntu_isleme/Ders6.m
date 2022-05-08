%% Görüntü Restorasyonu 
% Ders 6
clear; clc; close all
% Biber gurultusu eklemek
f = imread('devre.png');
[m, n] = size(f);
figure
subplot(121), imshow(f)
R = tuzbiber(m, n, 0.1, 0);
gpepper = f;
gpepper(R==0) = 0;
subplot(122), imshow(gpepper)

% Tuz gurultusu eklemek
f = imread('devre.png');
[m, n] = size(f);
figure
subplot(121),imshow(f)
R = tuzbiber(m, n, 0, 0.1);
gsalt = f;
gsalt(R==1) = 255;
subplot(122),imshow(gsalt)

% Gaussian gurultusu olusturma
I = imread('lena.tif');
g = imnoise(I,'gaussian');
f = figure;
f.Position = [10 10 800 700];
subplot(221),imshow(I);title('Original image')
subplot(222),imshow(g);title('image with gaussian noise')
h = fspecial('gaussian',[5 5],3.0);
Ig = imfilter(g,h);
subplot(223),imshow(Ig);title('Gaussian filtrelenmiş görüntü')
%saveas(gcf,'gaussiannoise.jpg')

% Periyodik gurultu olusturma
I = imread('lena.tif');
I = im2double(I); % double tipli goruntu
[m, n] = size(I(:,:,1)); % t'nin boyutlari
[x,y] = meshgrid(1:m, 1:n); % x, y boyutlu matris.
p = sin(x/3)+cos(y/5); % sinusoidal bir dalga
%P = sin(x/3+y/5) + 1; % sinusoidal bir dalga
figure
subplot(121);surf(P);title('Periyodik gurultu')
k = (I + P/2)/2;
subplot(122);imshow(k);title('Periyodik gurultulu goruntu.')

% Tuz-biber gurultusunu kaldirma
I = imread('lena.tif');
g = imnoise(I,'salt & pepper');
h1  = fspecial('average');
h2  = fspecial('average', [9,9]);
gh1 = imfilter(g,h1);
gh2 = imfilter(g,h2);
f = figure;
f.Position = [10 10 800 700];
subplot(131),imshow(g);
title({'Salt & pepper','gurultulu goruntu'})
subplot(132),imshow(gh1);title('3x3 ortalama filtreli')
subplot(133),imshow(gh2);title('9x9 ortalama filtreli')
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/filteredimg1.jpg'),

% Medyan Filtre
%siyah beyaz olmadigi icin asagidaki sekilde ayri ayri yaptik.
t = imread('lena.tif');
c = imnoise(t,'salt & pepper',0.1);
R = c(:,:,1);
G = c(:,:,2);
B = c(:,:,3);
f = figure;
f.Position = [10 10 800 700];
subplot(121),imshow(c);title('Tuz-biber gurultulu goruntu')
d1 = medfilt2(R);
d2 = medfilt2(G);
d3 = medfilt2(B);
g(:,:,1) = d1;
g(:,:,2) = d2;
g(:,:,3) = d3;
subplot(122),imshow(g);title('Medyan filtrelenmis goruntu')
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/filteredimg2.jpg'),

% Maksimum & minimum Filtre
clc
f = imread('cameraman.tif');
[m, n] = size(f);
disp('(1) Biber tipi gurultulu')

disp('(2) Tuz tipi gurultulu')
sec = input('Seciminiz? ');
switch sec
    case 1 % biber tipi a=0.1, b=0;
        R = tuzbiber(m, n, 0.1, 0);
        A = f;
        A(R==0) = 0;
        sonuc = maksfiltre(A);
    case 2 % tuz tipi a=0, b=0.1;
        R = tuzbiber(m, n, 0, 0.1);
        A = f;
        A(R==1) = 255;
        sonuc = minfiltre(A);
    otherwise
        error('Yanlis secim')
end   
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/filteredimg3.jpg'),

% Aritmetik filtre
I = imread('cameraman.tif');   % Read in intensity image
Iga = imnoise(I,'gaussian');
h3 = fspecial('average');
h5 = fspecial('average',[5,5]);
g3 = imfilter(Iga,h3);
g5 = imfilter(Iga,h5);
subplot(121),imshow(g3);title('3x3 filtreli görüntü')
subplot(122),imshow(g5);title('5x5 filtreli görüntü')
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/filteredimg4.jpg'),

%Adaptive Filtre - wiener2 
I = imread('cameraman.tif');   % Read in intensity image
Iga = imnoise(I,'gaussian');
figure, imshow(Iga);
t3 = wiener2(Iga);
t5 = wiener2(Iga,[5,5]);
t7 = wiener2(Iga,[7,7]);
t9 = wiener2(Iga,[9,9]);
f = figure;
f.Position = [10 10 800 700]; 
subplot(221),imshow(t3);title('3x3 wiener')
subplot(222),imshow(t5);title('5x5 wiener')
subplot(223),imshow(t7);title('7x7 wiener')
subplot(224),imshow(t9);title('9x9 wiener')
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/weiner.jpg'),

% Periyodik gürültünün yok edilmesi
a = imread('lena.tif');
b = rgb2gray(a);
[m,n] = size(b);
[x,y] = meshgrid(1:m,1:n);
P = 1 + sin(x+y/1.5);
tp = (double(b)/128 + P)/8;
f = figure;
f.Position = [10 10 800 600]; 
subplot(121), imshow(tp);title('Periyodik gürültülü görüntü')
af = fftshift(fft2(tp));
tf = mat2gray(log(1+abs(af)));
% imtool(tf)
subplot(122), imshow(tf);
title('FFT')
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/FFT1.jpg'),

% Band söndüren filtreleme
z = sqrt((x-257).^2+(y-257).^2);
z(177,204) 
z(337,310)
br = (z < 94 | z > 98); % band geçiren filter
tbr = af .* br; % eleman eleman çarpma
f = figure;
f.Position = [10 10 800 600]; 
subplot(121), imshow(mat2gray(log(1+abs(tbr))));
title('Frekans bölgesindeki çember')
s = ifft2(tbr);
subplot(122), imshow(mat2gray((1+abs(s))));
title('Filtrelenmiş görüntü')
%saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/FFT2.jpg'),

% Notch (Çentik) Filtre
tf(204,:) = 0;
tf(310,:) = 0;
tf(:,177) = 0;
tf(:,337) = 0;
f = figure;
f.Position = [10 10 800 600];
subplot(121), imshow(tf);
title('Frekans bölgesindeki çember')
s = ifft2(tf);
subplot(122), imshow(mat2gray(1+abs(s)));
title('Notch Filtrelenmiş görüntü')
saveas(gcf,'D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ İŞLEME/LaTeX Files for Lessons/images/FFT3.jpg'),

% Hareket bulanıklığını yok etme
bc = imread('board.tif');
bg = im2uint8(rgb2gray(bc));
b = bg(100:355,50:305);
f = figure;
f.Position = [10 10 800 600];
subplot(121),imshow(b);
title('Orijinal görüntü');

m = fspecial('motion',7,0);
bm = imfilter(b,m);
subplot(122), imshow(bm);
title('Motion Filtreli görüntü');

m2 = zeros(256,256);
m2(1,1:7) = m;

d = 0.02;
mf = fft2(m2);
mf(abs(mf) < d) = 1;

bmi = ifft2(fft2(bm)./mf);
imshow(bmi,[])

