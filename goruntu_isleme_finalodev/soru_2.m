im = imread('peppers.png');
im = im2double(im);
subplot(1,4,1), imshow(im);
title('Orjinal Görüntü');
h = fspecial('sobel'); %yatay kenar
h2 = transpose(h); %dikey kenar
horizontal = imfilter(im, h, 'replicate');
vertical = imfilter(im, h2, 'replicate');
subplot(1,4,2), imshow(horizontal);
title('Yatay Goruntu');
subplot(1,4,3), imshow(vertical);
title('Dikey Goruntu');
im = im(:,:,1);
h = fspecial('sobel');
PQ = paddedsize(size(im));
F = fft2(double(im), PQ(1), PQ(2));
H = fft2(double(h), PQ(1), PQ(2));
F_fH = H.*F;
ffi = ifft2(F_fH);
ffi = abs(ffi); % ffi mutlak degeri
ffi = ffi(2:size(oku,1) +p 1,2:size(im,2)+1);
% Sonuc
subplot(1,4,4), imshow(ffi,[]);
title('Bilesen Mutlak Degerleri Toplami');