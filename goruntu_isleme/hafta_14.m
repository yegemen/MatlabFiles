%% Bölütleme-2
% Ders 8_2
%% 2D-bwdist fonksiyonu incelemesi
% *bwdist* fonksiyonu, ikili bir görüntüde bir piksel ile en yak?n s?f?rdan 
% farkli piksel arasindaki mesafeyi o piksel de?eri olarak atayarak single tipli 
% bir görüntü döndürür.

bw = zeros(200,200);
bw(50,50) = 1; bw(50,150) = 1; bw(150,100) = 1;
figure, imshow(bw);
title('Yapay ikili görüntü');    % Mesafe dönüsümleri
D1 = bwdist(bw,'euclidean');     % Default
D2 = bwdist(bw,'cityblock');
D3 = bwdist(bw,'chessboard');
D4 = bwdist(bw,'quasi-euclidean');
figure
subplot(221), imshow(D1,[]), title('Euclidean')
subplot(222), imshow(D2,[]), title('City block')
subplot(223), imshow(D3,[]), title('Chessboard')
subplot(224), imshow(D4,[]), title('Quasi-Euclidean')

RGB1 = repmat(rescale(D1,0,1), [1 1 3]); % Renkli görüntüye dönü?türme 
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
%% ?kili bir görüntüyü bölütlemek için bwdist ve watershed fonksiyonlar?

clc;clear;
I = imread('overlapdisks.tif');
figure, 
subplot(221), imshow(I,[])
title('Orijinal çak???k diskler')
D0 = bwdist(I);
subplot(222), imshow(D0,[])
title('bwdist(I) görüntüsü')
subplot(223), imshow(~I,[])
title('Negatif görüntü')
D = bwdist(~I);
subplot(224), imshow(D,[])
title('bwdist(~I) görüntüsü')
% D mesafe görüntüsünün negatifini alarak de?erleri çevrelerinden daha dü?ük 
% olan havuzlar elde ediyoruz.
negD = -D;
figure, 
subplot(121), imshow(negD,[])
%% 
% |?imdi Havza s?rt? dönü?ümü için uygun olan bu single tipli görüntüye watershed 
% fonksiyonu uygulan?r.|

L = watershed(negD);
%% 
% |L etiket matrisindeki de?erler, s?rt çizgileri boyunca s?f?r ve havuz bölgelerinde 
% pozitif tamsay?lard?r. L'nin s?f?r oldu?u konumlar? bularak havza s?rtlar?n? 
% belirleriz.|

ridges = zeros(size(I));
ridges(L == 0) = 1;
subplot(122), imshow(ridges)
%% 
% |Bölütlenmi? görüntü ile s?rt çizgisi görüntüsünü üst üste gösterme.|

Iseg = I;
Iseg(ridges == 1) = 0;
figure, imshow(Iseg)
%% 
% |L'de I görüntüsünün arka plan? olan noktalardaki etiketleri s?f?r yapar?z 
% ve label2rgb fonksiyonu ile RGB görüntü olarak L etiket matrisini görüntüleriz.|

L(~I) = 0;
rgb = label2rgb(L,'hot(4)','k'); 
figure, imshow(rgb)
%% 
% |Tüm arka plan pikselleri havuzun minimumlar?ndan daha küçük yap?larak, havza 
% s?rt? çizgileri sadece iki beyaz bölge aras?nda de?il, bu bölgeler ve arka plan 
% aras?nda bir s?n?r çizgisi olu?turacak ?ekilde, nesnede olmayan tüm noktalar 
% ayr? bir havuz olu?turmaya zorlan?r.|

negD(~I) = -Inf; % en yüksek piksel de?erler nesne s?n?r?r ve havza s?rt çizgisinde bulunan pikseller olur.
figure, imshow(negD,[]); 
title('Arka plan ve nesnenin havuz oldu?u görüntü')
%% 
% ?imdi bu ?ekilde olu?turulan bölütleme fonksiyonunun havza s?rt? dönü?ümünü 
% alal?m ve etiket matrisinin s?f?r oldu?u yerleri görüntüleyelim.

L = watershed(negD);        % calculate watershed of modified segmentation function
figure, imshow(L==0);
title('Nesne s?n?r? ve havza s?rt? çizgilerinin görüntüsü')
%% 
% Görüldü?ü gibi elde edilen sonuç görüntü üst üste binmi? disklerin s?n?r çizgilerini 
% ve havza s?rt? çizgisini içerir.
%% Özet: ikili bir görüntüyü bölütlemek
% |Üst üste binmi? iki diskten olu?an yapay bir ikili görüntü olu?turma|

center1 = -40;                    % Create artificial image.....
center2 = -center1;
dist = sqrt(2*(2*center1)^2);
radius = dist/2 * 1.4;
lims = [floor(center1 - 1.2*radius) ceil(center2 + 1.2*radius)];
[x,y] = meshgrid(lims(1):lims(2));
bw1 = sqrt((x-center1).^2 + (y-center1).^2) <= radius;
bw2 = sqrt((x-center2).^2 + (y-center2).^2) <= radius;
bw  = bw1 | bw2;                  % iki görüntünün birle?im bölgesini olu?turma.
figure,
subplot(121), imshow(bw);         % Display artificial image
%% 
% |?kili görüntünün tümleyeni (~bw) al?narak Öklid uzakl?k dönü?ümü ile temel 
% bölütleme fonksiyonunu olu?turulur.|

D = bwdist(~bw);   
subplot(122), imshow(D,[]);        % Display basic segmentation function                                                    		
%% 
% |Temel bölütleme fonksiyonunun tüm de?erleri negatif yap?larak ve arka plan 
% pikselleri tüm havuz minimumlar?ndan daha dü?ük de?ere ayarlan?r.|

negD = -D;               % Bölütleme fonksiyonunu modifiye etme
figure, imshow(negD,[]); % Display modified segmentation image
negD(~bw) = -inf;        % Tüm arka plan pikselleri havuzun minimumlar?ndan daha küçük yap?ld?
L = watershed(negD);     % calculate watershed of modified segmentation function
figure, imshow(L==0); 
title('Nesne s?n?r? ve havza s?rt? çizgilerinin görüntüsü')
%% 
% |Son olarak, havza s?rt? dönü?ümüne uygun hale getirilen temel bölütleme fonksiyonuna 
% havza bölütlemesi uygulan?r ve elde edilen etiket matrisi L görüntülenerek bölütlenmi? 
% görüntü elde edilir.|

figure, imagesc(L); 
axis image; axis off;  
colormap(hot(12)); colorbar;        % Display labelled image - colour coded	
%% Görüntü gradyant? kullan?larak gri ölçekli görüntülerin watershed bölütlemesi

clear;
f = im2double(imread('bubbles.tif')); % Gradiyent hesab? için double tipli görüntü okunur.
figure, imshow(f)
title('Orijinal gri tonlu görüntü')

Gmag = imgradient(f);
figure, imshow(Gmag,[])
title('Gradyent ?iddeti görüntüsü')

L = watershed(Gmag);
ridges = L == 0;
figure, imshow(ridges)
title('Havza s?rtlar?n?n görüntüsü')

% Smooth the image.
fs = imgaussfilt(f, 0.01*size(f,1));
figure, imshow(fs)
title('Düzgünle?tirilmi? görüntü')
% Compute the gradient for basic segmentation function.
gs = imgradient(fs);
figure, imshow(gs,[]); 
title('Düzgünle?tirilmi? görüntünün gradyentinin ?iddeti')

Ls = watershed(gs);
ridgess = Ls == 0;
figure, imshow(ridgess)
title('Hazva s?rtlar?n?n görüntüsü')
%% 
% Tüm minimumlar? bast?rma.

gsm = imhmin(gs,0.04);
figure, imshow(gsm,[])
title('Ba?t?r?lm?? minimumlar?n görüntüsü')

Lsm = watershed(gsm);
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,1) = ridgessm; % K?rm?z? renkli s?rt çizgileri olu?turma.
figure, imshow(ridgessmrgb)
title('Hazva s?rtlar?n?n görüntüsü')

C = imfuse(f,ridgessmrgb,'blend','Scaling','joint');
figure, imshow(C)
title('Üst üste bindirilmi? görüntü')

LsmRGB = label2rgb(Lsm);
D = imfuse(LsmRGB,ridgessmrgb,'blend','Scaling','joint');
figure, imagesc(D); 
axis image; axis off;  
colormap(hot(18)); %colorbar;  
%exportgraphics(gcf,[filepath,'graywatershed.png'])
%% |Morfolojik i?lem ve Watershed bölütlemesi.|
% |Bu örnekte, havza s?rt? mükemmel bir segmentasyon sa?lar. Örtü?en madeni 
% paralar?n havza s?rt? hesab?ndan önce e?ikli görüntüde morfolojik aç?lma yapmak 
% gerekir.|

clear;
f = im2double(imread('overlapping_euros1.png'));   % Read in image      
figure, imshow(f);       
title('Orijinal Görüntü')

se = strel('disk',13); 
fo = imopen(f,se);             % Arka plan?n temizlenmesi
figure, imshow(fo);       
title('Aç?lm?? Görüntü')

% Smooth the image.
fs = imgaussfilt(fo, 5.55);
figure, imshow(fs)
title('Gauss Filtreli Görüntü')
% fe = edge(fs,'sobel');
% figure, imshow(fe)

% Compute the gradient.
gs = imgradient(fs);
figure, imshow(gs,[]);
title('Gradyent ?iddetinin Görüntüsü')

gsm = imhmin(gs,0.049);
figure, imshow(gsm,[])
title('Bast?r?lm?? Görüntü')
Lsm = watershed(gsm);
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,2) = ridgessm;
figure, imshow(ridgessmrgb)
title('RGB S?rt Görüntüsü')

C = imfuse(f,ridgessmrgb,'blend','Scaling','joint');
figure, imshow(C,[])
title('Üst üste bindirilmi? görüntü')
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
title('RGB S?rt Görüntüsü')

LsmRGB = label2rgb(Lsm,'jet',[0 0 0]);    
figure, 
imshow(LsmRGB,'InitialMagnification','fit') % Display labelled image
title('Watershed')

D = imfuse(f,LsmRGB,'blend','Scaling','joint');
figure, imagesc(D); 
axis image; axis off;  
colormap(hot(18)); colorbar;  
%% ??aretçi-kontrollü havza s?rt? bölütlemesi
clear; 
%% 
% *Step 1.* *Renkli görüntüyü okuma ve Gri ölçe?e dönü?türme.*

rgb = imread('pears.png');
I = im2double(rgb2gray(rgb));      % Mask-1
figure, imshow(rgb)
title('Orijinal renkli görüntü')
figure, imshow(I)    
title('Orijinal gri ölçekli görüntü')
%% 
% *Step 2.* *Temel bölütleme fonksiyonu olarak gradyant ?iddetini hesaplama 
% ve kullanma.*
% 
% |Gradyentin, nesnelerin kenarlar?nda yüksek ve içinde (ço?unlukla) dü?ük de?erler 
% döndürdü?ünü hat?rlay?n.|

gmag = imgradient(I);
figure, imshow(gmag,[])
title('Gradient Magnitude')
%% 
% |Watershed dönü?ümünü do?rudan gradyent ?iddetini kullanarak görüntüyü bölütleyebilir 
% misiniz?|

L = watershed(gmag);
%Lrgb = label2rgb(L);
figure, imshow(L,[])
title('Gradyent ?iddetinin havza s?rt? dönü?ümü')
%% 
% |Sonuçtanda görülebilece?i gibi cevap hay?rd?r. A?a??daki i?aretleyici hesaplamalar? 
% gibi ek ön i?leme ad?mlar? olmadan, do?rudan havza dönü?ümünü kullanmak genellikle 
% "a??r? bölütleme" ile sonuçlan?r.|
% 
% *Step 3. Ön plan nesnelerini i?aretleme.*
% 
% |Ön plan nesnelerinin her birinin içindeki piksel lekelerine (bloblar?na) 
% ba?lanmas? gereken ön plan i?aretçilerini bulmak için çe?itli prosedürler uygulamam?z 
% gerekir. Bu örnekte, görüntüyü "temizlemek" için "yeniden yap?land?rma ile açma-kapama" 
% morfolojik i?lemlerini kullanarak Ön Plan Nesnelerini i?aretleyce?iz.|
% 
% |Açma, geni?lemenin ard?ndan erozyondur. Yeniden yap?lanma ile açma ise erozyon 
% ve ard?ndan morfolojik yeniden yap?land?rmad?r. ?imdi ikisini kar??la?t?ral?m. 
% ?lk olarak, *imopen* kullanarak açmay? hesaplayal?m.|

se = strel('disk',20);
Io = imopen(I,se);       % Gri ölçekli görüntüdeki küçük parlak bölgeleri bast?r?r.
figure, imshow(Io)
title('Opening')
%% 
% |Ard?ndan, *imerode* ve *imreconstruct* kullanarak yeniden yap?land?rma ile 
% açmay? hesaplayal?m.|
% 
% |Morfolojik erezyon ile görüntüdeki yüksek yo?unluklu nesneleri tan?mlayan 
% bir i?aretleyici görüntüsü olu?turulur.| 
% 
% |??aretleyici görüntü ile maske görüntüsü üzerinde yeniden yap?land?rma ile 
% morfolojik açma gerçekle?tirilerek maskedeki yüksek yo?unluklu nesneler tan?mlanabilir.|

Ie = imerode(I, se);             % Marker
Iobr = imreconstruct(Ie, I);     
figure, imshow(Iobr)
title('Yeniden yap?land?rma ile açma sonras?')
%% 
% |Açman?n ard?ndan kapamayla koyu noktalar ve gövde izleri kald?r?labilir. 
% Morfolojik kapama ile yeniden yap?land?rmayla kapamay? kar??la?t?rma. ?lk önce 
% açman?n ard?ndan kapamay? deneyelim.|

Ioc = imclose(Io,se);
figure, imshow(Ioc)
title('Opening-Closing')
%% 
% |?imdi *imdilate (geni?leme)* ve ard?ndan *imreconstruct*'? kullanal?m. *imreconstruct*'da 
% girdinin ve ç?kt?n?n tümleyenini almam?z gerekti?ine dikkat edin.|

Iobrd   = imdilate(Iobr, se);    % max(Iobr)
figure, imshow(imcomplement(Iobrd));   
title('Aç?lm?? görüntünün geni?lemesi')
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr); 
figure, imshow(Iobrcbr);   
title('Yeniden yap?land?rma ile açma-kapama')
%% 
% |_Iobrcbr (yeniden yap?land?rma ile aç?lm?? görüntü)_ ile _Ioc (açman?n ard?ndan 
% kapaman?n görüntüsü)_'u kar??la?t?rarak görebilece?imiz gibi, yeniden yap?land?rmayla 
% açma-kapama, nesnelerin genel ?ekillerini etkilemeden küçük kusurlar? gidermede 
% standart açma ve kapamadan daha etkilidir. Daha iyi ön plan i?aretcileri elde 
% etmek için _Iobrcbr_'nin bölgesel maksimumunu hesaplayal?m.|
% 
% |Bu i?lemi, *imregionalmax* kullan?larak her nesnenin içinde düz maksimum 
% bölgeler olu?turarak yapar?z.|
% 
% |*imregionalmax:* Gri ölçekli _*I*_ görüntüsündeki bölgesel maksimumlar? tan?mlayan 
% ikili bir _BW_ görüntüsü döndürür.|

fgm = imregionalmax(Iobrcbr); % Ön plan i?aretcisi
figure, imshow(fgm);
title('Yeniden yap?land?rma ile açma-kapaman?n bölgesel maksimumlar?')
%% 
% |Sonucu yorumlamak için, bu ön plan i?aretleyici görüntüsü ile orijinal görüntüyü 
% üst üste yerle?tirelim.|
% 
% |B = labeloverlay(A,BW), girdi görüntüsünü _BW_ maskesinin do?ru (1=true) 
% oldu?u bir renkle birle?tirir ve arka plan (0=false etiketli) piksellerini bir 
% renkle birle?tirmez.|

I2 = labeloverlay(I,fgm);
figure, imshow(I2);       
title('Orijinal görüntü üzerine yerle?tirilmi? bölgesel maksimumlar')	
%% 
% |Genel olarak, kapal? ve gölgeli nesnelerin baz?lar?n?n i?aretlenmedi?ine 
% dikkat edin; bu nesneler sonuçta düzgün ?ekilde bölütlenemeyecektir. Ayr?ca, 
% baz? nesnelerdeki ön plan i?aretcileri, nesnelerin kenar?na kadar gider. Bu, 
% i?aretçi lekelerinin kenarlar?n? temizlemeniz ve ard?ndan biraz küçültmeniz 
% gerekti?i anlam?na gelir. Bunu kapama ve ard?ndan erozyonla yapabiliriz.|

se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);  % Küçük karanl?k bölgeleri bast?r?r.
figure, imshow(fgm2);
fgm3 = imerode(fgm2, se2); % min(fgm2)
figure, imshow(fgm3); 
%% 
% |Bu prosedür, kald?r?lmas? gereken baz? ba??bo? izole pikseller b?rakma e?ilimindedir. 
% Bu izole pikselleri, belirli bir say?dan daha az piksele sahip tüm bloblar? 
% kald?ran *bwareaopen*'? kullanarak kald?rabiliriz.|
% 
% |*bwareaopen:*| <https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-BW2 
% |BW2|> |= bwareaopen(|<https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-BW 
% |BW|>|,|<https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-P 
% |P|>|) ikili görüntü _BW_'den _P_ pikselden küçük olan tüm ba?lant?l? bile?enleri 
% (nesneleri) kald?r?r ve bir _BW2_ ikili görüntüsü üretir. Bu operasyon, alan 
% açma olarak bilinir. ?imdi ikili görüntüdeki 20 pikselden küçük bölgeleri temizleyerek 
% yeni bir ikili görüntü olu?turuldu.|

fgm4 = bwareaopen(fgm3, 20);
figure,  imshow(fgm4);
I3 = labeloverlay(I,fgm4);
figure,  imshow(I3);	  
title('Orijinal görüntü üzerine yerle?tirilmi? modifiye bölgesel maksimumlar')
%% 
% |*Step 4:* A*rka plan i?aretcilerini hesaplama.*|
% 
% |Yeniden yap?land?rma ile açma-kapama morfolojik i?lemleri kullanarak temizlenen 
% Ön Plan Nesnelerinin i?aretcileri _Iobrcbr_ görüntüsünde koyu pikseller art?k 
% arka plana aittir. ?imdi buna bir e?ikleme i?lemi yapal?m.|

bw = imbinarize(Iobrcbr);
figure, imshow(bw);
title('E?iklenmi? yeniden yap?land?rma ile açma-kapama görüntüsü')
%% 
% |Arka plan pikselleri siyaht?r, ancak ideal olarak arka plan i?aretçilerinin, 
% bölütlemeye çal??t???m?z nesnelerin kenarlar?na çok yak?n olmas?n? istemeyiz. 
% _bw_'nin ön plan?n?n "etki bölgelerine göre iskeletini" hesaplayarak arka plan? 
% "inceltece?iz". Bu, bw'nin mesafe dönü?ümünün havza dönü?ümü hesaplanmas?n?n 
% ard?ndan sonucun havza s?rt? çizgileri (DL == 0) aranarak yap?labilir.|

D = bwdist(bw);
figure, imshow(D,[]);
DL = watershed(D);	  
bgm = DL == 0;        % ön plan (nesne) piksellerinin s?n?rlar?
figure, imshow(bgm); 
title('Havza s?rt? çizgileri')
%% 
% *Step 5: Temel fonksiyonun havza dönü?ümünü hesaplama.*
% 
% |J = imimposemin(I,BW) morfolojik rekonstrüksiyon kullanarak gri tonlamal? 
% _I_ maske görüntüsünü modifiye eder, _BW_, ikili i?aretleyici görüntünün s?f?r 
% olmad??? her yerde yaln?zca bölgesel minimuma sahiptir.|
% 
% |*?mimposemin* fonksiyonu, bir görüntüyü yaln?zca istenen belirli konumlarda 
% bölgesel minimumlara sahip olacak ?ekilde de?i?tirmek için kullan?l?r. Bölgesel 
% minimumun sadece ön plan ve arka plan i?aretçi piksellerinin olu?tu?u yerlerde 
% gradyant ?iddeti görüntüsünü modifiye etmekte kullanabilir.|

gmag2 = imimposemin(gmag, bgm | fgm4);
figure, imshow(gmag2);
%% 
% |Sonuçta, havza tabanl? bölütlemeyi hesaplamaya haz?r?z.|

L = watershed(gmag2);
%% 
% *Step 6:* *Sonucu görüntüleme.*
% 
% |Bir görselle?tirme tekni?i, ön plan i?aretleyicilerini, arka plan i?aretleyicilerini 
% ve bölütlenmi? nesne s?n?rlar?n? orijinal görüntü üzerine bindirmektir. L == 
% 0 olan yerlerde bulunan nesne s?n?rlar? gibi belirli yönleri daha görünür hale 
% getirmek için geni?leme kullanabiliriz. ?kili ön plan (bgm) ve arka plan (fgm4) 
% i?aretçilerinin, farkl? etiketlere atanmalar? için farkl? tamsay? de?erleriyle 
% ölçekleriz.|

labels = imdilate(L==0, ones(3,3)) + 2*bgm + 3*fgm4;
I4 = labeloverlay(I,labels);
figure, imshow(I4)
title('Orijinal görüntü üzerine bindirilmi? i?aretçiler ve nesne s?n?rlar?')
%% 
% |Bu görselle?tirme, ön plan ve arka plan i?aretçilerinin konumlar?n?n sonucu 
% nas?l etkiledi?ini gösterir. Birkaç yerde, k?smen kapat?lm?? daha koyu nesneler, 
% daha parlak kom?u nesnelerle birle?tirilmi?tir, çünkü kapat?lan nesnelerin ön 
% plan i?aretçileri yoktu.|
% 
% |Bir ba?ka kullan??l? görselle?tirme tekni?i, etiket matrisini renkli bir 
% görüntü olarak görüntülemektir. Watershed ve bwlabel taraf?ndan üretilenler 
% gibi etiket matrisleri, label2rgb kullan?larak görselle?tirme amac?yla gerçek 
% renkli görüntülere dönü?türülebilir.|

Lrgb = label2rgb(L,'jet','w','shuffle');
figure, imshow(Lrgb)
title('Renkli havza s?rt? etiket matrisi')
%% 
% |Bu sahte-renk etiket matrisini orijinal yo?unluk görüntüsünün üzerine bindirmek 
% için saydaml??? kullanabiliriz.|

figure
imshow(I)
hold on
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Orijinal görüntüye saydam bir ?ekilde bindirilmi? renkli etiketler')