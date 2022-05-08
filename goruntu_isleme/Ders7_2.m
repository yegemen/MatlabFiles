%% Frekans bölgesi işlemleri -- 2
% Ders 9
clear; clc; close all
mypath=['D:/MyDriveFiles/DERS SUNUM DOSYALARI/BM409-GÖRÜNTÜ '...
          'İŞLEME/LaTeX Files for Lessons/images/'];
%% 2-D DFT
f = imread('trui.png');
y = fft2(f);
ay = fftshift(y);
phase = angle(ay);
figure
subplot(131), imshow(f);title('Orijinal görüntü')
subplot(132), imshow(mat2gray(log(1+abs(ay))));
title('Genlik Spektrumu');
subplot(133); imshow(phase,[]);
title('Faz Spektrumu');
%saveas(gcf,[mypath 'DFT1.jpg'])
%% Matlab 2-DFT örnekleri
% Örnek-1:
a = ones(8);
af = fft2(a);
caf = fftshift(af);
disp('DC katsayısı gerçekten tüm değerlerinin toplamıdır.')
icaf = ifft2(caf);
figure, 
subplot(121),imshow(mat2gray(log(1+abs(caf))))
subplot(122),imshow(abs(icaf))

% Örnek-2: Oluklu bir matris alalım:
clc
a = [100 200; 100 200];
a = repmat(a,4,4)
imshow(a,[])
af = fft2(a);
caf = fftshift(af);
disp('DC katsayısı gerçekten tüm değerlerinin toplamıdır.')
icaf = ifft2(caf);
figure, 
subplot(121),imshow(mat2gray(log(1+abs(caf))))
subplot(122),imshow(abs(icaf),[])
% Örnek-3: Tek adımlı kenar görüntüsü alalım:
clc
a = [zeros(8,4) ones(8,4)]
caf = fftshift(fft2(a));
round(abs(caf))
icaf = ifft2(caf);
disp('DC katsayısı gerçekten tüm değerlerinin toplamıdır.')
figure, 
subplot(121),imshow(mat2gray(log(1+abs(caf))))
subplot(122),imshow(abs(icaf),[])
% Örnek-2
a = [zeros(256,128) ones(256,128)];
figure;
subplot(121), imshow(a,[]); 
title('Orijinal görüntü');
af = fftshift(fft2(a));
subplot(122), imshow(mat2gray(log(1+abs(af))));
title('DFT matrisinin tersinin Kaydırılmışı');
%saveas(gcf,[mypath 'FFT2-2.jpg'])
% Örnek-2
a = zeros(256,256);
a(78:178,78:178)=1;
figure;
subplot(121), imshow(a,[]); 
title('Orijinal görüntü');
af = fftshift(fft2(a));
subplot(122), fftshow(af,'log');
title('DFT matrisinin tersinin Kaydırılmışı');
%saveas(gcf,[mypath 'FFT2-2.jpg'])
% 3. Şimdi $45^\circ$ döndürülmüş bir kutuya bakalım.
[x,y] = meshgrid(1:256,1:256);
b = (x+y<329) & (x+y>182) & (x-y>-67) & (x-y<73);
figure,
subplot(121),imshow(b)
bf = fftshift(fft2(b));
subplot(122), fftshow(bf,'log')
%saveas(gcf,[mypath 'FFT2-4.jpg'])

% 4. Küçük bir çember oluşturup dönüşümüne bakalım.
[x,y] = meshgrid(-128:127,-128:127);
z = sqrt(x.^2 + y.^2); 
d0 = 15;
c = z < d0; % d0 yarıçaplı daireyi tanımlar.
figure,
subplot(121),imshow(c)
cf = fftshift(fft2(c));
subplot(122),fftshow(cf,'log')
%saveas(gcf,[mypath 'FFT2-5.jpg'])
b = 1./(1 + (z./d0).^2);
figure
subplot(121), imshow(b)
bf = fftshift(fft2(b));
subplot(122),fftshow(bf,'log')
%% ALÇAK GEÇİREN FİLTRELER
img = imread('cameraman.tif');
[m,n] = size(img);
f = figure;
f.Position = [10 10 500 500];
subplot(321), imshow(img)
cf = fftshift(fft2(img));
subplot(322), fftshow(cf,'log')
[x,y] = meshgrid(-floor(m/2):floor(m/2)-1,...
                 -floor(n/2):floor(n/2)-1);
z = sqrt(x.^2+y.^2);
D = 15; % cutoffs
c1 = z < D;
cf1 = cf.*c1; % Frekans bölgesinde filtreleme
subplot(324), fftshow(cf1,'log');
s1 = ifft2(cf1);
subplot(323), fftshow(s1,'abs');

D = 75;
c2 = z < D;
cf2 = cf.*c2;
subplot(326), fftshow(cf2,'log');
s2 = ifft2(cf2);
subplot(325), fftshow(s2,'abs');
%saveas(gcf,[mypath 'LowF.jpg'])
%% YÜKSEK GEÇİREN FİLTRELER
cm = imread('cameraman.tif');
[m,n] = size(cm);
[x,y] = meshgrid(-floor(m/2):floor(m/2)-1,...
                 -floor(n/2):floor(n/2)-1);
z = sqrt(x.^2+y.^2);
c = z > 40;
cf = fftshift(fft2(cm));
f = figure;
f.Position = [10 10 800 300];
subplot(131), fftshow(cf,'log');
title('Frekans bölgesi görüntüsü');
cfh = cf.*c; 
subplot(132), fftshow(cfh,'log');
title({'Yüksek geçişli Frekans' 'bölgesi görüntüsü'});
cfhi = ifft2(cfh);
subplot(133), fftshow(cfhi,'abs')
title('Yüksek Filtrelenmiş görüntü');
%saveas(gcf,[mypath 'HighF.jpg'])
%% Butterworth 1.dereceden filtreleme örneği
cm = imread('cameraman.tif');
[m,n] = size(cm);
cf = fftshift(fft2(cm));
%figure, fftshow(cf)
f = figure;
f.Position = [10 10 800 700];
title('Frekans bölgesi görüntüsü');
[x,y] = meshgrid(-floor(m/2):floor(m/2)-1,...
                 -floor(n/2):floor(n/2)-1);
z = sqrt(x.^2+y.^2);
n = 1; % Butturworth derecesi
D = 50;
bL = 1./(1+(z/D).^(2*n));% Alçak geçiren 1.Butterworth
%bH = 1 - bL;% Yüksek geçiren Butterworth
cfbL = cf.*bL;
subplot(221), fftshow(cfbL,'log');
title('Butterwort Lp-filtrelenmiş DFT');
b = ifft2(cfbL);
subplot(222),fftshow(b,'abs')
title({'Sonuç görüntü'});

bH = 1 - 1./(1+(z/D).^(2*n));% Yüksek geçiren 1.Butterworth
cfbH = cf.*bH;
subplot(223), fftshow(cfbH,'log');
title('Butterwort Hp-filtrelenmiş DFT');
b = ifft2(cfbH);
subplot(224),fftshow(b,'abs')
title({'Sonuç görüntü'});
%saveas(gcf,[mypath 'Butterworth1.jpg'])
%% Frekans bölgesinde Gauss filtreleme 
cm = imread('cameraman.tif');
cf = fftshift(fft2(cm));
g1 = mat2gray(fspecial('gaussian',256,10));
cg1 = cf.*g1;
g2 = mat2gray(fspecial('gaussian',256,30));
cg2 = cf.*g2;
f = figure;
f.Position = [10 10 800 700];
subplot(221), fftshow(cg1,'log');
title({'Yüksek geçiren Gauss' '(a) \sigma = 10'});
cgi1 = ifft2(cg1);
subplot(222), fftshow(cgi1,'abs');
title('(b) Gauss Filtreli görüntü');

subplot(223), fftshow(cg2,'log');
title({'Yüksek geçiren Gauss' '(b) \sigma = 30'});
cgi2 = ifft2(cg2);
subplot(224), fftshow(cgi2,'abs');
title('(b) Gauss Filtreli görüntü');

% High pass Gauss filtresi
h1=1-g1;
h2=1-g2;
ch1=cf.*h1;
ch2=cf.*h2;
chi1=ifft2(ch1);
chi2=ifft2(ch2);
figure,
subplot(221), fftshow(ch1,'log');
subplot(222), fftshow(chi1,'abs')
title({'Yüksek geçiren Gauss' '\sigma = 10'});
subplot(223), fftshow(ch2,'log');
subplot(224), fftshow(chi2,'abs')
title({'Yüksek geçiren Gauss' '\sigma = 30'});
%saveas(gcf,[mypath 'GaussianF.jpg'])
%% Periyodik gürültünün yok edilmesi
% Yapay periyodik gürültü ekleme
clear;close all
a = imread('lena.tif');
b = rgb2gray(a);
[m,n] = size(b);
[x,y] = meshgrid(1:m,1:n);
p = 1 + sin(x + y/1.5);
tp = (double(b)/128 + p)/8;
f = figure;
f.Position = [10 10 800 600]; 
subplot(121), imshow(tp, []);
title('Yapay Periyodik Gürültülü Görüntü')
tpfft = fft2(tp);
af = fftshift(tpfft);
tf = log(1+abs(af));
subplot(122), imshow(log(1 + abs(tf)), []);
title('FFT Görüntüsü')
hold on 
r = [177 338];
c = [204 312];
plot(r,c,'ro','linew',1.2)
hold off
imtool(log(1 + abs(tf)), []);
%saveas(gcf,[mypath 'FFT1.jpg'])
%% Band söndüren filtreleme
% Bütün noktaların görüntü merkezine uzaklığı
z = sqrt((x - m/2).^2 + (y - n/2).^2);
br = (z < 95 | z > 100); % band geçiren filter oluşturma
tbr = af .* br; % Filtrelenmiş görüntü
f = figure;
f.Position = [10 10 800 600]; 
subplot(121), imshow(log(1+abs(tbr)), []);
title('Frekans bölgesindeki Band Filtesi')
s = ifft2(tbr);
subplot(122), imshow(abs(s), []);
title('Band Filtrelenmiş görüntü')
%saveas(gcf,[mypath 'bandFilter.jpg'])
%% Notch (Çentik) Filtre
D0 = 5;
z1 = sqrt((x - r(1)).^2 + (y - c(1)).^2);
z2 = sqrt((x - r(2)).^2 + (y - c(2)).^2);
cr1 = z1 >= D0; 
cr2 = z2 >= D0;
tNotch = af.*cr1.*cr2; % Filtrelenmiş görüntü
f = figure;
f.Position = [10 10 800 600];
subplot(121), imshow(log(1+abs(tNotch)),[]);
title('Frekans bölgesindeki Notch Filtresi')
s = ifft2(tNotch);
subplot(122), imshow(abs(s), []);
title('Notch Filtrelenmiş görüntü')
%saveas(gcf,[mypath 'NotchFilter1.jpg'])
%% Hareket bulanıklığını yok etme
bc = imread('board.tif');
bg = im2uint8(rgb2gray(bc));
b = bg(100:355,50:305);
[row,col] = size(b);
% uint8 tipinde gri ölçekli alt görüntü alındı.
f = figure;
f.Position = [10 10 800 600];
subplot(221),imshow(b);
title('Orijinal görüntü');

m = fspecial('motion',7,0); % bulanıklaştırma filtresi
bm = imfilter(b,m); % görüntü bulanıklaştırıldı
subplot(222), imshow(bm);
title('Motion Filtreli görüntü');
% 
m2 = zeros(row,col);
m2(1,1:7) = m; % bulanıklığı yapan filtreyi oluşturma
mf = fft2(m2); % frekans uzayına dönüştürme(çok küçük değerli)
d = 0.02;  %bölme işlemini $(d=0.02)$ eşik değeri ile sınırla
mf(abs(mf) < d) = 1;
subplot(223), imshow(abs(mf));
title({'Frekans Bölgesinde' 'Motion Filtreli görüntü'});

bmi = ifft2(fft2(bm)./mf);
subplot(224), imshow(mat2gray(abs(bmi))*2)
title('Sonuç görüntü');
mf = fft2(m2); % frekans uzayına dönüştürme(çok küçük değerli)
bmi = ifft2(fft2(bm)./mf);
figure(2),imshow(abs(bmi),[]);
title({'Frekans Bölgesinde' 'Motion Filtreli koyu görüntü'});
%saveas(f,[mypath 'MotionFilter.jpg'])