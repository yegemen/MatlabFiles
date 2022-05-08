%% Frekans bölgesi işlemleri -- 1
% Ders 7
%% 1- DFT oluşturma ve Görüntüleme
clear; clc; close all
% Create a black 30x30 image
f = zeros(30,30);
% With a white rectangle in it.
f(5:24, 13:17) = 1;
q = figure;
q.Position = [10 10 800 700];
subplot(311), imshow(f);
title('Orijinal görüntü')
% Calculate the DFT. 
F = fft2(f);
% There are real and imaginary parts to F.
% Use the abs function to compute the 
% magnitude of the combined components.
F2 = abs(F);
% F = Re(F) + Im(F)*i 
% abs(F)= sqrt(Re(F)^2 + Im(F)^2)
subplot(312), imshow(F2,[]);
title('Log(DFT) görüntüsü');
% f'in DFT'sinin daha iyi bir örneklemini 
% oluşturmak için f'e 2^Nx2^M boyutlu bir  
% sıfır dolgu eklemelisiniz. 2'nin bir 
% kuvveti olan bir dolgu eklemeye dikkat  
% edin. Böylece çok daha hızlı bir Fast           
% Fourier Dönüşümü elde edersiniz.
F = fft2(f, 256, 256);
F2 = abs(F);
subplot(313); imshow(F2,[]);
% F(0,0) sol üst köşede görüntülen, sıfır     
% dc, frekans katsayısını merkezde görüntülemek 
% için fftshift fonksiyonu kullanılır.
Fc = fftshift(F);
F2 = abs(Fc);
q = figure;
q.Position = [10 10 800 700];
subplot(211), imshow(F2,[]);
title('Merkezlenmiş DC, abs(DFT) görüntüsü');
% Fourier dönüşümlerinde, görüntüdeki ayrıntıları   
% gizleyecek kadar yüksek tepeler vardır.    
% log fonksiyonu kullanarak kontrastı azaltır
% ve ayrıntıları ortaya çıkarırız.
F2 = log(1+F2);
subplot(212), imshow(F2,[]) 
title('Merkezlenmiş Log(DFT) görüntüsü');

%% 2-- Uzaysal filtrelenmiş görüntüyü oluşturma
f = imread('entry2.png');
% görüntüyü kayan noktalı türe dönüştürme
%[f, revertclass] = tofloat(f);
f = im2double(f);
[~,~,c] = size(f);
if c ~= 0
  f = f(:,:,1);
end
h = fspecial('sobel');
sfi = imfilter(f,h,'conv'); % default 'corr'.
% Sonucu ekrana verme
q = figure;
q.Position = [10 10 800 700];
subplot(311), imshow(sfi, []);
title('Uzaysal Filtrelenmiş Görüntü');
% abs fonksiyonu ile pozitif sayı elde ediriz.
sfim = abs(sfi);
subplot(312), imshow(sfim, []);
title('Filtrelenmiş Görüntünün şiddeti');
% Eşik uygulanmış ikili görüntü
T = graythresh(sfim);
subplot(313), imshow(sfim>T);
%subplot(313), imshow(sfim>0.2*max(sfim(:)));
title('Eşik uygulanmış Görüntü');

% Frekans filtrelenmiş görüntüyü oluşturma
f = imread('entry2.png');
f = tofloat(f);
[m,n,c] = size(f);
if c ~= 0
  f = f(:,:,1);
end
h = fspecial('sobel');
PQ = paddedsize(size(f));
F = fft2(f, PQ(1), PQ(2));
H = fft2(double(h), PQ(1), PQ(2));
F_fH = H.*F;
ffi = ifft2(F_fH);
ffi = ffi(2:size(f,1)+1, 2:size(f,2)+1);
% Sonucu ekrana verme
q = figure;
q.Position = [10 10 800 700];
subplot(311), imshow(ffi,[])
title('Frekans bölgesinde Filtrelenmiş Görüntü');
  % abs fonksiyonu kompleks sayılarda 
  % kullanıldığında şiddeti verir.
ffim = abs(ffi);
subplot(312), imshow(ffim, []);
title('Filtrelenmiş Görüntünün şiddeti');
% Eşik uygulanmış ikili görüntü 
T = graythresh(ffim);
subplot(313), imshow(ffim>T);
%subplot(313), imshow(ffim>0.2*max(ffim(:)));
title('Eşik uygulanmış Görüntü');

%% 3-- High/Lowpass Filter Sample
clear; close all;clc;
footBall = imread('football.jpg');
% floating sayi tipine donusturme
footBall = im2double(footBall(:,:,1)); 
% Fourier donusumu icin iyi bir doldurma boyutunu belirle
PQ = paddedsize(size(footBall));
% Fourier donusumunun genisligi %5 olan 
% Gaussyen highpass filtresi olusturma
D0 = 0.05*PQ(1);
sec = input('Yuksek/Alcak Gecisli Filtre(1/2)');
switch sec
    case 1
       H = hpfilter('ideal', PQ(1), PQ(2), D0);
    case 2
       H = lpfilter('btw', PQ(1), PQ(2), D0);
    otherwise
        error('Yanlis giris!');
end
str1 = {'Keskinlesmis', 'Bulaniklasmis'};
str2 = {'Highpass', 'Lowpass'};
q = figure;
q.Position = [10 10 800 700];
subplot(221), imshow(footBall);
title('Orijinal goruntu');
% Goruntunun DFT 'sini hesapla
F = fft2(footBall, PQ(1), PQ(2));
% Goruntunun Fourier spektrumuna highpass filter uygula.
FS_football = H.*F;
% Sonucu uzaysal bolgeye donusturme icin reel kismi al.
F_football = real(ifft2(FS_football)); 
% Doldurmayi geri almak icin goruntuyu kirp.
F_football = F_football(1:size(footBall,1),...
                        1:size(footBall,2));
% "Bulaniklasmis" goruntuyu goruntule.
subplot(223), imshow(abs(F_football), [])
title({ str1{sec} 'Goruntu'});
% Fourier Spektrumunu goruntule
% Donusumun merkezini frekans dikdortgenin merkezine tasi.
Fc = fftshift(F);
Fcf = fftshift(FS_football);
% Siddeti hesaplamak icin abs ve aydinlik goruntu 
% icin log kullan.
S1 = log(1+abs(Fc)); 
S2 = log(1+abs(Fcf));
subplot(222), imshow(S1,[])
title('Goruntunun Fourier Spektrumu')
subplot(224), imshow(S2,[])
title({['Gaussyen ' str2{sec} ' Filtreli'] 'Goruntunun Fourier Spektrumu'})
saveas(gcf,'GaussLPF.png')

%% 4-- Notch Filter Sample
clear; close all;clc;
footBall = imread('noiseball.png');
% Gri ölçeğe dönüştürme
footBall = im2double(footBall); 
% Fourier dönüşümü için iyi bir doldurma boyutunu belirle
PQ = paddedsize(size(footBall));
% Görüntünün DFT 'sini hesapla
F = fft2(footBall, PQ(1), PQ(2));
h = figure(1); 
imshow(log(1 + abs(F)), [])
title('Gürültü zirveli Fourier spektrumu');
impixelinfo(h)
hold on
x = [50    1 620  22 592  1];
y = [100 400 100 414 414 114];
plot(x,y,'linestyle','none','marker','o','color','r')
D0 = 15; % filtre yarıçapı
% Notch filtrelerini oluşturma
H1 = notch('btw', PQ(1), PQ(2), D0, 50, 100);
H2 = notch('btw', PQ(1), PQ(2), D0, 1, 400);
H3 = notch('btw', PQ(1), PQ(2), D0, 620, 100);
H4 = notch('btw', PQ(1), PQ(2), D0, 22, 414);
H5 = notch('btw', PQ(1), PQ(2), D0, 592, 414);
H6 = notch('btw', PQ(1), PQ(2), D0, 1, 114);
% Görüntünün Fourier spektrumuna Notcth filteleri uygula.
FS_football = H1.*H2.*H3.*H4.*H5.*H6.*F;

% Sonucu uzaysal bölgeye dönüştürme için reel kısmı al.
F_football = real(ifft2(FS_football)); 

% Doldurmayı geri almak için görüntüyü kırp.
F_football = F_football(1:size(footBall,1),...
                        1:size(footBall,2));
q = figure;
q.Position = [10 10 800 700];
subplot(221), imshow(footBall);
title('Orijinal görüntü');
% Fourier dönüşümündeki zirvelerle ilişkili
% "Keskinleşmiş" görüntüyü görüntüleme.
subplot(223), imshow(F_football, [])
title('Keskinleşmiş görüntü')
% Fourier Spektrumunu görüntüle
% Dönüşümün merkezini frekans dikdörtgenin merkezine taşı.
Fc  = fftshift(F);
Fcf = fftshift(FS_football);
% Şiddeti hesaplamak için abs ve aydınlık görüntü 
% için log kullan.
S1 = log(1+abs(Fc)); 
S2 = log(1+abs(Fcf));
subplot(222), imshow(S1,[])
title('Görüntünün Fourier Spektrumu')
subplot(224), imshow(S2,[])
title({'Notch Filtreli' 'Görüntünün Fourier Spektrumu'})
saveas(gcf,'NocthF1.png')
