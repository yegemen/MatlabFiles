function imfiltGaussian(imagename, option, filtersize, sigma, filtermode)

if(nargin < 2)
    error('en az iki girdi vermek gerekmektedir.')
end

A = imread(imagename); %fonksiyona girdi verilen goruntu okunur.

%switch ile opsiyonu kontrol ediyorum.
switch option
    case('default')
        k = fspecial('gaussian', [7 7], 5);
        B = imfilter(A, k, 'conv');
    case('manual')
        k = [1, 4, 7, 4, 1;
            4, 20, 33, 20, 4;
            7, 33, 55, 33, 7;
            4, 20, 33, 20, 4;
            1, 4, 7, 4, 1];
            A = double(A);
            B = imfilter(A, k, 'conv');
    case('special')
        k = fspecial('gaussian', filtersize, sigma);
        B = imfilter(A, k, filtermode);
end

figure(1)
subplot(1,2,1), imshow(A,[])
title('Original Image')
subplot(1,2,2), imshow(B,[]) 
title('Filtered Image')