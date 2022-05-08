%% Bölütleme-2 
% Ders 8_2-1
%% Global Temel Eşik hesabı.
clc;close all;
f = imread('fingerprint.tif');
T = mean2(f);
done = false; count = 0;
while ~done
    count = count + 1;
    g = f > T;
    Tnext = 0.5*(mean(f(g)) + mean(f(~g)));
    done = abs(T - Tnext) < 0.5; 
    % Ardışık eşik farkınının tolerans değerden küçük olması
    T = Tnext;
end
fprintf('Bölge sayısı=%d, Eşik = %3.3f\n',count,T)
bw = imbinarize(f,T/255); % Eşik değerine göre bölütleme
figure, imshow(f) 

figure, imhist(f); ylim([0,24000])
title(['Global eşik değeri= ' num2str(T) newline ...
    'Yineleme Sayısı=' num2str(count)])
%exportgraphics(gcf,[filepath,'fingerHist.png'])
figure, imshow(bw)
%exportgraphics(gcf,[filepath,'ThreshFinger.png'])
%% Otsu yöntemi kullanılarak görüntü bölütleme.
f = imread('fingerprint.tif');
[T,SM] = graythresh(f);
bw = imbinarize(f,T); % Eşik değerine göre bölütleme
figure, imshow(bw) 
title(['Otsu Eşiği = ' num2str(T*255) ...
    ',   Ayrılabilirlik Ölçüsü =' num2str(SM)])
%% Temel eşik ve Otsu eşiğinin karşılaştırılması
close all;clc;
f = imread('polymercell.tif');
figure, imshow(f)
figure, imhist(f); ylim([0,52000])
T = 169.395; % Temel global eşik değeri
bwGlobal = imbinarize(f,T/255);
figure, imshow(bwGlobal) 
title(['Temel Eşik = ' num2str(169.395)])
[T,SM] = graythresh(f);
bwOtsu = imbinarize(f,T);
figure, imshow(bwOtsu)
title(['Otsu Eşiği = ' num2str(T*255) ',  SM=' num2str(SM)])
%exportgraphics(gcf,[filepath,'OtsuPolimer.png'])
%% Manuel global eşikleme için histograma polinom uydurma
clc;close all;
I = imread('coins.png');   % Read in original
subplot(221), imshow(I);   % Display original
title('Orijinal Görüntü')
bw = imbinarize(I,84/255);
subplot(222), imshow(bw);  % result of manual threshold
title('Manuel Eşikli Görüntü')
[counts,X] = imhist(I);    % Calculate image histogram
P = polyfit(X,counts,10); 
Y = polyval(P,X); % Fit to histogram and evaluate
TF = islocalmin(Y);
%ind = X(TF);
polythresh = median(X(TF))/255; % üç minimum olduğundan ind(3) alındı.

bwP = imbinarize(I,polythresh);
subplot(223), imshow(bwP) % result of Polynomial theshold
title('Polinom Eşikli Görüntü')
level = graythresh(I);
bwO = imbinarize(I,level);
subplot(224), imshow(bwO)  % result of Otsu's method
title('Otsu Eşikli Görüntü')
figure; plot(X, counts,'b',X(TF),Y(TF),'k*');
xticks(0:20:260)
hold on 
plot(X,Y,'r'); % histogram and polynomial fit
title({'Eşiği belirlemek için' 'histograma polinom uydurma'})
pl=line([polythresh*255 polythresh*255], [min(Y) max(Y)]);
pl.LineStyle = '--';
pl.Color = 'black';
pl.LineWidth = 1.5;
text(polythresh*255, max(Y)+100, 'Eşik')
%% Örnek-Using the Sobel edge detector 
clc; close all
I = imread('building.tif');
fig = figure;
fig.Position = [50 50 600 500];
subplot(231), imshow(I)
title('Orijinal görüntü')
% Bir başlangıç noktası olarak, kenar eşiği bulalım.
[gvl, tl] = edge(I,'sobel','vertical','nothinning');
subplot(232), imshow(gvl)
title({'Ağırlıklı olarak dikey' 'kenarlı sonuç'})
% Güçlü dikey kenarların baskın olduğu bir sonuç elde 
% etmek için eşik 0.10'a yükseltildi.
gv2 = edge(I,'sobel',0.10,'vertical','nothinning');
subplot(233), imshow(gv2)
title({'Ağırlıklı olarak dikey' 'eşikli kenar sonucu'})
gboth = edge(I,'sobel',0.10,'nothinning');
subplot(234), imshow(gboth)
title({'Yatay-dikey' 'eşikli kenar sonucu'})
% Edge fonksiyonu 45 derecedeki Sobel kenarlarını 
% hesaplamaz bunun için kendimiz filtreleme yaparız.
wpos45 =[0 1 2; -1 0 1; -2 -1 0]; % 
gpos45 = imfilter(I,wpos45,'replicate');
subplot(235), imshow(gpos45)
title({'45 dereceli Sobel' 'kernel sonucu'})
gpos45T = gpos45 >= 0.3*max(abs(gpos45(:)));
subplot(236), imshow(gpos45T)
title({'-45 dereceli Sobel' 'kernel sonucu'})