
% onemli: soruda verilen pdf.mat dosyasini matlab a surukleyip biraktiktan
% sonra pz adinda bir degisken olustu. bu degiskeni histogram olarak
% kullandim.

% goruntuyu okuyorum
im = imread('lowlight_1.jpg');
% her bir renk duzlemini ayri degiskenlere atiyorum
imR = im(:,:,1);
imG = im(:,:,2);
imB = im(:,:,3);
% her bir renk duzlemi ile pz histogramini eslestiriyorum
imhistR = histeq(imR, pz);
imhistG = histeq(imG, pz);
imhistB = histeq(imB, pz);
% her bir duzleme eslestirilmis duzlemleri atiyorum
im(:,:,1) = imhistR;  
im(:,:,2) = imhistG;  
im(:,:,3) = imhistB;  
% sonucu goruntuluyorum.
imshow(im);