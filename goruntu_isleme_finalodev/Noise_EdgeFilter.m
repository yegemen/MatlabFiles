function Noise_EdgeFilter(imagename)

A = imread(imagename); %fonksiyona girdi verilen goruntu okunur.

k1 = fspecial('gaussian', [5 5], 2); % gausyen filtre
k2 = fspecial('laplacian'); % laplasyen filtre

B = imfilter(A, k1, 'conv'); % filtreler uygulanir.
C = imfilter(A, k2, 'symmetric');

subplot(1,3,1), imshow(A); % sonuclar gosterilir.
subplot(1,3,2), imshow(B);
subplot(1,3,3), imshow(C);