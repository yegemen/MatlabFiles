%% Bölütleme-2
% Ders 8_2
%% 2D-bwdist fonksiyonu incelemesi
% *bwdist* fonksiyonu, ikili bir görüntüde bir piksel ile en yakın sıfırdan 
% farklı piksel arasındaki mesafeyi o piksel değeri olarak atayarak single tipli 
% bir görüntü döndürür.

bw = zeros(200,200);
bw(50,50) = 1; bw(50,150) = 1; bw(150,100) = 1;
figure, imshow(bw);
title('Yapay ikili görüntü');    % Mesafe dönüşümleri
D1 = bwdist(bw,'euclidean');     % Default
D2 = bwdist(bw,'cityblock');
D3 = bwdist(bw,'chessboard');
D4 = bwdist(bw,'quasi-euclidean');
figure
subplot(221), imshow(D1,[]), title('Euclidean')
subplot(222), imshow(D2,[]), title('City block')
subplot(223), imshow(D3,[]), title('Chessboard')
subplot(224), imshow(D4,[]), title('Quasi-Euclidean')

RGB1 = repmat(rescale(D1,0,1), [1 1 3]); % Renkli görüntüye dönüştürme 
RGB2 = repmat(rescale(D2), [1 1 3]);
RGB3 = repmat(rescale(D3), [1 1 3]);
RGB4 = repmat(rescale(D4), [1 1 3]);
figure
subplot(221), imshow(RGB1), title('Euclidean')
hold on, imcontour(D1)
subplot(222), imshow(RGB2), title('City block')
hold on, imcontour(D2)
subplot(223), imshow(RGB3), title('Chessboard')
hold on, imcontour(D3)
subplot(224), imshow(RGB4), title('Quasi-Euclidean')
hold on, imcontour(D4) 
%exportgraphics(gcf,[filepath2,'2D-bwdistFig.png'])
%% 3D-bwdist fonksiyonu incelemesi

bw = zeros(50,50,50); bw(25,25,25) = 1;
D1 = bwdist(bw);
D2 = bwdist(bw,'cityblock');
D3 = bwdist(bw,'chessboard');
D4 = bwdist(bw,'quasi-euclidean');
figure
subplot(221), isosurface(D1,15), axis equal, view(3), axis off
camlight, lighting gouraud, title('Euclidean')
subplot(222), isosurface(D2,15), axis equal, view(3), axis off
camlight, lighting gouraud, title('City block')
subplot(223), isosurface(D3,15), axis equal, view(3), axis off
camlight, lighting gouraud, title('Chessboard')
subplot(224), isosurface(D4,15), axis equal, view(3), axis off
camlight, lighting gouraud, title('Quasi-Euclidean')
%% İkili bir görüntüyü bölütlemek için bwdist ve watershed fonksiyonları

clc;clear;
I = imread('overlapdisks.tif');
figure, 
subplot(221), imshow(I,[])
title('Orijinal çakışık diskler')
D0 = bwdist(I);
subplot(222), imshow(D0,[])
title('bwdist(I) görüntüsü')
subplot(223), imshow(~I,[])
title('Negatif görüntü')
D = bwdist(~I);
subplot(224), imshow(D,[])
title('bwdist(~I) görüntüsü')
% D mesafe görüntüsünün negatifini alarak değerleri çevrelerinden daha düşük 
% olan havuzlar elde ediyoruz.
negD = -D;
figure, 
subplot(121), imshow(negD,[])
%% 
% |Şimdi Havza sırtı dönüşümü için uygun olan bu single tipli görüntüye watershed 
% fonksiyonu uygulanır.|

L = watershed(negD);
%% 
% |L etiket matrisindeki değerler, sırt çizgileri boyunca sıfır ve havuz bölgelerinde 
% pozitif tamsayılardır. L'nin sıfır olduğu konumları bularak havza sırtlarını 
% belirleriz.|

ridges = zeros(size(I));
ridges(L == 0) = 1;
subplot(122), imshow(ridges)
%% 
% |Bölütlenmiş görüntü ile sırt çizgisi görüntüsünü üst üste gösterme.|

Iseg = I;
Iseg(ridges == 1) = 0;
figure, imshow(Iseg)
%% 
% |L'de I görüntüsünün arka planı olan noktalardaki etiketleri sıfır yaparız 
% ve label2rgb fonksiyonu ile RGB görüntü olarak L etiket matrisini görüntüleriz.|

L(~I) = 0;
rgb = label2rgb(L,'hot(4)','k'); 
figure, imshow(rgb)
%% 
% |Tüm arka plan pikselleri havuzun minimumlarından daha küçük yapılarak, havza 
% sırtı çizgileri sadece iki beyaz bölge arasında değil, bu bölgeler ve arka plan 
% arasında bir sınır çizgisi oluşturacak şekilde, nesnede olmayan tüm noktalar 
% ayrı bir havuz oluşturmaya zorlanır.|

negD(~I) = -Inf; % en yüksek piksel değerler nesne sınırır ve havza sırt çizgisinde bulunan pikseller olur.
figure, imshow(negD,[]); 
title('Arka plan ve nesnenin havuz olduğu görüntü')
%% 
% Şimdi bu şekilde oluşturulan bölütleme fonksiyonunun havza sırtı dönüşümünü 
% alalım ve etiket matrisinin sıfır olduğu yerleri görüntüleyelim.

L = watershed(negD);        % calculate watershed of modified segmentation function
figure, imshow(L==0);
title('Nesne sınırı ve havza sırtı çizgilerinin görüntüsü')
%% 
% Görüldüğü gibi elde edilen sonuç görüntü üst üste binmiş disklerin sınır çizgilerini 
% ve havza sırtı çizgisini içerir.
%% Özet: ikili bir görüntüyü bölütlemek
% |Üst üste binmiş iki diskten oluşan yapay bir ikili görüntü oluşturma|

center1 = -40;                    % Create artificial image.....
center2 = -center1;
dist = sqrt(2*(2*center1)^2);
radius = dist/2 * 1.4;
lims = [floor(center1 - 1.2*radius) ceil(center2 + 1.2*radius)];
[x,y] = meshgrid(lims(1):lims(2));
bw1 = sqrt((x-center1).^2 + (y-center1).^2) <= radius;
bw2 = sqrt((x-center2).^2 + (y-center2).^2) <= radius;
bw  = bw1 | bw2;                  % iki görüntünün birleşim bölgesini oluşturma.
figure,
subplot(121), imshow(bw);         % Display artificial image
%% 
% |İkili görüntünün tümleyeni (~bw) alınarak Öklid uzaklık dönüşümü ile temel 
% bölütleme fonksiyonunu oluşturulur.|

D = bwdist(~bw);   
subplot(122), imshow(D,[]);        % Display basic segmentation function                                                    		
%% 
% |Temel bölütleme fonksiyonunun tüm değerleri negatif yapılarak ve arka plan 
% pikselleri tüm havuz minimumlarından daha düşük değere ayarlanır.|

negD = -D;               % Bölütleme fonksiyonunu modifiye etme
figure, imshow(negD,[]); % Display modified segmentation image
negD(~bw) = -inf;        % Tüm arka plan pikselleri havuzun minimumlarından daha küçük yapıldı
L = watershed(negD);     % calculate watershed of modified segmentation function
figure, imshow(L==0); 
title('Nesne sınırı ve havza sırtı çizgilerinin görüntüsü')
%% 
% |Son olarak, havza sırtı dönüşümüne uygun hale getirilen temel bölütleme fonksiyonuna 
% havza bölütlemesi uygulanır ve elde edilen etiket matrisi L görüntülenerek bölütlenmiş 
% görüntü elde edilir.|

figure, imagesc(L); 
axis image; axis off;  
colormap(hot(12)); colorbar;        % Display labelled image - colour coded	
%% Görüntü gradyantı kullanılarak gri ölçekli görüntülerin watershed bölütlemesi

clear;
f = im2double(imread('bubbles.tif')); % Gradiyent hesabı için double tipli görüntü okunur.
figure, imshow(f)
title('Orijinal gri tonlu görüntü')

Gmag = imgradient(f);
figure, imshow(Gmag,[])
title('Gradyent şiddeti görüntüsü')

L = watershed(Gmag);
ridges = L == 0;
figure, imshow(ridges)
title('Havza sırtlarının görüntüsü')

% Smooth the image.
fs = imgaussfilt(f, 0.01*size(f,1));
figure, imshow(fs)
title('Düzgünleştirilmiş görüntü')
% Compute the gradient for basic segmentation function.
gs = imgradient(fs);
figure, imshow(gs,[]); 
title('Düzgünleştirilmiş görüntünün gradyentinin şiddeti')

Ls = watershed(gs);
ridgess = Ls == 0;
figure, imshow(ridgess)
title('Hazva sırtlarının görüntüsü')
%% 
% Tüm minimumları bastırma.

gsm = imhmin(gs,0.04);
figure, imshow(gsm,[])
title('Baştırılmış minimumların görüntüsü')

Lsm = watershed(gsm);
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,1) = ridgessm; % Kırmızı renkli sırt çizgileri oluşturma.
figure, imshow(ridgessmrgb)
title('Hazva sırtlarının görüntüsü')

C = imfuse(f,ridgessmrgb,'blend','Scaling','joint');
figure, imshow(C)
title('Üst üste bindirilmiş görüntü')

LsmRGB = label2rgb(Lsm);
D = imfuse(LsmRGB,ridgessmrgb,'blend','Scaling','joint');
figure, imagesc(D); 
axis image; axis off;  
colormap(hot(18)); %colorbar;  
%exportgraphics(gcf,[filepath,'graywatershed.png'])
%% |Morfolojik işlem ve Watershed bölütlemesi.|
% |Bu örnekte, havza sırtı mükemmel bir segmentasyon sağlar. Örtüşen madeni 
% paraların havza sırtı hesabından önce eşikli görüntüde morfolojik açılma yapmak 
% gerekir.|

clear;
f = im2double(imread('overlapping_euros1.png'));   % Read in image      
figure, imshow(f);       
title('Orijinal Görüntü')

se = strel('disk',13); 
fo = imopen(f,se);             % Arka planın temizlenmesi
figure, imshow(fo);       
title('Açılmış Görüntü')

% Smooth the image.
fs = imgaussfilt(fo, 5.55);
figure, imshow(fs)
title('Gauss Filtreli Görüntü')
% fe = edge(fs,'sobel');
% figure, imshow(fe)

% Compute the gradient.
gs = imgradient(fs);
figure, imshow(gs,[]);
title('Gradyent Şiddetinin Görüntüsü')

gsm = imhmin(gs,0.049);
figure, imshow(gsm,[])
title('Bastırılmış Görüntü')
Lsm = watershed(gsm);
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,2) = ridgessm;
figure, imshow(ridgessmrgb)
title('RGB Sırt Görüntüsü')

C = imfuse(f,ridgessmrgb,'blend','Scaling','joint');
figure, imshow(C,[])
title('Üst üste bindirilmiş görüntü')
LsmRGB = label2rgb(Lsm,'jet(5)',[0 0 0]); 
D = imfuse(f,LsmRGB,'blend','Scaling','joint');
figure, imshow(D); 
axis image; axis off;  
colormap(jet);             % Display labelled image - colour coded	
%% Watershed segmantation on the raw gradient image

clear;
f = imread('overlapping_euros.jpg');       %Read image
f = im2double(f);
figure, imshow(f);      %Display image 
title('Original image')

se = strel('disk',17);
fmax = imdilate(f,se); fmin = imerode(f,se);
fgrad =  fmax - fmin; % Morfolojik gradyent

% Calculate basic segmentation function 
fsm = imhmin(fgrad,0.09);
figure, imshow(fsm,[]);  %Display basic segmentation function                                         
title('Mofrolojik gradyent')

Lsm = watershed(fsm); 
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,2) = ridgessm;
figure, imshow(ridgessmrgb)
title('RGB Sırt Görüntüsü')

LsmRGB = label2rgb(Lsm,'jet',[0 0 0]);    
figure, 
imshow(LsmRGB,'InitialMagnification','fit') % Display labelled image
title('Watershed')

D = imfuse(f,LsmRGB,'blend','Scaling','joint');
figure, imagesc(D); 
axis image; axis off;  
colormap(hot(18)); colorbar;  
%% İşaretçi-kontrollü havza sırtı bölütlemesi
clear; 
%% 
% *Step 1.* *Renkli görüntüyü okuma ve Gri ölçeğe dönüştürme.*

rgb = imread('pears.png');
I = im2double(rgb2gray(rgb));      % Mask-1
figure, imshow(rgb)
title('Orijinal renkli görüntü')
figure, imshow(I)    
title('Orijinal gri ölçekli görüntü')
%% 
% *Step 2.* *Temel bölütleme fonksiyonu olarak gradyant şiddetini hesaplama 
% ve kullanma.*
% 
% |Gradyentin, nesnelerin kenarlarında yüksek ve içinde (çoğunlukla) düşük değerler 
% döndürdüğünü hatırlayın.|

gmag = imgradient(I);
figure, imshow(gmag,[])
title('Gradient Magnitude')
%% 
% |Watershed dönüşümünü doğrudan gradyent şiddetini kullanarak görüntüyü bölütleyebilir 
% misiniz?|

L = watershed(gmag);
%Lrgb = label2rgb(L);
figure, imshow(L,[])
title('Gradyent şiddetinin havza sırtı dönüşümü')
%% 
% |Sonuçtanda görülebileceği gibi cevap hayırdır. Aşağıdaki işaretleyici hesaplamaları 
% gibi ek ön işleme adımları olmadan, doğrudan havza dönüşümünü kullanmak genellikle 
% "aşırı bölütleme" ile sonuçlanır.|
% 
% *Step 3. Ön plan nesnelerini işaretleme.*
% 
% |Ön plan nesnelerinin her birinin içindeki piksel lekelerine (bloblarına) 
% bağlanması gereken ön plan işaretçilerini bulmak için çeşitli prosedürler uygulamamız 
% gerekir. Bu örnekte, görüntüyü "temizlemek" için "yeniden yapılandırma ile açma-kapama" 
% morfolojik işlemlerini kullanarak Ön Plan Nesnelerini işaretleyceğiz.|
% 
% |Açma, genişlemenin ardından erozyondur. Yeniden yapılanma ile açma ise erozyon 
% ve ardından morfolojik yeniden yapılandırmadır. Şimdi ikisini karşılaştıralım. 
% İlk olarak, *imopen* kullanarak açmayı hesaplayalım.|

se = strel('disk',20);
Io = imopen(I,se);       % Gri ölçekli görüntüdeki küçük parlak bölgeleri bastırır.
figure, imshow(Io)
title('Opening')
%% 
% |Ardından, *imerode* ve *imreconstruct* kullanarak yeniden yapılandırma ile 
% açmayı hesaplayalım.|
% 
% |Morfolojik erezyon ile görüntüdeki yüksek yoğunluklu nesneleri tanımlayan 
% bir işaretleyici görüntüsü oluşturulur.| 
% 
% |İşaretleyici görüntü ile maske görüntüsü üzerinde yeniden yapılandırma ile 
% morfolojik açma gerçekleştirilerek maskedeki yüksek yoğunluklu nesneler tanımlanabilir.|

Ie = imerode(I, se);             % Marker
Iobr = imreconstruct(Ie, I);     
figure, imshow(Iobr)
title('Yeniden yapılandırma ile açma sonrası')
%% 
% |Açmanın ardından kapamayla koyu noktalar ve gövde izleri kaldırılabilir. 
% Morfolojik kapama ile yeniden yapılandırmayla kapamayı karşılaştırma. İlk önce 
% açmanın ardından kapamayı deneyelim.|

Ioc = imclose(Io,se);
figure, imshow(Ioc)
title('Opening-Closing')
%% 
% |Şimdi *imdilate (genişleme)* ve ardından *imreconstruct*'ı kullanalım. *imreconstruct*'da 
% girdinin ve çıktının tümleyenini almamız gerektiğine dikkat edin.|

Iobrd   = imdilate(Iobr, se);    % max(Iobr)
figure, imshow(imcomplement(Iobrd));   
title('Açılmış görüntünün genişlemesi')
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr); 
figure, imshow(Iobrcbr);   
title('Yeniden yapılandırma ile açma-kapama')
%% 
% |_Iobrcbr (yeniden yapılandırma ile açılmış görüntü)_ ile _Ioc (açmanın ardından 
% kapamanın görüntüsü)_'u karşılaştırarak görebileceğimiz gibi, yeniden yapılandırmayla 
% açma-kapama, nesnelerin genel şekillerini etkilemeden küçük kusurları gidermede 
% standart açma ve kapamadan daha etkilidir. Daha iyi ön plan işaretcileri elde 
% etmek için _Iobrcbr_'nin bölgesel maksimumunu hesaplayalım.|
% 
% |Bu işlemi, *imregionalmax* kullanılarak her nesnenin içinde düz maksimum 
% bölgeler oluşturarak yaparız.|
% 
% |*imregionalmax:* Gri ölçekli _*I*_ görüntüsündeki bölgesel maksimumları tanımlayan 
% ikili bir _BW_ görüntüsü döndürür.|

fgm = imregionalmax(Iobrcbr); % Ön plan işaretcisi
figure, imshow(fgm);
title('Yeniden yapılandırma ile açma-kapamanın bölgesel maksimumları')
%% 
% |Sonucu yorumlamak için, bu ön plan işaretleyici görüntüsü ile orijinal görüntüyü 
% üst üste yerleştirelim.|
% 
% |B = labeloverlay(A,BW), girdi görüntüsünü _BW_ maskesinin doğru (1=true) 
% olduğu bir renkle birleştirir ve arka plan (0=false etiketli) piksellerini bir 
% renkle birleştirmez.|

I2 = labeloverlay(I,fgm);
figure, imshow(I2);       
title('Orijinal görüntü üzerine yerleştirilmiş bölgesel maksimumlar')	
%% 
% |Genel olarak, kapalı ve gölgeli nesnelerin bazılarının işaretlenmediğine 
% dikkat edin; bu nesneler sonuçta düzgün şekilde bölütlenemeyecektir. Ayrıca, 
% bazı nesnelerdeki ön plan işaretcileri, nesnelerin kenarına kadar gider. Bu, 
% işaretçi lekelerinin kenarlarını temizlemeniz ve ardından biraz küçültmeniz 
% gerektiği anlamına gelir. Bunu kapama ve ardından erozyonla yapabiliriz.|

se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);  % Küçük karanlık bölgeleri bastırır.
figure, imshow(fgm2);
fgm3 = imerode(fgm2, se2); % min(fgm2)
figure, imshow(fgm3); 
%% 
% |Bu prosedür, kaldırılması gereken bazı başıboş izole pikseller bırakma eğilimindedir. 
% Bu izole pikselleri, belirli bir sayıdan daha az piksele sahip tüm blobları 
% kaldıran *bwareaopen*'ı kullanarak kaldırabiliriz.|
% 
% |*bwareaopen:*| <https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-BW2 
% |BW2|> |= bwareaopen(|<https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-BW 
% |BW|>|,|<https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-P 
% |P|>|) ikili görüntü _BW_'den _P_ pikselden küçük olan tüm bağlantılı bileşenleri 
% (nesneleri) kaldırır ve bir _BW2_ ikili görüntüsü üretir. Bu operasyon, alan 
% açma olarak bilinir. Şimdi ikili görüntüdeki 20 pikselden küçük bölgeleri temizleyerek 
% yeni bir ikili görüntü oluşturuldu.|

fgm4 = bwareaopen(fgm3, 20);
figure,  imshow(fgm4);
I3 = labeloverlay(I,fgm4);
figure,  imshow(I3);	  
title('Orijinal görüntü üzerine yerleştirilmiş modifiye bölgesel maksimumlar')
%% 
% |*Step 4:* A*rka plan işaretcilerini hesaplama.*|
% 
% |Yeniden yapılandırma ile açma-kapama morfolojik işlemleri kullanarak temizlenen 
% Ön Plan Nesnelerinin işaretcileri _Iobrcbr_ görüntüsünde koyu pikseller artık 
% arka plana aittir. Şimdi buna bir eşikleme işlemi yapalım.|

bw = imbinarize(Iobrcbr);
figure, imshow(bw);
title('Eşiklenmiş yeniden yapılandırma ile açma-kapama görüntüsü')
%% 
% |Arka plan pikselleri siyahtır, ancak ideal olarak arka plan işaretçilerinin, 
% bölütlemeye çalıştığımız nesnelerin kenarlarına çok yakın olmasını istemeyiz. 
% _bw_'nin ön planının "etki bölgelerine göre iskeletini" hesaplayarak arka planı 
% "incelteceğiz". Bu, bw'nin mesafe dönüşümünün havza dönüşümü hesaplanmasının 
% ardından sonucun havza sırtı çizgileri (DL == 0) aranarak yapılabilir.|

D = bwdist(bw);
figure, imshow(D,[]);
DL = watershed(D);	  
bgm = DL == 0;        % ön plan (nesne) piksellerinin sınırları
figure, imshow(bgm); 
title('Havza sırtı çizgileri')
%% 
% *Step 5: Temel fonksiyonun havza dönüşümünü hesaplama.*
% 
% |J = imimposemin(I,BW) morfolojik rekonstrüksiyon kullanarak gri tonlamalı 
% _I_ maske görüntüsünü modifiye eder, _BW_, ikili işaretleyici görüntünün sıfır 
% olmadığı her yerde yalnızca bölgesel minimuma sahiptir.|
% 
% |*İmimposemin* fonksiyonu, bir görüntüyü yalnızca istenen belirli konumlarda 
% bölgesel minimumlara sahip olacak şekilde değiştirmek için kullanılır. Bölgesel 
% minimumun sadece ön plan ve arka plan işaretçi piksellerinin oluştuğu yerlerde 
% gradyant şiddeti görüntüsünü modifiye etmekte kullanabilir.|

gmag2 = imimposemin(gmag, bgm | fgm4);
figure, imshow(gmag2);
%% 
% |Sonuçta, havza tabanlı bölütlemeyi hesaplamaya hazırız.|

L = watershed(gmag2);
%% 
% *Step 6:* *Sonucu görüntüleme.*
% 
% |Bir görselleştirme tekniği, ön plan işaretleyicilerini, arka plan işaretleyicilerini 
% ve bölütlenmiş nesne sınırlarını orijinal görüntü üzerine bindirmektir. L == 
% 0 olan yerlerde bulunan nesne sınırları gibi belirli yönleri daha görünür hale 
% getirmek için genişleme kullanabiliriz. İkili ön plan (bgm) ve arka plan (fgm4) 
% işaretçilerinin, farklı etiketlere atanmaları için farklı tamsayı değerleriyle 
% ölçekleriz.|

labels = imdilate(L==0, ones(3,3)) + 2*bgm + 3*fgm4;
I4 = labeloverlay(I,labels);
figure, imshow(I4)
title('Orijinal görüntü üzerine bindirilmiş işaretçiler ve nesne sınırları')
%% 
% |Bu görselleştirme, ön plan ve arka plan işaretçilerinin konumlarının sonucu 
% nasıl etkilediğini gösterir. Birkaç yerde, kısmen kapatılmış daha koyu nesneler, 
% daha parlak komşu nesnelerle birleştirilmiştir, çünkü kapatılan nesnelerin ön 
% plan işaretçileri yoktu.|
% 
% |Bir başka kullanışlı görselleştirme tekniği, etiket matrisini renkli bir 
% görüntü olarak görüntülemektir. Watershed ve bwlabel tarafından üretilenler 
% gibi etiket matrisleri, label2rgb kullanılarak görselleştirme amacıyla gerçek 
% renkli görüntülere dönüştürülebilir.|

Lrgb = label2rgb(L,'jet','w','shuffle');
figure, imshow(Lrgb)
title('Renkli havza sırtı etiket matrisi')
%% 
% |Bu sahte-renk etiket matrisini orijinal yoğunluk görüntüsünün üzerine bindirmek 
% için saydamlığı kullanabiliriz.|

figure
imshow(I)
hold on
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Orijinal görüntüye saydam bir şekilde bindirilmiş renkli etiketler')