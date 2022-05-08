%% B�l�tleme-2
% Ders 8_2
%% 2D-bwdist fonksiyonu incelemesi
% *bwdist* fonksiyonu, ikili bir g�r�nt�de bir piksel ile en yak?n s?f?rdan 
% farkli piksel arasindaki mesafeyi o piksel de?eri olarak atayarak single tipli 
% bir g�r�nt� d�nd�r�r.

bw = zeros(200,200);
bw(50,50) = 1; bw(50,150) = 1; bw(150,100) = 1;
figure, imshow(bw);
title('Yapay ikili g�r�nt�');    % Mesafe d�n�s�mleri
D1 = bwdist(bw,'euclidean');     % Default
D2 = bwdist(bw,'cityblock');
D3 = bwdist(bw,'chessboard');
D4 = bwdist(bw,'quasi-euclidean');
figure
subplot(221), imshow(D1,[]), title('Euclidean')
subplot(222), imshow(D2,[]), title('City block')
subplot(223), imshow(D3,[]), title('Chessboard')
subplot(224), imshow(D4,[]), title('Quasi-Euclidean')

RGB1 = repmat(rescale(D1,0,1), [1 1 3]); % Renkli g�r�nt�ye d�n�?t�rme 
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
%% ?kili bir g�r�nt�y� b�l�tlemek i�in bwdist ve watershed fonksiyonlar?

clc;clear;
I = imread('overlapdisks.tif');
figure, 
subplot(221), imshow(I,[])
title('Orijinal �ak???k diskler')
D0 = bwdist(I);
subplot(222), imshow(D0,[])
title('bwdist(I) g�r�nt�s�')
subplot(223), imshow(~I,[])
title('Negatif g�r�nt�')
D = bwdist(~I);
subplot(224), imshow(D,[])
title('bwdist(~I) g�r�nt�s�')
% D mesafe g�r�nt�s�n�n negatifini alarak de?erleri �evrelerinden daha d�?�k 
% olan havuzlar elde ediyoruz.
negD = -D;
figure, 
subplot(121), imshow(negD,[])
%% 
% |?imdi Havza s?rt? d�n�?�m� i�in uygun olan bu single tipli g�r�nt�ye watershed 
% fonksiyonu uygulan?r.|

L = watershed(negD);
%% 
% |L etiket matrisindeki de?erler, s?rt �izgileri boyunca s?f?r ve havuz b�lgelerinde 
% pozitif tamsay?lard?r. L'nin s?f?r oldu?u konumlar? bularak havza s?rtlar?n? 
% belirleriz.|

ridges = zeros(size(I));
ridges(L == 0) = 1;
subplot(122), imshow(ridges)
%% 
% |B�l�tlenmi? g�r�nt� ile s?rt �izgisi g�r�nt�s�n� �st �ste g�sterme.|

Iseg = I;
Iseg(ridges == 1) = 0;
figure, imshow(Iseg)
%% 
% |L'de I g�r�nt�s�n�n arka plan? olan noktalardaki etiketleri s?f?r yapar?z 
% ve label2rgb fonksiyonu ile RGB g�r�nt� olarak L etiket matrisini g�r�nt�leriz.|

L(~I) = 0;
rgb = label2rgb(L,'hot(4)','k'); 
figure, imshow(rgb)
%% 
% |T�m arka plan pikselleri havuzun minimumlar?ndan daha k���k yap?larak, havza 
% s?rt? �izgileri sadece iki beyaz b�lge aras?nda de?il, bu b�lgeler ve arka plan 
% aras?nda bir s?n?r �izgisi olu?turacak ?ekilde, nesnede olmayan t�m noktalar 
% ayr? bir havuz olu?turmaya zorlan?r.|

negD(~I) = -Inf; % en y�ksek piksel de?erler nesne s?n?r?r ve havza s?rt �izgisinde bulunan pikseller olur.
figure, imshow(negD,[]); 
title('Arka plan ve nesnenin havuz oldu?u g�r�nt�')
%% 
% ?imdi bu ?ekilde olu?turulan b�l�tleme fonksiyonunun havza s?rt? d�n�?�m�n� 
% alal?m ve etiket matrisinin s?f?r oldu?u yerleri g�r�nt�leyelim.

L = watershed(negD);        % calculate watershed of modified segmentation function
figure, imshow(L==0);
title('Nesne s?n?r? ve havza s?rt? �izgilerinin g�r�nt�s�')
%% 
% G�r�ld�?� gibi elde edilen sonu� g�r�nt� �st �ste binmi? disklerin s?n?r �izgilerini 
% ve havza s?rt? �izgisini i�erir.
%% �zet: ikili bir g�r�nt�y� b�l�tlemek
% |�st �ste binmi? iki diskten olu?an yapay bir ikili g�r�nt� olu?turma|

center1 = -40;                    % Create artificial image.....
center2 = -center1;
dist = sqrt(2*(2*center1)^2);
radius = dist/2 * 1.4;
lims = [floor(center1 - 1.2*radius) ceil(center2 + 1.2*radius)];
[x,y] = meshgrid(lims(1):lims(2));
bw1 = sqrt((x-center1).^2 + (y-center1).^2) <= radius;
bw2 = sqrt((x-center2).^2 + (y-center2).^2) <= radius;
bw  = bw1 | bw2;                  % iki g�r�nt�n�n birle?im b�lgesini olu?turma.
figure,
subplot(121), imshow(bw);         % Display artificial image
%% 
% |?kili g�r�nt�n�n t�mleyeni (~bw) al?narak �klid uzakl?k d�n�?�m� ile temel 
% b�l�tleme fonksiyonunu olu?turulur.|

D = bwdist(~bw);   
subplot(122), imshow(D,[]);        % Display basic segmentation function                                                    		
%% 
% |Temel b�l�tleme fonksiyonunun t�m de?erleri negatif yap?larak ve arka plan 
% pikselleri t�m havuz minimumlar?ndan daha d�?�k de?ere ayarlan?r.|

negD = -D;               % B�l�tleme fonksiyonunu modifiye etme
figure, imshow(negD,[]); % Display modified segmentation image
negD(~bw) = -inf;        % T�m arka plan pikselleri havuzun minimumlar?ndan daha k���k yap?ld?
L = watershed(negD);     % calculate watershed of modified segmentation function
figure, imshow(L==0); 
title('Nesne s?n?r? ve havza s?rt? �izgilerinin g�r�nt�s�')
%% 
% |Son olarak, havza s?rt? d�n�?�m�ne uygun hale getirilen temel b�l�tleme fonksiyonuna 
% havza b�l�tlemesi uygulan?r ve elde edilen etiket matrisi L g�r�nt�lenerek b�l�tlenmi? 
% g�r�nt� elde edilir.|

figure, imagesc(L); 
axis image; axis off;  
colormap(hot(12)); colorbar;        % Display labelled image - colour coded	
%% G�r�nt� gradyant? kullan?larak gri �l�ekli g�r�nt�lerin watershed b�l�tlemesi

clear;
f = im2double(imread('bubbles.tif')); % Gradiyent hesab? i�in double tipli g�r�nt� okunur.
figure, imshow(f)
title('Orijinal gri tonlu g�r�nt�')

Gmag = imgradient(f);
figure, imshow(Gmag,[])
title('Gradyent ?iddeti g�r�nt�s�')

L = watershed(Gmag);
ridges = L == 0;
figure, imshow(ridges)
title('Havza s?rtlar?n?n g�r�nt�s�')

% Smooth the image.
fs = imgaussfilt(f, 0.01*size(f,1));
figure, imshow(fs)
title('D�zg�nle?tirilmi? g�r�nt�')
% Compute the gradient for basic segmentation function.
gs = imgradient(fs);
figure, imshow(gs,[]); 
title('D�zg�nle?tirilmi? g�r�nt�n�n gradyentinin ?iddeti')

Ls = watershed(gs);
ridgess = Ls == 0;
figure, imshow(ridgess)
title('Hazva s?rtlar?n?n g�r�nt�s�')
%% 
% T�m minimumlar? bast?rma.

gsm = imhmin(gs,0.04);
figure, imshow(gsm,[])
title('Ba?t?r?lm?? minimumlar?n g�r�nt�s�')

Lsm = watershed(gsm);
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,1) = ridgessm; % K?rm?z? renkli s?rt �izgileri olu?turma.
figure, imshow(ridgessmrgb)
title('Hazva s?rtlar?n?n g�r�nt�s�')

C = imfuse(f,ridgessmrgb,'blend','Scaling','joint');
figure, imshow(C)
title('�st �ste bindirilmi? g�r�nt�')

LsmRGB = label2rgb(Lsm);
D = imfuse(LsmRGB,ridgessmrgb,'blend','Scaling','joint');
figure, imagesc(D); 
axis image; axis off;  
colormap(hot(18)); %colorbar;  
%exportgraphics(gcf,[filepath,'graywatershed.png'])
%% |Morfolojik i?lem ve Watershed b�l�tlemesi.|
% |Bu �rnekte, havza s?rt? m�kemmel bir segmentasyon sa?lar. �rt�?en madeni 
% paralar?n havza s?rt? hesab?ndan �nce e?ikli g�r�nt�de morfolojik a�?lma yapmak 
% gerekir.|

clear;
f = im2double(imread('overlapping_euros1.png'));   % Read in image      
figure, imshow(f);       
title('Orijinal G�r�nt�')

se = strel('disk',13); 
fo = imopen(f,se);             % Arka plan?n temizlenmesi
figure, imshow(fo);       
title('A�?lm?? G�r�nt�')

% Smooth the image.
fs = imgaussfilt(fo, 5.55);
figure, imshow(fs)
title('Gauss Filtreli G�r�nt�')
% fe = edge(fs,'sobel');
% figure, imshow(fe)

% Compute the gradient.
gs = imgradient(fs);
figure, imshow(gs,[]);
title('Gradyent ?iddetinin G�r�nt�s�')

gsm = imhmin(gs,0.049);
figure, imshow(gsm,[])
title('Bast?r?lm?? G�r�nt�')
Lsm = watershed(gsm);
ridgessm = Lsm == 0;
ridgessmrgb = zeros(size(ridgessm,1), size(ridgessm,2),3);
ridgessmrgb(:,:,2) = ridgessm;
figure, imshow(ridgessmrgb)
title('RGB S?rt G�r�nt�s�')

C = imfuse(f,ridgessmrgb,'blend','Scaling','joint');
figure, imshow(C,[])
title('�st �ste bindirilmi? g�r�nt�')
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
title('RGB S?rt G�r�nt�s�')

LsmRGB = label2rgb(Lsm,'jet',[0 0 0]);    
figure, 
imshow(LsmRGB,'InitialMagnification','fit') % Display labelled image
title('Watershed')

D = imfuse(f,LsmRGB,'blend','Scaling','joint');
figure, imagesc(D); 
axis image; axis off;  
colormap(hot(18)); colorbar;  
%% ??aret�i-kontroll� havza s?rt? b�l�tlemesi
clear; 
%% 
% *Step 1.* *Renkli g�r�nt�y� okuma ve Gri �l�e?e d�n�?t�rme.*

rgb = imread('pears.png');
I = im2double(rgb2gray(rgb));      % Mask-1
figure, imshow(rgb)
title('Orijinal renkli g�r�nt�')
figure, imshow(I)    
title('Orijinal gri �l�ekli g�r�nt�')
%% 
% *Step 2.* *Temel b�l�tleme fonksiyonu olarak gradyant ?iddetini hesaplama 
% ve kullanma.*
% 
% |Gradyentin, nesnelerin kenarlar?nda y�ksek ve i�inde (�o?unlukla) d�?�k de?erler 
% d�nd�rd�?�n� hat?rlay?n.|

gmag = imgradient(I);
figure, imshow(gmag,[])
title('Gradient Magnitude')
%% 
% |Watershed d�n�?�m�n� do?rudan gradyent ?iddetini kullanarak g�r�nt�y� b�l�tleyebilir 
% misiniz?|

L = watershed(gmag);
%Lrgb = label2rgb(L);
figure, imshow(L,[])
title('Gradyent ?iddetinin havza s?rt? d�n�?�m�')
%% 
% |Sonu�tanda g�r�lebilece?i gibi cevap hay?rd?r. A?a??daki i?aretleyici hesaplamalar? 
% gibi ek �n i?leme ad?mlar? olmadan, do?rudan havza d�n�?�m�n� kullanmak genellikle 
% "a??r? b�l�tleme" ile sonu�lan?r.|
% 
% *Step 3. �n plan nesnelerini i?aretleme.*
% 
% |�n plan nesnelerinin her birinin i�indeki piksel lekelerine (bloblar?na) 
% ba?lanmas? gereken �n plan i?aret�ilerini bulmak i�in �e?itli prosed�rler uygulamam?z 
% gerekir. Bu �rnekte, g�r�nt�y� "temizlemek" i�in "yeniden yap?land?rma ile a�ma-kapama" 
% morfolojik i?lemlerini kullanarak �n Plan Nesnelerini i?aretleyce?iz.|
% 
% |A�ma, geni?lemenin ard?ndan erozyondur. Yeniden yap?lanma ile a�ma ise erozyon 
% ve ard?ndan morfolojik yeniden yap?land?rmad?r. ?imdi ikisini kar??la?t?ral?m. 
% ?lk olarak, *imopen* kullanarak a�may? hesaplayal?m.|

se = strel('disk',20);
Io = imopen(I,se);       % Gri �l�ekli g�r�nt�deki k���k parlak b�lgeleri bast?r?r.
figure, imshow(Io)
title('Opening')
%% 
% |Ard?ndan, *imerode* ve *imreconstruct* kullanarak yeniden yap?land?rma ile 
% a�may? hesaplayal?m.|
% 
% |Morfolojik erezyon ile g�r�nt�deki y�ksek yo?unluklu nesneleri tan?mlayan 
% bir i?aretleyici g�r�nt�s� olu?turulur.| 
% 
% |??aretleyici g�r�nt� ile maske g�r�nt�s� �zerinde yeniden yap?land?rma ile 
% morfolojik a�ma ger�ekle?tirilerek maskedeki y�ksek yo?unluklu nesneler tan?mlanabilir.|

Ie = imerode(I, se);             % Marker
Iobr = imreconstruct(Ie, I);     
figure, imshow(Iobr)
title('Yeniden yap?land?rma ile a�ma sonras?')
%% 
% |A�man?n ard?ndan kapamayla koyu noktalar ve g�vde izleri kald?r?labilir. 
% Morfolojik kapama ile yeniden yap?land?rmayla kapamay? kar??la?t?rma. ?lk �nce 
% a�man?n ard?ndan kapamay? deneyelim.|

Ioc = imclose(Io,se);
figure, imshow(Ioc)
title('Opening-Closing')
%% 
% |?imdi *imdilate (geni?leme)* ve ard?ndan *imreconstruct*'? kullanal?m. *imreconstruct*'da 
% girdinin ve �?kt?n?n t�mleyenini almam?z gerekti?ine dikkat edin.|

Iobrd   = imdilate(Iobr, se);    % max(Iobr)
figure, imshow(imcomplement(Iobrd));   
title('A�?lm?? g�r�nt�n�n geni?lemesi')
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr); 
figure, imshow(Iobrcbr);   
title('Yeniden yap?land?rma ile a�ma-kapama')
%% 
% |_Iobrcbr (yeniden yap?land?rma ile a�?lm?? g�r�nt�)_ ile _Ioc (a�man?n ard?ndan 
% kapaman?n g�r�nt�s�)_'u kar??la?t?rarak g�rebilece?imiz gibi, yeniden yap?land?rmayla 
% a�ma-kapama, nesnelerin genel ?ekillerini etkilemeden k���k kusurlar? gidermede 
% standart a�ma ve kapamadan daha etkilidir. Daha iyi �n plan i?aretcileri elde 
% etmek i�in _Iobrcbr_'nin b�lgesel maksimumunu hesaplayal?m.|
% 
% |Bu i?lemi, *imregionalmax* kullan?larak her nesnenin i�inde d�z maksimum 
% b�lgeler olu?turarak yapar?z.|
% 
% |*imregionalmax:* Gri �l�ekli _*I*_ g�r�nt�s�ndeki b�lgesel maksimumlar? tan?mlayan 
% ikili bir _BW_ g�r�nt�s� d�nd�r�r.|

fgm = imregionalmax(Iobrcbr); % �n plan i?aretcisi
figure, imshow(fgm);
title('Yeniden yap?land?rma ile a�ma-kapaman?n b�lgesel maksimumlar?')
%% 
% |Sonucu yorumlamak i�in, bu �n plan i?aretleyici g�r�nt�s� ile orijinal g�r�nt�y� 
% �st �ste yerle?tirelim.|
% 
% |B = labeloverlay(A,BW), girdi g�r�nt�s�n� _BW_ maskesinin do?ru (1=true) 
% oldu?u bir renkle birle?tirir ve arka plan (0=false etiketli) piksellerini bir 
% renkle birle?tirmez.|

I2 = labeloverlay(I,fgm);
figure, imshow(I2);       
title('Orijinal g�r�nt� �zerine yerle?tirilmi? b�lgesel maksimumlar')	
%% 
% |Genel olarak, kapal? ve g�lgeli nesnelerin baz?lar?n?n i?aretlenmedi?ine 
% dikkat edin; bu nesneler sonu�ta d�zg�n ?ekilde b�l�tlenemeyecektir. Ayr?ca, 
% baz? nesnelerdeki �n plan i?aretcileri, nesnelerin kenar?na kadar gider. Bu, 
% i?aret�i lekelerinin kenarlar?n? temizlemeniz ve ard?ndan biraz k���ltmeniz 
% gerekti?i anlam?na gelir. Bunu kapama ve ard?ndan erozyonla yapabiliriz.|

se2 = strel(ones(5,5));
fgm2 = imclose(fgm, se2);  % K���k karanl?k b�lgeleri bast?r?r.
figure, imshow(fgm2);
fgm3 = imerode(fgm2, se2); % min(fgm2)
figure, imshow(fgm3); 
%% 
% |Bu prosed�r, kald?r?lmas? gereken baz? ba??bo? izole pikseller b?rakma e?ilimindedir. 
% Bu izole pikselleri, belirli bir say?dan daha az piksele sahip t�m bloblar? 
% kald?ran *bwareaopen*'? kullanarak kald?rabiliriz.|
% 
% |*bwareaopen:*| <https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-BW2 
% |BW2|> |= bwareaopen(|<https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-BW 
% |BW|>|,|<https://localhost:31515/static/help/images/ref/bwareaopen.html?snc=A63YUK&searchsource=mw&container=jshelpbrowser#buwet8w-1-P 
% |P|>|) ikili g�r�nt� _BW_'den _P_ pikselden k���k olan t�m ba?lant?l? bile?enleri 
% (nesneleri) kald?r?r ve bir _BW2_ ikili g�r�nt�s� �retir. Bu operasyon, alan 
% a�ma olarak bilinir. ?imdi ikili g�r�nt�deki 20 pikselden k���k b�lgeleri temizleyerek 
% yeni bir ikili g�r�nt� olu?turuldu.|

fgm4 = bwareaopen(fgm3, 20);
figure,  imshow(fgm4);
I3 = labeloverlay(I,fgm4);
figure,  imshow(I3);	  
title('Orijinal g�r�nt� �zerine yerle?tirilmi? modifiye b�lgesel maksimumlar')
%% 
% |*Step 4:* A*rka plan i?aretcilerini hesaplama.*|
% 
% |Yeniden yap?land?rma ile a�ma-kapama morfolojik i?lemleri kullanarak temizlenen 
% �n Plan Nesnelerinin i?aretcileri _Iobrcbr_ g�r�nt�s�nde koyu pikseller art?k 
% arka plana aittir. ?imdi buna bir e?ikleme i?lemi yapal?m.|

bw = imbinarize(Iobrcbr);
figure, imshow(bw);
title('E?iklenmi? yeniden yap?land?rma ile a�ma-kapama g�r�nt�s�')
%% 
% |Arka plan pikselleri siyaht?r, ancak ideal olarak arka plan i?aret�ilerinin, 
% b�l�tlemeye �al??t???m?z nesnelerin kenarlar?na �ok yak?n olmas?n? istemeyiz. 
% _bw_'nin �n plan?n?n "etki b�lgelerine g�re iskeletini" hesaplayarak arka plan? 
% "inceltece?iz". Bu, bw'nin mesafe d�n�?�m�n�n havza d�n�?�m� hesaplanmas?n?n 
% ard?ndan sonucun havza s?rt? �izgileri (DL == 0) aranarak yap?labilir.|

D = bwdist(bw);
figure, imshow(D,[]);
DL = watershed(D);	  
bgm = DL == 0;        % �n plan (nesne) piksellerinin s?n?rlar?
figure, imshow(bgm); 
title('Havza s?rt? �izgileri')
%% 
% *Step 5: Temel fonksiyonun havza d�n�?�m�n� hesaplama.*
% 
% |J = imimposemin(I,BW) morfolojik rekonstr�ksiyon kullanarak gri tonlamal? 
% _I_ maske g�r�nt�s�n� modifiye eder, _BW_, ikili i?aretleyici g�r�nt�n�n s?f?r 
% olmad??? her yerde yaln?zca b�lgesel minimuma sahiptir.|
% 
% |*?mimposemin* fonksiyonu, bir g�r�nt�y� yaln?zca istenen belirli konumlarda 
% b�lgesel minimumlara sahip olacak ?ekilde de?i?tirmek i�in kullan?l?r. B�lgesel 
% minimumun sadece �n plan ve arka plan i?aret�i piksellerinin olu?tu?u yerlerde 
% gradyant ?iddeti g�r�nt�s�n� modifiye etmekte kullanabilir.|

gmag2 = imimposemin(gmag, bgm | fgm4);
figure, imshow(gmag2);
%% 
% |Sonu�ta, havza tabanl? b�l�tlemeyi hesaplamaya haz?r?z.|

L = watershed(gmag2);
%% 
% *Step 6:* *Sonucu g�r�nt�leme.*
% 
% |Bir g�rselle?tirme tekni?i, �n plan i?aretleyicilerini, arka plan i?aretleyicilerini 
% ve b�l�tlenmi? nesne s?n?rlar?n? orijinal g�r�nt� �zerine bindirmektir. L == 
% 0 olan yerlerde bulunan nesne s?n?rlar? gibi belirli y�nleri daha g�r�n�r hale 
% getirmek i�in geni?leme kullanabiliriz. ?kili �n plan (bgm) ve arka plan (fgm4) 
% i?aret�ilerinin, farkl? etiketlere atanmalar? i�in farkl? tamsay? de?erleriyle 
% �l�ekleriz.|

labels = imdilate(L==0, ones(3,3)) + 2*bgm + 3*fgm4;
I4 = labeloverlay(I,labels);
figure, imshow(I4)
title('Orijinal g�r�nt� �zerine bindirilmi? i?aret�iler ve nesne s?n?rlar?')
%% 
% |Bu g�rselle?tirme, �n plan ve arka plan i?aret�ilerinin konumlar?n?n sonucu 
% nas?l etkiledi?ini g�sterir. Birka� yerde, k?smen kapat?lm?? daha koyu nesneler, 
% daha parlak kom?u nesnelerle birle?tirilmi?tir, ��nk� kapat?lan nesnelerin �n 
% plan i?aret�ileri yoktu.|
% 
% |Bir ba?ka kullan??l? g�rselle?tirme tekni?i, etiket matrisini renkli bir 
% g�r�nt� olarak g�r�nt�lemektir. Watershed ve bwlabel taraf?ndan �retilenler 
% gibi etiket matrisleri, label2rgb kullan?larak g�rselle?tirme amac?yla ger�ek 
% renkli g�r�nt�lere d�n�?t�r�lebilir.|

Lrgb = label2rgb(L,'jet','w','shuffle');
figure, imshow(Lrgb)
title('Renkli havza s?rt? etiket matrisi')
%% 
% |Bu sahte-renk etiket matrisini orijinal yo?unluk g�r�nt�s�n�n �zerine bindirmek 
% i�in saydaml??? kullanabiliriz.|

figure
imshow(I)
hold on
himage = imshow(Lrgb);
himage.AlphaData = 0.3;
title('Orijinal g�r�nt�ye saydam bir ?ekilde bindirilmi? renkli etiketler')