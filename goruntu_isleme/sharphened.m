% Run for  time = sharphened('cameraman.tif',10,3.0)
function time = sharphened(name,N,sigma)
tic;
% 8 Keskin olmayan maske filtresi
Iorig = imread(name);      %Read in image
g = fspecial('gaussian', [N N], sigma); %Generate 5x5 Gaussian kernel
figure('units','normalized','outerposition',[0 0 1 1])
subplot(2,4,1), imshow(Iorig)   %Display Original image
title('Original Image')
Is = imfilter(Iorig, g);  %Create smoothed image by filtering
Ie = imsubtract(Iorig, Is);     %Get difference image
subplot(2,4,2), imshow(Ie)      %Display unsharp difference
title('Kenarlar = Original Image - Smoothed Image')
item = 3;
for k = 0.5:0.5:3
    Iout = Iorig + k*Ie;%Add k*difference image to original.
    subplot(2,4,item), imshow(Iout)                       
    title(['İyileştirilmiş = Original + ' num2str(k) '*Kenarlar'])
item = item +1;
end
time = toc;

end