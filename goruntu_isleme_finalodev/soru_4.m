im = imread('kibrit.tif'); % resim okunur.
esik = graythresh(im); % esik deger otsu ya gore bulunur.
bw = imbinarize(im,esik); % esikleme yapilir.
subplot(2,4,1), imshow(im);
subplot(2,4,2),imshow(bw);
se = strel('disk',15); % yapilandirma elemani olusturulur.
arkaplan = imopen(bw,se); % morfolojik acma islemi yapilir.
subplot(2,4,3), imshow(arkaplan);
[L, num] = bwlabel(arkaplan); % artan pikseller, baglantili bilesenler.
subplot(2,4,4), imshow(L);
f = msgbox(sprintf('Toplam kibrit sayisi: %d', num)); % sayi ekrana yazdirilir.
